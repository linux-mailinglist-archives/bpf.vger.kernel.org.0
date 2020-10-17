Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17B291003
	for <lists+bpf@lfdr.de>; Sat, 17 Oct 2020 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437080AbgJQGDQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Oct 2020 02:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411680AbgJQGBg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A1C0613E1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2020 17:26:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so5476482lfk.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2020 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VpQ6UkhMUCM4OB4ea+Wfc9+vYzBSrFDhpzCoDb328bA=;
        b=VvpI6BDLjJrmUyriVf6t5g4oR5ct5qN8t76w4v/4VqhlPcoP4Kck8Qt1xa8Fl4pT3a
         dWCKtXxNVSVjNZWz770a8WYF4vPWC1gNrFAOavrS+KKnNnFjsMXXeFL6ei9x3N3kuMWv
         QZ/H4k0br4XFPNoyGmtyAUEphmAJHLR9CPDuih9iM7dNhSUf0EsH/AZbp2JmEE69Gu1D
         bBQ0eutIiUaGjSmrk3SP8ZG4yS2aMp7SmNQkmEq6oYbnHZmZkb4TyXupa+yG4Bl//Huj
         0sp07Fhu7yGOASJbPSIHNXIH4jz8+1YfpIL1VpRNyDON36nb6ofwYUG8t2Tw2vH11ywb
         OK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VpQ6UkhMUCM4OB4ea+Wfc9+vYzBSrFDhpzCoDb328bA=;
        b=TIs5CG5dnb3GQefjUaLxfgyl2fXXRDHdX9bxOB60IcNAF87KLadHfiYIAYIpbUAIZ2
         bZRstmfUmwLDJHNGFKy/gf7grFmb/4UKJPiATJi63VhH9agoKyqDRr5VZQ0KXqk4UDk4
         SO/St4MI8QPA4ff4aAWA1LnpNSiwkv4FskWsin4ES9sYKqlWQ3m9CuD6Xuz0SDxUlXRZ
         jSsGPK65EVxS2+CeVmPvfx5RauH1W23UJdRUDEXj/1FYubrXUfxM3d9qkyOW3JVAIhBq
         pUn3edaAOzbJjurmkmi7QGzxOyk2QrrznFayM+3tL5q7S0iueRE4ik/EpVrtKBWRwl/c
         JrjQ==
X-Gm-Message-State: AOAM531ibSMzP6W+o07tTNY1WjOko1I1cf2MbKMdWtMtyIc70JT4WPXU
        BOQsBtwWYa4bMme1j+qaHZswMQjDeCDAqTrKTuSoFw==
X-Google-Smtp-Source: ABdhPJyuMJoagMbBy1lrsc4uBYB98JfO4Fxlkv3DOBMNRDNq0bOebQJh88EoHG8T8M+2H9177SkC7jIJnv0XFWzwgc8=
X-Received: by 2002:a19:e308:: with SMTP id a8mr2148609lfh.573.1602894371034;
 Fri, 16 Oct 2020 17:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com> <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
 <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com>
In-Reply-To: <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 02:25:43 +0200
Message-ID: <CAG48ez1e-xKoJ_1v0DGMZ62WQCG7o7AUw+89DYEVbDpHWrdweA@mail.gmail.com>
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

On Fri, Oct 16, 2020 at 8:29 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 10/15/20 10:32 PM, Jann Horn wrote:
> > On Thu, Oct 15, 2020 at 1:24 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >> On 9/30/20 5:53 PM, Jann Horn wrote:
> >>> On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
> >>> <mtk.manpages@gmail.com> wrote:
> >>>> I knew it would be a big ask, but below is kind of the manual page
> >>>> I was hoping you might write [1] for the seccomp user-space notifica=
tion
> >>>> mechanism. Since you didn't (and because 5.9 adds various new pieces
> >>>> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
> >>>> that also will need documenting [2]), I did :-). But of course I may
> >>>> have made mistakes...
> > [...]
> >>>>        3. The supervisor process will receive notification events on=
 the
> >>>>           listening  file  descriptor.   These  events  are  returne=
d as
> >>>>           structures of type seccomp_notif.  Because this structure =
 and
