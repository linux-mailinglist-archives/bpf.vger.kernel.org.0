Return-Path: <bpf+bounces-20788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE678435EE
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 06:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE6428A245
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 05:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B23D56F;
	Wed, 31 Jan 2024 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s8uf+Ou0"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB23D54C
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678176; cv=none; b=RrxMPCrAzJp+i0NJiCAX8TfUoRM/+A+byYZ92XkKaKCWrSKkHsgQ6vcfsKCqbvZEKNSX6QBip5qRlMMHSEDXde1Crhya1XxAKQY5E39Czxfblq3WeYx7LhnvC5a4MPiugNocKG0A+eLyiGwu+bbeeYiz0NOgXvaz1W/GIMVVAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678176; c=relaxed/simple;
	bh=gtTRU/T8g65wGY5C6/+eIBCVpItNBdZ46BFzcTBxuBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLp3zIVnBOkOmlezPf6HjyC/hnERlJ1Oo40/0QsvWm8G7E0/gyXuKnzydXILP2GGfvF1fmnfMrnl8GPGjOu2WZLaCPZ1Jxz+8EvfqBOZCAlvWm1Y+QoMezcdDX3ZoadJa2TW6qU9+ZK08pUOyYwNcwyWPHz2GL80ujb1LhFSe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s8uf+Ou0; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aa043e86-586d-45dd-83c0-f47b271c2634@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706678169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZZieZDz72Z37v4xfkvmYN3Qq0TO1CAKB4YOsI9Msvo=;
	b=s8uf+Ou0yrXLqdYKLiA4qja3EVZLJrEixogIZaoZLpoGW1qB0XoJGJNMGAsNAeKkzKlgzr
	eDDQnf5PuiOjR6iIVugWQnfYplVh8FXaxlZ3hMlixbADSwyi4ez/I6UtLhSoeY1vcNOyiC
	Iv05ShYsd98416os+BAkUDDTzBFjWp4=
Date: Tue, 30 Jan 2024 21:16:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to
 libbpf_set_memlock_rlim API
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-3-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240130193649.3753476-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
> add it to make this API callable from libbpf's shared library version.
>
> Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")

Maybe we should the following commit as Fixes?

   ab9a5a05dc48 libbpf: fix up few libbpf.map problems

Other than the above, LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/bpf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 1441f642c563..f866e98b2436 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -35,7 +35,7 @@
>   extern "C" {
>   #endif
>   
> -int libbpf_set_memlock_rlim(size_t memlock_bytes);
> +LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>   
>   struct bpf_map_create_opts {
>   	size_t sz; /* size of this struct for forward/backward compatibility */

