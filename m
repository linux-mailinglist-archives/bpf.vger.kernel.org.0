Return-Path: <bpf+bounces-76082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5343CA4E72
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6C33077E64
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704E5364EAF;
	Thu,  4 Dec 2025 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxolkMqO"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8E364E9B
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872342; cv=none; b=L7l2OOWRKokpMujpPbkzgHmpMzcJ61RtfbmCPbVqSyjqgsOfhzup/Ua0M8mxvRuHmwZFEEZowPzYw5EoQfDHmS3zcNLm+GYJCEjHOaD5gpFNQgh47OWJVSUjqMUBzhHuQ6K576MmmZJB9MfAUvxuD3+mACuIWR8GFeG2Be6BTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872342; c=relaxed/simple;
	bh=7Vg+sUqDEGkddo9gM3K8cgAS0h36LZhkXtC/3PB2nRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZByY/6TJtDcEkadknBsxjE0C8j9EZ721TKxByI0QXSEc32OEp4g4kqGkjfXjTlZzNTZaxVeMgSq44HEunDbMWtZevOdicNbR7fQWdA302OxUWXjmHCUbuSY6AQlbxEHr5hBEQOBbHeqlthv9gnToe+STykd1XlPH9tBDS8UmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxolkMqO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae991e0c-66e9-4e27-ab8a-ab166c12dd60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764872327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4T+2P2ViQeWy94dgDnC4eMz2hzs9znnO0lAojnK0RQ=;
	b=kxolkMqO0qBAZTVy/D44C+Y9O7D6GRxj35sMQpi/cVwkOYD2qc5IgYQ87oFivCfGIx8GTx
	i1f+fks1/WC2KEk6Q5IwS/Ff3IjXDDDdFeNS8bNe0xwbWOQn2I5BeCkRoi8tlEFtztZ+8+
	OiqFQ2r5Kbu2+iV9ndtSMacSOpP35qc=
Date: Thu, 4 Dec 2025 10:18:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bpf: Fix register_bpf_struct_ops() dummy
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1764843951.git.geert@linux-m68k.org>
 <ead27aa92275c71c1fcd148f88ca6926a524f322.1764843951.git.geert@linux-m68k.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ead27aa92275c71c1fcd148f88ca6926a524f322.1764843951.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 2:29 AM, Geert Uytterhoeven wrote:
> If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n:
> 
>      net/smc/smc_hs_bpf.c: In function ‘bpf_smc_hs_ctrl_init’:
>      include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
>       2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
> 	  |                                                  ^~~~~~~~~~~~~~~~
>      net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro ‘register_bpf_struct_ops’
>        139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
> 	  |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> As type is not a variable, but a variable type, this cannot be fixed by
> just converting register_bpf_struct_ops() into a static inline function.
> Hence fix this by introducing a static inline intermediate dummy.
> 
> Fixes: f6be98d19985411c ("bpf, net: switch to dynamic registration")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   include/linux/bpf.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6498be4c44f8c275..bb69905c28a761e7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2065,7 +2065,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>   void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
>   #else
> -#define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
> +static inline int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +{
> +	return 0;
> +}
> +#define register_bpf_struct_ops(st_ops, type) __register_bpf_struct_ops(st_ops)

Only patch 2 is needed. This empty register_bpf_struct_ops should be 
removed in the bpf-next tree as a cleanup.


