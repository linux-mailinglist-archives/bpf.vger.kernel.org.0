Return-Path: <bpf+bounces-62770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C94AFE35D
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595993B49E1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4057283151;
	Wed,  9 Jul 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOClkRZd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D55383;
	Wed,  9 Jul 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051515; cv=none; b=AXT2eOh1RxtNy1eKin3bRqJpJa8mMdjQlo1yDURv6P3wlKnDht1KBczU7u/kHPB4AVw545JoXcrWTpIex+tSe+BQm4rSKltZgrw0MOTfrAOVKGUa7cg8ezTz3mU4TzKdwiybfGkmg3H/3R5NdKb5khwiUejG/WTzCcJFsvErzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051515; c=relaxed/simple;
	bh=Y0o0ryo0AoD3mTpRJuuHPuBO5t3sO486uzuJTcp1iEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au8f7u0CgiheGhjXGspwRiv8AnlWD4Y2R+tBerTMS3FehsAQDi0cdwVtULj8vQEri3WP9jRb1myJWI0Ni3N3UsDgmYjpIAkewGQ0q6Jp9+smyFIrmJGQKvPA5sPrioNbpDnGHWkgWUaxYMKyoEYwfbhohb5BviVNMYu5SeS3N24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOClkRZd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso157722466b.0;
        Wed, 09 Jul 2025 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752051511; x=1752656311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZU7PLU9etK740VjrgTZnaTTwZRId0YkGwhFbRJaUiw=;
        b=XOClkRZdmXFoete18uk/9aEzr7JDDKV9tQPzR4CPH6bgOri1TA0tuKLfxbJ1auonev
         J2s6pUl8NFSVVGqo44GtySvB8SgoaWiN+W0scoVe1pbtZKwgWoopQI0g2saJRQJQQQ/P
         vw+YvL+JreeRqG/dqz4XoCCW4HhxHSqbSHhjmFNB13H/1+Xa99CXIksCRpuLU2/o95MI
         vbJiGA/Pf3dfxKnr4ghzBlyloE18TTHuv4VTqiWQPJvYvXpYUzD2lyWB95LvdJ2R9tAx
         XRBAdN+PQG7PrOT9JIAvlqY84lYKr2Iqwy5r/GeKaT3ac79nxhzM2zaVuM1ME/Y/6oUa
         qK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051511; x=1752656311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZU7PLU9etK740VjrgTZnaTTwZRId0YkGwhFbRJaUiw=;
        b=Oymu1q8gknlJ7LOmC000dikkzZ1Qmy5Z3O9wnMo7+TyWHphowmfwydaMsQNE0rvAsm
         +iFFtJ4xdVofSxwiSQZISioamFvjN54lmVXoItgcZ3iiReI5f4K0E9zy21WPet24qHeL
         5uvpUcPd59DgVxU+uTFh5tJQy6NbyyaDKkPNbdEmgj2LZLQaxkRKiYgKPl0hBCKgFN4v
         YNyWFPBqqnhtLUgKVtsdYxUrrmFaNfI4iLwC1QfmH7yz5Y1u3t63Wy2ZHSeR/7DA5TYL
         0fJ9afa7hT89WBD0NIR0xX9566FYYAcxI/lZFTVOH+tM43zIlEMHmi0cRbVb+zs5VcNe
         c70Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAh3mQ8tCXxHkdqgXJRxteSucfQKeMqbh0Y7YegxL0daIPnsuigVXEBPdSqG7oBDzYHaIUTt7xXeTETGe8@vger.kernel.org, AJvYcCWk/zAA1lkv1uzyUwmZrJF+ci/6Ksy/Q/DMTpM1J//3t8ti2RYUB6FlLSPdArjjX6dc9ICcXU7c2sQt/QLTqO53vYVU@vger.kernel.org, AJvYcCWuM/kiklun1CAA01k/v0SaoCwtn6vmQ04MetLR6s2SXBb6ox6tUuXmxEjECiJRARww4nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFXSl9zfyDSEAu+A7XBoq+PU/3EfGe51ZLaQ7SQN5ruXCXsgu
	1sj0EWh5CEMjEEUAU8vMSXaXO7w70U1vwQ6tHs1D1gn2kkbySAkiKWIJ
