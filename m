Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1D27EDFA
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgI3PyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgI3PyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 11:54:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4057C0613D0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 08:54:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so3543452ejb.10
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQHdYKkQrM8LX30vZi0/rOu6WG4XzLb4I7b6B+G2ny8=;
        b=OTtTzSeWb5VLQFjYIaG/eQriaB16hpz9zFOD2+gxEphbpywOyQacybid/S1XwyxyhW
         SCunQoL67BhmztdmBpoYTUyUKJW/6yn+MC7szG36xABvO5B0tD4t/q/bodSpR8P6uLjs
         SV7y1cU7o52IEeTEqF1pA+NXzAeeUaQbHjRIWGyPcdPOSt1jjxhSZjFMU+xxvGyfVVE3
         HAq4OL4oRPYWwaa8YhON0AvsDvnm8Cs16SZrvlrfg09AJVD0lpfjmIJZ0nFGJC1TwD3e
         uLNRscYs69nZQ/neUlpYM/9JcxZt0EHR98CppWCrcE5pRG5YYCqyKKXEORkEag0azSiv
         wGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQHdYKkQrM8LX30vZi0/rOu6WG4XzLb4I7b6B+G2ny8=;
        b=YHtXQ6QF/SiJimPmtphXo5oBYMODWzEvq/rqJr0auIWxsT9LENtj8tzF5Z/QGycf6c
         YGt4coIoilyEiDFUYP9il7KB3PRThJ/DAcEefJEQC7tbfYh3KhcURySNi6HvL9ZYTyCJ
         F4jf4RZMhcm7MHUd5sFhE3vUSfmSdHHNw91qyhCaQPw7uNQa4Hbh0SxmjoYRFkv02HKv
         C84eWjT5PDtzoXfMca/0sWL2IaDF3iJ9khFu1ANPQkX6PxYpQRxQsXZJofXJJySCEH/Q
         H/KL2nELOADUzRkC1GVNbi7Q0XzTiF7mVHJnj1btD2tpBzfxxV/T+hUqqbTZOIoXmlm9
         JedQ==
X-Gm-Message-State: AOAM533mCJiJGj8kJpRwtqZaPdvMR59opExRU/LDAyNOHRWvshLfQK54
        KR7gm04oViFMi6m5lfDJ0g5vMaw1YMiPkETeyt93dQ==
X-Google-Smtp-Source: ABdhPJwqc64JZOY1UMywufnHW50/IfotWvllMQMYcpyOMjIHa9Iz5wsjFDDWM1bt3nqXHk5s9WUDH2BCvcc1C7cIwtI=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr3438831ejb.358.1601481252977;
 Wed, 30 Sep 2020 08:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
In-Reply-To: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 17:53:46 +0200
Message-ID: <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
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

On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> I knew it would be a big ask, but below is kind of the manual page
> I was hoping you might write [1] for the seccomp user-space notification
> mechanism. Since you didn't (and because 5.9 adds various new pieces
> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
> that also will need documenting [2]), I did :-). But of course I may
> have made mistakes...
[...]
> NAME
>        seccomp_user_notif - Seccomp user-space notification mechanism
>
> SYNOPSIS
>        #include <linux/seccomp.h>
>        #include <linux/filter.h>
>        #include <linux/audit.h>
>
>        int seccomp(unsigned int operation, unsigned int flags, void *args=
);

Should the ioctl() calls be listed here, similar to e.g. the SYNOPSIS
of the ioctl_* manpages?

> DESCRIPTION
>        This  page  describes  the user-space notification mechanism pro=
=E2=80=90
>        vided by the Secure Computing (seccomp) facility.  As well as the
>        use   of  the  SECCOMP_FILTER_FLAG_NEW_LISTENER  flag,  the  SEC=
=E2=80=90
>        COMP_RET_USER_NOTIF action value, and the SECCOMP_GET_NOTIF_SIZES
>        operation  described  in  seccomp(2), this mechanism involves the
>        use of a number of related ioctl(2) operations (described below).
>
>    Overview
>        In conventional usage of a seccomp filter, the decision about how
>        to  treat  a particular system call is made by the filter itself.
>        The user-space notification mechanism allows the handling of  the
>        system  call  to  instead  be handed off to a user-space process.
>        The advantages of doing this are that, by contrast with the  sec=
=E2=80=90
>        comp  filter,  which  is  running on a virtual machine inside the
>        kernel, the user-space process has access to information that  is
>        unavailable to the seccomp filter and it can perform actions that
>        can't be performed from the seccomp filter.
>
>        In the discussion that follows, the process  that  has  installed
>        the  seccomp filter is referred to as the target, and the process

