Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A052529851C
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 01:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420797AbgJZAVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Oct 2020 20:21:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43645 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420796AbgJZATu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Oct 2020 20:19:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id a200so5191046pfa.10
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2020 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZZ2a4aOmPjyQjPWSse0Y9NGMYSnUn8G3zEmlqVOLMFc=;
        b=dDktHPh1RGN624IjgTdeCk991cxycw5WvnOSaWkqtnSZAjdcKDbvAP2OF3D1ECVjAl
         eqepqpN0AxzpG3OWPp5xHKcAeXyl4Z4ZV26WQEUl4Bra0e9/GHYQjLogFkam4oQY4xKD
         QSPEN+Q0tvE02IyLA0WOV0Fa4X6UQB6YWZP+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZZ2a4aOmPjyQjPWSse0Y9NGMYSnUn8G3zEmlqVOLMFc=;
        b=EeMPjAIzwbfsoIypa4ro9BZrC7Qxl8t5lydUAyLPdfiCCw/MMtJRF4/z0D2FarxJLH
         Bu+NYWM1IF8BVMVb5ziZ9yIlztWm5a2Ga9u1u0Qv6MqdP4LrqTksq4w9s+b9ifWcPJL3
         qfh/Jur4osAH1yLn9wYjfo8adeMcoqV4sxhOWxpWetgXCp+51P2dXbFUcQpn5tx/9gbH
         MdkL8ese++fgLYuQw40tC804xhD+SPQcUwftxtAMS7oE2v/nYgxFlip61X/6Uo5FaUn/
         fSJvMxfwUOjB7I3eg/eN39fOVrI8rqLSsZCAb+oIhlwORIsOnkkvMxyr89MmUysjjgM3
         i8CQ==
X-Gm-Message-State: AOAM532nhgYo+UWVxPA7aNcKYCuN3VUKP1ny+8fciHixBpUKiBGP5mR3
        G1oUECc3xs4zv6KOGSXWOlTk/w==
X-Google-Smtp-Source: ABdhPJxjlEz21at3a78MBRzgHi7GljicYmNqfcTeN3KUjQ8xXnALihf+MYh/wD7/glH3jV3TUCgP+Q==
X-Received: by 2002:a62:5c06:0:b029:160:1b43:14ed with SMTP id q6-20020a625c060000b02901601b4314edmr9205604pfb.11.1603671586067;
        Sun, 25 Oct 2020 17:19:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm10041350pjq.42.2020.10.25.17.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 17:19:44 -0700 (PDT)
Date:   Sun, 25 Oct 2020 17:19:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
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
Message-ID: <202010250759.F9745E0B6@keescook>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <202009301632.9C6A850272@keescook>
 <c1cc0df8-bd06-51e7-d5a0-888c1955683b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1cc0df8-bd06-51e7-d5a0-888c1955683b@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 15, 2020 at 01:24:03PM +0200, Michael Kerrisk (man-pages) wrote:
> On 10/1/20 1:39 AM, Kees Cook wrote:
> > I'll comment more later, but I've run out of time today and I didn't see
> > anyone mention this detail yet in the existing threads... :)
> 
> Later never came :-). But, I hope you may have comments for the 
> next draft, which I will send out soon.

Later is now, and Soon approaches!

I finally caught up and read through this whole thread. Thank you all
for the bug fix[1], and I'm looking forward to more[2]. :)

For my reply I figured I'd base it on the current draft, so here's a
simulated quote based on the seccomp_user_notif branch of
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
through commit 71101158fe330af5a26552447a0bb433b69e15b7
$ COLUMNS=75 man --nh --nj man2/seccomp_user_notif.2 | sed 's/^/> /'

On Sun, Oct 25, 2020 at 01:54:05PM +0100, Michael Kerrisk (man-pages) wrote:
> SECCOMP_USER_NOTIF(2)   Linux Programmer's Manual   SECCOMP_USER_NOTIF(2)
> 
> NAME
>        seccomp_user_notif - Seccomp user-space notification mechanism
> 
> SYNOPSIS
>        #include <linux/seccomp.h>
>        #include <linux/filter.h>
>        #include <linux/audit.h>
> 
>        int seccomp(unsigned int operation, unsigned int flags, void *args);
> 
>        #include <sys/ioctl.h>
> 
>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_RECV,
>                  struct seccomp_notif *req);
>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_SEND,
>                  struct seccomp_notif_resp *resp);
>        int ioctl(int fd, SECCOMP_IOCTL_NOTIF_ID_VALID, __u64 *id);
> 
> DESCRIPTION
>        This page describes the user-space notification mechanism provided
>        by the Secure Computing (seccomp) facility.  As well as the use of
>        the SECCOMP_FILTER_FLAG_NEW_LISTENER flag, the
>        SECCOMP_RET_USER_NOTIF action value, and the
>        SECCOMP_GET_NOTIF_SIZES operation described in seccomp(2), this
>        mechanism involves the use of a number of related ioctl(2)
>        operations (described below).
> 
>    Overview
>        In conventional usage of a seccomp filter, the decision about how
>        to treat a system call is made by the filter itself.  By contrast,
>        the user-space notification mechanism allows the seccomp filter to
>        delegate the handling of the system call to another user-space
>        process.  Note that this mechanism is explicitly not intended as a
>        method implementing security policy; see NOTES.
> 
>        In the discussion that follows, the thread(s) on which the seccomp
>        filter is installed is (are) referred to as the target, and the
>        process that is notified by the user-space notification mechanism
>        is referred to as the supervisor.
> 
>        A suitably privileged supervisor can use the user-space
>        notification mechanism to perform actions on behalf of the target.
>        The advantage of the user-space notification mechanism is that the
>        supervisor will usually be able to retrieve information about the
>        target and the performed system call that the seccomp filter
>        itself cannot.  (A seccomp filter is limited in the information it
>        can obtain and the actions that it can perform because it is
>        running on a virtual machine inside the kernel.)
> 
>        An overview of the steps performed by the target and the
>        supervisor is as follows:
> 
>        1. The target establishes a seccomp filter in the usual manner,
>           but with two differences:
> 
>           • The seccomp(2) flags argument includes the flag
>             SECCOMP_FILTER_FLAG_NEW_LISTENER.  Consequently, the return
>             value  of the (successful) seccomp(2) call is a new

nit: extra space

>             "listening" file descriptor that can be used to receive
>             notifications.  Only one "listening" seccomp filter can be
>             installed for a thread.

I like this limitation, but I expect that it'll need to change in the
future. Even with LSMs, we see the need for arbitrary stacking, and the
idea of there being only 1 supervisor will eventually break down. Right
now there is only 1 because only container managers are using this
feature. But if some daemon starts using it to isolate some thread,
suddenly it might break if a container manager is trying to listen to it
too, etc. I expect it won't be needed soon, but I do think it'll change.

