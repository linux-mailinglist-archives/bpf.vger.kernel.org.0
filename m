Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81230B8EA
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBBHt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 02:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBBHtX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 02:49:23 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C1C06174A;
        Mon,  1 Feb 2021 23:48:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b187so5448814ybg.9;
        Mon, 01 Feb 2021 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTgnxV4+sEWrA1Wks3E2hJC5HV3CMr0sX+l9RmTre/w=;
        b=AaBOs1Ru/uoqWd/fHRBX2YO2CPwo1si9mYUXREqa8BNx+lUA3Fir/LYPUCvy8zbMI7
         pbiMOJuvtV3x1+cryA1X/zEzTi6TMMQRkER4/ZY4P2GZqHYG5iyT2RO4SUevlxk3vRse
         b89sqlchmUm4k02+DTrLfKFaoo7bdHMsKKMQWVy11K3pEIS0Yv6K5AV9+S7/8ST3UuTH
         pJAs1LMqy8c3NVqP55dwPOyo97AKFNqV/6LhVqj04XsVSPGthtOLPb2DZhLz1g7UNlnm
         BtLj2S7IX8UKMPHwGoMS68GOC7GuqgKkTj6oYawwrFvpmacHMKNzLQrlDaqI7lbaIxhN
         swkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTgnxV4+sEWrA1Wks3E2hJC5HV3CMr0sX+l9RmTre/w=;
        b=bG4ObU8vq+YXagnE1pnezpDAICVshXRniSVAeSScpDHyQGNytGHZhTBFYBhimUizSs
         yB8kX/QMEZdFJscZnbqHp3QNk9K3KaFEa7w3tY0YqIgJQpk7zxeUBfcWPAgnwY22jEqX
         SZAi11BmIWKdsNovxps4/vaLyDMFiPXrXy0lO2UhBM1B6wKbrbGJICEEwqEpiumwfpPO
         NC0P+UWX8x5g5rEICT+1KEzojBR37/WhdJm6Lz3BwR6+2A549WI7Ea0+wxrI2vR3aXEI
         90zI8kTAKWhje52AzjUWLmYKSIdDcq9O5B46TneiymfLm9cwA2SXyyC0OLisGCdO5peA
         F23Q==
X-Gm-Message-State: AOAM530uDc/m+DfIroZv2vB9UkkCKor97zJ1Lbsw3jcNL0PZ4g8IR7sC
        YUp+F3z9HM/9UoECHeZyEKn+VRsRVpwStAhbMVo=
X-Google-Smtp-Source: ABdhPJzb6QRLNIs1Utk2oI4rqA0kbxcCRyQoEUBSYc/DnpqM9mJBcaZBoKSWHaL496EEBPWSKifoHPmv/dSGkp+TUcI=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr30111092ybd.230.1612252123007;
 Mon, 01 Feb 2021 23:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com> <20210128200046.GA794568@kernel.org>
In-Reply-To: <20210128200046.GA794568@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Feb 2021 23:48:32 -0800
Message-ID: <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
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

On Thu, Jan 28, 2021 at 12:00 PM Arnaldo Carvalho de Melo
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

Hi Arnaldo,

Sorry for the delay, just back from a short PTO.

It all looks to be working fine on my side. There is a compilation
error in our libbpf CI when building the latest pahole from sources
due to DW_FORM_implicit_const being undefined. I'm updating our VMs to
use Ubuntu Focal 20.04, up from Bionic 18.04, and that should
hopefully solve the issue due to newer versions of libdw. If you worry
about breaking others, though, we might want to add #ifndef guards and
re-define DW_FORM_implicit_const as 0x21 explicitly in pahole source
code.

But otherwise, all good from what I can see in my environment. Looking
forward to 1.20 release! I'll let you know if, after updating to
Ubuntu Focal, any new pahole issues crop up.


> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
>
> ?
>
> The cset has the tests I performed and the references to the bugzilla
> ticket and Daniel has tested as well for his XDR + gcc 11 problem.
>
> Thanks,
>
> - Arnaldo
