Return-Path: <bpf+bounces-18002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE79814AF0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14C41C2386C
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D52339AE;
	Fri, 15 Dec 2023 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrnUJLTb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822932F85A
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso8591795e9.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702651698; x=1703256498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ubTOYZyF+LE25OKhC51v0ERkmrIv+3fTGU4sNakkOA=;
        b=SrnUJLTbdAgonWrlKIOZlOvOxMkq6U2wFmVSMdaIR9UWi/36B0VzSotcs8nn9/RNAq
         31V6K0Q6B7ONdiSJxdU6RGNQCGzQIjf5m8ROBi1kH07qJIuN6sfOQWUdnIKz9IMf3MTv
         cdUItNw19m1axdb/0oPCJgQ4qUdAM4c5DXyKXU1X0tXkMZ0v4a2sM3SzAZdZ8MwUTC12
         FqrgGKLiRFE4B+QHvWDXpGoBQ4h7FwRtOkZ3gPtVJp0s85An2JXt1UoSWUQ4tVjkP7Wc
         iOiyUcock1pS/WWXB1XhsnsvP7kKaWfm3Pz+90Sl6Y7IJi57T9VeCjHsE62+Re0km7pY
         z5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651698; x=1703256498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ubTOYZyF+LE25OKhC51v0ERkmrIv+3fTGU4sNakkOA=;
        b=q46sIcx+zxSPNXhSM3nnQfMRc/dYpvpkibhe+NcECNMx0zwj2GykndlapvRfw7C7Un
         dyiEFJxxWKmUwjJyVZ9kGo6CmXtxCd3ZqLMM+O+bdeTCgSHGGiVz6bJzIipmtNFmIdkK
         O6E3ko0yZxeHitkpKrx0W2o99AZtT7/hO3fDZLbR2NtZ/h8/CVVP3HmzZ6R/mRYahSyT
         Hu9vy55gW9KrkpZZd3tzCOzExje5yQiVKpRDpN8y8ggxQVxTUAKz2gZ5Yuo056bUyfVd
         pJKzN3Y7i7Aav8W9b8gUbBX1FA08kh2mCxldSV/7j9FQ1Yp32XE3dj/eyqYLvcgfX0jv
         K+rQ==
X-Gm-Message-State: AOJu0Yy1bZq/maz2iaxO6sihH77daQgMy14r5P4x+Wa6xmxtv1+GZt8F
	eFbNYhTfSd1br/m05r462cY=
X-Google-Smtp-Source: AGHT+IEGU0xEnhUBzu4gMVpY5mel9Z6T3dOTI6lAPGA8Gv8zjjzkkXA3C5EQ17TLlHpUb24IQKwVAw==
X-Received: by 2002:a05:600c:1f08:b0:40c:3e98:5309 with SMTP id bd8-20020a05600c1f0800b0040c3e985309mr6100768wmb.98.1702651697556;
        Fri, 15 Dec 2023 06:48:17 -0800 (PST)
Received: from krava ([83.240.61.143])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm29182447wmq.18.2023.12.15.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:48:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 15:48:15 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v8 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZXxnLzhAFxwepM_7@krava>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
 <20231212195413.23942-2-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212195413.23942-2-9erthalion6@gmail.com>

On Tue, Dec 12, 2023 at 08:54:06PM +0100, Dmitrii Dolgov wrote:
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
> 
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Previous discussion: https://lore.kernel.org/bpf/20231208185557.8477-1-9erthalion6@gmail.com/
> 
> Changes in v8:
>     - Move bookkeping in bpf_tracing_link_release under the tgt_prog
>       condition.
>     - Fix some indentation issues.
> 
> Changes in v7:
>     - Replace attach_depth with a boolean flag to indicate a program is
>       already tracing an fentry/fexit.
> 
> Changes in v6:
>     - Apply nesting level limitation only to tracing programs, otherwise
>       it's possible to apply it in "fentry->extension" case and break it
> 
> Changes in v5:
>     - Remove follower_cnt and drop unreachable cycle prevention condition
>     - Allow only one level of attachment nesting
>     - Do not display attach_depth in bpftool, as it doesn't make sense
>       anymore
> 
> Changes in v3:
>     - Fix incorrect decreasing of attach_depth, setting to 0 instead
>     - Place bookkeeping later, to not miss a cleanup if needed
>     - Display attach_depth in bpftool only if the value is not 0
> 
> Changes in v2:
>     - Verify tgt_prog is not null
>     - Replace boolean followed with number of followers, to handle
>       multiple progs attaching/detaching
> 
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/syscall.c  | 10 +++++++++-
>  kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++--------------
>  3 files changed, 35 insertions(+), 15 deletions(-)
> 
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
> index 5e43ddd1b83f..af51e97c2c28 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>  	bpf_trampoline_put(tr_link->trampoline);
>  
>  	/* tgt_prog is NULL if target is a kernel function */
> -	if (tr_link->tgt_prog)
> +	if (tr_link->tgt_prog) {
>  		bpf_prog_put(tr_link->tgt_prog);
> +		link->prog->aux->attach_tracing_prog = false;
> +	}
>  }
>  
>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		goto out_unlock;
>  	}
>  
> +	/* Bookkeeping for managing the prog attachment chain */
> +	if (tgt_prog &&
> +		prog->type == BPF_PROG_TYPE_TRACING &&
> +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> +			prog->aux->attach_tracing_prog = true;

hi,
this still looks bad, I think it should be:

+	if (tgt_prog &&
+	    prog->type == BPF_PROG_TYPE_TRACING &&
+	    tgt_prog->type == BPF_PROG_TYPE_TRACING)
+		prog->aux->attach_tracing_prog = true;

other than that the patchset looks good to me

thanks,
jirka


> +
>  	link->tgt_prog = tgt_prog;
>  	link->trampoline = tr;
>  
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

