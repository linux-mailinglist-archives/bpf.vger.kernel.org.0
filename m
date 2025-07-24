Return-Path: <bpf+bounces-64305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E825EB1138C
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AD3ABC79
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8241E9B35;
	Thu, 24 Jul 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Jw+Ywm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348424C8F
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394509; cv=none; b=RC22nRLBes/5DCMRC2YCRyjg4dm1yoyIEYAfPN5ersQAJTGaWRYRVQlnyYoIwCDnNwz+WKmotg74uJy8cOPQo4Zz7J5ecst0JCb44WKDbM902OsYsh6PzVaEVWDPXOR+VMJhMMOq5M9jyHvAYeDfm+yCDdUMTrjbcOt4Sp24CqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394509; c=relaxed/simple;
	bh=85GMsWZeG2HvjY52q087EVPIDfeO9AgQEtU/E9u6BLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iffWWn9XetnFEbGxuNAwHIYKMjL04PIilmWxJ15myhBiyDtCHvFSrJJtMIyXAa0Mfhu7EHg6lbulINFAYaoHeGBvQLy2oUy0+SlCw845JOH4ybXp7YxouKRI5DmbwnaQw+bYD6zEY3HcVbuLJJnhylevrcPVlw14EeMFFp2iyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Jw+Ywm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so11955505e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753394506; x=1753999306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wb0AilMbYx1h8CRqWy/7I4sAvHg80BU1bie1HYzPPk=;
        b=Z6Jw+YwmA+VBjnmDwo6l7epxQ1j0B/YzmMeWd/NChaYuc5nkwgiJ8ZOe6RKSbJXkV8
         jkWMHgQQnBV/YXNrhwgyoNDW5BA9yVSdED+sRHNGpaWPW5GsuupFIjElX3BDoNwNQvAI
         pqVXl6G11YRb/GndQkAuxJuyBbADOIRX/3Hm91wYUtJ12/lr/BjKNk6jQ5yUvx6U/Wvq
         1570YwInG2TF7WT0MET4NbH9nQo6hs3PPC1bVxv4E8C0yVRl8clcH1qsAlv09xKI2tMH
         Epv5HN5XGgDW+nv3wbucPvXlX63h9rMG//PyQD41quo05hOlc3lVFeMuhk70tAec0HIq
         DB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394506; x=1753999306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wb0AilMbYx1h8CRqWy/7I4sAvHg80BU1bie1HYzPPk=;
        b=m72CoXphbm/6+RUKff7KmBAIUx3zh5sqNPbj/X44OYnj7lxPPQRdJ1L8Ht5T0ivgPN
         qi1ZmxXCXhRRLZ81AVlGHx0WVMz8A03V9RUw3/XP66zXGRGUdoJ+Wpk9PBOaNoGvOvLU
         QSSzxo+3V9WRPrJOCymO3NUUCLOwMiRhEEoSn+OxVaItU3ZF6Fy75I1INokaLzMMC5zW
         DIfn9V7Hfb9N/fAK/+S80lC6FbyMpKSk5vSjab0SYgJw2nz75wzMCH3Zrv2d5swGOvwH
         JBxUMM/eHSazJuYyTaZTib1NJdxQ+Gwz6CGE4oP17YiDfU/0nvrX4v9oOz/4e24fG3nQ
         M7nw==
X-Gm-Message-State: AOJu0Yw4Gi3uf9GbSkblWyZ/sIQR8X7Kyua+X0TetH1DNhqbJHACBGUr
	ZaS0RJUNmV+hg+085O7Kmpcpfm8zr0QlswcBwN5P7kjiwFMJ1q2NatyU
