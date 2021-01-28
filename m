Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC6308007
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 21:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhA1U6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 15:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhA1U6H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 15:58:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F5C061573;
        Thu, 28 Jan 2021 12:57:26 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id l4so6559468ilo.11;
        Thu, 28 Jan 2021 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=i9REdMi6SebWG3JZ7lgPYTN/NgmA8D8mxCSnCKhI23s=;
        b=awtT27WDnqMlsreiZ5miMG1XQEuMR5MnbJY1RrnQYJ+FhUVmxbcGc8k4Jpkxm12XFJ
         Tn/fgl2nmNDGTQ2jkdSUdUzyXnO3xpVxWuF1LgDVj0gdjLynM97q3PJ/QuUYZejtHR+V
         M1c3XIobqVU3pnQml2FvBrdxsux2EKC5P47vOYuzYRgAssutvK9iDNmv3z4okM3sMWSU
         x/hgYmRx4zk48E3X/iiCvu4a9X5UCBQkFLs5M8++qpVac4Wele3RwZhmaGkFWBpsNp2h
         ZRPHPyaRBCvnF6UU6FAsdI4jNqTDOtR6bOK6tvpKVoR7IIOgu25WCTWwLxiUHW0icuWU
         lLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=i9REdMi6SebWG3JZ7lgPYTN/NgmA8D8mxCSnCKhI23s=;
        b=nGsnjnSlCjxE+WMrXU6FnHbDxsTMcYSABUi+buXrPF0gt2+WPTLsGJwqMp5BxTzNzr
         lP6s8XYxglY9NZzbv0cqSb9aC0AdqxOLqNQ3eyguPGPyKBRwiut6CPqk9BCqQDOwjfAW
         LufdaWCRi7G5eMJV9/kzWm841RvDgFUVlrjmQHhP4D/WT4O07DXZN72OzjKDGTFLl0SP
         E8OqwLuRyDZLAjJyh19WuztNQ7U/tcZuCEAm9mmOlAezS7Fq32TV60eNfJhy4SRV5jul
         o4azyythn2fKHxx3EXJZbo8TK90ep9hS/38iJeO/3Otg1vs/xb3fDxnSuK0n4xbfDNQu
         DFYA==
X-Gm-Message-State: AOAM530oqM0FWmW+12WHIJ38bn8HLO27tOZPl6UCNp21bSjwzAta4vus
        YYZTidDQijfeUJQEFWFSCOw13Gjlc04aYdMc9vU=
X-Google-Smtp-Source: ABdhPJwq9M4gqcXGgf3hWfRmyOnXAcHDSeKfUjxHN1tLzqeVQBFL4f7mHskBkk+tSon6+ETF4OEa6958BCGpXlBlQxg=
X-Received: by 2002:a92:c5c8:: with SMTP id s8mr721637ilt.186.1611867445626;
 Thu, 28 Jan 2021 12:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com> <20210128200046.GA794568@kernel.org>
In-Reply-To: <20210128200046.GA794568@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 Jan 2021 21:57:14 +0100
Message-ID: <CA+icZUWi_3=T2B-bv4dd6D78rpHKVyYrkpxEVcXPW5saqHttCg@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Mark Wielaard <mark@klomp.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 9:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jan 21, 2021 at 08:11:17PM -0800, Andrii Nakryiko escreveu:
> > On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > Do you want Nick's DWARF v5 patch-series as a base?
>
> > Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
> > it up to him. I'm curious about DWARF v4 problems because no one yet
> > reported that previously.
>
> I think I have the reported one fixed, Andrii, can you please do
> whatever pre-release tests you can in your environment with what is in:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
>
> ?
>
> The cset has the tests I performed and the references to the bugzilla
> ticket and Daniel has tested as well for his XDR + gcc 11 problem.
>
> Thanks,
>

What Git tree should someone use to test this?
Linus Git?
bpf / bpf-next?

- Sedat -
