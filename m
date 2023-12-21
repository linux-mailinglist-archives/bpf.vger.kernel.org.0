Return-Path: <bpf+bounces-18552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C781BDE0
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 19:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E461C216E2
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731364ABB;
	Thu, 21 Dec 2023 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOqBdDrz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A493634EE
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3366e78d872so953834f8f.3
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703181733; x=1703786533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOBgNh4oHntmRaMAdNdxxX343EN4oLhRYEPnrEBTRRA=;
        b=ZOqBdDrzxlgvLgU0Ykb65j2xHQb1DIs+f7ciCV1Uua0AfW1Glu38x/Ytc7MMtUb7PC
         sxDliDfrcC7U/W+Jj894mz901KT1JwoLXT4wMJh5j4NV4JWT/EjQli9eufN9JChay9oq
         63ECaD6FrbBFxd6Z35dg1GGU2li5M6Qitdc15Mo12WC+IeKKtkltmTFfOLsocJtNOSto
         /2xInhUrxencP8/UCRPCiuJoJnO382KrmO9iXCn76ch6HuKukF7yaQdN1jaf9s984rhm
         EAqhmtRg0f1sXOyFPWoR83BBNZD+zZX0FrbEo7iUcRaPOv0ssemU1ThBCL7jbNzZhAx9
         LSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181733; x=1703786533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOBgNh4oHntmRaMAdNdxxX343EN4oLhRYEPnrEBTRRA=;
        b=XHbImXYwA2SV03zlg6T0PHhg97bx2YTrek7elkTsGa0P8wOc2AwHJ5jDeH76AkWm7V
         cM5idgVIDcECNhcuM4IKd6DMVZR1x9CYnw3h53/Mch0+Kj8D1S6nDQ7v61WxZ3CyYiJQ
         YVclkD4k/NsSla6cAO+9H79gR8ITVX+k8Na5gXyWterCuFrHMI3FM+SqnrmR+h0oTrj2
         lvgjp5/YOHG+fLdgrcFJKDSJ4o4Ds4CBRNQsi398UVFDZF7z3B1R0lHoKze+OzE6ZhqU
         4yaRJ5ejiRwBsx7O888IgkNrUPAaTM6hngJfZgdVMKMHL8lgdh10gITqSg+MYCOLGwF5
         joLA==
X-Gm-Message-State: AOJu0YzVCLzXoer5hjslB0/GPrCrqgkqNVE/Yws5ikQ4CLI5mjm8YwZu
	APL2B14/idLEZphDJPQiHD4=
X-Google-Smtp-Source: AGHT+IF1VgNkqGmUTnfP5mCbBdvdK16eMxXdhH9RXbwU5OVzUsVvHeiLu67kKyDsc6yAf08xX13npg==
X-Received: by 2002:a05:600c:4e90:b0:40b:5e22:2e8 with SMTP id f16-20020a05600c4e9000b0040b5e2202e8mr36930wmq.84.1703181732732;
        Thu, 21 Dec 2023 10:02:12 -0800 (PST)
Received: from krava (cst-prg-70-88.cust.vodafone.cz. [46.135.70.88])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b0040b37f1079dsm11921987wmq.29.2023.12.21.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:02:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 19:02:02 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v10 1/4] bpf: Relax tracing prog recursive
 attach rules
Message-ID: <ZYR9mrvFargzFlQp@krava>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
 <20231220180422.8375-2-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220180422.8375-2-9erthalion6@gmail.com>

On Wed, Dec 20, 2023 at 07:04:16PM +0100, Dmitrii Dolgov wrote:
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one fentry/fexit. At the same time it's not uncommon to see a tracing
> program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
> 
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. But currently it seems impossible to load and attach tracing
> programs in a way that will form such a cycle. The limitation is coming
> from the fact that attach_prog_fd is specified at the prog load (thus
> making it impossible to attach to a program loaded after it in this
> way), as well as tracing progs not implementing link_detach.
> 
> Replace "no same type" requirement with verification that no more than
> one level of attachment nesting is allowed. In this way only one
> fentry/fexit program could be attached to another fentry/fexit to cover
> profiling use case, and still no cycle could be formed. To implement,
> add a new field into bpf_prog_aux to track nested attachment for tracing
> programs.

