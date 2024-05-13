Return-Path: <bpf+bounces-29670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2E8C48AD
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB7CB229D0
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA44824B1;
	Mon, 13 May 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="C3HRbjhI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBirZnE3"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69971DA24;
	Mon, 13 May 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634891; cv=none; b=IXgxVQ1CYJl7yh8iGTi+yV2dZ9E0XKYKw+gSHW+kOEZPdOyv4Z1agl5E46xKTJmqdFQNa760xkBJ1GF4Ofw+M84P5VZ41JvktEBKSyJXAjWs15feEgjoPzG01pRAQ9H9pv5ZoV7VAbkalKas05pbMJjgLthfKLj+MjMCaKUIUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634891; c=relaxed/simple;
	bh=3RU14hPBRJi9AV9s+50eZOV1ETZIQyBxt+R/qp8IzRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsRQqrfE4FQWzXeaWC7bLbdr5cqsZ3DvMGitetcPLD2CTQD/1tUq6zdji2j0D++cI+kLWWNHFCrzXRGNg9d2RPrrpg4VpWh2vIeR+jJK7tQ3Ry26yAOjp2WmOyXm6DjqoRrk+VXzjXr3eOVdKVH4cko2agoGqbsoNDQSuB62uK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=C3HRbjhI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBirZnE3; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B62D61800165;
	Mon, 13 May 2024 17:14:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 17:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715634887; x=1715721287; bh=5jWB6u8tA+
	i7tSP2QC8w163S31C7XhqcLLTbhhZxvX4=; b=C3HRbjhI8qJH4OYIqx1gxKnweB
	qPkVDutbLoTXx1orYCjAYNJL8jyMa6P8zr8Z5GPIQRNvQh8o76GuXgIULFWSFpyg
	JUCOIcFlQSmLtP/OcUkSAIwVooEmRTSyDXYVHuBJp+HOK6IDnFp/ukTWD5oTawJm
	3zJApPi88xNmmYwSEsW0JXujV02B66me109zyNbrG1VViSM6RqwXKAESJnFRy8m1
	IkikurFuPFrYHlPe30s5H2CMylBb1+x/5Ws9W6TRROektZZ9cWh4Oz0nyyrvCUwH
	WV88dSZdPc88h6gtO+SxobdvvksX9hF9KLsn5HtzQuw25W97AGqwdBpVtSTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715634887; x=1715721287; bh=5jWB6u8tA+i7tSP2QC8w163S31C7
	XhqcLLTbhhZxvX4=; b=RBirZnE3wJBSizEubcQhyFS/hGUmLA+N/h73t4J3wOsu
	X2fP2OVVXgbe+7MA0kw0ye8XXRkonyRCxP86X6CQGN6mRhEhqS+fI6cTIQP7B8zM
	+kh2qT+h4JkLyjGQ6shtG7wGCwbJj6hlHUvGB81eW2RAPLFoFUw3EjsGgixDFm3h
	UqiyL7bwTYw2YFWh2o7eit4w37BBw5AfIQSa3XIBb2ObsYfrcQrMhp853x3yrJMx
	nPHBk9GIHznfw4YitrnuXmY14X0roH2YZsR0WmMl1bEvu5Znj1w59isBX638P9jl
	eQZXQUAtCSij5yxHIve94rBe4T1wl9zw/mtr4pb2vw==
X-ME-Sender: <xms:xoJCZtiWU-clMtxv7adKhVdpHx5HuQNOQsKEb1LT0wgDwGXjt6p_gg>
    <xme:xoJCZiBmMz_Um0uoONcB6tQKqU1AGrFZDHJ3QuoWLQrWKdN5_L70EeRCZptHI4kOt
    vXsn7KpviBThWD4Sw>
X-ME-Received: <xmr:xoJCZtGTg_PmDbBbZ9cpUJib-HAg5cA3Ao4AVBgYE27PczSB-mJwO1GXo6RAHghEnbqxzSIKqIKSdLkqVEzjqfZa1GoYSlf2wIo7ZBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepff
    fhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefie
    egtdehfeffkeeuudekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:xoJCZiQiY63J_-4w_onneR62Y83dA5ctUgZVgMWpZTXR0XNW-2kmSw>
    <xmx:xoJCZqylVdG6CoXR0qUgaHkrTVvFoMJyROPwN8rdRVsGbuIBtZCA4g>
    <xmx:xoJCZo6uxnfvBUswxrNJF7XtzkZL5ih-9ejkZmtpcZlqcEIeUsYvGg>
    <xmx:xoJCZvx38QH-qpYw1dpkEa41Q8fCBIc7bIf__Ep_-dk_Boua-KJTeg>
    <xmx:x4JCZnzT7In_dEt7X-AGBC1w_mLHsoNCtrGNwQKzctGJwZnc7HheTDlF>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 17:14:45 -0400 (EDT)