Technically, this definition of "target" is a bit inaccurate because:

 - seccomp filters are inherited
 - seccomp filters apply to threads, not processes
 - seccomp filters can be semi-remotely installed via TSYNC

(I assume that in manpages, we should try to go for the "a task is a
thread and a thread group is a process" definition, right?)

Perhaps "the threads on which the seccomp filter is installed are
referred to as the target", or something like that would be better?

>        that is notified by  the  user-space  notification  mechanism  is
>        referred  to  as  the  supervisor.  An overview of the steps per=
=E2=80=90
>        formed by these two processes is as follows:
>
>        1. The target process establishes a seccomp filter in  the  usual
>           manner, but with two differences:
>
>           =C2=B7 The seccomp(2) flags argument includes the flag SECCOMP_=
FIL=E2=80=90
>             TER_FLAG_NEW_LISTENER.  Consequently, the return  value   of
>             the  (successful)  seccomp(2) call is a new "listening" file
>             descriptor that can be used to receive notifications.
>
>           =C2=B7 In cases where it is appropriate, the seccomp filter ret=
urns
>             the  action value SECCOMP_RET_USER_NOTIF.  This return value
>             will trigger a notification event.
>
>        2. In order that the supervisor process can obtain  notifications
>           using  the  listening  file  descriptor, (a duplicate of) that
>           file descriptor must be passed from the target process to  the
>           supervisor process.  One way in which this could be done is by
>           passing the file descriptor over a UNIX domain socket  connec=
=E2=80=90
>           tion between the two processes (using the SCM_RIGHTS ancillary
>           message type described in unix(7)).   Another  possibility  is
>           that  the  supervisor  might  inherit  the file descriptor via
>           fork(2).

With the caveat that if the supervisor inherits the file descriptor
via fork(), that (more or less) implies that the supervisor is subject
to the same filter (although it could bypass the filter using a helper
thread that responds SECCOMP_USER_NOTIF_FLAG_CONTINUE, but I don't
expect any clean software to do that).

>        3. The supervisor process will receive notification events on the
>           listening  file  descriptor.   These  events  are  returned as
>           structures of type seccomp_notif.  Because this structure  and
>           its  size may evolve over kernel versions, the supervisor must
>           first determine the size of  this  structure  using  the  sec=
=E2=80=90
>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  returns a
>           structure of type seccomp_notif_sizes.  The  supervisor  allo=
=E2=80=90
>           cates a buffer of size seccomp_notif_sizes.seccomp_notif bytes
>           to receive notification events.   In  addition,the  supervisor
>           allocates  another  buffer  of  size  seccomp_notif_sizes.sec=
=E2=80=90
>           comp_notif_resp  bytes  for  the  response  (a   struct   sec=
=E2=80=90
>           comp_notif_resp  structure) that it will provide to the kernel
>           (and thus the target process).
>
>        4. The target process then performs its workload, which  includes
>           system  calls  that  will be controlled by the seccomp filter.
>           Whenever one of these system calls causes the filter to return
>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does not
>           execute the system call;  instead,  execution  of  the  target
>           process is temporarily blocked inside the kernel and a notifi=
=E2=80=90

where "blocked" refers to the interruptible, restartable kind - if the
child receives a signal with an SA_RESTART signal handler in the
meantime, it'll leave the syscall, go through the signal handler, then
restart the syscall again and send the same request to the supervisor
again. so the supervisor may see duplicate syscalls.

What's really gross here is that signal(7) promises that some syscalls
like epoll_wait(2) never restart, but seccomp doesn't know about that;
if userspace installs a filter that uses SECCOMP_RET_USER_NOTIF for a
non-restartable syscall, the result is that UAPI gets broken a little
bit. Luckily normal users of seccomp probably won't use
SECCOMP_RET_USER_NOTIF for restartable syscalls, but if someone does
want to do that, we might have to add some "suppress syscall
restarting" flag into the seccomp action value, or something like
that... yuck.

>           cation event is generated on the listening file descriptor.
>
>        5. The supervisor process can now repeatedly monitor the  listen=
=E2=80=90
>           ing   file   descriptor  for  SECCOMP_RET_USER_NOTIF-triggered
>           events.   To  do  this,   the   supervisor   uses   the   SEC=
=E2=80=90
>           COMP_IOCTL_NOTIF_RECV  ioctl(2)  operation to read information
>           about a notification event; this  operation  blocks  until  an

(interruptably - but I guess that maybe doesn't have to be said
explicitly here?)

>           event  is  available.

Maybe we should note here that you can use the multi-fd-polling APIs
(select/poll/epoll) instead, and that if the notification goes away
before you call SECCOMP_IOCTL_NOTIF_RECV, the ioctl will return
-ENOENT instead of blocking, and therefore as long as nobody else
reads from the same fd, you can assume that after the fd reports as
readable, you can call SECCOMP_IOCTL_NOTIF_RECV once without blocking.

Exceeeeept that this part looks broken:

  if (mutex_lock_interruptible(&filter->notify_lock) < 0)
    return EPOLLERR;

which I think means that we can have a race where a signal arrives
while poll() is trying to add itself to the waitqueue of the seccomp
fd, and then we'll get a spurious error condition reported on the fd.
That's a kernel bug, I'd say.

> The  operation returns a seccomp_notif
>           structure containing information about the system call that is
>           being attempted by the target process.
>
>        6. The    seccomp_notif    structure   returned   by   the   SEC=
=E2=80=90
>           COMP_IOCTL_NOTIF_RECV operation includes the same  information
>           (a seccomp_data structure) that was passed to the seccomp fil=
=E2=80=90
>           ter.  This information allows the supervisor to  discover  the
>           system  call number and the arguments for the target process's
>           system call.  In addition, the notification event contains the
>           PID of the target process.

That's a PIDTYPE_PID, which the manpages call a "thread ID".

>           The  information  in  the notification can be used to discover
>           the values of pointer arguments for the target process's  sys=
=E2=80=90
>           tem call.  (This is something that can't be done from within a
>           seccomp filter.)  To do this (and  assuming  it  has  suitable
>           permissions),   the   supervisor   opens   the   corresponding
>           /proc/[pid]/mem file,

... which means that here we might have to get into the weeds of how
actually /proc has invisible directories for every TID, even though
only the ones for PIDs are visible, and therefore you can just open
/proc/[tid]/mem and it'll work fine?

> seeks to the memory location that corre=E2=80=90
>           sponds to one of the pointer arguments whose value is supplied
>           in the notification event, and reads bytes from that location.
>           (The supervisor must be careful to avoid a race condition that
>           can occur when doing this; see the  description  of  the  SEC=
=E2=80=90
>           COMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)  In addi=
=E2=80=90
>           tion, the supervisor can access other system information  that
>           is  visible  in  user space but which is not accessible from a
>           seccomp filter.
>
>           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>           =E2=94=82FIXME                                                =
=E2=94=82
>           =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>           =E2=94=82Suppose we are reading a pathname from /proc/PID/mem =
=E2=94=82
>           =E2=94=82for  a system call such as mkdir(). The pathname can =
=E2=94=82
>           =E2=94=82be an arbitrary length. How do we know how much (how =
=E2=94=82
>           =E2=94=82many pages) to read from /proc/PID/mem?              =
=E2=94=82
>           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

It can't be an arbitrary length. While pathnames *returned* from the
kernel in some places can have different limits, strings supplied as
path arguments *to* the kernel AFAIK always have an upper limit of
PATH_MAX, else you get -ENAMETOOLONG. See getname_flags().

>        7. Having  obtained  information  as  per  the previous step, the
>           supervisor may then choose to perform an action in response to
>           the  target  process's  system call (which, as noted above, is
>           not  executed  when  the  seccomp  filter  returns  the   SEC=
=E2=80=90
>           COMP_RET_USER_NOTIF action value).