SNIP

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb447b0a9423..e7393674ab94 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>  	bool dev_bound; /* Program is bound to the netdev. */
>  	bool offload_requested; /* Program is bound and offloaded to the netdev. */
>  	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
> +	bool attach_tracing_prog; /* true if tracing another tracing program */
>  	bool func_proto_unreliable;
>  	bool sleepable;
>  	bool tail_call_reachable;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e43ddd1b83f..c40cad8886e9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2702,6 +2702,22 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  			goto free_prog_sec;
>  	}
>  
> +	/*
> +	 * Bookkeeping for managing the program attachment chain.
> +	 *
> +	 * It might be tempting to set attach_tracing_prog flag at the attachment
> +	 * time, but this will not prevent from loading bunch of tracing prog
> +	 * first, then attach them one to another.

hi,
sorry for delayed response..  this part gets trickier with every change :-)

> +	 *
> +	 * The flag attach_tracing_prog is set for the whole program lifecycle, and
> +	 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
> +	 * programs cannot change attachment target.

I'm not sure that's the case.. AFAICS the bpf_tracing_prog_attach can
be called on already loaded program with different target program it
was loaded for, like:

  load fentry1   -> bpf_test_fentry1

  load fentry2   -> fentry1
    fentry2->attach_tracing_prog = true

  load ext1      -> prog

  attach fentry2 -> ext1

in which case we drop the tgt_prog from loading time
and attach fentry2 to ext1

but I think we could just fix with resseting the attach_tracing_prog
in bpf_tracing_prog_attach when the tgt_prog switch happens

it'd be great to have test for that.. also to find out it's real case,
I'm not sure I haven't overlooked anything

jirka

> +	 */
> +	if (type == BPF_PROG_TYPE_TRACING && dst_prog &&
> +	    dst_prog->type == BPF_PROG_TYPE_TRACING) {
> +		prog->aux->attach_tracing_prog = true;
> +	}
> +
>  	/* find program type: socket_filter vs tracing_filter */
>  	err = find_prog_type(type, prog);
>  	if (err < 0)
> @@ -3135,7 +3151,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	}
>  
>  	if (tgt_prog_fd) {
> -		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
> +		/*
> +		 * For now we only allow new targets for BPF_PROG_TYPE_EXT. If this
> +		 * part would be changed to implement the same for
> +		 * BPF_PROG_TYPE_TRACING, do not forget to update the way how
> +		 * attach_tracing_prog flag is set.
> +		 */
>  		if (prog->type != BPF_PROG_TYPE_EXT) {
>  			err = -EINVAL;
>  			goto out_put_prog;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e7b6072e3f4..f8c15ce8fd05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    struct bpf_attach_target_info *tgt_info)
>  {
>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
> +	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
>  	const char prefix[] = "btf_trace_";
>  	int ret = 0, subprog = -1, i;
>  	const struct btf_type *t;
> @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Can attach to only JITed progs\n");
>  			return -EINVAL;
>  		}
> -		if (tgt_prog->type == prog->type) {
> -			/* Cannot fentry/fexit another fentry/fexit program.
> -			 * Cannot attach program extension to another extension.
> -			 * It's ok to attach fentry/fexit to extension program.
> +		if (prog_tracing) {
> +			if (aux->attach_tracing_prog) {
> +				/*
> +				 * Target program is an fentry/fexit which is already attached
> +				 * to another tracing program. More levels of nesting
> +				 * attachment are not allowed.
> +				 */
> +				bpf_log(log, "Cannot nest tracing program attach more than once\n");
> +				return -EINVAL;
> +			}
> +		} else if (tgt_prog->type == prog->type) {
> +			/*
> +			 * To avoid potential call chain cycles, prevent attaching of a
> +			 * program extension to another extension. It's ok to attach
> +			 * fentry/fexit to extension program.
>  			 */
>  			bpf_log(log, "Cannot recursively attach\n");
>  			return -EINVAL;
> @@ -20163,16 +20175,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			 * except fentry/fexit. The reason is the following.
>  			 * The fentry/fexit programs are used for performance
>  			 * analysis, stats and can be attached to any program
> -			 * type except themselves. When extension program is
> -			 * replacing XDP function it is necessary to allow
> -			 * performance analysis of all functions. Both original
> -			 * XDP program and its program extension. Hence
> -			 * attaching fentry/fexit to BPF_PROG_TYPE_EXT is
> -			 * allowed. If extending of fentry/fexit was allowed it
> -			 * would be possible to create long call chain
> -			 * fentry->extension->fentry->extension beyond
> -			 * reasonable stack size. Hence extending fentry is not
> -			 * allowed.
> +			 * type. When extension program is replacing XDP function
> +			 * it is necessary to allow performance analysis of all
> +			 * functions. Both original XDP program and its program
> +			 * extension. Hence attaching fentry/fexit to
> +			 * BPF_PROG_TYPE_EXT is allowed. If extending of
> +			 * fentry/fexit was allowed it would be possible to create
> +			 * long call chain fentry->extension->fentry->extension
> +			 * beyond reasonable stack size. Hence extending fentry
> +			 * is not allowed.
>  			 */
>  			bpf_log(log, "Cannot extend fentry/fexit\n");
>  			return -EINVAL;
> -- 
> 2.41.0
> 

