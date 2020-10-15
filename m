Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6228F153
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgJOLZi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgJOLYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 07:24:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437CC061755;
        Thu, 15 Oct 2020 04:24:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y12so2980747wrp.6;
        Thu, 15 Oct 2020 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+GsbYluG4u73BDHZLeU5QbT5MuUDYp+oqb/QiX1Syl0=;
        b=SLKdxK4xJ3f0UY65WuYDwOPmq8FiXCQsoHFIAEDjY/8fRXghl9pW/mmrLFle8mJ0Ea
         aWzOwGaLTbr05PdcAjHdASzr5w3A3mX1D3vyq4zXPQEistjoQmgPXDQUSwA2OAiyEtwv
         HstV4YdLQU5+/tQRVgJKpiKI23jjUegxDeAS4yVYGG5CgvLcSYVKFHE5GFEym292a5OL
         cwsGfPeWMrGzPsAdMCdjBG1XN+IvtfmJByG8QOpVp/bNrrHHpfDY4AsNbXtXq2luxE6v
         /HiB+9bhXRdNxn0R+wh9kPvNhKzNtvuUHUJ1NxpZKysLmqf8KbSDv7mzhpWu/4XIGpdG
         uVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GsbYluG4u73BDHZLeU5QbT5MuUDYp+oqb/QiX1Syl0=;
        b=AuDixC13eC3NXx58HmDtaL+TE7Dx/omlGL3xqywcT/Y+trCozxqeWABQbMer0pN4uI
         aDruesC7rMmsWLz+OI0v9lTCfSAl8xEjqi4H9vV7JAFWp1MlDZRWiYjy/Y5+O+k3bLaw
         yy++vQ2NmYHmzoQHQw1Gs7HNwEqO2sAjZEoBgkJeohk61UcXO6/ibPIxe8TGgIqnzgyu
         Mxr9nGK4oxLUoiFPJU08jB4aLddDNndlSXZHalaVlxENGi+3Vi1+u/rQO6GgsFSYmgsR
         yO97H+Y98nNC1DrcuQSACFeRawfhxhWDpM/tp+Vzr09o3+tAK9lgk4WF4IpcApmuzZFp
         9gPQ==
X-Gm-Message-State: AOAM530qGaq/0doQXmUa652zKUyDj8vx7gCEcrBw7PL2OYNQioY1J43f
        SSHn54o/POV0jGfHp00CMXU=
X-Google-Smtp-Source: ABdhPJyLzb1oNdIf3dcQDnEybL8jAcn6eVv8vhtqU7+wnrvHk69L6GlDUHCHaX6ML2cLfRBMpXcwIQ==
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr3744783wrx.76.1602761086653;
        Thu, 15 Oct 2020 04:24:46 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id z191sm3999995wme.30.2020.10.15.04.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 04:24:45 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
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
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
Message-ID: <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
Date:   Thu, 15 Oct 2020 13:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jann,

So, first off, thank you for the detailed review. I really 
appreciate it! I've changed various pieces, and still have
a few questions below.

On 9/30/20 5:53 PM, Jann Horn wrote:
> On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> I knew it would be a big ask, but below is kind of the manual page
>> I was hoping you might write [1] for the seccomp user-space notification
>> mechanism. Since you didn't (and because 5.9 adds various new pieces
>> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
>> that also will need documenting [2]), I did :-). But of course I may
>> have made mistakes...
> [...]
>> NAME
>>        seccomp_user_notif - Seccomp user-space notification mechanism
>>
>> SYNOPSIS
>>        #include <linux/seccomp.h>
>>        #include <linux/filter.h>
>>        #include <linux/audit.h>
>>
>>        int seccomp(unsigned int operation, unsigned int flags, void *args);
> 
> Should the ioctl() calls be listed here, similar to e.g. the SYNOPSIS
> of the ioctl_* manpages?

Yes, good idea. I added:

       int ioctl(int fd, SECCOMP_IOCTL_NOTIF_RECV,
                 struct seccomp_notif *req);
       int ioctl(int fd, SECCOMP_IOCTL_NOTIF_SEND,
                 struct seccomp_notif_resp *req);
       int ioctl(int fd, SECCOMP_IOCTL_NOTIF_ID_VALID, __u64 *id);
> 
>> DESCRIPTION
>>        This  page  describes  the user-space notification mechanism pro‐
>>        vided by the Secure Computing (seccomp) facility.  As well as the
>>        use   of  the  SECCOMP_FILTER_FLAG_NEW_LISTENER  flag,  the  SEC‐
>>        COMP_RET_USER_NOTIF action value, and the SECCOMP_GET_NOTIF_SIZES
>>        operation  described  in  seccomp(2), this mechanism involves the
>>        use of a number of related ioctl(2) operations (described below).
>>
>>    Overview
>>        In conventional usage of a seccomp filter, the decision about how
>>        to  treat  a particular system call is made by the filter itself.
>>        The user-space notification mechanism allows the handling of  the
>>        system  call  to  instead  be handed off to a user-space process.
>>        The advantages of doing this are that, by contrast with the  sec‐
>>        comp  filter,  which  is  running on a virtual machine inside the
>>        kernel, the user-space process has access to information that  is
>>        unavailable to the seccomp filter and it can perform actions that
>>        can't be performed from the seccomp filter.
>>
>>        In the discussion that follows, the process  that  has  installed
>>        the  seccomp filter is referred to as the target, and the process
> 
> Technically, this definition of "target" is a bit inaccurate because:
> 
>  - seccomp filters are inherited
>  - seccomp filters apply to threads, not processes
>  - seccomp filters can be semi-remotely installed via TSYNC

