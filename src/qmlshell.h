#ifndef QMLSHELL_H
#define QMLSHELL_H

#include <QObject>
#include <QThread>

class QMLShell : public QThread
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text NOTIFY textChanged FINAL)
public:
    explicit QMLShell(QObject *parent = nullptr);

    Q_INVOKABLE void buttonPressed(QString inputText);

    QString text() const;

    void run() override;

signals:
    void textChanged();

private:
    QString _backlog;
    std::pair<int,int> fds;
};

#endif // QMLSHELL_H
