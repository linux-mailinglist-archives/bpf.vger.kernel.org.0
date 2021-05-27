Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A083936BC
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhE0T6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbhE0T6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 15:58:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380DC061574;
        Thu, 27 May 2021 12:57:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k4so1945861qkd.0;
        Thu, 27 May 2021 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Fwp/m0jaIQUr6Ktnj2mzMS00PxmRloLtQtG4O3COx5o=;
        b=W1O7amDsoGJyGZA2rtsLZvLFW01VQAwnF+Qgbu57PRkyQVb9J3bh48QGImqzEgNDyD
         p1pENaoJaNSwA4TFy3y1NLlNrhSW/NaWJJqq+eWgiEhzbXGv/Uc21nK+2MaR/HJK5K48
         LcK+0W8DqCyFprvWwj+a7rFSYA3XBdHtEDtS9MtMEzDW/1SAX4tEBZ5/V9FDotvemL7E
         g4PMnhGDlF/3Bid54Bn8rrkiv4uwNEajffkmi5XwybFBKLkEs7zQ5Zomp1M2r4Oko186
         7mzjpvCJexUxo6JT57k0n14phH8z7LOhTcjLjUf5RYJPnT6sJSX9Z0t/2r7iuCDRNdO0
         Vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Fwp/m0jaIQUr6Ktnj2mzMS00PxmRloLtQtG4O3COx5o=;
        b=ZkhBabgiWrNm5MpfO/zMaTsXzHF+QgpMHxeD0OZv7xVkUk06I7LhVtcC1RQKSHyQPC
         XURs/mxYOTgrkUf5+C6FGzH9CDLyUaM0jFaOVoVoNIpJmq+xIdokafd/3mL0o1aSiJiF
         0Vz1mb2Ix47wxCQ1goekS9NveoJwIZ2WU9pD8ECqHmRHS0JMXYZwofV+PLYzAJYNSUdc
         j5Wsvam2KNBERZepxfS2eDEWLFcjKBFrZ880v7WWyI7hNS/KsaJNVWMJgpUtLQvq1lfp
         Un7W3ZWEveI0d+LMJuz27Yiu7BaqfIpJv4wADTdbxVXW3cJUPOteydRpwaLRG/8zDXJy
         hbcw==
X-Gm-Message-State: AOAM533DzUkEFLdBr6yWnNyC7BtwJ8AHbEDOIphsOtrYh9wgoPohunhD
        +MoUJrr4LIOCOd1WteGHJmQ=
X-Google-Smtp-Source: ABdhPJzeKzcZ8hFqnjIbqrCIqyhJceunpYSGdCP04oLs8U0XQveFaV1+b8i5//EuFuewqb+1RGIfPw==
X-Received: by 2002:a37:a4c1:: with SMTP id n184mr165740qke.309.1622145426812;
        Thu, 27 May 2021 12:57:06 -0700 (PDT)
Received: from [172.16.141.208] ([187.68.192.38])
        by smtp.gmail.com with ESMTPSA id h16sm2063269qke.43.2021.05.27.12.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:57:06 -0700 (PDT)
Date:   Thu, 27 May 2021 16:55:52 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com> <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFT] Testing 1.22
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakryiko@g=
mail=2Ecom> wrote:
>On Thu, May 27, 2021 at 12:06 PM Arnaldo <arnaldo=2Emelo@gmail=2Ecom>
>wrote:
>>
>>
>>
>> On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko
><andrii=2Enakryiko@gmail=2Ecom> wrote:
>> >On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
>> ><acme@kernel=2Eorg> wrote:
>> >>
>> >> Hi guys,
>> >>
>> >>         Its important to have 1=2E22 out of the door ASAP, so please
>> >clone
>> >> what is in tmp=2Emaster and report your results=2E
>> >>
>> >
>> >Hey Arnaldo,
>> >
>> >If we are going to make pahole 1=2E22 a new mandatory minimal version
>of
>> >pahole, I think we should take a little bit of time and fix another
>> >problematic issue and clean up Kbuild significantly=2E
>> >
>> >We discussed this before, it would be great to have an ability to
>dump
>> >generated BTF into a separate file instead of modifying vmlinux
>image
>> >in place=2E I'd say let's try to push for [0] to land as a temporary
>> >work around to buy us a bit of time to implement this feature=2E Then,
>> >when pahole 1=2E22 is released and packaged into major distros, we can
>> >follow up in kernel with Kbuild clean ups and making pahole 1=2E22
>> >mandatory=2E
>> >
>> >What do you think? If anyone agrees, please consider chiming in on
>the
>> >above thread ([0])=2E
>>
>> There's multiple fixes that affects lots of stakeholders, so I'm more
>inclined to release 1=2E22 sooner rather than later=2E
>>
>> If anyone has cycles right now to work on that detached BTF feature,
>releasing 1=2E23 as soon as that feature is complete and tested shouldn't
>be a problem=2E
>>
>> Then 1=2E23 the mandatory minimal version=2E
>>
>> Wdyt?
>
>If we make 1=2E22 mandatory there will be no good reason to make 1=2E23
>mandatory again=2E So I will have absolutely no inclination to work on
>this, for example=2E So we are just wasting a chance to clean up the
>Kbuild story w=2Er=2Et=2E pahole=2E And we are talking about just a few d=
ays
>at most, while we do have a reasonable work around on the kernel side=2E

So there were patches for stop using objcopy, which we thought could uncov=
er some can of worms, were there patches for the detached BTF  file?

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
