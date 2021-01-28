Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E2307F19
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 21:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhA1UEd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 15:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhA1UBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 15:01:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1513F64DFD;
        Thu, 28 Jan 2021 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611864051;
        bh=LaGtbHwf4J0cz2TJ0XFzrCRPky7RpimSe/7KGVCTzpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUhKKzXGt/2Ah20x0Ss/V5peHD1FmHpDSgtrROWE9BDDQX43vhMPiOL+uH/NjDQvS
         3btva1b07FLVbH05ssIsu8GjHpF3QtTmdFztyFPmkZdwO61AwQWF2M96tHl80T9RxM
         zpcu3IaKeKOJbVYxp73mOInGWM9XPDiHI246LLUk6oUj7uarGoKrf7pmqnFGPLKlf/
         Hb7XSYizyDfEKIx07uQ/rkOR2vX9KC7EB+76JCDoOH+9YGv/rJcRau2hIDZSDYYkwX
         aJiy07gKnpy7/DwpuGQXz9DBjSj+jD0WnKfphb2BMNoY31ZEuTJxnlcJH4wBxme83z
         vFsc/47XX3Omw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81CF240513; Thu, 28 Jan 2021 17:00:46 -0300 (-03)
Date:   Thu, 28 Jan 2021 17:00:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Mark Wielaard <mark@klomp.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: [RFT] pahole 1.20 RC was Re: [PATCH] btf_encoder: Add extra checks
 for symbol names
Message-ID: <20210128200046.GA794568@kernel.org>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org>
 <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
 <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
 <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 21, 2021 at 08:11:17PM -0800, Andrii Nakryiko escreveu:
> On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > Do you want Nick's DWARF v5 patch-series as a base?
 
> Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
> it up to him. I'm curious about DWARF v4 problems because no one yet
> reported that previously.

I think I have the reported one fixed, Andrii, can you please do
whatever pre-release tests you can in your environment with what is in:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset

?

The cset has the tests I performed and the references to the bugzilla
ticket and Daniel has tested as well for his XDR + gcc 11 problem.

Thanks,

- Arnaldo