(unless SECCOMP_USER_NOTIF_FLAG_CONTINUE is used)

>           One  example  use case here relates to containers.  The target
>           process may be located inside a container where  it  does  not
>           have sufficient capabilities to mount a filesystem in the con=
=E2=80=90
>           tainer's mount namespace.  However, the supervisor  may  be  a
>           more  privileged  process that that does have sufficient capa=
=E2=80=90

nit: s/that that/that/

>           bilities to perform the mount operation.
>
>        8. The supervisor then sends a response to the notification.  The
>           information  in  this  response  is used by the kernel to con=
=E2=80=90
>           struct a return value for the target process's system call and
>           provide a value that will be assigned to the errno variable of
>           the target process.
>
>           The  response  is  sent  using  the   SECCOMP_IOCTL_NOTIF_RECV
>           ioctl(2)   operation,   which  is  used  to  transmit  a  sec=
=E2=80=90
>           comp_notif_resp  structure  to  the  kernel.   This  structure
>           includes  a  cookie  value that the supervisor obtained in the
>           seccomp_notif    structure    returned     by     the     SEC=
=E2=80=90
>           COMP_IOCTL_NOTIF_RECV operation.  This cookie value allows the
>           kernel to associate the response with the target process.

(unless if the target thread entered a signal handler or was killed in
the meantime)