> >>>>           its  size may evolve over kernel versions, the supervisor =
must
> >>>>           first determine the size of  this  structure  using  the  =
sec=E2=80=90
> >>>>           comp(2)  SECCOMP_GET_NOTIF_SIZES  operation,  which  retur=
ns a
> >>>>           structure of type seccomp_notif_sizes.  The  supervisor  a=
llo=E2=80=90
> >>>>           cates a buffer of size seccomp_notif_sizes.seccomp_notif b=
ytes
> >>>>           to receive notification events.   In  addition,the  superv=
isor
> >>>>           allocates  another  buffer  of  size  seccomp_notif_sizes.=
sec=E2=80=90
> >>>>           comp_notif_resp  bytes  for  the  response  (a   struct   =
sec=E2=80=90
> >>>>           comp_notif_resp  structure) that it will provide to the ke=
rnel
> >>>>           (and thus the target process).
> >>>>
> >>>>        4. The target process then performs its workload, which  incl=
udes
> >>>>           system  calls  that  will be controlled by the seccomp fil=
ter.
> >>>>           Whenever one of these system calls causes the filter to re=
turn
> >>>>           the  SECCOMP_RET_USER_NOTIF  action value, the kernel does=
 not
> >>>>           execute the system call;  instead,  execution  of  the  ta=
rget
> >>>>           process is temporarily blocked inside the kernel and a not=
ifi=E2=80=90
> >>>
> >>> where "blocked" refers to the interruptible, restartable kind - if th=
e
> >>> child receives a signal with an SA_RESTART signal handler in the
> >>> meantime, it'll leave the syscall, go through the signal handler, the=
n
> >>> restart the syscall again and send the same request to the supervisor
> >>> again. so the supervisor may see duplicate syscalls.
> >>
> >> So, I partially demonstrated what you describe here, for two example
> >> system calls (epoll_wait() and pause()). But I could not exactly
> >> demonstrate things as I understand you to be describing them. (So,
> >> I'm not sure whether I have not understood you correctly, or
> >> if things are not exactly as you describe them.)
> >>
> >> Here's a scenario (A) that I tested:
> >>
> >> 1. Target installs seccomp filters for a blocking syscall
> >>    (epoll_wait() or pause(), both of which should never restart,
> >>    regardless of SA_RESTART)
> >> 2. Target installs SIGINT handler with SA_RESTART
> >> 3. Supervisor is sleeping (i.e., is not blocked in
> >>    SECCOMP_IOCTL_NOTIF_RECV operation).
> >> 4. Target makes a blocking system call (epoll_wait() or pause()).
> >> 5. SIGINT gets delivered to target; handler gets called;
> >>    ***and syscall gets restarted by the kernel***
> >>
> >> That last should never happen, of course, and is a result of the
> >> combination of both the user-notify filter and the SA_RESTART flag.
> >> If one or other is not present, then the system call is not
> >> restarted.
> >>
> >> So, as you note below, the UAPI gets broken a little.
> >>
> >> However, from your description above I had understood that
> >> something like the following scenario (B) could occur:
> >>
> >> 1. Target installs seccomp filters for a blocking syscall
> >>    (epoll_wait() or pause(), both of which should never restart,
> >>    regardless of SA_RESTART)
> >> 2. Target installs SIGINT handler with SA_RESTART
> >> 3. Supervisor performs SECCOMP_IOCTL_NOTIF_RECV operation (which
> >>    blocks).
> >> 4. Target makes a blocking system call (epoll_wait() or pause()).
> >> 5. Supervisor gets seccomp user-space notification (i.e.,
> >>    SECCOMP_IOCTL_NOTIF_RECV ioctl() returns
> >> 6. SIGINT gets delivered to target; handler gets called;
> >>    and syscall gets restarted by the kernel
> >> 7. Supervisor performs another SECCOMP_IOCTL_NOTIF_RECV operation
> >>    which gets another notification for the restarted system call.
> >>
> >> However, I don't observe such behavior. In step 6, the syscall
> >> does not get restarted by the kernel, but instead returns -1/EINTR.
> >> Perhaps I have misconstructed my experiment in the second case, or
> >> perhaps I've misunderstood what you meant, or is it possibly the
> >> case that things are not quite as you said?
>
> Thanks for the code, Jann (including the demo of the CLONE_FILES
> technique to pass the notification FD to the supervisor).
>
> But I think your code just demonstrates what I described in
> scenario A. So, it seems that I both understood what you
> meant (because my code demonstrates the same thing) and
> also misunderstood what you said (because I thought you
> were meaning something more like scenario B).

Ahh, sorry, I should've read your mail more carefully. Indeed, that
testcase only shows scenario A. But the following shows scenario B...



user@vm:~/test/seccomp-notify-interrupt$ cat seccomp-notify-interrupt-b.c
#define _GNU_SOURCE
#include <stdio.h>
#include <signal.h>
#include <err.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <sched.h>
#include <stddef.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <linux/seccomp.h>
#include <linux/filter.h>
#include <linux/futex.h>

struct {
  int seccomp_fd;
} *shared;

static void handle_signal(int sig, siginfo_t *info, void *uctx) {
  const char *msg =3D "signal handler invoked\n";
  write(1, msg, strlen(msg));
}

static size_t max_size(size_t a, size_t b) {
  return (a > b) ? a : b;
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

  struct seccomp_notif_sizes sizes;
  if (syscall(__NR_seccomp, SECCOMP_GET_NOTIF_SIZES, 0, &sizes))
    err(1, "notif_sizes");
  struct seccomp_notif *notif =3D malloc(max_size(
    sizeof(struct seccomp_notif),
    sizes.seccomp_notif
  ));
  if (!notif)
    err(1, "malloc");
  for (int i=3D0; i<4; i++) {
    memset(notif, '\0', sizes.seccomp_notif);
    if (ioctl(fd, SECCOMP_IOCTL_NOTIF_RECV, notif))
      err(1, "notif_recv");
    printf("got notif: id=3D%" PRIu64 " pid=3D%u nr=3D%d\n",
           notif->id, notif->pid, notif->data.nr);
    sleep(1);
    printf("going to send SIGUSR1...\n");
    kill(child, SIGUSR1);
  }
  sleep(1);

  exit(0);
}
user@vm:~/test/seccomp-notify-interrupt$ gcc -o
seccomp-notify-interrupt-b seccomp-notify-interrupt-b.c
user@vm:~/test/seccomp-notify-interrupt$ ./seccomp-notify-interrupt-b
installed seccomp: fd 3
woke 1 waiters
child installed seccomp fd 3
got notif: id=3D4490537653766950251 pid=3D2641 nr=3D34
going to send SIGUSR1...
signal handler invoked
got notif: id=3D4490537653766950252 pid=3D2641 nr=3D34
going to send SIGUSR1...
signal handler invoked
got notif: id=3D4490537653766950253 pid=3D2641 nr=3D34
going to send SIGUSR1...
signal handler invoked
got notif: id=3D4490537653766950254 pid=3D2641 nr=3D34
going to send SIGUSR1...
signal handler invoked
user@vm:~/test/seccomp-notify-interrupt$



> I'm not sure if I should write anything about this small UAPI
> breakage in BUGS, or not. Your thoughts?

Thinking about it a bit more: Any code that relies on pause() or
epoll_wait() not restarting is buggy anyway, right? Because a signal
could also arrive directly before entering the syscall, while
userspace code is still executing? So one could argue that we're just
enlarging a preexisting race. (Unless the signal handler checks the
interrupted register state to figure out whether we already entered
syscall handling?)

If userspace relies on non-restarting behavior, it should be using
something like epoll_pwait(). And that stuff only unblocks signals
after we've already past the seccomp checks on entry. (I guess this
also means that anything that uses pause() properly effectively has to
either run pause() in a loop with nothing else [iow, not care whether
pause() restarts] or siglongjmp() out of the signal handler [iow,
unwind through the signal frame]?)

