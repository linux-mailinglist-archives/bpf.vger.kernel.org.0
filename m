Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A668930E91F
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 02:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhBDBHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 20:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhBDBHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 20:07:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3659664E0A;
        Thu,  4 Feb 2021 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612400792;
        bh=YZcUAIbCt2hit811Im9XvKy28/ibVaifI212e7Pjmhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsGlkyRHGqbri37ST8w47sUZ3XmMZYX3fxRP1ZntAXy+F6bfK+XvfOiV3X2ImxMwe
         OooB2X1OZs1V7DdGfsAFtG/YW/Njx+aeKcRqL0gw8tL4ODOZYn216lWh2Uxd11mPhv
         mjKnlKMOhPNvTzX7Ey+ypsnVH8qTrizWBDh5trQ6R6qIyXXdAyXybv1AWI85Nl/wBu
         pYE7E9MpBePW5hU7Bhg2h9eZNRJ6nQ2OgTHHvH5Mdi5M/XQeVlYDsSCRBq53/cBHmQ
         dbCP38t8NjQKcdUewGW9WuCVCHvANPiVnktkVxsqd1FlzM1nYaJI/Cy3z4MNVRsQV6
         uV8qtgHkLSz6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BEB1340513; Wed,  3 Feb 2021 22:06:29 -0300 (-03)
Date:   Wed, 3 Feb 2021 22:06:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Wielaard <mark@klomp.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra
 checks for symbol names
Message-ID: <20210204010629.GB854763@kernel.org>
References: <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
 <20210128200046.GA794568@kernel.org>
 <CAEf4BzbXhn2qAwNyDx6Oqaj7+RdBtjnPPLe27=B0-aB9yY+Xmw@mail.gmail.com>
 <CA+icZUUTddV18rhZjaVif0a6BgpWtpj4mP1pyQ9cfh_e2xxvMQ@mail.gmail.com>
 <95233b493fd29b613f5bf3f92419528ce3298c14.camel@klomp.org>
 <CA+icZUU+XEMnrwgOSRhAaO1bn2p62P6g1KVKGyJfRqxt_jr0Ew@mail.gmail.com>
 <CAEf4Bzay-MS9mKc7N9Kc-eQBv1U5DomOY4VoBW=BQZaqs3f0kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzay-MS9mKc7N9Kc-eQBv1U5DomOY4VoBW=BQZaqs3f0kg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 03, 2021 at 03:21:58PM -0800, Andrii Nakryiko escreveu:
> On Wed, Feb 3, 2021 at 1:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > Looks like CONFIG_DEBUG_INFO_BTF=y makes troubles with LLVM/Clang.
> > Can we have a fix for Linux v5.11-rc6+ to avoid a selection of it when
> > CC_IS_CLANG=y?
 
> Let's first understand problems and try to fix them, please.

Yeah, from what I've read this is something only related to clang
building the kernel with DWARF5, right?

I just delayed to tomorrow releasing pahole 1.20 as its late here and
there is this discussion going on, what I have is at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.1.20

There is one patch more than what I think Sedat tried, that makes a
Mark's patch for DWARF_TAG_call_site{_parameter} to be applied as well
when processing inline expansions, which for what is being discussed
here seems unrelated, just avoids tons of warnings when processing
vmlinux with gcc 11 in fedora rawhide.

- Arnaldo
