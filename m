Return-Path: <bpf+bounces-19179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F07826B51
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B8DB21AC7
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888D134BD;
	Mon,  8 Jan 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvt0/qjh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84414271;
	Mon,  8 Jan 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3367632ce7bso1502925f8f.2;
        Mon, 08 Jan 2024 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704708334; x=1705313134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xYzN2Nttdc7HPzsAjIhxYOW2Xli4S/FbED/CaXe2GY=;
        b=dvt0/qjhTTnNLew+ZcL+lUlPjPiR81L747SrbiIaGVyfdBnjl+5v/3IyPQlPHcH9QA
         3tpXKSbEEKFHnj9/tbd/gpvdMYYqpgAT13gOd1mmME29PvDf1ZIUJqKQOaUGXV3LTea8
         1Lo1XHZWQn4WcweRFPAYQ1HNJyjiRxIsXkZNDVjd9Yf+IurOBPsxFztOK1aPI8YFvljT
         RaxHxdsOoOIwxyIf5uLyEGCgGb2lI4SrhrtDrjAK5kbfOGHps1G58NN83/E//j3PV3vI
         EcMQD7oB/l6Vqf7xJ+6KCnl/xmwCJP64nxvbNsXduy0yUUzYSYASYOtx7lcgvtQVvyIx
         8f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704708334; x=1705313134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xYzN2Nttdc7HPzsAjIhxYOW2Xli4S/FbED/CaXe2GY=;
        b=UQ3cdaGkcMC318MTs+oqxhhhISzh3hOocdXr5o0elJq1OLarTTvtwQeGsiquslWqNJ
         KzcPuEsNl9JQlMDHIJjB3sThR/d62yLxB2UL685zCipwPuXl2NIGsxtvdD72Bfs679M/
         yD/miAtdGo2m8s143IvMyKAOq2pw9c+l5cRNJ4eNIaiB0wZNecChwfEPm1SaWQg3VTE/
         n7ljPyfP83s/ohz5YT4MYecakDSEdeAX5OonQ8/8TWNvziU81xOB1hULO21JaTF1O+di
         mDfDANWD/Bsf0TnLRlOycxzyrTfEfPjVPxwcQyBXmSqzKo0yZxs3fY9OfXBjKvsbWzRa
         XiYA==
X-Gm-Message-State: AOJu0YyZxINOxZq2PKgQpxJGoHrvz3/iTXOJIWmcYYvbK1/wW0qzb1/h
	eFMXvRQhWQra5XrAMh2Gci/iB93FRmY=
X-Google-Smtp-Source: AGHT+IHKkbb5zrfuKsZwwxS8K1rupztEUtZ6sYv5Qokpp/o5IHTSRY3GUC+v2iK37aAsl1yxC5LSFA==
X-Received: by 2002:adf:c088:0:b0:336:c403:56e0 with SMTP id d8-20020adfc088000000b00336c40356e0mr1552036wrf.130.1704708333683;
        Mon, 08 Jan 2024 02:05:33 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o15-20020adfca0f000000b0033666ec47b7sm7371909wrh.99.2024.01.08.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:05:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Jan 2024 11:05:30 +0100
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Return -ENOTSUPP if calls are not
 allowed in non-JITed programs
Message-ID: <ZZvI6g2gGRoebPiO@krava>
References: <20240104130817.1221-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130817.1221-1-yangtiezhu@loongson.cn>

On Thu, Jan 04, 2024 at 09:08:17PM +0800, Tiezhu Yang wrote:
> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
> exist 6 failed tests.
> 
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   #106/p inline simple bpf_loop call FAIL
>   #107/p don't inline bpf_loop call, flags non-zero FAIL
>   #108/p don't inline bpf_loop call, callback non-constant FAIL
>   #109/p bpf_loop_inline and a dead func FAIL
>   #110/p bpf_loop_inline stack locations for loop vars FAIL
>   #111/p inline bpf_loop call in a big program FAIL
>   Summary: 768 PASSED, 15 SKIPPED, 6 FAILED
> 
> The test log shows that callbacks are not allowed in non-JITed programs,
> interpreter doesn't support them yet, thus these tests should be skipped
> if jit is disabled, just return -ENOTSUPP instead of -EINVAL for pseudo
> calls in fixup_call_args().
> 
> With this patch:
> 
>   [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
>   [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
>   [root@linux bpf]# ./test_verifier | grep FAIL
>   Summary: 768 PASSED, 21 SKIPPED, 0 FAILED
> 
> Additionally, as Eduard suggested, return -ENOTSUPP instead of -EINVAL
> for the other three places where "non-JITed" is used in error messages
> to keep consistent.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2:
>   -- rebase on the latest bpf-next tree.
>   -- return -ENOTSUPP instead of -EINVAL for the other three places
>      where "non-JITed" is used in error messages to keep consistent.
>   -- update the patch subject and commit message.
> 
>  kernel/bpf/verifier.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5f4ff1eb235..99558a5186b2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8908,7 +8908,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>  			goto error;
>  		if (env->subprog_cnt > 1 && !allow_tail_call_in_subprogs(env)) {
>  			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
> -			return -EINVAL;
> +			return -ENOTSUPP;

FWIW I agree with John review earlier [1], also there's chance (however small)
we could mess up with some app already checking on that

jirka

[1] https://lore.kernel.org/bpf/6594a4c15a677_11e86208cd@john.notmuch/

>  		}
>  		break;
>  	case BPF_FUNC_perf_event_read:
> @@ -19069,14 +19069,14 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  	if (has_kfunc_call) {
>  		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
> -		return -EINVAL;
> +		return -ENOTSUPP;
>  	}
>  	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
>  		/* When JIT fails the progs with bpf2bpf calls and tail_calls
>  		 * have to be rejected, since interpreter doesn't support them yet.
>  		 */
>  		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
> -		return -EINVAL;
> +		return -ENOTSUPP;
>  	}
>  	for (i = 0; i < prog->len; i++, insn++) {
>  		if (bpf_pseudo_func(insn)) {
> @@ -19084,7 +19084,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  			 * have to be rejected, since interpreter doesn't support them yet.
>  			 */
>  			verbose(env, "callbacks are not allowed in non-JITed programs\n");
> -			return -EINVAL;
> +			return -ENOTSUPP;
>  		}
>  
>  		if (!bpf_pseudo_call(insn))
> -- 
> 2.42.0
> 
> 