So we should probably document the restarting behavior as something
the supervisor has to deal with in the manpage; but for the
"non-restarting syscalls can restart from the target's perspective"
aspect, it might be enough to document this as quirky behavior that
can't actually break correct code? (Or not document it at all. Dunno.)

[...]
> >>>>            if (s =3D=3D 0) {
> >>>>                fprintf(stderr, "\tS: read() of /proc/PID/mem "
> >>>>                        "returned 0 (EOF)\n");
> >>>>                exit(EXIT_FAILURE);
> >>>>            }
> >>>>
> >>>>            if (close(procMemFd) =3D=3D -1)
> >>>>                errExit("close-/proc/PID/mem");
> >>>
> >>> We should probably make sure here that the value we read is actually
> >>> NUL-terminated?
> >>
> >> So, I was curious about that point also. But, (why) are we not
> >> guaranteed that it will be NUL-terminated?
> >
> > Because it's random memory filled by another process, which we don't
> > necessarily trust. While seccomp notifiers aren't usable for applying
> > *extra* security restrictions, the supervisor will still often be more
> > privileged than the supervised process.
>
> D'oh! Yes, I see that I failed my Security Engineering 101 exam.
>
> How about:
>
>     /* We have no guarantees about what was in the memory of the target
>        process. Therefore, we ensure that 'path' is null-terminated. Such
>        precautions are particularly important in cases where (as is
>        common) the surpervisor is running at a higher privilege level
>        than the target. */
>
>     // 'len' is size of buffer; 's' is return value from pread()
>     int zeroIdx =3D len - 1;
>     if (s < zeroIdx)
>         zeroIdx =3D s;
>     path[zeroIdx] =3D '\0';
>
> Or just simply:
>
>     path[len - 1] =3D '\0';
>
> ?

