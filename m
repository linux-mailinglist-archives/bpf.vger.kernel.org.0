Return-Path: <bpf+bounces-46420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A29E9FAC
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 20:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A317282238
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B91991B6;
	Mon,  9 Dec 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPwLKiT+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02442197A88;
	Mon,  9 Dec 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772641; cv=none; b=Uc9dXgtkJmdCVVGubfT1MGAUYxsoC0Qnot/MVUHEcQlA1XYnEWXw8XdINpBTkyKX0HNhmTzuPEP+owlWIvwMEJmWjVIPHhtSXL4iL18DJC9JuG1yea5UyGf58GYBqXJdTzRkU/r9eHl6WibFp4/bU8Xiu7wNF+r2GeLKFSVGrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772641; c=relaxed/simple;
	bh=S6Drv5Gppj1g45uWp8IRutQYX3sLuEipz2nh1SgJlAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPywOW+ETFKn8DKnlF490DtoQwM1ijXQX2RsovYx6PL8YxJXHIRat2hpDXbVZNe1O/8f7o3sVw01MHDq7hQXhutNoDQSquxT3Gy9xYPdqcXXXl28tEN5Bd+mBvZgG0lg+NVWhXXXWNXtxCDWqgTlk6zfFWhLLFUAASoVKao1ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPwLKiT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF40DC4CED1;
	Mon,  9 Dec 2024 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733772640;
	bh=S6Drv5Gppj1g45uWp8IRutQYX3sLuEipz2nh1SgJlAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPwLKiT+sjOYcUJRBtZvgJB54sMWNrp9/zBHNOoB31UTThExuAS3cLfcP1Q8nApBq
	 5u8TE+yZV5qcP2gaN/hPbkLtsDEcV9+k9FrnidyZQYuAXhImtUkunV8sBwK58QKBZF
	 ZnLP5RL4+ITWailEB0H3qn+9GtouJGbpAptfhHyEQg2LICL77jGLL/Xn4VlCDll4Mg
	 01S7xuu+R2FlO3OUh8FuP0jQ0UviSNudcwauak/YjgcVs9Hji/AzQ1c4J9vbP4jX2O
	 ybp+gRwFcfyJhdC3W+Zn2Q8DZDpp4lLRpZdw0FxD4l/x1d1kFnFA96rmvE80hlwC4r
	 sB7a9WGqF9yzA==
Date: Mon, 9 Dec 2024 16:30:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for
 eligible kfuncs
Message-ID: <Z1dFXVFYmQ-nHSVO@x1>
References: <20240916091921.2929615-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916091921.2929615-1-eddyz87@gmail.com>

On Mon, Sep 16, 2024 at 02:19:21AM -0700, Eduard Zingerman wrote:
> For kfuncs marked with KF_FASTCALL flag generate the following pair of
> decl tags:
> 
>     $ bpftool btf dump file vmlinux
>     ...
>     [A] FUNC 'bpf_rdonly_cast' type_id=...
>     ...
>     [B] DECL_TAG 'bpf_kfunc' type_id=A component_idx=-1
>     [C] DECL_TAG 'bpf_fastcall' type_id=A component_idx=-1

While testing slab cache BPF iterators I noticed:

⬢ [acme@toolbox perf-tools-next]$ pahole bpf_iter__kmem_cache
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
struct bpf_iter__kmem_cache {
	union {
		struct bpf_iter_meta * meta;             /*     0     8 */
	};                                               /*     0     8 */
	union {
		struct kmem_cache * s;                   /*     8     8 */
	};                                               /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

⬢ [acme@toolbox perf-tools-next]$

Next time adding a feature in the BTF encoder, please consider adding
the support for the BTF loader and the pretty printer, so that we can
capture that info and produce compileable output that has those tags.

I'll do it when I get some free time.

- Arnaldo

