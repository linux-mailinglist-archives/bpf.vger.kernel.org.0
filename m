Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5B27959D
	for <lists+bpf@lfdr.de>; Sat, 26 Sep 2020 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgIZAed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 20:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgIZAed (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 20:34:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CB1C0613CE
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 17:34:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so4828505pfc.7
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LQhUSgVwoAzLw92Ygh+sbDkDg9VzTVlbdTb6qu/28UI=;
        b=0UCfcG1B3lmiWLRmVTEkHEUvtYL/+yhH6MaR4BWOvVAYPKMPznhtEUKI/JMwclvII0
         9ugielLLHq/9jC2MBpemsPqqbJ04Wlymmt1JLIvfwrsKOq0QR3OAKlahWJSDERU7+31q
         JuZ9/lnzx2HUSbV0cfM6jynGVVFsUOKZd+x0a9PyXqhvpJQHpAvqteHU50MiHkuhTuTW
         YpimImgQ1rDbVJ8Q1YqS2+R/5tuTyvJC4lKAIbQY5qB+v2UsPjZ/S1g/VyaRpd/gWf2o
         TwKgb9LFhMCnYONj4IYLFVgofXdBJggPp5ck/xABw8LJD/FLU11+fRzv1l0E3btCfsd4
         Q72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LQhUSgVwoAzLw92Ygh+sbDkDg9VzTVlbdTb6qu/28UI=;
        b=YQuGSI2fwBz7hHxmch8CRKyWRETk9VPVLscJbtv/PrA+v3UEX7+JSjdX/r5drC98fu
         vqsE6p3SiHqDsidxFnq0g5PsJNEQayYy1dBQks4gAQX4WhpusjLk4Lj8yYpNuh6XWGBN
         gY/Su2fIoBbikzwyplVp3vq985VguM7QIi2Bqdibjy624wLWYTqevI94WJjjwI6lZjRH
         OwZOJMNuMgTBcEO1aG/58FmSYwqpdAfO4NazqxToNPu4aRfIYDBv8SjGYdWH2XqoNU//
         HgGoV1YviyAwJa7vZUwOTbXJ04VO0vCBPCExUYw1YpmZfuI4j+Qsdz2J6H15BgxbFHkv
         WuOw==
X-Gm-Message-State: AOAM533k2qHH85Na2UO5B33U+uw48nEldjWlThGjsIvLB8lJnWCz/Fwt
        ERgiEsF/0QCu+jlOHZ1jrrPyZQ==
X-Google-Smtp-Source: ABdhPJz4QibazbedTmXsQcRaU2pyUx8+oz1N5Q2XhtYTgoF1usymw1iGqYSgVjNPq/RGgqqdBMYJXQ==
X-Received: by 2002:a63:4a43:: with SMTP id j3mr1190597pgl.42.1601080473158;
        Fri, 25 Sep 2020 17:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:c200:1ef2:480b:55cd:6a45:1705])
        by smtp.gmail.com with ESMTPSA id a71sm3563540pfa.26.2020.09.25.17.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:34:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if filter is arg-dependent
Date:   Fri, 25 Sep 2020 17:34:29 -0700
Message-Id: <677FA6F9-D577-4594-9FDC-D70B0D6900C6@amacapital.net>
References: <202009251648.4AA27D5B@keescook>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
In-Reply-To: <202009251648.4AA27D5B@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 25, 2020, at 4:49 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 25, 2020 at 02:07:46PM -0700, Andy Lutomirski wrote:
>>> On Fri, Sep 25, 2020 at 1:37 PM Kees Cook <keescook@chromium.org> wrote:=

>>>=20
>>> On Fri, Sep 25, 2020 at 12:51:20PM -0700, Andy Lutomirski wrote:
>>>>=20
>>>>=20
>>>>> On Sep 25, 2020, at 12:42 PM, Kees Cook <keescook@chromium.org> wrote:=

>>>>>=20
>>>>> =EF=BB=BFOn Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
>>>>>> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> w=
rote:
>>>>>>>> Why do the prepare here instead of during attach? (And note that it=

>>>>>>>> should not be written to fail.)
>>>>>>>=20
>>>>>>> Right.
>>>>>>=20
>>>>>> During attach a spinlock (current->sighand->siglock) is held. Do we
>>>>>> really want to put the emulator in the "atomic section"?
>>>>>=20
>>>>> It's a good point, but I had some other ideas around it that lead to m=
e
>>>>> a different conclusion. Here's what I've got in my head:
>>>>>=20
>>>>> I don't view filter attach (nor the siglock) as fastpath: the lock is
>>>>> rarely contested and the "long time" will only be during filter attach=
.
>>>>>=20
>>>>> When performing filter emulation, all the syscalls that are already
>>>>> marked as "must run filter" on the previous filter can be skipped for
>>>>> the new filter, since it cannot change the outcome, which makes the
>>>>> emulation step faster.
>>>>>=20
>>>>> The previous filter's bitmap isn't "stable" until siglock is held.
>>>>>=20
>>>>> If we do the emulation step before siglock, we have to always do full
>>>>> evaluation of all syscalls, and then merge the bitmap during attach.
>>>>> That means all filters ever attached will take maximal time to perform=

>>>>> emulation.
>>>>>=20
>>>>> I prefer the idea of the emulation step taking advantage of the bitmap=

>>>>> optimization, since the kernel spends less time doing work over the li=
fe
>>>>> of the process tree. It's certainly marginal, but it also lets all the=

>>>>> bitmap manipulation stay in one place (as opposed to being split betwe=
en
>>>>> "prepare" and "attach").
>>>>>=20
>>>>> What do you think?
>>>>>=20
>>>>>=20
>>>>=20
>>>> I=E2=80=99m wondering if we should be much much lazier. We could potent=
ially wait until someone actually tries to do a given syscall before we try t=
o evaluate whether the result is fixed.
>>>=20
>>> That seems like we'd need to track yet another bitmap of "did we emulate=

>>> this yet?" And it means the filter isn't really "done" until you run
>>> another syscall? eeh, I'm not a fan: it scratches at my desire for
>>> determinism. ;) Or maybe my implementation imagination is missing
>>> something?
>>>=20
>>=20
>> We'd need at least three states per syscall: unknown, always-allow,
>> and need-to-run-filter.
>>=20
>> The downsides are less determinism and a bit of an uglier
>> implementation.  The upside is that we don't need to loop over all
>> syscalls at load -- instead the time that each operation takes is
>> independent of the total number of syscalls on the system.  And we can
>> entirely avoid, say, evaluating the x32 case until the task tries an
>> x32 syscall.
>>=20
>> I think it's at least worth considering.
>=20
> Yeah, worth considering. I do still think the time spent in emulation is
> SO small that it doesn't matter running all of the syscalls at attach
> time. The filters are tiny and fail quickly if anything "interesting"
> start to happen. ;)
>=20

There=E2=80=99s a middle ground, too: do it lazily per arch.  So we would al=
locate and populate the compat bitmap the first time a compat syscall is att=
empted and do the same for x32. This may help avoid the annoying extra memor=
y usage and 3x startup overhead while retaining full functionality.=
