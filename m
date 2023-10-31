Return-Path: <bpf+bounces-13765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8877DD912
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16655B20F9B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BE27467;
	Tue, 31 Oct 2023 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+O0qPLz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDA27455
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 23:03:50 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365EF3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:03:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c773ac9b15so928448366b.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698793427; x=1699398227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHW4XwHs8TtMPk3qLpEXRTvLnK5XWtJBtcaJXol7HsY=;
        b=h+O0qPLzzG4T74453IhPNUpdzpMgQJ3AHLUguM/KHSZmYBvges9VizGPceE4qbOV1V
         yOlczm97Yoc/UPdtBV2Ung8W5iEHNMIx9bmeRVqikNXGo4L66KmVYNRa3rReRqO+q8rO
         FsLy1ylzWvHdqKyl+aID4XcZYmbl4CbZd4CnGm4kXtBmfO8H4Kdgn7X+hJJHVrCctoK7
         Q4IAxW71PpV46AAStXkzU5vBjteGG/IPr1Sh4im4qwKx7AZhUV5rIgFCRzHRz7dR38y1
         rZEF+IrlwKvPxPENHdQEa2M7ulr/f6xwNPpms5JXCbdX88qlA2bkVxxpA5L/jYtoEMrG
         RcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793427; x=1699398227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHW4XwHs8TtMPk3qLpEXRTvLnK5XWtJBtcaJXol7HsY=;
        b=vdUZfH3+FoRdAHj5/ZQOQNCjHIVBx1VDGHF5rjFjc6XciVVQqAPWCcm3J8WJ2kmLZW
         4d9yX8mSOCMrTaHb/VDQAO3fKIFQEwRY/wwguDjYZcuuvEd6FdDjtMgWxrl2sRvgQxlk
         44o7eU55YLRSi24XVRlq9ACUG7inGhav0pBFjOXW2vV0lRAo68axlAu/jWhEABJKxxJC
         E629avKFLDduhs1/7ArEnnVBNkqFicT+95+QuxuX0R7tu81agyGIjqNVWAXjUI7YDsqj
         srmr9Mbn7m/Ua8cL1L+N+IwL7GzRX0BiqmjJ0+qrVtg8J2T5deOpLZwGvkfY2Ti99kkH
         lBsw==
X-Gm-Message-State: AOJu0YyBEXkpODsntXcwl6dsTq/gb4GU5Ftw6CGc8+0o/Q5WFXVTFXgG
	fhB/mBWq2WdgSzeKUiEgrQA=
X-Google-Smtp-Source: AGHT+IFdRdKalIf3Cu16trnV7MnJlGY+MRGvBhzTvf1syEKX8ImEBxiQml2BJhVE7r+zZhkUh0oMNQ==
X-Received: by 2002:a17:907:7ba9:b0:9be:40ba:5f1 with SMTP id ne41-20020a1709077ba900b009be40ba05f1mr609814ejc.60.1698793426781;
        Tue, 31 Oct 2023 16:03:46 -0700 (PDT)
Received: from krava ([83.240.60.144])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906278a00b009b977bea1dcsm1603343ejc.23.2023.10.31.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 16:03:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Nov 2023 00:03:44 +0100
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>, laoar.shao@gmail.com
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: Add __bpf_hook_{start,end} macros
Message-ID: <ZUGH0Hat81I7AH9s@krava>
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
 <20231031215625.2343848-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031215625.2343848-2-davemarchevsky@fb.com>

On Tue, Oct 31, 2023 at 02:56:25PM -0700, Dave Marchevsky wrote:
> Not all uses of __diag_ignore_all(...) in BPF-related code in order to
> suppress warnings are wrapping kfunc definitions. Some "hook point"
> definitions - small functions meant to be used as attach points for
> fentry and similar BPF progs - need to suppress -Wmissing-declarations.
> 
> We could use __bpf_kfunc_{start,end}_defs added in the previous patch in
> such cases, but this might be confusing to someone unfamiliar with BPF
> internals. Instead, this patch adds __bpf_hook_{start,end} macros,
> currently having the same effect as __bpf_kfunc_{start,end}_defs, then
> uses them to suppress warnings for two hook points in the kernel itself
> and some bpf_testmod hook points as well.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> This patch was added in v2 in response to convo on v1's thread.
> 
>  include/linux/btf.h                                   | 2 ++
>  kernel/cgroup/rstat.c                                 | 9 +++------
>  net/socket.c                                          | 8 ++------
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 ++----
>  4 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index dc5ce962f600..59d404e22814 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -92,6 +92,8 @@
>  			  "Global kfuncs as their definitions will be in BTF")
>  
>  #define __bpf_kfunc_end_defs() __diag_pop()
> +#define __bpf_hook_start() __bpf_kfunc_start_defs()
> +#define __bpf_hook_end() __bpf_kfunc_end_defs()
>  
>  /*
>   * Return the name of the passed struct, if exists, or halt the build if for
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index d80d7a608141..c0adb7254b45 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -156,19 +156,16 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>   * optimize away the callsite. Therefore, __weak is needed to ensure that the
>   * call is still emitted, by telling the compiler that we don't know what the
>   * function might eventually be.
> - *
> - * __diag_* below are needed to dismiss the missing prototype warning.
>   */
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -		  "kfuncs which will be used in BPF programs");
> +
> +__bpf_hook_start();
>  
>  __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>  				     struct cgroup *parent, int cpu)
>  {
>  }
>  
> -__diag_pop();
> +__bpf_hook_end();
>  
>  /* see cgroup_rstat_flush() */
>  static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
> diff --git a/net/socket.c b/net/socket.c
> index c4a6f5532955..cd4d9ae2144f 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1685,20 +1685,16 @@ struct file *__sys_socket_file(int family, int type, int protocol)
>   *	Therefore, __weak is needed to ensure that the call is still
>   *	emitted, by telling the compiler that we don't know what the
>   *	function might eventually be.
> - *
> - *	__diag_* below are needed to dismiss the missing prototype warning.
>   */
>  
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -		  "A fmod_ret entry point for BPF programs");
> +__bpf_hook_start();
>  
>  __weak noinline int update_socket_protocol(int family, int type, int protocol)
>  {
>  	return protocol;
>  }
>  
> -__diag_pop();
> +__bpf_hook_end();
>  
>  int __sys_socket(int family, int type, int protocol)
>  {
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index a5e246f7b202..91907b321f91 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -39,9 +39,7 @@ struct bpf_testmod_struct_arg_4 {
>  	int b;
>  };
>  
> -__diag_push();
> -__diag_ignore_all("-Wmissing-prototypes",
> -		  "Global functions as their definitions will be in bpf_testmod.ko BTF");
> +__bpf_hook_start();
>  
>  noinline int
>  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, int c) {
> @@ -335,7 +333,7 @@ noinline int bpf_fentry_shadow_test(int a)
>  }
>  EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
>  
> -__diag_pop();
> +__bpf_hook_end();
>  
>  static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
>  	.attr = { .name = "bpf_testmod", .mode = 0666, },
> -- 
> 2.34.1
> 
> 

