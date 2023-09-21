Return-Path: <bpf+bounces-10529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA327A9826
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FF92823D7
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663417997;
	Thu, 21 Sep 2023 17:09:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499017996
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:09:36 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F89B61B2
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:09:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-530e180ffcbso1357893a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316153; x=1695920953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8VVQrVnZee+aGxc2CUGAEq4qzXZzKMNjg1XZbbpQNM=;
        b=OHAgEGKA8emRBkMtoXmnsq0kYedMu9IpkNHc7PxHud86GzbZxascupTquL/fhvWFYc
         Vb2sdk3lxbOFnaNyi094UTVOXQ1mIDTgkRVYO1vIRN3Py0zQdO1Hz/meB4/t75eSqJOy
         Du5gs/X01vJ0i+ImvrpunsiTnscBWrTAB/o9ZvIYOjmJdZw6d73yFitk+LX35rwb6Dl1
         V3qpJQbCyTU6YEftHxUlskb+sLOr6TI1srSXU7yb65IpUtBIEzXbjUb7IHtUYwZL9BBr
         4oJRrRoV+0ZCPTPyFFJqD5qWiFB1ivR+yiz3I/JPCcrq8hG5bMTO4KW4P31uwIXF/N5b
         ndXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316153; x=1695920953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8VVQrVnZee+aGxc2CUGAEq4qzXZzKMNjg1XZbbpQNM=;
        b=dhKMtOzL5OXWAQ0QNthKmNf6CurRk/ZtFBnMQ6j36RHdfw+7vbzHB3LNpvdN1S8U9v
         iaQgrCLN6D57q1Goi2LuXOItTkWRVLzjPzj2aQMsYrTMKrSijKHkAEOWoe4qb01Hb+1B
         drUb0KFvU939RPXiNubjiVIDclQ7QH8nwo3/lQQkkOPZ3t3bpfWPeqMzFa8rLvDSvWiI
         Cnb9FvBEAGX3AdQAhwMme7ccbXH4ZdXH+tylDxBEWF7VQSPLzFHF3QvvP7rwl10ZiWHE
         2AtJl3Y+TfvGFuf/somLOFmwEFuNGB4aPGMIB7U1X2QDWOMj3TI+PehATYB3275MfP2p
         9COA==
X-Gm-Message-State: AOJu0Yyv3jin90yni+JmJspOQkpiFj9W4ojW+dwdLOP+vxHNF6x1F3Ax
	oNQ8QIxDGRXHl7v1rYk9Py/9vAP485U=
X-Google-Smtp-Source: AGHT+IHvsbAPg4dJ00y8pVJs8tECJGRohgVG1HA4PvDuSeoWDe4giSQKNtrP2dT0f8DhaSyZaS3RvQ==
X-Received: by 2002:a17:906:20d4:b0:9a5:874a:9745 with SMTP id c20-20020a17090620d400b009a5874a9745mr5597106ejc.26.1695306302445;
        Thu, 21 Sep 2023 07:25:02 -0700 (PDT)
Received: from krava (253.252.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.252.253])
        by smtp.gmail.com with ESMTPSA id gq23-20020a170906e25700b009ad75d318ffsm1150808ejb.17.2023.09.21.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:25:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Sep 2023 16:24:59 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Message-ID: <ZQxSO/eR6NpZ/aBX@krava>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920053158.3175043-7-song@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:31:56PM -0700, Song Liu wrote:

SNIP

>  bool bpf_jit_supports_subprog_tailcalls(void)
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5f7528cac344..eca561621e65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2422,10 +2422,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>   * add rsp, 8                      // skip eth_type_trans's frame
>   * ret                             // return to its caller
>   */
> -int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> -				const struct btf_func_model *m, u32 flags,
> -				struct bpf_tramp_links *tlinks,
> -				void *func_addr)
> +static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> +					 const struct btf_func_model *m, u32 flags,
> +					 struct bpf_tramp_links *tlinks,
> +					 void *func_addr)
>  {

hum, I dont understand what's the __arch_prepare_bpf_trampoline for,
could we have just the arch_prepare_bpf_trampoline?

jirka

>  	int i, ret, nr_regs = m->nr_args, stack_size = 0;
>  	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
> @@ -2678,6 +2678,38 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	return ret;
>  }
>  
> +int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> +				const struct btf_func_model *m, u32 flags,
> +				struct bpf_tramp_links *tlinks,
> +				void *func_addr)
> +{
> +	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tlinks, func_addr);
> +}
> +
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	struct bpf_tramp_image im;
> +	void *image;
> +	int ret;
> +
> +	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> +	 * This will NOT cause fragmentation in direct map, as we do not
> +	 * call set_memory_*() on this buffer.
> +	 */
> +	image = bpf_jit_alloc_exec(PAGE_SIZE);
> +	if (!image)
> +		return -ENOMEM;
> +
> +	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
> +					    tlinks, func_addr);
> +	bpf_jit_free_exec(image);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret;
> +}
> +
>  static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
>  {
>  	u8 *jg_reloc, *prog = *pprog;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 548f3ef34ba1..5bbac549b0a0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1087,6 +1087,8 @@ void *arch_alloc_bpf_trampoline(int size);
>  void arch_free_bpf_trampoline(void *image, int size);
>  void arch_protect_bpf_trampoline(void *image, int size);
>  void arch_unprotect_bpf_trampoline(void *image, int size);
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +			     struct bpf_tramp_links *tlinks, void *func_addr);
>  
>  u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
>  					     struct bpf_tramp_run_ctx *run_ctx);
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5509bdf98067..285c5b7c1ea4 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1070,6 +1070,12 @@ void __weak arch_unprotect_bpf_trampoline(void *image, int size)
>  	set_memory_rw((long)image, 1);
>  }
>  
> +int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +				    struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static int __init init_trampolines(void)
>  {
>  	int i;
> -- 
> 2.34.1
> 
> 

