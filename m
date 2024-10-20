Return-Path: <bpf+bounces-42551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F39A571C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 00:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA79B281F74
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E12168488;
	Sun, 20 Oct 2024 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAfiL/B9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865312119
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461671; cv=none; b=PTy49HAejrh9gxFtOeU7265R/pSeLgjuUzWRTXXXMPonqyXwjR3Qk2BD7bnykFMjQBHhyk5+2QuNx2Sueu/lBR8kOQIgOuiZUvvhIA1sSx2x70/J7NGY86XwKI4Y7z89Td5AQSdDtTS2yQ5nOWdNak0GkXB9sE+lnD1TvBo2f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461671; c=relaxed/simple;
	bh=+fF9p6Q0Ohvnux3/e/iucwZoGU+O+ba3uqVMytulSos=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znuw4LwXEgrF34R3Pg391dCfhH+8M8aiqIrHdU+X8ZQRID7WbnuOpUiFFn8xz50v6c8kU6QRjZyiYjgjWZ3OyJGXiS7CTETSiLtuVgpd1IbCuKNrvhfR9sZyVQxogH3V4Lz2yxBeF5OmRdFYKuf/XqWTUcP8pmWJ9n1uEQqsI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAfiL/B9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso439020566b.3
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729461668; x=1730066468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0AQo2SoFHsh5+EMsA03NVPAfv4lSfV0EXdMhcaTrd8=;
        b=HAfiL/B9qk4oqyTpJjn2LZpWT0nqGmgEv1uBCIS10k0vb2msi+NRNCk9ZikpIcfUd7
         6wxXA1lx3pfUx9KvCrK2+M/WpJaH4auVo+qwTPrnreUmZxe+hl6NwF0QkFTWrG0k4vzA
         RRv0Sv+AhmVh3cCxIK0SiwKasOB9yQ8rlL62/EueAbc+/GuzLgrKVrm6Le23ga+eNmYo
         I6jSCXBi4YGi2DcqvoGy88zn43oWBwRArS7zz4xSYGfck7AVZwZbhFEHPwQ8/kZ5utmT
         7aM0cZwbcZodGE4ngnCh4Xp8lB6hkh5UgE0oJiM5ncc3X75ysjefYcWK1RXWYQnLoy5r
         pbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729461668; x=1730066468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0AQo2SoFHsh5+EMsA03NVPAfv4lSfV0EXdMhcaTrd8=;
        b=v7oKYCGkrYj9C71BPrlHnm/MbCNvivNoHkBc87FTLFNqaergA4drNAqgDxLbxTveJR
         RTAPqRism6Tew5OEtAOyjLPd55f1PlcvUjxMeut5sqzWSfy55siXnmLkmxZi4YkrXRp6
         6hM/6eKDaJ2v5Dj8wY4moOhCXt4kBUkgfDut3+ClHUXIzwMTSj4hihJRqv70j08DUB93
         Uupjwu2Z/FE4UF+NFx48ekBEQO6nsrS7UPrtu5ZwrH1NZEZXYZKWjl1QUnXpduO4Xf0T
         cIOEOFW/oy56Tq72XBtL27lJRwl3QT7eq+Hg0/Rs3RmpXsA6G7evINnaKq8SilFyeK2C
         BLOA==
X-Gm-Message-State: AOJu0YwXnJhQ1QCkgerityKuCmPLwbXnbCi82hx2PgtGk7SuMvrfQu4Z
	70jfnOrV8xjCraqjbvirj95ouRRq5RSA6aF2HhYouNvo3n9IEv1anthFAw==
X-Google-Smtp-Source: AGHT+IG0zSUytKo5vXhS0WLaoQ0j6xXERcj+9oI0pBDTfxp61yYP+mvYR9o5X514PBj7J8Lyt6RX8Q==
X-Received: by 2002:a17:907:7e92:b0:a9a:1094:55de with SMTP id a640c23a62f3a-a9a69969979mr927079666b.13.1729461667625;
        Sun, 20 Oct 2024 15:01:07 -0700 (PDT)
