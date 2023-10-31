Return-Path: <bpf+bounces-13728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD17DD3DF
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC394B21014
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98F2032D;
	Tue, 31 Oct 2023 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USHGYfnn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BC2031C
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:05:30 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47E181;
	Tue, 31 Oct 2023 10:05:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so10251870a12.1;
        Tue, 31 Oct 2023 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698771927; x=1699376727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHOq+cM1i5HvilDCUI3n2s0JE2fFsAEJIBhWGuopi9E=;
        b=USHGYfnnsTMSxXqdmOHwuBfdbU20Ymow/HfF6shFT4ANCtcq9ICZYYA4pIQ7RE4jlX
         7edaUJ1TE4Bt+Q0K9g/7WHYnrQccXZLlreQ7M2ohQw7pcxjZr/yjUiJ7JFtTn+mH2arx
         UEEnhjHTRVPLSHZPJWnbVvf9j2wNAK3gOc1DM95z2MGQSAlS0ol/9u1l8RzJr6tOOfQS
         fr30yKguNEDQ5lRenE7t4VjovjYGAu8bFD8sbskAgYzQYR6RRkqfujVJORRK0Ml34sqh
         tnh2lLkfqn962QwobeG1u2MLS6qwMWpQPse5K/3y2Tw8ALqZpfgaABfYpmTrBEiaUrJy
         WlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771927; x=1699376727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHOq+cM1i5HvilDCUI3n2s0JE2fFsAEJIBhWGuopi9E=;
        b=op2CYNNIZSgchTC1HWY1FpYVPC2ZKpDNjehyv5ttAsDNAdvKv+oxTPyOpLkx5Tjvtz
         9Fa0/RaEP4M57oDss7r8/Jpg6J60VcqPKnIy8c2MQv+85HjqCMvtxp9mpD2Sg2+cqRR1
         9zKOQh0F6xf5x9tgDzuAid6VleUm8YMDplI+437d0e+ZilqC7rNcSWRdYvGvWGDuQXWV
         0IV4y8RjaEjTbzRxOxr+MytQ35R9XdXQIlXnwH4rcdCliEo15GPk+xT67yNts7QfnNAc
         olLGNWxRVP7swXLBNrSYcbizmDtXZdt9dDJfN3/WIOItqp1O9PGnURGm9i2H0gcT72Fm
         Pv3w==
X-Gm-Message-State: AOJu0Yzt8nYIC6N8pxY+o4vAeFt/C001l3PETe7TgNu0Yi7hPb9LemAf
	+JuoPzlkhrAA0K/GvxCjOPZb8iMQezOw7Q==
X-Google-Smtp-Source: AGHT+IHaRXGmxNROU+qgeKBTMhFayeYLeKfBdCCE+0SfI7lcwuHO+zQmfzKBoA+F2pfuixIZlMBnpA==
X-Received: by 2002:a17:906:dace:b0:9c3:730e:6947 with SMTP id xi14-20020a170906dace00b009c3730e6947mr10822219ejb.41.1698771926710;
        Tue, 31 Oct 2023 10:05:26 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906714500b0099ce188be7fsm1279516ejj.3.2023.10.31.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:05:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 31 Oct 2023 18:05:17 +0100
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Message-ID: <ZUEzzc/Sod8OR28B@krava>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>

On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> possible to build the kernel without CONFIG_CGROUPS:
> 
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |              ^~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>         |                                                            ^~~~~~
>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>     930 |         css_task_iter_start(css, flags, kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~~~
>         |         task_seq_start
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~
>         |                class_dev_iter_next
>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>     949 |         css_task_iter_end(kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~
> 
> This patch simply surrounds with a #ifdef the new code requiring CGroups
> support. It seems enough for the compiler and this is similar to
> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> been added in kernel/bpf/helpers.c and in the selftests.
> 
> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/task_iter.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 59e747938bdb..e0d313114a5b 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -894,6 +894,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  
>  __diag_pop();
>  
> +#ifdef CONFIG_CGROUPS
> +
>  struct bpf_iter_css_task {
>  	__u64 __opaque[1];
>  } __attribute__((aligned(8)));
> @@ -952,6 +954,8 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>  
>  __diag_pop();
>  
> +#endif /* CONFIG_CGROUPS */
> +
>  struct bpf_iter_task {
>  	__u64 __opaque[3];
>  } __attribute__((aligned(8)));
> 
> ---
> base-commit: f1c73396133cb3d913e2075298005644ee8dfade
> change-id: 20231031-bpf-compil-err-css-056f3db04860
> 
> Best regards,
> -- 
> Matthieu Baerts <matttbe@kernel.org>
> 

