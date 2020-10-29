Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7CD29F649
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 21:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgJ2Uh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJ2Uh0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 16:37:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCCC0613D4;
        Thu, 29 Oct 2020 13:37:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h22so1078365wmb.0;
        Thu, 29 Oct 2020 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7GQge44w5h4XXb7qRwm1NVPkzAdaD5C5i1fj7qBdE8=;
        b=J/R9a33P0vuHfg56Rkk0ZrX7aq4o08eDGojAe2dv9LLmSW878/OC19+tGonzbF0iHW
         hSwVy/4eXR9+CpJwuQyZhHpLFBhWi2MTPklB4kUrRPU7h+o+DG6HO+ctMKgdz3PtaZMs
         DZ/KJkesedySSI+1yI5xyIe4gaJKQuJdfJiYTgmteCl2sLwDkqnExSVo9rBjdysD2gmc
         XtctHkJuijF18BMWULdKagIQxFWSRnUSZ9VwC5bXCybQoYtDxxp34LLPNt0eSOyhvH6Q
         Qhn6Angh9vpT0syqIuj0CcCd9Rz5JWDweQ5etMF9FQuexG3Pf1AssDLl92d2XABqJbVs
         T2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7GQge44w5h4XXb7qRwm1NVPkzAdaD5C5i1fj7qBdE8=;
        b=c5aR7yM76LuGFpAGHs8UR/r4WFejlyzSkwkH4ujrv0rYNS8CZwV7Cofwv69Ydolb50
         qUWwB22sz4Xq/UMeS+tLvmQjQExNctAvssT2IHkBSRPRLhg/WW1z5zE7Ue21UefCn57+
         MCjNCq0s7nA9PH6SgXiRS4Vy6LhAaAV0+FhYGyF0AcvaTa8C6wyIETwYJJpec5eOnhWf
         cj5JlW97CrkcePS6uT2Rdwi9ews1Ytlq4u3JeNxiVjFCzx4+Y/XyLvKNTzrrjKnC/R60
         v25mLcDj+AfIGL8tlveB/MHEuk3SLlhYpsp1ZeRuCQG6JS42imC4o/Ar1j9oKoeIey8F
         0Xhg==
X-Gm-Message-State: AOAM533H5H9CVYjDVs9Ce5t+NKf//Ie81ULhs3RkaWjUUGdVxN4syst/
        FtpjiykYpRma1gzVr6wiF28=
X-Google-Smtp-Source: ABdhPJxsEeVN1upx8rKdfaaG+9tnR49dnO+gOJhycXPvWFASGaFk2NDYY/HpoVfSRwyy12PzOTHE1Q==
X-Received: by 2002:a1c:ed06:: with SMTP id l6mr702506wmh.67.1604003844285;
        Thu, 29 Oct 2020 13:37:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id e7sm7247334wrm.6.2020.10.29.13.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 13:37:23 -0700 (PDT)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <48e5937b-80f5-c48b-1c67-e8c9db263ca5@gmail.com>
Date:   Thu, 29 Oct 2020 21:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029085312.GC29881@ircssh-2.c.rugged-nimbus-611.internal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Sargun,,

On 10/29/20 9:53 AM, Sargun Dhillon wrote:
> On Mon, Oct 26, 2020 at 10:55:04AM +0100, Michael Kerrisk (man-pages) wrote:

[...]

