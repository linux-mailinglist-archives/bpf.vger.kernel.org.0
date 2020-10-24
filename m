Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45F297C7D
	for <lists+bpf@lfdr.de>; Sat, 24 Oct 2020 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759311AbgJXMxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Oct 2020 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759310AbgJXMxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Oct 2020 08:53:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A17C0613CE;
        Sat, 24 Oct 2020 05:53:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k18so5556538wmj.5;
        Sat, 24 Oct 2020 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EgfvM5zV/kLXfQPV9wOlD5QlbUHURZ8e5f5iQyqUGAY=;
        b=qTKLAuP52o52qdtepm2jcn4I1p5bVTzpCBfTd3tmMAK2lnUgZW9S/A+oEd7fN/WU/E
         ZhMpxwQTA80p6Y4ULlFihR0k4p/gjWg1HhinUz94PYAsszR8vqmXA8qutQPP4CwZvki8
         C44zIP/iYpGc/cLM35K/Yizsee1UlwHQnWiRqeOdDgHzTspkrw1xAonyVAS3Z7emVTuH
         kZPkT811ipHg21cdlNapNVhjoEZNntmRc1AbZSWVxwlLCZQ27DgA+j0LI1IXIMIY1jpa
         R4fmJlSfwuJ2Y0c0sQhtI7TMD49rpgNYtpgo8hPpvkWaDIHQYv/OBRDz2Zh5egdcnpHN
         GMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EgfvM5zV/kLXfQPV9wOlD5QlbUHURZ8e5f5iQyqUGAY=;
        b=oPhe6nDRTRFq4yfszFaxL+Se5qMpNB/ts7mBVkOIGBkR4sqlFCkLhyKpW/+yDg3YMC
         neerzM9tjIcXKqXLFtgj2aTKc0cZhxADogXiOCTdUMA5zPItidKXpbasJg0DL4TgmhXA
         TGiPdcU+AMGSZQ6MPmSpQRkjbvXskVoa9t1u166fViIYAb0Tldog+hru54mRhPJhrUBB
         HNaVubuD1CxN/oVUJLCZkGG8wN8tkrLfpJOgYRjt4VH8m2ojDq7jGZcmSKJyxk8JMof2
         v4FPV/mZmtuB3JypwPHz7xU1Ug6AJ+WJy36EJY1N1mq/uSVwSo8zf3KHDJZCuyGLlllC
         fofA==
X-Gm-Message-State: AOAM532xlhxArl1/rZ4picRkgPNxGQwi/2jmkgF48qXMIa5gzkHJ2EQ9
        xuEnjZuarQ/BvIBGVV2OpAw=
X-Google-Smtp-Source: ABdhPJyWMq5sFBx6761rCcFGnq1OX92QzDhq2aX97z6npZvl1UBaEeOKWJ1f6yYmIRdGcKsm7UM/Bg==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr6503131wmm.45.1603543978165;
        Sat, 24 Oct 2020 05:52:58 -0700 (PDT)
Received: from [172.18.229.53] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id f139sm10424410wme.47.2020.10.24.05.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 05:52:56 -0700 (PDT)
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
 <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
 <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
 <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com>
 <CAG48ez1e-xKoJ_1v0DGMZ62WQCG7o7AUw+89DYEVbDpHWrdweA@mail.gmail.com>
Message-ID: <887d5a29-edaa-2761-1512-370c1f5c3a6f@gmail.com>
Date:   Sat, 24 Oct 2020 14:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1e-xKoJ_1v0DGMZ62WQCG7o7AUw+89DYEVbDpHWrdweA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Jann,

