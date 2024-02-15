Return-Path: <bpf+bounces-22071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6A8561DD
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F7BB2D7EF
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18D12EBE4;
	Thu, 15 Feb 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa4QMyfY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57912881A
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994202; cv=none; b=rZp0eENaLHyTjSqpk4PzgwUyJ2pCIkm8xwQ2Jil8+9X0Ga8n6Echw7f3lrfKgveCTOvQUIo+xUXYFwg8nhCss8T6Xfrv+2ElLwPlVgnR6v3amlNmj81VeZ4yfU4PwJRGQZMKq4tZgUQsBvbnwglsnHQ8jq8G7OhkIF/TIvxJ/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994202; c=relaxed/simple;
	bh=xy4XXrTofRkhuzqJ2OfzNGWp44wXcuVzYggYIeQJMuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ0KMlSLCWBHU2OVb4ISF86wAve22hpBXy1qNsXMX1tPm8l65OSiNBxWXqTsD2/6Yx4jDL4hnVY8mV0kJ0DV/J+5A8p04glPHrs9zAf2TaSj02J1Uevo/NTP7uIpT4C3bhxSAf9Zts886i01fgDC1THFTslgU5laRHeBoWJHIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa4QMyfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB8C43390;
	Thu, 15 Feb 2024 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707994202;
	bh=xy4XXrTofRkhuzqJ2OfzNGWp44wXcuVzYggYIeQJMuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aa4QMyfYRtA3plzFYEq0UQIFe7S7YJuGZusvxfcgDWMzTkGixh5940xndyzPkNBTi
	 8E2WUYQNnQaKCK/j3DpsMjFq6uXC/mZXFKiqUta1mOpEmhKQbHIaSdHJbY/gGrZ8T7
	 7/SDvQ/y/+uhA7ALoHJeyAHHlmWTKC95pR7megBDCkk0MnvxdRF+K4M8g58sakOpTd
	 qF6+7fzC4KTjr1dCMb/77RGzkOwerZ2/e4Rt1xzlEoD4B05RC8yWzztbY0efh0f+zU
	 lsoQgn0UdKgX+jG8vtsGOx7J2e116HH5fZZlag/qYAbjMvpKOGlQfhmKQbtJLeYcz0
	 0hyYlEPrSerIA==
Date: Thu, 15 Feb 2024 16:14:54 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Hari Bathini <hbathini@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH v2 2/2] powerpc/bpf: enable kfunc call
Message-ID: <jago3vhogcn4dy7jxbjlm5dy2y4fh3a6xe7jiwkasof5wwp4is@pqdwcq36mj2v>
References: <20240201171249.253097-1-hbathini@linux.ibm.com>
 <20240201171249.253097-2-hbathini@linux.ibm.com>
 <4dd99601-6990-444c-af23-95cb3f7b156b@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dd99601-6990-444c-af23-95cb3f7b156b@csgroup.eu>

On Tue, Feb 13, 2024 at 07:54:27AM +0000, Christophe Leroy wrote:
> 
> 
> Le 01/02/2024 à 18:12, Hari Bathini a écrit :
> > With module addresses supported, override bpf_jit_supports_kfunc_call()
> > to enable kfunc support. Module address offsets can be more than 32-bit
> > long, so override bpf_jit_supports_far_kfunc_call() to enable 64-bit
> > pointers.
> 
> What's the impact on PPC32 ? There are no 64-bit pointers on PPC32.

Looking at commit 1cf3bfc60f98 ("bpf: Support 64-bit pointers to 
kfuncs"), which added bpf_jit_supports_far_kfunc_call(), that does look 
to be very specific to platforms where module addresses are farther than 
s32. This is true for powerpc 64-bit, but shouldn't be needed for 
32-bit.

> 
> > 
> > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > ---
> > 
> > * No changes since v1.
> > 
> > 
> >   arch/powerpc/net/bpf_jit_comp.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 7b4103b4c929..f896a4213696 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -359,3 +359,13 @@ void bpf_jit_free(struct bpf_prog *fp)
> >   
> >   	bpf_prog_unlock_free(fp);
> >   }
> > +
> > +bool bpf_jit_supports_kfunc_call(void)
> > +{
> > +	return true;
> > +}
> > +
> > +bool bpf_jit_supports_far_kfunc_call(void)
> > +{
> > +	return true;
> > +}

I am not sure there is value in keeping this as a separate patch since 
all support code for kfunc calls is introduced in an earlier patch.  
Consider folding this into the previous patch.

- Naveen

