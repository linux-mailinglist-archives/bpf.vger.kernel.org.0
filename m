Return-Path: <bpf+bounces-5044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06D75447B
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36E62822E5
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85118AE8;
	Fri, 14 Jul 2023 21:58:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40953AF
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 21:58:19 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794B2127
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:58:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668711086f4so1516096b3a.1
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689371897; x=1691963897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCKwgwAuq9Sn6zrdvI5tfYOVZ7A2Era/YBHiJVaQMg=;
        b=HEIAJAtnfzkEZ8eI66h0+iltBSmOBst6Jc4/HEZjhGKbmHL1Czmf5azmusOCGGKIym
         vPwYzEXkGqeKnGl+d1M/EdVFl0lDk1g2rhGXWc79OnYCMY+dcWi2vCwzqRVueT6mtrsH
         TcA0ukBAEq3+8iE3YK0JQ+ZYkjWCiKSZ627lpY/0rTiIVFRd+0y4/+SMP6uHooZCo/dX
         ecKFrZ79mx0IzccvIJKoqu+2LwtI35qlwpXpCxKzW0bPO87GGjA1rQb6uVd8pY0hk0qn
         qK2gAblRjwPbbvTd5qm4Rf+lm2j08CYyirH0qVQ9xxU34yhqxE6aAhu+pVMs6ZUjO+XD
         busQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689371897; x=1691963897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnCKwgwAuq9Sn6zrdvI5tfYOVZ7A2Era/YBHiJVaQMg=;
        b=TJUj/DG1wAi/DrBrFDDeds7YQp7An7XZYf/wuS4TAXB8HMYEJ3MdpQy/Y3q97572zH
         H8OyXQBoN5iUHjBO2+QrA+TyfKeXeP6jEOMXO1eN+n4w4n0H2/5M34G5a3aA0DNh/mTX
         vks9QLraGv2InfwAVQ927n8uiG4C/u1DOrLZ/jBhqOaPxeUizH0IbOl9pxCXNquAib0a
         c7RGSnHwgPceXo3ZbsSDiHbPoUMpziFo/b6v3pm28xp5+AmCaqSf3NcvD5XIBSHBvYlf
         93NGxjYrNCiXoM99c5TKWWY2H/IK7LYVvGx/LqdK26+6UrQ1YjYr+8LXukRCx7KMLmN8
         hTVw==
X-Gm-Message-State: ABy/qLYD2uRBJ0JTmk5puskqLWybAV75C02sfcXpLc0heQMN4DGipXVX
	ya7/IJ7X+as/IOCKUV0/8wu1lqfwDu4=
X-Google-Smtp-Source: APBJJlHj4PIaH9Lh9eUZtxY8GgvsHBk9nzwKM0yR7zx4YIxaGW1YypZM/I3kFHI2ZCXSj+YhK9cISw==
X-Received: by 2002:a05:6a00:1988:b0:682:edbe:4cbd with SMTP id d8-20020a056a00198800b00682edbe4cbdmr3936975pfl.15.1689371896927;
        Fri, 14 Jul 2023 14:58:16 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id e13-20020a62ee0d000000b0064d74808738sm7525125pfi.214.2023.07.14.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 14:58:16 -0700 (PDT)
Date: Fri, 14 Jul 2023 14:58:14 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 04/10] bpf: Add support for inserting new
 subprogs
Message-ID: <20230714215814.fqv5aypobicomszr@MacBook-Pro-8.local>
References: <20230713023232.1411523-1-memxor@gmail.com>
 <20230713023232.1411523-5-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-5-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:26AM +0530, Kumar Kartikeya Dwivedi wrote:
> Introduce support in the verifier for generating a subprogram and
> include it as part of a BPF program dynamically after the do_check
> phase is complete. The appropriate place of invocation would be
> do_misc_fixups.
> 
> Since they are always appended to the end of the instruction sequence of
> the program, it becomes relatively inexpensive to do the related
> adjustments to the subprog_info of the program. Only the fake exit
> subprogram is shifted forward by 1, making room for our invented subprog.
> 
> This is useful to insert a new subprogram and obtain its function
> pointer. The next patch will use this functionality to insert a default
> exception callback which will be invoked after unwinding the stack.
> 
> Note that these invented subprograms are invisible to userspace, and
> never reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a single
> invented program is supported, but more can be easily supported in the
> future.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h          |  1 +
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/core.c            |  4 ++--
>  kernel/bpf/syscall.c         | 19 ++++++++++++++++++-
>  kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++++-
>  5 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 360433f14496..70f212dddfbf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1385,6 +1385,7 @@ struct bpf_prog_aux {
>  	bool sleepable;
>  	bool tail_call_reachable;
>  	bool xdp_has_frags;
> +	bool invented_prog;
>  	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>  	const struct btf_type *attach_func_proto;
>  	/* function name for valid attach_btf_id */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f70f9ac884d2..360aa304ec09 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -540,6 +540,7 @@ struct bpf_subprog_info {
>  	bool has_tail_call;
>  	bool tail_call_reachable;
>  	bool has_ld_abs;
> +	bool invented_prog;
>  	bool is_async_cb;
>  };
>  
> @@ -594,10 +595,11 @@ struct bpf_verifier_env {
>  	bool bypass_spec_v1;
>  	bool bypass_spec_v4;
>  	bool seen_direct_write;
> +	bool invented_prog;

Instead of a flag in two places how about adding aux->func_cnt_real
and use it in JITing and free-ing while get_info*() keep using aux->func_cnt.

> +/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
> +static int invent_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
> +{
> +	struct bpf_subprog_info *info = env->subprog_info;
> +	int cnt = env->subprog_cnt;
> +	struct bpf_prog *prog;
> +
> +	if (env->invented_prog) {
> +		verbose(env, "verifier internal error: only one invented prog supported\n");
> +		return -EFAULT;
> +	}
> +	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);

The actual patching is not necessary.
bpf_prog_realloc() and memcpy would be enough, no?

> +	if (!prog)
> +		return -ENOMEM;
> +	env->prog = prog;
> +	info[cnt + 1].start = info[cnt].start;
> +	info[cnt].start = prog->len - len + 1;
> +	info[cnt].invented_prog = true;
> +	env->subprog_cnt++;
> +	env->invented_prog = true;
> +	return 0;
> +}
> +
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> -- 
> 2.40.1
> 