>        9. Once the notification has been sent, the system  call  in  the
>           target  process  unblocks,  returning the information that was
>           provided by the supervisor in the notification response.
>
>        As a variation on the last two steps, the supervisor can  send  a
>        response  that tells the kernel that it should execute the target
>        process's   system   call;   see   the   discussion    of    SEC=
=E2=80=90
>        COMP_USER_NOTIF_FLAG_CONTINUE, below.
>
>    ioctl(2) operations
>        The following ioctl(2) operations are provided to support seccomp
>        user-space notification.  For each of these operations, the first
>        (file  descriptor)  argument  of  ioctl(2)  is the listening file
>        descriptor returned by a call to seccomp(2) with the SECCOMP_FIL=
=E2=80=90
>        TER_FLAG_NEW_LISTENER flag.
>
>        SECCOMP_IOCTL_NOTIF_RECV
>               This operation is used to obtain a user-space notification
>               event.  If no such event is currently pending, the  opera=
=E2=80=90
>               tion  blocks  until  an  event occurs.

Not necessarily; for every time a process entered a signal handler or
was killed while a notification was pending, a call to
SECCOMP_IOCTL_NOTIF_RECV will return -ENOENT.

> The third ioctl(2)
>               argument is a pointer to a structure of the following form
>               which  contains  information about the event.  This struc=
=E2=80=90
>               ture must be zeroed out before the call.
>
>                   struct seccomp_notif {
>                       __u64  id;              /* Cookie */
>                       __u32  pid;             /* PID of target process */

(TID, not PID)

>                       __u32  flags;           /* Currently unused (0) */
>                       struct seccomp_data data;   /* See seccomp(2) */
>                   };
>
>               The fields in this structure are as follows:
>
>               id     This is a cookie for the notification.   Each  such
>                      cookie  is  guaranteed  to be unique for the corre=
=E2=80=90
>                      sponding seccomp  filter.   In  other  words,  this
>                      cookie  is  unique for each notification event from
>                      the target process.

That sentence about "target process" looks wrong to me. The cookies
are unique across notifications from the filter, but there can be
multiple filters per thread, and multiple threads per filter.

> The cookie value has the  fol=E2=80=90
>                      lowing uses:
>
>                      =C2=B7 It     can     be     used    with    the    =
SEC=E2=80=90
>                        COMP_IOCTL_NOTIF_ID_VALID ioctl(2)  operation  to
>                        verify that the target process is still alive.
>
>                      =C2=B7 When  returning  a  notification  response to=
 the
>                        kernel, the supervisor must  include  the  cookie
>                        value in the seccomp_notif_resp structure that is
>                        specified   as   the   argument   of   the   SEC=
=E2=80=90
>                        COMP_IOCTL_NOTIF_SEND operation.
>
>               pid    This  is  the  PID of the target process that trig=
=E2=80=90
>                      gered the notification event.
>
>                      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                      =E2=94=82FIXME                                      =
          =E2=94=82
>                      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>                      =E2=94=82This is a thread ID, rather than a PID, rig=
ht?       =E2=94=82
>                      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

Yeah.

>
>               flags  This is a  bit  mask  of  flags  providing  further
>                      information on the event.  In the current implemen=
=E2=80=90
>                      tation, this field is always zero.
>
>               data   This is a seccomp_data structure containing  infor=
=E2=80=90
>                      mation  about  the  system  call that triggered the
>                      notification.  This is the same structure  that  is
>                      passed  to  the seccomp filter.  See seccomp(2) for
>                      details of this structure.
>
>               On success, this operation returns 0; on  failure,  -1  is
>               returned,  and  errno  is set to indicate the cause of the
>               error.  This operation can fail with the following errors:
>
>               EINVAL (since Linux 5.5)
>                      The seccomp_notif structure that was passed to  the
>                      call contained nonzero fields.
>
>               ENOENT The  target  process  was killed by a signal as the
>                      notification information was being generated.

