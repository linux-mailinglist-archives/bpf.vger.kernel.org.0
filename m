Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6433C28F0DD
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJOLXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgJOLXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 07:23:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EB9C061755;
        Thu, 15 Oct 2020 04:23:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p15so2773523wmi.4;
        Thu, 15 Oct 2020 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GmEVmU88O8qTiwUb+ICW1QOn1EEa3s/908Lo1d+XEAY=;
        b=KC9BPD5GvkT8f7maqCMdJoPtbT9r/F6jN6s3KjF6ZbDtA9MoFFRkdR8bUUuqJkJCt3
         iVzVMSI2SodaAjbbOe1VX7rtYR1LiqcdcbPC9c4Br1nM7t9/po/D0TLKkBkOyJycbeoA
         a1wiQ0tuWCbYU/7QwpQjvOkXBLnECrjYp8E1VNy1tyu0+bo2/Y5L10MvdpdfgjM1Ks1+
         iiX+pSXPCOpQiUAm0a44hSDuvYCw+/rPbkou2ZZGbSaLjEj0F9Ikf0bW3uJZrgWjftR0
         DdP8IMeRWNNnqf74ct7ieiZCrn16MW4NBGzy158dRKIuYDod/pL5ZfcF7OXgBCU1tDY0
         duvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GmEVmU88O8qTiwUb+ICW1QOn1EEa3s/908Lo1d+XEAY=;
        b=UnkZzQpLcF0cjo1l32VZy91zwFp0WWW+AiuefrZLzbvH4UV54IfUE0QtnZLzt1PK+0
         n/pB4QBqQKNVlM2Z1iHQlMWh7fDruYH7afLYcCPbAmZRAkt4ToqdyhLtnq5G5ejVYfJG
         0+eGbXsc7HGMBxNo+EOy+id/6uL4cnRGV5Xi5jjYdzc/YX/q6HV07ZRjPXnlbRVTFRPo
         HVfGEWLNwzGVokU+a5Of962JrfTbzxVvXMsRcU0tnkG58u1wc4+06Dzpj1/0dyP/mfCQ
         wtBhH3WFAhw9C4rck7Zglafr46geSk+n75hCF5R8mQJ0SCCayJ1VWEXwLTysZqwHRkFh
         HAkg==
X-Gm-Message-State: AOAM5307ck1tOgbB+aT2sBroSYyHi0755hLIlcRLnRMJaVN44Jm3RpRW
        /9+M9Esr8NopcntFHal87Pc=
X-Google-Smtp-Source: ABdhPJwyufiojU8J691nXzhj6hk9Qnf4xI2ezsyZEgQZFG9kqq1kcH4x83jUdaD+8QpHVcQukgX0xQ==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr3368720wmc.114.1602761025714;
        Thu, 15 Oct 2020 04:23:45 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id y7sm3898721wmg.40.2020.10.15.04.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 04:23:44 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-man <linux-man@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, wad@chromium.org,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>, bpf@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Christian Brauner <christian.brauner@canonical.com>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20201001123619.fdlk2xb56lej6rx3@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3cd4826a-074e-e863-af70-43a80a996e58@gmail.com>
Date:   Thu, 15 Oct 2020 13:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001123619.fdlk2xb56lej6rx3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Christian,

On 10/1/20 2:36 PM, Christian Brauner wrote:
> [I'm on vacation so I'll just give this a quick glance for now.]
> 
> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Tycho, Sargun (and all),
>>
>> I knew it would be a big ask, but below is kind of the manual page
>> I was hoping you might write [1] for the seccomp user-space notification
>> mechanism. Since you didn't (and because 5.9 adds various new pieces 
>> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD 
>> that also will need documenting [2]), I did :-). But of course I may 
>> have made mistakes...
>>
>> I've shown the rendered version of the page below, and would love
>> to receive review comments from you and others, and acks, etc.
>>
>> There are a few FIXMEs sprinkled into the page, including one
>> that relates to what appears to me to be a misdesign (possibly 
>> fixable) in the operation of the SECCOMP_IOCTL_NOTIF_RECV 
>> operation. I would be especially interested in feedback on that
>> FIXME, and also of course the other FIXMEs.
>>
>> The page includes an extensive (albeit slightly contrived)
>> example program, and I would be happy also to receive comments
>> on that program.
>>
>> The page source currently sits in a branch (along with the text
>> that you sent me for the seccomp(2) page) at
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=seccomp_user_notif
>>
>> Thanks,
>>
>> Michael
>>
>> [1] https://lore.kernel.org/linux-man/2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com/#t
>> [2] Sargun, can you prepare something on SECCOMP_ADDFD_FLAG_SETFD
>>     and SECCOMP_IOCTL_NOTIF_ADDFD to be added to this page?
>>
>> =====
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
> 
> "In contrast, the user notification mechanism allows to delegate the
> handling of the system call of one process (target) to another
> user-space process (supervisor)."?

