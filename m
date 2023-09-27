Return-Path: <bpf+bounces-10964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55B7B050D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 68ADB281E39
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C530CEE;
	Wed, 27 Sep 2023 13:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FAC8E2
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 13:16:17 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF0F4
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 06:16:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503397ee920so17612948e87.1
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695820574; x=1696425374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoWVYE4kCO6g2gKoZjMNIrmI16Dk775CN/XT8WGdOy8=;
        b=l9BNTzttY2VyzyW6zuLJJ8pjfmrnyO9m1XpmL5X4jfJuI1bPJvmfXWTZjy0KY2BYBq
         YFUKMX3C6JE+ONxqICxaT3kQ96Nxi83Hvc6I8VAGlSPI4QMSWfoSW3jH8Uav/hSMuLQg
         QvLWpuYlEKX8VThTAElS+2enyHLeI05lxKrY7ClY4xX6M/xQ/d4z5QycNwUDzZxSf5pT
         717apWBb+Ls9gUxcCSEHtRMGBe7W9CoiX7QklPm0NZyvJY3N5TwwjBHLawkGRD84QQ3i
         JEbKsWJpgLEYMAsVZO32C+nf2jlTpsKbdpWd+MjXcgMbZYPyyBFa9wozfMzPpL58Zbu4
         wagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820574; x=1696425374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoWVYE4kCO6g2gKoZjMNIrmI16Dk775CN/XT8WGdOy8=;
        b=uMKEVCmoMLnzEC/CMEPl7AkBD7zoy6TWC/rR5l6ZbFWbNOWIQ7+cLhBzu1PoWf54SF
         u03zjRj9dZvpmgj/mob1/KmJJVUCsqtmJWvjMgsmY4JRrb5TM8bXL/G6PTZqNAMwuCjm
         sxZyNWGWx+XNTK6F3dLG4i7smLEILVH9gxZvF5csHej5Ee/aqtuOIXxK8QmAKfhPUcH7
         vvy3tciGHIrqcffpPUn4aqODw0mvgi1oiaVP5zof7lN6RClw88tx6Fw3QBVwB/mwg1JX
         Mfs9aPg2WsXCS95oaP7/yL4bgQI/hDoo2y7FJIWeSsUZeMi5AaMsLbUjDFSGDDPGT4PJ
         iA7Q==
X-Gm-Message-State: AOJu0Yx8oeoBPl52TeuwOw3/e7WY5pjpi6p36pg2ba3fC8ba9kwvdNo2
	MwgeTCGmwNwDhOJQhY+4szfVPUH2xxE=
X-Google-Smtp-Source: AGHT+IEdTZ5hjG5sN64b7HR14x8eVgA6TA3H5cI/kUjqQu/7pN4JYWrOG/gxw9tfLvDJSATNgjPgzg==
X-Received: by 2002:a05:6512:3b14:b0:503:3756:9ff1 with SMTP id f20-20020a0565123b1400b0050337569ff1mr2050882lfv.49.1695820573468;
        Wed, 27 Sep 2023 06:16:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7cf02000000b005232ea6a330sm8196720edy.2.2023.09.27.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:16:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Sep 2023 15:16:11 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
	iii@linux.ibm.com, bjorn@kernel.org
Subject: Re: [PATCH v3 bpf-next 8/8] x86, bpf: Use bpf_prog_pack for bpf
 trampoline
Message-ID: <ZRQrG7ve8MRKD6xT@krava>
References: <20230926190020.1111575-1-song@kernel.org>
 <20230926190020.1111575-9-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926190020.1111575-9-song@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 12:00:20PM -0700, Song Liu wrote:

SNIP

> @@ -2665,25 +2672,61 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
>  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
>  		/* skip our return address and return to parent */
>  		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> -	emit_return(&prog, prog);
> +	emit_return(&prog, image + (prog - (u8 *)rw_image));
>  	/* Make sure the trampoline generation logic doesn't overflow */
> -	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
> +	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
>  		ret = -EFAULT;
>  		goto cleanup;
>  	}
> -	ret = prog - (u8 *)image + BPF_INSN_SAFETY;
> +	ret = prog - (u8 *)rw_image + BPF_INSN_SAFETY;
>  
>  cleanup:
>  	kfree(branches);
>  	return ret;
>  }
>  
> +void *arch_alloc_bpf_trampoline(int size)
> +{
> +	return bpf_prog_pack_alloc(size, jit_fill_hole);
> +}
> +
> +void arch_free_bpf_trampoline(void *image, int size)
> +{
> +	bpf_prog_pack_free(image, size);
> +}
> +
> +void arch_protect_bpf_trampoline(void *image, int size)
> +{
> +}
> +
> +void arch_unprotect_bpf_trampoline(void *image, int size)
> +{
> +}

seems bit confusing having empty non weak functions to overload
the weak versions IIUC

would maybe some other way fit better than weak functions in here?
like having arch specific macro to use bpf_prog_pack_alloc for
trampoline allocation

feel free to disregard if you have already investigated this ;-)

jirka


> +
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
>  				const struct btf_func_model *m, u32 flags,
>  				struct bpf_tramp_links *tlinks,
>  				void *func_addr)
>  {
> -	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tlinks, func_addr);
> +	void *rw_image, *tmp;
> +	int ret;
> +	u32 size = image_end - image;
> +
> +	rw_image = bpf_jit_alloc_exec(size);
> +	if (!rw_image)
> +		return -ENOMEM;
> +
> +	ret = __arch_prepare_bpf_trampoline(im, rw_image, rw_image + size, image, m,
> +					    flags, tlinks, func_addr);
> +	if (ret < 0)
> +		goto out;
> +
> +	tmp = bpf_arch_text_copy(image, rw_image, size);
> +	if (IS_ERR(tmp))
> +		ret = PTR_ERR(tmp);
> +out:
> +	bpf_jit_free_exec(rw_image);
> +	return ret;
>  }
>  
>  int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> @@ -2701,8 +2744,8 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  	if (!image)
>  		return -ENOMEM;
>  
> -	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
> -					    tlinks, func_addr);
> +	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> +					    m, flags, tlinks, func_addr);
>  	bpf_jit_free_exec(image);
>  	return ret;
>  }
> -- 
> 2.34.1
> 
> 