(Nice summary.)

> (I assume that in manpages, we should try to go for the "a task is a
> thread and a thread group is a process" definition, right?)

Exactly.

> Perhaps "the threads on which the seccomp filter is installed are
> referred to as the target", or something like that would be better?

Thanks. It's always hugely helpful to get a suggested wording, even
if I still feel the need to rework it (which I don't in this case).
The sentence now reads:

       In the discussion that follows, the thread(s) on which the seccomp
       filter is installed are referred to as the target, and the process
       that is notified  by  the  user-space  notification  mechanism  is
       referred to as the supervisor.

>>        that is notified by  the  user-space  notification  mechanism  is
>>        referred  to  as  the  supervisor.  An overview of the steps per‐
>>        formed by these two processes is as follows:
>>
>>        1. The target process establishes a seccomp filter in  the  usual
>>           manner, but with two differences:
>>
>>           · The seccomp(2) flags argument includes the flag SECCOMP_FIL‐
>>             TER_FLAG_NEW_LISTENER.  Consequently, the return  value   of
>>             the  (successful)  seccomp(2) call is a new "listening" file
>>             descriptor that can be used to receive notifications.
>>
>>           · In cases where it is appropriate, the seccomp filter returns
>>             the  action value SECCOMP_RET_USER_NOTIF.  This return value
>>             will trigger a notification event.
>>
>>        2. In order that the supervisor process can obtain  notifications
>>           using  the  listening  file  descriptor, (a duplicate of) that
>>           file descriptor must be passed from the target process to  the
>>           supervisor process.  One way in which this could be done is by
>>           passing the file descriptor over a UNIX domain socket  connec‐
>>           tion between the two processes (using the SCM_RIGHTS ancillary
>>           message type described in unix(7)).   Another  possibility  is
>>           that  the  supervisor  might  inherit  the file descriptor via
>>           fork(2).
> 
> With the caveat that if the supervisor inherits the file descriptor
> via fork(), that (more or less) implies that the supervisor is subject
> to the same filter (although it could bypass the filter using a helper
> thread that responds SECCOMP_USER_NOTIF_FLAG_CONTINUE, but I don't
> expect any clean software to do that).

It's a good thing no one ever writes unclean software...

Thanks for catching this; Tycho did also. It was a thinko on my part
to forget that if one used fork(), the supervisor would inherit the
filter. I've simply removed the sentence mentioning fork().


>>        3. The supervisor process will receive notification events on the
>>           listening  file  descriptor.   These  events  are  returned as
>>           structures of type seccomp_notif.  Because this structure  and
>>           its  size may evolve over kernel versions, the supervisor must
>>           first determine the size of  this  structure  using  the  sec‐
>>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  returns a
>>           structure of type seccomp_notif_sizes.  The  supervisor  allo‐
>>           cates a buffer of size seccomp_notif_sizes.seccomp_notif bytes
>>           to receive notification events.   In  addition,the  supervisor
>>           allocates  another  buffer  of  size  seccomp_notif_sizes.sec‐
>>           comp_notif_resp  bytes  for  the  response  (a   struct   sec‐
>>           comp_notif_resp  structure) that it will provide to the kernel
>>           (and thus the target process).
>>
>>        4. The target process then performs its workload, which  includes
>>           system  calls  that  will be controlled by the seccomp filter.
>>           Whenever one of these system calls causes the filter to return
>>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does not
>>           execute the system call;  instead,  execution  of  the  target
>>           process is temporarily blocked inside the kernel and a notifi‐
> 
> where "blocked" refers to the interruptible, restartable kind - if the
> child receives a signal with an SA_RESTART signal handler in the
> meantime, it'll leave the syscall, go through the signal handler, then
> restart the syscall again and send the same request to the supervisor
> again. so the supervisor may see duplicate syscalls.

So, I partially demonstrated what you describe here, for two example
system calls (epoll_wait() and pause()). But I could not exactly 
demonstrate things as I understand you to be describing them. (So,
I'm not sure whether I have not understood you correctly, or
if things are not exactly as you describe them.)

Here's a scenario (A) that I tested:

1. Target installs seccomp filters for a blocking syscall
   (epoll_wait() or pause(), both of which should never restart,
   regardless of SA_RESTART)
2. Target installs SIGINT handler with SA_RESTART
3. Supervisor is sleeping (i.e., is not blocked in
   SECCOMP_IOCTL_NOTIF_RECV operation).
4. Target makes a blocking system call (epoll_wait() or pause()).
5. SIGINT gets delivered to target; handler gets called;
   ***and syscall gets restarted by the kernel***

That last should never happen, of course, and is a result of the
combination of both the user-notify filter and the SA_RESTART flag.
If one or other is not present, then the system call is not
restarted.

So, as you note below, the UAPI gets broken a little.

However, from your description above I had understood that 
something like the following scenario (B) could occur:

1. Target installs seccomp filters for a blocking syscall
   (epoll_wait() or pause(), both of which should never restart,
   regardless of SA_RESTART)
2. Target installs SIGINT handler with SA_RESTART
3. Supervisor performs SECCOMP_IOCTL_NOTIF_RECV operation (which
   blocks).
4. Target makes a blocking system call (epoll_wait() or pause()).
5. Supervisor gets seccomp user-space notification (i.e.,
   SECCOMP_IOCTL_NOTIF_RECV ioctl() returns
6. SIGINT gets delivered to target; handler gets called;
   and syscall gets restarted by the kernel
7. Supervisor performs another SECCOMP_IOCTL_NOTIF_RECV operation
   which gets another notification for the restarted system call.

However, I don't observe such behavior. In step 6, the syscall
does not get restarted by the kernel, but instead returns -1/EINTR.
Perhaps I have misconstructed my experiment in the second case, or
perhaps I've misunderstood what you meant, or is it possibly the
case that things are not quite as you said?

> What's really gross here is that signal(7) promises that some syscalls
> like epoll_wait(2) never restart, but seccomp doesn't know about that;
> if userspace installs a filter that uses SECCOMP_RET_USER_NOTIF for a
> non-restartable syscall, the result is that UAPI gets broken a little
> bit. Luckily normal users of seccomp probably won't use
> SECCOMP_RET_USER_NOTIF for restartable syscalls, but if someone does
> want to do that, we might have to add some "suppress syscall
> restarting" flag into the seccomp action value, or something like
> that... yuck.

Yes, the UAPI breakage is a bit sad (although, likely to be rarely
encountered, as you note). I'm inclined to add a note about this in
in BUGS, but beforehand I'm interested in hearing your thoughts on
scenario B above.

>>           cation event is generated on the listening file descriptor.
>>
>>        5. The supervisor process can now repeatedly monitor the  listen‐
>>           ing   file   descriptor  for  SECCOMP_RET_USER_NOTIF-triggered
>>           events.   To  do  this,   the   supervisor   uses   the   SEC‐
>>           COMP_IOCTL_NOTIF_RECV  ioctl(2)  operation to read information
>>           about a notification event; this  operation  blocks  until  an
> 
> (interruptably - but I guess that maybe doesn't have to be said
> explicitly here?)

Yes, I think so. The general assumption is that syscalls block
interruptibly, unless text in a manual page that says
"uninterruptible". (Postscript: Christian made a similar comment,
so I decided to explicitly note that it's an interruptible sleep.)

>>           event  is  available.
> 
> Maybe we should note here that you can use the multi-fd-polling APIs
> (select/poll/epoll) instead, and that if the notification goes away
> before you call SECCOMP_IOCTL_NOTIF_RECV, the ioctl will return
> -ENOENT instead of blocking, and therefore as long as nobody else
> reads from the same fd, you can assume that after the fd reports as
> readable, you can call SECCOMP_IOCTL_NOTIF_RECV once without blocking.

I'd rather not add this info in the overview section, which is
already longer than I would like. But I did add some details
in NOTES:

[[
       The file descriptor returned when seccomp(2) is employed with  the
       SECCOMP_FILTER_FLAG_NEW_LISTENER   flag  can  be  monitored  using
       poll(2), epoll(7), and select(2).  When a notification is pending,
       these  interfaces  indicate  that the file descriptor is readable.
       Following    such    an    indication,    a    subsequent     SEC‐
       COMP_IOCTL_NOTIF_RECV  ioctl(2)  will  not block, returning either
       information about a notification or else failing  with  the  error
       EINTR  if  the  target  process has been killed by a signal or its
       system call has been interrupted by a signal handler.
]]

Okay?

> Exceeeeept that this part looks broken:
> 
>   if (mutex_lock_interruptible(&filter->notify_lock) < 0)
>     return EPOLLERR;
> 
> which I think means that we can have a race where a signal arrives
> while poll() is trying to add itself to the waitqueue of the seccomp
> fd, and then we'll get a spurious error condition reported on the fd.
> That's a kernel bug, I'd say.

Sigh... Writing documentation helps find bugs. Who knew?

>> The  operation returns a seccomp_notif
>>           structure containing information about the system call that is
>>           being attempted by the target process.
>>
>>        6. The    seccomp_notif    structure   returned   by   the   SEC‐
>>           COMP_IOCTL_NOTIF_RECV operation includes the same  information
>>           (a seccomp_data structure) that was passed to the seccomp fil‐
>>           ter.  This information allows the supervisor to  discover  the
>>           system  call number and the arguments for the target process's
>>           system call.  In addition, the notification event contains the
>>           PID of the target process.
> 
> That's a PIDTYPE_PID, which the manpages call a "thread ID".

Yes. Fixed now. More generally, I've swept through the page replacing
various instances of "target process" with either "target thread", or
often just "target".

>>           The  information  in  the notification can be used to discover
>>           the values of pointer arguments for the target process's  sys‐
>>           tem call.  (This is something that can't be done from within a
>>           seccomp filter.)  To do this (and  assuming  it  has  suitable
>>           permissions),   the   supervisor   opens   the   corresponding
>>           /proc/[pid]/mem file,
> 
> ... which means that here we might have to get into the weeds of how
> actually /proc has invisible directories for every TID, even though
> only the ones for PIDs are visible, and therefore you can just open
> /proc/[tid]/mem and it'll work fine?

I myself was unaware of this for years until I *accidentally* made use
of the feature in one of my test programs and then a while later got to
asking myself "how come that worked?".

About two years ago, I added some text (@) to explain this in proc(5)
near the start of the page:

   Overview
       Underneath /proc, there are the following general groups of  files
       and subdirectories:

       /proc/[pid] subdirectories
              [...]
              Underneath each of the /proc/[pid] directories, a task sub‐
              directory contains subdirectories of the  form  task/[tid],
              [...]

              The  /proc/[pid]  subdirectories are visible when iterating
              through /proc with getdents(2) (and thus are  visible  when
              one uses ls(1) to view the contents of /proc).

       /proc/[tid] subdirectories
@             Each  one of these subdirectories contains files and subdi‐
@             rectories exposing information about the  thread  with  the
@             corresponding thread ID.  The contents of these directories
@             are the same as  the  corresponding  /proc/[pid]/task/[tid]
@             directories.

@             The /proc/[tid] subdirectories are not visible when iterat‐
@             ing through /proc with getdents(2) (and thus are not  visi‐
@             ble when one uses ls(1) to view the contents of /proc).

I think I'll just drop a cross reference to proc(5) into the text in
seccomp_user_notif.

>> seeks to the memory location that corre‐
>>           sponds to one of the pointer arguments whose value is supplied
>>           in the notification event, and reads bytes from that location.
>>           (The supervisor must be careful to avoid a race condition that
>>           can occur when doing this; see the  description  of  the  SEC‐
>>           COMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)  In addi‐
>>           tion, the supervisor can access other system information  that
>>           is  visible  in  user space but which is not accessible from a
>>           seccomp filter.
>>
>>           ┌─────────────────────────────────────────────────────┐
>>           │FIXME                                                │
>>           ├─────────────────────────────────────────────────────┤
>>           │Suppose we are reading a pathname from /proc/PID/mem │
>>           │for  a system call such as mkdir(). The pathname can │
>>           │be an arbitrary length. How do we know how much (how │
>>           │many pages) to read from /proc/PID/mem?              │
>>           └─────────────────────────────────────────────────────┘
> 
> It can't be an arbitrary length. While pathnames *returned* from the
> kernel in some places can have different limits, strings supplied as
> path arguments *to* the kernel AFAIK always have an upper limit of
> PATH_MAX, else you get -ENAMETOOLONG. See getname_flags().

Yes, another thinko on my part. I removed this FIXME.

>>        7. Having  obtained  information  as  per  the previous step, the
>>           supervisor may then choose to perform an action in response to
>>           the  target  process's  system call (which, as noted above, is
>>           not  executed  when  the  seccomp  filter  returns  the   SEC‐
>>           COMP_RET_USER_NOTIF action value).
> 
> (unless SECCOMP_USER_NOTIF_FLAG_CONTINUE is used)

As you probably saw, I give SECCOMP_USER_NOTIF_FLAG_CONTINUE a brief 
mention a couple of paragraphs later, and then go into rather more
detail later in the page. (Or do you still think something needs
fixing?)

>>           One  example  use case here relates to containers.  The target
>>           process may be located inside a container where  it  does  not
>>           have sufficient capabilities to mount a filesystem in the con‐
>>           tainer's mount namespace.  However, the supervisor  may  be  a
>>           more  privileged  process that that does have sufficient capa‐
> 
> nit: s/that that/that/

Thanks. Fixed.

>>           bilities to perform the mount operation.
>>
>>        8. The supervisor then sends a response to the notification.  The
>>           information  in  this  response  is used by the kernel to con‐
>>           struct a return value for the target process's system call and
>>           provide a value that will be assigned to the errno variable of
>>           the target process.
>>
>>           The  response  is  sent  using  the   SECCOMP_IOCTL_NOTIF_RECV
>>           ioctl(2)   operation,   which  is  used  to  transmit  a  sec‐
>>           comp_notif_resp  structure  to  the  kernel.   This  structure
>>           includes  a  cookie  value that the supervisor obtained in the
>>           seccomp_notif    structure    returned     by     the     SEC‐
>>           COMP_IOCTL_NOTIF_RECV operation.  This cookie value allows the
>>           kernel to associate the response with the target process.
> 
> (unless if the target thread entered a signal handler or was killed in
> the meantime)

Yes, but I think I have this adequately covered in the errors described
later in the page for SECCOMP_IOCTL_NOTIF_RECV. (I have now added the
target-process-terminated case to the orror text.)

              ENOENT The blocked system  call  in  the  target  has  been
                     interrupted  by  a  signal  handler  or  the  target
                     process has terminated.

Is that sufficient?

>>        9. Once the notification has been sent, the system  call  in  the
>>           target  process  unblocks,  returning the information that was
>>           provided by the supervisor in the notification response.
>>
>>        As a variation on the last two steps, the supervisor can  send  a
>>        response  that tells the kernel that it should execute the target
>>        process's   system   call;   see   the   discussion    of    SEC‐
>>        COMP_USER_NOTIF_FLAG_CONTINUE, below.
>>
>>    ioctl(2) operations
>>        The following ioctl(2) operations are provided to support seccomp
>>        user-space notification.  For each of these operations, the first
>>        (file  descriptor)  argument  of  ioctl(2)  is the listening file
>>        descriptor returned by a call to seccomp(2) with the SECCOMP_FIL‐
>>        TER_FLAG_NEW_LISTENER flag.
>>
>>        SECCOMP_IOCTL_NOTIF_RECV
>>               This operation is used to obtain a user-space notification
>>               event.  If no such event is currently pending, the  opera‐
>>               tion  blocks  until  an  event occurs.
> 
> Not necessarily; for every time a process entered a signal handler or
> was killed while a notification was pending, a call to
> SECCOMP_IOCTL_NOTIF_RECV will return -ENOENT.

Yes, but do you not consider this sufficiently covered by the
(updated) error text that appears later? (See below.)

>> The third ioctl(2)
>>               argument is a pointer to a structure of the following form
>>               which  contains  information about the event.  This struc‐
>>               ture must be zeroed out before the call.
>>
>>                   struct seccomp_notif {
>>                       __u64  id;              /* Cookie */
>>                       __u32  pid;             /* PID of target process */
> 
> (TID, not PID)

Thanks. Fixed.

>>                       __u32  flags;           /* Currently unused (0) */
>>                       struct seccomp_data data;   /* See seccomp(2) */
>>                   };
>>
>>               The fields in this structure are as follows:
>>
>>               id     This is a cookie for the notification.   Each  such
>>                      cookie  is  guaranteed  to be unique for the corre‐
>>                      sponding seccomp  filter.   In  other  words,  this
>>                      cookie  is  unique for each notification event from
>>                      the target process.
> 
> That sentence about "target process" looks wrong to me. The cookies
> are unique across notifications from the filter, but there can be
> multiple filters per thread, and multiple threads per filter.

Thanks. I simply removed that last sentence.

>> The cookie value has the  fol‐
>>                      lowing uses:
>>
>>                      · It     can     be     used    with    the    SEC‐
>>                        COMP_IOCTL_NOTIF_ID_VALID ioctl(2)  operation  to
>>                        verify that the target process is still alive.
>>
>>                      · When  returning  a  notification  response to the
>>                        kernel, the supervisor must  include  the  cookie
>>                        value in the seccomp_notif_resp structure that is
>>                        specified   as   the   argument   of   the   SEC‐
>>                        COMP_IOCTL_NOTIF_SEND operation.
>>
>>               pid    This  is  the  PID of the target process that trig‐
>>                      gered the notification event.
>>
>>                      ┌─────────────────────────────────────────────────────┐
>>                      │FIXME                                                │
>>                      ├─────────────────────────────────────────────────────┤
>>                      │This is a thread ID, rather than a PID, right?       │
>>                      └─────────────────────────────────────────────────────┘
> 
> Yeah.

Thanks. I've made various fixes.

>>               flags  This is a  bit  mask  of  flags  providing  further
>>                      information on the event.  In the current implemen‐
>>                      tation, this field is always zero.
>>
>>               data   This is a seccomp_data structure containing  infor‐
>>                      mation  about  the  system  call that triggered the
>>                      notification.  This is the same structure  that  is
>>                      passed  to  the seccomp filter.  See seccomp(2) for
>>                      details of this structure.
>>
>>               On success, this operation returns 0; on  failure,  -1  is
>>               returned,  and  errno  is set to indicate the cause of the
>>               error.  This operation can fail with the following errors:
>>
>>               EINVAL (since Linux 5.5)
>>                      The seccomp_notif structure that was passed to  the
>>                      call contained nonzero fields.
>>
>>               ENOENT The  target  process  was killed by a signal as the
>>                      notification information was being generated.
> 
> Not just killed, interruption with a signal handler has the same effect.

Ah yes! Thanks. I added that as well.

[[
              ENOENT The target thread was killed  by  a  signal  as  the
                     notification information was being generated, or the
                     target's (blocked) system call was interrupted by  a
                     signal handler.
]]

Okay?

>>        ┌─────────────────────────────────────────────────────┐
>>        │FIXME                                                │
>>        ├─────────────────────────────────────────────────────┤
>>        │From my experiments,  it  appears  that  if  a  SEC‐ │
>>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
>>        │process terminates, then the ioctl()  simply  blocks │
>>        │(rather than returning an error to indicate that the │
>>        │target process no longer exists).                    │
>>        │                                                     │
>>        │I found that surprising, and it required  some  con‐ │
>>        │tortions  in the example program.  It was not possi‐ │
>>        │ble to code my SIGCHLD handler (which reaps the zom‐ │
>>        │bie  when  the  worker/target process terminates) to │
>>        │simply set a flag checked in the main  handleNotifi‐ │
>>        │cations()  loop,  since  this created an unavoidable │
>>        │race where the child might terminate  just  after  I │
>>        │had  checked  the  flag,  but before I blocked (for‐ │
>>        │ever!) in  the  SECCOMP_IOCTL_NOTIF_RECV  operation. │
>>        │Instead,  I had to code the signal handler to simply │
>>        │call _exit(2)  in  order  to  terminate  the  parent │
>>        │process (the supervisor).                            │
>>        │                                                     │
>>        │Is  this  expected  behavior?  It seems to me rather │
>>        │desirable that SECCOMP_IOCTL_NOTIF_RECV should  give │
>>        │an error if the target process has terminated.       │
>>        └─────────────────────────────────────────────────────┘
> 
> You could poll() the fd first. But yeah, it'd probably be a good idea
> to change that.

Ah! It was only after reading some comments from Christian that I
realized how poll() works here. I'll make some additions to the
page about the poll() details. (See my reply to Christian that should
land at about the same time as this mail.)
  
>>        SECCOMP_IOCTL_NOTIF_ID_VALID
> [...]
>>               In the above scenario, the risk is that the supervisor may
>>               try to access the memory of a process other than the  tar‐
>>               get.   This  race  can be avoided by following the call to
>>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ver‐
>>               ify  that  the  process that generated the notification is
>>               still alive.  (Note that  if  the  target  process  subse‐
>>               quently  terminates, its PID won't be reused because there
> 
> That's wrong, the PID can be reused, but the /proc/$pid directory is
> internally not associated with the numeric PID, but, conceptually
> speaking, with a specific incarnation of the PID, or something like
> that. (Actually, it is associated with the "struct pid", which is not
> reused, instead of the numeric PID.)

Thanks. I simplified the last sentence of the paragraph:

              In  the above scenario, the risk is that the supervisor may
              try to access the memory of a process other than  the  tar‐
              get.   This  race  can  be avoided by following the call to
              open(2) with a  SECCOMP_IOCTL_NOTIF_ID_VALID  operation  to
              verify  that the process that generated the notification is
              still alive.  (Note that if the target terminates after the
              latter  step, a subsequent read(2) from the file descriptor
              will return 0, indicating end of file.)

I think that's probably enough detail.

>>               remains an open reference to the /proc[pid]/mem  file;  in
>>               this  case, a subsequent read(2) from the file will return
>>               0, indicating end of file.)
>>
>>               On success (i.e., the notification  ID  is  still  valid),
>>               this  operation  returns 0 On failure (i.e., the notifica‐
> 
> nit: s/returns 0/returns 0./

Thanks. Fixed.

>>               tion ID is no longer valid), -1 is returned, and errno  is
>>               set to ENOENT.
>>
>>        SECCOMP_IOCTL_NOTIF_SEND
> [...]
>>               Two kinds of response are possible:
>>
>>               · A response to the kernel telling it to execute the  tar‐
>>                 get  process's  system  call.   In  this case, the flags
>>                 field includes SECCOMP_USER_NOTIF_FLAG_CONTINUE and  the
>>                 error and val fields must be zero.
>>
>>                 This  kind  of response can be useful in cases where the
>>                 supervisor needs to do deeper analysis of  the  target's
>>                 system  call  than  is  possible  from  a seccomp filter
>>                 (e.g., examining the values of pointer arguments),  and,
>>                 having  verified that the system call is acceptable, the
>>                 supervisor wants to allow it to proceed.
> 
> "allow" sounds as if this is an access control thing, but this
> mechanism should usually not be used for access control (unless the
> "seccomp" syscall is blocked).

Yes, Kees has also raised this point.

> Maybe reword as "having decided that
> the system call does not require emulation by the supervisor, the
> supervisor wants it to execute normally", or something like that?

Great! More suggested wordings! Thank you :-).

I tweaked slightly:

    ... having decided that the system call does not require emulation
    by the supervisor, the supervisor wants the system call to 
    be executed normally in the target.

> [...]
>>               On success, this operation returns 0; on  failure,  -1  is
>>               returned,  and  errno  is set to indicate the cause of the
>>               error.  This operation can fail with the following errors:
>>
>>               EINPROGRESS
>>                      A response to this notification  has  already  been
>>                      sent.
>>
>>               EINVAL An invalid value was specified in the flags field.
>>
>>               EINVAL The       flags      field      contained      SEC‐
>>                      COMP_USER_NOTIF_FLAG_CONTINUE, and the error or val
>>                      field was not zero.
>>
>>               ENOENT The  blocked  system call in the target process has
>>                      been interrupted by a signal handler.
> 
> (you could also get this if a response has already been sent, instead
> of EINPROGRESS - the only difference is whether the target thread has
> picked up the response yet)

Got it. I don't think I'll try to work that detail into the page
(unless you really think I should, but since you made this a
parenthetical comment, perhaps you don't think it's necessary).

>> NOTES
>>        The file descriptor returned when seccomp(2) is employed with the
>>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
>>        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
>>        ing,  these interfaces indicate that the file descriptor is read‐
>>        able.
> 
> We should probably also point out somewhere that, as
> include/uapi/linux/seccomp.h says:
> 
>  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
>  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
>  * same syscall, the most recently added filter takes precedence. This means
>  * that the new SECCOMP_RET_USER_NOTIF filter can override any
>  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all

My takeaway from Chritian's comments is that this comment in the kernel 
source is partially wrong, since it is not possible to install multiple
filters with SECCOMP_RET_USER_NOTIF, right?

>  * such filtered syscalls to be executed by sending the response
>  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
>  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> 
> In other words, from a security perspective, you must assume that the
> target process can bypass any SECCOMP_RET_USER_NOTIF (or
> SECCOMP_RET_TRACE) filters unless it is completely prohibited from
> calling seccomp(). 

Drawing on text from Chrstian's comment in seccomp.h and Kees's mail,
I added the following in NOTES:

   Design goals; use of SECCOMP_USER_NOTIF_FLAG_CONTINUE
       The intent of the user-space notification feature is to allow sys‐
       tem calls to be performed on behalf of the target.   The  target's
       system  call should either be handled by the supervisor or allowed
       to continue normally in the kernel (where standard security  poli‐
       cies will be applied).

       Note well: this mechanism must not be used to make security policy
       decisions about the system call, which would be  inherently  race-
       prone for reasons described next.

       The  SECCOMP_USER_NOTIF_FLAG_CONTINUE  flag must be used with cau‐
       tion.  If set by the supervisor, the  target's  system  call  will
       continue.   However,  there  is  a time-of-check, time-of-use race
       here, since an attacker could exploit the interval of  time  where
       the  target  is  blocked  waiting on the "continue" response to do
       things such as rewriting the system call arguments.

       Note furthermore that a user-space notifier can be bypassed if the
       existing  filters  allow  the  use  of  seccomp(2)  or prctl(2) to
       install a filter that returns an action value with a higher prece‐
       dence than SECCOMP_RET_USER_NOTIF (see seccomp(2)).

       It  should  thus  be  absolutely clear that the seccomp user-space
       notification mechanism can not be used  to  implement  a  security
       policy!   It  should  only  ever be used in scenarios where a more
       privileged process supervises the system calls of a lesser  privi‐
       leged  target  to get around kernel-enforced security restrictions
       when the supervisor deems this safe.  In other words, in order  to
       continue a system call, the supervisor should be sure that another
       security mechanism or the kernel itself  will  sufficiently  block
       the  system  call  if  its  arguments  are  rewritten to something
       unsafe.

Seem okay?

> This should also be noted over in the main
> seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.

I added some words in seccomp(2) to emphasize this.

>> EXAMPLES
> [...]
>>        This  program  can  used  to  demonstrate  various aspects of the
> 
> nit: "can be used to demonstrate", or alternatively just "demonstrates"

Thanks. Fixed (added "to")

>>        behavior of the seccomp user-space  notification  mechanism.   To
>>        help  aid  such demonstrations, the program logs various messages
>>        to show the operation of the target process (lines prefixed "T:")
>>        and the supervisor (indented lines prefixed "S:").
> [...]
>>    Program source
> [...]
>>        #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>>                                } while (0)
> 
> Don't we have err() for this?

I tend to avoid the use of err() because it's a nonstandard BSDism.
Perhaps by this point this is as much a habit as anything rational.

>>        /* Send the file descriptor 'fd' over the connected UNIX domain socket
>>           'sockfd'. Returns 0 on success, or -1 on error. */
>>
>>        static int
>>        sendfd(int sockfd, int fd)
>>        {
>>            struct msghdr msgh;
>>            struct iovec iov;
>>            int data;
>>            struct cmsghdr *cmsgp;
>>
>>            /* Allocate a char array of suitable size to hold the ancillary data.
>>               However, since this buffer is in reality a 'struct cmsghdr', use a
>>               union to ensure that it is suitable aligned. */
> 
> nit: suitably

Thanks. Fixed.

>>            union {
>>                char   buf[CMSG_SPACE(sizeof(int))];
>>                                /* Space large enough to hold an 'int' */
>>                struct cmsghdr align;
>>            } controlMsg;
>>
>>            /* The 'msg_name' field can be used to specify the address of the
>>               destination socket when sending a datagram. However, we do not
>>               need to use this field because 'sockfd' is a connected socket. */
>>
>>            msgh.msg_name = NULL;
>>            msgh.msg_namelen = 0;
>>
>>            /* On Linux, we must transmit at least one byte of real data in
>>               order to send ancillary data. We transmit an arbitrary integer
>>               whose value is ignored by recvfd(). */
>>
>>            msgh.msg_iov = &iov;
>>            msgh.msg_iovlen = 1;
>>            iov.iov_base = &data;
>>            iov.iov_len = sizeof(int);
>>            data = 12345;
>>
>>            /* Set 'msghdr' fields that describe ancillary data */
>>
>>            msgh.msg_control = controlMsg.buf;
>>            msgh.msg_controllen = sizeof(controlMsg.buf);
>>
>>            /* Set up ancillary data describing file descriptor to send */
>>
>>            cmsgp = CMSG_FIRSTHDR(&msgh);
>>            cmsgp->cmsg_level = SOL_SOCKET;
>>            cmsgp->cmsg_type = SCM_RIGHTS;
>>            cmsgp->cmsg_len = CMSG_LEN(sizeof(int));
>>            memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
>>
>>            /* Send real plus ancillary data */
>>
>>            if (sendmsg(sockfd, &msgh, 0) == -1)
>>                return -1;
>>
>>            return 0;
>>        }
> 
> Instead of using unix domain sockets to send the fd to the parent, I
> think you could also use clone3() with flags==CLONE_FILES|SIGCHLD,
> dup2() the seccomp fd to an fd that was reserved in the parent, call
> unshare(CLONE_FILES) in the child after setting up the seccomp fd, and
> wake up the parent with something like pthread_cond_signal()? I'm not
> sure whether that'd look better or worse in the end though, so maybe
> just ignore this comment.

Ahh -- nice. That answers in detail a question I also had for Tycho.
I won't make any changes to the page (since I'm not sure it would 
look better), but I will add that detail in a comment in the page
source. Perhaps I'll do something with that in the future.

> [...]
>>        /* Access the memory of the target process in order to discover the
>>           pathname that was given to mkdir() */
>>
>>        static void
>>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>>                          char *path, size_t len)
>>        {
>>            char procMemPath[PATH_MAX];
>>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
>>
>>            int procMemFd = open(procMemPath, O_RDONLY);
> 
> Should example code like this maybe use O_CLOEXEC unless the fd in
> question actually has to be inheritable? I know it doesn't actually
> matter here, but if this code was used in a multi-threaded context, it
> might.

Yes, good point. I changed this.

>>            if (procMemFd == -1)
>>                errExit("Supervisor: open");
>>
>>            /* Check that the process whose info we are accessing is still alive.
>>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>>               in checkNotificationIdIsValid()) succeeds, we know that the
>>               /proc/PID/mem file descriptor that we opened corresponds to the
>>               process for which we received a notification. If that process
>>               subsequently terminates, then read() on that file descriptor
>>               will return 0 (EOF). */
>>
>>            checkNotificationIdIsValid(notifyFd, req->id);
>>
>>            /* Seek to the location containing the pathname argument (i.e., the
>>               first argument) of the mkdir(2) call and read that pathname */
>>
>>            if (lseek(procMemFd, req->data.args[0], SEEK_SET) == -1)
>>                errExit("Supervisor: lseek");
>>
>>            ssize_t s = read(procMemFd, path, PATH_MAX);
>>            if (s == -1)
>>                errExit("read");
> 
> Why not pread() instead of lseek()+read()?

No good reason! I changed it to:

           /* Read bytes at the location containing the pathname argument
              (i.e., the first argument) of the mkdir(2) call */

           ssize_t s = pread(procMemFd, path, PATH_MAX, req->data.args[0]);
           if (s == -1)
               errExit("pread");

           if (s == 0) {
               fprintf(stderr, "\tS: pread() of /proc/PID/mem "
                       "returned 0 (EOF)\n");
               exit(EXIT_FAILURE);
           }

Thanks!

>>            if (s == 0) {
>>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
>>                        "returned 0 (EOF)\n");
>>                exit(EXIT_FAILURE);
>>            }
>>
>>            if (close(procMemFd) == -1)
>>                errExit("close-/proc/PID/mem");
> 
> We should probably make sure here that the value we read is actually
> NUL-terminated?

