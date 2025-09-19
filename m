Return-Path: <bpf+bounces-68969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AEB8B11D
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA51F3B10E1
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E62BE02C;
	Fri, 19 Sep 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9gA196o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6C29A31D
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309557; cv=none; b=sfMXVd161eOZ3MIuF/50Luz6tmCcvDSzCkNLYrQrm3PRqQkVQAa9Qsm3AsxjhmHQDx6HjmOcb+J+HJhSJN4HQyfGpRwzSZuvHNJkfQ0xS+1yVzatCbswCafFBE5ypKuT/z4YSyy5ersg03Bt28HTNAsompAWaU4o2q1evKziXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309557; c=relaxed/simple;
	bh=N9dXR1fOPyxEmH/SC8Z0bQmSozn9qxwgBSYYhhNOZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1WO0sc7sMVFP+egTQ97AwoXCMmSXjtgg41xFNpc3RVfVp22OE3KDuK+WmEL/rAmQosX4pifZyTjRspIZzaKL9umAa5Y3QsAdxtAaj1Ag/IVMM8r5mhjBoz2lkzFBnvjt1K8yCmcolssc5wgYtx8VbMueNvq5QwXWoZDCDVyxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9gA196o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso18171125e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758309551; x=1758914351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ku4kEJGYebLoewMNIg0HCtmwnI/g5mg13JneklEJzlE=;
        b=G9gA196oZ3CqpIwgP/ljl0loH4L69vnZkJy0lYfcZbtlOMD7zC7+s1b89WUXXw3+nV
         AUl8yUzavsvymCKpciIaH6Hg3nWD6dM4lTgwocYXTbA+oDPJ3XelbjhS7483ITSftO7N
         nyECr6sgm3SCdWBaMzYqZR7hdXZh9smgRqomDFJDcBxRxsk3eTD5yHMtVxfJC0Q/V34K
         ckAsA72gqMPdEQ7IrbTZ6hcg212aaU5NydN49CNvmYKP2eJx8mPkHfA8JMQTAADs8Ra/
         3uXHyQbq2Ffj06IX8A6jY3bbMglf5u0ILL8RrxtKlgBSNFYUQD2vYrP2ziKmFRkEyGB3
         ZZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758309551; x=1758914351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku4kEJGYebLoewMNIg0HCtmwnI/g5mg13JneklEJzlE=;
        b=pWrNR0E53F48CcTordMcua6VoM0Xd8RrOd8+YaWOCKNkyehsOrHzA4Lkr03zIfwCZa
         BM5d+gdQPgdwb+qsn4nZ8x2dmvMtbGA486gqurTctJ2SWqctAJfmUKO3AfYzFsyTft7E
         hXeVB8tQQdDeJGKFxr+6yPtYhEF500+wiCnSvCffTmxHJTzVVJJ5fMw9O0BRsvv+AnhR
         93yNnIUB4uGZypF4YGBTU63dfrsTcxDUh42tmD/Z445KTe+mS7hVr1vwq9W/5SPN+ipV
         yEONhojE3h2YwmGGBp/f1kXUGSBd+GOjgOD6pCMTwnWs8WVXWlzKIdTPNl7WncTmYDTO
         3FcA==
X-Gm-Message-State: AOJu0Yw0NK11WZqDWoacgL8AZoJM5RPGwZsWPc9u9AWwZvVI46D3D4Mw
	V00l3/NwU5i8Wc1npJ82npKNcQ9taXCqvxmb257Zf0SI0VmFtMPZRB4/
X-Gm-Gg: ASbGncuBUFad22YVBtsKhEkzbTM5zfDrM+3Xr6hCJkeAMlacvde+7JFudPQQfpBM1/a
	AmloXErIxuqmgzSHtRuAf6r/1neuZstS7YCH+vSjDn4Zpy/wcw61FblxQxrp5CSdqE5FNIGYph+
	Nb2/DaEj0uzOZ5VL79ydHp/BuwrcSSwUH2fn8rWKF4/JfATijpn2bHj46UvlGw/lVwu7u5DV9s3
	1oKjhqkJ0MNP29yGaDRfViWsRxCQja+jOObajEKK37grWvrs2K77bmW10QTW3ehogHvMdBdyQE1
	oFb903d3ELyiiAcKc6p1KGWEHfqBR+9Yulj4+WRpUWvELd/1Dj/BgeWgTE6aRCB015fVB6rWXIC
	jMxCkqtf1/JGo3DH/ntL3T4d8J1ne/yVv
X-Google-Smtp-Source: AGHT+IGvZkSLY5rEOeTWwcLZyFzcumPlRYv/lpPb+Ap7bkMUNDk05LWiRvLNjXRyx+2ubjefuC7mWA==
X-Received: by 2002:a05:600c:a4c:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-467ebe9d9ffmr45435505e9.3.1758309550916;
        Fri, 19 Sep 2025 12:19:10 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm135097665e9.9.2025.09.19.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:19:10 -0700 (PDT)
Date: Fri, 19 Sep 2025 19:25:21 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 07/13] bpf, x86: allow indirect jumps to
 r8...r15
Message-ID: <aM2uIVYNkGkeNmie@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-8-a.s.protopopov@gmail.com>
 <59dd1a009a5682d4b16df81e097a1a1b43308a28.camel@gmail.com>
 <aee4f446462315c88537c87c39da2a5d3b745b62.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee4f446462315c88537c87c39da2a5d3b745b62.camel@gmail.com>

On 25/09/19 11:38AM, Eduard Zingerman wrote:
> On Fri, 2025-09-19 at 11:25 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> > >
> > >  #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
> > >
> > > -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> > > +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
> > >  {
> > >  	u8 *prog = *pprog;
> > >
> > > +	if (ereg)
> > > +		EMIT1(0x41);
> > > +
> > > +	EMIT2(0xFF, 0xE0 + reg);
> > > +
> > > +	*pprog = prog;
> > > +}
> > > +
> > > +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
> > > +{
> 
> [...]
> 
> > >  	} else {
> > > -		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
> > > +		__emit_indirect_jump(pprog, reg, ereg);
> >
> >                 You need to re-read *pprog after __emit_indirect_jump() call
> >                 this is what causes KASAN error I reported in the sibling thread.
> >                 W/o re-reading it the FF E1 emitted above is overwritten to CC E1
> >                 by EMIT1(0xCC) below.
> >
> > >  		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
> > >  			EMIT1(0xCC);		/* int3 */
> > >  	}
> 
> Or just move the EMIT1(0xCC) inside __emit_indirect_jump().
> It is probably necessary to correctly do mitigations anyway, wdyt?

Thanks a lot for bisecting! I think better is to re-read,
as in the other branch we do not emit CC