>>    ioctl(2) operations
>>        The following ioctl(2) operations are provided to support seccomp
>>        user-space notification.  For each of these operations, the first
>>        (file descriptor) argument of ioctl(2) is the listening file
>>        descriptor returned by a call to seccomp(2) with the
>>        SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
>>
>>        SECCOMP_IOCTL_NOTIF_RECV
>>               This operation is used to obtain a user-space notification
>>               event.  If no such event is currently pending, the
>>               operation blocks until an event occurs.  The third
>>               ioctl(2) argument is a pointer to a structure of the
>>               following form which contains information about the event.
>>               This structure must be zeroed out before the call.
>>
>>                   struct seccomp_notif {
>>                       __u64  id;              /* Cookie */
>>                       __u32  pid;             /* TID of target thread */
>>                       __u32  flags;           /* Currently unused (0) */
>>                       struct seccomp_data data;   /* See seccomp(2) */
>>                   };
>>
>>               The fields in this structure are as follows:
>>
>>               id     This is a cookie for the notification.  Each such
>>                      cookie is guaranteed to be unique for the
>>                      corresponding seccomp filter.
>>
>>                      · It can be used with the
>>                        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation
>>                        to verify that the target is still alive.
>>
>>                      · When returning a notification response to the
>>                        kernel, the supervisor must include the cookie
>>                        value in the seccomp_notif_resp structure that is
>>                        specified as the argument of the
>>                        SECCOMP_IOCTL_NOTIF_SEND operation.
>>
>>               pid    This is the thread ID of the target thread that
>>                      triggered the notification event.
>>
>>               flags  This is a bit mask of flags providing further
>>                      information on the event.  In the current
>>                      implementation, this field is always zero.
>>
>>               data   This is a seccomp_data structure containing
>>                      information about the system call that triggered
>>                      the notification.  This is the same structure that
>>                      is passed to the seccomp filter.  See seccomp(2)
>>                      for details of this structure.
>>
>>               On success, this operation returns 0; on failure, -1 is
>>               returned, and errno is set to indicate the cause of the
>>               error.  This operation can fail with the following errors:
>>
>>               EINVAL (since Linux 5.5)
>>                      The seccomp_notif structure that was passed to the
>>                      call contained nonzero fields.
>>
>>               ENOENT The target thread was killed by a signal as the
>>                      notification information was being generated, or
>>                      the target's (blocked) system call was interrupted
>>                      by a signal handler.
>>
>>        ┌─────────────────────────────────────────────────────┐
>>        │FIXME                                                │
>>        ├─────────────────────────────────────────────────────┤
>>        │From my experiments, it appears that if a            │
>>        │SECCOMP_IOCTL_NOTIF_RECV is done after the target    │
>>        │thread terminates, then the ioctl() simply blocks    │
>>        │(rather than returning an error to indicate that the │
>>        │target no longer exists).                            │
>>        │                                                     │
>>        │I found that surprising, and it required some        │
>>        │contortions in the example program.  It was not      │
>>        │possible to code my SIGCHLD handler (which reaps the │
>>        │zombie when the worker/target terminates) to simply  │
>>        │set a flag checked in the main handleNotifications() │
>>        │loop, since this created an unavoidable race where   │
>>        │the child might terminate just after I had checked   │
>>        │the flag, but before I blocked (forever!) in the     │
>>        │SECCOMP_IOCTL_NOTIF_RECV operation. Instead, I had   │
>>        │to code the signal handler to simply call _exit(2)   │
>>        │in order to terminate the parent process (the        │
>>        │supervisor).                                         │
>>        │                                                     │
>>        │Is this expected behavior? It seems to me rather     │
>>        │desirable that SECCOMP_IOCTL_NOTIF_RECV should give  │
>>        │an error if the target has terminated.               │
>>        │                                                     │
>>        │Jann posted a patch to rectify this, but there was   │
>>        │no response (Lore link: https://bit.ly/3jvUBxk) to   │
>>        │his question about fixing this issue. (I've tried    │
>>        │building with the patch, but encountered an issue    │
>>        │with the target process entering D state after a     │
>>        │signal.)                                             │
>>        │                                                     │
>>        │For now, this behavior is documented in BUGS.        │
>>        │                                                     │
>>        │Kees Cook commented: Let's change [this] ASAP!       │
>>        └─────────────────────────────────────────────────────┘
>>
> 
> I think I commented in another thread somewhere that the supervisor is not 
> notified if the syscall is preempted. Therefore if it is performing a 
> preemptible, long-running syscall, you need to poll
> SECCOMP_IOCTL_NOTIF_ID_VALID in the background, otherwise you can
> end up in a bad situation -- like leaking resources, or holding on to
> file descriptors after the program under supervision has intended to
> release them.

It's been a long day, and I'm not sure I reallu understand this.
Could you outline the scnario in more detail?

> A very specific example is if you're performing an accept on behalf
> of the program generating the notification, and the program intends
> to reuse the port. You can get into all sorts of awkward situations
> there.

[...]

> 	SECCOMP_IOCTL_NOTIF_ADDFD (Since Linux v5.9)
> 		This operations is used by the supervisor to add a file
> 		descriptor to the process that generated the notification.
> 		This can be used by the supervisor to enable "emulation"
> 		[Probably a better word] of syscalls which return file
> 		descriptors, such as socket(2), or open(2).
> 
> 		When the file descriptor is received by the process that
> 		is associated with the notification / cookie, it follows
> 		SCM_RIGHTS like semantics, and is evaluated by MAC.

I'm not sure what you mean by SCM_RIGHTS like semantics. Do you mean,
the file descriptor refers to the same open file description
('struct file')?

"is evaluated by MAC"... Do you mean something like: the FD is 
subject  to LSM checks?

> 		In addition, if it is a socket, it inherits the cgroup
> 		v1 classid and netprioidx of the receiving process.
> 
> 		The argument of this is as follows:
> 
> 			struct seccomp_notif_addfd {
> 				__u64 id;
> 				__u32 flags;
> 				__u32 srcfd;
> 				__u32 newfd;
> 				__u32 newfd_flags;
> 			};
> 
> 		id
> 			This is the cookie value that was obtained using
> 			SECCOMP_IOCTL_NOTIF_RECV.
> 
> 		flags
> 			A bitmask that includes zero or more of the
> 			SECCOMP_ADDFD_FLAG_* bits set
> 
> 			SECCOMP_ADDFD_FLAG_SETFD - Use dup2 (or dup3?)
> 				like semantics when copying the file
> 				descriptor.
> 
> 		srcfd
> 			The file descriptor number to copy in the
> 			supervisor process.
> 
> 		newfd
> 			If the SECCOMP_ADDFD_FLAG_SETFD flag is specified
> 			this will be the file descriptor that is used
> 			in the dup2 semantics. If this file descriptor
> 			exists in the receiving process, it is closed
> 			and replaced by this file descriptor in an
> 			atomic fashion. If the copy process fails
> 			due to a MAC failure, or if srcfd is invalid,
> 			the newfd will not be closed in the receiving
> 			process.

Great description!

> 			If SECCOMP_ADDFD_FLAG_SETFD it not set, then
> 			this value must be 0.
> 
> 		newfd_flags
> 			The file descriptor flags to set on
> 			the file descriptor after it has been received
> 			by the process. The only flag that can currently
> 			be specified is O_CLOEXEC.
> 
> 		On success, this operation returns the file descriptor
> 		number in the receiving process. On failure, -1 is returned.
> 
> 		It can fail with the following error codes:
> 
> 		EINPROGRESS
> 			The cookie number specified hasn't been received
> 			by the listener

I don't understand this. Can you say more about the scenario?

> 		ENOENT
> 			The cookie number is not valid. This can happen
> 			if a response has already been sent, or if the
> 			syscall was interrupted
> 
> 		EBADF
> 			If the file descriptor specified in srcfd is
> 			invalid, or if the fd is out of range of the
> 			destination program.

The piece "or if the fd is out of range of the destination
program" is not clear to me. Can you say some more please.

> 		EINVAL
> 			If flags or new_flags were unrecognized, or
> 			if newfd is non-zero, and SECCOMP_ADDFD_FLAG_SETFD
> 			has not been set.
> 
> 		EMFILE
> 			Too many files are open by the destination process.
> 
> 		[there's other error codes possible, like from the LSMs
> 		 or if memory can't be read / written or ebusy]
> 		 
> Does this help?

It's a good start!

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
