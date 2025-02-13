Return-Path: <bpf+bounces-51466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA5A34EBA
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E771916D274
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DE24A076;
	Thu, 13 Feb 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVqHzfis"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E216245B05
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476492; cv=none; b=dp/UBKnUvCmxpH9SDkpskswgu7WKEj6+BcBM8VhVmNO4IW1Kj0uqqxMx0fgCRLhmPApVDdReJ8eQz8ggwr/rTqdhGkKRWLCCWD+8zl44pbryYwkh9bGlvr+Xt8ND3LG/M0C1q1AeiTRqNJhqtLy+TLPcaitaP7L4YmDtZUpIa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476492; c=relaxed/simple;
	bh=gkhsxtf9qrRF8WXSpi9+XQph/BdpyHFwb9XUpfJkdek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbpYtQtptSUp3n0SrGd5xVHzBfEAkABHJHa9mxkL82i+10Lan+N0hsM9XtD5Tsqggf5mDXOpmNKr9yxPMW+jXed5doewREq+9jLXzx9YjelJh918lEi/K+dygwXAUrzm9B+eq44HEYkhfwQm+fbvfMtn+J1l+V6rXC9iyZNe3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVqHzfis; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0bee571a-927d-4042-9e89-53bf695ec054@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739476487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kq5wfnoFKln0Y2OzD3jZdnjsfuZI5Yaaccu5d5315Sk=;
	b=ZVqHzfisqjB1D8ffEBfdpMuxGU2JY0k8Mfay+2bURk6tYJYzAhwkU3Pse7G/OeAolFuDxx
	/qXtphDImXClZ9pzJ90Kfx7YO3fFUGh+B/V+ShYfAs95Tmn8fmU+hzuMOFrq5/snHcVd6D
	nZepCTZJYU4KfJHLzk14IZq6+RvmS8M=
Date: Thu, 13 Feb 2025 11:54:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 01/19] bpf: Make every prog keep a copy of
 ctx_arg_info
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com,
 cong.wang@bytedance.com, jhs@mojatatu.com, sinquersw@gmail.com,
 toke@redhat.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250210174336.2024258-1-ameryhung@gmail.com>
 <20250210174336.2024258-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250210174336.2024258-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/10/25 9:43 AM, Amery Hung wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..a41ba019780f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22377,6 +22377,18 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>   		env->peak_states, env->longest_mark_read_walk);
>   }
>   
> +int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> +			       const struct bpf_ctx_arg_aux *info, u32 cnt)
> +{
> +	prog->aux->ctx_arg_info = kcalloc(cnt, sizeof(*info), GFP_KERNEL);

Missing a kfree.

> +	if (!prog->aux->ctx_arg_info)
> +		return -ENOMEM;
> +
> +	memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
> +	prog->aux->ctx_arg_info_size = cnt;
> +	return 0;
> +}
> +