> 
>           • In cases where it is appropriate, the seccomp filter returns
>             the action value SECCOMP_RET_USER_NOTIF.  This return value
>             will trigger a notification event.
> 
>        2. In order that the supervisor can obtain notifications using the
>           listening file descriptor, (a duplicate of) that file
>           descriptor must be passed from the target to the supervisor.

Yet another reason to have an "activate on exec" mode for seccomp. With
no_new_privs _not_ being delayed in such a way, I think it'd be safe to
add. The supervisor would get the fd immediately, and then once it
fork/execed suddenly the whole thing would activate, and no fd passing
needed.

The "on exec" boundary is really only needed for oblivious targets. For
a coordinated target, I've thought it might be nice to have an arbitrary
"go" point, where the target could call seccomp() with something like a
SECCOMP_ACTIVATE_DELAYED_FILTERS operation. This lets any process
initialization happen that might need to do things that would be blocked
by filters, etc.

Before:

	fork
	install some filters that don't block initialization
	exec
	do some initialization
	install more filters, maybe block exec, seccomp
	run

After:

	fork
	install delayed filters
	exec
	do some initialization
	activate delayed filters
	run

In practice, the two-stage filter application has been fine, if
sometimes a bit complex (e.g. for user_notif, "do some initialization"
includes figuring out how to pass the fd back to the supervisor, etc).

>           One way in which this could be done is by passing the file
>           descriptor over a UNIX domain socket connection between the
>           target and the supervisor (using the SCM_RIGHTS ancillary
>           message type described in unix(7)).
> 
>        3. The supervisor will receive notification events on the
>           listening file descriptor.  These events are returned as
>           structures of type seccomp_notif.  Because this structure and
>           its size may evolve over kernel versions, the supervisor must
>           first determine the size of this structure using the seccomp(2)
>           SECCOMP_GET_NOTIF_SIZES operation, which returns a structure of
>           type seccomp_notif_sizes.  The supervisor allocates a buffer of
>           size seccomp_notif_sizes.seccomp_notif bytes to receive
>           notification events.  In addition,the supervisor allocates
>           another buffer of size seccomp_notif_sizes.seccomp_notif_resp
>           bytes for the response (a struct seccomp_notif_resp structure)
>           that it will provide to the kernel (and thus the target).
> 
>        4. The target then performs its workload, which includes system
>           calls that will be controlled by the seccomp filter.  Whenever
>           one of these system calls causes the filter to return the
>           SECCOMP_RET_USER_NOTIF action value, the kernel does not (yet)
>           execute the system call; instead, execution of the target is
>           temporarily blocked inside the kernel (in a sleep state that is
>           interruptible by signals) and a notification event is generated
>           on the listening file descriptor.
> 
>        5. The supervisor can now repeatedly monitor the listening file
>           descriptor for SECCOMP_RET_USER_NOTIF-triggered events.  To do
>           this, the supervisor uses the SECCOMP_IOCTL_NOTIF_RECV ioctl(2)
>           operation to read information about a notification event; this
>           operation blocks until an event is available.  The operation
>           returns a seccomp_notif structure containing information about
>           the system call that is being attempted by the target.
> 
>        6. The seccomp_notif structure returned by the
>           SECCOMP_IOCTL_NOTIF_RECV operation includes the same
>           information (a seccomp_data structure) that was passed to the
>           seccomp filter.  This information allows the supervisor to
>           discover the system call number and the arguments for the
>           target's system call.  In addition, the notification event
>           contains the ID of the thread that triggered the notification.

Should "cookie" be at least named here, just to provide a bit more
context for when it is mentioned in 8 below? E.g.:

			       ... In addition, the notification event
	    contains the triggering thread's ID and a unique cookie to be
	    used in subsequent SECCOMP_IOCTL_NOTIF_ID_VALID and
	    SECCOMP_IOCTL_NOTIF_SEND operations.

> 
>           The information in the notification can be used to discover the
>           values of pointer arguments for the target's system call.
>           (This is something that can't be done from within a seccomp
>           filter.)  One way in which the supervisor can do this is to
>           open the corresponding /proc/[tid]/mem file (see proc(5)) and
>           read bytes from the location that corresponds to one of the
>           pointer arguments whose value is supplied in the notification
>           event.  (The supervisor must be careful to avoid a race
>           condition that can occur when doing this; see the description
>           of the SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)
>           In addition, the supervisor can access other system information
>           that is visible in user space but which is not accessible from
>           a seccomp filter.
> 
>        7. Having obtained information as per the previous step, the
>           supervisor may then choose to perform an action in response to
>           the target's system call (which, as noted above, is not
>           executed when the seccomp filter returns the
>           SECCOMP_RET_USER_NOTIF action value).
> 
>           One example use case here relates to containers.  The target
>           may be located inside a container where it does not have
>           sufficient capabilities to mount a filesystem in the
>           container's mount namespace.  However, the supervisor may be a
>           more privileged process that does have sufficient capabilities
>           to perform the mount operation.
> 
>        8. The supervisor then sends a response to the notification.  The
>           information in this response is used by the kernel to construct
>           a return value for the target's system call and provide a value
>           that will be assigned to the errno variable of the target.
> 
>           The response is sent using the SECCOMP_IOCTL_NOTIF_SEND
>           ioctl(2) operation, which is used to transmit a
>           seccomp_notif_resp structure to the kernel.  This structure
>           includes a cookie value that the supervisor obtained in the
>           seccomp_notif structure returned by the
>           SECCOMP_IOCTL_NOTIF_RECV operation.  This cookie value allows
>           the kernel to associate the response with the target.

Describing where the cookie came from seems like it should live in 6
above. A reader would have to take this new info and figure out where
SECCOMP_IOCTL_NOTIF_RECV was described and piece it together. With the
suggestion to 6 above, maybe:

                                                     ... This structure
            must include the cookie value that the supervisor obtained in
            the seccomp_notif structure returned by the
	    SECCOMP_IOCTL_NOTIF_RECV operation, which allows the kernel
            to associate the response with the target.

