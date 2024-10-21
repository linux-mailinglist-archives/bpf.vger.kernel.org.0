Return-Path: <bpf+bounces-42585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81199A5E6A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4589BB22D84
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074C1E0DE9;
	Mon, 21 Oct 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIi+f1lR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7831A60
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498725; cv=none; b=OGQi5EOTvBMSIUtgNEFh4AdERF7Qphaog+9upC3nim+aPsY391LLmtzxRwy0hlAy6/1CfSvqeXQ/BSHogQzhH3qygPuZ/665xkZu0bdNTe6ga16LkJg8m8GfRyaeD6IsWz82lj2bR6bXybCJbeCTN8FlCAg15BT0nf0wGCGjr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498725; c=relaxed/simple;
	bh=s4KEYNGgIQplcJvet3RLV4X5XSs9CXxnyTY6FxYxLGY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij8YRgHKwLWRTACwHd+c/BzD4rGHd+DzU6l3m+6w/47mxh0nAafiFqChQV4BM8tzbjgc28CDq53ASVl3Up9rwod6TkmZco2JYq8HiezUCleDRC0UBNREoplEYABTEn6iCxPzkKwGY2rdmhI+64gOsfJBiqRBAaspcukhi9BC1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIi+f1lR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so565093266b.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498722; x=1730103522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4E6OCLzb+c5iWKJrtY4Pq190JTG757qMMgjgz8lAGs=;
        b=dIi+f1lRb6kEMzcJ7h9n6pz1ERjI0w72nLj2ob0QTeiIsjomXVhNAk8ShmFBXCRjNe
         3bPUa/k/+PgvPpi8gw9yWtzLazfNPEnhNbhsHqTz8ioCYarivPP/Z0zLdAWIWPTDzBIu
         ktjI4jcNj45DX372zz0RkOlyN8fDjXz6h25X9X6WT9wdAGZdVA0nPJKGc9NBkbfpjQxO
         NT4z5bTHG3MWnz8R4JmGRqJkF1UuXtL0gz3MDLNfueqLZs6eyRf/GjsmA44wZGFG6xk1
         +Km3dz43IPUvHFPvj3GEWG5+NCOy0OubqwgOrmcIj1rnK27LKLAB1pAftjP+zv1OzkND
         UUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498722; x=1730103522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4E6OCLzb+c5iWKJrtY4Pq190JTG757qMMgjgz8lAGs=;
        b=dqDeYFodg5GVMSbNf1tR/U1bMH7F/BdESjHX1GH5NK5C+u788XkGPqjeS9kOiFEssc
         k3D6FX3kbnBan2dlXmYaUIDDEIXuGNM26EMI6p5xV56uHBxZ0b85Q0Sh9V7V93RqSo18
         7twpY0hx33MGOZaxGMbAxGbaeih69uQiWVfWOXz2EXotoLVGbdd7FzH1Q1wi8exQafAg
         5iW+4BR6OYUM51+oiTJ/uxAlVXTZS9iBgQ8SEOUdW9XKqbafdDkyCAAKPWrI/v11CK4r
         p51IRsjiPOocg2qrbbz2+65SUlKuIo594IGM7MkjdpXoPyxmtkKS3QfjqyPieT7lo6B6
         wsOQ==
X-Gm-Message-State: AOJu0YzJLMpHHOy4JT856m84Vg3qX+Xng2L+YtshyKCP+zICD6ecBNJU
	0A3QDbzL1soDNOWs9c0ttaw3K1Wv/nTqI03BT78q4Ssg9xLLsEN1
X-Google-Smtp-Source: AGHT+IEb/mMtkFpnx6cXMzc2HC2FeoJsdnm12JXtevVp9b7AqPURtjYA+NKUMpeE8GcIWVpVEgYBIw==
X-Received: by 2002:a17:907:7214:b0:a9a:a5c:e23b with SMTP id a640c23a62f3a-a9a69cd3014mr892750866b.58.1729498721393;
        Mon, 21 Oct 2024 01:18:41 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915a2df1sm173421566b.225.2024.10.21.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:18:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 10:18:39 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf v2 2/7] bpf: Add assertion for the size of
 bpf_link_type_strs[]
Message-ID: <ZxYOX9_sIrSKGFB2@krava>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021014004.1647816-3-houtao@huaweicloud.com>

On Mon, Oct 21, 2024 at 09:39:59AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> If a corresponding link type doesn't invoke BPF_LINK_TYPE(), accessing
> bpf_link_type_strs[link->type] may result in out-of-bound access.
> 
> To prevent such missed invocations in the future, the following static
> assertion seems feasible:
> 
>   BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE)
> 
> However, this doesn't work well. The reason is that the invocation of
> BPF_LINK_TYPE() for one link type is optional due to its CONFIG_XXX
> dependency and the elements in bpf_link_type_strs[] will be sparse. For
> example, if CONFIG_NET is disabled, the size of bpf_link_type_strs will
> be BPF_LINK_TYPE_UPROBE_MULTI + 1.
> 
> Therefore, in addition to the static assertion, remove all CONFIG_XXX
> conditions for the invocation of BPF_LINK_TYPE(). If these CONFIG_XXX
> conditions become necessary later, the fix may need to be revised (e.g.,
> to check the validity of link_type in bpf_link_show_fdinfo()).
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf_types.h | 6 ------
>  kernel/bpf/syscall.c      | 2 ++
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fa78f49d4a9a..6b7eabe9a115 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -136,21 +136,15 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
>  
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> -#ifdef CONFIG_CGROUP_BPF
>  BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
> -#endif
>  BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
> -#ifdef CONFIG_NET
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_SOCKMAP, sockmap)
> -#endif
> -#ifdef CONFIG_PERF_EVENTS
>  BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
> -#endif
>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8cfa7183d2ef..9f335c379b05 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3071,6 +3071,8 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>  	const struct bpf_prog *prog = link->prog;
>  	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(bpf_link_type_strs) != __MAX_BPF_LINK_TYPE);

I wonder it'd be simpler to just kill BPF_LINK_TYPE completely
and add link names directly to bpf_link_type_strs array..
it seems it's the only purpose of the BPF_LINK_TYPE macro

jirka

