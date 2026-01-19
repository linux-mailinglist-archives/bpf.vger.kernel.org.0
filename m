Return-Path: <bpf+bounces-79521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0CBD3BBD7
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 00:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01152304157B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A262F6168;
	Mon, 19 Jan 2026 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5DMl1E0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CE2DB7AF
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865858; cv=none; b=Wg92HhzLUeS8FUkvzQTBQWZZwutXZDjAgFfTnnSAV+VRVCh+l1y1JSgn1JUawQ2VkONXB/T99YtBMuT12T+NokjW/tOPrFVvhSPYBaV+hwTeoQxSa90n8cL0xEDBwJbeKqgrIpCUdrvHQzgsTYe9S2zBboFerYNumZufInTR4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865858; c=relaxed/simple;
	bh=aDfnM7i9GGpQDHaGMBkiIsynJa7STOxJiG3hr1rIu1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tow/5AhRTrIPNdbz46RDVFDDk53WJF2VOVVZLCFOZcc7vZFbZS1gtiM8cGZZIGojLS39PxhApoebLFswGrzN/w1vbcTIqV7TKT9F4P1Ggxz0HM+SUpaYVrdRd9lswC3slG+kbkG74pnPnYBpAanM6A5wXTTU5bRtAnOEysV6QtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5DMl1E0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2886461f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768865855; x=1769470655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JfOnVqkCeNateHhFiNeNhXc5NJwePi9FKodOPEv0No=;
        b=Z5DMl1E08+VNpnLOt3VF/wp6VswTXOu5UPnjlsugmANXWk4rLdDmGwYuqxUcQyXljx
         94Vfyto/XIfZ+ivUu3TGcDltzD/yUJELkTbsh9LpcnCNo43W7u7qLgdcnd8CRKv34JaA
         /xw/ZNw4BOkXGRpNbmPfRa1cA2qqEVm1Jmgw8gFcW3YEbUX6L1PDPiNME0c4tDjH/UGQ
         oV3IZbS1A8e8FF5fipkE3+08f8oTIJSw2OP9tSrgd4MWn335h4m7yo6MPH40K2EFp2Hf
         D8TCk/KetpLdnxE5hK7a1YXtkVs15fnvmLwLyGxjhqOerDYe50o58lXDv3G0vBHEzyz9
         LdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865855; x=1769470655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JfOnVqkCeNateHhFiNeNhXc5NJwePi9FKodOPEv0No=;
        b=pxBOerFJLkIJCYMa4G/MfiIxV+8m0A+8EFBvR6ArOmq0v+7armgoPx9ak3C3AiIg+f
         QNrckPvozWDvfzytUXfr8xBScnQoFi0KNFGxOKklzcynzJrU2vvTxhEwP9dG8qlVrXrn
         rOJY+0FtjDa53otGHnrTPiAZRp1aqQ7jUo5WFc9SFKAXC5vCeVarE06uL6VLMvLeYFOc
         rQm98YNzWhCfyZMHJUu4/3gZIVhj/scDsrJ4NRVq5CcFnEpks9++RWIqBCE/icsIVu0W
         BgImLkPm1M6zq2kt6LQAz/TLfN7oFlg58oyptcPwuV4iKF/I+VNxjSXHDvzCLKygICy0
         T3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVEsmCmPsgSxewNX5phMhXwcxuHi4qgUp5UNgqo4WMiOh3JPUBSnfOEFW6cBZGnjvN/Zgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wN8U6gIzE0UZMbWYeo9RI6xGhTSJNIVmaG9tVA06bGDl5ASz
	VuQ52L9jtZWJLgUNd6qSJnmXVOLiuUCv6beUn64STFbcCAeTFoHK+Yan
X-Gm-Gg: AZuq6aIuY8q1Z4M6EiNcpFTuXkaUXXhrxjBNzVnGKJewXb528b+XTrxjfb9sCIr14H/
	ihRpKNEqtz10A/tWGt/12c43MVAXMLrAp+4B/dDxMwDVv/CbVp1RipTjhEoSgX+c6aV/vrBPVLo
	8xXp1uudB5xySo14GmBi1aCjDrVE+xKxu8qeA0mnBdc9Muq6QNos6IKwuVCarADjPQqsmzzpIHI
	TIiOTzcO/SuIy2iGxIkGT1UWL9vsNXBQEFSP5xgg8QSYe0OQXdkcDIswhuS32W97bfQa03G8TX8
	ihdX4aDJRhPbGPwQ97qY+7arDzL0ENsQ5uwHAV8Q3GSnhcLOhmMffh4EAsAHn4G5QzC1fWY9dxL
	xRjUoPHCRStMhjfMMnOgPLUrjxBYuapT8m3CRGkq/wwYms3WbDBLKCGJ97RHjQaDYsvrrQmesNl
	4LehPB1tLFIw==
X-Received: by 2002:a05:6000:2903:b0:432:c05b:d8c7 with SMTP id ffacd0b85a97d-43569bc7761mr15761095f8f.49.1768865855030;
        Mon, 19 Jan 2026 15:37:35 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm25306953f8f.19.2026.01.19.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 15:37:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Jan 2026 00:37:32 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Message-ID: <aW7APKlKCgg2_YvW@krava>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
 <20260119023732.130642-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119023732.130642-2-dongml2@chinatelecom.cn>

On Mon, Jan 19, 2026 at 10:37:31AM +0800, Menglong Dong wrote:
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
> 
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - remove unnecessary NULL checking for prog->aux->attach_func_proto
> 
> v2:
> - for nr_args, skip first 'void *__data' argument in btf_trace_##name
>   typedef
> ---
>  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |  4 ++--
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..4f52342573f0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg) {
> -			/* Load nr_args from ctx - 8 */
> -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> +
> +				/*
> +				 * skip first 'void *__data' argument in btf_trace_##name
> +				 * typedef
> +				 */
> +				nr_args--;
> +				/* Save nr_args to reg0 */
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}
>  			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
>  			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
>  			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> @@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement get_func_arg_cnt inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> -			/* Load nr_args from ctx - 8 */
> -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> +
> +				/*
> +				 * skip first 'void *__data' argument in btf_trace_##name
> +				 * typedef
> +				 */
> +				nr_args--;
> +				/* Save nr_args to reg0 */

I think we can attach single bpf program to multiple rawtp tracepoints,
in which case this would not work properly for such program links on
tracepoints with different nr_args, right?

jirka


> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}
>  
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
>  			if (!new_prog)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..9b1b56851d26 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_d_path:
>  		return &bpf_d_path_proto;
>  	case BPF_FUNC_get_func_arg:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> +		return &bpf_get_func_arg_proto;
>  	case BPF_FUNC_get_func_ret:
>  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
>  	case BPF_FUNC_get_func_arg_cnt:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> +		return &bpf_get_func_arg_cnt_proto;
>  	case BPF_FUNC_get_attach_cookie:
>  		if (prog->type == BPF_PROG_TYPE_TRACING &&
>  		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> -- 
> 2.52.0
> 