I'd either do "path[s-1] =3D '\0'" or bail out if "path[s - 1] !=3D '\0'".
Especially if we haven't NUL-terminated the buffer before reading into
it, we shouldn't write a nullbyte to path[len - 1], since the bytes in
front of that will stay uninitialized.

(Oh, by the way: In general, reading path buffers like this (with the
read potentially going beyond the end of the actual buffer) can
have... interesting interactions with userfaultfd. If the path is
stored in one page, starting at a non-zero offset inside the page, our
read will always overlap into the second page. That second page might
belong to a completely different VMA. If that VMA has a userfaultfd
handler, we'll take a userfaultfd fault and wait for the userfaultfd
handler to service the fault. Normally that's fine-ish; but if the
target thread is supposed to *be* the thread handling userfaultfd
faults in its process (and it never intentionally accesses any
userfaultfd regions, only other threads do that), userspace will
deadlock, because the thread waiting for userfaultfd fault resolution
is the same one that's blocked on the userfaultfd. But this is not
special to seccomp; there are syscalls that do the same thing,
although their over-reads are typically smaller. E.g.
do_strncpy_from_user() over-reads by up to 7 bytes. But when this came
up in a discussion with Linus Torvalds, he said it was a theoretical
concern; so I guess if the kernel seems fine with doing that in
practice, we probably don't care too much here either.)

> >>>>            /* Discover the sizes of the structures that are used to =
receive
> >>>>               notifications and send notification responses, and all=
ocate
> >>>>               buffers of those sizes. */
> >>>>
> >>>>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) =3D=3D -1=
)
> >>>>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
> >>>>
> >>>>            struct seccomp_notif *req =3D malloc(sizes.seccomp_notif)=
;
> >>>>            if (req =3D=3D NULL)
> >>>>                errExit("\tS: malloc");
> >>>>
> >>>>            struct seccomp_notif_resp *resp =3D malloc(sizes.seccomp_=
notif_resp);
> >>>
> >>> This should probably do something like max(sizes.seccomp_notif_resp,
> >>> sizeof(struct seccomp_notif_resp)) in case the program was built
> >>> against new UAPI headers that make struct seccomp_notif_resp big, but
> >>> is running under an old kernel where that struct is still smaller?
> >>
> >> I'm confused. Why? I mean, if the running kernel says that it expects
> >> a buffer of a certain size, and we allocate a buffer of that size,
> >> what's the problem?
> >
> > Because in userspace, we cast the result of malloc() to a "struct
> > seccomp_notif_resp *". If the kernel tells us that it expects a size
> > smaller than sizeof(struct seccomp_notif_resp), then we end up with a
> > pointer to a struct that consists partly of allocated memory, partly
> > of out-of-bounds memory, which is generally a bad idea - I'm not sure
> > whether the C standard permits that. And if userspace then e.g.
> > decides to access some member of that struct that is beyond what the
> > kernel thinks is the struct size, we get actual OOB memory accesses.
>
> Thanks. Got it. (But gosh, this seems like a fragile API mess.)
>
> I added the following to the code:
>
>     /* When allocating the response buffer, we must allow for the fact
>        that the user-space binary may have been built with user-space
>        headers where 'struct seccomp_notif_resp' is bigger than the
>        response buffer expected by the (older) kernel. Therefore, we
>        allocate a buffer that is the maximum of the two sizes. This
>        ensures that if the supervisor places bytes into the response
>        structure that are past the response size that the kernel expects,
>        then the supervisor is not touching an invalid memory location. */
>
>     size_t resp_size =3D sizes.seccomp_notif_resp;
>     if (sizeof(struct seccomp_notif_resp) > resp_size)
>         resp_size =3D sizeof(struct seccomp_notif_resp);
>
>     struct seccomp_notif_resp *resp =3D malloc(resp_size);
>
> Okay?

Looks good.
