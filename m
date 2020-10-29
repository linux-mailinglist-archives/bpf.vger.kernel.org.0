Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B062929F5A1
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgJ2Txw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 15:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2Txv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 15:53:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B565C0613D2;
        Thu, 29 Oct 2020 12:53:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i1so4124549wro.1;
        Thu, 29 Oct 2020 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=REIA8X66yZu20+dtZ3E6RBW5Bhn6WWNGEorw32YjsiA=;
        b=CAzgok2B/oy3C9Q48tJ+NHMMd5HHNjY738xut3pYiE0pnflVsCQEdVQTBLpxuD+IgX
         WQUUZdHJKU8eWCXQzI3RmJBSyDssAjKTCwbYXBRPLfflfj+hX3f0lwBQ06/dTKVmcPLJ
         UicL8GMCty9OPqi6Z/EyX86WmHIVg9f2o6DXAj+FQKJZnS5RKw3IeR8udmIuUH5J6Pk/
         svNLbovwG+gtg0mwoR9wKzJRaLwOBr5EQNSUP9HQdX36kjvpHp0qEs3jNwUWVb1oOhkR
         RL3xAWxyLYvrHB0jX1+SHw9SPU+n+tKcIeuoWCoICIVViNgzCiUcv6q7+X8CrbEUG1vz
         M+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=REIA8X66yZu20+dtZ3E6RBW5Bhn6WWNGEorw32YjsiA=;
        b=IUzXp6QdB8zVqxdnvl1De51oOJOMI3T+gs/6ZIhhnA5B5FEHmwGWB8PqQ/beddfgEs
         Y6ud+0Hi9VJoSOXxzHbr/mphoXKGjrGRxmPJiHSXjeXdbuGjJUrL1k06yKuD5dbod+T/
         eHEHNx/6x0moh+7XPHLJ4gK00+FuVK3xek0MVqDwWcZouttEjAQhqZJ8eqCjB/IoXT7V
         s6H/+cq8XT8PIXQ2MdgW1FZlhM5OvDEMttw4jEPYWuZpZaKA9QcS5AceceCbeOBPAXJe
         djuHXijWWS93MgXESYHrqbEBao/d8PhoeZwZ9VFavm2pAVv3QTZW15bx+jcDwSGCCF7w
         57WQ==
X-Gm-Message-State: AOAM5329cf7kBzJWjFCvHXZqm0SHtvVu5W6Xw726aTF2SmLZENnEY5gV
        zboBgLZOrtg1WIcZdcuaCKk=
X-Google-Smtp-Source: ABdhPJzwDIXNj2hsyJQvNM/Z7oAkd5gAs4Mw8YcbECairI5W6QxGeukTBN7ilXCbYIpdpgGm89TLrQ==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr8287024wrp.394.1604001229885;
        Thu, 29 Oct 2020 12:53:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id 71sm7538596wrm.20.2020.10.29.12.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 12:53:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-man <linux-man@vger.kernel.org>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Christian Brauner <christian.brauner@canonical.com>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <20201029152609.k3urvzjocf3s7uml@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <91b74ce1-de95-2b92-c62e-e2715d6071d3@gmail.com>
Date:   Thu, 29 Oct 2020 20:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029152609.k3urvzjocf3s7uml@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Christian

Thanks for taking a look at the page.

On 10/29/20 4:26 PM, Christian Brauner wrote:
> On Mon, Oct 26, 2020 at 10:55:04AM +0100, Michael Kerrisk (man-pages) wrote:
>> Hi all (and especially Tycho and Sargun),
>>
>> Following review comments on the first draft (thanks to Jann, Kees,
>> Christian and Tycho), I've made a lot of changes to this page.
>> I've also added a few FIXMEs relating to outstanding API issues.
>> I'd like a second pass review of the page before I release it.
>> But also, this mail serves as a way of noting the outstanding API
>> issues.
>>
>> Tycho: I still have an outstanding question for you at [2].
>>
>> Sargun: can you please prepare something on SECCOMP_ADDFD_FLAG_SETFD
>> and SECCOMP_IOCTL_NOTIF_ADDFD to be added to this page?
>>
>> I've shown the rendered version of the page below. The page source
>> currently sits in a branch at
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=seccomp_user_notif
>>
>> At this point, I'm mainly interested in feedback about the FIXMEs,
>> some of which relate to the text of the page itself, while the
>> others relate to the various outstanding API issues. The first 
>> FIXME provides a small opportunity for some bikeshedding :-);
> 
> I like this manpage. I think this is the most comprehensive explanation
> of any seccomp feature

