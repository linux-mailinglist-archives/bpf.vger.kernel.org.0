Return-Path: <bpf+bounces-76410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D2FCB2A0E
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 11:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CED05302F3F4
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F573090F1;
	Wed, 10 Dec 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpzMZMlK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866942FBE0D
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361195; cv=none; b=Z2GIoUmSdpO/u2q9BxdjbpdgENu/kDQB9MIt6caKF7I8p947Kau/0ahOxsyqVjaHkRgTSG8dGW9IFoi6xtSPK9LJofb50FaXbsUiVRh7ONKXsbOM95N2pFRV9O7390gRDKk8cEnqZT23RcLJ/Ozp9V3oh///bw9sPopaLip2sKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361195; c=relaxed/simple;
	bh=cw6oaBymTYLeSEcS/BqmfTk5kYjaDTJjQEUiLmsBx7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqgDmez3muaPojV6+QelZKGhlONMosUcl5iM86H/IS0OH1Q59bDuWGCCZXs/nJntnd12X6y5knI9Yict08KlRAIiLcrM9S9ZdbhNqFPANnLYX8pipcV2y7I0/od7OTL6eKMLRcyJZ2ltmAp/4BPlLlb2hYmpsBtBnNjt6G8k1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpzMZMlK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7633027cb2so1056385366b.1
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765361192; x=1765965992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFkseyARg7/gd8a1EpgRBdWBQ7N9V3WZnz9R3RNJ7tI=;
        b=CpzMZMlKZqlS/BB6W+9PgOzDo8Vgw7xYXiDuQvBIXSwqNNhvv4scQbSI7gwbZZf4c2
         tP+WVqnnHHnKfAzZ7rg1K+XfTqbMNRMqWJA6AoluhHBvuBgB2XCI18+U46Zwm9SNLpM5
         KfqTSeNGFXrsnCdGjxU2o5JkVChxEn4HMKW6t3sgHCM8e659QhzgS18U3+IW8/doL5Jx
         +ZxGRJi2S0QQ6hlvUXq/cmv8wmz0qSGXEZAQhjg1Isl5kexXngTZU0AeTZwSo4j8pGhi
         dEyLGvGYb0hwwEvKxA2bGYxztTmDqw58yNvt+Np/DMz1aKUO19H8XEgrU96rdxLYmzzE
         YXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361192; x=1765965992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFkseyARg7/gd8a1EpgRBdWBQ7N9V3WZnz9R3RNJ7tI=;
        b=GRk3Oecjq1JB/GDUKFxr56ldFTQF9KWHyO8HMhheJdWuagTWLeiGts9WSKo5k3ikgm
         b5bT6po9h7JdJAFpvwWd6gQb1DHHF38ARTjy1lWw8NGB0JuRtYlncgmO+A+vzzWwzx/E
         yF61duX+VGm2eS2OCN3LIOSkXXIycYvjrcEmlbEG0xbNR1Pu4DuA/nTH4zHj8di76lxZ
         NB4KyPir0bhzgniLppEADM7CRpM1qY12qMLl7MEZvAtrYRmRqWQZj99IWxo0KTMFmbas
         W+w9wlmSWgTeXeB0CjXJmp/v9xbJA3ryaaJI2Zw8Mi/O113Ancvw1W20XSNa3YZoEnjM
         47fw==
X-Gm-Message-State: AOJu0YzGoveRRsFCIIMK3DUJcjI8fHa/Kt/SE30xsqKINxc0wEH4gfFh
	bvXKkj0gbyTtCjubEGI8j4wuNIC5HGUxydqCdAgmJvqQV7Lc5ixLaR1YJI7vio9D4N9va7w1G68
	NDzmJdA==
X-Gm-Gg: ASbGncuwKNeMiEGBF9kJL5u0Lc1zyVjjcHCzyKEaYtgy1yc0lHkZPmUaPEsRB8dF43L
	Ha2fTYgQ6m+r9s+IEqBv+XR1yf5UcMcxQKSOxcFJrg4qGrtPgNTJ6qqaP6EEI1p7JIPZZg7bRHO
	VFQPlXMU16FNkQMn0Mf0JY2Ng5X2tEO5upWTO2pfguctgeklMYsowbTEbfMd94OOQXU6UjTA9Lo
	VNgwgnvPtn2Rf8HfY/GmSEF3DpiOvc2BYXpoNBYAHVj4eDLeP64y2jHwMN5CAOiqfDlqKhESIfq
	XKhUY5W6xXIy8LBk84sKpraQnanoGbQtskauVznUJaHBggCSDAr2s2QVqVZnNG0/5zstSX1qoUc
	wzsOncgcSogoYKcC2tRYZ1mzT0rNj6/LVuk+RQ5icM3o92vA/9z1dT56x8b4aej6VsGN7PjR0/z
	HCweCcQOukSegpoV5gWUCXuhwhSXRzaHLy7FE+KG6MlIYXb4cxvPJ9Lqzt
