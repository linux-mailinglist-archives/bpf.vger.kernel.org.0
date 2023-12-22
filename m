Return-Path: <bpf+bounces-18579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F781C2AF
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BAA1C2312F
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC3A31;
	Fri, 22 Dec 2023 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGQWQUQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03D5665
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so1000336b6e.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208407; x=1703813207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fypQzbGHVQ4zslvd8UkAohgFSHqbAEf8sSbFZ0ZdxtE=;
        b=SGQWQUQfgjlyveNbGjT9mIytvxEjWqasezyLjBF8JjzlREUl76j1HD4GrzoQC2DQoA
         1u4MKdt9zQY2rY2vZ4fnFuC/zT5wctborNROAdFc1ORnbrH6BPIa/bzS0TgAEwvRwFOk
         ZH7sk+cluHZNfYL+7WtBQ9lDSblxCvciX6fZPNySDxup+UlHQt5aMovTRykamMFwq9tJ
         r7Zv1lSg5O0magyP3tIdle1Hc4JcgXPVAxRA50CS5+aPwR5qYbeZ5xjCxJ4CR+kUyfds
         +29h8tYHbUz111MadeT26qOWJkvEJv/JMTDjIg1Ee0Ztpyp1FI0sd4978KOnFIcVmLYv
         6rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208407; x=1703813207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fypQzbGHVQ4zslvd8UkAohgFSHqbAEf8sSbFZ0ZdxtE=;
        b=LG0R4MxIFQTLBM2KyHeWN5LBPQiV1xM9GgoTOYVKM6RrSubiYXIYdKjMhsorbjmS7X
         vEver7uQNNWPWmT44wRCVqWAtGiHPe4iRr0bkhOD5NqaAtYNZK4TV0Y1uuTw0BC0vFwk
         6fzCpVpgVo43E/AphJLXOly0n1Bwu7ficNI8fDcRW4P77q3f+3ON2pXwTncjR+QHvyZd
         UO3bwyneKZxQxhCcnatHV/prpUq7ICc+vdX34glnot8LLzIPI9zNAPL3ttODP3uYLOxw
         jEq2KJY3ijlmDkEwfuuT5CvB8H38cHe2LQwwztgxs9nbpvT10ftT7fMw/ikZRZYQmBph
         YeOg==
X-Gm-Message-State: AOJu0Yz1al5h6g3ntOlSPD7Pk3GC5p0jBwO1ozFTxZEcqJLi/lgO+lPF
	VzTCdrKT5JN/p/AZm60uDJ/jdkZgGiA=
X-Google-Smtp-Source: AGHT+IEiZrjwExxxIhMMKE5YS5oYpfKe4DyK9m7DihB5yTexBQZAxHgs1T+5+rDJPbN73Hi5C+yJKQ==
X-Received: by 2002:a05:6808:38c4:b0:3ba:a5a:5e37 with SMTP id el4-20020a05680838c400b003ba0a5a5e37mr995719oib.117.1703208407330;
        Thu, 21 Dec 2023 17:26:47 -0800 (PST)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78703000000b006d93795f7e0sm2256626pfo.120.2023.12.21.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:26:46 -0800 (PST)
Date: Thu, 21 Dec 2023 17:26:44 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
Message-ID: <aa5oh3hr4hbq6uk5ejmazunhv4scr6fbmzuxqibilucwprhidy@wsmnjikxm6vu>
References: <20231220233127.1990417-1-andrii@kernel.org>
 <20231220233127.1990417-8-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220233127.1990417-8-andrii@kernel.org>

On Wed, Dec 20, 2023 at 03:31:26PM -0800, Andrii Nakryiko wrote:
> This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> the actual argument type not important, so that user can just define
> "generic" signature:
> 
>   __noinline int global_subprog(void *ctx __arg_ctx) { ... }

Just realized that we probably need to enforce in both libbpf doing
rewrite and in the kernel that __arg_ctx is either valid
'struct correct_type_for_bpf_prog *' or 'void *'.

Otherwise the user will get surprising behavior when
int foo(struct __sk_buff *ctx __arg_ctx)
{
  ctx->len;
}
will get rewritten to 'struct pt_regs *ctx' based on prog type
while all asm instructions inside prog were compiled with 'struct __sk_buff'
and CO_RE performs relocations against that type.
 
> +static struct {
> +	enum bpf_prog_type prog_type;
> +	const char *ctx_name;
> +} global_ctx_map[] = {
> +	{ BPF_PROG_TYPE_CGROUP_DEVICE,           "bpf_cgroup_dev_ctx" },
> +	{ BPF_PROG_TYPE_CGROUP_SKB,              "__sk_buff" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCK,             "bpf_sock" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCK_ADDR,        "bpf_sock_addr" },
> +	{ BPF_PROG_TYPE_CGROUP_SOCKOPT,          "bpf_sockopt" },
> +	{ BPF_PROG_TYPE_CGROUP_SYSCTL,           "bpf_sysctl" },
> +	{ BPF_PROG_TYPE_FLOW_DISSECTOR,          "__sk_buff" },
> +	{ BPF_PROG_TYPE_KPROBE,                  "bpf_user_pt_regs_t" },
> +	{ BPF_PROG_TYPE_LWT_IN,                  "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_OUT,                 "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_SEG6LOCAL,           "__sk_buff" },
> +	{ BPF_PROG_TYPE_LWT_XMIT,                "__sk_buff" },
> +	{ BPF_PROG_TYPE_NETFILTER,               "bpf_nf_ctx" },
> +	{ BPF_PROG_TYPE_PERF_EVENT,              "bpf_perf_event_data" },
> +	{ BPF_PROG_TYPE_RAW_TRACEPOINT,          "bpf_raw_tracepoint_args" },
> +	{ BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, "bpf_raw_tracepoint_args" },
> +	{ BPF_PROG_TYPE_SCHED_ACT,               "__sk_buff" },
> +	{ BPF_PROG_TYPE_SCHED_CLS,               "__sk_buff" },
> +	{ BPF_PROG_TYPE_SK_LOOKUP,               "bpf_sk_lookup" },
> +	{ BPF_PROG_TYPE_SK_MSG,                  "sk_msg_md" },
> +	{ BPF_PROG_TYPE_SK_REUSEPORT,            "sk_reuseport_md" },
> +	{ BPF_PROG_TYPE_SK_SKB,                  "__sk_buff" },
> +	{ BPF_PROG_TYPE_SOCK_OPS,                "bpf_sock_ops" },
> +	{ BPF_PROG_TYPE_SOCKET_FILTER,           "__sk_buff" },
> +	{ BPF_PROG_TYPE_XDP,                     "xdp_md" },

We already share the .c files (like relo_core.c) between kernel and libbpf
let's share here as well to avoid copy paste.
All of the above is available in include/linux/bpf_types.h

> +		/* clone fn/fn_proto, unless we already did it for another arg */
> +		if (func_rec->type_id == orig_fn_id) {

It feels that body of this 'if' can be factored out as a separate helper function.

> -static int
> -bpf_object__load_progs(struct bpf_object *obj, int log_level)
> +static int bpf_object_load_progs(struct bpf_object *obj, int log_level)

pls keep __ convention.

