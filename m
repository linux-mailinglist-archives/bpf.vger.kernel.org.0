Return-Path: <bpf+bounces-62084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1CAF0E6F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FCA4881DF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7723C4E5;
	Wed,  2 Jul 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GixH43Lg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D61DD529
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446191; cv=none; b=ufWkXPR0oMAApt1W/uKJes3K2csB5r+BWKnLYG5O8oe5OZsiHfWFNrXUWnDKUtVrfDHm+t0J9lD7BGQ7n41AqB6Qgt/W5GH+oHU5Zil4lkWvTzxIOzg2WXb8WuOzuCDCGPhkUW8GAexC/TtBUN2X7daF14mZro72QudMSW2MIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446191; c=relaxed/simple;
	bh=5swc5zkL1+Zxa1e/IgIZxFlfbzwx6EKvoatS5A00Kvo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lal46QaF7epHZoUgaIsNtkYxcB1o2m+9diEQOTkwPW3ZXVyOde9DF4F5axOwW6XNKllpiQJYmJ6xf8jqu/XhtU23TP4TiVz5sIkuRE6JGn+CCKTe5kb/HiQLRfiFcJySlIMq6wXcsVzPjenLXlNMONQpVWTj8nHgKL2xoYUJhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GixH43Lg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so5812942a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751446188; x=1752050988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxCrVunBYaOtXnSZLelqCNL5LvR8oA3vuPHe9gpT37o=;
        b=GixH43LgTRuAlhsazCjALBd4AyKkbpsXAcP/RbqDIi+V3wMkzp6dAtioPmaQ2ap44k
         sEcwrXDupKlSo/VCeG8sGndoYiiXLw2ewQ5dbQGTOwfeIabcgnPhB+63XNPxepMMJNWB
         OfAHkG2ZpKcVRsi3RVs1d579lEFc2vpYBjCCdGrcO8KcvP6jpXdm47EHrA+kDBgmKwXV
         T/PL17VxULB5CmUIHUDDJMPJWG2TR2G1yN8ezk/m66xAmfUPhvaIMRHwhlfnQvt1xWQO
         4Ya1Nf6nXDR/xRlp+EH3hm64UWOrvJVyPCH7gyxdq3h+0Rqx85ou1hpaREkuGWuPZ9r6
         Nkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446188; x=1752050988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxCrVunBYaOtXnSZLelqCNL5LvR8oA3vuPHe9gpT37o=;
        b=iGAdCqvLoqW4QAvnZukrpMpZF5Ie7WhXj/hQGfrLja6Mx1chit6to9KyJsM41g0FWS
         cUYkDXb45gcgRiaqrf4C7VEfEclZDzNXWZDKcdg7eha6Xe2EgtX8GOdZy21sMQfUzK6e
         qbpW5MYUtKA5S/om3DMOJwXCswqyCfBS2Xt8QOBnBBtLlkpswc2gFKMTzWt9LhApHvjN
         Z+OCR466RCLddcnxL5NkfXKDfBYZMNtDLTm6o5C55v6wMP1nqE1ofKbr1CvtmgAJe5P4
         9pSEO5qmC7zwvqcXgVmROg0+BwHGZrmDBU+QVSvduS39IWli2lB6+fNHqFbCXzv4CQ7C
         YQJw==
X-Gm-Message-State: AOJu0Yx+wJndCHGptFuQ49lpsqr04h8EOwPvKWshOeqETeYxeacxeS+X
	3GgbVWBxzcQelABJRAvEuYBX9h0wYS+TEZP6zBflOu7NQIRa1CYZVXb5/yzEGF1P
X-Gm-Gg: ASbGncsoQP9gxIYIU6MftViSKHI5VC5EFUbqgHK3rOHFGPZzwr75nQ2FizCKKXczbjL
	G+CiTAAd9cOx0JKT5hFcOny1RtJtKgKceNBIco/TCKbdoatkR9uFUnTcQ2ypvNzNVWh9pA99AbH
	fuyukhs+iRmO1bOXhjS3kUSn0y7E1zqJXQK4QUeuDwlcalf0CX/TgNBLnpuF/pwaxHyRrnUgF0f
	eu41odLrlEes4F0Q97GzAwiPp73AtSa3XkX6oaX3PksvqTCKbN+25W8Z/Amg64qw/pX6ds7s4PC
	aruFxe4VtJGOpjvjj6tM9G+ylFr/5QR6jffPBLVm1I4uDplv
X-Google-Smtp-Source: AGHT+IF24oxeB7FOXSsMIfEkmmdWhY7jz/okNfNDHheXi5BssANEfYukQh1lA7IXhVolu/YNx/ip+A==
X-Received: by 2002:a17:907:60d4:b0:ae3:c037:369d with SMTP id a640c23a62f3a-ae3c2a6c73dmr190285866b.6.1751446187621;
        Wed, 02 Jul 2025 01:49:47 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3c915bce9sm41455666b.116.2025.07.02.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:49:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Jul 2025 10:49:45 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Avoid putting struct bpf_scc_callchain
 variables on the stack
Message-ID: <aGTyqbsSOTceHJDi@krava>
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
 <20250702053337.1991752-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702053337.1991752-1-yonghong.song@linux.dev>