X-Google-Smtp-Source: AGHT+IHxhqUfSNrUjDUkW3FFCtDHhpjU57tefTMteZQYBBN0Gh6E2/8HeN+akMebNrBdV2LjD5wm9A==
X-Received: by 2002:a17:907:9307:b0:b73:4e86:88ac with SMTP id a640c23a62f3a-b7ce8231ffcmr194400666b.12.1765361191220;
        Wed, 10 Dec 2025 02:06:31 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79fe78c9ebsm1543232966b.5.2025.12.10.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 02:06:30 -0800 (PST)
Date: Wed, 10 Dec 2025 10:06:27 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Josh Don <joshdon@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: annotate file argument as __nullable
 in bpf_lsm_mmap_file
Message-ID: <aTlGIygVuQSLcNwN@google.com>
References: <20251210090701.2753545-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210090701.2753545-1-mattbobrowski@google.com>

On Wed, Dec 10, 2025 at 09:07:00AM +0000, Matt Bobrowski wrote:
> As reported in [0], anonymous memory mappings are not backed by a
> struct file instance. Consequently, the struct file pointer passed to
> the security_mmap_file() LSM hook is NULL in such cases.
> 
> The BPF verifier is currently unaware of this, allowing BPF LSM
> programs to dereference this struct file pointer without needing to
> perform an explicit NULL check. This leads to potential NULL pointer
> dereference and a kernel crash.
> 
> Add a strong override for bpf_lsm_mmap_file() which annotates the
> struct file pointer parameter with the __nullable suffix. This
> explicitly informs the BPF verifier that this pointer (PTR_MAYBE_NULL)
> can be NULL, forcing BPF LSM programs to perform a check on it before
> dereferencing it.
> 
> [0] https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn/
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  MAINTAINERS                |  1 +
>  kernel/bpf/Makefile        | 12 +++++++++++-
>  kernel/bpf/bpf_lsm.c       |  5 +++--
>  kernel/bpf/bpf_lsm_proto.c | 20 ++++++++++++++++++++
>  4 files changed, 35 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/bpf/bpf_lsm_proto.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e36689cd7cc7..c531fae0dc06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4754,6 +4754,7 @@ S:	Maintained
>  F:	Documentation/bpf/prog_lsm.rst
>  F:	include/linux/bpf_lsm.h
>  F:	kernel/bpf/bpf_lsm.c
> +F:	kernel/bpf/bpf_lsm_proto.c
>  F:	kernel/trace/bpf_trace.c
>  F:	security/bpf/
>  
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 232cbc97434d..79cf22860a99 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -42,7 +42,17 @@ endif
>  ifeq ($(CONFIG_BPF_JIT),y)
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>  obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
> -obj-${CONFIG_BPF_LSM} += bpf_lsm.o
> +# bpf_lsm_proto.o must precede bpf_lsm.o. The current pahole logic
> +# deduplicates function prototypes within
> +# btf_encoder__add_saved_func() by keeping the first instance seen. We
> +# need the function prototype(s) in bpf_lsm_proto.o to take precedence
> +# over those within bpf_lsm.o. Having bpf_lsm_proto.o precede
> +# bpf_lsm.o ensures its DWARF CU is processed early, forcing the
> +# generated BTF to contain the overrides.
> +#
> +# Notably, this is a temporary workaround whilst the deduplication
> +# semantics within pahole are revisited accordingly.
> +obj-${CONFIG_BPF_LSM} += bpf_lsm_proto.o bpf_lsm.o
>  endif
>  ifneq ($(CONFIG_CRYPTO),)
>  obj-$(CONFIG_BPF_SYSCALL) += crypto.o
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 7cb6e8d4282c..0c4a0c8e6f70 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -18,10 +18,11 @@
>  #include <linux/bpf-cgroup.h>
>  
>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> - * function where a BPF program can be attached.
> + * function where a BPF program can be attached. Notably, we qualify each with
> + * weak linkage such that strong overrides can be implemented if need be.
>   */
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
> -noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
> +__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  {						\
>  	return DEFAULT;				\
>  }
> diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
> new file mode 100644
> index 000000000000..273bc7ddad64
> --- /dev/null
> +++ b/kernel/bpf/bpf_lsm_proto.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 Google LLC.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/bpf_lsm.h>
> +
> +/*
> + * A strong definition for BPF LSM hook mmap_file(). Differs from its weak
> + * definition counterpart only through its of the __nullable suffix on its
> + * struct file pointer parameter. Annotating with a __nullable suffix allows the
> + * BPF verifier to enforce stricter NULL pointer checking in cases where a BPF
> + * program is attempting to access the BPF program context.
> + */

Ah, I just realized that I need to fix up the wording within this
comment. I'll do that when I send out v2.

> +int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
> +		      unsigned long prot, unsigned long flags)
> +{
> +	return 0;
> +}
> -- 
> 2.52.0.223.gf5cc29aaa4-goog
> 

