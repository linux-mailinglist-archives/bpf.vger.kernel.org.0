Return-Path: <bpf+bounces-19388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACC82B83B
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 00:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DC286518
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5759B79;
	Thu, 11 Jan 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fjaBtMiq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sk8P09X8"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FB57870
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A5CC35C01D8;
	Thu, 11 Jan 2024 18:49:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 18:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1705016968;
	 x=1705103368; bh=ftYo/2+WHLnICyLWQVVUBgXURZNsx/tIehrbS6Fr07c=; b=
	fjaBtMiq4H05/dzvYhzs3/r6MSkmx6eVxlESYGqb5OpS0X90Qoslh8fx/7OVQFCA
	GFnqFcc+1g75ai9XHv+qfLQLKv6puU6IOdEVOUujMUxbxyRVVc9guEZhqLJnCw2Q
	l5+Ap5AziEeM/dwqxK/iHU3BhnZkybOuleTBAmUWg8M4Cxet2YkzEPVk41bxamA2
	z6Nasa3zn9V3hExrbs7oQSbkXLDYtqsdNbhWuQo8Fou3TZPXCGOYCXudm16B9rJD
	oFx0VGKPDd+KwHvFboQZ0IDUA7ULdh2boF9sTJBkEedztttcPpKQp7dG8of7/rNa
	5AL5yNLoWpdwHIlCsdMHYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705016968; x=
	1705103368; bh=ftYo/2+WHLnICyLWQVVUBgXURZNsx/tIehrbS6Fr07c=; b=S
	k8P09X8WSuDyW19II6+3f9pEPdGcg0Lqqxs9umeDi828C7xuqHkhy/JUHNYHqehB
	Cd1qIxMEHZXINiX45GQzGzLmjNk2Jbn/Ok/ULBRieGsR4+L3HeJJFy+Fo+XW/ZXt
	/8yF+6v4kphG1dLu7WJLT8xoU8a6Vhs0hdgE/KQiOr7K6tvBTjrwAOBsViGIBlBA
	D6AO8FGzzIcVpgzlUFetMjJ6bV6cmWTkRaTdzQIOco/DWnPUpkhGn59DG7BNILiI
	TnedexaqOGkhrnGY2SsHfo9xsseU+oWGDyGhsKAIMTaecOhfNCB3Sp7lUXOs8eQX
	bOKBjQ/8cHhNUleOX+PnA==
X-ME-Sender: <xms:iH6gZePO-X9FPXjZ-YslSjbqhbIAaA84ZoRDjBF70n-BbcIMduRusA>
    <xme:iH6gZc8kd8j8m4IPy_rr2fojvvhDtrzmswYmLPWSR3ryw_nLfPqkZRny9LN2ST-gh
    jG7LalB3QEZXvfOqw>
X-ME-Received: <xmr:iH6gZVT-AM67PE2jQyTuU-cJwcNJLOtO_RGNBVPyfNNFwzh7IkF-QfApMRdMg_8GC0eJV3_FcmxpUQJqRjccLb2hUMEGUhNDom_DT-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeigedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:iH6gZestPy3YP6NJiC3iY9mofWylfq15dbNqzVh2JCnS7ymDPmBB-w>
    <xmx:iH6gZWdzD2KKoadoFRusp9fMgWnzJpXSbmeakIltZVfMG6Bv6zWFZg>
    <xmx:iH6gZS1JHdhx164gh8KHuUUrN7_EsPs0lb9wXhCMzZRO3xCEr4195w>
    <xmx:iH6gZdwj_EVSEpYAUjvBb9pvSfs3bxvQUXy5s2kiPP9Mz7zCVLdXoA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 18:49:27 -0500 (EST)
Date: Thu, 11 Jan 2024 16:49:25 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Song Liu <songliubraving@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Jordan Rome <jordalgo@meta.com>, Yonghong Song <yhs@meta.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
Message-ID: <n7jdll2bwj7futzz227g2nlo53zwg774appc3paxhi3iv76ean@4oj7mxalthzz>
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
 <rclqt5yod7n5l3cjuptadouxw3xshcedibgfe4fc3qjy6psuf7@qj2cjmzu5iwe>
 <DF3DD763-E5F2-4032-8F54-E25AA1270E12@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF3DD763-E5F2-4032-8F54-E25AA1270E12@fb.com>

On Thu, Jan 11, 2024 at 11:06:23PM +0000, Song Liu wrote:
> 
> 
> > On Jan 11, 2024, at 2:48 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
> > 
> > Hi Song,
> > 
> > On Thu, Jan 11, 2024 at 09:51:05PM +0000, Song Liu wrote:
> >> The problem
> >> 
> >> Inlining can cause surprises to tracing users, especially when the tool
> >> appears to be working. For example, with
> >> 
> >>    [root@ ~]# bpftrace -e 'kprobe:switch_mm {}'
> >>    Attaching 1 probe...
> >> 
> >> The user may not realize switch_mm() is inlined by leave_mm(), and we are
> >> not tracing the code path leave_mm => switch_mm. (This is x86_64, and both
> >> functions are in arch/x86/mm/tlb.c.)
> >> 
> >> We have folks working on ideas to create offline tools to detect such
> >> issues for critical use cases at compile time. However, I think it is
> >> necessary to handle it at program load/attach time.
> > 
> > Could you clarify what offline means?
> 
> The idea is to keep a list of kernel functions used by key services. At 
> kernel build time, we check whether any of these functions are inlined. 
> If so, the tool will catch it, and we need to add noinline to the function. 

Neat idea!

> > I wonder if libbpf should just give a way for applications to query
> > inline status. Seems most flexible.  And maybe also a special SEC() def?
> 
> API to query inline status makes sense. What do we do with SEC()?

Oh, I meant that you could make the SEC() parser take for example:

      SEC("kprobe.noinline/switch_mm")

or something like that. Rather than add flags to bpf_program which may
not be applicable to every program type.

[...]

Thanks,
Daniel

