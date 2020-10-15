Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3619E28FA2B
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392297AbgJOUdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392294AbgJOUdK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 16:33:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93804C0613D3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2020 13:33:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so171087ljj.8
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2020 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KlXh5rzDcwhJ0eG7Khk7VZ8Gw+aY5r4xoS2Zvo351jY=;
        b=KkZ4ssUiTctJvOODroIELOqJGrweV67+xSDHTgd2dhFEq+/iOm0IR4I/TGmIzva0qn
         h296f1tHQQh5Iwo8v/mJbVgB5GcsMK/4jnuslyUT6XxG4YipzgEUmcfJO2VLaUWhJBIC
         1AxbwUsM/43Pg7zcebTN2CDzozsEiQAN5u1HNjQltoifBg8moFKhKOX3Jttn+2A9scO3
         Ig/MsDVFHx6bi7LB/9yWJB/awEVeyTkrL241EqILhAk0M9InQ/dfIJMVg2yFVNV9glFk
         vl4GRusE9v++Dj4+Xvep6XLXhshzN7lTcyZuWamQHTR4/6dH2sr9KluTx58fTZWeje80
         oSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KlXh5rzDcwhJ0eG7Khk7VZ8Gw+aY5r4xoS2Zvo351jY=;
        b=RPi4yALkpF1HQP5r9dXxVlp6AE+q3oJJUdACsgj6cdFhW40IzkdaAxhFxWMq7G8U28
         DDzDIZpjzrOJBZqdVrHKwOgnCr2bKwBjSND6+C4KlJ6BG15GTFHfWK+sm0lmKBRVX+gZ
         xRvcc4Bbktv2b+zpyDtqpXnt6IWpodDrVVT/RBcGxRRD1+9Qf1C/fuFc5jEt15eOjQbl
         rLNl4HcSqCpLpDdwc7LbNBgZYtAEx2nKw4VmXGq9YoKyj9Cwg5xyTE98ZW81XgpncJ1Z
         4O9Mj46KXpVVxEZQfLmKz2hAC1iS+/UbS77rQIvPy5cTsM+cQOMsQ6Xu1tlbSCh38VHg
         QWiw==
X-Gm-Message-State: AOAM531iLRKApeQI+Cjuw/7cQ6kGLB5Wh84Z8WjzErY1NIohsBh2BDhS
        YUYF4e5JFtNBnXgWsRFz/3GqJYqoBetEs/CKH50rOA==
X-Google-Smtp-Source: ABdhPJyXC1djtRqQcpQpJNk8DlL1UstJBHC1hopewfptBSJdsB3WRm8+75Zqr+3t/3jIPBy1FB/9bY0U0e9cEIH+DeM=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr186827ljk.160.1602793987466;
 Thu, 15 Oct 2020 13:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com> <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
In-Reply-To: <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 15 Oct 2020 22:32:40 +0200
Message-ID: <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 15, 2020 at 1:24 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 9/30/20 5:53 PM, Jann Horn wrote:
> > On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >> I knew it would be a big ask, but below is kind of the manual page
> >> I was hoping you might write [1] for the seccomp user-space notificati=
on
> >> mechanism. Since you didn't (and because 5.9 adds various new pieces
> >> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
> >> that also will need documenting [2]), I did :-). But of course I may
> >> have made mistakes...
[...]
> >>        3. The supervisor process will receive notification events on t=
he
> >>           listening  file  descriptor.   These  events  are  returned =
as
> >>           structures of type seccomp_notif.  Because this structure  a=
nd
> >>           its  size may evolve over kernel versions, the supervisor mu=
st
> >>           first determine the size of  this  structure  using  the  se=
c=E2=80=90
> >>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  returns=
 a
