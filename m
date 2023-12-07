Return-Path: <bpf+bounces-16998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A401808525
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 11:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E294CB21DB1
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288035295;
	Thu,  7 Dec 2023 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boXGdDgC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA0126
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 02:07:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso1012151a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701943661; x=1702548461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAkRYgxq4dfpJF2gBv5sdr5mOutfojJy1scYEDIYGqw=;
        b=boXGdDgCLmqxh3SW86+hRuE5zy6zo3NK6SzxQ3p6+RTYPCveMc49iQnObo81a38lDm
         Rqtoq+hHLbKk3ZQw/WjkvvcEPf3O7s42l8Bj5IJjTMbkjtRfOXONVds9DlygnhhGIbDv
         5AEZgOFeaZOUcG+mI2ek5vGkURSDi5Wq7omp0/q9noYl+PI8dIttUTceoYsyLcn5ytNN
         CI1y9lx2hcUkXWCIBY9owtOc3mPXhwoj0Ji/OBcDG/ZpRuw6uHKT20RQboYG4cEjiYDu
         kS6GYKayGNBZHZN0bIWTHG5WtpfPOaOCoVuVqgHTfBPUWqussMi5+Z+mfKtZ/0kt+gg0
         Zj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943661; x=1702548461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAkRYgxq4dfpJF2gBv5sdr5mOutfojJy1scYEDIYGqw=;
        b=hfkz8CsikJ0m80VFvSFVs4cILBmulPgIysjGd0kiibunItUnBL+6fwbTA5enjMsq/I
         2lbWwlcIa8Z33HqGV8i2VivUhczSPdUVSyy1WEDiC04uCNUoVj0/ES2TJ3wBmCukWW7w
         sWMCuimCUQPzg/G41oOEuEKxG+F5IxuQrCFu910sXLrxc4q79sU8Ov+FmtWK1ElykSeF
         XKO3He0fcTXN2tbQ8E516BQgBMwhZWSOZBODGtsf4E6IRhrFkxw41QfXU9cDcnYT/gH6
         aKDTy45LDdmnAHRSHd9lV/pTyJBXUWLQ56/O/VaNIJyw3CpQsmRSB/rxealrfMu+Iu8p
         S0JQ==
X-Gm-Message-State: AOJu0YzeweqncGHbKtsE6pgC8k/RcL1QhRwBer77t/MNWh1cO2BPRMjH
	8sEri06k7e2PXejsT57PeMI=
X-Google-Smtp-Source: AGHT+IHIH84SiR77SEEY2VrbrVSWrKxktuLJDDmUA3MwhZap9QSOszoVspT1ZTJrRuV9sgFa0knfYg==
X-Received: by 2002:a17:906:15b:b0:a1e:7683:4da5 with SMTP id 27-20020a170906015b00b00a1e76834da5mr586584ejh.3.1701943661084;
        Thu, 07 Dec 2023 02:07:41 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b00a1da2c9b06asm618093ejz.42.2023.12.07.02.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:07:40 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Dec 2023 11:07:38 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZXGZaonxi9hLWEIJ@krava>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
 <20231202191556.30997-2-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202191556.30997-2-9erthalion6@gmail.com>

On Sat, Dec 02, 2023 at 08:15:47PM +0100, Dmitrii Dolgov wrote:
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
> add a new field into bpf_prog_aux to track the depth of attachment.
> 
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Previous discussion: https://lore.kernel.org/bpf/20231201154734.8545-1-9erthalion6@gmail.com/
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
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 12 ++++++++++++
>  kernel/bpf/verifier.c          | 33 +++++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h |  1 +
>  5 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb447b0a9423..1588e48fe31c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1400,6 +1400,7 @@ struct bpf_prog_aux {
>  	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
>  	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
>  	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
> +	u32 attach_depth; /* for tracing prog, level of attachment nesting */
>  	u32 ctx_arg_info_size;
>  	u32 max_rdonly_access;
>  	u32 max_rdwr_access;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e88746ba7d21..9cf45ad914f1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6468,6 +6468,7 @@ struct bpf_prog_info {
>  	__u32 verified_insns;
>  	__u32 attach_btf_obj_id;
>  	__u32 attach_btf_id;
> +	__u32 attach_depth;
>  } __attribute__((aligned(8)));
>  
>  struct bpf_map_info {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e43ddd1b83f..9c56b5970d7e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3039,6 +3039,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>  
>  	bpf_trampoline_put(tr_link->trampoline);
>  
> +	link->prog->aux->attach_depth = 0;
>  	/* tgt_prog is NULL if target is a kernel function */
>  	if (tr_link->tgt_prog)
>  		bpf_prog_put(tr_link->tgt_prog);
> @@ -3243,6 +3244,16 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  		goto out_unlock;
>  	}
>  
> +	if (tgt_prog) {
> +		/* Bookkeeping for managing the prog attachment chain. If it's a
> +		 * tracing program, bump the level, otherwise carry it on.
> +		 */
> +		if (prog->type == BPF_PROG_TYPE_TRACING)
> +			prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
> +		else
> +			prog->aux->attach_depth = tgt_prog->aux->attach_depth;
> +	}

I'm not sure why we need to keep the attach_depth for all program types,
I might be missing something but could we perhaps just use flag related
just to tracing programs like in patch below

jirka


---
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 10e5e4d8a00f..2387a29db193 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1425,6 +1425,7 @@ struct bpf_prog_aux {
 	bool dev_bound; /* Program is bound to the netdev. */
 	bool offload_requested; /* Program is bound and offloaded to the netdev. */
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
+	bool attach_tracing_prog; /* true if attaching to tracing prog */
 	bool func_proto_unreliable;
 	bool sleepable;
 	bool tail_call_reachable;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 991e7e73ff3c..a3d309197bc0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3277,6 +3277,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_unlock;
 	}
 
+	if (tgt_prog && prog->type == BPF_PROG_TYPE_TRACING)
+		prog->aux->attach_tracing_prog = true;
+
 	link->tgt_prog = tgt_prog;
 	link->trampoline = tr;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5ce530641ba..899e3b34c058 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20235,8 +20235,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Can attach to only JITed progs\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == prog->type) {
-			/* Cannot fentry/fexit another fentry/fexit program.
+		if (prog->type == BPF_PROG_TYPE_TRACING) {
+			if (aux->attach_tracing_prog) {
+				bpf_log(log, "Cannot nest tracing program attach more than once\n");
+				return -EINVAL;
+			}
+		} else if (tgt_prog->type == prog->type) {
+			/*
 			 * Cannot attach program extension to another extension.
 			 * It's ok to attach fentry/fexit to extension program.
 			 */