X-Gm-Gg: ASbGnctkjRE5rQrB8qNFI1uVVIIw7L+RaaTEBrua6SZ3HAlIR8GCCFFDpcpJe2YqP+p
	HM4DzP2vUfY5b9TW/k8rVl9niX2nkX1wqQjuD0Utx/IcJMR2jvtM/zTu8674JdyNRy9iUB0PSJK
	PXJt/rH5gRB37m3DARrh5CfQyWt3qryPwFFoUbpPUHK8k7R1LIEqqRcfhyISMrAtPdydpxNnNzY
	B2j6FM9kO2dh/DJaCL/0GS/frS1iEhHpl8W2PRq7GdovzN9AvzKcUlJ/ET+YZv8ib4EJFn8GTs1
	QSEatOsqgp+pT7kA9fdTKNCVNWAcD2reKZMNdYN8TFMdG6FV
X-Google-Smtp-Source: AGHT+IGMs8mKBfncdPVlgcuDOMHk/B1ZdoW3Ur23b6Nt5GbyAgyTzAx9ZOUVxdidKzOlFDPJNz3BFQ==
X-Received: by 2002:a17:907:6ea2:b0:ae0:7e95:fb with SMTP id a640c23a62f3a-ae6b2363d94mr578100066b.5.1752051510223;
        Wed, 09 Jul 2025 01:58:30 -0700 (PDT)
Received: from krava ([173.38.220.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6abfd8bsm1061632866b.81.2025.07.09.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:58:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 9 Jul 2025 10:58:28 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Clean up individual BTF_ID code
Message-ID: <aG4vNLiusia14f4Z@krava>
References: <20250709082038.103249-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709082038.103249-1-yangfeng59949@163.com>

On Wed, Jul 09, 2025 at 04:20:38PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Use BTF_ID_LIST_SINGLE(a, b, c) instead of
> BTF_ID_LIST(a)
> BTF_ID(b, c)

there's couple more in:

net/ipv6/route.c
net/netlink/af_netlink.c
net/sched/bpf_qdisc.c

jirka


> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  kernel/bpf/btf.c         | 3 +--
>  kernel/bpf/link_iter.c   | 3 +--
>  kernel/bpf/prog_iter.c   | 3 +--
>  kernel/trace/bpf_trace.c | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2dd13eea7b0e..0aff814cb53a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6200,8 +6200,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>  	return kctx_type_id;
>  }
>  
> -BTF_ID_LIST(bpf_ctx_convert_btf_id)
> -BTF_ID(struct, bpf_ctx_convert)
> +BTF_ID_LIST_SINGLE(bpf_ctx_convert_btf_id, struct, bpf_ctx_convert)
>  
>  static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name,
>  				  void *data, unsigned int data_size)
> diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
> index fec8005a121c..8158e9c1af7b 100644
> --- a/kernel/bpf/link_iter.c
> +++ b/kernel/bpf/link_iter.c
> @@ -78,8 +78,7 @@ static const struct seq_operations bpf_link_seq_ops = {
>  	.show	= bpf_link_seq_show,
>  };
>  
> -BTF_ID_LIST(btf_bpf_link_id)
> -BTF_ID(struct, bpf_link)
> +BTF_ID_LIST_SINGLE(btf_bpf_link_id, struct, bpf_link)
>  
>  static const struct bpf_iter_seq_info bpf_link_seq_info = {
>  	.seq_ops		= &bpf_link_seq_ops,
> diff --git a/kernel/bpf/prog_iter.c b/kernel/bpf/prog_iter.c
> index 53a73c841c13..85d8fcb56fb7 100644
> --- a/kernel/bpf/prog_iter.c
> +++ b/kernel/bpf/prog_iter.c
> @@ -78,8 +78,7 @@ static const struct seq_operations bpf_prog_seq_ops = {
>  	.show	= bpf_prog_seq_show,
>  };
>  
> -BTF_ID_LIST(btf_bpf_prog_id)
> -BTF_ID(struct, bpf_prog)
> +BTF_ID_LIST_SINGLE(btf_bpf_prog_id, struct, bpf_prog)
>  
>  static const struct bpf_iter_seq_info bpf_prog_seq_info = {
>  	.seq_ops		= &bpf_prog_seq_ops,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e7f97a9a8bbd..c8162dc89dc3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -781,8 +781,7 @@ BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
>  	return (unsigned long) task_pt_regs(task);
>  }
>  
> -BTF_ID_LIST(bpf_task_pt_regs_ids)
> -BTF_ID(struct, pt_regs)
> +BTF_ID_LIST_SINGLE(bpf_task_pt_regs_ids, struct, pt_regs)
>  
>  const struct bpf_func_proto bpf_task_pt_regs_proto = {
>  	.func		= bpf_task_pt_regs,
> -- 
> 2.43.0
> 

