Return-Path: <bpf+bounces-14681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64B7E7711
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A87B20F23
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB21102;
	Fri, 10 Nov 2023 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BHnOxfrZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21AED1
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:12:05 +0000 (UTC)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C913A8D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:12:04 -0800 (PST)
Message-ID: <4218c215-a8f9-8efb-6958-d7cbb4d792a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699582322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yO9O3LSS3LFdxp8a+SzowsKV8KFlrDgGjVeKds4yyA=;
	b=BHnOxfrZDatsj5dQMTvgDzpt/WC2THKD1yW3LuCjmGrwCSTnIsceJhIhYCgyNJ5mf+K7mN
	MsmKlJdQ4Wjh6eqF4Jzw8CLKzp6aihT1OQCYeNINl+uQcFhHhm2fd8C1sAy90/LXtyiRZa
	LVNDFwx14bXyFvriDgqoCUIfj2CogKA=
Date: Thu, 9 Nov 2023 18:11:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 09/13] bpf: validate value_type
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-10-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231106201252.1568931-10-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> A value_type should consist of three components: refcnt, state, and data.
> refcnt and state has been move to struct bpf_struct_ops_common_value to
> make it easier to check the value type.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         | 14 ++++++
>   kernel/bpf/bpf_struct_ops.c | 93 ++++++++++++++++++++++++-------------
>   2 files changed, 74 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c287f42b2e48..48e97a255945 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3231,4 +3231,18 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +#ifdef CONFIG_BPF_JIT

There is an existing "#if defined(CONFIG_BPF_JIT) && 
defined(CONFIG_BPF_SYSCALL)" above and a few bpf_struct_ops_*() has already been 
there. Does it need another separate one which is only CONFIG_BPF_JIT here?

> +enum bpf_struct_ops_state {
> +	BPF_STRUCT_OPS_STATE_INIT,
> +	BPF_STRUCT_OPS_STATE_INUSE,
> +	BPF_STRUCT_OPS_STATE_TOBEFREE,
> +	BPF_STRUCT_OPS_STATE_READY,
> +};
> +
> +struct bpf_struct_ops_common_value {
> +	refcount_t refcnt;
> +	enum bpf_struct_ops_state state;
> +};

Do the struct and enum really need to be in ifdef?

> +#endif /* CONFIG_BPF_JIT */
> +


