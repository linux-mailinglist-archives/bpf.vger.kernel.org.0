Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE86298A38
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 11:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbgJZJkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 05:40:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422581AbgJZJjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 05:39:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id s9so11553408wro.8;
        Mon, 26 Oct 2020 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZwGLU/rU5L//G5apVPcdJV153AWbUEYe+mVBVjXP33k=;
        b=IJk6LBFpSyg+OHxf/MaLBwVPtxt+AzqUsvkpYF+66FdiajKRI3Qhv6lNY2558k+8GQ
         mvJ0NcA23jg4WbmcB85FtrgAq5CH+WDg2ljB36Uzb86EXmfRJJm+HEJc/enLp139QW8z
         /2GHNGobTCcenZK4OBllEEQ6Wiyt0Yd6DQKSUo60PN+Jd98YrrlLI9RJgIhFHmaKB1Bh
         lgtla+zT5wc39XijxHykLnZmF+DKjbRyFOAhFjQZ7Ml/kppecUB7cY+Pk2VJeGmhBFH/
         vK0ex3g27OTLHfS7IqT5A/uRE/HOMBiOClCoAGBu7k22wbEVh99sJEg+k/GBBFLP+35h
         yoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZwGLU/rU5L//G5apVPcdJV153AWbUEYe+mVBVjXP33k=;
        b=Dcg6tu4+y++5t5F4yWf/kUxWlh2nZFDrTGMy2svgTu/48UYRc5UoiFvKtoO2i6e8hK
         rhzezdkE7XtQAydbA/zQIDLuavgL1lQFTusC458AT8CHp0PK+rna/rLKomQWaDUIZtDD
         3ts1eOpjj9Ue6QQ6r6wBX6yfa1p5TEXsRbSjxxeWgLKqS/1cChdYtDEjkquaAQNm74EW
         WUGLjCnA4cVYJ5K6KFeA7ZP4bO3WPd7wYEFvfazX2r0Kebrrcw78Nt+35WwxeyvaNVR3
         ThcNWxf+mQnbXJ9vUzIHgetbrIz2SBN/vJDWLuQG1UC3NrBIhCjm9GCRihcGyT5PaSvp
         udlw==
X-Gm-Message-State: AOAM53337VqMwnCcy+xd48QekKGINnpGp0Jt/RpA+0ICLmaANQbABSbV
        VjihGzu59+ANCpJEJ+TbsPA=
X-Google-Smtp-Source: ABdhPJxI9mh1F+vvnusf42u8B/rdJi5ri/Gle2lkizOo4lSEsRTc3lRYKvVyCmoM++zxrypwMjhn7A==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr17424328wrr.185.1603705182621;
        Mon, 26 Oct 2020 02:39:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id f6sm20798773wru.50.2020.10.26.02.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 02:39:41 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Kees Cook <keescook@chromium.org>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <202009301632.9C6A850272@keescook>
 <c1cc0df8-bd06-51e7-d5a0-888c1955683b@gmail.com>
 <202010250759.F9745E0B6@keescook>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cb398342-38e0-fb76-748c-813af8c688d1@gmail.com>
Date:   Mon, 26 Oct 2020 10:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202010250759.F9745E0B6@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Kees,

On 10/26/20 1:19 AM, Kees Cook wrote:
> On Thu, Oct 15, 2020 at 01:24:03PM +0200, Michael Kerrisk (man-pages) wrote:
>> On 10/1/20 1:39 AM, Kees Cook wrote:
>>> I'll comment more later, but I've run out of time today and I didn't see
>>> anyone mention this detail yet in the existing threads... :)
>>
>> Later never came :-). But, I hope you may have comments for the 
>> next draft, which I will send out soon.
> 
> Later is now, and Soon approaches!
> 
> I finally caught up and read through this whole thread. Thank you all
> for the bug fix[1], and I'm looking forward to more[2]. :)


> For my reply I figured I'd base it on the current draft, so here's a
> simulated quote based on the seccomp_user_notif branch of
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> through commit 71101158fe330af5a26552447a0bb433b69e15b7
> $ COLUMNS=75 man --nh --nj man2/seccomp_user_notif.2 | sed 's/^/> /'

Thanks for reviewing the latest version!

