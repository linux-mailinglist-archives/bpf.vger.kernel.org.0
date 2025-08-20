Return-Path: <bpf+bounces-66060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D0BB2D349
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 07:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF52A5B8F
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E42367CF;
	Wed, 20 Aug 2025 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V76uM3GR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2219C542
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666572; cv=none; b=hBlBoXb0o9INbqAg154WaH1LBpD6sXnlvArxwjWeW2Inwm4R5lhIFFRzOoT8n3/jguUUeIYEubd353RyJ2z9aIu07D7vnmoGl1gOHdE4wAM1jgEiRIWY+PSniX73Qjhj30jqHeZMY7CSX67v0O/0VJZDsw6rMSdmwtGCfW60gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666572; c=relaxed/simple;
	bh=NpGfwdXW0cfbCohlI3oL+yDFMyTaSXXJ5sijIVarCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6TN/dnBkrXiCuMtM4b27e+BtLUDBjkTAbu1Wex4bU2qXpXwnCkuhL2vJg/27+SNzU2qSnKVkPDsNN0b0B9gffSfgCrL452kN95uEDv7UOFy2qTtFEMV+ST/cyehk0HuxkZ2tYfmXE35bRa57anRblB8XW0nyDeMPU3sDd97J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V76uM3GR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so360450f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 22:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755666569; x=1756271369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bEeb9o3UAnGjwo7IDfQ/kIK6xxwB41tUnqNh7/1rLQ=;
        b=V76uM3GRtRmfF0GRcuQZ6Gb3gbjdtTwu1pzDD57bEj2bcjBSYJCBvbMycXHfQRzaem
         DGN2Dv74AW0DHVllVOxxc9wQx+aCt3Mv/DxMbB+Wcpbk9kt8kj2fP/AB41zGwbRT8DJq
         Cgqe0njwUiNzo+1BZ3lLCijO/OeLAcG5GEJNLwjdUdE4gNgRvASIQbB4BMJ5xybbcRIM
         CHRHQRynM3nJQ11jMCySIjGepItSqqiBc2aaqrTnepzTukPmD8X6rWopvizG6yF17by+
         nf+QC6SVCvuRdMcxWQ8P+e9xaHmGHkOvXFuInwUQAxJlcch0+ALYAw2bqb/877p/vOgE
         D1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755666569; x=1756271369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bEeb9o3UAnGjwo7IDfQ/kIK6xxwB41tUnqNh7/1rLQ=;
        b=iGlHac1rcLYqmXa8m7qq5PPSg3p63ZmQc22wXdchZpsedPtAIpQ9oj72m5057Ecq1Y
         N8BwB/bOxVzwViifM4RMQ3drbHyoznnH7Qbg3lhRCVL10Urdlaxp1xLc/H0TwiCGJ1A4
         VxsxRuOEC2w4i+dDjpoLZzHV2DacsMXajXWL+HT8PtW3mlT21Ec1zp9PrKQHvLXg80TG
         3xcsG3tWInjGiOZOA/qXTx/t+zG4tmBt7lkSHAdauh8Zyrs9ZmFc+ph6Kb1nVfQMzPSS
         4ZglmP2C3TbvLl+gaA5mqHrdFYVyjcjJpRg4YsWlkH5n3azwXFppCP0VrXZKiCGR/2am
         wJCA==
X-Gm-Message-State: AOJu0Yx3wOmvsHgQuDXQULuL4Xq7pZa7DRnHiMyXRnrf1mLp6vUoWsxw
	2JID1QjcmBQ0YndSAOXoNcfgRiKQqUsQyl3J1HYkKMzCNiSnjsulIvPc668orletXxY=
