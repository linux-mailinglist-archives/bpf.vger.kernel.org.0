Return-Path: <bpf+bounces-17933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364CB813F90
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CADB221D2
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15591815;
	Fri, 15 Dec 2023 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whOm1R/6"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90247E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b80b0dc5-ebd3-4d6e-8ba8-9fe4d2dbf9d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702605905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpVC96IbxxexOpg4mRHS7vO4h6BT+0ZVXeCwbJqJRJc=;
	b=whOm1R/6vDWhm+MxBIIpxsX4WpIXsepJ6X8+z2JazUPU59mua/RNhwlTLyYfNmwynQHuDA
	EwOqkPZ5QaGum2A5MMd1ao5PhAnJfdBN0ZQk322OsfWUWCVggJsntod23KoKN8egKheaJW
	bhKMO0bMa0BBEUtYz/PikzRlUxDCqeE=
Date: Thu, 14 Dec 2023 18:05:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 03/14] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index 2748f9d77b18..bd753dbccaf6 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -17,6 +17,8 @@ struct bpf_dummy_ops_test_args {
>   	struct bpf_dummy_ops_state state;
>   };
>   
> +static struct btf *bpf_dummy_ops_btf;
> +
>   static struct bpf_dummy_ops_test_args *
>   dummy_ops_init_args(const union bpf_attr *kattr, unsigned int nr)
>   {
> @@ -85,9 +87,13 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	void *image = NULL;
>   	unsigned int op_idx;
>   	int prog_ret;
> +	u32 type_id;

	s32 type_id;

>   	int err;
>   
> -	if (prog->aux->attach_btf_id != st_ops->type_id)
> +	type_id = btf_find_by_name_kind(bpf_dummy_ops_btf,
> +					bpf_bpf_dummy_ops.name,
> +					BTF_KIND_STRUCT);

	if (type_id < 0)
		return -EINVAL;

> +	if (prog->aux->attach_btf_id != type_id)
>   		return -EOPNOTSUPP;
>   
>   	func_proto = prog->aux->attach_func_proto;
> @@ -142,6 +148,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   static int bpf_dummy_init(struct btf *btf)
>   {
> +	bpf_dummy_ops_btf = btf;
>   	return 0;
>   }
>   
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index c7bbd8f3c708..5bb56c9ad4e5 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -20,6 +20,7 @@ static u32 unsupported_ops[] = {
>   
>   static const struct btf_type *tcp_sock_type;
>   static u32 tcp_sock_id, sock_id;
> +static const struct btf_type *tcp_congestion_ops_type;
>   
>   static int bpf_tcp_ca_init(struct btf *btf)
>   {
> @@ -36,6 +37,11 @@ static int bpf_tcp_ca_init(struct btf *btf)
>   	tcp_sock_id = type_id;
>   	tcp_sock_type = btf_type_by_id(btf, tcp_sock_id);
>   
> +	type_id = btf_find_by_name_kind(btf, "tcp_congestion_ops", BTF_KIND_STRUCT);
> +	if (type_id < 0)
> +		return -EINVAL;
> +	tcp_congestion_ops_type = btf_type_by_id(btf, type_id);
> +
>   	return 0;
>   }
>   
> @@ -149,7 +155,7 @@ static u32 prog_ops_moff(const struct bpf_prog *prog)
>   	u32 midx;
>   
>   	midx = prog->expected_attach_type;
> -	t = bpf_tcp_congestion_ops.type;
> +	t = tcp_congestion_ops_type;
>   	m = &btf_type_member(t)[midx];
>   
>   	return __btf_member_bit_offset(t, m) / 8;