> On Sun, Oct 25, 2020 at 01:54:05PM +0100, Michael Kerrisk (man-pages) wrote:
>> SECCOMP_USER_NOTIF(2)   Linux Programmer's Manual   SECCOMP_USER_NOTIF(2)
>>
>> NAME
>>        seccomp_user_notif - Seccomp user-space notification mechanism
>>
>> SYNOPSIS
>>        #include <linux/seccomp.h>
>>        #include <linux/filter.h>
>>        #include <linux/audit.h>
>>
>>        int seccomp(unsigned int operation, unsigned int flags, void *args);
>>
>>        #include <sys/ioctl.h>
>>
>>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_RECV,
>>                  struct seccomp_notif *req);
>>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_SEND,
>>                  struct seccomp_notif_resp *resp);
>>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_ID_VALID, __u64 *id);
>>
>> DESCRIPTION
>>        This page describes the user-space notification mechanism provided
>>        by the Secure Computing (seccomp) facility.  As well as the use of
>>        the SECCOMP_FILTER_FLAG_NEW_LISTENER flag, the
>>        SECCOMP_RET_USER_NOTIF action value, and the
>>        SECCOMP_GET_NOTIF_SIZES operation described in seccomp(2), this
>>        mechanism involves the use of a number of related ioctl(2)
>>        operations (described below).
>>
>>    Overview
>>        In conventional usage of a seccomp filter, the decision about how
>>        to treat a system call is made by the filter itself.  By contrast,
>>        the user-space notification mechanism allows the seccomp filter to
>>        delegate the handling of the system call to another user-space
>>        process.  Note that this mechanism is explicitly not intended as a
>>        method implementing security policy; see NOTES.
>>
>>        In the discussion that follows, the thread(s) on which the seccomp
>>        filter is installed is (are) referred to as the target, and the
>>        process that is notified by the user-space notification mechanism
>>        is referred to as the supervisor.
>>
>>        A suitably privileged supervisor can use the user-space
>>        notification mechanism to perform actions on behalf of the target.
>>        The advantage of the user-space notification mechanism is that the
>>        supervisor will usually be able to retrieve information about the
>>        target and the performed system call that the seccomp filter
>>        itself cannot.  (A seccomp filter is limited in the information it
>>        can obtain and the actions that it can perform because it is
>>        running on a virtual machine inside the kernel.)
>>
>>        An overview of the steps performed by the target and the
>>        supervisor is as follows:
>>
>>        1. The target establishes a seccomp filter in the usual manner,
>>           but with two differences:
>>
>>           • The seccomp(2) flags argument includes the flag
>>             SECCOMP_FILTER_FLAG_NEW_LISTENER.  Consequently, the return
>>             value  of the (successful) seccomp(2) call is a new
> 
> nit: extra space

Thanks. Fixed.

>>             "listening" file descriptor that can be used to receive
>>             notifications.  Only one "listening" seccomp filter can be
>>             installed for a thread.
> 
> I like this limitation, but I expect that it'll need to change in the
> future. Even with LSMs, we see the need for arbitrary stacking, and the
> idea of there being only 1 supervisor will eventually break down. Right
> now there is only 1 because only container managers are using this
> feature. But if some daemon starts using it to isolate some thread,
> suddenly it might break if a container manager is trying to listen to it
> too, etc. I expect it won't be needed soon, but I do think it'll change.

Thanks for the background. (I added your text in a comment in the
page, just for my own reference in the future.)

>>           • In cases where it is appropriate, the seccomp filter returns
>>             the action value SECCOMP_RET_USER_NOTIF.  This return value
>>             will trigger a notification event.
>>
>>        2. In order that the supervisor can obtain notifications using the
>>           listening file descriptor, (a duplicate of) that file
>>           descriptor must be passed from the target to the supervisor.
> 
> Yet another reason to have an "activate on exec" mode for seccomp. With

Funnily enough, I was having an in-person conversation just last week
with someone else who was interested in "activate-on-exec".

