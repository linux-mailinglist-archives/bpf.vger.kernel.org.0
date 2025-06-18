Return-Path: <bpf+bounces-60945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE8ADEFFA
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858F43A2BB3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F02857C4;
	Wed, 18 Jun 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnwcFOXS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AB27E071
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257816; cv=none; b=pGGVM4hQ32Y78cj3UthoytHyCidwhYLtqD8Up+XN/pC10rLfcWZK2D2lzkoUf2Z52TMtk0wR9DjJTJBP9zXFCiDVrCSCpElnZfrGff8LcIkcFmIm6Uy8a+VeFnYIruFagKGxR075X8ZfbRxnx0MqKUlXBuWzmBEvzUwnjJoPmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257816; c=relaxed/simple;
	bh=5laQeIyxuNINf1WvVhIN92ooLXw2+/dGrZ2oH1FVOKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFLgPvFS3JSjAIiLEhA/T/sogsT0aseV5sg24g8/WRW/5OuhnnxstI3nzZDNrlHRyNxEOuF1oIKvwSDQUKACz6tTMxCFVM2zXTGK0SGP0rBqoCcijD6ANTe2TA6DVvRmiirhEWYl5gNUP2K2+RE89TW+v6OgwkYC98DCyDTCIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnwcFOXS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a5257748e1so5102521f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257813; x=1750862613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GTtlKIBuLcxgM6LMRyvW6OsCbMxXQvsvOhpzpIK20Ac=;
        b=TnwcFOXSTKt8+Z5X38R5ergdpuAwqV1idfSbBsZofLwfE0On4paCcvHQh+wQdcQDcd
         0TkoEPiDFMLDWk1A/mj9UWZXISPRes7GqZsoV5BLWZUnpMpG8I5Ehoea9hy1byiIq9nt
         +5RW2ZN7qwWW2vYDtZXsnQwy50K44q7r5ucYP/iJG8qMaSp4qEs+XhOgl9Q28eQcB/mt
         5JkioMK2UGJIxV/1LdnXuHWY50j+NfHbZIlQLyaVAiQAHzhK2FSuRx3e1n2fzXHMS9bb
         BYHCKlutj3L0pBmLxArP7z5QqS7Fw39mSCEth0M4Qfstayx/qgV2QW3xa+1ucCf9Xu18
         HpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257813; x=1750862613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTtlKIBuLcxgM6LMRyvW6OsCbMxXQvsvOhpzpIK20Ac=;
        b=gL70djquwSz/BiGqqX/afreavz+Lf+6UWpFVqtwE+CVTgfI8xD0FmDoS5inWm4SXGI
         XTpBFhicEVob8AH2pVK+iu38RkR9c2jliNF57UcQTNLB62oxthiL8MfpRLh1G06fGAbU
         24HuzNbaKNuVdp34TUr5m0eISvVXisYm25iEvwb5royCEUg4ICyE7F4crHKTlPdUHe5B
         DGLRRhLeZK2BbvUd1VT7ZFlgB5YxV/rFZrU4KhbtTEQro8x/4/4LjNZE4OIGJeEe37Y5
         +XTRd66pzyrr0kwkCc9Cg88Z5UfiSm9Q0KlizLG/FvUcWlHWfoAm20KEi9H08Es0T/FT
         FAqg==
X-Gm-Message-State: AOJu0YyGp2DSu5xYxHyEmAH+6Prcs88XIP1cuay0bs5PjgtD3MeLivfQ
	5ERpal5bwYSB+9XdtgNBMWEtQGvOqrQ808D02Gh7OtfXsMlOve2n0tdC
X-Gm-Gg: ASbGnctEL1BS2Z1KC0yKIKeolhOgf6gswawGInDO/hA7blIhIUZJhgk86ifD2OCgi+a
	ZS4zfRNse50KuevGAmJ6qF7L7/bNqAGMth8y6kJmO3aevDif/D8c2G4usXX9fIRxeNxhl51CmWo
	Ef5pqORP0nnuuk1r8nZXOk5VK35ScunqDRc3PiYia1T6eZYuMDSsZ/T0BFGb4FC/KEgz1NtPjym
	4w3yOSvtp+oHG50NzABKB66Uk+B1Sgu4GFw42YemZeGeZ/V8Wo5W8nHKKE/2G8CdsIrR4EAGmv9
	+hLsks0AvtYzkPlXWLdU0yM44KneVzGugWwRWkRRg1y/Z5XttcGAG9OwPhesyuGPzRX2ZbJgIA=
	=
X-Google-Smtp-Source: AGHT+IEi17niuiUIZ93w3zwgPm3HOtDcEFAFPgeUVbDti1v/8xmwzHS9KaOqWRQNHtvE7yS4WxVPjA==
X-Received: by 2002:a05:6000:26c9:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3a5723a368fmr15852833f8f.33.1750257813174;
        Wed, 18 Jun 2025 07:43:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d1fsm16896808f8f.2.2025.06.18.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:43:32 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:49:16 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect
 jumps
Message-ID: <aFLR7NrdX3gbjC1s@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-10-a.s.protopopov@gmail.com>
 <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKPbBRGOj2mB5Um80VFUh_vVg=oRJCdYUgyz_DrObuagQ@mail.gmail.com>

On 25/06/17 08:24PM, Alexei Starovoitov wrote:
> On Sun, Jun 15, 2025 at 1:55 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > +SEC("syscall")
> > +int two_towers(struct simple_ctx *ctx)
> > +{
> > +       switch (ctx->x) {
> >
> 
> Not sure why you went with switch() statements everywhere.
> Please add few tests with explicit indirect goto
> like interpreter does: goto *jumptable[insn->code];

This requires to patch libbpf a bit more, as some meta-info
accompanying this instruction should be emitted, like LLVM does with
jump_table_sizes. And this probably should be a different section,
such that it doesn't conflict with LLVM/GCC. I thought to add this
later, but will try to add to the next version.

> Remove all bpf_printk() too and get easy on names.

The `bpf_printk` is there to emit some instructions which later will
be replaced by the verifier with more instructions; this is to
additionally test "instruction set" basic functionality
(orig->xlated mapping). Do you think this selftest shouldn't have
this?

> i_am_a_little_tiny_foo() sounds funny today, but
> it won't be funny at all tomorrow.

Yeah, thanks, will rename it.

