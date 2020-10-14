Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4628DD9A
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgJNJZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgJNJTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F636C045860;
        Tue, 13 Oct 2020 22:41:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so2234678wro.1;
        Tue, 13 Oct 2020 22:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ZD1Q1ycqo0UA6f9xY0VJ9HAjkT2BLtIOvzScJIKi9M=;
        b=AYQcWHx49JTyiIvfHAlkFzIhR6WG3kcBicmvcevU3yWLq5+Gspl272RNPtjAzKPT9e
         n8SPo6JiEuTivW7zt0Gvu0lQKKnMzaX2SoP+QqmO6/9+pmcVyteTPXEjvVqBivl/Dm9k
         KLjGCU2OSfbEzJu+cJYYSphQFyuZSpnjPFN3h04e3kvtET6Zlr5szW61p5MrMJBIZvUh
         sKlCvlwIGsAKwj+XW+EMLvl9CKPFmPNIPgXDKx4Ay4xO+le7aeQKP/jkkmP8U2y5LlXu
         lV3W0sQgBYtWgD5WpYetbxeCzmwkK42RQJsq8opSJfQhtFmZ0hh8FD6j5VjTZbUJt4rS
         LWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZD1Q1ycqo0UA6f9xY0VJ9HAjkT2BLtIOvzScJIKi9M=;
        b=GZQNMeY46xXpxQMF2xrESgd3u6HFx4wn6Y9jv8MQVuUCVJ+JB9rCMMvy29rzkxGotD
         IuRGaxXAEgFHt4rEnqEjKH7wKGSf6h/5rKKn3WDoZSFyYKemb5VaLBJFU7HUTCaspSl9
         iqKx8uOLi6TXUhzKP9GICV7FrqYAdIAv6ii4ehA7fge5zuRNAbFAeNxS2ApZkhocQNxF
         WP+TCue4NFm9P7eGnb9+gqM1Hxzl5JU3yEa26e/E6Nzp+umgPUg0YvUHqgt6w5IWbQkj
         TtmDoGV6KRapLv2+8t1OZ9W6VU7mmIwftrGysYo2J3l+ArWbflcCHGpqN7reuDObxirS
         N5Lg==
X-Gm-Message-State: AOAM532NI//i3C8O8277RQ5/iBGBNJAINBcJITbJ1cm7GzmSO7hRRu6Q
        HMt+LQx9oTOLhqZ7ZqfhaNQ=
X-Google-Smtp-Source: ABdhPJz5XyrZLGamBlvAuoMrkkPcgWPQMbcczbspT9zKCtHmVhGjFjSIuktq+RJkYJSEg3ti156pOw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr3595047wrr.57.1602654071185;
        Tue, 13 Oct 2020 22:41:11 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id f189sm1977581wmf.16.2020.10.13.22.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 22:41:10 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Jann Horn <jannh@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Christian Brauner <christian.brauner@canonical.com>,
        Tycho Andersen <tycho@tycho.pizza>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <20201001125043.dj6taeieatpw3a4w@gmail.com>
 <CAG48ez2U1K2XYZu6goRYwmQ-RSu7LkKSOhPt8_wPVEUQfm7Eeg@mail.gmail.com>
 <20201001165850.GC1260245@cisco> <20201001171206.jvkdx4htqux5agdv@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3a417df2-6346-601d-568e-29307347e6aa@gmail.com>