Thanks. I've reworded similarly to what you suggest.

>>        The advantages of doing this are that, by contrast with the  sec‐
>>        comp  filter,  which  is  running on a virtual machine inside the
>>        kernel, the user-space process has access to information that  is
>>        unavailable to the seccomp filter and it can perform actions that
>>        can't be performed from the seccomp filter.
> 
> This section reads a bit difficult imho:
> "A suitably privileged supervisor can use the user notification
> mechanism to perform actions in lieu of the target. The supervisor will
> usually be able to retrieve information about the target and the
> performed system call that the seccomp filter itself cannot."

Thanks. Again I've done some rewording.

>>        In the discussion that follows, the process  that  has  installed
>>        the  seccomp filter is referred to as the target, and the process
>>        that is notified by  the  user-space  notification  mechanism  is
>>        referred  to  as  the  supervisor.  An overview of the steps per‐
>>        formed by these two processes is as follows:

After the various rewordings, the opening paragraphs now read:

       In conventional usage of a seccomp filter, the decision about  how
       to treat a system call is made by the filter itself.  By contrast,
       the user-space notification mechanism allows the seccomp filter to
       delegate  the  handling  of  the system call to another user-space
       process.

       In the discussion that follows, the thread(s) on which the seccomp
       filter  is  installed  is (are) referred to as the target, and the
       process that is notified by the user-space notification  mechanism
       is referred to as the supervisor.

       A  suitably privileged supervisor can use the user-space notifica‐
       tion mechanism to perform actions on behalf of  the  target.   The
       advantage  of  the  user-space  notification mechanism is that the
       supervisor will usually be able to retrieve information about  the
       target  and  the  performed  system  call  that the seccomp filter
       itself cannot.  (A seccomp filter is limited in the information it
       can  obtain and the actions that it can perform because it is run‐
       ning on a virtual machine inside the kernel.)

       An overview of the steps performed by the target and the  supervi‐
       sor is as follows:

>>        1. The target process establishes a seccomp filter in  the  usual
>>           manner, but with two differences:
>>
>>           · The seccomp(2) flags argument includes the flag SECCOMP_FIL‐
>>             TER_FLAG_NEW_LISTENER.  Consequently, the return  value   of
>>             the  (successful)  seccomp(2) call is a new "listening" file
>>             descriptor that can be used to receive notifications.
> 
> I think it would be good to mention that seccomp notify fds are
> O_CLOEXEC by default somewhere.

Yep. This is already noted in seccomp(2).

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
> I think a few people have already pointed out other ways of retrieving
> an fd. :)

Yup.

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
> Maybe mention that the task is killable when so blocked?

Jann also noted this, and I thought it could be presumed, and so was
not thinking to add anything to the text. But, since you mention it too,
I've added some words to note that the sleep state is interruptible by
signals.

>>           cation event is generated on the listening file descriptor.
>>
>>        5. The supervisor process can now repeatedly monitor the  listen‐
>>           ing   file   descriptor  for  SECCOMP_RET_USER_NOTIF-triggered
>>           events.   To  do  this,   the   supervisor   uses   the   SEC‐
>>           COMP_IOCTL_NOTIF_RECV  ioctl(2)  operation to read information
>>           about a notification event; this  operation  blocks  until  an
>>           event  is  available.   The  operation returns a seccomp_notif
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
> (Technically TID.)

