Return-Path: <bpf+bounces-63130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A18B030C1
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838923B8376
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F426CE0E;
	Sun, 13 Jul 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDq9/w7v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDE4A3C;
	Sun, 13 Jul 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752404498; cv=none; b=gaMgPa7d1v1mfwxbpSfkMN4v4gfTM0v0/aipdEIlHZfvWPkIsUyZxmQs3emFT8MOX5jemcYZusYYGPFNEzzo4wKxngfPrSpKxb6/UDTZffcCJdrxnc8e86/T/QXUl12ggQWK8i+Au6rTPdyfaQ2ofYw8yda/SSmOITROGJ289AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752404498; c=relaxed/simple;
	bh=3ppvpjpE778pR8n0IiMaZ2ojlFIf7ZdM68QSPS9hKOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLg3Rgu1rEnPOwLVwbVbeMoKUHON85DmY3s5VQtku5BOlHbE33Of0bgCTwplPwfMY2nKbKV1yBNtdyppgdpRYdQBuen8Z39pAUj/LJK/xiZZ83wMeWsk/rFelSZ1eQlTnw03a8gTWeywNbiGpZ2hnnnxrhQYJQVP0+9M6ml7lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDq9/w7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED52C4CEE3;
	Sun, 13 Jul 2025 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752404498;
	bh=3ppvpjpE778pR8n0IiMaZ2ojlFIf7ZdM68QSPS9hKOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDq9/w7vNZwogdD6T7cz6Axb3o/rs2QVeLRHOucGVkWk2DES14Rbo5xe+Yc/GWoWN
	 G9oc+Oyd4Z6b0TMUU5S+n0t8n+auBLff7HXZChTCnRN4twX8tJj/tzwqA4UcTrp9qT
	 D2tLWRroi1gm4uLLGOPtHJG0ncjNn3MpSKvbYtONulitHsLl4DVC28kWEKNPC6BqUm
	 Q1zihsSgSWa1yB0Uxw12YArp2mBmWT6JsMTP6jwEPUM29tV34P/OteUmM/Kiy9hrEC
	 9vQ8kFoV+cZjt03Ah3uQapC9aSPn2Df1AxqoVGl+AFo7dx3ALPUD+PspGhNylk99Uo
	 VReuZKXA4wZEg==
Date: Sun, 13 Jul 2025 12:01:30 +0100
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Dao Huang <huangdao1@oppo.com>
Subject: Re: [PATCH bpf-next v9 2/2] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Message-ID: <aHOSCtykfYLLmy1n@willie-the-truck>
References: <20250505223437.3722164-4-samitolvanen@google.com>
 <20250505223437.3722164-6-samitolvanen@google.com>
 <aHEfJZjW9dTXCgw3@willie-the-truck>
 <CABCJKued2XsLp5+ZW1ZWQn6=CgYkhjEDyJdfTRTR1MGkvDtmXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKued2XsLp5+ZW1ZWQn6=CgYkhjEDyJdfTRTR1MGkvDtmXg@mail.gmail.com>

Hey Sami,

On Fri, Jul 11, 2025 at 11:49:29AM -0700, Sami Tolvanen wrote:
> > > +#define cfi_get_offset cfi_get_offset
> > > +extern u32 cfi_bpf_hash;
> > > +extern u32 cfi_bpf_subprog_hash;
> > > +extern u32 cfi_get_func_hash(void *func);
> > > +#else
> > > +#define cfi_bpf_hash 0U
> > > +#define cfi_bpf_subprog_hash 0U
> > > +static inline u32 cfi_get_func_hash(void *func)
> > > +{
> > > +     return 0;
> > > +}
> > > +#endif /* CONFIG_CFI_CLANG */
> > > +#endif /* _ASM_ARM64_CFI_H */
> >
> > This looks like an awful lot of boiler plate to me. The only thing you
> > seem to need is the CFI offset -- why isn't that just a constant that we
> > can define (or a Kconfig symbol?).
> 
> The cfi_get_offset function was originally added in commit
> 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call") because the offset can
> change on x86 depending on which CFI scheme is enabled at runtime.
> Starting with commit 2cd3e3772e41 ("x86/cfi,bpf: Fix bpf_struct_ops
> CFI") the function is also called by the generic BPF code, so we can't
> trivially replace it with a constant. However, since this defaults to
> `4` unless the architecture adds pre-function NOPs, I think we could
> simply move the default implementation to include/linux/cfi.h (and
> also drop the RISC-V version). Come to think of it, we could probably
> move most of this boilerplate to generic code. I'll refactor this and
> send a new version.

Excellent, thanks.

> > > @@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > >               jit_data->ro_header = ro_header;
> > >       }
> > >
> > > -     prog->bpf_func = (void *)ctx.ro_image;
> > > +     prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
> > >       prog->jited = 1;
> > > -     prog->jited_len = prog_size;
> > > +     prog->jited_len = prog_size - cfi_get_offset();
> >
> > Why do we add the offset even when CONFIG_CFI_CLANG is not enabled?
> 
> The function returns zero if CFI is not enabled, so I believe it's
> just to avoid extra if (IS_ENABLED(CONFIG_CFI_CLANG)) statements in
> the code. IMO this is cleaner, but I can certainly change this if you
> prefer.

Ah, that caught me out because the !CONFIG_CFI_CLANG stub is in the
core code (and I'm extra susceptible to being caught out on a warm
Friday evening!).

Hopefully if you're able to trim down the boilerplate then this will
become more obvious too.

Cheers,

Will