Thanks (at least, I think so...)

> and somewhat understandable.
      ^^^^^^^^

(... but I'm not sure ;-).)

> Just tiny comments below, hopefully no bike-shedding though. :)

Most relevant point for bikeshedding is the page name. I plan 
to change it to seccomp_unotify(2) (shorter, reads better out loud).

>> Thanks,
>>
>> Michael
>>
>> [1] https://lore.kernel.org/linux-man/45f07f17-18b6-d187-0914-6f341fe90857@gmail.com/
>> [2] https://lore.kernel.org/linux-man/8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com/
>>
>> =====
>>
>> SECCOMP_USER_NOTIF(2)   Linux Programmer's Manual  SECCOMP_USER_NOTIF(2)

[...]

>>        An overview of the steps performed by the target and the
>>        supervisor is as follows:
>>
>>        1. The target establishes a seccomp filter in the usual manner,
>>           but with two differences:
>>
>>           · The seccomp(2) flags argument includes the flag
>>             SECCOMP_FILTER_FLAG_NEW_LISTENER.  Consequently, the return
>>             value of the (successful) seccomp(2) call is a new
>>             "listening" file descriptor that can be used to receive
>>             notifications.  Only one "listening" seccomp filter can be
>>             installed for a thread.
>>
>>             ┌─────────────────────────────────────────────────────┐
>>             │FIXME                                                │
>>             ├─────────────────────────────────────────────────────┤
>>             │Is the last sentence above correct?                  │
>>             │                                                     │
>>             │Kees Cook (25 Oct 2020) notes:                       │
>>             │                                                     │
>>             │I like this limitation, but I expect that it'll need │
>>             │to change in the future. Even with LSMs, we see the  │
>>             │need for arbitrary stacking, and the idea of there   │
>>             │being only 1 supervisor will eventually break down.  │
>>             │Right now there is only 1 because only container     │
>>             │managers are using this feature. But if some daemon  │
>>             │starts using it to isolate some thread, suddenly it  │
>>             │might break if a container manager is trying to      │
>>             │listen to it too, etc. I expect it won't be needed   │
>>             │soon, but I do think it'll change.                   │
>>             │                                                     │
>>             └─────────────────────────────────────────────────────┘
>>
>>           · In cases where it is appropriate, the seccomp filter returns
>>             the action value SECCOMP_RET_USER_NOTIF.  This return value
>>             will trigger a notification event.
>>
>>        2. In order that the supervisor can obtain notifications using
>>           the listening file descriptor, (a duplicate of) that file
>>           descriptor must be passed from the target to the supervisor.
>>           One way in which this could be done is by passing the file
>>           descriptor over a UNIX domain socket connection between the
>>           target and the supervisor (using the SCM_RIGHTS ancillary
>>           message type described in unix(7)).
> 
> Fwiw, on newer kernels you could also use pidfd_getfd() for that.

Thanks. I added that to the text.

>>        3. The supervisor will receive notification events on the
>>           listening file descriptor.  These events are returned as
>>           structures of type seccomp_notif.  Because this structure and
>>           its size may evolve over kernel versions, the supervisor must
>>           first determine the size of this structure using the
>>           seccomp(2) SECCOMP_GET_NOTIF_SIZES operation, which returns a
>>           structure of type seccomp_notif_sizes.  The supervisor
>>           allocates a buffer of size seccomp_notif_sizes.seccomp_notif
>>           bytes to receive notification events.  In addition,the
>>           supervisor allocates another buffer of size
>>           seccomp_notif_sizes.seccomp_notif_resp bytes for the response
>>           (a struct seccomp_notif_resp structure) that it will provide
>>           to the kernel (and thus the target).
>>
>>        4. The target then performs its workload, which includes system
>>           calls that will be controlled by the seccomp filter.  Whenever
>>           one of these system calls causes the filter to return the
>>           SECCOMP_RET_USER_NOTIF action value, the kernel does not (yet)
>>           execute the system call; instead, execution of the target is
>>           temporarily blocked inside the kernel (in a sleep state that
>>           is interruptible by signals) and a notification event is
>>           generated on the listening file descriptor.
>>
>>        5. The supervisor can now repeatedly monitor the listening file
>>           descriptor for SECCOMP_RET_USER_NOTIF-triggered events.  To do
>>           this, the supervisor uses the SECCOMP_IOCTL_NOTIF_RECV
>>           ioctl(2) operation to read information about a notification
>>           event; this operation blocks until an event is available.  The
> 
> Maybe mention that users can choose to either use the blocking ioctl()
> directly or use poll semantics and point to the section below.

