Return-Path: <bpf+bounces-13651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85E7DC430
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB467B20F8C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76936EDA;
	Tue, 31 Oct 2023 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0GBy72n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AC10FD
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:12:08 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02274E4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:12:04 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so3576563fac.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698718323; x=1699323123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmTnp//JgOMX5WoiQzVvA+FD2Qlm47vRj5Cl4/bPCZA=;
        b=U0GBy72n7aVk2gW5q5hgOnfIoBMxyg2lrWr2Et39pt7rsciljtzyIkRdLHXTyBX5Va
         ZW/0F7S7DDI02YrLU4gFdeBOT047mzSICuwgPNcPa2WXtjBTt76jdfb/0b87AVffMpFg
         /BY8LpzEM4SZX14m2EvcHXn6SZPI1GWP70eqGOJBk3kydv49XXJe6cGrHSiNT/8uaNr/
         hj6bMz7/LOrusJR6lMqI9ur42qbt9M5yR89rZnOV9FtQnIKH5m0PQQKSIO42OfVNQmI1
         /JqHVSUHZMpFNvd9lpJRFxGlFXt8zZXBWSQOpTXakAbBLn9vi+1k0xvM90Hsa0dd+IPe
         K3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698718323; x=1699323123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmTnp//JgOMX5WoiQzVvA+FD2Qlm47vRj5Cl4/bPCZA=;
        b=D9RXE2DuRXZcvjzQoeVad69lgsQmDyu5HCj1f03n+DQnwbkVg870fIk0Jmwrm5XGHE
         dqMJwo3z/kPpQpojpG8k6o6Qn34i0Huxa9DxGKEMLuIb6/dV+XBd7DSKQkbuRF3SpMnH
         E4BzEC4eFH9V533U8GJVK9xrYTAYDtWNMvV1LsoH9QX5xXumhDHRMSwqq/qPfCfAYHYI
         NagebKLYU1/83khmp5U1QoWWNguAZicQKRZgqJFK+dl+5ShfMQfEdz1u8P8dzCV5Lyb/
         /rFrCKHXHpEBG75S72xFb8M7GrRygov1MM+BFb8dIqAAn/yH5h2h8OuCQdLBUmPV03+j
         CCZg==
X-Gm-Message-State: AOJu0YzRpRM8DQ0k8nc1OvCcTEVGQ61GWH/13GcGx4347omoctsY7/at
	fJTx6nb/dbAw/4pVa2pZCao=
X-Google-Smtp-Source: AGHT+IHLF4g8F9Milbsvp3t6Iykndieg3PqBeatyahC5ok8oRupv1DkKqPXUQuLadQKmPgufE9tjRA==
X-Received: by 2002:a05:6870:1390:b0:1ef:c944:222b with SMTP id 16-20020a056870139000b001efc944222bmr5543897oas.11.1698718323071;
        Mon, 30 Oct 2023 19:12:03 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:e78a])
        by smtp.gmail.com with ESMTPSA id t12-20020a63b70c000000b0057ab7d42a4dsm115740pgf.86.2023.10.30.19.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:12:02 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:12:00 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 19/23] bpf: generalize
 is_scalar_branch_taken() logic
Message-ID: <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231027181346.4019398-20-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-20-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:42AM -0700, Andrii Nakryiko wrote:
> Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> cases when both registers are not constants. Previously supported
> <range> vs <scalar> cases are a natural subset of more generic <range>
> vs <range> set of cases.
> 
> Generalized logic relies on straightforward segment intersection checks.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4c974296127b..f18a8247e5e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
>  				  u8 opcode, bool is_jmp32)
>  {
>  	struct tnum t1 = is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_off;
> +	struct tnum t2 = is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_off;
>  	u64 umin1 = is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
>  	u64 umax1 = is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
>  	s64 smin1 = is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
>  	s64 smax1 = is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
> -	u64 val = is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : reg2->var_off.value;
> -	s64 sval = is_jmp32 ? (s32)val : (s64)val;
> +	u64 umin2 = is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_value;
> +	u64 umax2 = is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_value;
> +	s64 smin2 = is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
> +	s64 smax2 = is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
>  
>  	switch (opcode) {
>  	case BPF_JEQ:
> -		if (tnum_is_const(t1))
> -			return !!tnum_equals_const(t1, val);
> -		else if (val < umin1 || val > umax1)
> +		/* const tnums */
> +		if (tnum_is_const(t1) && tnum_is_const(t2))
> +			return t1.value == t2.value;
> +		/* const ranges */
> +		if (umin1 == umax1 && umin2 == umax2)
> +			return umin1 == umin2;

I don't follow this logic.
umin1 == umax1 means that it's a single constant and
it should have been handled by earlier tnum_is_const check.

> +		if (smin1 == smax1 && smin2 == smax2)
> +			return umin1 == umin2;

here it's even more confusing. smin == smax -> singel const,
but then compare umin1 with umin2 ?!

> +		/* non-overlapping ranges */
> +		if (umin1 > umax2 || umax1 < umin2)
>  			return 0;
> -		else if (sval < smin1 || sval > smax1)
> +		if (smin1 > smax2 || smax1 < smin2)
>  			return 0;

this part makes sense.

