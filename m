Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7D2A18BC
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgJaQ15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Oct 2020 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQ15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Oct 2020 12:27:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3EC0617A6;
        Sat, 31 Oct 2020 09:27:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i16so4316291wrv.1;
        Sat, 31 Oct 2020 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZS1Sb48m+qDvPTafZpQbeAaJf1HLzdFEdyw+BpUANJ8=;
        b=JkJ314p1U9zUzQfmkCX8cjxR66zvv0R9vMBDQHpgpVyHH40JEbY8CYcIRcPc9qB3wd
         mAg8A3XelZGAEcfzgb4v0hWJp5MVp43unParrrzUY/qC1TrMUbPcMjCdUNNZsEKn0GzD
         i8AXxwJGJ3zBV82bBhW6z37mnKnsMM4tHls67D7o3lUnPHHmJLiKAf2i5RgW4cer7/Pl
         VqmYQuSiO03QXfI9LZDlzUwuAKC0zI3gfBFZ7oD7dxDfGKcw1xZ9dSTxJ9r2+lj1tuMY
         0xviTHQEZjDyRZ74SmxlW6cEH+HcnYVTjEqySZi66pKs54PP22nNmpzPKIGhzxbDoFD0
         qEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZS1Sb48m+qDvPTafZpQbeAaJf1HLzdFEdyw+BpUANJ8=;
        b=SbRQeeWEsmQOr0Cz4XieCWrC/yWGgQD+ZJA46U0rTRAaPoywcesG6WfohXh4/wmVOR
         zY+Nyn2CjyEGT79ANU+Yf0EspirnxwDx9qbeaoD7fRkGCivrv1Kk1m+l3J+U1G8qF/5u
         +vo3waNmPq6j87brSoiv/GexlXLbePrzUDN/GL7Iyzl8fym0ABBwJzU1mZMPwf3GYZpi
         dt6EKrpEC0UfL3QgoiycjojIJRJtZDavWzeN89fceWxwVnODVvsVQVQ55MlLen28O0Fp
         ZDO4NTNuDrJzlcsLX0v5vEZpHAeecX0KI9wQnDP7Y9mRVNXCLihvCPjZaH8VDTyjKqvL
         ZFQw==
X-Gm-Message-State: AOAM533doCYGe4pKKJl16pRRzjJBN0yWZK0nsyfbS/6252BzntdNDtPX
        Dvs+8YR3xh88J1fVAb9Ow/RqAbH4zVg=
X-Google-Smtp-Source: ABdhPJxxOLA2vFQQ1H6m0go+bytX3hwj/pax9iShqodVQzyCjGunNUIP6HAFvzjSBM8odYz/A0RSPg==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr10100171wrw.283.1604161673976;
        Sat, 31 Oct 2020 09:27:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id t4sm8912354wmb.20.2020.10.31.09.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 09:27:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Sargun Dhillon <sargun@sargun.me>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029085312.GC29881@ircssh-2.c.rugged-nimbus-611.internal>
 <48e5937b-80f5-c48b-1c67-e8c9db263ca5@gmail.com>
 <20201030202720.GA4088@ircssh-2.c.rugged-nimbus-611.internal>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <606199d6-b48c-fee2-6e79-1e52bd7f429f@gmail.com>
Date:   Sat, 31 Oct 2020 17:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030202720.GA4088@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Sargun,

Thanks for your reply.

On 10/30/20 9:27 PM, Sargun Dhillon wrote:
> On Thu, Oct 29, 2020 at 09:37:21PM +0100, Michael Kerrisk (man-pages)
> wrote:

[...]

>>> I think I commented in another thread somewhere that the
>>> supervisor is not notified if the syscall is preempted. Therefore
>>> if it is performing a preemptible, long-running syscall, you need
>>> to poll SECCOMP_IOCTL_NOTIF_ID_VALID in the background, otherwise
>>> you can end up in a bad situation -- like leaking resources, or
>>> holding on to file descriptors after the program under
>>> supervision has intended to release them.
>> 
>> It's been a long day, and I'm not sure I reallu understand this. 
>> Could you outline the scnario in more detail?
>> 
> S: Sets up filter + interception for accept T: socket(AF_INET,
> SOCK_STREAM, 0) = 7 T: bind(7, {127.0.0.1, 4444}, ..) T: listen(7,
> 10) T: pidfd_getfd(T, 7) = 7 # For the sake of discussion.

Presumably, the preceding line should have been:

S: pidfd_getfd(T, 7) = 7 # For the sake of discussion.
(s/T:/S:/)

right?