Yep. I've already made various fixes after comments from Jann.

>>           The  information  in  the notification can be used to discover
>>           the values of pointer arguments for the target process's  sys‐
>>           tem call.  (This is something that can't be done from within a
>>           seccomp filter.)  To do this (and  assuming  it  has  suitable
>>           permissions),   the   supervisor   opens   the   corresponding
>>           /proc/[pid]/mem file, seeks to the memory location that corre‐
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
> This has already been answered, I believe.

Yep.

>>
>>        7. Having  obtained  information  as  per  the previous step, the
>>           supervisor may then choose to perform an action in response to
>>           the  target  process's  system call (which, as noted above, is
>>           not  executed  when  the  seccomp  filter  returns  the   SEC‐
>>           COMP_RET_USER_NOTIF action value).
> 
> Nit: It is not _yet_ executed it may very well be if the response is
> "continue". 

Okay. I've added the word "yet" in point 4. I already elaborate on
the "continue" details later.

> This should either mention that when the fd becomes
> _RECVable the system call is guaranteed to not have executed yet or
> specify that it is not yet executed, I think.

I'm not sure that I understand your point here. I mean, doesn't the
arrival of the notification already imply that the system call hasn't
yet been executed? You seem to be drawing some distinction between
the notification vs FD being RECVable, but I don't understand what
that distinction is. Can you elaborate please...

>>           One  example  use case here relates to containers.  The target
>>           process may be located inside a container where  it  does  not
>>           have sufficient capabilities to mount a filesystem in the con‐
>>           tainer's mount namespace.  However, the supervisor  may  be  a
>>           more  privileged  process that that does have sufficient capa‐
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
> I think here or above you should mention that the id or "cookie" _must_
> be used when a file descriptor to /proc/<pid>/mem or any /proc/<pid>/*
> is opened:
> fd = open(/proc/pid/*);
> verify_via_cookie_that_pid_still_alive(cookie);
> operate_on(fd)
> 
> Otherwise this is a potential security issue.

Yes, but already in point 6 above I say:

           (The supervisor must be careful to avoid a race condition that
           can occur when doing this; see the  description  of  the  SEC‐
           COMP_IOCTL_NOTIF_ID_VALID ioctl(2) operation below.)  In addi‐

And then I say more about the ioctl() later. So, I think that I've
covered this point sufficiently (?). Maybe you missed some of
that text. Or do you think there's still something I should add?

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
>>               tion  blocks  until  an  event occurs.  The third ioctl(2)
>>               argument is a pointer to a structure of the following form
>>               which  contains  information about the event.  This struc‐
>>               ture must be zeroed out before the call.
>>
>>                   struct seccomp_notif {
>>                       __u64  id;              /* Cookie */
>>                       __u32  pid;             /* PID of target process */
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
>>                      the target process.  The cookie value has the  fol‐
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
> Yes.
> 
>>
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
>>
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
> This has been discussed later in the thread too, I believe. My patchset
> fixed a different but related bug in ->poll() when a filter becomes
> unused. I hadn't noticed this behavior since I'm always polling. (Pure
> ioctls() feel a bit fishy to me. :) But obviously a valid use.)

Yes, I hope the ioctl() can be fixed.