> 
>        9. Once the notification has been sent, the system call in the
>           target thread unblocks, returning the information that was
>           provided by the supervisor in the notification response.
> 
>        As a variation on the last two steps, the supervisor can send a
>        response that tells the kernel that it should execute the target
>        thread's system call; see the discussion of
>        SECCOMP_USER_NOTIF_FLAG_CONTINUE, below.
> 
>    ioctl(2) operations
>        The following ioctl(2) operations are provided to support seccomp
>        user-space notification.  For each of these operations, the first
>        (file descriptor) argument of ioctl(2) is the listening file
>        descriptor returned by a call to seccomp(2) with the
>        SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
> 
>        SECCOMP_IOCTL_NOTIF_RECV
>               This operation is used to obtain a user-space notification
>               event.  If no such event is currently pending, the
>               operation blocks until an event occurs.  The third ioctl(2)
>               argument is a pointer to a structure of the following form
>               which contains information about the event.  This structure
>               must be zeroed out before the call.
> 
>                   struct seccomp_notif {
>                       __u64  id;              /* Cookie */
>                       __u32  pid;             /* TID of target thread */

Should we rename this variable from pid to tid? Yes it's UAPI, but yay for
anonymous unions:

struct seccomp_notif {
	__u64		id;		/* Cookie */
	union {
		__u32	pid;
		__u32	tid;		/* TID of target thread */
	};
	__u32  flags;			/* Currently unused (0) */
	struct seccomp_data data;	/* See seccomp(2) */
};

>                       __u32  flags;           /* Currently unused (0) */
>                       struct seccomp_data data;   /* See seccomp(2) */
>                   };
> 
>               The fields in this structure are as follows:
> 
>               id     This is a cookie for the notification.  Each such
>                      cookie is guaranteed to be unique for the
>                      corresponding seccomp filter.
> 
>                      • It can be used with the
>                        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation to
>                        verify that the target is still alive.
> 
>                      • When returning a notification response to the
>                        kernel, the supervisor must include the cookie
>                        value in the seccomp_notif_resp structure that is
>                        specified as the argument of the
>                        SECCOMP_IOCTL_NOTIF_SEND operation.
> 
>               pid    This is the thread ID of the target thread that
>                      triggered the notification event.
> 
>               flags  This is a bit mask of flags providing further
>                      information on the event.  In the current
>                      implementation, this field is always zero.
> 
>               data   This is a seccomp_data structure containing
>                      information about the system call that triggered the
>                      notification.  This is the same structure that is
>                      passed to the seccomp filter.  See seccomp(2) for
>                      details of this structure.
> 
>               On success, this operation returns 0; on failure, -1 is
>               returned, and errno is set to indicate the cause of the
>               error.  This operation can fail with the following errors:
> 
>               EINVAL (since Linux 5.5)
>                      The seccomp_notif structure that was passed to the
>                      call contained nonzero fields.
> 
>               ENOENT The target thread was killed by a signal as the
>                      notification information was being generated, or the
>                      target's (blocked) system call was interrupted by a
>                      signal handler.
> 
>        SECCOMP_IOCTL_NOTIF_ID_VALID
>               This operation can be used to check that a notification ID
>               returned by an earlier SECCOMP_IOCTL_NOTIF_RECV operation
>               is still valid (i.e., that the target still exists).

Maybe clarify a bit more, since it's covering more than just "is the
target still alive", but also "is that syscall still waiting for a
response":

                is still valid (i.e., that the target still exists and
		the syscall is still blocked waiting for a response).


> 
>               The third ioctl(2) argument is a pointer to the cookie (id)
>               returned by the SECCOMP_IOCTL_NOTIF_RECV operation.
> 
>               This operation is necessary to avoid race conditions that
>               can occur when the pid returned by the
>               SECCOMP_IOCTL_NOTIF_RECV operation terminates, and that
>               process ID is reused by another process.  An example of
>               this kind of race is the following
> 
>               1. A notification is generated on the listening file
>                  descriptor.  The returned seccomp_notif contains the TID
>                  of the target thread (in the pid field of the
>                  structure).
> 
>               2. The target terminates.
> 
>               3. Another thread or process is created on the system that
>                  by chance reuses the TID that was freed when the target
>                  terminated.
> 
>               4. The supervisor open(2)s the /proc/[tid]/mem file for the
>                  TID obtained in step 1, with the intention of (say)
>                  inspecting the memory location(s) that containing the
>                  argument(s) of the system call that triggered the
>                  notification in step 1.
> 
>               In the above scenario, the risk is that the supervisor may
>               try to access the memory of a process other than the
>               target.  This race can be avoided by following the call to
>               open(2) with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to
>               verify that the process that generated the notification is
>               still alive.  (Note that if the target terminates after the
>               latter step, a subsequent read(2) from the file descriptor
>               may return 0, indicating end of file.)
> 
>               On success (i.e., the notification ID is still valid), this
>               operation returns 0.  On failure (i.e., the notification ID
>               is no longer valid), -1 is returned, and errno is set to
>               ENOENT.
> 
>        SECCOMP_IOCTL_NOTIF_SEND
>               This operation is used to send a notification response back
>               to the kernel.  The third ioctl(2) argument of this
>               structure is a pointer to a structure of the following
>               form:
> 
>                   struct seccomp_notif_resp {
>                       __u64 id;               /* Cookie value */
>                       __s64 val;              /* Success return value */
>                       __s32 error;            /* 0 (success) or negative
>                                                  error number */
>                       __u32 flags;            /* See below */
>                   };
> 
>               The fields of this structure are as follows:
> 
>               id     This is the cookie value that was obtained using the
>                      SECCOMP_IOCTL_NOTIF_RECV operation.  This cookie
>                      value allows the kernel to correctly associate this
>                      response with the system call that triggered the
>                      user-space notification.
> 
>               val    This is the value that will be used for a spoofed
>                      success return for the target's system call; see
>                      below.
> 
>               error  This is the value that will be used as the error
>                      number (errno) for a spoofed error return for the
>                      target's system call; see below.
> 
>               flags  This is a bit mask that includes zero or more of the
>                      following flags:
> 
>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE (since Linux 5.5)
>                             Tell the kernel to execute the target's
>                             system call.
> 
>               Two kinds of response are possible:
> 
>               • A response to the kernel telling it to execute the
>                 target's system call.  In this case, the flags field
>                 includes SECCOMP_USER_NOTIF_FLAG_CONTINUE and the error
>                 and val fields must be zero.
> 
>                 This kind of response can be useful in cases where the
>                 supervisor needs to do deeper analysis of the target's
>                 system call than is possible from a seccomp filter (e.g.,
>                 examining the values of pointer arguments), and, having
>                 decided that the system call does not require emulation
>                 by the supervisor, the supervisor wants the system call
>                 to be executed normally in the target.
> 
>                 The SECCOMP_USER_NOTIF_FLAG_CONTINUE flag should be used
>                 with caution; see NOTES.
> 
>               • A spoofed return value for the target's system call.  In
>                 this case, the kernel does not execute the target's
>                 system call, instead causing the system call to return a
>                 spoofed value as specified by fields of the
>                 seccomp_notif_resp structure.  The supervisor should set
>                 the fields of this structure as follows:
> 
>                 +  flags does not contain
>                    SECCOMP_USER_NOTIF_FLAG_CONTINUE.
> 
>                 +  error is set either to 0 for a spoofed "success"
>                    return or to a negative error number for a spoofed
>                    "failure" return.  In the former case, the kernel
>                    causes the target's system call to return the value
>                    specified in the val field.  In the later case, the
>                    kernel causes the target's system call to return -1,
>                    and errno is assigned the negated error value.
> 
>                 +  val is set to a value that will be used as the return
>                    value for a spoofed "success" return for the target's
>                    system call.  The value in this field is ignored if
>                    the error field contains a nonzero value.

