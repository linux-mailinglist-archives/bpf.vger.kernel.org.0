Return-Path: <bpf+bounces-16924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447558078B0
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87089282158
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3913B47F56;
	Wed,  6 Dec 2023 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QksY5fA5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC98E
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 11:34:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-333630e9e43so155546f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 11:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701891241; x=1702496041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5e7Kyl9THdXz4ba1pKlKGv7cbWKsAgyo45L0ZqiBKo=;
        b=QksY5fA5ZQ8exXkXH1Lt9Jga1ckSvWSqVCRFjDH/Z1MmPbJLAeU2/0FUoWjzCjIS+c
         WqLfwyyliC2u+v9oj08XfSUbJvcFQ4cvkizTJ9LGXp6NrrB1trgmVglYfQ93V+RtfDoO
         h1ARQSM+seZSfJmLI/laVYOaTo4XuEPAwHv3oswC4lBaJyXhh7uGNiiWwiSxCDzcX4W4
         GT37at/i06eFaNFcO2o4DJBXtxJrqJPETZ97irzvGFPEp39rrNW3tDYNnHwY6kigF8G4
         QRsxFwRLXhGTNfbIdV+Q7ayLUnTRqt0rHBT/9l+kTpurn5fiTNT0gFgmln4hpGEg7Mew
         rB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891241; x=1702496041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5e7Kyl9THdXz4ba1pKlKGv7cbWKsAgyo45L0ZqiBKo=;
        b=BhkDEb9/aMoQt5EARPeAGlG8UKOdXoRp6HSzATGMnuUVv98nSaxWDK02YPlJhXOjkC
         nwnHAFG/pmKdKJulOTl++fvG4e67n4JcmYac5Z/rqVYKu2CoP+9JCltHaCjKbhzueBB0
         Yizg5EIxnWl/ZGe7+swk2JI4cueaRj93WgroG8tfGV7cU9J1XLo/mBFp4lHivr+jqFd4
         3Mm7iaQCP8oKh6HXYaUn2Tsufdy0ENV4+RhbG38bGfk5biqtv/sDg8MOTDTLcIdOKADS
         YaLEL3yFBAxJ4vMrMVaq8k1k0DiNgqjIRHFAEUhSI9mlnmeuYKQZw46jToa9hHRw3G2y
         B+aQ==
X-Gm-Message-State: AOJu0YzcUIRp+cWJXUGUqCVIkd11zrRVCFeiS87mR5RgXwCcIbMpkp0f
	lir24FKaWRLLvNV06bjPqa26kARR/PrQX94AFLpKcQXHHps=
X-Google-Smtp-Source: AGHT+IGKuyQl3Z3i40zZiaeZpxvZdR9kdnkIRdm6iXo6BY5lhtyOHBxYgvcpyFWgKoeKnZTHHDspH0e1cocaIHn/io0=
X-Received: by 2002:a05:6000:10c1:b0:333:2fd2:3bfe with SMTP id
 b1-20020a05600010c100b003332fd23bfemr603699wrx.183.1701891240674; Wed, 06 Dec
 2023 11:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201190654.1233153-1-song@kernel.org> <20231201190654.1233153-6-song@kernel.org>
In-Reply-To: <20231201190654.1233153-6-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Dec 2023 11:33:49 -0800
Message-ID: <CAADnVQ+_XZMVegPSN_xmA6C9Tx9UTQ0J-q=N6pv6RzbkVwBCEg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 11:06:52AM -0800, Song Liu wrote:
> +int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> +                          struct bpf_tramp_links *tlinks, void *func_addr)
> +{
> +     struct bpf_tramp_image im;
> +     void *image;
> +     int ret;
> +
> +     /* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> +      * This will NOT cause fragmentation in direct map, as we do not
> +      * call set_memory_*() on this buffer.
> +      */
> +     image = bpf_jit_alloc_exec(PAGE_SIZE);
> +     if (!image)
> +             return -ENOMEM;
> +
> +     ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
> +                                         tlinks, func_addr);
> +     bpf_jit_free_exec(image);
> +     return ret;
> +}

There is no need to allocate an executable page just to compute the size, right?
Instead of bpf_jit_alloc_exec() it should work with alloc_page() ?

Similar in patch 7:
int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void
*image, void *image_end,
                                const struct btf_func_model *m, u32 flags,
                                struct bpf_tramp_links *tlinks,
                                void *func_addr)
 {
-       return __arch_prepare_bpf_trampoline(im, image, image_end, m,
flags, tlinks, func_addr);
+       void *rw_image, *tmp;
+       int ret;
+       u32 size = image_end - image;
+
+       rw_image = bpf_jit_alloc_exec(size);
+       if (!rw_image)
+               return -ENOMEM;
+
+       ret = __arch_prepare_bpf_trampoline(im, rw_image, rw_image +
size, image, m,
+                                           flags, tlinks, func_addr);
+       if (ret < 0)
+               goto out;
+
+       tmp = bpf_arch_text_copy(image, rw_image, size);
+       if (IS_ERR(tmp))
+               ret = PTR_ERR(tmp);
+out:
+       bpf_jit_free_exec(rw_image);
+       return ret;
 }

In the above only 'image' has to be ROX. rw_image can be allocated
with kvmalloc().
Just like it's done in the main loop of JIT via
bpf_jit_binary_pack_alloc() -> kvmalloc() -> rw_header.

pw-bot: cr

