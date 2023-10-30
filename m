Return-Path: <bpf+bounces-13635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092107DC0B9
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E34281676
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827B1A717;
	Mon, 30 Oct 2023 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ZPlTTS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B21A711
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:40:02 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F265FFC
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:40:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so3509279a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694800; x=1699299600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTvLEboRKSBjYPFsIPVX1i84k4fzgBTXsciS+AzFRYY=;
        b=E7ZPlTTS9Ndfnph2r+ibobZEBiMdnUL8zffxqjniUyLaws+ue5MTTe3OBjdxiHhw7n
         YFfiPqU3rGaAwN7WTOPghsrRQjdaguWLeKhIwNbkZXFb94MQdq0GyFFiwgP4Oakr8yEu
         HSb8+AASjmD82XOjmFrn1OoONLvd8i7pH1Yh3h+vQRpIyvP1So9/3GHc2GCo7o3Kuha6
         IIBOzngQjxdclOw3m7YMHZQTSjSvR68KbUiBb/2+1RUdzT4syISL4QnZLzh3zC3ZGgHH
         zN9q2AfUSyaSueyU8FFvGyJ57sgux4gGml5WyfWXewHpLVUyRuA1fb/o+ikoMiAQd0B7
         Jo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694800; x=1699299600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTvLEboRKSBjYPFsIPVX1i84k4fzgBTXsciS+AzFRYY=;
        b=grODqvD2vRTE+UEQ6IGQ7923DsIBHM+dea9nyVmA8U6lKZfRCshP+6GQuMOc1nAl6j
         Qogi3WqdFzSExJamkqA/haqayWrr7XF+P1/UPizTDfnqQX5hRsRg1nw2Q94opXpFLxt1
         bk+D8U72CnE0HPWlAMeMhaW9jaaDmO1nbJyotLkmrtA2yt+RWbg1p4dbdDKzveHrCrbl
         lkm81l44aTYsToDfi1wzEg2a3FOAEk7/2KkJDiGceIr6xVVkUB7EWO0ByGdx5rOEAQr2
         58zhybD0WVI7l/aVk8EQ7PyC1fGbVp8Tr0oT1k+L7PRWMWFqsbRMiFxt8VbLN0F61evw
         +4LA==
X-Gm-Message-State: AOJu0Yy08GEGjXUm75n65IZfSZ3Gg68CU7ftj/fPgKFHAN8VjA9pW7jU
	Kqg+giHT7Zil1bJGRtfjxKp2+rjVWSE=
X-Google-Smtp-Source: AGHT+IEKiGpFMrXvSvllOz0p2OCiTzNNVJ8bUAKku/1tT7uqNSr5yEMn7eNWJwzSqE5t3V4sNxn0rQ==
X-Received: by 2002:a05:6300:8003:b0:14d:4ab5:5e34 with SMTP id an3-20020a056300800300b0014d4ab55e34mr8150108pzc.51.1698694800329;
        Mon, 30 Oct 2023 12:40:00 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:500::7:f772])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068fb8e18971sm6198681pfo.130.2023.10.30.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:39:59 -0700 (PDT)
Date: Mon, 30 Oct 2023 12:39:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 11/23] bpf: rename is_branch_taken reg
 arguments to prepare for the second one
Message-ID: <20231030193957.poqagefzsxqfputp@macbook-pro-49.dhcp.thefacebook.com>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231027181346.4019398-12-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-12-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:34AM -0700, Andrii Nakryiko wrote:
> Just taking mundane refactoring bits out into a separate patch. No
> functional changes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 107 +++++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 54 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f5fcb7fb2c67..aa13f32751a1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14169,26 +14169,25 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
>  	}));
>  }
>  
> -static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 opcode)
> +static int is_branch32_taken(struct bpf_reg_state *reg1, u32 val, u8 opcode)
>  {
> -	struct tnum subreg = tnum_subreg(reg->var_off);

Looks like accidental removal that breaks build.

>  	s32 sval = (s32)val;
>  
>  	switch (opcode) {
>  	case BPF_JEQ:
>  		if (tnum_is_const(subreg))
>  			return !!tnum_equals_const(subreg, val);