Not just killed, interruption with a signal handler has the same effect.

>        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>        =E2=94=82FIXME                                                =E2=
=94=82
>        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
>        =E2=94=82From my experiments,  it  appears  that  if  a  SEC=E2=80=
=90 =E2=94=82
>        =E2=94=82COMP_IOCTL_NOTIF_RECV   is  done  after  the  target =E2=
=94=82
>        =E2=94=82process terminates, then the ioctl()  simply  blocks =E2=
=94=82
>        =E2=94=82(rather than returning an error to indicate that the =E2=
=94=82
>        =E2=94=82target process no longer exists).                    =E2=
=94=82
>        =E2=94=82                                                     =E2=
=94=82
>        =E2=94=82I found that surprising, and it required  some  con=E2=80=
=90 =E2=94=82
>        =E2=94=82tortions  in the example program.  It was not possi=E2=80=
=90 =E2=94=82
>        =E2=94=82ble to code my SIGCHLD handler (which reaps the zom=E2=80=
=90 =E2=94=82
>        =E2=94=82bie  when  the  worker/target process terminates) to =E2=
=94=82
>        =E2=94=82simply set a flag checked in the main  handleNotifi=E2=80=
=90 =E2=94=82
>        =E2=94=82cations()  loop,  since  this created an unavoidable =E2=
=94=82
>        =E2=94=82race where the child might terminate  just  after  I =E2=
=94=82
>        =E2=94=82had  checked  the  flag,  but before I blocked (for=E2=80=
=90 =E2=94=82
>        =E2=94=82ever!) in  the  SECCOMP_IOCTL_NOTIF_RECV  operation. =E2=
=94=82
>        =E2=94=82Instead,  I had to code the signal handler to simply =E2=
=94=82
>        =E2=94=82call _exit(2)  in  order  to  terminate  the  parent =E2=
=94=82
>        =E2=94=82process (the supervisor).                            =E2=
=94=82
>        =E2=94=82                                                     =E2=
=94=82
>        =E2=94=82Is  this  expected  behavior?  It seems to me rather =E2=
=94=82
>        =E2=94=82desirable that SECCOMP_IOCTL_NOTIF_RECV should  give =E2=
=94=82
>        =E2=94=82an error if the target process has terminated.       =E2=
=94=82
>        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

You could poll() the fd first. But yeah, it'd probably be a good idea
to change that.

>        SECCOMP_IOCTL_NOTIF_ID_VALID
[...]
>               In the above scenario, the risk is that the supervisor may
>               try to access the memory of a process other than the  tar=
=E2=80=90
>               get.   This  race  can be avoided by following the call to
>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ver=
=E2=80=90
>               ify  that  the  process that generated the notification is
>               still alive.  (Note that  if  the  target  process  subse=
=E2=80=90
>               quently  terminates, its PID won't be reused because there

That's wrong, the PID can be reused, but the /proc/$pid directory is
internally not associated with the numeric PID, but, conceptually
speaking, with a specific incarnation of the PID, or something like
that. (Actually, it is associated with the "struct pid", which is not
reused, instead of the numeric PID.)

>               remains an open reference to the /proc[pid]/mem  file;  in
>               this  case, a subsequent read(2) from the file will return
>               0, indicating end of file.)
>
>               On success (i.e., the notification  ID  is  still  valid),
>               this  operation  returns 0 On failure (i.e., the notifica=
=E2=80=90

nit: s/returns 0/returns 0./

>               tion ID is no longer valid), -1 is returned, and errno  is
>               set to ENOENT.
>
>        SECCOMP_IOCTL_NOTIF_SEND
[...]
>               Two kinds of response are possible:
>
>               =C2=B7 A response to the kernel telling it to execute the  =
tar=E2=80=90
>                 get  process's  system  call.   In  this case, the flags
>                 field includes SECCOMP_USER_NOTIF_FLAG_CONTINUE and  the
>                 error and val fields must be zero.
>
>                 This  kind  of response can be useful in cases where the
>                 supervisor needs to do deeper analysis of  the  target's
>                 system  call  than  is  possible  from  a seccomp filter
>                 (e.g., examining the values of pointer arguments),  and,
>                 having  verified that the system call is acceptable, the
>                 supervisor wants to allow it to proceed.