Strictly speaking, this is architecture specific, but all architectures
do it this way. Should seccomp enforce val == 0 when err != 0 ?

> 
>               On success, this operation returns 0; on failure, -1 is
>               returned, and errno is set to indicate the cause of the
>               error.  This operation can fail with the following errors:
> 
>               EINPROGRESS
>                      A response to this notification has already been
>                      sent.
> 
>               EINVAL An invalid value was specified in the flags field.
> 
>               EINVAL The flags field contained
>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE, and the error or
>                      val field was not zero.
> 
>               ENOENT The blocked system call in the target has been
>                      interrupted by a signal handler or the target has
>                      terminated.
> 
> NOTES
>    select()/poll()/epoll semantics
>        The file descriptor returned when seccomp(2) is employed with the
>        SECCOMP_FILTER_FLAG_NEW_LISTENER flag can be monitored using
>        poll(2), epoll(7), and select(2).  These interfaces indicate that
>        the file descriptor is ready as follows:
> 
>        • When a notification is pending, these interfaces indicate that
>          the file descriptor is readable.  Following such an indication,
>          a subsequent SECCOMP_IOCTL_NOTIF_RECV ioctl(2) will not block,
>          returning either information about a notification or else
>          failing with the error EINTR if the target has been killed by a
>          signal or its system call has been interrupted by a signal
>          handler.
> 
>        • After the notification has been received (i.e., by the
>          SECCOMP_IOCTL_NOTIF_RECV ioctl(2) operation), these interfaces
>          indicate that the file descriptor is writable, meaning that a
>          notification response can be sent using the
>          SECCOMP_IOCTL_NOTIF_SEND ioctl(2) operation.
> 
>        • After the last thread using the filter has terminated and been
>          reaped using waitpid(2) (or similar), the file descriptor
>          indicates an end-of-file condition (readable in select(2);
>          POLLHUP/EPOLLHUP in poll(2)/ epoll_wait(2)).

I'll reply separately about the "ioctl() does not terminate when all
filters have terminated" case.

> 
>    Design goals; use of SECCOMP_USER_NOTIF_FLAG_CONTINUE
>        The intent of the user-space notification feature is to allow
>        system calls to be performed on behalf of the target.  The
>        target's system call should either be handled by the supervisor or
>        allowed to continue normally in the kernel (where standard
>        security policies will be applied).
> 
>        Note well: this mechanism must not be used to make security policy
>        decisions about the system call, which would be inherently race-
>        prone for reasons described next.
> 
>        The SECCOMP_USER_NOTIF_FLAG_CONTINUE flag must be used with
>        caution.  If set by the supervisor, the target's system call will
>        continue.  However, there is a time-of-check, time-of-use race
>        here, since an attacker could exploit the interval of time where
>        the target is blocked waiting on the "continue" response to do
>        things such as rewriting the system call arguments.
> 
>        Note furthermore that a user-space notifier can be bypassed if the
>        existing filters allow the use of seccomp(2) or prctl(2) to
>        install a filter that returns an action value with a higher
>        precedence than SECCOMP_RET_USER_NOTIF (see seccomp(2)).
> 
>        It should thus be absolutely clear that the seccomp user-space
>        notification mechanism can not be used to implement a security
>        policy!  It should only ever be used in scenarios where a more
>        privileged process supervises the system calls of a lesser
>        privileged target to get around kernel-enforced security
>        restrictions when the supervisor deems this safe.  In other words,
>        in order to continue a system call, the supervisor should be sure
>        that another security mechanism or the kernel itself will
>        sufficiently block the system call if its arguments are rewritten
>        to something unsafe.
> 
>    Interaction with SA_RESTART signal handlers
>        Consider the following scenario:
> 
>        • The target process has used sigaction(2) to install a signal
>          handler with the SA_RESTART flag.
> 
>        • The target has made a system call that triggered a seccomp user-
>          space notification and the target is currently blocked until the
>          supervisor sends a notification response.
> 
>        • A signal is delivered to the target and the signal handler is
>          executed.
> 
>        • When (if) the supervisor attempts to send a notification
>          response, the SECCOMP_IOCTL_NOTIF_SEND ioctl(2)) operation will
>          fail with the ENOENT error.
> 
>        In this scenario, the kernel will restart the target's system
>        call.  Consequently, the supervisor will receive another user-
>        space notification.  Thus, depending on how many times the blocked
>        system call is interrupted by a signal handler, the supervisor may
>        receive multiple notifications for the same system call in the

maybe "... for the same instance of a system call in the target." for
clarity?

>        target.
> 
>        One oddity is that system call restarting as described in this
>        scenario will occur even for the blocking system calls listed in
>        signal(7) that would never normally be restarted by the SA_RESTART
>        flag.

Does this need fixing? I imagine the correct behavior for this case
would be a response to _SEND of EINPROGRESS and the target would see
EINTR normally?

I mean, it's not like seccomp doesn't already expose weirdness with
syscall restarts. Not even arm64 compat agrees[3] with arm32 in this
regard. :(

> BUGS
>        If a SECCOMP_IOCTL_NOTIF_RECV ioctl(2) operation is performed
>        after the target terminates, then the ioctl(2) call simply blocks
>        (rather than returning an error to indicate that the target no
>        longer exists).

I want this fixed. It caused me no end of pain when building the
selftests, and ended up spawning my implementing a global test timeout
in kselftest. :P Before the usage counter refactor, there was no sane
way to deal with this, but now I think we're close[2]. I'll reply
separately about this.

> 
> EXAMPLES
>        The (somewhat contrived) program shown below demonstrates the use
>        of the interfaces described in this page.  The program creates a
>        child process that serves as the "target" process.  The child
>        process installs a seccomp filter that returns the
>        SECCOMP_RET_USER_NOTIF action value if a call is made to mkdir(2).
>        The child process then calls mkdir(2) once for each of the
>        supplied command-line arguments, and reports the result returned
>        by the call.  After processing all arguments, the child process
>        terminates.
> 
>        The parent process acts as the supervisor, listening for the
>        notifications that are generated when the target process calls
>        mkdir(2).  When such a notification occurs, the supervisor
>        examines the memory of the target process (using /proc/[pid]/mem)
>        to discover the pathname argument that was supplied to the
>        mkdir(2) call, and performs one of the following actions:

I like this example! It's simple enough to be understandable and complex
enough to show the purpose of user_notif. :)

