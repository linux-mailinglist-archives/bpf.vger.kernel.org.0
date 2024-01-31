Return-Path: <bpf+bounces-20789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32C843613
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 06:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9040B1C21736
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E23D57A;
	Wed, 31 Jan 2024 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TK6d/hLf"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F73D980
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679044; cv=none; b=PFhjlnWOxdo7plOvC/5mYyU7D9oXVmWS85tbsVJiRqb+fJW2dmdgO3m27uccn+wglx63I7YcL+jm92Ka/mtHEL8N/uttUyyGfKX5oDLdKI+b83huMr7VsHy/19kydjjI+jMIelftFWxSfjK24R11KGhgEepbqfl1aV5rwni1mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679044; c=relaxed/simple;
	bh=IFk//7mm/iWZDXTV0iB0hdiOmjCawqt2h/1/FcRXdI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTzCAcgCvhcZHJX9ECLxK0A7p/3uSMWeFyFZe2SAjR8N1Xc8TfKrtv0j15YYYMYbLwyJqrhamgLuFBim+X9v2/n9bk7g5gMm+nDeKJTOY8z2t7vduzvTl57K3CQLVYnOp1QJZ1LWYDnAG1FHEe2Z4ShQDqaC2jZPvO7s1A4GWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TK6d/hLf; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b4b98dd-64a6-4fbd-bc8f-45006cc0e089@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706679041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68zwM3ZsFwKz1q5yCZ6FfguyFlRug7V1XDfNsuy5VBE=;
	b=TK6d/hLfuU+2a8LyGc26xIBnFyHtliAOPy/vh8z6fEVplfkg3O8j1iVBSAE7nCBmRLahtY
	sQsdwcoXvQey5mp87MrrF02LgQo2ss8D4ONT0eh4jVOjTxofkGjGvIPX5uXlzvSZzvlA7w
	mSXojs2adpIplwhTO0qLWpAORwbPkNM=
Date: Tue, 30 Jan 2024 21:30:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/5] libbpf: add btf__new_split() API that was
 declared but not implemented
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-4-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240130193649.3753476-4-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> Seems like original commit adding split BTF support intended to add
> btf__new_split() API, and even declared it in libbpf.map, but never
> added (trivial) implementation. Fix this.
>
> Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

The patch LGTM. We did some cross checking between libbpf.map
and the implementation. What things are missing here to
capture missed implementation or LIBBPF_API marking?

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/lib/bpf/btf.c      | 5 +++++
>   tools/lib/bpf/libbpf.map | 3 ++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 95db88b36cf3..845034d15420 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 size)
>   	return libbpf_ptr(btf_new(data, size, NULL));
>   }
>   
> +struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
> +{
> +	return libbpf_ptr(btf_new(data, size, base_btf));
> +}
> +
>   static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>   				 struct btf_ext **btf_ext)
>   {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d9e1f57534fa..386964f572a8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
>   		btf__parse_raw_split;
>   		btf__parse_split;
>   		btf__new_empty_split;
> -		btf__new_split;
>   		ring_buffer__epoll_fd;
>   } LIBBPF_0.2.0;
>   
> @@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
>   } LIBBPF_1.2.0;
>   
>   LIBBPF_1.4.0 {
> +	global:
>   		bpf_token_create;
> +		btf__new_split;
>   } LIBBPF_1.3.0;