"allow" sounds as if this is an access control thing, but this
mechanism should usually not be used for access control (unless the
"seccomp" syscall is blocked). Maybe reword as "having decided that
the system call does not require emulation by the supervisor, the
supervisor wants it to execute normally", or something like that?

[...]
>               On success, this operation returns 0; on  failure,  -1  is
>               returned,  and  errno  is set to indicate the cause of the
>               error.  This operation can fail with the following errors:
>
>               EINPROGRESS
>                      A response to this notification  has  already  been
>                      sent.
>
>               EINVAL An invalid value was specified in the flags field.
>
>               EINVAL The       flags      field      contained      SEC=
=E2=80=90
>                      COMP_USER_NOTIF_FLAG_CONTINUE, and the error or val
>                      field was not zero.
>
>               ENOENT The  blocked  system call in the target process has
>                      been interrupted by a signal handler.

(you could also get this if a response has already been sent, instead
of EINPROGRESS - the only difference is whether the target thread has
picked up the response yet)

> NOTES
>        The file descriptor returned when seccomp(2) is employed with the
>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
>        poll(2), epoll(7), and select(2).  When a notification  is  pend=
=E2=80=90
>        ing,  these interfaces indicate that the file descriptor is read=
=E2=80=90
>        able.

We should probably also point out somewhere that, as
include/uapi/linux/seccomp.h says:

 * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOT=
IF
 * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
 * same syscall, the most recently added filter takes precedence. This mean=
s
 * that the new SECCOMP_RET_USER_NOTIF filter can override any
 * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
 * such filtered syscalls to be executed by sending the response
 * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equall=
y
 * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.

In other words, from a security perspective, you must assume that the
target process can bypass any SECCOMP_RET_USER_NOTIF (or
SECCOMP_RET_TRACE) filters unless it is completely prohibited from
calling seccomp(). This should also be noted over in the main
seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.


> EXAMPLES
[...]
>        This  program  can  used  to  demonstrate  various aspects of the

nit: "can be used to demonstrate", or alternatively just "demonstrates"

>        behavior of the seccomp user-space  notification  mechanism.   To
>        help  aid  such demonstrations, the program logs various messages
>        to show the operation of the target process (lines prefixed "T:")
>        and the supervisor (indented lines prefixed "S:").
[...]
>    Program source
[...]
>        #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                                } while (0)

Don't we have err() for this?

>        /* Send the file descriptor 'fd' over the connected UNIX domain so=
cket
>           'sockfd'. Returns 0 on success, or -1 on error. */
>
>        static int
>        sendfd(int sockfd, int fd)
>        {
>            struct msghdr msgh;
>            struct iovec iov;
>            int data;
>            struct cmsghdr *cmsgp;
>
>            /* Allocate a char array of suitable size to hold the ancillar=
y data.
>               However, since this buffer is in reality a 'struct cmsghdr'=
, use a
>               union to ensure that it is suitable aligned. */

nit: suitably

>            union {
>                char   buf[CMSG_SPACE(sizeof(int))];
>                                /* Space large enough to hold an 'int' */
>                struct cmsghdr align;
>            } controlMsg;
>
>            /* The 'msg_name' field can be used to specify the address of =
the
>               destination socket when sending a datagram. However, we do =
not
>               need to use this field because 'sockfd' is a connected sock=
et. */
>
>            msgh.msg_name =3D NULL;
>            msgh.msg_namelen =3D 0;
>
>            /* On Linux, we must transmit at least one byte of real data i=
n
>               order to send ancillary data. We transmit an arbitrary inte=
ger
>               whose value is ignored by recvfd(). */
>
>            msgh.msg_iov =3D &iov;
>            msgh.msg_iovlen =3D 1;
>            iov.iov_base =3D &data;
>            iov.iov_len =3D sizeof(int);
>            data =3D 12345;
>
>            /* Set 'msghdr' fields that describe ancillary data */
>
>            msgh.msg_control =3D controlMsg.buf;
>            msgh.msg_controllen =3D sizeof(controlMsg.buf);
>
>            /* Set up ancillary data describing file descriptor to send */
>
>            cmsgp =3D CMSG_FIRSTHDR(&msgh);
>            cmsgp->cmsg_level =3D SOL_SOCKET;
>            cmsgp->cmsg_type =3D SCM_RIGHTS;
>            cmsgp->cmsg_len =3D CMSG_LEN(sizeof(int));
>            memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
>
>            /* Send real plus ancillary data */
>
>            if (sendmsg(sockfd, &msgh, 0) =3D=3D -1)
>                return -1;
>
>            return 0;
>        }

