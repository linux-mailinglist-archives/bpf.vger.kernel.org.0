Return-Path: <bpf+bounces-19386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F181182B747
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 23:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478B1B24F2F
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228422134A;
	Thu, 11 Jan 2024 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lpX/5k8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEC9cORu"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54AFC16
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 869DE5C0125;
	Thu, 11 Jan 2024 17:48:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Jan 2024 17:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705013334; x=1705099734; bh=jSEINGMj97
	5z5yI7G8Odj1lJqievETXJNhi3d43qXjA=; b=lpX/5k8ebbfFz0uT3q9AsWAd/t
	9hSfGxxqr3MiVlnxjY24UxrPwBYAZGM8UeZvbqixIsGe8/gedr6UIHuDSWlBEwdg
	1ZL4Ns3GdaK1gdRjvjFzO4nj6Oj62LGbuxS0sA5tqMT9i8udrW34plGC+VyDtDYs
	ygXgSXU8+WOvXPoOxoZQ3DimxmHi7mW96//KdpoMvwl74CpA/r+vBqXmI833hfnn
	6zrgA80MZFRDsa5sp13P3k6VGC2TixtvC1nm24fW1wQmjhAsfxncIKutZDvr+egd
	DVeuYIEAqZpFCQssrntOsMV338eiuWWIALPho4b8E6r64QJWCe0Cmx8bdACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705013334; x=1705099734; bh=jSEINGMj975z5yI7G8Odj1lJqiev
	ETXJNhi3d43qXjA=; b=VEC9cORuiZPO9D7aJspc3R/v9a2C1no3ao5IPcZ0kCjW
	ndOMsXGGjigXGo2qNcEStxfXAU2vxROZt6bn5XgbCkooOZwCMQ2L6t/EGyyQkH8Z
	iefQOf6qVblJkQyprBfLSh+CC4GcCQTU2qMeahbLpVSbYKwmi0tD2mrBdbq+ugG5
	nujzNnmrcNd+8N1a4EzEOZUZJO7oY8tM1eZqXQbs1+qrj3lCLHAcrVvTYEtLVat7
	iqNjzsCIArZWjPdWUFm0hL7oLXY5Lvu1Fw+S1Su2sC0bgA0YtUHI8pWZZ8p8wTV9
	b5U5Jbzjh59Xp1/+0DJjCHgNq7EoOOez0S9NjgbGgg==
X-ME-Sender: <xms:VnCgZTUshLH0mLlq-BAMFcG62KQjMnF1kWUw_t7iqbbFTb7ONp9h0g>
    <xme:VnCgZbmM0FNWJyfkFJx-C3xthk62Exdl1AWCGnoOPnjMISnDNcYqjs47KWrV-kgbq
    63IwOReyPW_-NoDwQ>
X-ME-Received: <xmr:VnCgZfZ4Ji4pja3iBe5wQwcp2O-kjEZz5zG-pddfMYkXACsnRAJKPGBwavyR29yO_olpsAfg5yDpuSE-Zlp7dXrpLyIJSz_fW4W_IJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeigedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnheptdefvefgheeigefgieeiudegffegheduvdduteegkeevgfdt
    udfgtddvffeitdehnecuffhomhgrihhnpegsthhfpggvnhgtohguvghrrdgtfienucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihu
    uhhurdighiii
X-ME-Proxy: <xmx:VnCgZeXwuVKcfZtlyxPVrpkVIvW1uPeaBv2pqt3ysv0MInBCOtuJ0g>
    <xmx:VnCgZdkT-Szs4oyD6Yun6wQy-tAxelVeaD-LBMGPDXRzqUAwF7viNw>
    <xmx:VnCgZbcF1eiy1ZREZte7VMfJoJsY4yh-ImlQYSMk1Q-wXNkELFep1Q>
    <xmx:VnCgZf6K3Usht0eLGFLjkTMCZ6ASKPAX1EfTzb8C2qYn9Mxp4Xu3qQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 17:48:53 -0500 (EST)
Date: Thu, 11 Jan 2024 15:48:51 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Song Liu <songliubraving@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Jordan Rome <jordalgo@meta.com>, Yonghong Song <yhs@meta.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
Message-ID: <rclqt5yod7n5l3cjuptadouxw3xshcedibgfe4fc3qjy6psuf7@qj2cjmzu5iwe>
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>

Hi Song,

On Thu, Jan 11, 2024 at 09:51:05PM +0000, Song Liu wrote:
> The problem
> 
> Inlining can cause surprises to tracing users, especially when the tool
> appears to be working. For example, with
> 
>     [root@ ~]# bpftrace -e 'kprobe:switch_mm {}'
>     Attaching 1 probe...
> 
> The user may not realize switch_mm() is inlined by leave_mm(), and we are
> not tracing the code path leave_mm => switch_mm. (This is x86_64, and both
> functions are in arch/x86/mm/tlb.c.)
> 
> We have folks working on ideas to create offline tools to detect such
> issues for critical use cases at compile time. However, I think it is
> necessary to handle it at program load/attach time.

Could you clarify what offline means?

I wonder if libbpf should just give a way for applications to query
inline status. Seems most flexible.  And maybe also a special SEC() def?

Although I suspect end users might want a flag to "attach anyways; I'm
aware", so a more generic api (eg `btf__is_inlined(..)`) results in a
smaller and maximally flexible result.

> Detect "inlined by some callers" functions
> 
> This appears to be straightforward in pahole. Something like the following
> should do the work:
> 
> diff --git i/btf_encoder.c w/btf_encoder.c
> index fd040086827e..e546a059eb4b 100644
> --- i/btf_encoder.c
> +++ w/btf_encoder.c
> @@ -885,6 +885,15 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
>         struct llvm_annotation *annot;
>         const char *name;
> 
> +       if (function__inlined(fn)) {
> +               /* This function is inlined by some callers. */
> +       }
> +
>         btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
>         name = function__name(fn);
>         btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> 
> 
> Mark "inlined by some callers" functions
> 
> We have a few options to mark these functions.
> 
> 1. We can set struct btf_type.info.kind_flag for inlined function. Or we
>    can use a bit from info.vlen.

Seems reasonable. Decl tag is another option but probably too heavy.

> 2. We can simply not generate btf for these functions. This is similar to
>    --skip_encoding_btf_inconsistent_proto.

This option seems a bit confusing. Basically you're suggesting that:

        func_in_avilable_filter_functions && !func_in_btf

implies partially inlined function, right? Seems a bit non-obvious.

[...]

Thanks,
Daniel