Thanks. I added mention of the poll/select/epoll here.

> (Do we support O_NONBLOCK with SECCOMP_IOCTL_NOTIF_RECV and if not should
> we?)

A quick test suggests that O_NONBLOCK has no effect on the blocking
behavior of SECCOMP_IOCTL_NOTIF_RECV.

(I've added your question and this info as a FIXME in the page.)

>>           operation returns a seccomp_notif structure containing
>>           information about the system call that is being attempted by
>>           the target.
>>
>>        6. The seccomp_notif structure returned by the
>>           SECCOMP_IOCTL_NOTIF_RECV operation includes the same
>>           information (a seccomp_data structure) that was passed to the
>>           seccomp filter.  This information allows the supervisor to
>>           discover the system call number and the arguments for the
>>           target's system call.  In addition, the notification event
>>           contains the ID of the thread that triggered the notification
>>           and a unique cookie value that is used in subsequent
>>           SECCOMP_IOCTL_NOTIF_ID_VALID and SECCOMP_IOCTL_NOTIF_SEND
>>           operations.
>>
>>           The information in the notification can be used to discover
>>           the values of pointer arguments for the target's system call.
>>           (This is something that can't be done from within a seccomp
>>           filter.)  One way in which the supervisor can do this is to
>>           open the corresponding /proc/[tid]/mem file (see proc(5)) and
>>           read bytes from the location that corresponds to one of the
>>           pointer arguments whose value is supplied in the notification
>>           event.  (The supervisor must be careful to avoid a race
>>           condition that can occur when doing this; see the description
>>           of the SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)
>>           In addition, the supervisor can access other system
>>           information that is visible in user space but which is not
>>           accessible from a seccomp filter.
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
>>           information in this response is used by the kernel to
>>           construct a return value for the target's system call and
>>           provide a value that will be assigned to the errno variable of
>>           the target.
>>
>>           The response is sent using the SECCOMP_IOCTL_NOTIF_SEND
>>           ioctl(2) operation, which is used to transmit a
>>           seccomp_notif_resp structure to the kernel.  This structure
>>           includes a cookie value that the supervisor obtained in the
>>           seccomp_notif structure returned by the
>>           SECCOMP_IOCTL_NOTIF_RECV operation.  This cookie value allows
>>           the kernel to associate the response with the target.  This
>>           structure must include the cookie value that the supervisor
>>           obtained in the seccomp_notif structure returned by the
>>           SECCOMP_IOCTL_NOTIF_RECV operation; the cookie allows the
>>           kernel to associate the response with the target.
>>
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
> 
> Hm, since the ioctls() are associatd with the seccomp notify file
> descriptor maybe we should rephrase this a bit to make this more
> obvious:
> "[...] ioctl(2) operations are supported by the seccomp user-space file descriptor"
> That might line-uper better with the following sentence. Just a thought,
> feel free to ignore.

Yep, your idea is better. I changed the text.

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
> 
> I think we haven't settled whether this is input or output only. I guess
> we could technically use it for both.

So, change something here in the page?

> 
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
> 
> (Technically also EFAULT because the user provided a garbage address.)

Yeah. But that error is kind of presumed anywhere a pointer 
is provided.

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
>>        SECCOMP_IOCTL_NOTIF_ID_VALID
>>               This operation can be used to check that a notification ID
>>               returned by an earlier SECCOMP_IOCTL_NOTIF_RECV operation
>>               is still valid (i.e., that the target still exists and its
>>               system call is still blocked waiting for a response).
>>
>>               The third ioctl(2) argument is a pointer to the cookie
>>               (id) returned by the SECCOMP_IOCTL_NOTIF_RECV operation.
>>
>>               This operation is necessary to avoid race conditions that
>>               can occur when the pid returned by the
>>               SECCOMP_IOCTL_NOTIF_RECV operation terminates, and that
>>               process ID is reused by another process.  An example of
>>               this kind of race is the following
>>
>>               1. A notification is generated on the listening file
>>                  descriptor.  The returned seccomp_notif contains the
>>                  TID of the target thread (in the pid field of the
>>                  structure).
>>
>>               2. The target terminates.
>>
>>               3. Another thread or process is created on the system that
>>                  by chance reuses the TID that was freed when the target
>>                  terminated.
>>
>>               4. The supervisor open(2)s the /proc/[tid]/mem file for
>>                  the TID obtained in step 1, with the intention of (say)
>>                  inspecting the memory location(s) that containing the
>>                  argument(s) of the system call that triggered the
>>                  notification in step 1.
>>
>>               In the above scenario, the risk is that the supervisor may
>>               try to access the memory of a process other than the
>>               target.  This race can be avoided by following the call to
>>               open(2) with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to
>>               verify that the process that generated the notification is
>>               still alive.  (Note that if the target terminates after
>>               the latter step, a subsequent read(2) from the file
>>               descriptor may return 0, indicating end of file.)
>>
>>               On success (i.e., the notification ID is still valid),
>>               this operation returns 0.  On failure (i.e., the
>>               notification ID is no longer valid), -1 is returned, and
>>               errno is set to ENOENT.
>>
>>        SECCOMP_IOCTL_NOTIF_SEND
>>               This operation is used to send a notification response
>>               back to the kernel.  The third ioctl(2) argument of this
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
>>               id     This is the cookie value that was obtained using
>>                      the SECCOMP_IOCTL_NOTIF_RECV operation.  This
>>                      cookie value allows the kernel to correctly
>>                      associate this response with the system call that
>>                      triggered the user-space notification.
>>
>>               val    This is the value that will be used for a spoofed
>>                      success return for the target's system call; see
>>                      below.
>>
>>               error  This is the value that will be used as the error
>>                      number (errno) for a spoofed error return for the
>>                      target's system call; see below.
>>
>>               flags  This is a bit mask that includes zero or more of
>>                      the following flags:
>>
>>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE (since Linux 5.5)
>>                             Tell the kernel to execute the target's
>>                             system call.
>>
>>               Two kinds of response are possible:
>>
>>               · A response to the kernel telling it to execute the
>>                 target's system call.  In this case, the flags field
>>                 includes SECCOMP_USER_NOTIF_FLAG_CONTINUE and the error
>>                 and val fields must be zero.
>>
>>                 This kind of response can be useful in cases where the
>>                 supervisor needs to do deeper analysis of the target's
>>                 system call than is possible from a seccomp filter
>>                 (e.g., examining the values of pointer arguments), and,
>>                 having decided that the system call does not require
>>                 emulation by the supervisor, the supervisor wants the
>>                 system call to be executed normally in the target.
>>
>>                 The SECCOMP_USER_NOTIF_FLAG_CONTINUE flag should be used
>>                 with caution; see NOTES.
>>
>>               · A spoofed return value for the target's system call.  In
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
> 
> Not a native English speaker but shouldn't this be "latter"?

Yup!

>>                    kernel causes the target's system call to return -1,
>>                    and errno is assigned the negated error value.
>>
>>                 +  val is set to a value that will be used as the return
>>                    value for a spoofed "success" return for the target's
>>                    system call.  The value in this field is ignored if
>>                    the error field contains a nonzero value.
>>
>>                    ┌─────────────────────────────────────────────────────┐
>>                    │FIXME                                                │
>>                    ├─────────────────────────────────────────────────────┤
>>                    │Kees Cook suggested:                                 │
>>                    │                                                     │
>>                    │Strictly speaking, this is architecture specific,    │
>>                    │but all architectures do it this way. Should seccomp │
>>                    │enforce val == 0 when err != 0 ?                     │
> 
> Feels like it should, at least for the SEND ioctl where we already
> verify that val and err are both 0 when CONTINUE is specified (as you
> pointed out correctly above).

Your comments ended here (with no sign-off). Was that intentional?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
