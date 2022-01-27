Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A249EAF7
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiA0TVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiA0TVp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 14:21:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD8C061714;
        Thu, 27 Jan 2022 11:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDCC7B8234A;
        Thu, 27 Jan 2022 19:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B578C340E4;
        Thu, 27 Jan 2022 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643311302;
        bh=WRWq5IpSwMMUF+r1nwQfKOtmKgmeg4AixlRkp8n54eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0yu5T98cXObAkEGmkwgy18oo/fph8YLW5+/VoF/BFTCwa3WHAxON9jLdw1VN3v5v
         KM3DMiHNDEMgUDGfWZE7EX8c9F3caL0Fo9BMiHMKqp+zHJqf0s0wuUetAXxmvtvI31
         JcToCy0KZqSQYZiutmFgKHz5C+zmLMveuWwl1Rt2Zcp29+YuuNMEXHY6uzUx72+xnQ
         uiPxTe0Dqw7CLQjEtsicZfoNXF2GLSRnl/IRMygyO+jqnrsGrgAuIx9iAEPmBh18Bs
         fqTWy3/IhMFJ+Uwhj9sEBiWyn8OCoQAk4zTx/Q6ImvoJ/GE6B8mwmOCDJK86VIm0x2
         5i8B5wZ1pzlyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23B2540C99; Thu, 27 Jan 2022 07:05:11 -0300 (-03)
Date:   Thu, 27 Jan 2022 07:05:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Message-ID: <YfJuV9Sm3GfVqH+w@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-4-kuifeng@fb.com>
 <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 26, 2022 at 11:58:27AM -0800, Andrii Nakryiko escreveu:
> On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > Create an instance of btf for each worker thread, and add type info to
> > the local btf instance in the steal-function of pahole without mutex
> > acquiring.  Once finished with all worker threads, merge all
> > per-thread btf instances to the primary btf instance.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> 
> There are still unnecessary casts and missing {} in the else branch,
> but I'll let Arnaldo decide or fix it up.

Yeah, I'll do some sanitization, thanks for all the review!

- Arnaldo
 
> Once this lands, can you please send kernel patch to use -j if pahole
> support it during the kernel build? See scripts/pahole-version.sh and
> scripts/link-vmlinux.sh for how pahole is set up and used in the
> kernel. Thanks!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  btf_encoder.c |   5 ++
> >  btf_encoder.h |   2 +
> >  pahole.c      | 125 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 124 insertions(+), 8 deletions(-)
> >
> 
> [...]

-- 

- Arnaldo
