Return-Path: <bpf+bounces-64419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF8B1271F
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 01:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476943B4D4A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97C25A63D;
	Fri, 25 Jul 2025 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjh/y5yV"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FD259CA1
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485109; cv=none; b=FY9p1/vLBHrAVicSX5/8mCukZ3aixs6DDjUcehRqYCG6YS1UZLiuubjC+RM94spQgHvLd8AsNGgvjI2dCHm/8f7X4bAu+ap+a7zCQSZEZYDT38XEf/UCjmkSDuZO9m2FNppIhuC68ymhri/Jymj3Kxg2gmWNCC+fD/Bstnrywsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485109; c=relaxed/simple;
	bh=IXkJNk6afU6gWW1EIchhvOKGzqQ7V9PRE3PFU/v204c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMxW0LRhWgmwrdzDiSI+Qhtz9LyssVQ4J5HYzyOSD6ttK2+2t6ZlTz5r6JtDy0bgAc67MWiNeiCBCdaDGD1GiDTb/rl0zjHmBcgFV8Ns4V2GUmELhLcnp/IFwaHloJkn/71L5zpsXoSTSd5arAEDJAbJOpHuw3GHadB7g6YoxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjh/y5yV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <932a6a4d-d30b-4b85-b6a9-2eabeb5eaf2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753485095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQRz5jGRtVRmnbmD+RJSpwn39XGxG33xPSgLoIzuVnI=;
	b=sjh/y5yVn7VP408JwIB0FZXLlq5c6ou7dox1+ek5j3rK3FShuNkMI47wztrk6ZnEverdie
	t5rBIe6rqMa9KvQ79lknL4SZnpJs9E6TqWEZnGTGpxzbSbGB2wU6JrGN/QZAo+jvpH1rP5
	4ObXP8+JyuR0rD0KetdiH+JvlLcHAsg=
Date: Fri, 25 Jul 2025 16:11:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf: crypto: Use the correct destructor
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
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <20250725214401.1475224-7-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250725214401.1475224-7-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 2:44 PM, Sami Tolvanen wrote:
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
>   kernel/bpf/crypto.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..f44aa454826b 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -261,6 +261,13 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>   		call_rcu(&ctx->rcu, crypto_free_cb);
>   }
>   
> +__used __retain void __bpf_crypto_ctx_release(void *ctx)
> +{
> +	bpf_crypto_ctx_release(ctx);
> +}
> +
> +CFI_NOSEAL(__bpf_crypto_ctx_release);

Okay, looks like Peter has made similar changes before.
See https://lore.kernel.org/all/20231215092707.799451071@infradead.org/

To be consistent with existing code base, I think the following
change is better:

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..a267d9087d40 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
                 call_rcu(&ctx->rcu, crypto_free_cb);
  }
  
+__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
+{
+       bpf_crypto_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
+
  static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
                             const struct bpf_dynptr_kern *src,
                             const struct bpf_dynptr_kern *dst,
@@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
  
  BTF_ID_LIST(bpf_crypto_dtor_ids)
  BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, bpf_crypto_ctx_release_dtor)
  
  static int __init crypto_kfunc_init(void)
  {

The same code pattern can be done for patch 2 and patch 3.

> +
>   static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>   			    const struct bpf_dynptr_kern *src,
>   			    const struct bpf_dynptr_kern *dst,
> @@ -368,7 +375,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
>   
>   BTF_ID_LIST(bpf_crypto_dtor_ids)
>   BTF_ID(struct, bpf_crypto_ctx)
> -BTF_ID(func, bpf_crypto_ctx_release)
> +BTF_ID(func, __bpf_crypto_ctx_release)
>   
>   static int __init crypto_kfunc_init(void)
>   {