Date:   Wed, 14 Oct 2020 07:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001171206.jvkdx4htqux5agdv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/1/20 7:12 PM, Christian Brauner wrote:
> On Thu, Oct 01, 2020 at 10:58:50AM -0600, Tycho Andersen wrote:
>> On Thu, Oct 01, 2020 at 05:47:54PM +0200, Jann Horn via Containers wrote:
>>> On Thu, Oct 1, 2020 at 2:54 PM Christian Brauner
>>> <christian.brauner@canonical.com> wrote:
>>>> On Wed, Sep 30, 2020 at 05:53:46PM +0200, Jann Horn via Containers wrote:
>>>>> On Wed, Sep 30, 2020 at 1:07 PM Michael Kerrisk (man-pages)
>>>>> <mtk.manpages@gmail.com> wrote:
>>>>>> NOTES
>>>>>>        The file descriptor returned when seccomp(2) is employed with the
>>>>>>        SECCOMP_FILTER_FLAG_NEW_LISTENER  flag  can  be  monitored  using
>>>>>>        poll(2), epoll(7), and select(2).  When a notification  is  pend‐
>>>>>>        ing,  these interfaces indicate that the file descriptor is read‐
>>>>>>        able.
>>>>>
>>>>> We should probably also point out somewhere that, as
>>>>> include/uapi/linux/seccomp.h says:
>>>>>
>>>>>  * Similar precautions should be applied when stacking SECCOMP_RET_USER_NOTIF
>>>>>  * or SECCOMP_RET_TRACE. For SECCOMP_RET_USER_NOTIF filters acting on the
>>>>>  * same syscall, the most recently added filter takes precedence. This means
>>>>>  * that the new SECCOMP_RET_USER_NOTIF filter can override any
>>>>>  * SECCOMP_IOCTL_NOTIF_SEND from earlier filters, essentially allowing all
>>>>>  * such filtered syscalls to be executed by sending the response
>>>>>  * SECCOMP_USER_NOTIF_FLAG_CONTINUE. Note that SECCOMP_RET_TRACE can equally
>>>>>  * be overriden by SECCOMP_USER_NOTIF_FLAG_CONTINUE.
>>>>>
>>>>> In other words, from a security perspective, you must assume that the
>>>>> target process can bypass any SECCOMP_RET_USER_NOTIF (or
>>>>> SECCOMP_RET_TRACE) filters unless it is completely prohibited from
>>>>> calling seccomp(). This should also be noted over in the main
>>>>> seccomp(2) manpage, especially the SECCOMP_RET_TRACE part.
>>>>
>>>> So I was actually wondering about this when I skimmed this and a while
>>>> ago but forgot about this again... Afaict, you can only ever load a
>>>> single filter with SECCOMP_FILTER_FLAG_NEW_LISTENER set. If there
>>>> already is a filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER property
>>>> in the tasks filter hierarchy then the kernel will refuse to load a new
>>>> one?
>>>>
>>>> static struct file *init_listener(struct seccomp_filter *filter)
>>>> {
>>>>         struct file *ret = ERR_PTR(-EBUSY);
>>>>         struct seccomp_filter *cur;
>>>>
>>>>         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
>>>>                 if (cur->notif)
>>>>                         goto out;
>>>>         }
>>>>
>>>> shouldn't that be sufficient to guarantee that USER_NOTIF filters can't
>>>> override each other for the same task simply because there can only ever
>>>> be a single one?
>>>
>>> Good point. Exceeeept that that check seems ineffective because this
>>> happens before we take the locks that guard against TSYNC, and also
>>> before we decide to which existing filter we want to chain the new
>>> filter. So if two threads race with TSYNC, I think they'll be able to
>>> chain two filters with listeners together.
>>
>> Yep, seems the check needs to also be in seccomp_can_sync_threads() to
>> be totally effective,
>>
>>> I don't know whether we want to eternalize this "only one listener
>>> across all the filters" restriction in the manpage though, or whether
>>> the man page should just say that the kernel currently doesn't support
>>> it but that security-wise you should assume that it might at some
>>> point.
>>
>> This requirement originally came from Andy, arguing that the semantics
>> of this were/are confusing, which still makes sense to me. Perhaps we
>> should do something like the below?
> 
> I think we should either keep up this restriction and then cement it in
> the manpage or add a flag to indicate that the notifier is
> non-overridable.
> I don't care about the default too much, i.e. whether it's overridable
> by default and exclusive if opting in or the other way around doesn't
> matter too much. But from a supervisor's perspective it'd be quite nice
> to be able to be sure that a notifier can't be overriden by another
> notifier.
> 
> I think having a flag would provide the greatest flexibility but I agree
> that the semantics of multiple listeners are kinda odd.

So, for now, I have applied the patch at the foot of this mail
to the pages. Does this seem correct?

> Below looks sane to me though again, I'm not sitting in fron of source
> code.
[...]

Thanks,

Michael

PS Jann, if you see this, I'm still working through your (extensive
and very helpful) review comments. I will be sending a response.

======

diff --git a/man2/seccomp.2 b/man2/seccomp.2
index 9ab07f4ab..45a6984df 100644
--- a/man2/seccomp.2
+++ b/man2/seccomp.2
@@ -221,6 +221,11 @@ return a new user-space notification file descriptor.
 When the filter returns
 .BR SECCOMP_RET_USER_NOTIF
 a notification will be sent to this file descriptor.
+.IP
+At most one seccomp filter using the
+.BR SECCOMP_FILTER_FLAG_NEW_LISTENER
+flag can be installed for a thread.
+.IP
 See
 .BR seccomp_user_notif (2)
 for further details.
@@ -789,6 +794,12 @@ capability in its user namespace, or had not set
 before using
 .BR SECCOMP_SET_MODE_FILTER .
 .TP
+.BR EBUSY
+While installing a new filter, the
+.BR SECCOMP_FILTER_FLAG_NEW_LISTENER
+flag was specified,
+but a previous filter had already been installed with that flag.
+.TP
 .BR EFAULT
 .IR args
 was not a valid address.
diff --git a/man2/seccomp_user_notif.2 b/man2/seccomp_user_notif.2
index a6025e4d4..d1a406f46 100644
--- a/man2/seccomp_user_notif.2
+++ b/man2/seccomp_user_notif.2
@@ -92,6 +92,7 @@ Consequently, the return value  of the (successful)
 .BR seccomp (2)
 call is a new "listening"
 file descriptor that can be used to receive notifications.
+Only one such "listener" can be established.
 .IP \(bu
 In cases where it is appropriate, the seccomp filter returns the action value
 .BR SECCOMP_RET_USER_NOTIF .

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
