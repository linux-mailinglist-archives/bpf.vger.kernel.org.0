Return-Path: <bpf+bounces-16273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744967FF1C6
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E98B21173
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6B51007;
	Thu, 30 Nov 2023 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk5NmryD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF09196
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:30:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1882023bbfso106340466b.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701354642; x=1701959442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ3gYuyG5+qFHADxH3OvPVX9Z9TRazFjK7ZC+iOtuTM=;
        b=Lk5NmryDh+LGU/mNYSXRIDVJr+Ez81eWeOU5ULrLZ/qmM8sVHBTVyZFp8mpT1N9iIB
         x/XRTCWXKK2gN+S2V3/+lNnYjzzWXrdJLdVnmoA8QQZ1nS4393HAcoW+2mKevo8wqlrO
         yFw+6sVB64C8eQiY0PcPSgMOgy0FyxMuFPlSZhVKPrjdEhwTo8HNWPbyDvtFj2KMdyV9
         iq8qhsLA3huRCQ/nSnbhpyk7WYaXlDpeJiqR0lrcDbagbWoNV1fcYJ7VTaF34bVF4ykI
         CqYibiIuJ2T+s7tDhMNA44TmNViL6VYPsaPNvoJ/pgfvMY2KoUHDctwWQ1gSUs/agTsk
         LdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354642; x=1701959442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ3gYuyG5+qFHADxH3OvPVX9Z9TRazFjK7ZC+iOtuTM=;
        b=gkSMoi8T1zOmwNFT6y5G0OfeG+MpmFrkfa210EnEeeoyBPiNM7H2JeptDMFg32nhyp
         5k0+IQ85FjPp4qlls6KaWuGfXlUt4lVAWLMlr2RVEUVORXYIaFdHgYE9rEFECM9ciXtI
         pcnRmgsWvs8JBS7pgmyXMoiN39PrKbYkf16zQuzO0atDAQIe/E+uBOuVcLj9bX0e0zjU
         ApBI1E2ibe2mpJc93rWFzktn1HGPkrFiRsGj80ppa1k+RNQsQNgl6VdgqTa1ZPpPTlqg
         G5xDhBxgXdSGrR/F92KxLbya6JMvt8wyWmy7frpVPFE1cxR+T8cnh+HjvwjSsL9678ry
         gicA==
X-Gm-Message-State: AOJu0Yx3eMiKm/v3pougnCme8xB+q3OCbK0Uk5SR7Hm97mZLX1KXBm1E
	ccUeTQkvIgQcIWWiZe44eh4=
X-Google-Smtp-Source: AGHT+IGb0mIeqBTyuwwtriswF/qTjq5P8BcrN0q68EVuIhq7to8/JCwUhrG1+3RB3JmLtzVmEcPrFQ==
X-Received: by 2002:a17:906:5b:b0:a01:a299:fa3 with SMTP id 27-20020a170906005b00b00a01a2990fa3mr15868572ejg.8.1701354642034;
        Thu, 30 Nov 2023 06:30:42 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906715500b00a1185ad53c6sm732351ejj.199.2023.11.30.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:30:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Nov 2023 15:30:38 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZWicjpfZlVpC7HhP@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-2-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195240.19091-2-9erthalion6@gmail.com>

On Wed, Nov 29, 2023 at 08:52:36PM +0100, Dmitrii Dolgov wrote:
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
> 
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed. To
> implement, add a new field into bpf_prog_aux to track the number of
> attachments to the target prog.
> 
> As a side effect of this change alone, one could create an unbounded
> chain of tracing progs attached to each other. Similar issues between
> fentry/fexit and extend progs are addressed via forbidding certain
> combinations that could lead to similar chains. Introduce an
> attach_depth field to limit the attachment chain, and display it in
> bpftool.
> 
> Note, that currently, due to various limitations, it's actually not
> possible to form such an attachment cycle the original implementation
> was prohibiting. It seems that the idea was to make this part robust
> even in the view of potential future changes.

SNIP

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e7b6072e3f4..31ffcffb7198 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20109,6 +20109,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	if (tgt_prog) {
>  		struct bpf_prog_aux *aux = tgt_prog->aux;
>  
> +		if (aux->attach_depth >= 32) {
> +			bpf_log(log, "Target program attach depth is %d. Too large\n",
> +					aux->attach_depth);
> +			return -EINVAL;
> +		}

IIUC the use case you have is to be able to attach fentry program on
another fentry program.. do you have use case that needs more than
that?

could we allow just single nesting? that might perhaps endup in easier
code while still allowing your use case?


> +
>  		if (bpf_prog_is_dev_bound(prog->aux) &&
>  		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
>  			bpf_log(log, "Target program bound device mismatch");
> @@ -20147,9 +20153,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Can attach to only JITed progs\n");
>  			return -EINVAL;
>  		}
> -		if (tgt_prog->type == prog->type) {
> -			/* Cannot fentry/fexit another fentry/fexit program.
> -			 * Cannot attach program extension to another extension.
> +		if (tgt_prog->type == prog->type &&
> +			(prog_extension || prog->aux->follower_cnt > 0)) {
> +			/*
> +			 * To avoid potential call chain cycles, prevent attaching programs
> +			 * of the same type. The only exception is standalone fentry/fexit
> +			 * programs that themselves are not attachment targets.
> +			 * That means:
> +			 *  - Cannot attach followed fentry/fexit to another
> +			 *    fentry/fexit program.
> +			 *  - Cannot attach program extension to another extension.
>  			 * It's ok to attach fentry/fexit to extension program.

next condition below denies extension on fentry/fexit and the reason
is the possibility:
  "... to create long call chain * fentry->extension->fentry->extension
  beyond reasonable stack size ..."

that might be problem also here with 32 allowed nesting

also the the comment mentions that it's not possible to attach fentry/fexit
on themselfs, so it should be updated

jirka

>  			 */
>  			bpf_log(log, "Cannot recursively attach\n");
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index feb8e305804f..83f999f5505d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -558,6 +558,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd, bool orphaned)
>  	if (orphaned)
>  		printf("  orphaned");
>  
> +	if (info->attach_depth)
> +		printf("  attach depth %d", info->attach_depth);
> +
>  	if (info->nr_map_ids)
>  		show_prog_maps(fd, info->nr_map_ids);
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index e88746ba7d21..9cf45ad914f1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6468,6 +6468,7 @@ struct bpf_prog_info {
>  	__u32 verified_insns;
>  	__u32 attach_btf_obj_id;
>  	__u32 attach_btf_id;
> +	__u32 attach_depth;
>  } __attribute__((aligned(8)));
>  
>  struct bpf_map_info {
> -- 
> 2.41.0
> 

