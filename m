Return-Path: <bpf+bounces-138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5776F88F7
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58231281082
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80730C8E4;
	Fri,  5 May 2023 18:49:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB01156EF
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:49:13 +0000 (UTC)
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10721559
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 11:49:08 -0700 (PDT)
Message-ID: <45684b6f-ecfb-5f14-e5ad-386b8f611c7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683312545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIpoDvP+sUtxX320Xv2sW2+9cRPPV+RYBhqLgppamBI=;
	b=Zq4M2LpQXHR3lSzv196IU/TKL101y4ynrr21SNzccyhFo6iMMVyfJ7YgAoH9hknpBHfxeS
	TJbHwYD4AgiEEhdyJsRqal4GzOTkzqpSbtKeermi+8HVkXxHZkNkEzzhudplfJAD2XX3on
	Edm5PSl/wHAhpqM1+B818hpb4xPAIV8=
Date: Fri, 5 May 2023 11:49:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 06/10] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>
Cc: sdf@google.com, bpf@vger.kernel.org, Aditi Ghag <aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-7-aditi.ghag@isovalent.com>
 <1013e81f-5a0a-dd0b-c18d-3ee849c079ab@linux.dev>
In-Reply-To: <1013e81f-5a0a-dd0b-c18d-3ee849c079ab@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/4/23 5:13 PM, Martin KaFai Lau wrote:
> 
> Follow up on the v6 patch-set regarding KF_TRUSTED_ARGS.
> KF_TRUSTED_ARGS is needed here to avoid the cases where a PTR_TO_BTF_ID sk is 
> obtained by following another pointer. eg. getting a sk pointer (may be even 
> NULL) by following another sk pointer. The recent PTR_TRUSTED concept in the 
> verifier can guard this. I tried and the following should do:
> 
> diff --git i/net/core/filter.c w/net/core/filter.c
> index 68b228f3eca6..d82e038da0e3 100644
> --- i/net/core/filter.c
> +++ w/net/core/filter.c
> @@ -11767,7 +11767,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>   __diag_pop()
> 
>   BTF_SET8_START(sock_destroy_kfunc_set)
> -BTF_ID_FLAGS(func, bpf_sock_destroy)
> +BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
>   BTF_SET8_END(sock_destroy_kfunc_set)
> 
>   static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
> diff --git i/net/ipv4/tcp_ipv4.c w/net/ipv4/tcp_ipv4.c
> index 887f83a90d85..a769284e8291 100644
> --- i/net/ipv4/tcp_ipv4.c
> +++ w/net/ipv4/tcp_ipv4.c
> @@ -3354,7 +3354,7 @@ static struct bpf_iter_reg tcp_reg_info = {
>       .ctx_arg_info_size    = 1,
>       .ctx_arg_info        = {
>           { offsetof(struct bpf_iter__tcp, sk_common),
> -          PTR_TO_BTF_ID_OR_NULL },
> +          PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },

Alexei, what do you think about having "PTR_MAYBE_NULL | PTR_TRUSTED" here?
The verifier side looks fine (eg. is_trusted_reg() is taking PTR_MAYBE_NULL into 
consideration). However, it seems this will be the first "PTR_MAYBE_NULL | 
PTR_TRUSTED" use case and not sure if PTR_MAYBE_NULL may conceptually conflict 
with the PTR_TRUSTED idea (like PTR_TRUSTED should not be NULL).

>       },
>       .get_func_proto        = bpf_iter_tcp_get_func_proto,
>       .seq_info        = &tcp_seq_info,
> diff --git i/net/ipv4/udp.c w/net/ipv4/udp.c
> index 746c85f2bb03..945b641b363b 100644
> --- i/net/ipv4/udp.c
> +++ w/net/ipv4/udp.c
> @@ -3646,7 +3646,7 @@ static struct bpf_iter_reg udp_reg_info = {
>       .ctx_arg_info_size    = 1,
>       .ctx_arg_info        = {
>           { offsetof(struct bpf_iter__udp, udp_sk),
> -          PTR_TO_BTF_ID_OR_NULL },
> +          PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
>       },
>       .seq_info        = &udp_seq_info,
>   };