> no_new_privs _not_ being delayed in such a way, I think it'd be safe to
> add. The supervisor would get the fd immediately, and then once it
> fork/execed suddenly the whole thing would activate, and no fd passing
> needed.
> 
> The "on exec" boundary is really only needed for oblivious targets. For
> a coordinated target, I've thought it might be nice to have an arbitrary
> "go" point, where the target could call seccomp() with something like a
> SECCOMP_ACTIVATE_DELAYED_FILTERS operation. This lets any process
> initialization happen that might need to do things that would be blocked
> by filters, etc.
> 
> Before:
> 
> 	fork
> 	install some filters that don't block initialization
> 	exec
> 	do some initialization
> 	install more filters, maybe block exec, seccomp
> 	run
> 
> After:
> 
> 	fork
> 	install delayed filters
> 	exec
> 	do some initialization
> 	activate delayed filters
> 	run
> 
> In practice, the two-stage filter application has been fine, if
> sometimes a bit complex (e.g. for user_notif, "do some initialization"
> includes figuring out how to pass the fd back to the supervisor, etc).

Yes, something like what you describe above would certainly make some
uses easier. Activate-on-exec seems to me the most compelling need
though..

>>           One way in which this could be done is by passing the file
>>           descriptor over a UNIX domain socket connection between the
>>           target and the supervisor (using the SCM_RIGHTS ancillary
>>           message type described in unix(7)).
>>
>>        3. The supervisor will receive notification events on the
>>           listening file descriptor.  These events are returned as
>>           structures of type seccomp_notif.  Because this structure and
>>           its size may evolve over kernel versions, the supervisor must
>>           first determine the size of this structure using the seccomp(2)
>>           SECCOMP_GET_NOTIF_SIZES operation, which returns a structure of
>>           type seccomp_notif_sizes.  The supervisor allocates a buffer of
>>           size seccomp_notif_sizes.seccomp_notif bytes to receive
>>           notification events.  In addition,the supervisor allocates
>>           another buffer of size seccomp_notif_sizes.seccomp_notif_resp
>>           bytes for the response (a struct seccomp_notif_resp structure)
>>           that it will provide to the kernel (and thus the target).
>>
>>        4. The target then performs its workload, which includes system
>>           calls that will be controlled by the seccomp filter.  Whenever
>>           one of these system calls causes the filter to return the
>>           SECCOMP_RET_USER_NOTIF action value, the kernel does not (yet)
>>           execute the system call; instead, execution of the target is
>>           temporarily blocked inside the kernel (in a sleep state that is
>>           interruptible by signals) and a notification event is generated
>>           on the listening file descriptor.
>>
>>        5. The supervisor can now repeatedly monitor the listening file
>>           descriptor for SECCOMP_RET_USER_NOTIF-triggered events.  To do
>>           this, the supervisor uses the SECCOMP_IOCTL_NOTIF_RECV ioctl(2)
>>           operation to read information about a notification event; this
>>           operation blocks until an event is available.  The operation
>>           returns a seccomp_notif structure containing information about
>>           the system call that is being attempted by the target.
>>
>>        6. The seccomp_notif structure returned by the
>>           SECCOMP_IOCTL_NOTIF_RECV operation includes the same
>>           information (a seccomp_data structure) that was passed to the
>>           seccomp filter.  This information allows the supervisor to
>>           discover the system call number and the arguments for the
>>           target's system call.  In addition, the notification event
>>           contains the ID of the thread that triggered the notification.
> 
> Should "cookie" be at least named here, just to provide a bit more
> context for when it is mentioned in 8 below? E.g.:
> 
> 			       ... In addition, the notification event
> 	    contains the triggering thread's ID and a unique cookie to be
> 	    used in subsequent SECCOMP_IOCTL_NOTIF_ID_VALID and
> 	    SECCOMP_IOCTL_NOTIF_SEND operations.

Good catch! Changed as you suggest. (And thanks so much for all
your suggested rewordings; that makes things *much* easier for me.)

