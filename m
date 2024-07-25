Return-Path: <bpf+bounces-35608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2540D93BC41
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 07:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8531F2393F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469613E881;
	Thu, 25 Jul 2024 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jxrq+YPM"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633E1CFB9
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886916; cv=none; b=uadk9IblJoMrbFRCm/x7t+wYeQxpDyOif+4QJEAhdqU2dhh7C0MKWq1t/E2t1lrufgdjy3wy0WdE0DP0NLWkqhD5d0gXzS9/CfMgBObuvx6rcXKQ69QU+x0pNU4KJjv0Khf5j+Y2hjYh3BZxf75BTb+zmIi6eBobjuBxR/+SZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886916; c=relaxed/simple;
	bh=xuzbDE52Bn6g9Euv+PJQJSS0ckZ6+0Rbj8cvnQofx9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVkzGJW67xsEgZn1F45WDGFa42SoTEErC9L9Uzqc0gXkVeIF54QABbpnI+5FAbld9tu5qubb2ioWAxHJwvqR2u5gM3xDtSDBaBAH4UYPbYVl7OypQ9NFWPpbJWxFb1UWLjaeeRUr+DqaO+Ya/++pRJTZVhekk7BGMw+R+dI3CRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jxrq+YPM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721886910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzZHqkug/79QkjvohWjTIiykDjrWCF7qe3jwRF2k0Zc=;
	b=jxrq+YPMUDN/EtNcSM8Vr6FrUYeofEuJoGyd1CjZ7tXTeUt6kNrNjdfaJD4eEmtkdCxdk/
	EjwjCQri7eAAqPAGFXmt+5ao20q5FEcrCaaBVHPs/J2/j0JABoos8SC91XnUTGzvVqqqXb
	euIV3+jiqz+VCU+FRKpQnnCDwLaWfLg=
Date: Wed, 24 Jul 2024 22:54:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-GB
To: Zheao Li <me@manjusaka.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240725051511.57112-1-me@manjusaka.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 10:15 PM, Zheao Li wrote:
> This is a v2 patch, previous Link: https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u
>
> Compare with v1:
>
> 1. Format the code style and signed-off field
> 2. Use a shorter name bpf_check_attach_target_with_klog instead of
> original name bpf_check_attach_target_with_kernel_log
>
> When attaching a freplace hook, failures can occur,
> but currently, no output is provided to help developers diagnose the root cause.
>
> This commit adds a new method, bpf_check_attach_target_with_klog,
> which outputs the verifier log to the kernel.
> Developers can then use dmesg to obtain more detailed information about the failure.
>
> For an example of eBPF code,
> Link: https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace/main.go
>
> Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> Signed-off-by: Zheao Li <me@manjusaka.me>
> ---
>   include/linux/bpf_verifier.h |  5 +++++
>   kernel/bpf/syscall.c         |  5 +++--
>   kernel/bpf/trampoline.c      |  6 +++---
>   kernel/bpf/verifier.c        | 19 +++++++++++++++++++
>   4 files changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cea15c81b8a..8eddba62c194 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -848,6 +848,11 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
>   		*btf_id = key & 0x7FFFFFFF;
>   }
>   
> +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
> +					    const struct bpf_prog *tgt_prog,
> +					    u32 btf_id,
> +					    struct bpf_attach_target_info *tgt_info);

format issue in the above. Same code alignment is needed for arguments in different lines.

> +
>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			    const struct bpf_prog *prog,
>   			    const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 869265852d51..bf826fcc8cf4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>   		 */
>   		struct bpf_attach_target_info tgt_info = {};
>   
> -		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
> -					      &tgt_info);
> +		err = bpf_check_attach_target_with_klog(prog, NULL,
> +							      prog->aux->attach_btf_id,
> +							      &tgt_info);

code alignment issue here as well.
Also, the argument should be 'prog, tgt_prog, btf_id, &tgt_info', right?

>   		if (err)
>   			goto out_unlock;
>   
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f8302a5ca400..8862adaa7302 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>   	u64 key;
>   	int err;
>   
> -	err = bpf_check_attach_target(NULL, prog, NULL,
> -				      prog->aux->attach_btf_id,
> -				      &tgt_info);
> +	err = bpf_check_attach_target_with_klog(prog, NULL,
> +						      prog->aux->attach_btf_id,
> +						      &tgt_info);

code alignment issue here

>   	if (err)
>   		return err;
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1f5302fb0957..4873b72f5a9a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21643,6 +21643,25 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>   	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>   }
>   
> +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
> +					    const struct bpf_prog *tgt_prog,
> +					    u32 btf_id,
> +					    struct bpf_attach_target_info *tgt_info);

code alignment issue here.

> +{
> +	struct bpf_verifier_log *log;
> +	int err;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);

__GFP_NOWARN is unnecessary here.

> +	if (!log) {
> +		err = -ENOMEM;
> +		return err;
> +	}
> +	log->level = BPF_LOG_KERNEL;
> +	err = bpf_check_attach_target(log, prog, tgt_prog, btf_id, tgt_info);
> +	kfree(log);
> +	return err;
> +}
> +
>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>   			    const struct bpf_prog *prog,
>   			    const struct bpf_prog *tgt_prog,

More importantly, Andrii has implemented retsnoop, which intends to locate
precise location in the kernel where err happens. The link is
   https://github.com/anakryiko/retsnoop

Maybe you want to take a look and see whether it can resolve your issue.
We should really avoid putting more stuff in dmesg whenever possible.


