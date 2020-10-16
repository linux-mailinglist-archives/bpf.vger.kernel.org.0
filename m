Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3896290B48
	for <lists+bpf@lfdr.de>; Fri, 16 Oct 2020 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbgJPS3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Oct 2020 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391614AbgJPS3t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Oct 2020 14:29:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE59C061755;
        Fri, 16 Oct 2020 11:29:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so2093180wmh.1;
        Fri, 16 Oct 2020 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fjhHDgtGKDkmsE20A5S1tjDqj2OZ2lKXPJVT44zEZks=;
        b=DMcDY/POrwCWToO1l+vt2aYtvCqBZ+bDBgDpl6Vr/KSsB+v9sQFJbvp6bGKfKjQbfW
         vmjKxo4/brSd8YtEqA9Vdoo8+4nt9rd+Q5k3bZ2pCo3jU0U9xinrSM9maWAGtrYfFqbI
         Iv8cpLLrSykzhWnaCTTs/msRSKZkDMR5alHczeCnU/EVoKxMEOphFbEKa1fBjQyo8D8f
         C3ilrTmeMxdxUJjpqdX/U1BzF5dIm/zIV471o11IX5s7mlbH2tYsdxeEuGlnwrHGq3MM
         X9OqWF+qk2OmXBCLvYHD78JD0dIKPDh0hPLLSSkWNOrCxF8emqEuW1R0EegFKe27d+6H
         ujeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjhHDgtGKDkmsE20A5S1tjDqj2OZ2lKXPJVT44zEZks=;
        b=j7exbiYg15v7JWNES6eFRkhq6CAlKq1hLIX7DkGbEYxYnWF2KHdtJMkGSekZrBU0qB
         IDLqMM1Y7SnNm842OK1ddDDU1tBpKn5OyWAqq8MSIlm+YvGOB0/DovDY/FDTds70wl4v
         5NcZ5Hn/RqJ0pVcEa883PXnz7crPC+Y99Csl6Io8WCmNUczKrG5TQ3qI1YvD8LcAmrfP
         7TPzakHr1rpliXgr0WcenBOWaxr4urjTQ8L9UTP9v+TuNyVwcaIe1DvN6mJFgBRW8oaR
         HgsNMzO075FLxTGZ13sJAqX6VznovvBnDYloq3+kMVUhgIAObcqlraD6vg97y52gpV7M
         6BuA==
X-Gm-Message-State: AOAM531XIhgeQvFQOPrFmGTb+2un8DBI3iYwEVBZBS6Mtsi7cClLYfNV
        xyaAfecvc688bYmRNqjU2bo=
X-Google-Smtp-Source: ABdhPJxOF3C8sqMEN9L7YEsWf8K/+WqPtZUGkqlk40squt01sAQGCxe/bxB+CvZjdnWLrHb9aNCCmQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr4954728wmi.120.1602872987057;
        Fri, 16 Oct 2020 11:29:47 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id d20sm4769846wra.38.2020.10.16.11.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:29:46 -0700 (PDT)
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
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
 <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com>
Date:   Fri, 16 Oct 2020 20:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Jann,

Thanks for your reply!