>>           The information in the notification can be used to discover the
>>           values of pointer arguments for the target's system call.
>>           (This is something that can't be done from within a seccomp
>>           filter.)  One way in which the supervisor can do this is to
>>           open the corresponding /proc/[tid]/mem file (see proc(5)) and
>>           read bytes from the location that corresponds to one of the
>>           pointer arguments whose value is supplied in the notification
>>           event.  (The supervisor must be careful to avoid a race
>>           condition that can occur when doing this; see the description
>>           of the SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)
>>           In addition, the supervisor can access other system information
>>           that is visible in user space but which is not accessible from
>>           a seccomp filter.
>>
>>        7. Having obtained information as per the previous step, the
>>           supervisor may then choose to perform an action in response to
>>           the target's system call (which, as noted above, is not
>>           executed when the seccomp filter returns the
>>           SECCOMP_RET_USER_NOTIF action value).
>>
>>           One example use case here relates to containers.  The target
>>           may be located inside a container where it does not have
>>           sufficient capabilities to mount a filesystem in the
>>           container's mount namespace.  However, the supervisor may be a
>>           more privileged process that does have sufficient capabilities
>>           to perform the mount operation.
>>
>>        8. The supervisor then sends a response to the notification.  The
>>           information in this response is used by the kernel to construct
>>           a return value for the target's system call and provide a value
>>           that will be assigned to the errno variable of the target.
>>
>>           The response is sent using the SECCOMP_IOCTL_NOTIF_SEND
>>           ioctl(2) operation, which is used to transmit a
>>           seccomp_notif_resp structure to the kernel.  This structure
>>           includes a cookie value that the supervisor obtained in the
>>           seccomp_notif structure returned by the
>>           SECCOMP_IOCTL_NOTIF_RECV operation.  This cookie value allows
>>           the kernel to associate the response with the target.
> 
> Describing where the cookie came from seems like it should live in 6
> above. A reader would have to take this new info and figure out where
> SECCOMP_IOCTL_NOTIF_RECV was described and piece it together.

Yeah. I hate it when the documentation loses the reader like that :-}.

> With the
> suggestion to 6 above, maybe:
> 
>                                                      ... This structure
>             must include the cookie value that the supervisor obtained in
>             the seccomp_notif structure returned by the
> 	    SECCOMP_IOCTL_NOTIF_RECV operation, which allows the kernel
>             to associate the response with the target.

Great! Changed.

