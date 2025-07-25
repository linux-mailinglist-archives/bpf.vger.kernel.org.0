Return-Path: <bpf+bounces-64379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32926B1217D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EE37A8AB0
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA812EF28F;
	Fri, 25 Jul 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1GdaUB3"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C632EE61C
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460004; cv=none; b=cPcMwqf6M62ROXg/FyQYsCuXo07XWUzwRXiB8C6VaHpTUFRzGYmi5YA+aI9aNOC9D8LRwAOD2Qi5IsiL6P2nCNmFkNLB5FlMw5WyMng3dO2YST/9+ktnkc6lVKaBdp9kbMObiaq11h6arHfIHMIIfmw9p2MzQ6DVB9sw/DIxluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460004; c=relaxed/simple;
	bh=vTpbd0BP2L6tPWRLZ509TtVKssBkd0klbMWWaSLeeWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rocdIODekhXkAoXwNtazagN3XKO1tITLTtlZQaaxPWGQ1avNQN/4WFBKeto9Jrdc3/Je7RMSNkL6GpAtu5bK9WPvwjRwcOOks6Vt9UFy7p2z0halgvxAMRuo1uciUohuGaiWPTMuoNxL/De4TnV6dYq8+NHbqVAsn/KLrRmZ2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1GdaUB3; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6bab8404-f830-4855-be83-df57705491f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753459990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRWnqQggMPPeHBerbCQybKqJBdoR2jYJWymSZs5VvRM=;
	b=a1GdaUB3hA1rLLby3rC4NSVZZevqwc72Qcv6T84csnpMi+/OmKarf0ZjOpJrei2Bg02CHk
	veA4gw3vtyzIzyRVc3uVLDUz409OlegP60NbfknrwMMgrLkmR0W6oLMlkUfjPI6atdX2Q3
	jgZa/k6tyiy9OUoeuMOVXYL08kAWPuU=
Date: Fri, 25 Jul 2025 09:13:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: crypto: Use the correct destructor
 kfunc type
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250724223225.1481960-6-samitolvanen@google.com>
 <20250724223225.1481960-7-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250724223225.1481960-7-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/24/25 3:32 PM, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches the
> target function. I ran into the following type mismatch when running
> BPF self-tests:
>
>    CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
>      bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
>    Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
>    ...
>
> As bpf_crypto_ctx_release() is also used in BPF programs and using
> a void pointer as the argument would make the verifier unhappy, add
> a simple stub function with the correct type and register it as the
> destructor kfunc instead.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>   kernel/bpf/crypto.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..b703b1d1c282 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -261,6 +261,11 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>   		call_rcu(&ctx->rcu, crypto_free_cb);
>   }
>   
> +__bpf_kfunc void __bpf_crypto_ctx_release(void *ctx)

We are not really creating a kfunc here. The function is merely
to be used for destructor. So you can replace '__bpf_kfunc' with
'__used __retain'.

> +{
> +	bpf_crypto_ctx_release(ctx);
> +}
> +
>   static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>   			    const struct bpf_dynptr_kern *src,
>   			    const struct bpf_dynptr_kern *dst,
> @@ -368,7 +373,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
>   
>   BTF_ID_LIST(bpf_crypto_dtor_ids)
>   BTF_ID(struct, bpf_crypto_ctx)
> -BTF_ID(func, bpf_crypto_ctx_release)
> +BTF_ID(func, __bpf_crypto_ctx_release)
>   
>   static int __init crypto_kfunc_init(void)
>   {