Received: from krava (85-193-35-5.rib.o2.cz. [85.193.35.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6349sm130253966b.21.2024.10.20.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 15:01:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 00:01:04 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v6 4/9] bpf: Mark each subprog with proper
 private stack modes
Message-ID: <ZxV9oMixusfz2YtC@krava>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191405.2106256-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020191405.2106256-1-yonghong.song@linux.dev>

On Sun, Oct 20, 2024 at 12:14:05PM -0700, Yonghong Song wrote:
> Three private stack modes are used to direct jit action:
>   NO_PRIV_STACK:        do not use private stack
>   PRIV_STACK_SUB_PROG:  adjust frame pointer address (similar to normal stack)
>   PRIV_STACK_ROOT_PROG: set the frame pointer
> 
> Note that for subtree root prog (main prog or callback fn), even if the
> bpf_prog stack size is 0, PRIV_STACK_ROOT_PROG mode is still used.
> This is for bpf exception handling. More details can be found in
> subsequent jit support and selftest patches.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  9 +++++++++
>  kernel/bpf/core.c     | 19 +++++++++++++++++++
>  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 376e43fc72b9..27430e9dcfe3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1456,6 +1456,12 @@ struct btf_mod_pair {
>  
>  struct bpf_kfunc_desc_tab;
>  
> +enum bpf_priv_stack_mode {
> +	NO_PRIV_STACK,
> +	PRIV_STACK_SUB_PROG,
> +	PRIV_STACK_ROOT_PROG,
> +};
> +
>  struct bpf_prog_aux {
>  	atomic64_t refcnt;
>  	u32 used_map_cnt;
> @@ -1472,6 +1478,9 @@ struct bpf_prog_aux {
>  	u32 ctx_arg_info_size;
>  	u32 max_rdonly_access;
>  	u32 max_rdwr_access;
> +	enum bpf_priv_stack_mode priv_stack_mode;
> +	u16 subtree_stack_depth; /* Subtree stack depth if PRIV_STACK_ROOT_PROG, 0 otherwise */
> +	void __percpu *priv_stack_ptr;
>  	struct btf *attach_btf;
>  	const struct bpf_ctx_arg_aux *ctx_arg_info;
>  	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 14d9288441f2..aee0055def4f 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1240,6 +1240,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>  		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
>  
>  		bpf_jit_binary_free(hdr);
> +		free_percpu(fp->aux->priv_stack_ptr);

this should be also put to the x86 version of the bpf_jit_free ?

jirka

>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>  	}
>  
> @@ -2421,6 +2422,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  		if (*err)
>  			return fp;
>  
> +		if (fp->aux->priv_stack_eligible) {
> +			if (!fp->aux->stack_depth) {
> +				fp->aux->priv_stack_mode = NO_PRIV_STACK;
> +			} else {
> +				void __percpu *priv_stack_ptr;
> +
> +				fp->aux->priv_stack_mode = PRIV_STACK_ROOT_PROG;
> +				priv_stack_ptr =
> +					__alloc_percpu_gfp(fp->aux->stack_depth, 8, GFP_KERNEL);
> +				if (!priv_stack_ptr) {
> +					*err = -ENOMEM;
> +					return fp;
> +				}
> +				fp->aux->subtree_stack_depth = fp->aux->stack_depth;
> +				fp->aux->priv_stack_ptr = priv_stack_ptr;
> +			}
> +		}
> +
>  		fp = bpf_int_jit_compile(fp);
>  		bpf_prog_jit_attempt_done(fp);
>  		if (!fp->jited && jit_needed) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25283ee6f86f..f770015d6ad1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20018,6 +20018,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_prog *prog = env->prog, **func, *tmp;
>  	int i, j, subprog_start, subprog_end = 0, len, subprog;
> +	int subtree_top_idx, subtree_stack_depth;
> +	void __percpu *priv_stack_ptr;
>  	struct bpf_map *map_ptr;
>  	struct bpf_insn *insn;
>  	void *old_bpf_func;
> @@ -20096,6 +20098,33 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		func[i]->is_func = 1;
>  		func[i]->sleepable = prog->sleepable;
>  		func[i]->aux->func_idx = i;
> +
> +		subtree_top_idx = env->subprog_info[i].subtree_top_idx;
> +		if (env->subprog_info[subtree_top_idx].priv_stack_eligible) {
> +			if (subtree_top_idx == i)
> +				func[i]->aux->subtree_stack_depth =
> +					env->subprog_info[i].subtree_stack_depth;
> +
> +			subtree_stack_depth = func[i]->aux->subtree_stack_depth;
> +			if (subtree_top_idx != i) {
> +				if (env->subprog_info[subtree_top_idx].subtree_stack_depth)
> +					func[i]->aux->priv_stack_mode = PRIV_STACK_SUB_PROG;
> +				else
> +					func[i]->aux->priv_stack_mode = NO_PRIV_STACK;
> +			} else if (!subtree_stack_depth) {
> +				func[i]->aux->priv_stack_mode = PRIV_STACK_ROOT_PROG;
> +			} else {
> +				func[i]->aux->priv_stack_mode = PRIV_STACK_ROOT_PROG;
> +				priv_stack_ptr =
> +					__alloc_percpu_gfp(subtree_stack_depth, 8, GFP_KERNEL);
> +				if (!priv_stack_ptr) {
> +					err = -ENOMEM;
> +					goto out_free;
> +				}
> +				func[i]->aux->priv_stack_ptr = priv_stack_ptr;
> +			}
> +		}
> +
>  		/* Below members will be freed only at prog->aux */
>  		func[i]->aux->btf = prog->aux->btf;
>  		func[i]->aux->func_info = prog->aux->func_info;
> -- 
> 2.43.5
> 
> 