>>        9. Once the notification has been sent, the system call in the
>>           target thread unblocks, returning the information that was
>>           provided by the supervisor in the notification response.
>>
>>        As a variation on the last two steps, the supervisor can send a
>>        response that tells the kernel that it should execute the target
>>        thread's system call; see the discussion of
>>        SECCOMP_USER_NOTIF_FLAG_CONTINUE, below.
>>
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
>>               operation blocks until an event occurs.  The third ioctl(2)
>>               argument is a pointer to a structure of the following form
>>               which contains information about the event.  This structure
>>               must be zeroed out before the call.
>>
>>                   struct seccomp_notif {
>>                       __u64  id;              /* Cookie */
>>                       __u32  pid;             /* TID of target thread */
> 
> Should we rename this variable from pid to tid? Yes it's UAPI, but yay for
> anonymous unions:
> 
> struct seccomp_notif {
> 	__u64		id;		/* Cookie */
> 	union {
> 		__u32	pid;
> 		__u32	tid;		/* TID of target thread */
> 	};
> 	__u32  flags;			/* Currently unused (0) */
> 	struct seccomp_data data;	/* See seccomp(2) */
> };

Yes, it would be nice to make this change. But, already there
are so many places in the UAPI where the pid/tid is messed upp :-(.

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
>>                      • It can be used with the
>>                        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation to
>>                        verify that the target is still alive.
>>
>>                      • When returning a notification response to the
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
>>                      information about the system call that triggered the
>>                      notification.  This is the same structure that is
>>                      passed to the seccomp filter.  See seccomp(2) for
>>                      details of this structure.
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
>>                      notification information was being generated, or the
>>                      target's (blocked) system call was interrupted by a
>>                      signal handler.
>>
>>        SECCOMP_IOCTL_NOTIF_ID_VALID
>>               This operation can be used to check that a notification ID
>>               returned by an earlier SECCOMP_IOCTL_NOTIF_RECV operation
>>               is still valid (i.e., that the target still exists).
> 
> Maybe clarify a bit more, since it's covering more than just "is the
> target still alive", but also "is that syscall still waiting for a
> response":
> 
>                 is still valid (i.e., that the target still exists and
> 		the syscall is still blocked waiting for a response).

Thanks. I made it:

(i.e., that the target still exists and its system call
is still blocked waiting for a response).

>>               The third ioctl(2) argument is a pointer to the cookie (id)
>>               returned by the SECCOMP_IOCTL_NOTIF_RECV operation.
>>
>>               This operation is necessary to avoid race conditions that
>>               can occur when the pid returned by the
>>               SECCOMP_IOCTL_NOTIF_RECV operation terminates, and that
>>               process ID is reused by another process.  An example of
>>               this kind of race is the following
>>
>>               1. A notification is generated on the listening file
>>                  descriptor.  The returned seccomp_notif contains the TID
>>                  of the target thread (in the pid field of the
>>                  structure).
>>
>>               2. The target terminates.
>>
>>               3. Another thread or process is created on the system that
>>                  by chance reuses the TID that was freed when the target
>>                  terminated.
>>
>>               4. The supervisor open(2)s the /proc/[tid]/mem file for the
>>                  TID obtained in step 1, with the intention of (say)
>>                  inspecting the memory location(s) that containing the
>>                  argument(s) of the system call that triggered the
>>                  notification in step 1.
>>
>>               In the above scenario, the risk is that the supervisor may
>>               try to access the memory of a process other than the
>>               target.  This race can be avoided by following the call to
>>               open(2) with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to
>>               verify that the process that generated the notification is
>>               still alive.  (Note that if the target terminates after the
>>               latter step, a subsequent read(2) from the file descriptor
>>               may return 0, indicating end of file.)
>>
>>               On success (i.e., the notification ID is still valid), this
>>               operation returns 0.  On failure (i.e., the notification ID
>>               is no longer valid), -1 is returned, and errno is set to
>>               ENOENT.
>>
>>        SECCOMP_IOCTL_NOTIF_SEND
>>               This operation is used to send a notification response back
>>               to the kernel.  The third ioctl(2) argument of this
>>               structure is a pointer to a structure of the following
>>               form:
>>
>>                   struct seccomp_notif_resp {
>>                       __u64 id;               /* Cookie value */
>>                       __s64 val;              /* Success return value */
>>                       __s32 error;            /* 0 (success) or negative
>>                                                  error number */
>>                       __u32 flags;            /* See below */
>>                   };
>>
>>               The fields of this structure are as follows:
>>
>>               id     This is the cookie value that was obtained using the
>>                      SECCOMP_IOCTL_NOTIF_RECV operation.  This cookie
>>                      value allows the kernel to correctly associate this
>>                      response with the system call that triggered the
>>                      user-space notification.
>>
>>               val    This is the value that will be used for a spoofed
>>                      success return for the target's system call; see
>>                      below.
>>
>>               error  This is the value that will be used as the error
>>                      number (errno) for a spoofed error return for the
>>                      target's system call; see below.
>>
>>               flags  This is a bit mask that includes zero or more of the
>>                      following flags:
>>
>>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE (since Linux 5.5)
>>                             Tell the kernel to execute the target's
>>                             system call.
>>
>>               Two kinds of response are possible:
>>
>>               • A response to the kernel telling it to execute the
>>                 target's system call.  In this case, the flags field
>>                 includes SECCOMP_USER_NOTIF_FLAG_CONTINUE and the error
>>                 and val fields must be zero.
>>
>>                 This kind of response can be useful in cases where the
>>                 supervisor needs to do deeper analysis of the target's
>>                 system call than is possible from a seccomp filter (e.g.,
>>                 examining the values of pointer arguments), and, having
>>                 decided that the system call does not require emulation
>>                 by the supervisor, the supervisor wants the system call
>>                 to be executed normally in the target.
>>
>>                 The SECCOMP_USER_NOTIF_FLAG_CONTINUE flag should be used
>>                 with caution; see NOTES.
>>
>>               • A spoofed return value for the target's system call.  In
>>                 this case, the kernel does not execute the target's
>>                 system call, instead causing the system call to return a
>>                 spoofed value as specified by fields of the
>>                 seccomp_notif_resp structure.  The supervisor should set
>>                 the fields of this structure as follows:
>>
>>                 +  flags does not contain
>>                    SECCOMP_USER_NOTIF_FLAG_CONTINUE.
>>
>>                 +  error is set either to 0 for a spoofed "success"
>>                    return or to a negative error number for a spoofed
>>                    "failure" return.  In the former case, the kernel
>>                    causes the target's system call to return the value
>>                    specified in the val field.  In the later case, the
>>                    kernel causes the target's system call to return -1,
>>                    and errno is assigned the negated error value.
>>
>>                 +  val is set to a value that will be used as the return
>>                    value for a spoofed "success" return for the target's
>>                    system call.  The value in this field is ignored if
>>                    the error field contains a nonzero value.
> 
> Strictly speaking, this is architecture specific, but all architectures
> do it this way. Should seccomp enforce val == 0 when err != 0 ?

That seems a resonable check to add. Initially, I found the absence of
such a check confusing, since it left me wondering: have I understood
the kernel code correctly?

>>               On success, this operation returns 0; on failure, -1 is
>>               returned, and errno is set to indicate the cause of the
>>               error.  This operation can fail with the following errors:
>>
>>               EINPROGRESS
>>                      A response to this notification has already been
>>                      sent.
>>
>>               EINVAL An invalid value was specified in the flags field.
>>
>>               EINVAL The flags field contained
>>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE, and the error or
>>                      val field was not zero.
>>
>>               ENOENT The blocked system call in the target has been
>>                      interrupted by a signal handler or the target has
>>                      terminated.
>>
>> NOTES
>>    select()/poll()/epoll semantics
>>        The file descriptor returned when seccomp(2) is employed with the
>>        SECCOMP_FILTER_FLAG_NEW_LISTENER flag can be monitored using
>>        poll(2), epoll(7), and select(2).  These interfaces indicate that
>>        the file descriptor is ready as follows:
>>
>>        • When a notification is pending, these interfaces indicate that
>>          the file descriptor is readable.  Following such an indication,
>>          a subsequent SECCOMP_IOCTL_NOTIF_RECV ioctl(2) will not block,
>>          returning either information about a notification or else
>>          failing with the error EINTR if the target has been killed by a
>>          signal or its system call has been interrupted by a signal
>>          handler.
>>
>>        • After the notification has been received (i.e., by the
>>          SECCOMP_IOCTL_NOTIF_RECV ioctl(2) operation), these interfaces
>>          indicate that the file descriptor is writable, meaning that a
>>          notification response can be sent using the
>>          SECCOMP_IOCTL_NOTIF_SEND ioctl(2) operation.
>>
>>        • After the last thread using the filter has terminated and been
>>          reaped using waitpid(2) (or similar), the file descriptor
>>          indicates an end-of-file condition (readable in select(2);
>>          POLLHUP/EPOLLHUP in poll(2)/ epoll_wait(2)).
> 
> I'll reply separately about the "ioctl() does not terminate when all
> filters have terminated" case.

Okay.

>>    Design goals; use of SECCOMP_USER_NOTIF_FLAG_CONTINUE
>>        The intent of the user-space notification feature is to allow
>>        system calls to be performed on behalf of the target.  The
>>        target's system call should either be handled by the supervisor or
>>        allowed to continue normally in the kernel (where standard
>>        security policies will be applied).
>>
>>        Note well: this mechanism must not be used to make security policy
>>        decisions about the system call, which would be inherently race-
>>        prone for reasons described next.
>>
>>        The SECCOMP_USER_NOTIF_FLAG_CONTINUE flag must be used with
>>        caution.  If set by the supervisor, the target's system call will
>>        continue.  However, there is a time-of-check, time-of-use race
>>        here, since an attacker could exploit the interval of time where
>>        the target is blocked waiting on the "continue" response to do
>>        things such as rewriting the system call arguments.
>>
>>        Note furthermore that a user-space notifier can be bypassed if the
>>        existing filters allow the use of seccomp(2) or prctl(2) to
>>        install a filter that returns an action value with a higher
>>        precedence than SECCOMP_RET_USER_NOTIF (see seccomp(2)).
>>
>>        It should thus be absolutely clear that the seccomp user-space
>>        notification mechanism can not be used to implement a security
>>        policy!  It should only ever be used in scenarios where a more
>>        privileged process supervises the system calls of a lesser
>>        privileged target to get around kernel-enforced security
>>        restrictions when the supervisor deems this safe.  In other words,
>>        in order to continue a system call, the supervisor should be sure
>>        that another security mechanism or the kernel itself will
>>        sufficiently block the system call if its arguments are rewritten
>>        to something unsafe.
>>
>>    Interaction with SA_RESTART signal handlers
>>        Consider the following scenario:
>>
>>        • The target process has used sigaction(2) to install a signal
>>          handler with the SA_RESTART flag.
>>
>>        • The target has made a system call that triggered a seccomp user-
>>          space notification and the target is currently blocked until the
>>          supervisor sends a notification response.
>>
>>        • A signal is delivered to the target and the signal handler is
>>          executed.
>>
>>        • When (if) the supervisor attempts to send a notification
>>          response, the SECCOMP_IOCTL_NOTIF_SEND ioctl(2)) operation will
>>          fail with the ENOENT error.
>>
>>        In this scenario, the kernel will restart the target's system
>>        call.  Consequently, the supervisor will receive another user-
>>        space notification.  Thus, depending on how many times the blocked
>>        system call is interrupted by a signal handler, the supervisor may
>>        receive multiple notifications for the same system call in the
> 
> maybe "... for the same instance of a system call in the target." for
> clarity?

Yes, that's a nice clarification.

>>        target.
>>
>>        One oddity is that system call restarting as described in this
>>        scenario will occur even for the blocking system calls listed in
>>        signal(7) that would never normally be restarted by the SA_RESTART
>>        flag.
> 
> Does this need fixing? I imagine the correct behavior for this case
> would be a response to _SEND of EINPROGRESS and the target would see
> EINTR normally?

That sounds reasonable.

> I mean, it's not like seccomp doesn't already expose weirdness with
> syscall restarts. Not even arm64 compat agrees[3] with arm32 in this
> regard. :(

I've added the above comments as a FIXME in the page.

>> BUGS
>>        If a SECCOMP_IOCTL_NOTIF_RECV ioctl(2) operation is performed
>>        after the target terminates, then the ioctl(2) call simply blocks
>>        (rather than returning an error to indicate that the target no
>>        longer exists).
> 
> I want this fixed. It caused me no end of pain when building the
> selftests, and ended up spawning my implementing a global test timeout
> in kselftest. :P Before the usage counter refactor, there was no sane
> way to deal with this, but now I think we're close[2]. I'll reply
> separately about this.

Also added as FIXME comment in the page :-).

The behavior here is surprising, and caused me some
confusion until I worked out what was going on.

>> EXAMPLES
>>        The (somewhat contrived) program shown below demonstrates the use
>>        of the interfaces described in this page.  The program creates a
>>        child process that serves as the "target" process.  The child
>>        process installs a seccomp filter that returns the
>>        SECCOMP_RET_USER_NOTIF action value if a call is made to mkdir(2).
>>        The child process then calls mkdir(2) once for each of the
>>        supplied command-line arguments, and reports the result returned
>>        by the call.  After processing all arguments, the child process
>>        terminates.
>>
>>        The parent process acts as the supervisor, listening for the
>>        notifications that are generated when the target process calls
>>        mkdir(2).  When such a notification occurs, the supervisor
>>        examines the memory of the target process (using /proc/[pid]/mem)
>>        to discover the pathname argument that was supplied to the
>>        mkdir(2) call, and performs one of the following actions:
> 
> I like this example! It's simple enough to be understandable and complex
> enough to show the purpose of user_notif. :)