On 10/17/20 2:25 AM, Jann Horn wrote:
> On Fri, Oct 16, 2020 at 8:29 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 10/15/20 10:32 PM, Jann Horn wrote:
>>> On Thu, Oct 15, 2020 at 1:24 PM Michael Kerrisk (man-pages)
>>> <mtk.manpages@gmail.com> wrote:
>>>> On 9/30/20 5:53 PM, Jann Horn wrote:
>>>>> On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
>>>>> <mtk.manpages@gmail.com> wrote:
>>>>>> I knew it would be a big ask, but below is kind of the manual page
>>>>>> I was hoping you might write [1] for the seccomp user-space notification
>>>>>> mechanism. Since you didn't (and because 5.9 adds various new pieces
>>>>>> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
>>>>>> that also will need documenting [2]), I did :-). But of course I may
>>>>>> have made mistakes...
>>> [...]
>>>>>>        3. The supervisor process will receive notification events on the
>>>>>>           listening  file  descriptor.   These  events  are  returned as
>>>>>>           structures of type seccomp_notif.  Because this structure  and
>>>>>>           its  size may evolve over kernel versions, the supervisor must
>>>>>>           first determine the size of  this  structure  using  the  sec‐
>>>>>>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  returns a
>>>>>>           structure of type seccomp_notif_sizes.  The  supervisor  allo‐
>>>>>>           cates a buffer of size seccomp_notif_sizes.seccomp_notif bytes
>>>>>>           to receive notification events.   In  addition,the  supervisor
>>>>>>           allocates  another  buffer  of  size  seccomp_notif_sizes.sec‐
>>>>>>           comp_notif_resp  bytes  for  the  response  (a   struct   sec‐
>>>>>>           comp_notif_resp  structure) that it will provide to the kernel
>>>>>>           (and thus the target process).
>>>>>>
>>>>>>        4. The target process then performs its workload, which  includes
>>>>>>           system  calls  that  will be controlled by the seccomp filter.
>>>>>>           Whenever one of these system calls causes the filter to return
>>>>>>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does not
>>>>>>           execute the system call;  instead,  execution  of  the  target
>>>>>>           process is temporarily blocked inside the kernel and a notifi‐
>>>>>
>>>>> where "blocked" refers to the interruptible, restartable kind - if the
>>>>> child receives a signal with an SA_RESTART signal handler in the
>>>>> meantime, it'll leave the syscall, go through the signal handler, then
>>>>> restart the syscall again and send the same request to the supervisor
>>>>> again. so the supervisor may see duplicate syscalls.
>>>>
>>>> So, I partially demonstrated what you describe here, for two example
>>>> system calls (epoll_wait() and pause()). But I could not exactly
>>>> demonstrate things as I understand you to be describing them. (So,
>>>> I'm not sure whether I have not understood you correctly, or
>>>> if things are not exactly as you describe them.)
>>>>
>>>> Here's a scenario (A) that I tested:
>>>>
>>>> 1. Target installs seccomp filters for a blocking syscall
>>>>    (epoll_wait() or pause(), both of which should never restart,
>>>>    regardless of SA_RESTART)
>>>> 2. Target installs SIGINT handler with SA_RESTART
>>>> 3. Supervisor is sleeping (i.e., is not blocked in
>>>>    SECCOMP_IOCTL_NOTIF_RECV operation).
>>>> 4. Target makes a blocking system call (epoll_wait() or pause()).
>>>> 5. SIGINT gets delivered to target; handler gets called;
>>>>    ***and syscall gets restarted by the kernel***
>>>>
>>>> That last should never happen, of course, and is a result of the
>>>> combination of both the user-notify filter and the SA_RESTART flag.
>>>> If one or other is not present, then the system call is not
>>>> restarted.
>>>>
>>>> So, as you note below, the UAPI gets broken a little.
>>>>
>>>> However, from your description above I had understood that
>>>> something like the following scenario (B) could occur:
>>>>
>>>> 1. Target installs seccomp filters for a blocking syscall
>>>>    (epoll_wait() or pause(), both of which should never restart,
>>>>    regardless of SA_RESTART)
>>>> 2. Target installs SIGINT handler with SA_RESTART
>>>> 3. Supervisor performs SECCOMP_IOCTL_NOTIF_RECV operation (which
>>>>    blocks).
>>>> 4. Target makes a blocking system call (epoll_wait() or pause()).
>>>> 5. Supervisor gets seccomp user-space notification (i.e.,
>>>>    SECCOMP_IOCTL_NOTIF_RECV ioctl() returns
>>>> 6. SIGINT gets delivered to target; handler gets called;
>>>>    and syscall gets restarted by the kernel
>>>> 7. Supervisor performs another SECCOMP_IOCTL_NOTIF_RECV operation
>>>>    which gets another notification for the restarted system call.
>>>>
>>>> However, I don't observe such behavior. In step 6, the syscall
>>>> does not get restarted by the kernel, but instead returns -1/EINTR.
>>>> Perhaps I have misconstructed my experiment in the second case, or
>>>> perhaps I've misunderstood what you meant, or is it possibly the
>>>> case that things are not quite as you said?
>>
>> Thanks for the code, Jann (including the demo of the CLONE_FILES
>> technique to pass the notification FD to the supervisor).
>>
>> But I think your code just demonstrates what I described in
>> scenario A. So, it seems that I both understood what you
>> meant (because my code demonstrates the same thing) and
>> also misunderstood what you said (because I thought you
>> were meaning something more like scenario B).
> 
> Ahh, sorry, I should've read your mail more carefully. Indeed, that
> testcase only shows scenario A. But the following shows scenario B...
> 
> user@vm:~/test/seccomp-notify-interrupt$ cat seccomp-notify-interrupt-b.c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <signal.h>
> #include <err.h>
> #include <errno.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sched.h>
> #include <stddef.h>
> #include <string.h>
> #include <limits.h>
> #include <inttypes.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ioctl.h>
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
>   const char *msg = "signal handler invoked\n";
>   write(1, msg, strlen(msg));
> }
> 
> static size_t max_size(size_t a, size_t b) {
>   return (a > b) ? a : b;
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
>   struct seccomp_notif_sizes sizes;
>   if (syscall(__NR_seccomp, SECCOMP_GET_NOTIF_SIZES, 0, &sizes))
>     err(1, "notif_sizes");
>   struct seccomp_notif *notif = malloc(max_size(
>     sizeof(struct seccomp_notif),
>     sizes.seccomp_notif
>   ));
>   if (!notif)
>     err(1, "malloc");
>   for (int i=0; i<4; i++) {
>     memset(notif, '\0', sizes.seccomp_notif);
>     if (ioctl(fd, SECCOMP_IOCTL_NOTIF_RECV, notif))
>       err(1, "notif_recv");
>     printf("got notif: id=%" PRIu64 " pid=%u nr=%d\n",
>            notif->id, notif->pid, notif->data.nr);
>     sleep(1);
>     printf("going to send SIGUSR1...\n");
>     kill(child, SIGUSR1);
>   }
>   sleep(1);
> 
>   exit(0);
> }
> user@vm:~/test/seccomp-notify-interrupt$ gcc -o
> seccomp-notify-interrupt-b seccomp-notify-interrupt-b.c
> user@vm:~/test/seccomp-notify-interrupt$ ./seccomp-notify-interrupt-b
> installed seccomp: fd 3
> woke 1 waiters
> child installed seccomp fd 3
> got notif: id=4490537653766950251 pid=2641 nr=34
> going to send SIGUSR1...
> signal handler invoked
> got notif: id=4490537653766950252 pid=2641 nr=34
> going to send SIGUSR1...
> signal handler invoked
> got notif: id=4490537653766950253 pid=2641 nr=34
> going to send SIGUSR1...
> signal handler invoked
> got notif: id=4490537653766950254 pid=2641 nr=34
> going to send SIGUSR1...
> signal handler invoked
> user@vm:~/test/seccomp-notify-interrupt$

