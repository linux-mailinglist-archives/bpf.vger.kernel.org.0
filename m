Return-Path: <bpf+bounces-78020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ADECFB54D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9772303B180
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971D301010;
	Tue,  6 Jan 2026 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cgleLD5N"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79D2F25EB;
	Tue,  6 Jan 2026 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741137; cv=none; b=RxudF7tfunfgTe1i7SOvOJB8pKveLbU8l7D21fcjciwbh0k/I2Yp+5yOn+auSzIseBwH68ezr6OJAYwuuggr52wxC0V865pjaqDJYEdG+aC/fzwscKCQ1cYcep/kKPMFdjvUM11nZUWrCOiYomQ+T34DA467/ZVv1u6+CnstBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741137; c=relaxed/simple;
	bh=Olnd6ntWy0T7Fm7UkbaDuXWc5PknhxjePk4OmYP+8uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLQHjcXKBTBzsUIjokl2L1WOSW+almXeEagZy5zaGNuQ0zh4rz7l3kjCVq5m/HZsvpktzyXVe+Eo/GzS3WGNCZMPo6mwTdegOpbH+Vo4+ztyzk28kUWCvm9dWn+DZhaboLmwRpALTiVlXJVR85JfQ0QpXPluvY1HdKwv6g/uZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cgleLD5N; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1a7abd3c-5ab4-4d38-a89f-78cb5b6ca14c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767741132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWG7Evt10/KKaS0ZLqsl+z3PfiVaVWRY4OYBns6dWWw=;
	b=cgleLD5NtZtPaPwxIKp5zL8qCPNm7qYSMnGih0MzcQ+710+7PEaQD9oaL5IXLMtiee/Roa
	6WT5/5sW4Tqcvs7HaHQjR+MO0HNuYFpmAK3inu3/0s1WQ8DMxC7b3+vaK0LByevZOFV6Ig
	Yp4UuOQ2Oxtb4vlNU+Jc8IcXndD+q/M=
Date: Tue, 6 Jan 2026 23:11:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Add ECDSA signature verification
 kfuncs
To: Daniel Hodges <git@danielhodges.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260105173755.22515-1-git@danielhodges.dev>
 <20260105173755.22515-6-git@danielhodges.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260105173755.22515-6-git@danielhodges.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/01/2026 17:37, Daniel Hodges wrote:
> Add support for ECDSA signature verification in BPF programs through
> the unified bpf_crypto_ctx API.
> 
> Changes:
> - Add enum bpf_crypto_type_id for efficient type checking
> - Update all crypto type modules to set type_id field
> - Implement bpf_ecdsa_verify() for signature verification
> - Add bpf_ecdsa_keysize(), bpf_ecdsa_digestsize(), bpf_ecdsa_maxsize()
>    helper functions for querying context properties
> - Add type_id checks in all ECDSA kfuncs for type safety
> - Register ECDSA kfuncs for SCHED_CLS and XDP program types
> 
> ECDSA contexts are created using bpf_crypto_ctx_create() with
> type="sig" and appropriate algorithm (e.g., "p1363(ecdsa-nist-p256)").
> The public key is passed via the key/key_len fields in bpf_crypto_params.
> 
> This enables BPF programs to perform cryptographic signature verification
> for use cases such as packet authentication and content validation.
> 
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> @@ -57,6 +58,7 @@ struct bpf_crypto_ctx {
>   	refcount_t usage;
>   };
>   
> +
>   int bpf_crypto_register_type(const struct bpf_crypto_type *type)
>   {
>   	struct bpf_crypto_type_list *node;

This chunk is extra empty line - no need for it