> 
>        • If the pathname begins with the prefix "/tmp/", then the
>          supervisor attempts to create the specified directory, and then
>          spoofs a return for the target process based on the return value
>          of the supervisor's mkdir(2) call.  In the event that that call
>          succeeds, the spoofed success return value is the length of the
>          pathname.
> 
>        • If the pathname begins with "./" (i.e., it is a relative
>          pathname), the supervisor sends a
>          SECCOMP_USER_NOTIF_FLAG_CONTINUE response to the kernel to say
>          that the kernel should execute the target process's mkdir(2)
>          call.
> 
>        • If the pathname begins with some other prefix, the supervisor
>          spoofs an error return for the target process, so that the
>          target process's mkdir(2) call appears to fail with the error
>          EOPNOTSUPP ("Operation not supported").  Additionally, if the
>          specified pathname is exactly "/bye", then the supervisor
>          terminates.
> 
>        This program can be used to demonstrate various aspects of the
>        behavior of the seccomp user-space notification mechanism.  To
>        help aid such demonstrations, the program logs various messages to
>        show the operation of the target process (lines prefixed "T:") and
>        the supervisor (indented lines prefixed "S:").
> 
>        In the following example, the target attempts to create the
>        directory /tmp/x.  Upon receiving the notification, the supervisor
>        creates the directory on the target's behalf, and spoofs a success
>        return to be received by the target process's mkdir(2) call.
> 
>            $ ./seccomp_unotify /tmp/x
>            T: PID = 23168
> 
>            T: about to mkdir("/tmp/x")
>                    S: got notification (ID 0x17445c4a0f4e0e3c) for PID 23168
>                    S: executing: mkdir("/tmp/x", 0700)
>                    S: success! spoofed return = 6
>                    S: sending response (flags = 0; val = 6; error = 0)
>            T: SUCCESS: mkdir(2) returned 6
> 
>            T: terminating
>                    S: target has terminated; bye
> 
>        In the above output, note that the spoofed return value seen by
>        the target process is 6 (the length of the pathname /tmp/x),
>        whereas a normal mkdir(2) call returns 0 on success.
> 
>        In the next example, the target attempts to create a directory
>        using the relative pathname ./sub.  Since this pathname starts
>        with "./", the supervisor sends a SECCOMP_USER_NOTIF_FLAG_CONTINUE
>        response to the kernel, and the kernel then (successfully)
>        executes the target process's mkdir(2) call.
> 
>            $ ./seccomp_unotify ./sub
>            T: PID = 23204
> 
>            T: about to mkdir("./sub")
>                    S: got notification (ID 0xddb16abe25b4c12) for PID 23204
>                    S: target can execute system call
>                    S: sending response (flags = 0x1; val = 0; error = 0)
>            T: SUCCESS: mkdir(2) returned 0
> 
>            T: terminating
>                    S: target has terminated; bye
> 
>        If the target process attempts to create a directory with a
>        pathname that doesn't start with "." and doesn't begin with the
>        prefix "/tmp/", then the supervisor spoofs an error return
>        (EOPNOTSUPP, "Operation not  supported") for the target's mkdir(2)
>        call (which is not executed):
> 
>            $ ./seccomp_unotify /xxx
>            T: PID = 23178
> 
>            T: about to mkdir("/xxx")
>                    S: got notification (ID 0xe7dc095d1c524e80) for PID 23178
>                    S: spoofing error response (Operation not supported)
>                    S: sending response (flags = 0; val = 0; error = -95)
>            T: ERROR: mkdir(2): Operation not supported
> 
>            T: terminating
>                    S: target has terminated; bye
> 
>        In the next example, the target process attempts to create a
>        directory with the pathname /tmp/nosuchdir/b.  Upon receiving the
>        notification, the supervisor attempts to create that directory,
>        but the mkdir(2) call fails because the directory /tmp/nosuchdir
>        does not exist.  Consequently, the supervisor spoofs an error
>        return that passes the error that it received back to the target
>        process's mkdir(2) call.
> 
>            $ ./seccomp_unotify /tmp/nosuchdir/b
>            T: PID = 23199
> 
>            T: about to mkdir("/tmp/nosuchdir/b")
>                    S: got notification (ID 0x8744454293506046) for PID 23199
>                    S: executing: mkdir("/tmp/nosuchdir/b", 0700)
>                    S: failure! (errno = 2; No such file or directory)
>                    S: sending response (flags = 0; val = 0; error = -2)
>            T: ERROR: mkdir(2): No such file or directory
> 
>            T: terminating
>                    S: target has terminated; bye
> 
>        If the supervisor receives a notification and sees that the
>        argument of the target's mkdir(2) is the string "/bye", then (as
>        well as spoofing an EOPNOTSUPP error), the supervisor terminates.
>        If the target process subsequently executes another mkdir(2) that
>        triggers its seccomp filter to return the SECCOMP_RET_USER_NOTIF
>        action value, then the kernel causes the target process's system
>        call to fail with the error ENOSYS ("Function not implemented").
>        This is demonstrated by the following example:
> 
>            $ ./seccomp_unotify /bye /tmp/y
>            T: PID = 23185
> 
>            T: about to mkdir("/bye")
>                    S: got notification (ID 0xa81236b1d2f7b0f4) for PID 23185
>                    S: spoofing error response (Operation not supported)
>                    S: sending response (flags = 0; val = 0; error = -95)
>                    S: terminating **********
>            T: ERROR: mkdir(2): Operation not supported
> 
>            T: about to mkdir("/tmp/y")
>            T: ERROR: mkdir(2): Function not implemented
> 
>            T: terminating
> 
>    Program source
>        #define _GNU_SOURCE
>        #include <sys/types.h>
>        #include <sys/prctl.h>
>        #include <fcntl.h>
>        #include <limits.h>
>        #include <signal.h>
>        #include <stddef.h>
>        #include <stdint.h>
>        #include <stdbool.h>
>        #include <linux/audit.h>
>        #include <sys/syscall.h>
>        #include <sys/stat.h>
>        #include <linux/filter.h>
>        #include <linux/seccomp.h>
>        #include <sys/ioctl.h>
>        #include <stdio.h>
>        #include <stdlib.h>
>        #include <unistd.h>
>        #include <errno.h>
>        #include <sys/socket.h>
>        #include <sys/un.h>
> 
>        #define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
>                                } while (0)