Thanks for that! Clearly I must have messed up something when
I tried to construct the code to test that scenario.

>> I'm not sure if I should write anything about this small UAPI
>> breakage in BUGS, or not. Your thoughts?
> 
> Thinking about it a bit more: Any code that relies on pause() or
> epoll_wait() not restarting is buggy anyway, right? Because a signal
> could also arrive directly before entering the syscall, while
> userspace code is still executing? So one could argue that we're just
> enlarging a preexisting race. (Unless the signal handler checks the
> interrupted register state to figure out whether we already entered
> syscall handling?)

Yes, that all makes sense.

> If userspace relies on non-restarting behavior, it should be using
> something like epoll_pwait(). And that stuff only unblocks signals
> after we've already past the seccomp checks on entry.

Thanks for elaborating that detail, since as soon as you talked 
about "enlarging a preexisting race" above, I immediately wondered
sigsuspend(), pselect(), etc.

(Mind you, I still wonder about the effect on system calls that
are normally nonrestartable because they have timeouts. My
understanding is that the kernel doesn't restart those system
calls because it's impossible for the kernel to restart the call
with the right timeout value. I wonder what happens when those
system calls are restarted in the scenario we're discussing.)

Anyway, returning to your point... So, to be clear (and to
quickly remind myself in case I one day reread this thread),
there is not a problem with sigsuspend(), pselect(), ppoll(),
and epoll_pwait() since:

* Before the syscall, signals are blocked in the target.
* Inside the syscall, signals are still blocked at the time 
  the check is made for seccomp filters.
* If a seccomp user-space notification  event kicks, the target
  is put to sleep with the signals still blocked.
* The signal will only get delivered after the supervisor either
  triggers a spoofed success/failure return in the target or the
  supervisor sends a CONTINUE response to the kernel telling it
  to execute the target's system call. Either way, there won't be
  any restarting of the target's system call (and the supervisor
  thus won't see multiple notifications).

(Right?)

> (I guess this
> also means that anything that uses pause() properly effectively has to
> either run pause() in a loop with nothing else [iow, not care whether
> pause() restarts] or siglongjmp() out of the signal handler [iow,
> unwind through the signal frame]?)

Yes, that's my understanding. Simple pause() (vs sigsuspend())
is always racy.

> So we should probably document the restarting behavior as something
> the supervisor has to deal with in the manpage; but for the
> "non-restarting syscalls can restart from the target's perspective"
> aspect, it might be enough to document this as quirky behavior that
> can't actually break correct code? (Or not document it at all. Dunno.)

So, I've added the following to the page:

   Interaction with SA_RESTART signal handlers
       Consider the following scenario:

       · The target process has used sigaction(2)  to  install  a  signal
         handler with the SA_RESTART flag.

       · The target has made a system call that triggered a seccomp user-
         space notification and the target is currently blocked until the
         supervisor sends a notification response.

       · A  signal  is  delivered to the target and the signal handler is
         executed.

       · When  (if)  the  supervisor  attempts  to  send  a  notification
         response,  the SECCOMP_IOCTL_NOTIF_SEND ioctl(2)) operation will
         fail with the ENOENT error.

       In this scenario, the kernel  will  restart  the  target's  system
       call.   Consequently,  the  supervisor  will receive another user-
       space notification.  Thus, depending on how many times the blocked
       system call is interrupted by a signal handler, the supervisor may
       receive multiple notifications for the same  system  call  in  the
       target.

       One  oddity  is  that  system call restarting as described in this
       scenario will occur even for the blocking system calls  listed  in
       signal(7) that would never normally be restarted by the SA_RESTART
       flag.