Precisely my aim. Thank you for noticing and appreciating :-).

>>        • If the pathname begins with the prefix "/tmp/", then the
>>          supervisor attempts to create the specified directory, and then
>>          spoofs a return for the target process based on the return value
>>          of the supervisor's mkdir(2) call.  In the event that that call
>>          succeeds, the spoofed success return value is the length of the
>>          pathname.
>>
>>        • If the pathname begins with "./" (i.e., it is a relative
>>          pathname), the supervisor sends a
>>          SECCOMP_USER_NOTIF_FLAG_CONTINUE response to the kernel to say
>>          that the kernel should execute the target process's mkdir(2)
>>          call.
>>
>>        • If the pathname begins with some other prefix, the supervisor
>>          spoofs an error return for the target process, so that the
>>          target process's mkdir(2) call appears to fail with the error
>>          EOPNOTSUPP ("Operation not supported").  Additionally, if the
>>          specified pathname is exactly "/bye", then the supervisor
>>          terminates.

[...]

>>    Program source
>>        #define _GNU_SOURCE
>>        #include <sys/types.h>
>>        #include <sys/prctl.h>
>>        #include <fcntl.h>
>>        #include <limits.h>
>>        #include <signal.h>
>>        #include <stddef.h>
>>        #include <stdint.h>
>>        #include <stdbool.h>
>>        #include <linux/audit.h>
>>        #include <sys/syscall.h>
>>        #include <sys/stat.h>
>>        #include <linux/filter.h>
>>        #include <linux/seccomp.h>
>>        #include <sys/ioctl.h>
>>        #include <stdio.h>
>>        #include <stdlib.h>
>>        #include <unistd.h>
>>        #include <errno.h>
>>        #include <sys/socket.h>
>>        #include <sys/un.h>
>>
>>        #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>>                                } while (0)
> 
> Because I love macros, you can expand this to make it take a format
> string:
> 
> #define errExit(fmt, ...)	do {					\
> 		char __err[64];						\
> 		strerror_r(errno, __err, sizeof(__err));		\
> 		fprintf(stderr, fmt ": %s\n", ##__VA_ARG__, __err);	\
> 		exit(EXIT_FAILURE);					\
> 	} while (0)