> T: accept(7, ...) S: Intercepts accept S: Does accept in background 
> T: Receives signal, and accept(...) responds in EINTR T: close(7) S:
> Still running accept(7, ....), holding port 4444, so if now T
> retries to bind to port 4444, things fail.

Okay -- I understand. Presumably the solution here is not to 
block in accept(), but rather to use poll() to monitor both the
notification FD and the listening socket FD?

>>> A very specific example is if you're performing an accept on
>>> behalf of the program generating the notification, and the
>>> program intends to reuse the port. You can get into all sorts of
>>> awkward situations there.
>> 
>> [...]
>> 
> See above

[...]

>>> In addition, if it is a socket, it inherits the cgroup v1 classid
>>> and netprioidx of the receiving process.
>>> 
>>> The argument of this is as follows:
>>> 
>>> struct seccomp_notif_addfd { __u64 id; __u32 flags; __u32 srcfd; 
>>> __u32 newfd; __u32 newfd_flags; };
>>> 
>>> id This is the cookie value that was obtained using 
>>> SECCOMP_IOCTL_NOTIF_RECV.
>>> 
>>> flags A bitmask that includes zero or more of the 
>>> SECCOMP_ADDFD_FLAG_* bits set
>>> 
>>> SECCOMP_ADDFD_FLAG_SETFD - Use dup2 (or dup3?) like semantics
>>> when copying the file descriptor.
>>> 
>>> srcfd The file descriptor number to copy in the supervisor
>>> process.
>>> 
>>> newfd If the SECCOMP_ADDFD_FLAG_SETFD flag is specified this will
>>> be the file descriptor that is used in the dup2 semantics. If
>>> this file descriptor exists in the receiving process, it is
>>> closed and replaced by this file descriptor in an atomic fashion.
>>> If the copy process fails due to a MAC failure, or if srcfd is
>>> invalid, the newfd will not be closed in the receiving process.
>> 
>> Great description!
>> 
>>> If SECCOMP_ADDFD_FLAG_SETFD it not set, then this value must be
>>> 0.
>>> 
>>> newfd_flags The file descriptor flags to set on the file
>>> descriptor after it has been received by the process. The only
>>> flag that can currently be specified is O_CLOEXEC.
>>> 
>>> On success, this operation returns the file descriptor number in
>>> the receiving process. On failure, -1 is returned.
>>> 
>>> It can fail with the following error codes:
>>> 
>>> EINPROGRESS The cookie number specified hasn't been received by
>>> the listener
>> 
>> I don't understand this. Can you say more about the scenario?
>> 
> 
> This should not really happen. But if you do a ADDFD(...), on a
> notification *before* you've received it, you will get this error. So
> for example, 
> --> epoll(....) -> returns 
> --> RECV(...) cookie id is 777
> --> epoll(...) -> returns
> <-- ioctl(ADDFD, id = 778) # Notice how we haven't done a receive yet
> where we've received a notification for 778.

Got it. Looking also at the source code, I came up with the 
following:

              EINPROGRESS
                     The user-space notification specified in the id
                     field exists but has not yet been fetched (by a
                     SECCOMP_IOCTL_NOTIF_RECV) or has already been
                     responded to (by a SECCOMP_IOCTL_NOTIF_SEND).

Does that seem okay?

>>> ENOENT The cookie number is not valid. This can happen if a
>>> response has already been sent, or if the syscall was
>>> interrupted
>>> 
>>> EBADF If the file descriptor specified in srcfd is invalid, or if
>>> the fd is out of range of the destination program.
>> 
>> The piece "or if the fd is out of range of the destination program"
>> is not clear to me. Can you say some more please.
>> 
> 
> IIRC the maximum fd range is specific in proc by some sysctl named 
> nr_open. It's also evaluated against RLIMITs, and nr_max.
> 
> If nr-open (maximum fds open per process, iiirc) is 1000, even if 10
> FDs are open, it wont work if newfd is 1001.

Actually, the relevant limit seems to be just the RLIMIT_NOFILE
resource limit at least in my reading of fs/file.c::replace_fd().
So I made the text

              EBADF  Allocating the file descriptor in the target would
                     cause the target's RLIMIT_NOFILE limit to be
                     exceeded (see getrlimit(2)).

 
>>> EINVAL If flags or new_flags were unrecognized, or if newfd is
>>> non-zero, and SECCOMP_ADDFD_FLAG_SETFD has not been set.
>>> 
>>> EMFILE Too many files are open by the destination process.

I'm not sure that the error can really occur. That's the error
that in most other places occurs when RLIMIT_NOFILE is exceeded.
But I may have missed something. More precisely, when do you think
EMFILE can occur?

[...]

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