Because I love macros, you can expand this to make it take a format
string:

#define errExit(fmt, ...)	do {					\
		char __err[64];						\
		strerror_r(errno, __err, sizeof(__err));		\
		fprintf(stderr, fmt ": %s\n", ##__VA_ARG__, __err);	\
		exit(EXIT_FAILURE);					\
	} while (0)

> 
>        /* Send the file descriptor 'fd' over the connected UNIX domain socket
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
>            /* Allocate a char array of suitable size to hold the ancillary data.
>               However, since this buffer is in reality a 'struct cmsghdr', use a
>               union to ensure that it is suitably aligned. */
>            union {
>                char   buf[CMSG_SPACE(sizeof(int))];
>                                /* Space large enough to hold an 'int' */
>                struct cmsghdr align;
>            } controlMsg;
> 
>            /* The 'msg_name' field can be used to specify the address of the
>               destination socket when sending a datagram. However, we do not
>               need to use this field because 'sockfd' is a connected socket. */
> 
>            msgh.msg_name = NULL;
>            msgh.msg_namelen = 0;
> 
>            /* On Linux, we must transmit at least one byte of real data in
>               order to send ancillary data. We transmit an arbitrary integer
>               whose value is ignored by recvfd(). */
> 
>            msgh.msg_iov = &iov;
>            msgh.msg_iovlen = 1;
>            iov.iov_base = &data;
>            iov.iov_len = sizeof(int);
>            data = 12345;
> 
>            /* Set 'msghdr' fields that describe ancillary data */
> 
>            msgh.msg_control = controlMsg.buf;
>            msgh.msg_controllen = sizeof(controlMsg.buf);
> 
>            /* Set up ancillary data describing file descriptor to send */
> 
>            cmsgp = CMSG_FIRSTHDR(&msgh);
>            cmsgp->cmsg_level = SOL_SOCKET;
>            cmsgp->cmsg_type = SCM_RIGHTS;
>            cmsgp->cmsg_len = CMSG_LEN(sizeof(int));
>            memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
> 
>            /* Send real plus ancillary data */
> 
>            if (sendmsg(sockfd, &msgh, 0) == -1)
>                return -1;
> 
>            return 0;
>        }
> 
>        /* Receive a file descriptor on a connected UNIX domain socket. Returns
>           the received file descriptor on success, or -1 on error. */
> 
>        static int
>        recvfd(int sockfd)
>        {
>            struct msghdr msgh;
>            struct iovec iov;
>            int data, fd;
>            ssize_t nr;
> 
>            /* Allocate a char buffer for the ancillary data. See the comments
>               in sendfd() */
>            union {
>                char   buf[CMSG_SPACE(sizeof(int))];
>                struct cmsghdr align;
>            } controlMsg;
>            struct cmsghdr *cmsgp;
> 
>            /* The 'msg_name' field can be used to obtain the address of the
>               sending socket. However, we do not need this information. */
> 
>            msgh.msg_name = NULL;
>            msgh.msg_namelen = 0;
> 
>            /* Specify buffer for receiving real data */
> 
>            msgh.msg_iov = &iov;
>            msgh.msg_iovlen = 1;
>            iov.iov_base = &data;       /* Real data is an 'int' */
>            iov.iov_len = sizeof(int);
> 
>            /* Set 'msghdr' fields that describe ancillary data */
> 
>            msgh.msg_control = controlMsg.buf;
>            msgh.msg_controllen = sizeof(controlMsg.buf);
> 
>            /* Receive real plus ancillary data; real data is ignored */
> 
>            nr = recvmsg(sockfd, &msgh, 0);
>            if (nr == -1)
>                return -1;
> 
>            cmsgp = CMSG_FIRSTHDR(&msgh);
> 
>            /* Check the validity of the 'cmsghdr' */
> 
>            if (cmsgp == NULL ||
>                    cmsgp->cmsg_len != CMSG_LEN(sizeof(int)) ||
>                    cmsgp->cmsg_level != SOL_SOCKET ||
>                    cmsgp->cmsg_type != SCM_RIGHTS) {
>                errno = EINVAL;
>                return -1;
>            }
> 
>            /* Return the received file descriptor to our caller */
> 
>            memcpy(&fd, CMSG_DATA(cmsgp), sizeof(int));
>            return fd;
>        }
> 
>        static void
>        sigchldHandler(int sig)
>        {
>            char *msg  = "\tS: target has terminated; bye\n";
> 
>            write(STDOUT_FILENO, msg, strlen(msg));

white space nit: extra space before "="
efficiency nit: strlen isn't needed, since it can be done with
compile-time constant constants:

             char msg[] = "\tS: target has terminated; bye\n";
             write(STDOUT_FILENO, msg, sizeof(msg) - 1);

(some optimization levels may already replace the strlen a sizeof - 1)

>            _exit(EXIT_SUCCESS);
>        }
> 
>        static int
>        seccomp(unsigned int operation, unsigned int flags, void *args)
>        {
>            return syscall(__NR_seccomp, operation, flags, args);
>        }
> 
>        /* The following is the x86-64-specific BPF boilerplate code for checking
>           that the BPF program is running on the right architecture + ABI. At
>           completion of these instructions, the accumulator contains the system
>           call number. */
> 
>        /* For the x32 ABI, all system call numbers have bit 30 set */
> 
>        #define X32_SYSCALL_BIT         0x40000000
> 
>        #define X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR \
>                BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
>                        (offsetof(struct seccomp_data, arch))), \
>                BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, AUDIT_ARCH_X86_64, 0, 2), \
>                BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
>                         (offsetof(struct seccomp_data, nr))), \
>                BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, X32_SYSCALL_BIT, 0, 1), \
>                BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS)
> 
>        /* installNotifyFilter() installs a seccomp filter that generates
>           user-space notifications (SECCOMP_RET_USER_NOTIF) when the process
>           calls mkdir(2); the filter allows all other system calls.
> 
>           The function return value is a file descriptor from which the
>           user-space notifications can be fetched. */
> 
>        static int
>        installNotifyFilter(void)
>        {
>            struct sock_filter filter[] = {
>                X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR,
> 
>                /* mkdir() triggers notification to user-space supervisor */
> 
>                BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_mkdir, 0, 1),
>                BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_USER_NOTIF),
> 
>                /* Every other system call is allowed */
> 
>                BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
>            };
> 
>            struct sock_fprog prog = {
>                .len = sizeof(filter) / sizeof(filter[0]),
>                .filter = filter,
>            };
> 
>            /* Install the filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
>               as a result, seccomp() returns a notification file descriptor. */
> 
>            int notifyFd = seccomp(SECCOMP_SET_MODE_FILTER,
>                                   SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
>            if (notifyFd == -1)
>                errExit("seccomp-install-notify-filter");
> 
>            return notifyFd;
>        }
> 
>        /* Close a pair of sockets created by socketpair() */
> 
>        static void
>        closeSocketPair(int sockPair[2])
>        {
>            if (close(sockPair[0]) == -1)
>                errExit("closeSocketPair-close-0");
>            if (close(sockPair[1]) == -1)
>                errExit("closeSocketPair-close-1");
>        }
> 
>        /* Implementation of the target process; create a child process that:
> 
>           (1) installs a seccomp filter with the
>               SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
>           (2) writes the seccomp notification file descriptor returned from
>               the previous step onto the UNIX domain socket, 'sockPair[0]';
>           (3) calls mkdir(2) for each element of 'argv'.
> 
>           The function return value in the parent is the PID of the child
>           process; the child does not return from this function. */
> 
>        static pid_t
>        targetProcess(int sockPair[2], char *argv[])
>        {
>            pid_t targetPid = fork();
>            if (targetPid == -1)
>                errExit("fork");
> 
>            if (targetPid > 0)          /* In parent, return PID of child */
>                return targetPid;
> 
>            /* Child falls through to here */
> 
>            printf("T: PID = %ld\n", (long) getpid());
> 
>            /* Install seccomp filter(s) */
> 
>            if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
>                errExit("prctl");
> 
>            int notifyFd = installNotifyFilter();
> 
>            /* Pass the notification file descriptor to the tracing process over
>               a UNIX domain socket */
> 
>            if (sendfd(sockPair[0], notifyFd) == -1)
>                errExit("sendfd");
> 
>            /* Notification and socket FDs are no longer needed in target */
> 
>            if (close(notifyFd) == -1)
>                errExit("close-target-notify-fd");
> 
>            closeSocketPair(sockPair);
> 
>            /* Perform a mkdir() call for each of the command-line arguments */
> 
>            for (char **ap = argv; *ap != NULL; ap++) {
>                printf("\nT: about to mkdir(\"%s\")\n", *ap);
> 
>                int s = mkdir(*ap, 0700);
>                if (s == -1)
>                    perror("T: ERROR: mkdir(2)");
>                else
>                    printf("T: SUCCESS: mkdir(2) returned %d\n", s);
>            }
> 
>            printf("\nT: terminating\n");
>            exit(EXIT_SUCCESS);
>        }
> 
>        /* Check that the notification ID provided by a SECCOMP_IOCTL_NOTIF_RECV
>           operation is still valid. It will no longer be valid if the process
>           has terminated. This operation can be used when accessing /proc/PID
>           files in the target process in order to avoid TOCTOU race conditions
>           where the PID that is returned by SECCOMP_IOCTL_NOTIF_RECV terminates
>           and is reused by another process. */
> 
>        static void
>        checkNotificationIdIsValid(int notifyFd, uint64_t id)
>        {
>            if (ioctl(notifyFd, SECCOMP_IOCTL_NOTIF_ID_VALID, &id) == -1) {
>                fprintf(stderr, "\tS: notification ID check: "
>                        "target has terminated!!!\n");
> 
>                exit(EXIT_FAILURE);

And now you can do:

		errExit("\tS: notification ID check: "
			"target has terminated! ioctl");

;)

>            }
>        }
> 
>        /* Access the memory of the target process in order to discover the
>           pathname that was given to mkdir() */
> 
>        static bool
>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>                          char *path, size_t len)
>        {
>            char procMemPath[PATH_MAX];
> 
>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
> 
>            int procMemFd = open(procMemPath, O_RDONLY);
>            if (procMemFd == -1)
>                errExit("Supervisor: open");
> 
>            /* Check that the process whose info we are accessing is still alive.
>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>               in checkNotificationIdIsValid()) succeeds, we know that the
>               /proc/PID/mem file descriptor that we opened corresponds to the
>               process for which we received a notification. If that process
>               subsequently terminates, then read() on that file descriptor
>               will return 0 (EOF). */
> 
>            checkNotificationIdIsValid(notifyFd, req->id);
> 
>            /* Read bytes at the location containing the pathname argument
>               (i.e., the first argument) of the mkdir(2) call */
> 
>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>            if (nread == -1)
>                errExit("pread");
> 
>            if (nread == 0) {
>                fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>                        "returned 0 (EOF)\n");
>                exit(EXIT_FAILURE);
>            }
> 
>            if (close(procMemFd) == -1)
>                errExit("close-/proc/PID/mem");
> 
>            /* We have no guarantees about what was in the memory of the target
>               process. We therefore treat the buffer returned by pread() as
>               untrusted input. The buffer should be terminated by a null byte;
>               if not, then we will trigger an error for the target process. */
> 
>            for (int j = 0; j < nread; j++)
>                if (path[j] == ' ')

