Return-Path: <bpf+bounces-7944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AF77EE99
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E337281CAF
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59F390;
	Thu, 17 Aug 2023 01:17:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB211379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:17:47 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78926AB
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:17:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-688787570ccso1432037b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692235066; x=1692839866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FlHbuOGrpzDTPcfD+70ah1KiMmQIC4ESrZrVbe6Ckw=;
        b=BkoKFRR2TjMR4PdS1l/6O0J2qgNMM93JILG9nkKES/oZFkrVUw1tz7VTtvr0M/2oGc
         eTlZr94/TZC8jiAzU2tQOmMbJOUh17gzy4XJNzFr/gNObBiO3UQGOBLKq+9Qu88PKGcn
         FV5841M29P8YPEQEZHcSG8qRYvLn/MlAcy1k9rJgsgt882om+iD15tXs0aMpA64bMdWb
         9cr3tSyt55Hpbd4sEJeOKLqQBVhwEhFzoxIX2SARZfPfqTh7FhI+Yn1ncAnTSQINdAYS
         IlAsDoYZz540piyPZcPjn+3OQUxvG4ra4vpPrfJpo4f95M0jp0+ygUDRfznnV2NKkiBM
         fOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235066; x=1692839866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FlHbuOGrpzDTPcfD+70ah1KiMmQIC4ESrZrVbe6Ckw=;
        b=ZAIvylh5JipLLx/tmheJsBHrfbl6fuL7M1VZPJ86y52nUvMuBE+8zG+Eo/y1Abm9mw
         QEM+PGr4mFc9PGafMoB5f6b4O67n1zRPJ5lKOhOUScM/kSqRt13HOelNClRcVBhurA1D
         bIFFsp+Gsaq21NOMQOehP7CfhecfeDR4nBbSDsAfeTvG0aByD25aGhjttFn4N/REqeQD
         K1PTj7X+NH9AbFn6i/lbHZyHHnDeVC5svSQtW+YH7xTdHQ+sjaGN9d1t+bONViZZuXPN
         GEUY5smxiocEVmi6c5kwZlXIMaHRAE91FCDvZxzXGMyQmpeCFP9XP8LBJJA50fnMArwx
         Yxdg==
X-Gm-Message-State: AOJu0Yz9ThbETCxRfi/rQKjHpoUbvkpTBr7RjfOCEQ3YK46VuKqrmkLO
	k83KvI8ditmqJzpPqeNz5t4=
X-Google-Smtp-Source: AGHT+IFDMCdY/8vbyLPUNPsqwe6V0iVGL2MZSVaf/PWOHZoDtXufTb5MLMMzHGqdy4iTAZokcL14cQ==
X-Received: by 2002:a05:6a00:1407:b0:64f:7a9c:cb15 with SMTP id l7-20020a056a00140700b0064f7a9ccb15mr3560068pfu.11.1692235065777;
        Wed, 16 Aug 2023 18:17:45 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2000])
        by smtp.gmail.com with ESMTPSA id fm22-20020a056a002f9600b00688459a9bdcsm3548500pfb.135.2023.08.16.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:17:45 -0700 (PDT)
Date: Wed, 16 Aug 2023 18:17:42 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sdf@google.com, yonghong.song@linux.dev, sinquersw@gmail.com,
	kuifeng@meta.com
Subject: Re: [RFC bpf-next v3 3/5] bpf: Prevent BPF programs from access the
 buffer pointed by user_optval.
Message-ID: <20230817011742.lgouyc4hx5ayihco@MacBook-Pro-8.local>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-4-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815174712.660956-4-thinker.li@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 10:47:10AM -0700, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Since the buffer pointed by ctx->user_optval is in user space, BPF programs
> in kernel space should not access it directly.  They should use
> bpf_copy_from_user() and bpf_copy_to_user() to move data between user and
> kernel space.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/bpf/cgroup.c   | 16 +++++++++--
>  kernel/bpf/verifier.c | 66 +++++++++++++++++++++----------------------
>  2 files changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b977768a28e5..425094e071ba 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2494,12 +2494,24 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>  	case offsetof(struct bpf_sockopt, optval):
>  		if (size != sizeof(__u64))
>  			return false;
> -		info->reg_type = PTR_TO_PACKET;
> +		if (prog->aux->sleepable)
> +			/* Prohibit access to the memory pointed by optval
> +			 * in sleepable programs.
> +			 */
> +			info->reg_type = PTR_TO_PACKET | MEM_USER;
> +		else
> +			info->reg_type = PTR_TO_PACKET;
>  		break;
>  	case offsetof(struct bpf_sockopt, optval_end):
>  		if (size != sizeof(__u64))
>  			return false;
> -		info->reg_type = PTR_TO_PACKET_END;
> +		if (prog->aux->sleepable)
> +			/* Prohibit access to the memory pointed by
> +			 * optval_end in sleepable programs.
> +			 */
> +			info->reg_type = PTR_TO_PACKET_END | MEM_USER;

This doesn't look correct.
packet memory and user memory are non overlapping address spaces.
There cannot be a packet memory that is also and user memory.