Does that seem okay?

In addition, I've queued a cross-reference in signal(7):

       In certain circumstances, the seccomp(2) user-space notifi‐
       cation  feature can lead to restarting of system calls that
       would otherwise  never  be  restarted  by  SA_RESTART;  for
       details, see seccomp_user_notif(2).

> [...]
>>>>>>            if (s == 0) {
>>>>>>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
>>>>>>                        "returned 0 (EOF)\n");
>>>>>>                exit(EXIT_FAILURE);
>>>>>>            }
>>>>>>
>>>>>>            if (close(procMemFd) == -1)
>>>>>>                errExit("close-/proc/PID/mem");
>>>>>
>>>>> We should probably make sure here that the value we read is actually
>>>>> NUL-terminated?
>>>>
>>>> So, I was curious about that point also. But, (why) are we not
>>>> guaranteed that it will be NUL-terminated?
>>>
>>> Because it's random memory filled by another process, which we don't
>>> necessarily trust. While seccomp notifiers aren't usable for applying
>>> *extra* security restrictions, the supervisor will still often be more
>>> privileged than the supervised process.
>>
>> D'oh! Yes, I see that I failed my Security Engineering 101 exam.
>>
>> How about:
>>
>>     /* We have no guarantees about what was in the memory of the target
>>        process. Therefore, we ensure that 'path' is null-terminated. Such
>>        precautions are particularly important in cases where (as is
>>        common) the surpervisor is running at a higher privilege level
>>        than the target. */
>>
>>     // 'len' is size of buffer; 's' is return value from pread()
>>     int zeroIdx = len - 1;
>>     if (s < zeroIdx)
>>         zeroIdx = s;
>>     path[zeroIdx] = '\0';
>>
>> Or just simply:
>>
>>     path[len - 1] = '\0';
>>
>> ?
> 
> I'd either do "path[s-1] = '\0'" or bail out if "path[s - 1] != '\0'".
> Especially if we haven't NUL-terminated the buffer before reading into
> it, we shouldn't write a nullbyte to path[len - 1], since the bytes in
> front of that will stay uninitialized.

I realized by the way that I made a thinko. In the usual case,
read(fd, buf, PATH_MAX) will return PATHMAX bytes that include
trailing garbage after the pathname. So the right check is I think
to scan from the start of the buffer to see if there's a NUL, and
error if there is not, and that's how I have modified the example
program.

> (Oh, by the way: In general, reading path buffers like this (with the
> read potentially going beyond the end of the actual buffer) can
> have... interesting interactions with userfaultfd. If the path is
> stored in one page, starting at a non-zero offset inside the page, our
> read will always overlap into the second page. That second page might
> belong to a completely different VMA. If that VMA has a userfaultfd
> handler, we'll take a userfaultfd fault and wait for the userfaultfd
> handler to service the fault. Normally that's fine-ish; but if the
> target thread is supposed to *be* the thread handling userfaultfd
> faults in its process (and it never intentionally accesses any
> userfaultfd regions, only other threads do that), userspace will
> deadlock, because the thread waiting for userfaultfd fault resolution
> is the same one that's blocked on the userfaultfd. But this is not
> special to seccomp; there are syscalls that do the same thing,
> although their over-reads are typically smaller. E.g.
> do_strncpy_from_user() over-reads by up to 7 bytes. But when this came
> up in a discussion with Linus Torvalds, he said it was a theoretical
> concern; so I guess if the kernel seems fine with doing that in
> practice, we probably don't care too much here either.)

Thanks for the background info. Indeed there are some 
bizarre corner cases...

[...]

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