On Tue, Jul 01, 2025 at 10:33:37PM -0700, Yonghong Song wrote:
> Add a 'struct bpf_scc_callchain callchain' field in bpf_verifier_env.
> This way, the previous bpf_scc_callchain local variables can be
> replaced by taking address of env->callchain. This can reduce stack
> usage and fix the following error:
>     kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds limit (1280) in 'do_check'
>         [-Werror,-Wframe-larger-than]
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 36 ++++++++++++++++++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7e459e839f8b..e2c175d608bb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -841,6 +841,7 @@ struct bpf_verifier_env {
>  	char tmp_str_buf[TMP_STR_BUF_LEN];
>  	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>  	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
> +	struct bpf_scc_callchain callchain;
>  	/* array of pointers to bpf_scc_info indexed by SCC id */
>  	struct bpf_scc_info **scc_info;
>  	u32 scc_cnt;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 29faef51065d..b334e6434eb4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1913,19 +1913,19 @@ static char *format_callchain(struct bpf_verifier_env *env, struct bpf_scc_callc
>   */
>  static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
>  {
> -	struct bpf_scc_callchain callchain;
> +	struct bpf_scc_callchain *callchain = &env->callchain;
>  	struct bpf_scc_visit *visit;
>  
> -	if (!compute_scc_callchain(env, st, &callchain))
> +	if (!compute_scc_callchain(env, st, callchain))
>  		return 0;
> -	visit = scc_visit_lookup(env, &callchain);
> -	visit = visit ?: scc_visit_alloc(env, &callchain);
> +	visit = scc_visit_lookup(env, callchain);
> +	visit = visit ?: scc_visit_alloc(env, callchain);
>  	if (!visit)
>  		return -ENOMEM;
>  	if (!visit->entry_state) {
>  		visit->entry_state = st;
>  		if (env->log.level & BPF_LOG_LEVEL2)
> -			verbose(env, "SCC enter %s\n", format_callchain(env, &callchain));
> +			verbose(env, "SCC enter %s\n", format_callchain(env, callchain));
>  	}
>  	return 0;
>  }
> @@ -1938,21 +1938,21 @@ static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visi
>   */
>  static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
>  {
> -	struct bpf_scc_callchain callchain;
> +	struct bpf_scc_callchain *callchain = &env->callchain;
>  	struct bpf_scc_visit *visit;
>  
> -	if (!compute_scc_callchain(env, st, &callchain))
> +	if (!compute_scc_callchain(env, st, callchain))
>  		return 0;
> -	visit = scc_visit_lookup(env, &callchain);
> +	visit = scc_visit_lookup(env, callchain);
>  	if (!visit) {
>  		verifier_bug(env, "scc exit: no visit info for call chain %s",
> -			     format_callchain(env, &callchain));
> +			     format_callchain(env, callchain));
>  		return -EFAULT;
>  	}
>  	if (visit->entry_state != st)
>  		return 0;
>  	if (env->log.level & BPF_LOG_LEVEL2)
> -		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
> +		verbose(env, "SCC exit %s\n", format_callchain(env, callchain));
>  	visit->entry_state = NULL;
>  	env->num_backedges -= visit->num_backedges;
>  	visit->num_backedges = 0;
> @@ -1967,22 +1967,22 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
>  			    struct bpf_verifier_state *st,
>  			    struct bpf_scc_backedge *backedge)
>  {
> -	struct bpf_scc_callchain callchain;
> +	struct bpf_scc_callchain *callchain = &env->callchain;
>  	struct bpf_scc_visit *visit;
>  
> -	if (!compute_scc_callchain(env, st, &callchain)) {
> +	if (!compute_scc_callchain(env, st, callchain)) {
>  		verifier_bug(env, "add backedge: no SCC in verification path, insn_idx %d",
>  			     st->insn_idx);
>  		return -EFAULT;
>  	}
> -	visit = scc_visit_lookup(env, &callchain);
> +	visit = scc_visit_lookup(env, callchain);
>  	if (!visit) {
>  		verifier_bug(env, "add backedge: no visit info for call chain %s",
> -			     format_callchain(env, &callchain));
> +			     format_callchain(env, callchain));
>  		return -EFAULT;
>  	}
>  	if (env->log.level & BPF_LOG_LEVEL2)
> -		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
> +		verbose(env, "SCC backedge %s\n", format_callchain(env, callchain));
>  	backedge->next = visit->backedges;
>  	visit->backedges = backedge;
>  	visit->num_backedges++;
> @@ -1998,12 +1998,12 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
>  static bool incomplete_read_marks(struct bpf_verifier_env *env,
>  				  struct bpf_verifier_state *st)
>  {
> -	struct bpf_scc_callchain callchain;
> +	struct bpf_scc_callchain *callchain = &env->callchain;
>  	struct bpf_scc_visit *visit;
>  
> -	if (!compute_scc_callchain(env, st, &callchain))
> +	if (!compute_scc_callchain(env, st, callchain))
>  		return false;
> -	visit = scc_visit_lookup(env, &callchain);
> +	visit = scc_visit_lookup(env, callchain);
>  	if (!visit)
>  		return false;
>  	return !!visit->backedges;
> -- 
> 2.47.1
> 
> 