On 10/15/20 10:32 PM, Jann Horn wrote:
> On Thu, Oct 15, 2020 at 1:24 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 9/30/20 5:53 PM, Jann Horn wrote:
>>> On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
>>> <mtk.manpages@gmail.com> wrote:
>>>> I knew it would be a big ask, but below is kind of the manual page
>>>> I was hoping you might write [1] for the seccomp user-space notification
>>>> mechanism. Since you didn't (and because 5.9 adds various new pieces
>>>> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
>>>> that also will need documenting [2]), I did :-). But of course I may
>>>> have made mistakes...
> [...]
>>>>        3. The supervisor process will receive notification events on the
>>>>           listening  file  descriptor.   These  events  are  returned as
>>>>           structures of type seccomp_notif.  Because this structure  and
>>>>           its  size may evolve over kernel versions, the supervisor must
>>>>           first determine the size of  this  structure  using  the  sec‐
>>>>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  returns a
>>>>           structure of type seccomp_notif_sizes.  The  supervisor  allo‐
>>>>           cates a buffer of size seccomp_notif_sizes.seccomp_notif bytes
>>>>           to receive notification events.   In  addition,the  supervisor
>>>>           allocates  another  buffer  of  size  seccomp_notif_sizes.sec‐
>>>>           comp_notif_resp  bytes  for  the  response  (a   struct   sec‐
>>>>           comp_notif_resp  structure) that it will provide to the kernel
>>>>           (and thus the target process).
>>>>
>>>>        4. The target process then performs its workload, which  includes
>>>>           system  calls  that  will be controlled by the seccomp filter.
>>>>           Whenever one of these system calls causes the filter to return
>>>>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does not
>>>>           execute the system call;  instead,  execution  of  the  target
>>>>           process is temporarily blocked inside the kernel and a notifi‐
>>>
>>> where "blocked" refers to the interruptible, restartable kind - if the
>>> child receives a signal with an SA_RESTART signal handler in the
>>> meantime, it'll leave the syscall, go through the signal handler, then
>>> restart the syscall again and send the same request to the supervisor
>>> again. so the supervisor may see duplicate syscalls.
>>
>> So, I partially demonstrated what you describe here, for two example
>> system calls (epoll_wait() and pause()). But I could not exactly
>> demonstrate things as I understand you to be describing them. (So,
>> I'm not sure whether I have not understood you correctly, or
>> if things are not exactly as you describe them.)
>>
>> Here's a scenario (A) that I tested:
>>
>> 1. Target installs seccomp filters for a blocking syscall
>>    (epoll_wait() or pause(), both of which should never restart,
>>    regardless of SA_RESTART)
>> 2. Target installs SIGINT handler with SA_RESTART
>> 3. Supervisor is sleeping (i.e., is not blocked in
>>    SECCOMP_IOCTL_NOTIF_RECV operation).
>> 4. Target makes a blocking system call (epoll_wait() or pause()).
>> 5. SIGINT gets delivered to target; handler gets called;
>>    ***and syscall gets restarted by the kernel***
>>
>> That last should never happen, of course, and is a result of the
>> combination of both the user-notify filter and the SA_RESTART flag.
>> If one or other is not present, then the system call is not
>> restarted.
>>
>> So, as you note below, the UAPI gets broken a little.
>>
>> However, from your description above I had understood that
>> something like the following scenario (B) could occur:
>>
>> 1. Target installs seccomp filters for a blocking syscall
>>    (epoll_wait() or pause(), both of which should never restart,
>>    regardless of SA_RESTART)
>> 2. Target installs SIGINT handler with SA_RESTART
>> 3. Supervisor performs SECCOMP_IOCTL_NOTIF_RECV operation (which
>>    blocks).
>> 4. Target makes a blocking system call (epoll_wait() or pause()).
>> 5. Supervisor gets seccomp user-space notification (i.e.,
>>    SECCOMP_IOCTL_NOTIF_RECV ioctl() returns
>> 6. SIGINT gets delivered to target; handler gets called;
>>    and syscall gets restarted by the kernel
>> 7. Supervisor performs another SECCOMP_IOCTL_NOTIF_RECV operation
>>    which gets another notification for the restarted system call.
>>
>> However, I don't observe such behavior. In step 6, the syscall
>> does not get restarted by the kernel, but instead returns -1/EINTR.
>> Perhaps I have misconstructed my experiment in the second case, or
>> perhaps I've misunderstood what you meant, or is it possibly the
>> case that things are not quite as you said?

Thanks for the code, Jann (including the demo of the CLONE_FILES
technique to pass the notification FD to the supervisor).

But I think your code just demonstrates what I described in
scenario A. So, it seems that I both understood what you
meant (because my code demonstrates the same thing) and
also misunderstood what you said (because I thought you
were meaning something more like scenario B).

I'm not sure if I should write anything about this small UAPI
breakage in BUGS, or not. Your thoughts?

> user@vm:~/test/seccomp-notify-interrupt$ cat seccomp-notify-interrupt.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <signal.h>
> #include <err.h>
> #include <errno.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sched.h>
> #include <stddef.h>
> #include <limits.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/prctl.h>
> #include <linux/seccomp.h>
> #include <linux/filter.h>
> #include <linux/futex.h>
> 
> struct {
>   int seccomp_fd;
> } *shared;
> 
> static void handle_signal(int sig, siginfo_t *info, void *uctx) {
>   printf("signal handler invoked\n");
> }
> 
> int main(void) {
>   setbuf(stdout, NULL);
> 
>   shared = mmap(NULL, 0x1000, PROT_READ|PROT_WRITE,
>                 MAP_ANONYMOUS|MAP_SHARED, -1, 0);
>   if (shared == MAP_FAILED)
>     err(1, "mmap");
>   shared->seccomp_fd = -1;
> 
>   /* glibc's clone() wrapper doesn't support fork()-style usage */
>   pid_t child = syscall(__NR_clone, CLONE_FILES|SIGCHLD,
>                         NULL, NULL, NULL, 0);
>   if (child == -1) err(1, "clone");
>   if (child == 0) {
>     /* don't outlive the parent */
>     prctl(PR_SET_PDEATHSIG, SIGKILL);
>     if (getppid() == 1) exit(0);
> 
>     prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>     struct sock_filter insns[] = {
>       BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
>       BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_pause, 0, 1),
>       BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
>       BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW)
>     };
>     struct sock_fprog prog = {
>       .len = sizeof(insns)/sizeof(insns[0]),
>       .filter = insns
>     };
>     int seccomp_ret = syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
>                               SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
>     if (seccomp_ret < 0)
>       err(1, "install");
>     printf("installed seccomp: fd %d\n", seccomp_ret);
> 
>     __atomic_store(&shared->seccomp_fd, &seccomp_ret, __ATOMIC_RELEASE);
>     int futex_ret = syscall(__NR_futex, &shared->seccomp_fd, FUTEX_WAKE,
>                             INT_MAX, NULL, NULL, 0);
>     printf("woke %d waiters\n", futex_ret);
> 
>     struct sigaction act = {
>       .sa_sigaction = handle_signal,
>       .sa_flags = SA_RESTART|SA_SIGINFO
>     };
>     if (sigaction(SIGUSR1, &act, NULL))
>       err(1, "sigaction");
> 
>     pause();
>     perror("pause returned");
>     exit(0);
>   }
> 
>   int futex_ret = syscall(__NR_futex, &shared->seccomp_fd, FUTEX_WAIT,
>                           -1, NULL, NULL, 0);
>   if (futex_ret == -1 && errno != EAGAIN)
>     err(1, "futex wait");
>   int fd = __atomic_load_n(&shared->seccomp_fd, __ATOMIC_ACQUIRE);
>   printf("child installed seccomp fd %d\n", fd);
> 
>   sleep(1);
>   printf("going to send SIGUSR1...\n");
>   kill(child, SIGUSR1);
>   sleep(1);
> 
>   exit(0);
> }
> user@vm:~/test/seccomp-notify-interrupt$ gcc -o
> seccomp-notify-interrupt seccomp-notify-interrupt.c -Wall
> user@vm:~/test/seccomp-notify-interrupt$ strace -f
> ./seccomp-notify-interrupt >/dev/null
> execve("./seccomp-notify-interrupt", ["./seccomp-notify-interrupt"],
> 0x7ffcb31a0d08 /* 42 vars */) = 0
> brk(NULL)                               = 0x5565864b2000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=89296, ...}) = 0
> mmap(NULL, 89296, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7e688e7000
> close(3)                                = 0
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260A\2\0\0\0\0\0"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=1824496, ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x7f7e688e5000
> mmap(NULL, 1837056, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f7e68724000
> mprotect(0x7f7e68746000, 1658880, PROT_NONE) = 0
> mmap(0x7f7e68746000, 1343488, PROT_READ|PROT_EXEC,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7f7e68746000
> mmap(0x7f7e6888e000, 311296, PROT_READ,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16a000) = 0x7f7e6888e000
> mmap(0x7f7e688db000, 24576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b6000) = 0x7f7e688db000
> mmap(0x7f7e688e1000, 14336, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f7e688e1000
> close(3)                                = 0
> arch_prctl(ARCH_SET_FS, 0x7f7e688e6500) = 0
> mprotect(0x7f7e688db000, 16384, PROT_READ) = 0
> mprotect(0x556585183000, 4096, PROT_READ) = 0
> mprotect(0x7f7e68924000, 4096, PROT_READ) = 0
> munmap(0x7f7e688e7000, 89296)           = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1,
> 0) = 0x7f7e688fc000
> clone(child_stack=NULL, flags=CLONE_FILES|SIGCHLD) = 2558
> futex(0x7f7e688fc000, FUTEX_WAIT, 4294967295, NULLstrace: Process 2558 attached
>  <unfinished ...>
> [pid  2558] prctl(PR_SET_PDEATHSIG, SIGKILL) = 0
> [pid  2558] getppid()                   = 2557
> [pid  2558] prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) = 0
> [pid  2558] seccomp(SECCOMP_SET_MODE_FILTER, 0x8 /*
> SECCOMP_FILTER_FLAG_??? */, {len=4, filter=0x7ffdf7cc9b50}) = 3
> [pid  2558] write(1, "installed seccomp: fd 3\n", 24) = 24
> [pid  2558] futex(0x7f7e688fc000, FUTEX_WAKE, 2147483647 <unfinished ...>
> [pid  2557] <... futex resumed> )       = 0
> [pid  2558] <... futex resumed> )       = 1
> [pid  2558] write(1, "woke 1 waiters\n", 15) = 15
> [pid  2557] write(1, "child installed seccomp fd 3\n", 29) = 29
> [pid  2558] rt_sigaction(SIGUSR1, {sa_handler=0x556585181215,
> sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART|SA_SIGINFO,
> sa_restorer=0x7f7e6875b840}, NULL, 8) = 0
> [pid  2557] nanosleep({tv_sec=1, tv_nsec=0},  <unfinished ...>
> [pid  2558] pause( <unfinished ...>
> [pid  2557] <... nanosleep resumed> 0x7ffdf7cc9b10) = 0
> [pid  2557] write(1, "going to send SIGUSR1...", 24) = 24
> [pid  2557] write(1, "\n", 1)           = 1
> [pid  2557] kill(2558, SIGUSR1)         = 0
> [pid  2557] nanosleep({tv_sec=1, tv_nsec=0},  <unfinished ...>
> [pid  2558] <... pause resumed> )       = ? ERESTARTSYS (To be
> restarted if SA_RESTART is set)
> [pid  2558] --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER,
> si_pid=2557, si_uid=1000} ---
> [pid  2558] write(1, "signal handler invoked", 22) = 22
> [pid  2558] write(1, "\n", 1)           = 1
> [pid  2558] rt_sigreturn({mask=[]})     = 34
> [pid  2558] pause( <unfinished ...>
> [pid  2557] <... nanosleep resumed> 0x7ffdf7cc9b10) = 0
> [pid  2557] exit_group(0)               = ?
> [pid  2557] +++ exited with 0 +++
> <... pause resumed>)                    = ?
> +++ killed by SIGKILL +++
> user@vm:~/test/seccomp-notify-interrupt$

[...]

>>>>               In the above scenario, the risk is that the supervisor may
>>>>               try to access the memory of a process other than the  tar‐
>>>>               get.   This  race  can be avoided by following the call to
>>>>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ver‐
>>>>               ify  that  the  process that generated the notification is
>>>>               still alive.  (Note that  if  the  target  process  subse‐
>>>>               quently  terminates, its PID won't be reused because there
>>>
>>> That's wrong, the PID can be reused, but the /proc/$pid directory is
>>> internally not associated with the numeric PID, but, conceptually
>>> speaking, with a specific incarnation of the PID, or something like
>>> that. (Actually, it is associated with the "struct pid", which is not
>>> reused, instead of the numeric PID.)
>>
>> Thanks. I simplified the last sentence of the paragraph:
>>
>>               In  the above scenario, the risk is that the supervisor may
>>               try to access the memory of a process other than  the  tar‐
>>               get.   This  race  can  be avoided by following the call to
>>               open(2) with a  SECCOMP_IOCTL_NOTIF_ID_VALID  operation  to
>>               verify  that the process that generated the notification is
>>               still alive.  (Note that if the target terminates after the
>>               latter  step, a subsequent read(2) from the file descriptor
>>               will return 0, indicating end of file.)
>>
>> I think that's probably enough detail.
> 
> Maybe make that "may return 0" instead of "will return 0" - reading
> from /proc/$pid/mem can only return 0 in the following cases AFAICS:
> 
> 1. task->mm was already gone at open() time
> 2. mm->mm_users has dropped to zero (the mm only has lazytlb users;
>    page tables and VMAs are being blown away or have been blown away)
> 3. the syscall was called with length 0
> 
> When a process has gone away, normally mm->mm_users will drop to zero,
> but someone else could theoretically still be holding a reference to
> the mm (e.g. someone else in the middle of accessing /proc/$pid/mem).
> (Such references should normally not be very long-lived though.)
> 
> Additionally, in the unlikely case that the OOM killer just chomped
> through the page tables of the target process, I think the read will
> return -EIO (same error as if the address was simply unmapped) if the
> address is within a non-shared mapping. (Maybe that's something procfs
> could do better...)

Thanks for all the detail! I changed the text to say "may" 
instead of "will".

> [...]
>>>> NOTES
>>>>        The file descriptor returned when seccomp(2) is employed with the
>>>>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
>>>>        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
>>>>        ing,  these interfaces indicate that the file descriptor is read‐
>>>>        able.
>>>
>>> We should probably also point out somewhere that, as
>>> include/uapi/linux/seccomp.h says:
>>>
>>>  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
>>>  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
>>>  * same syscall, the most recently added filter takes precedence. This means
>>>  * that the new SECCOMP_RET_USER_NOTIF filter can override any
>>>  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
>>
>> My takeaway from Chritian's comments is that this comment in the kernel
>> source is partially wrong, since it is not possible to install multiple
>> filters with SECCOMP_RET_USER_NOTIF, right?
> 
> Yeah. (Well, AFAICS technically, you can add more filters that return
> SECCOMP_RET_USER_NOTIF, but when a filter returns that without having
> a notifier fd attached, seccomp blocks the syscall with -ENOSYS; it
> won't use the notifier fd attached to a different filter in the
> chain.)

Ah yes. I misspoke. I meant to say that only one filter can be installed
with SECCOMP_FILTER_FLAG_NEW_LISTENER (and that's what seccomp(2)
currently says). Also, I just checked, and I have already added the
detail about ENOSYS in seccomp(2).

       SECCOMP_RET_USER_NOTIF (since Linux 5.0)
              ...
              If there is no attached  supervisor  (either  because  the
              filter   was   not   installed   with   the   SECCOMP_FIL‐
              TER_FLAG_NEW_LISTENER flag or because the file  descriptor
              was  closed),  the  filter returns ENOSYS (similar to what
              happens when a filter returns SECCOMP_RET_TRACE and  there
              is  no  tracer).   See  seccomp_user_notif(2)  for further
              details.

[...]

>>>>            if (s == 0) {
>>>>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
>>>>                        "returned 0 (EOF)\n");
>>>>                exit(EXIT_FAILURE);
>>>>            }
>>>>
>>>>            if (close(procMemFd) == -1)
>>>>                errExit("close-/proc/PID/mem");
>>>
>>> We should probably make sure here that the value we read is actually
>>> NUL-terminated?
>>
>> So, I was curious about that point also. But, (why) are we not
>> guaranteed that it will be NUL-terminated?
> 
> Because it's random memory filled by another process, which we don't
> necessarily trust. While seccomp notifiers aren't usable for applying
> *extra* security restrictions, the supervisor will still often be more
> privileged than the supervised process.

D'oh! Yes, I see that I failed my Security Engineering 101 exam.

How about:

    /* We have no guarantees about what was in the memory of the target
       process. Therefore, we ensure that 'path' is null-terminated. Such
       precautions are particularly important in cases where (as is
       common) the surpervisor is running at a higher privilege level
       than the target. */

    // 'len' is size of buffer; 's' is return value from pread()
    int zeroIdx = len - 1;
    if (s < zeroIdx)
        zeroIdx = s;
    path[zeroIdx] = '\0';

Or just simply:

    path[len - 1] = '\0';

?

>>>>            /* Discover the sizes of the structures that are used to receive
>>>>               notifications and send notification responses, and allocate
>>>>               buffers of those sizes. */
>>>>
>>>>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) == -1)
>>>>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
>>>>
>>>>            struct seccomp_notif *req = malloc(sizes.seccomp_notif);
>>>>            if (req == NULL)
>>>>                errExit("\tS: malloc");
>>>>
>>>>            struct seccomp_notif_resp *resp = malloc(sizes.seccomp_notif_resp);
>>>
>>> This should probably do something like max(sizes.seccomp_notif_resp,
>>> sizeof(struct seccomp_notif_resp)) in case the program was built
>>> against new UAPI headers that make struct seccomp_notif_resp big, but
>>> is running under an old kernel where that struct is still smaller?
>>
>> I'm confused. Why? I mean, if the running kernel says that it expects
>> a buffer of a certain size, and we allocate a buffer of that size,
>> what's the problem?
> 
> Because in userspace, we cast the result of malloc() to a "struct
> seccomp_notif_resp *". If the kernel tells us that it expects a size
> smaller than sizeof(struct seccomp_notif_resp), then we end up with a
> pointer to a struct that consists partly of allocated memory, partly
> of out-of-bounds memory, which is generally a bad idea - I'm not sure
> whether the C standard permits that. And if userspace then e.g.
> decides to access some member of that struct that is beyond what the
> kernel thinks is the struct size, we get actual OOB memory accesses.

Thanks. Got it. (But gosh, this seems like a fragile API mess.)

I added the following to the code:

    /* When allocating the response buffer, we must allow for the fact
       that the user-space binary may have been built with user-space
       headers where 'struct seccomp_notif_resp' is bigger than the
       response buffer expected by the (older) kernel. Therefore, we
       allocate a buffer that is the maximum of the two sizes. This
       ensures that if the supervisor places bytes into the response
       structure that are past the response size that the kernel expects,
       then the supervisor is not touching an invalid memory location. */

    size_t resp_size = sizes.seccomp_notif_resp;
    if (sizeof(struct seccomp_notif_resp) > resp_size)
        resp_size = sizeof(struct seccomp_notif_resp);

    struct seccomp_notif_resp *resp = malloc(resp_size);

Okay?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