This rendering typo (' ' vs '\0') ends up manifesting badly. ;) The man
source shows:

        if (path[j] == \(aq\0\(aq)

I think this needs to be \\0 ?

Or it could also be a tested as:

	if (strnlen(path, nread) < nread)

>                    return true;
> 
>            return false;
>        }
> 
>        /* Handle notifications that arrive via the SECCOMP_RET_USER_NOTIF file
>           descriptor, 'notifyFd'. */
> 
>        static void
>        handleNotifications(int notifyFd)
>        {
>            struct seccomp_notif_sizes sizes;
>            char path[PATH_MAX];
> 
>            /* Discover the sizes of the structures that are used to receive
>               notifications and send notification responses, and allocate
>               buffers of those sizes. */
> 
>            if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) == -1)
>                errExit("\tS: seccomp-SECCOMP_GET_NOTIF_SIZES");
> 
>            struct seccomp_notif *req = malloc(sizes.seccomp_notif);
>            if (req == NULL)
>                errExit("\tS: malloc");
> 
>            /* When allocating the response buffer, we must allow for the fact
>               that the user-space binary may have been built with user-space
>               headers where 'struct seccomp_notif_resp' is bigger than the
>               response buffer expected by the (older) kernel. Therefore, we
>               allocate a buffer that is the maximum of the two sizes. This
>               ensures that if the supervisor places bytes into the response
>               structure that are past the response size that the kernel expects,
>               then the supervisor is not touching an invalid memory location. */
> 
>            size_t resp_size = sizes.seccomp_notif_resp;
>            if (sizeof(struct seccomp_notif_resp) > resp_size)
>                resp_size = sizeof(struct seccomp_notif_resp);
> 
>            struct seccomp_notif_resp *resp = malloc(resp_size);
>            if (resp == NULL)
>                errExit("\tS: malloc");
> 
>            /* Loop handling notifications */
> 
>            for (;;) {
>                /* Wait for next notification, returning info in '*req' */
> 
>                memset(req, 0, sizes.seccomp_notif);
>                if (ioctl(notifyFd, SECCOMP_IOCTL_NOTIF_RECV, req) == -1) {
>                    if (errno == EINTR)
>                        continue;
>                    errExit("Supervisor: ioctl-SECCOMP_IOCTL_NOTIF_RECV");
>                }
> 
>                printf("\tS: got notification (ID %#llx) for PID %d\n",
>                        req->id, req->pid);
> 
>                /* The only system call that can generate a notification event
>                   is mkdir(2). Nevertheless, we check that the notified system
>                   call is indeed mkdir() as kind of future-proofing of this
>                   code in case the seccomp filter is later modified to
>                   generate notifications for other system calls. */
> 
>                if (req->data.nr != __NR_mkdir) {
>                    printf("\tS: notification contained unexpected "
>                            "system call number; bye!!!\n");
>                    exit(EXIT_FAILURE);
>                }
> 
>                bool pathOK = getTargetPathname(req, notifyFd, path,
>                                                sizeof(path));
> 
>                /* Prepopulate some fields of the response */
> 
>                resp->id = req->id;     /* Response includes notification ID */
>                resp->flags = 0;
>                resp->val = 0;
> 
>                /* If the target pathname was not valid, trigger an EINVAL error;
>                   if the directory is in /tmp, then create it on behalf of the
>                   supervisor; if the pathname starts with '.', tell the kernel
>                   to let the target process execute the mkdir(); otherwise, give
>                   an error for a directory pathname in any other location. */
> 
>                if (!pathOK) {
>                    resp->error = -EINVAL;
>                    printf("\tS: spoofing error for invalid pathname (%s)\n",
>                            strerror(-resp->error));
>                } else if (strncmp(path, "/tmp/", strlen("/tmp/")) == 0) {
>                    printf("\tS: executing: mkdir(\"%s\", %#llo)\n",
>                            path, req->data.args[1]);
> 
>                    if (mkdir(path, req->data.args[1]) == 0) {
>                        resp->error = 0;            /* "Success" */
>                        resp->val = strlen(path);   /* Used as return value of
>                                                       mkdir() in target */
>                        printf("\tS: success! spoofed return = %lld\n",
>                                resp->val);
>                    } else {
> 
>                        /* If mkdir() failed in the supervisor, pass the error
>                           back to the target */
> 
>                        resp->error = -errno;
>                        printf("\tS: failure! (errno = %d; %s)\n", errno,
>                                strerror(errno));
>                    }
>                } else if (strncmp(path, "./", strlen("./")) == 0) {
>                    resp->error = resp->val = 0;
>                    resp->flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
>                    printf("\tS: target can execute system call\n");
>                } else {
>                    resp->error = -EOPNOTSUPP;
>                    printf("\tS: spoofing error response (%s)\n",
>                            strerror(-resp->error));
>                }
> 
>                /* Send a response to the notification */
> 
>                printf("\tS: sending response "
>                        "(flags = %#x; val = %lld; error = %d)\n",
>                        resp->flags, resp->val, resp->error);
> 
>                if (ioctl(notifyFd, SECCOMP_IOCTL_NOTIF_SEND, resp) == -1) {
>                    if (errno == ENOENT)
>                        printf("\tS: response failed with ENOENT; "
>                                "perhaps target process's syscall was "
>                                "interrupted by a signal?\n");
>                    else
>                        perror("ioctl-SECCOMP_IOCTL_NOTIF_SEND");
>                }
> 
>                /* If the pathname is just "/bye", then the supervisor
>                   terminates. This allows us to see what happens if the
>                   target process makes further calls to mkdir(2). */
> 
>                if (strcmp(path, "/bye") == 0) {
>                    printf("\tS: terminating **********\n");
>                    exit(EXIT_FAILURE);
>                }
>            }
>        }
> 
>        /* Implementation of the supervisor process:
> 
>           (1) obtains the notification file descriptor from 'sockPair[1]'
>           (2) handles notifications that arrive on that file descriptor. */
> 
>        static void
>        supervisor(int sockPair[2])
>        {
>            int notifyFd = recvfd(sockPair[1]);
>            if (notifyFd == -1)
>                errExit("recvfd");
> 
>            closeSocketPair(sockPair);  /* We no longer need the socket pair */
> 
>            handleNotifications(notifyFd);
>        }
> 
>        int
>        main(int argc, char *argv[])
>        {
>            int sockPair[2];
> 
>            setbuf(stdout, NULL);
> 
>            if (argc < 2) {
>                fprintf(stderr, "At least one pathname argument is required\n");
>                exit(EXIT_FAILURE);
>            }
> 
>            /* Create a UNIX domain socket that is used to pass the seccomp
>               notification file descriptor from the target process to the
>               supervisor process. */
> 
>            if (socketpair(AF_UNIX, SOCK_STREAM, 0, sockPair) == -1)
>                errExit("socketpair");
> 
>            /* Create a child process--the "target"--that installs seccomp
>               filtering. The target process writes the seccomp notification
>               file descriptor onto 'sockPair[0]' and then calls mkdir(2) for
>               each directory in the command-line arguments. */
> 
>            (void) targetProcess(sockPair, &argv[optind]);
> 
>            /* Catch SIGCHLD when the target terminates, so that the
>               supervisor can also terminate. */
> 
>            struct sigaction sa;
>            sa.sa_handler = sigchldHandler;
>            sa.sa_flags = 0;
>            sigemptyset(&sa.sa_mask);
>            if (sigaction(SIGCHLD, &sa, NULL) == -1)
>                errExit("sigaction");
> 
>            supervisor(sockPair);
> 
>            exit(EXIT_SUCCESS);
>        }
> 
> SEE ALSO
>        ioctl(2), seccomp(2)
> 
>        A further example program can be found in the kernel source file
>        samples/seccomp/user-trap.c.
> 
> Linux                           2020-10-01          SECCOMP_USER_NOTIF(2)

Thank you so much for this documentation and example! :)

-Kees

[1] https://git.kernel.org/linus/dfe719fef03d752f1682fa8aeddf30ba501c8555
[2] https://lore.kernel.org/lkml/CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CAGXu5jKzif=vp6gn5ZtrTx-JTN367qFphobnt9s=awbaafwoUw@mail.gmail.com/

-- 
Kees Cook
