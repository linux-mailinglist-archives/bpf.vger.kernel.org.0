Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAB29F4AF
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJ2TO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgJ2TOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 15:14:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8EC0613D4;
        Thu, 29 Oct 2020 12:14:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so876329wmf.0;
        Thu, 29 Oct 2020 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tzpyO8iGd6ISqQqB76LQ2KRMJcjgxpyukpb6ZzZ/qvE=;
        b=i9kfCzOCGtS9KMw8oYc1qSbcxpwLdGZowXhT3dMtToGHcRX1ULk0IvYdInIlb3jvV8
         b+HMFAFpqgF/Ydf8YxHBhQFpUV6UDvanpuV13RBYXwiAzP7VoFPK9fuxLSZpsb8+Marf
         Ambv+Tz1gSb0pUjlxS9Sf1mdlZzZ53zzIb1hAQPBa0EvJwqZyZSwTg/6c/YcHahKHyyy
         39pN8cJSg3j8WRIRoYT+p7CSI41bzBeVjq4PuCbPwrlsSKkiSF1k+xUi/e781l3h6R8x
         lZGwor4THZFGSuv/Qly+7OOhiGXWJD5TlKHXhEYv8sfuZzTjQd8VNQsqEyn3Qmb/wDgn
         /0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tzpyO8iGd6ISqQqB76LQ2KRMJcjgxpyukpb6ZzZ/qvE=;
        b=VVzECyZ87c/S2pj6iMhIjR6CBCtPiAUwMMkuMSc/kdJAN4evv5WELe6ds0YeNanA8c
         zE7GYxvo79ERUqBMNI8hnpOtCSZOkFGXV37E1HfcJQ+8NP9750/45f1tLlxLx64HILQa
         ZmEIe67We3WFnYveARk6Kaaaw/I4xyUxgWc0mu4fbu574bxBJUB8cLaNeCxpSTiJExhC
         VFxAVoeePDB7KqVvlEans5ikfuaNGT5KZlbbNYposp/icO0ZaXyb+mnOIHP8x7vt4ND1
         YuLkiCt6UgXpThUrKrPRHJY6TR8LbSUiNnoDTCiHcLNCn0NgOyF5x6iBsLFu00y+tRRd
         jFIw==
X-Gm-Message-State: AOAM5305tMxY/8+rY1GJxkBdTx4yedP23Spj3778PlOD+7vC/5g/W4yx
        l9vtrg0kBT+XR1EecV+CZg0=
X-Google-Smtp-Source: ABdhPJyMDfgiSIKtY0aILPTyTuQphrwaTfKpj58BkdDWPukoZrBGtNtR5YqHCMlsAzRuOSAyoLrlhA==
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr689291wmh.73.1603998894166;
        Thu, 29 Oct 2020 12:14:54 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id u195sm1433563wmu.18.2020.10.29.12.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 12:14:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <93cfdc79-4c48-bceb-3620-4c63e9f4822e@gmail.com>
Date:   Thu, 29 Oct 2020 20:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Jann,

On 10/29/20 2:42 AM, Jann Horn wrote:
> On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>        static bool
>>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>>                          char *path, size_t len)
>>        {
>>            char procMemPath[PATH_MAX];
>>
>>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
>>
>>            int procMemFd = open(procMemPath, O_RDONLY);
>>            if (procMemFd == -1)
>>                errExit("\tS: open");
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
>>            /* Read bytes at the location containing the pathname argument
>>               (i.e., the first argument) of the mkdir(2) call */
>>
>>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>>            if (nread == -1)
>>                errExit("pread");
> 
> As discussed at
> <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
> we need to re-check checkNotificationIdIsValid() after reading remote
> memory but before using the read value in any way. Otherwise, the
> syscall could in the meantime get interrupted by a signal handler, the
> signal handler could return, and then the function that performed the
> syscall could free() allocations or return (thereby freeing buffers on
> the stack).
> 
> In essence, this pread() is (unavoidably) a potential use-after-free
> read; and to make that not have any security impact, we need to check
> whether UAF read occurred before using the read value. This should
> probably be called out elsewhere in the manpage, too...
> 
> Now, of course, **reading** is the easy case. The difficult case is if
> we have to **write** to the remote process... because then we can't
> play games like that. If we write data to a freed pointer, we're
> screwed, that's it. (And for somewhat unrelated bonus fun, consider
> that /proc/$pid/mem is originally intended for process debugging,
> including installing breakpoints, and will therefore happily write
> over "readonly" private mappings, such as typical mappings of
> executable code.)
> 
> So, uuuuh... I guess if anyone wants to actually write memory back to
> the target process, we'd better come up with some dedicated API for
> that, using an ioctl on the seccomp fd that magically freezes the
> target process inside the syscall while writing to its memory, or
> something like that? And until then, the manpage should have a big fat
> warning that writing to the target's memory is simply not possible
> (safely).

Thank you for your very clear explanation! It turned out to be 
trivially easy to demonstrate this issue with a slightly modified
version of my program.

As well as the change to the code example that I already mentioned
my reply of a few hours ago, I've added the following text to the 
page:

   Caveats regarding the use of /proc/[tid]/mem
       The discussion above noted the need to use the
       SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) when opening the
       /proc/[tid]/mem file of the target to avoid the possibility of
       accessing the memory of the wrong process in the event that the
       target terminates and its ID is recycled by another (unrelated)
       thread.  However, the use of this ioctl(2) operation is also
       necessary in other situations, as explained in the following
       pargraphs.

       Consider the following scenario, where the supervisor tries to
       read the pathname argument of a target's blocked mount(2) system
       call:

       • From one of its functions (func()), the target calls mount(2),
         which triggers a user-space notification and causes the target
         to block.

       • The supervisor receives the notification, opens
         /proc/[tid]/mem, and (successfully) performs the
         SECCOMP_IOCTL_NOTIF_ID_VALID check.

       • The target receives a signal, which causes the mount(2) to
         abort.

       • The signal handler executes in the target, and returns.

       • Upon return from the handler, the execution of func() resumes,
         and it returns (and perhaps other functions are called,
         overwriting the memory that had been used for the stack frame
         of func()).

       • Using the address provided in the notification information, the
         supervisor reads from the target's memory location that used to
         contain the pathname.

       • The supervisor now calls mount(2) with some arbitrary bytes
         obtained in the previous step.

       The conclusion from the above scenario is this: since the
       target's blocked system call may be interrupted by a signal
       handler, the supervisor must be written to expect that the target
       may abandon its system call at any time; in such an event, any
       information that the supervisor obtained from the target's memory
       must be considered invalid.

       To prevent such scenarios, every read from the target's memory
       must be separated from use of the bytes so obtained by a
       SECCOMP_IOCTL_NOTIF_ID_VALID check.  In the above example, the
       check would be placed between the two final steps.  An example of
       such a check is shown in EXAMPLES.

       Following on from the above, it should be clear that a write by
       the supervisor into the target's memory can never be considered
       safe.

Seem okay?

By the way, is there any analogous kind of issue concerning
pidfd_getfd()? I'm thinking not, but I wonder if I've missed
something.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
