Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF127F364
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgI3Ue4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Ue4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 16:34:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC34C061755;
        Wed, 30 Sep 2020 13:34:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so3216386wrn.13;
        Wed, 30 Sep 2020 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IspiLrnT2imZY/Ib+JxzPK1rgkTFQ0uem4Utb6KnzxY=;
        b=b4EbsNm9L32a8sJpoFaT4hyWH+ptKyoaxgjye0AYiOlxBeFrPKNJgYR+UakNy2STga
         yX9kSFsWwTymYX4CZrw2rug3yhHP+zATsXh+ObeaDw2GqxuIWfH5i9unDwq2sP/eV9GG
         mFlLS9h8p/vBExDznmT3C3D/MFbTlhF43vcyU64J8Prg+WnylxB64USH0ZW4pPdtAJZj
         XnAXqN9tamWT92flreZMHVpUBUO0RV1QOJ6slsXRzHpZcv18mLma5Lt7h1V1g1uQNnJl
         N2CYCPRa4pujcs/uvk7T7/wRD/rqvsKNS4ijTrQ+Rfrjph957/qgQ+t/aX58IKUnl+iV
         NFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IspiLrnT2imZY/Ib+JxzPK1rgkTFQ0uem4Utb6KnzxY=;
        b=H40ynTxaxbX2UMwVl3uapGlPoWv2BZyX42TvyuTVU1C1kCHqjcke/6qcsbI5A55jWe
         LP910hyHLl/IqDJRZ8acIhDp9sN333rnx93RPrpr35MxtIMrUMvxfCUSuqeQc/vSutBW
         iQHCdob70UnAwmYw0CuvjQYlJCf6QXgkRyBYo9EpHqqxYhmGUYqBnOl020i5HPbfT2FI
         uN/syW2zP+PTL4K9XM/LaiVIMXJHUNJVpWcDyJqZGnT4SnFJd7VRfBb20UbvGeyCzxPK
         7uj1ouyW23IcI9Lw936QEWsODbT0fxpT3dLhzYluMIQN/LNYOQYDXL6LcGslCCwFTJz9
         lYtA==
X-Gm-Message-State: AOAM531vNz43VT9Z6P33Xrt7mOUHt6LLQKEjXaoHpr+D4JUlEDsawIAE
        w0Bwlea+2TybI3vbZhGnJRU=
X-Google-Smtp-Source: ABdhPJxu7WCzwNxAHegKNtrhoSoK3B3wGOn21tufT7z08EpALYEeln9Ii4oycORRXrlIkIl2co1tog==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr5099611wrv.139.1601498094353;
        Wed, 30 Sep 2020 13:34:54 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id d83sm4993890wmf.23.2020.09.30.13.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 13:34:53 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
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
To:     Tycho Andersen <tycho@tycho.pizza>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
Date:   Wed, 30 Sep 2020 22:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930150330.GC284424@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tycho,

Thanks for taking time to look at the page!

On 9/30/20 5:03 PM, Tycho Andersen wrote:
> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
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
> It is technically possible to inherit the fd via fork, but is it
> really that useful? The child process wouldn't be able to actually do
> the syscall in question, since it would have the same filter.

D'oh! Yes, of course.

I think I was reaching because in an earlier conversation
you replied:

[[
> 3. The "target process" passes the "listening file descriptor"
>    to the "monitoring process" via the UNIX domain socket.

or some other means, it doesn't have to be with SCM_RIGHTS.
]]

So, what other means?

Anyway, I removed the sentence mentioning fork().

>>           The  information  in  the notification can be used to discover
>>           the values of pointer arguments for the target process's  sys‐
>>           tem call.  (This is something that can't be done from within a
>>           seccomp filter.)  To do this (and  assuming  it  has  suitable
> 
> s/To do this/One way to accomplish this/ perhaps, since there are
> others.

Yes, thanks, done.

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
> PATH_MAX, I suppose.

Yes, I misunderstood a fundamental detail here, as Jann 
also confirmed.

>>        ┌─────────────────────────────────────────────────────┐
>>        │FIXME                                                │
>>        ├─────────────────────────────────────────────────────┤
>>        │From my experiments,  it  appears  that  if  a  SEC‐ │
>>        │COMP_IOCTL_NOTIF_RECV   is  done  after  the  target │
>>        │process terminates, then the ioctl()  simply  blocks │
>>        │(rather than returning an error to indicate that the │
>>        │target process no longer exists).                    │
> 
> Yeah, I think Christian wanted to fix this at some point,

Do you have a pointer that discussion? I could not find it with a 
quick search.

> but it's a
> bit sticky to do.

Can you say a few words about the nature of the problem?

In the meantime. I think this merits a note under BUGS, and
I've added one.

> Note that if you e.g. rely on fork() above, the
> filter is shared with your current process, and this notification
> would never be possible. Perhaps another reason to omit that from the
> man page.

(Yes, as noted above, I removed that sentence.)

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
>                                           ^ need a period?
> 
>>        ┌─────────────────────────────────────────────────────┐
>>        │FIXME                                                │
>>        ├─────────────────────────────────────────────────────┤
>>        │Interestingly, after the event  had  been  received, │
>>        │the  file descriptor indicates as writable (verified │
>>        │from the source code and by experiment). How is this │
>>        │useful?                                              │
> 
> You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
> reasonable.

No, I'm saying something more fundamental: why is the FD indicating as
writable? Can you write something to it? If yes, what? If not, then
why do these APIs want to say that the FD is writable?

>> EXAMPLES
>>        The (somewhat contrived) program shown below demonstrates the use
> 
> May also be worth mentioning the example in
> samples/seccomp/user-trap.c as well.

Oh -- I meant to do that! Thanks for the reminding me.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