X-Gm-Gg: ASbGncurgZqM6cAxefy7Ziqdkpc/vCHdiRgGD+wPchZCEvbXXaR82N1gJ5F943ccvKH
	NUCOV/dt5nf2Cim0cBd07RDiD4A34KWdh4+bQNcXt8NqqRcZd1SVWQur5KqAUWClvKO5JNGZofA
	7I4UQ9iqal3KjVbvhsEBq9v6EWE30NImDjwJ07qtNfoGfCFyT0Sfvi72DQXbpkUXmUxjv7HDD9f
	P03JRN/+2ceFtXaXQrgN65skpiNCG93S6Mza80pyWfX2C/3yZNq7wWKaTr1/s3VQA+Y3+YSgHJ6
	az2QSaBZffxa+mGHc1W76jCWf78Kw+Tsk5zLSRYpj/cfNVdTlZFbSODl2pSv5gtcgwJvfZvPAQP
	9yvHvR8JrUQ0v2CeDfdoyyHgQy55S
X-Google-Smtp-Source: AGHT+IFOwt23ISnS2EebVxEj8DBkpSr2TJYPurwHoOef+c97ML5p2QHg8Zr7VY2ze3Sjr9mwZWDrRg==
X-Received: by 2002:a05:6000:420b:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3c133c6ec8amr3826493f8f.27.1755666568744;
        Tue, 19 Aug 2025 22:09:28 -0700 (PDT)
Received: from u94a ([2401:e180:8d22:bc2c:a01b:6199:b8b3:7622])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e256a2basm968118a91.19.2025.08.19.22.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:09:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:09:22 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use tnums for JEQ/JNE is_branch_taken
 logic
Message-ID: <d5uns2wnicohhp77ufr4kbzsjsughmnvo7c2ws44c5tndlkmg6@zla452ef6qs4>
References: <ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
 <hxshkvnzsyrmnty25ainifbei732oco3ss6y76iez2cdsxa77q@cdnvjuhsp6c2>
 <aKNmZZ3L3ws8NUth@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNmZZ3L3ws8NUth@mail.gmail.com>

On Mon, Aug 18, 2025 at 07:44:05PM +0200, Paul Chaignon wrote:
> On Thu, Aug 14, 2025 at 08:55:22PM +0800, Shung-Hsi Yu wrote:
> > On Wed, Aug 13, 2025 at 05:34:08PM +0200, Paul Chaignon wrote:
[...]
> > > @@ -15891,6 +15891,8 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
> > >  			return 0;
> > >  		if (smin1 > smax2 || smax1 < smin2)
> > >  			return 0;
> > > +		if (!tnum_agree(t1, t2))
> > > +			return 0;
> > 
> > Could we reuse tnum_xor() here instead?
> > 
> > If xor of two register cannot be 0, then the two can never hold the same
> > value. Also we can use the tnum_xor() result in place of tnum_is_const()
> > checks.
> > 
> > case BPF_JEQ:
> >     t = tnum_xor(t1, t2);
> >     if (!t.mask) /* Equvalent of tnum_is_const(t1) && tnum_is_const(t2) */
> >         return t.value == 0;
> >     if (umin1 > umax2 || umax1 < umin2)
> >         return 0;
> >     if (smin1 > smax2 || smax1 < smin2)
> >         return 0;
> >     if (!t.value) /* Equvalent of !tnum_agree(t1, t2) */
> >       return 0;
> >     ...
[...]
> > Looks slighly less readable though.
> 
> Nice find on the xor-based equivalent version! I lean a bit toward
> keeping the slightly more readable version though. The xor version is
> probably a bit more efficient, but I'm unsure that matters much for this
> piece of code, whereas I think readability matters a lot here.

True, I probably had jump a bit too quickly to optimization. Thinking
about this over again adding a new helper does make more sense (someone
probably will try to add it in the future anyway), so let's take the
readability preference. You can add

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Maybe add the check right after 'tnum_is_const(t1) && tnum_is_const(t2)'
check, and before 'umin/umax/smin/smax' check though? Bunching tnum
usage together for aesthetic.

> ... That
> said, if others prefer the xor version, I don't mind much :)

FWIW I'd ideally would like tnum_intersect to return 'false' if no
intersection can be found (similar to check_add_overflow), then we can
use it here. And forcing check to always be done should help avoid
running into some of the register bound violations. But such change felt
too intrusive for the purpose of this patchset, maybe for a future
refactor.

  __must_check bool tnum_intersect(struct tnum a, struct tnum b, struct tnum *out)

