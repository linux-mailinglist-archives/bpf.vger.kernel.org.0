Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A3C2AE4EB
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 01:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgKKAaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 19:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgKKAaQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 19:30:16 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B5C0613D1;
        Tue, 10 Nov 2020 16:30:14 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id z17so106841qvy.11;
        Tue, 10 Nov 2020 16:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=DI9RVWIS9OEcYmrism63DknzHCRsoU98xjZvRuuCt/E=;
        b=B5XiEygs3KeTOXueERvPqhcVPadxwQTS2jJwtU+YG/2qlum9/tGePw979larfX8bGY
         CTw2NQqd/Wfb3V4duz+b8R92tQd5S4ZOCpps1DNeb8D6Dtjm5CgTvMEy0x57FVs1qhE5
         Z28vZnyZe5B1HNzGyyhSX1eUkMymZhKYHxG455G6SBOCcV++IneSWNDOlQAwSJJ7IhKZ
         bf2fxcKiMnj4awdg3w3GGYgyB/CDMtY7lmys5E4MZ9ErM7QNJ69vS0QQxYr6ia02LlNl
         ne6v20ko8lpT1ZhVOqkNMFaD0c5jIPwyq1y5cX9RAvNgLhNMHo16u6+WxOPSp+35QSFn
         1/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=DI9RVWIS9OEcYmrism63DknzHCRsoU98xjZvRuuCt/E=;
        b=kkuUF24Hza28V8UWVY3gxfXqg1HaFmzVENwSrks8jbzFIujhktH1g886edt0nqC/a2
         FLeOxGi0UTSS9HhUuq/FPjvPAWFk6K8B7UEWPqHb4+Lyh3WGJFasnkx5GE7LeGqPPYsa
         C3k9IiHxGgP2nADoz67zIneJcB1syVDV8JzuBPuiEPxG6q2KBdDeUmzzo6BEL7aCSHKJ
         +dMnc2D8WkiXPR1208WWr0/x8BKJRf1+tFUXjIzeKeht7Y3yIzLYJOBhjJT0TqNlRewm
         Yia9KRCg3yNZBwcdLofQf5vCZGtToIYNWdPvmFGberfuzZHiiG/f4Vry1a1L4I7ZGZhE
         sXXw==
X-Gm-Message-State: AOAM530RCw22LKQmdXlsDdjiPaLmOWGynUUvoDoUujy55g0LuYuR3h64
        4ylUzR7n5mDLveRCRcRuvSWdgmjLDomWyg==
X-Google-Smtp-Source: ABdhPJwWMzgM5TqHomoldbrEb5bSNqJp/56UUmoPgQXDfpE0H8cqhtY+UvzxCWtb/X/nJXH32lO+JA==
X-Received: by 2002:a0c:bda2:: with SMTP id n34mr14851151qvg.28.1605054613789;
        Tue, 10 Nov 2020 16:30:13 -0800 (PST)
Received: from [192.168.86.242] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a85sm519058qkg.3.2020.11.10.16.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:30:13 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:29:48 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEf4BzZGXQaDEwASyaJ39AAZ7TWnbi89pgrwXB5uFi861c9CCA@mail.gmail.com>
References: <20201106052549.3782099-1-andrii@kernel.org> <CAEf4BzZGXQaDEwASyaJ39AAZ7TWnbi89pgrwXB5uFi861c9CCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves 0/4] Add split BTF support to pahole
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <348BC25F-0DDF-416E-8659-0C4B09F0A767@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On November 10, 2020 8:34:18 PM GMT-03:00, Andrii Nakryiko <andrii=2Enakry=
iko@gmail=2Ecom> wrote:
>On Thu, Nov 5, 2020 at 9:25 PM Andrii Nakryiko <andrii@kernel=2Eorg>
>wrote:
>>
>> Add ability to generate split BTF (for kernel modules), as well as
>load split
>> BTF=2E --btf_base argument is added to specify base BTF for split BTF=
=2E
>This
>> works for both btf_loader and btf_encoder=2E
>
>Arnaldo, can you please take a look at these patches? Would be nice to
>get them landed ASAP so that we can start testing out kernel module
>BTFs without locally applying patches first=2E Thanks!


I've been working on prepping up v1=2E19, will process these patches first=
 thing in the morning, tomorrow,

Thanks,

- Arnaldo
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
