Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAE3935F2
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 21:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhE0THu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 15:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhE0THu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 15:07:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23B2C061574;
        Thu, 27 May 2021 12:06:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q10so1747920qkc.5;
        Thu, 27 May 2021 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=h7vvVXSySNhPv8SRj++Jueyu0vH2GO6PLTFcEgK20MY=;
        b=U8Gi6Wzci5VoP+H4EOizvAqR6dNZ+DoVaeq1Uq7cfguZBVSILyXszXK5XffdUNjmcI
         pwZJUeGO2DhWAJEM+uWZvegONdhctRWi/Ak56MdS0jKcV5Vf9y0r/AqzAyL0Wj5jVnGM
         EyDPaoCWA0v+aoiEhhOhqKfkg1j2ItA5aZ2lvOxR739kQ8pgHUVgSCVDAEz7+SineI5N
         FcjQkSQBN38PQ5ST/Zko06DJiF9SSjJf5eAgjgJy+jvQNY2rpP/wkdrhT6afV+eykdCl
         flp17N8capjJ7NXyugn1CDAcdPwNg9Lr2LYexzVJTRSTKQFaPVX7R3HRHGfhFi9wg/FQ
         hEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=h7vvVXSySNhPv8SRj++Jueyu0vH2GO6PLTFcEgK20MY=;
        b=L+4YVNfbCI3DbvqPjgXuldhgeXpac/xNjOmegN/I3RVrtZI+bmFCpZe7fEcsRd9GMp
         0EtPeC0k/xRtyp39Xh//aEe5LxSRPdpk1oIqt/IbCZLhgcCqsik3sniuo+iXQdRrRmb7
         xXpDj5iEpvSMfnW6kfrawaibfy0Un3VkkRN/cmVh+DPh+3cYafGwNsKf86g4gmnDvxYJ
         W5X1eE4fR41oYdK/h0JGWoC8i9TkGN64S22k2J1IXFnkR1Qs2/bU4J/1ZvKS7F1KLnlH
         Ccr0+hiNAU3wE2kAsy6Lfwi5CGgOn0klfvDK/3hb7KvX9mOI/+qSRVdM0yFDliUJ7biU
         eTpg==
X-Gm-Message-State: AOAM533RDLQxmy2mBNZ5LQylcuUZ845bCkDYkpvauxPs0khk/FiMs1sF
        wexF98/dK1vExZ9cTmGDTnc=
X-Google-Smtp-Source: ABdhPJw9cn2gOXNXRSurLPjhEPvEhRJanzaNjulRQPT4fe6oXhd6y2FLNhMAXrXqDHCvPHGQWX5TRQ==
X-Received: by 2002:a05:620a:1334:: with SMTP id p20mr5093151qkj.7.1622142374916;
        Thu, 27 May 2021 12:06:14 -0700 (PDT)
Received: from [172.16.141.208] ([187.68.192.38])
        by smtp.gmail.com with ESMTPSA id s16sm1829451qtq.67.2021.05.27.12.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:06:14 -0700 (PDT)
Date:   Thu, 27 May 2021 16:04:58 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFT] Testing 1.22
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On May 27, 2021 1:54:40 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakryiko@g=
mail=2Ecom> wrote:
>On Thu, May 27, 2021 at 8:20 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Hi guys,
>>
>>         Its important to have 1=2E22 out of the door ASAP, so please
>clone
>> what is in tmp=2Emaster and report your results=2E
>>
>
>Hey Arnaldo,
>
>If we are going to make pahole 1=2E22 a new mandatory minimal version of
>pahole, I think we should take a little bit of time and fix another
>problematic issue and clean up Kbuild significantly=2E
>
>We discussed this before, it would be great to have an ability to dump
>generated BTF into a separate file instead of modifying vmlinux image
>in place=2E I'd say let's try to push for [0] to land as a temporary
>work around to buy us a bit of time to implement this feature=2E Then,
>when pahole 1=2E22 is released and packaged into major distros, we can
>follow up in kernel with Kbuild clean ups and making pahole 1=2E22
>mandatory=2E
>
>What do you think? If anyone agrees, please consider chiming in on the
>above thread ([0])=2E

There's multiple fixes that affects lots of stakeholders, so I'm more incl=
ined to release 1=2E22 sooner rather than later=2E

If anyone has cycles right now to work on that detached BTF feature, relea=
sing 1=2E23 as soon as that feature is complete and tested shouldn't be a p=
roblem=2E

Then 1=2E23 the mandatory minimal version=2E

Wdyt?

- Arnaldo


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