>>        SECCOMP_IOCTL_NOTIF_ID_VALID
>>               This operation can be used to check that a notification ID
>>               returned by an earlier SECCOMP_IOCTL_NOTIF_RECV  operation
>>               is  still  valid  (i.e.,  that  the  target  process still
>>               exists).
>>
>>               The third ioctl(2) argument is a  pointer  to  the  cookie
>>               (id) returned by the SECCOMP_IOCTL_NOTIF_RECV operation.
>>
>>               This  operation is necessary to avoid race conditions that
>>               can  occur   when   the   pid   returned   by   the   SEC‐
>>               COMP_IOCTL_NOTIF_RECV   operation   terminates,  and  that
>>               process ID is reused by another process.   An  example  of
>>               this kind of race is the following
>>
>>               1. A  notification  is  generated  on  the  listening file
>>                  descriptor.  The returned  seccomp_notif  contains  the
>>                  PID of the target process.
>>
>>               2. The target process terminates.
>>
>>               3. Another process is created on the system that by chance
>>                  reuses the PID that was freed when the  target  process
>>                  terminates.
>>
>>               4. The  supervisor  open(2)s  the /proc/[pid]/mem file for
>>                  the PID obtained in step 1, with the intention of (say)
>>                  inspecting the memory locations that contains the argu‐
>>                  ments of the system call that triggered  the  notifica‐
>>                  tion in step 1.
>>
>>               In the above scenario, the risk is that the supervisor may
>>               try to access the memory of a process other than the  tar‐
>>               get.   This  race  can be avoided by following the call to
>>               open with a SECCOMP_IOCTL_NOTIF_ID_VALID operation to ver‐
>>               ify  that  the  process that generated the notification is
>>               still alive.  (Note that  if  the  target  process  subse‐
>>               quently  terminates, its PID won't be reused because there
>>               remains an open reference to the /proc[pid]/mem  file;  in
>>               this  case, a subsequent read(2) from the file will return
>>               0, indicating end of file.)
>>
>>               On success (i.e., the notification  ID  is  still  valid),
>>               this  operation  returns 0 On failure (i.e., the notifica‐
> 
> Missing a ".", I think.

(Yup. Already fixed.)

>>               tion ID is no longer valid), -1 is returned, and errno  is
>>               set to ENOENT.
>>
>>        SECCOMP_IOCTL_NOTIF_SEND
>>               This  operation  is  used  to send a notification response
>>               back to the kernel.  The third ioctl(2) argument  of  this
>>               structure  is  a  pointer  to a structure of the following
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
>>               id     This is the cookie value that  was  obtained  using
>>                      the   SECCOMP_IOCTL_NOTIF_RECV   operation.    This
>>                      cookie value allows the kernel to  correctly  asso‐
>>                      ciate this response with the system call that trig‐
>>                      gered the user-space notification.
>>
>>               val    This is the value that will be used for  a  spoofed
>>                      success  return  for  the  target  process's system
>>                      call; see below.
>>
>>               error  This is the value that will be used  as  the  error
>>                      number  (errno)  for a spoofed error return for the
>>                      target process's system call; see below.
> 
> Nit: "val" is only used when "error" is not set.

Yes. I note that below. I don't want to clutter this part of the page with
too many details.

>>               flags  This is a bit mask that includes zero  or  more  of
>>                      the following flags
>>
>>                      SECCOMP_USER_NOTIF_FLAG_CONTINUE (since Linux 5.5)
>>                             Tell   the  kernel  to  execute  the  target
>>                             process's system call.
>>
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
> I think Jann has pointed this out. This needs to come with a big warning
> and I would explicitly put a:
> "The user notification mechanism cannot be used to implement a syscall
> security policy in user space!"
> You might want to take a look at the seccomp.h header file where I
> placed a giant warning about how to use this too.

Yes. Kees also raised this. See my reply to Jann (who pasted in a copy 
of part of your comment from seccomp.h). I'm going to freely reuse the
text from your comment. Please take a look at the text in my reply to Jann,
ad let me know wat you think.

>>               · A spoofed return value for the target  process's  system
>>                 call.   In  this  case,  the kernel does not execute the
>>                 target process's system call, instead causing the system
>>                 call to return a spoofed value as specified by fields of
>>                 the seccomp_notif_resp structure.  The supervisor should
>>                 set the fields of this structure as follows:
>>
>>                 +  flags  does  not contain SECCOMP_USER_NOTIF_FLAG_CON‐
>>                    TINUE.
>>
>>                 +  error is set either to  0  for  a  spoofed  "success"
>>                    return  or  to  a negative error number for a spoofed
>>                    "failure" return.  In the  former  case,  the  kernel
>>                    causes the target process's system call to return the
>>                    value specified in the val field.  In the later case,
>>                    the kernel causes the target process's system call to
>>                    return -1, and errno is assigned  the  negated  error
>>                    value.
>>
>>                 +  val is set to a value that will be used as the return
>>                    value for a spoofed "success" return for  the  target
>>                    process's  system  call.   The value in this field is
>>                    ignored if the error field contains a nonzero value.
>>
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
>>
>> NOTES
>>        The file descriptor returned when seccomp(2) is employed with the
>>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
>>        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
>>        ing,  these interfaces indicate that the file descriptor is read‐
>>        able.
> 
> This should also note that when a filter becomes unused, i.e. the last
> task using that filter in its filter hierarchy is dead (been
> reaped/autoreaped) ->poll() will notify with (E)POLLHUP.