Instead of using unix domain sockets to send the fd to the parent, I
think you could also use clone3() with flags=3D=3DCLONE_FILES|SIGCHLD,
dup2() the seccomp fd to an fd that was reserved in the parent, call
unshare(CLONE_FILES) in the child after setting up the seccomp fd, and
wake up the parent with something like pthread_cond_signal()? I'm not
sure whether that'd look better or worse in the end though, so maybe
just ignore this comment.

[...]
>        /* Access the memory of the target process in order to discover th=
e
>           pathname that was given to mkdir() */
>
>        static void
>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>                          char *path, size_t len)
>        {
>            char procMemPath[PATH_MAX];
>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req=
->pid);
>
>            int procMemFd =3D open(procMemPath, O_RDONLY);

Should example code like this maybe use O_CLOEXEC unless the fd in
question actually has to be inheritable? I know it doesn't actually
matter here, but if this code was used in a multi-threaded context, it
might.

>            if (procMemFd =3D=3D -1)
>                errExit("Supervisor: open");
>
>            /* Check that the process whose info we are accessing is still=
 alive.
>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>               in checkNotificationIdIsValid()) succeeds, we know that the
>               /proc/PID/mem file descriptor that we opened corresponds to=
 the
>               process for which we received a notification. If that proce=
ss
>               subsequently terminates, then read() on that file descripto=
r
>               will return 0 (EOF). */
>
>            checkNotificationIdIsValid(notifyFd, req->id);
>
>            /* Seek to the location containing the pathname argument (i.e.=
, the
>               first argument) of the mkdir(2) call and read that pathname=
 */
>
>            if (lseek(procMemFd, req->data.args[0], SEEK_SET) =3D=3D -1)
>                errExit("Supervisor: lseek");
>
>            ssize_t s =3D read(procMemFd, path, PATH_MAX);
>            if (s =3D=3D -1)
>                errExit("read");

Why not pread() instead of lseek()+read()?

>            if (s =3D=3D 0) {
>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
>                        "returned 0 (EOF)\n");
>                exit(EXIT_FAILURE);
>            }
>
>            if (close(procMemFd) =3D=3D -1)
>                errExit("close-/proc/PID/mem");

We should probably make sure here that the value we read is actually
NUL-terminated?

>        }
>
>        /* Handle notifications that arrive via the SECCOMP_RET_USER_NOTIF=
 file
>           descriptor, 'notifyFd'. */
>
>        static void
>        handleNotifications(int notifyFd)
>        {
>            struct seccomp_notif_sizes sizes;
>            char path[PATH_MAX];
>                /* For simplicity, we assume that the pathname given to mk=
dir()
>                   is no more than PATH_MAX bytes; but this might not be t=
rue. */

No, it has to be true, otherwise the kernel would fail the syscall if
it was executing normally.

>            /* Discover the sizes of the structures that are used to recei=
ve
>               notifications and send notification responses, and allocate
>               buffers of those sizes. */
>
>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) =3D=3D -1)
>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
>
>            struct seccomp_notif *req =3D malloc(sizes.seccomp_notif);
>            if (req =3D=3D NULL)
>                errExit("\tS: malloc");
>
>            struct seccomp_notif_resp *resp =3D malloc(sizes.seccomp_notif=
_resp);

This should probably do something like max(sizes.seccomp_notif_resp,
sizeof(struct seccomp_notif_resp)) in case the program was built
against new UAPI headers that make struct seccomp_notif_resp big, but
is running under an old kernel where that struct is still smaller?

>            if (resp =3D=3D NULL)
>                errExit("\tS: malloc");
[...]
>                    } else {
>
>                        /* If mkdir() failed in the supervisor, pass the e=
rror
>                           back to the target */
>
>                        resp->error =3D -errno;
>                        printf("\tS: failure! (errno =3D %d; %s)\n", errno=
,
>                                strerror(errno));
>                    }
>                                                             } else if (st=
rncmp(path, "./", strlen("./")) =3D=3D 0) {

nit: indent messed up

>                    resp->error =3D resp->val =3D 0;
>                    resp->flags =3D SECCOMP_USER_NOTIF_FLAG_CONTINUE;
>                    printf("\tS: target can execute system call\n");
[...]