I'm a bit divivided about this. I don't want to distract the reader by
requiring them to understand the macro. I'll leave this for the moment.

[...]

>>        static void
>>        sigchldHandler(int sig)
>>        {
>>            char *msg  = "\tS: target has terminated; bye\n";
>>
>>            write(STDOUT_FILENO, msg, strlen(msg));
> 
> white space nit: extra space before "="

Thanks!

> efficiency nit: strlen isn't needed, since it can be done with
> compile-time constant constants:
> 
>              char msg[] = "\tS: target has terminated; bye\n";
>              write(STDOUT_FILENO, msg, sizeof(msg) - 1);
> 
> (some optimization levels may already replace the strlen a sizeof - 1)

Changed as you suggest. Thanks!

>>            _exit(EXIT_SUCCESS);
>>        }

[...]

>>        static void
>>        checkNotificationIdIsValid(int notifyFd, uint64_t id)
>>        {
>>            if (ioctl(notifyFd, SECCOMP_IOCTL_NOTIF_ID_VALID, &id) == -1) {
>>                fprintf(stderr, "\tS: notification ID check: "
>>                        "target has terminated!!!\n");
>>
>>                exit(EXIT_FAILURE);
> 
> And now you can do:
> 
> 		errExit("\tS: notification ID check: "
> 			"target has terminated! ioctl");
> 
> ;)

Thanks. Changed as you suggest.

>>            }
>>        }
>>
>>        /* Access the memory of the target process in order to discover the
>>           pathname that was given to mkdir() */
>>
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
>>            /* Read bytes at the location containing the pathname argument
>>               (i.e., the first argument) of the mkdir(2) call */
>>
>>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>>            if (nread == -1)
>>                errExit("pread");
>>
>>            if (nread == 0) {
>>                fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>>                        "returned 0 (EOF)\n");
>>                exit(EXIT_FAILURE);
>>            }
>>
>>            if (close(procMemFd) == -1)
>>                errExit("close-/proc/PID/mem");
>>
>>            /* We have no guarantees about what was in the memory of the target
>>               process. We therefore treat the buffer returned by pread() as
>>               untrusted input. The buffer should be terminated by a null byte;
>>               if not, then we will trigger an error for the target process. */
>>
>>            for (int j = 0; j < nread; j++)
>>                if (path[j] == ' ')
> 
> This rendering typo (' ' vs '\0') ends up manifesting badly. ;) The man
> source shows:
> 
>         if (path[j] == \(aq\0\(aq)
> 
> I think this needs to be \\0 ?

Yes, that was the intention.

> Or it could also be a tested as:
> 
> 	if (strnlen(path, nread) < nread)
>

Good point. Changed to:

    if (strnlen(path, nread) < nread)
        return true;

[...]

> 
> Thank you so much for this documentation and example! :)

You're welcome. It's been "interesting" uncovering the glitches :-).

Cheers,

Michael


> [1] https://git.kernel.org/linus/dfe719fef03d752f1682fa8aeddf30ba501c8555
> [2] https://lore.kernel.org/lkml/CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CAGXu5jKzif=vp6gn5ZtrTx-JTN367qFphobnt9s=awbaafwoUw@mail.gmail.com/
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