X-Gm-Gg: ASbGncuZ98v89EFWz0WXIwr3JNH5URb04n1GDhzQ4M/84oj27wMwvGlHL6qNoIDXk+0
	QiA2mTB2kfOsoOHqKT7ZHWc9uzqHWiIL+P4iZp7m+knjXF04oKSnO4wC/dnNdSQW/hT6EJD5aqQ
	v9jJdGJRVkRRPfHt8rVS5jj2pY5ZueeOY225B+DL+Z8lSFkcew8b1bHH15hPRM14V4agMNTFvjM
	6jinhWH2IU0RuZweEVjPdVt+0dtcU/73yhQblf3i5R3nKRWFQJ2XnX5z3ZVXIyy1JP8P+U/GN8d
	w1FWlrUImY/Oc9cnmh2GAfcTBIJ5eBuxjp7X4AF4RZQKJdHMPuS9/7pvsXONg/oNUmQpGPUPIdp
	OMQlI98xC3e1ySCGi52rTXcE3+rtACxrGoDRpnQaMxbhc4K5gLuQ5CN8RIrnL7s1/qt4VW6EqwS
	IRNZybkvd1W9k7hP68U1+C
X-Google-Smtp-Source: AGHT+IHbstsS9sGRTJC6IT8Jnh6dak3bh54LL2WTzxwMnBVrXH3vDCZ/H4+ho4mfpZGT7j9TWO+PDQ==
X-Received: by 2002:a05:600c:46d2:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-45868d48911mr79224835e9.19.1753394506152;
        Thu, 24 Jul 2025 15:01:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00667e58c39c19dc02.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:667e:58c3:9c19:dc02])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45870554a02sm33176885e9.21.2025.07.24.15.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 15:01:45 -0700 (PDT)
Date: Fri, 25 Jul 2025 00:01:44 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Test cross-sign 64bits
 range refinement
Message-ID: <aIKtSK9LjQXB8FLY@mail.gmail.com>
References: <cover.1753364265.git.paul.chaignon@gmail.com>
 <8f1297bcbfaeebff55215d57f488570152ebb05f.1753364265.git.paul.chaignon@gmail.com>
 <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905853bfc266a6969953b4de8433ef9ca7e7a34c.camel@gmail.com>

On Thu, Jul 24, 2025 at 12:15:53PM -0700, Eduard Zingerman wrote:
> On Thu, 2025-07-24 at 15:43 +0200, Paul Chaignon wrote:

[...]

> > +SEC("socket")
> > +__description("bounds deduction cross sign boundary, negative overlap")
> > +__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
> > +__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
> 
> Interesting, note the difference: smin=-655, smin32=-783.
> There is a code to infer s32 range from s46 range in this situation in
> __reg32_deduce_bounds(), but it looks like a third __reg_deduce_bounds
> call is needed to trigger it. E.g. the following patch removes the
> difference for me:

Hm, I can add the third __reg_deduce_bounds to the first patch in the
series. That said, we may want to rethink and optimize reg_bounds_sync
in a followup patchset. It's probably worth listing all the inferences
we have and their dependencies and see if we can reorganize the
subfunctions.

> 
>   diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>   index f0a41f1596b6..87050d17baf9 100644
>   --- a/kernel/bpf/verifier.c
>   +++ b/kernel/bpf/verifier.c
>   @@ -2686,6 +2686,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
>           /* We might have learned something about the sign bit. */
>           __reg_deduce_bounds(reg);
>           __reg_deduce_bounds(reg);
>   +       __reg_deduce_bounds(reg);
>           /* We might have learned some bits from the bounds. */
>           __reg_bound_offset(reg);
>           /* Intersecting with the old var_off might have improved our bounds
> 
> > +__retval(0)
> > +__naked void bounds_deduct_negative_overlap(void)
> > +{
> > +	asm volatile("			\
> > +	call %[bpf_get_prandom_u32];	\
> > +	w3 = w0;			\
> > +	w6 = (s8)w0;			\
> > +	r0 = (s8)r0;			\
> > +	if w6 >= 0xf0000000 goto l0_%=;	\
> > +	r0 += r6;			\
> > +	r6 += 400;			\
> > +	r0 -= r6;			\
> > +	if r3 < r0 goto l0_%=;		\
> > +l0_%=:	r0 = 0;				\
> > +	exit;				\
> > +"	:
> > +	: __imm(bpf_get_prandom_u32)
> > +	: __clobber_all);
> > +}
> 
> [...]

