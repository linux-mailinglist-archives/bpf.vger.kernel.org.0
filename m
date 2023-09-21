Return-Path: <bpf+bounces-10542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943CA7A9901
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305A7B21427
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BA3B2A1;
	Thu, 21 Sep 2023 17:22:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191542C1C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:22:48 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184B573EA
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:18:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so876070a12.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316719; x=1695921519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yMqq3AARWyXbrKYJTzEmeS3BTtZYH6TPZAZzIFbUV54=;
        b=LW9lJsOg+/WNPL7P8AncNyXJQSYPUBqhAhWyYaGpuiheXkEpOEJLjRDiaYltslabON
         wYiM2IWjQUJT2giLYr6y2iH+8oZzksvXLZkIDfV7yNJjjqPVb/ZWb6ZblPCI1+LPwL2h
         SePEHehO4jjy29AJ6Wee0PJFQVAKaPMM53cNkmHbqBRv8Uvu94gQ/nYCICjxnonrWrjY
         v41A/x/al1koXziVwnfRzvFDiHPE4HOFOK25ZYU7zJ9+fBl3/cxkscCBtanNDkNDcBEo
         uU7VV8a1WexRClviLxJkFtrtQCa/qX36gQFSckuf802QngJadjNVK69hcBhSnyW7Mbfs
         mtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316719; x=1695921519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMqq3AARWyXbrKYJTzEmeS3BTtZYH6TPZAZzIFbUV54=;
        b=D4GXdbCjAV5NB1avOmXd/u13jBFFJEXdIv1mPuiDar4NNYIVZT3jqbj5pqENMnD334
         zEWPe64jvVz2I3BVhH8L+JS2QQR3FWlNo8MQEB47lWosuzffpLDIUa1obwxtJY16j7fI
         4FKFERjwA+rfpbc2M1/v6DhgF2Wq39nwR6aWIrdm79FPQ7KUndzbdZkLKuKJcNzEPryf
         2nuEKAcT0rr/MEtf94HJpsVkPIP/z76VrdkUkq1QODMAKCvnQ083Rc/yrgQKtXAgTaRa
         Zazjz+NBnzwd+ra+2JzhQ8o/5YElj6h4KJh3QeIpans/YuO1l5mp9CtNDwaiydgomRpC
         BpKA==
X-Gm-Message-State: AOJu0Yx//2VjVgi5upcZWwiznFkjOgHuHjpSz7BhGhTvXyzGZ3QESFBc
	f4E1n5TlLEVCsMKF8Pb1h4D0KTl7svSM6Q==
X-Google-Smtp-Source: AGHT+IE+s97P4m34QaccumoMdNCG8UtnFMnnXoz9nFrCZzywQN7Ck2Ou4bxfI2poENfWa35STXH38w==
X-Received: by 2002:a17:906:5386:b0:9a1:be50:ae61 with SMTP id g6-20020a170906538600b009a1be50ae61mr4653539ejo.69.1695305236375;
        Thu, 21 Sep 2023 07:07:16 -0700 (PDT)
Received: from krava (253.252.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.252.253])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906970f00b0098733a40bb7sm1090358ejx.155.2023.09.21.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:07:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Sep 2023 16:07:13 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Message-ID: <ZQxOEVFUFFgYpqtx@krava>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:31:56PM -0700, Song Liu wrote:

SNIP

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

this can be just 'return ret;'

jirka

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