Ahh! Now I understand. I was unaware of this. Jann commented that
poll() could be used as well, but you provided enough detail that
now I understand how this works. I added the following in NOTES
where poll/select/epoll are described:

       · After the last thread using the filter has terminated  and  been
         reaped  using waitpid(2) (or similar), the file descriptor indi‐
         cates an end-of-file condition  (readable  in  select(2);  POLL‐
         HUP/EPOLLHUP in poll(2)/ epoll_wait(2)).

>>        ┌─────────────────────────────────────────────────────┐
>>        │FIXME                                                │
>>        ├─────────────────────────────────────────────────────┤
>>        │Interestingly, after the event  had  been  received, │
>>        │the  file descriptor indicates as writable (verified │
>>        │from the source code and by experiment). How is this │
>>        │useful?                                              │
>>        └─────────────────────────────────────────────────────┘
>>
>> EXAMPLES
>>        The (somewhat contrived) program shown below demonstrates the use
>>        of the interfaces described in this page.  The program creates  a
>>        child  process  that  serves  as the "target" process.  The child
>>        process  installs  a  seccomp  filter  that  returns   the   SEC‐
>>        COMP_RET_USER_NOTIF  action  value if a call is made to mkdir(2).
>>        The child process then calls mkdir(2) once for each of  the  sup‐
>>        plied  command-line arguments, and reports the result returned by
>>        the call.  After processing all arguments, the child process ter‐
>>        minates.
>>
>>        The  parent  process  acts  as  the supervisor, listening for the
>>        notifications that are generated when the  target  process  calls
>>        mkdir(2).   When such a notification occurs, the supervisor exam‐
>>        ines the memory of the target process (using /proc/[pid]/mem)  to
>>        discover  the pathname argument that was supplied to the mkdir(2)
>>        call, and performs one of the following actions:
>>
>>        · If the pathname begins with the prefix "/tmp/", then the super‐
>>          visor  attempts  to  create  the  specified directory, and then
>>          spoofs a return for the target  process  based  on  the  return
>>          value  of  the  supervisor's  mkdir(2) call.  In the event that
>>          that call succeeds, the spoofed success  return  value  is  the
>>          length of the pathname.
>>
>>        · If  the pathname begins with "./" (i.e., it is a relative path‐
>>          name), the supervisor sends a  SECCOMP_USER_NOTIF_FLAG_CONTINUE
>>          response  to  the  kernel to say that kernel should execute the
>>          target process's mkdir(2) call.
> 
> Potentially problematic if the two processes have the same privilege
> level and the supervisor intends _CONTINUE to mean "is safe to execute".

Understood. But I think that needs to be clarified elsewhere in the
page, since it's essentially the same point as "The user notification
mechanism cannot be used to implement a syscall security policy in 
user space!" See my reply to Jann.

> An attacker could try to re-write arguments afaict.

By an attacker, I presume you mean a malign supervisor, right.
Sure, it looks to me as though rewriting arguments could be 
possible. But, if you had privilege to do that, you'd presumably
have privileges for any number of other nefarious actities, right?
(So, I don't think anything special needs to be said here; let me
know if you feel something does need to be said.

> A good an easy example is usually mknod() in a user namespace. A
> _CONTINUE is always safe since you can't create device nodes anyway.

Okay -- but I wanted to provide an example (admittedly very
contrived) to show how the supervisor could either do the systcall
on behalf of the target, or leave things to the target to execute
the system call. Do you feel that the example is leading people
astray?

> Sorry, I can't review the rest in sufficient detail since I'm on
> vacation still so I'm just going to shut up now. :)

Well, thanks already, because your comments were already very
useful!. I will send out a new draft shortly :-).

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