> >>           structure of type seccomp_notif_sizes.  The  supervisor  all=
o=E2=80=90
> >>           cates a buffer of size seccomp_notif_sizes.seccomp_notif byt=
es
> >>           to receive notification events.   In  addition,the  supervis=
or
> >>           allocates  another  buffer  of  size  seccomp_notif_sizes.se=
c=E2=80=90
> >>           comp_notif_resp  bytes  for  the  response  (a   struct   se=
c=E2=80=90
> >>           comp_notif_resp  structure) that it will provide to the kern=
el
> >>           (and thus the target process).
> >>
> >>        4. The target process then performs its workload, which  includ=
es
> >>           system  calls  that  will be controlled by the seccomp filte=
r.
> >>           Whenever one of these system calls causes the filter to retu=
rn
> >>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does n=
ot
> >>           execute the system call;  instead,  execution  of  the  targ=
et
> >>           process is temporarily blocked inside the kernel and a notif=
i=E2=80=90
> >
> > where "blocked" refers to the interruptible, restartable kind - if the
> > child receives a signal with an SA_RESTART signal handler in the
> > meantime, it'll leave the syscall, go through the signal handler, then
> > restart the syscall again and send the same request to the supervisor
> > again. so the supervisor may see duplicate syscalls.
>
> So, I partially demonstrated what you describe here, for two example
> system calls (epoll_wait() and pause()). But I could not exactly
> demonstrate things as I understand you to be describing them. (So,
> I'm not sure whether I have not understood you correctly, or
> if things are not exactly as you describe them.)
>
> Here's a scenario (A) that I tested:
>
> 1. Target installs seccomp filters for a blocking syscall
>    (epoll_wait() or pause(), both of which should never restart,
>    regardless of SA_RESTART)
> 2. Target installs SIGINT handler with SA_RESTART
> 3. Supervisor is sleeping (i.e., is not blocked in
>    SECCOMP_IOCTL_NOTIF_RECV operation).
> 4. Target makes a blocking system call (epoll_wait() or pause()).
> 5. SIGINT gets delivered to target; handler gets called;
>    ***and syscall gets restarted by the kernel***
>
> That last should never happen, of course, and is a result of the
> combination of both the user-notify filter and the SA_RESTART flag.
> If one or other is not present, then the system call is not
> restarted.
>
> So, as you note below, the UAPI gets broken a little.
>
> However, from your description above I had understood that
> something like the following scenario (B) could occur:
>
> 1. Target installs seccomp filters for a blocking syscall
>    (epoll_wait() or pause(), both of which should never restart,
>    regardless of SA_RESTART)
> 2. Target installs SIGINT handler with SA_RESTART
> 3. Supervisor performs SECCOMP_IOCTL_NOTIF_RECV operation (which
>    blocks).
> 4. Target makes a blocking system call (epoll_wait() or pause()).
> 5. Supervisor gets seccomp user-space notification (i.e.,
>    SECCOMP_IOCTL_NOTIF_RECV ioctl() returns
> 6. SIGINT gets delivered to target; handler gets called;
>    and syscall gets restarted by the kernel
> 7. Supervisor performs another SECCOMP_IOCTL_NOTIF_RECV operation
>    which gets another notification for the restarted system call.
>
> However, I don't observe such behavior. In step 6, the syscall
> does not get restarted by the kernel, but instead returns -1/EINTR.
> Perhaps I have misconstructed my experiment in the second case, or
> perhaps I've misunderstood what you meant, or is it possibly the
> case that things are not quite as you said?

user@vm:~/test/seccomp-notify-interrupt$ cat seccomp-notify-interrupt.c
#define _GNU_SOURCE
#include <stdio.h>
#include <signal.h>
#include <err.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <sched.h>
#include <stddef.h>
#include <limits.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/prctl.h>
#include <linux/seccomp.h>
#include <linux/filter.h>
#include <linux/futex.h>

struct {
  int seccomp_fd;
} *shared;

static void handle_signal(int sig, siginfo_t *info, void *uctx) {
  printf("signal handler invoked\n");
}

int main(void) {
  setbuf(stdout, NULL);

  shared =3D mmap(NULL, 0x1000, PROT_READ|PROT_WRITE,
                MAP_ANONYMOUS|MAP_SHARED, -1, 0);
  if (shared =3D=3D MAP_FAILED)
    err(1, "mmap");
  shared->seccomp_fd =3D -1;

  /* glibc's clone() wrapper doesn't support fork()-style usage */
  pid_t child =3D syscall(__NR_clone, CLONE_FILES|SIGCHLD,
                        NULL, NULL, NULL, 0);
  if (child =3D=3D -1) err(1, "clone");
  if (child =3D=3D 0) {
    /* don't outlive the parent */
    prctl(PR_SET_PDEATHSIG, SIGKILL);
    if (getppid() =3D=3D 1) exit(0);

    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
    struct sock_filter insns[] =3D {
      BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
      BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_pause, 0, 1),
      BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
      BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW)
    };
    struct sock_fprog prog =3D {
      .len =3D sizeof(insns)/sizeof(insns[0]),
      .filter =3D insns
    };
    int seccomp_ret =3D syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
                              SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
    if (seccomp_ret < 0)
      err(1, "install");
    printf("installed seccomp: fd %d\n", seccomp_ret);

    __atomic_store(&shared->seccomp_fd, &seccomp_ret, __ATOMIC_RELEASE);
    int futex_ret =3D syscall(__NR_futex, &shared->seccomp_fd, FUTEX_WAKE,
                            INT_MAX, NULL, NULL, 0);
    printf("woke %d waiters\n", futex_ret);

    struct sigaction act =3D {
      .sa_sigaction =3D handle_signal,
      .sa_flags =3D SA_RESTART|SA_SIGINFO
    };
    if (sigaction(SIGUSR1, &act, NULL))
      err(1, "sigaction");

    pause();
    perror("pause returned");
    exit(0);
  }

  int futex_ret =3D syscall(__NR_futex, &shared->seccomp_fd, FUTEX_WAIT,
                          -1, NULL, NULL, 0);
  if (futex_ret =3D=3D -1 && errno !=3D EAGAIN)
    err(1, "futex wait");
  int fd =3D __atomic_load_n(&shared->seccomp_fd, __ATOMIC_ACQUIRE);
  printf("child installed seccomp fd %d\n", fd);

  sleep(1);
  printf("going to send SIGUSR1...\n");
  kill(child, SIGUSR1);
  sleep(1);

  exit(0);
}
user@vm:~/test/seccomp-notify-interrupt$ gcc -o
seccomp-notify-interrupt seccomp-notify-interrupt.c -Wall
user@vm:~/test/seccomp-notify-interrupt$ strace -f
./seccomp-notify-interrupt >/dev/null
execve("./seccomp-notify-interrupt", ["./seccomp-notify-interrupt"],
0x7ffcb31a0d08 /* 42 vars */) =3D 0
brk(NULL)                               =3D 0x5565864b2000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D89296, ...}) =3D 0
mmap(NULL, 89296, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f7e688e7000
close(3)                                =3D 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D=
 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260A\2\0\0\0\0\0"..=
.,
832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1824496, ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7f7e688e5000
mmap(NULL, 1837056, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f7e6=
8724000
mprotect(0x7f7e68746000, 1658880, PROT_NONE) =3D 0
mmap(0x7f7e68746000, 1343488, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) =3D 0x7f7e68746000
mmap(0x7f7e6888e000, 311296, PROT_READ,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16a000) =3D 0x7f7e6888e000
mmap(0x7f7e688db000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b6000) =3D 0x7f7e688db000
mmap(0x7f7e688e1000, 14336, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f7e688e1000
close(3)                                =3D 0
arch_prctl(ARCH_SET_FS, 0x7f7e688e6500) =3D 0
mprotect(0x7f7e688db000, 16384, PROT_READ) =3D 0
mprotect(0x556585183000, 4096, PROT_READ) =3D 0
mprotect(0x7f7e68924000, 4096, PROT_READ) =3D 0
munmap(0x7f7e688e7000, 89296)           =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
0) =3D 0x7f7e688fc000
clone(child_stack=3DNULL, flags=3DCLONE_FILES|SIGCHLD) =3D 2558
futex(0x7f7e688fc000, FUTEX_WAIT, 4294967295, NULLstrace: Process 2558 atta=
ched
 <unfinished ...>
[pid  2558] prctl(PR_SET_PDEATHSIG, SIGKILL) =3D 0
[pid  2558] getppid()                   =3D 2557
[pid  2558] prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) =3D 0
[pid  2558] seccomp(SECCOMP_SET_MODE_FILTER, 0x8 /*
SECCOMP_FILTER_FLAG_??? */, {len=3D4, filter=3D0x7ffdf7cc9b50}) =3D 3
[pid  2558] write(1, "installed seccomp: fd 3\n", 24) =3D 24
[pid  2558] futex(0x7f7e688fc000, FUTEX_WAKE, 2147483647 <unfinished ...>
[pid  2557] <... futex resumed> )       =3D 0
[pid  2558] <... futex resumed> )       =3D 1
[pid  2558] write(1, "woke 1 waiters\n", 15) =3D 15
[pid  2557] write(1, "child installed seccomp fd 3\n", 29) =3D 29
[pid  2558] rt_sigaction(SIGUSR1, {sa_handler=3D0x556585181215,
sa_mask=3D[], sa_flags=3DSA_RESTORER|SA_RESTART|SA_SIGINFO,
sa_restorer=3D0x7f7e6875b840}, NULL, 8) =3D 0
[pid  2557] nanosleep({tv_sec=3D1, tv_nsec=3D0},  <unfinished ...>
[pid  2558] pause( <unfinished ...>
[pid  2557] <... nanosleep resumed> 0x7ffdf7cc9b10) =3D 0
[pid  2557] write(1, "going to send SIGUSR1...", 24) =3D 24
[pid  2557] write(1, "\n", 1)           =3D 1
[pid  2557] kill(2558, SIGUSR1)         =3D 0
[pid  2557] nanosleep({tv_sec=3D1, tv_nsec=3D0},  <unfinished ...>
[pid  2558] <... pause resumed> )       =3D ? ERESTARTSYS (To be
restarted if SA_RESTART is set)
[pid  2558] --- SIGUSR1 {si_signo=3DSIGUSR1, si_code=3DSI_USER,
si_pid=3D2557, si_uid=3D1000} ---
[pid  2558] write(1, "signal handler invoked", 22) =3D 22
[pid  2558] write(1, "\n", 1)           =3D 1
[pid  2558] rt_sigreturn({mask=3D[]})     =3D 34
[pid  2558] pause( <unfinished ...>
[pid  2557] <... nanosleep resumed> 0x7ffdf7cc9b10) =3D 0
[pid  2557] exit_group(0)               =3D ?
[pid  2557] +++ exited with 0 +++
<... pause resumed>)                    =3D ?
+++ killed by SIGKILL +++
user@vm:~/test/seccomp-notify-interrupt$


[...]
> >>           event  is  available.
> >
> > Maybe we should note here that you can use the multi-fd-polling APIs
> > (select/poll/epoll) instead, and that if the notification goes away
> > before you call SECCOMP_IOCTL_NOTIF_RECV, the ioctl will return
> > -ENOENT instead of blocking, and therefore as long as nobody else
> > reads from the same fd, you can assume that after the fd reports as
> > readable, you can call SECCOMP_IOCTL_NOTIF_RECV once without blocking.
>
> I'd rather not add this info in the overview section, which is
> already longer than I would like. But I did add some details
> in NOTES:
>
> [[
>        The file descriptor returned when seccomp(2) is employed with  the
>        SECCOMP_FILTER_FLAG_NEW_LISTENER   flag  can  be  monitored  using
>        poll(2), epoll(7), and select(2).  When a notification is pending,
>        these  interfaces  indicate  that the file descriptor is readable.
>        Following    such    an    indication,    a    subsequent     SEC=
=E2=80=90
>        COMP_IOCTL_NOTIF_RECV  ioctl(2)  will  not block, returning either
>        information about a notification or else failing  with  the  error
>        EINTR  if  the  target  process has been killed by a signal or its
>        system call has been interrupted by a signal handler.
> ]]
>
> Okay?

Sounds good.

[...]
> >>           bilities to perform the mount operation.
> >>
> >>        8. The supervisor then sends a response to the notification.  T=
he
> >>           information  in  this  response  is used by the kernel to co=
n=E2=80=90
> >>           struct a return value for the target process's system call a=
nd
> >>           provide a value that will be assigned to the errno variable =
of
> >>           the target process.
> >>
> >>           The  response  is  sent  using  the   SECCOMP_IOCTL_NOTIF_RE=
CV
> >>           ioctl(2)   operation,   which  is  used  to  transmit  a  se=
c=E2=80=90
> >>           comp_notif_resp  structure  to  the  kernel.   This  structu=
re
> >>           includes  a  cookie  value that the supervisor obtained in t=
he
> >>           seccomp_notif    structure    returned     by     the     SE=
C=E2=80=90
> >>           COMP_IOCTL_NOTIF_RECV operation.  This cookie value allows t=
he
> >>           kernel to associate the response with the target process.
> >
> > (unless if the target thread entered a signal handler or was killed in
> > the meantime)
>
> Yes, but I think I have this adequately covered in the errors described
> later in the page for SECCOMP_IOCTL_NOTIF_RECV. (I have now added the
> target-process-terminated case to the orror text.)
>
>               ENOENT The blocked system  call  in  the  target  has  been
>                      interrupted  by  a  signal  handler  or  the  target
>                      process has terminated.
>
> Is that sufficient?

Ah, right.

[...]
> >>               ENOENT The  target  process  was killed by a signal as t=
he
> >>                      notification information was being generated.
> >
> > Not just killed, interruption with a signal handler has the same effect=
.
>
> Ah yes! Thanks. I added that as well.
>
> [[
>               ENOENT The target thread was killed  by  a  signal  as  the
>                      notification information was being generated, or the
>                      target's (blocked) system call was interrupted by  a
>                      signal handler.
> ]]
>
> Okay?

Yeah, sounds good.

[...]
> >>               In the above scenario, the risk is that the supervisor m=
ay
> >>               try to access the memory of a process other than the  ta=
r=E2=80=90
> >>               get.   This  race  can be avoided by following the call =
to
> >>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ve=
r=E2=80=90
> >>               ify  that  the  process that generated the notification =
is
> >>               still alive.  (Note that  if  the  target  process  subs=
e=E2=80=90
> >>               quently  terminates, its PID won't be reused because the=
re
> >
> > That's wrong, the PID can be reused, but the /proc/$pid directory is
> > internally not associated with the numeric PID, but, conceptually
> > speaking, with a specific incarnation of the PID, or something like
> > that. (Actually, it is associated with the "struct pid", which is not
> > reused, instead of the numeric PID.)
>
> Thanks. I simplified the last sentence of the paragraph:
>
>               In  the above scenario, the risk is that the supervisor may
>               try to access the memory of a process other than  the  tar=
=E2=80=90
>               get.   This  race  can  be avoided by following the call to
>               open(2) with a  SECCOMP_IOCTL_NOTIF_ID_VALID  operation  to
>               verify  that the process that generated the notification is
>               still alive.  (Note that if the target terminates after the
>               latter  step, a subsequent read(2) from the file descriptor
>               will return 0, indicating end of file.)
>
> I think that's probably enough detail.

Maybe make that "may return 0" instead of "will return 0" - reading
from /proc/$pid/mem can only return 0 in the following cases AFAICS:

1. task->mm was already gone at open() time
2. mm->mm_users has dropped to zero (the mm only has lazytlb users;
   page tables and VMAs are being blown away or have been blown away)
3. the syscall was called with length 0

When a process has gone away, normally mm->mm_users will drop to zero,
but someone else could theoretically still be holding a reference to
the mm (e.g. someone else in the middle of accessing /proc/$pid/mem).
(Such references should normally not be very long-lived though.)

Additionally, in the unlikely case that the OOM killer just chomped
through the page tables of the target process, I think the read will
return -EIO (same error as if the address was simply unmapped) if the
address is within a non-shared mapping. (Maybe that's something procfs
could do better...)

[...]
> >> NOTES
> >>        The file descriptor returned when seccomp(2) is employed with t=
he
> >>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  usi=
ng
> >>        poll(2), epoll(7), and select(2).  When a notification  is  pen=
d=E2=80=90
> >>        ing,  these interfaces indicate that the file descriptor is rea=
d=E2=80=90
> >>        able.
> >
> > We should probably also point out somewhere that, as
> > include/uapi/linux/seccomp.h says:
> >
> >  * Similar precautions should be applied when stacking SECCOMP_RET_USER=
_NOTIF
> >  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on t=
he
> >  * same syscall, the most recently added filter takes precedence. This =
means
> >  * that the new SECCOMP_RET_USER_NOTIF filter can override any
> >  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing =
all
>
> My takeaway from Chritian's comments is that this comment in the kernel
> source is partially wrong, since it is not possible to install multiple
> filters with SECCOMP_RET_USER_NOTIF, right?

Yeah. (Well, AFAICS technically, you can add more filters that return
SECCOMP_RET_USER_NOTIF, but when a filter returns that without having
a notifier fd attached, seccomp blocks the syscall with -ENOSYS; it
won't use the notifier fd attached to a different filter in the
chain.)

> >  * such filtered syscalls to be executed by sending the response
> >  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can eq=
ually
> >  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> >
> > In other words, from a security perspective, you must assume that the
> > target process can bypass any SECCOMP_RET_USER_NOTIF (or
> > SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> > calling seccomp().
>
> Drawing on text from Chrstian's comment in seccomp.h and Kees's mail,
> I added the following in NOTES:
>
>    Design goals; use of SECCOMP_USER_NOTIF_FLAG_CONTINUE
>        The intent of the user-space notification feature is to allow sys=
=E2=80=90
>        tem calls to be performed on behalf of the target.   The  target's
>        system  call should either be handled by the supervisor or allowed
>        to continue normally in the kernel (where standard security  poli=
=E2=80=90
>        cies will be applied).
>
>        Note well: this mechanism must not be used to make security policy
>        decisions about the system call, which would be  inherently  race-
>        prone for reasons described next.
>
>        The  SECCOMP_USER_NOTIF_FLAG_CONTINUE  flag must be used with cau=
=E2=80=90
>        tion.  If set by the supervisor, the  target's  system  call  will
>        continue.   However,  there  is  a time-of-check, time-of-use race
>        here, since an attacker could exploit the interval of  time  where
>        the  target  is  blocked  waiting on the "continue" response to do
>        things such as rewriting the system call arguments.
>
>        Note furthermore that a user-space notifier can be bypassed if the
>        existing  filters  allow  the  use  of  seccomp(2)  or prctl(2) to
>        install a filter that returns an action value with a higher prece=
=E2=80=90
>        dence than SECCOMP_RET_USER_NOTIF (see seccomp(2)).
>
>        It  should  thus  be  absolutely clear that the seccomp user-space
>        notification mechanism can not be used  to  implement  a  security
>        policy!   It  should  only  ever be used in scenarios where a more
>        privileged process supervises the system calls of a lesser  privi=
=E2=80=90
>        leged  target  to get around kernel-enforced security restrictions
>        when the supervisor deems this safe.  In other words, in order  to
>        continue a system call, the supervisor should be sure that another
>        security mechanism or the kernel itself  will  sufficiently  block
>        the  system  call  if  its  arguments  are  rewritten to something
>        unsafe.
>
> Seem okay?

Yeah, sounds good.

[...]
> >>            if (s =3D=3D 0) {
> >>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
> >>                        "returned 0 (EOF)\n");
> >>                exit(EXIT_FAILURE);
> >>            }
> >>
> >>            if (close(procMemFd) =3D=3D -1)
> >>                errExit("close-/proc/PID/mem");
> >
> > We should probably make sure here that the value we read is actually
> > NUL-terminated?
>
> So, I was curious about that point also. But, (why) are we not
> guaranteed that it will be NUL-terminated?

Because it's random memory filled by another process, which we don't
necessarily trust. While seccomp notifiers aren't usable for applying
*extra* security restrictions, the supervisor will still often be more
privileged than the supervised process.

[...]
> >>            /* Discover the sizes of the structures that are used to re=
ceive
> >>               notifications and send notification responses, and alloc=
ate
> >>               buffers of those sizes. */
> >>
> >>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) =3D=3D -1)
> >>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
> >>
> >>            struct seccomp_notif *req =3D malloc(sizes.seccomp_notif);
> >>            if (req =3D=3D NULL)
> >>                errExit("\tS: malloc");
> >>
> >>            struct seccomp_notif_resp *resp =3D malloc(sizes.seccomp_no=
tif_resp);
> >
> > This should probably do something like max(sizes.seccomp_notif_resp,
> > sizeof(struct seccomp_notif_resp)) in case the program was built
> > against new UAPI headers that make struct seccomp_notif_resp big, but
> > is running under an old kernel where that struct is still smaller?
>
> I'm confused. Why? I mean, if the running kernel says that it expects
> a buffer of a certain size, and we allocate a buffer of that size,
> what's the problem?

Because in userspace, we cast the result of malloc() to a "struct
seccomp_notif_resp *". If the kernel tells us that it expects a size
smaller than sizeof(struct seccomp_notif_resp), then we end up with a
pointer to a struct that consists partly of allocated memory, partly
of out-of-bounds memory, which is generally a bad idea - I'm not sure
whether the C standard permits that. And if userspace then e.g.
decides to access some member of that struct that is beyond what the
kernel thinks is the struct size, we get actual OOB memory accesses.