So, I was curious about that point also. But, (why) are we not
guaranteed that it will be NUL-terminated?

>>        }
>>
>>        /* Handle notifications that arrive via the SECCOMP_RET_USER_NOTIF file
>>           descriptor, 'notifyFd'. */
>>
>>        static void
>>        handleNotifications(int notifyFd)
>>        {
>>            struct seccomp_notif_sizes sizes;
>>            char path[PATH_MAX];
>>                /* For simplicity, we assume that the pathname given to mkdir()
>>                   is no more than PATH_MAX bytes; but this might not be true. */
> 
> No, it has to be true, otherwise the kernel would fail the syscall if
> it was executing normally.

Yes. I removed that comment.

>>            /* Discover the sizes of the structures that are used to receive
>>               notifications and send notification responses, and allocate
>>               buffers of those sizes. */
>>
>>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) == -1)
>>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
>>
>>            struct seccomp_notif *req = malloc(sizes.seccomp_notif);
>>            if (req == NULL)
>>                errExit("\tS: malloc");
>>
>>            struct seccomp_notif_resp *resp = malloc(sizes.seccomp_notif_resp);
> 
> This should probably do something like max(sizes.seccomp_notif_resp,
> sizeof(struct seccomp_notif_resp)) in case the program was built
> against new UAPI headers that make struct seccomp_notif_resp big, but
> is running under an old kernel where that struct is still smaller?

I'm confused. Why? I mean, if the running kernel says that it expects
a buffer of a certain size, and we allocate a buffer of that size,
what's the problem?

>>            if (resp == NULL)
>>                errExit("\tS: malloc");
> [...]
>>                    } else {
>>
>>                        /* If mkdir() failed in the supervisor, pass the error
>>                           back to the target */
>>
>>                        resp->error = -errno;
>>                        printf("\tS: failure! (errno = %d; %s)\n", errno,
>>                                strerror(errno));
>>                    }
>>                                                             } else if (strncmp(path, "./", strlen("./")) == 0) {
> 
> nit: indent messed up

Thanks. Fixed.

And thanks again for the detailed review, Jann.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