Date: Mon, 13 May 2024 15:14:44 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org, daniel@iogearbox.net, qmo@kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com, quentin@isovalent.com, 
	alan.maguire@oracle.com, acme@kernel.org, eddyz87@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Support dumping kfunc
 prototypes from BTF
Message-ID: <f27zhdp4ydckd36j7qskqjty227nax47uo62gqoimgw6hoanmv@bt2oxuxdngvs>
References: <cover.1715625447.git.dxu@dxuuu.xyz>
 <6b16417c2c05019e83e420240c6d9796f9324a6c.1715625447.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b16417c2c05019e83e420240c6d9796f9324a6c.1715625447.git.dxu@dxuuu.xyz>

On Mon, May 13, 2024 at 12:38:59PM GMT, Daniel Xu wrote:
> This patch enables dumping kfunc prototypes from bpftool. This is useful
> b/c with this patch, end users will no longer have to manually define
> kfunc prototypes. For the kernel tree, this also means we can optionally
> drop kfunc prototypes from:
> 
>         tools/testing/selftests/bpf/bpf_kfuncs.h
>         tools/testing/selftests/bpf/bpf_experimental.h
> 
> Example usage:
> 
>         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> 
>         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
>         extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
>         extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
>         extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/btf.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..884af6589f0d 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -20,6 +20,8 @@
>  #include "json_writer.h"
>  #include "main.h"
>  
> +#define KFUNC_DECL_TAG		"bpf_kfunc"
> +
>  static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_UNKN]		= "UNKNOWN",
>  	[BTF_KIND_INT]		= "INT",
> @@ -454,6 +456,48 @@ static int dump_btf_raw(const struct btf *btf,
>  	return 0;
>  }
>  
> +static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
> +{
> +	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
> +	int cnt = btf__type_cnt(btf);
> +	int i;
> +
> +	printf("\n/* BPF kfuncs */\n");
> +
> +	for (i = 1; i < cnt; i++) {
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +		const char *name;
> +		int err;
> +
> +		if (!btf_is_decl_tag(t))
> +			continue;
> +
> +		if (btf_decl_tag(t)->component_idx != -1)
> +			continue;
> +
> +		name = btf__name_by_offset(btf, t->name_off);
> +		if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
> +			continue;
> +
> +		t = btf__type_by_id(btf, t->type);
> +		if (!btf_is_func(t))
> +			continue;
> +
> +		printf("extern ");
> +
> +		opts.field_name = btf__name_by_offset(btf, t->name_off);
> +		err = btf_dump__emit_type_decl(d, t->type, &opts);
> +		if (err)
> +			return err;
> +
> +		printf(" __weak __ksym;\n");
> +	}
> +
> +	printf("\n");
> +
> +	return 0;
> +}
> +
>  static void __printf(2, 0) btf_dump_printf(void *ctx,
>  					   const char *fmt, va_list args)
>  {
> @@ -476,6 +520,12 @@ static int dump_btf_c(const struct btf *btf,
>  	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>  	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
>  	printf("#endif\n\n");
> +	printf("#ifndef __ksym\n");
> +	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> +	printf("#endif\n\n");
> +	printf("#ifndef __weak\n");
> +	printf("#define __weak __attribute__((weak))\n");
> +	printf("#endif\n\n");
>  
>  	if (root_type_cnt) {
>  		for (i = 0; i < root_type_cnt; i++) {
> @@ -491,6 +541,10 @@ static int dump_btf_c(const struct btf *btf,
>  			if (err)
>  				goto done;
>  		}
> +
> +		err = dump_btf_kfuncs(d, btf);
> +		if (err)
> +			goto done;
>  	}
>  
>  	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> -- 
> 2.44.0
> 
> 

Oh, looks like selftests fail to build. I will fix that for v4.

