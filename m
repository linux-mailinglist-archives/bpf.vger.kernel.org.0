Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6041A65B
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhI1ERQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 00:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhI1ERP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 00:17:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBCBC061575;
        Mon, 27 Sep 2021 21:15:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b22so2488266pls.1;
        Mon, 27 Sep 2021 21:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VI+ZU/Nf/rOy+J3o4BitX8Vfb8OfZokjm3NDK+58vhQ=;
        b=DmF7WyAwM5lNWtaI4ejkkaqbFq+vb4KQHiPYzvZWUDIDYDKFa7u7+0JuuONExLlGQ0
         +C40WGzP5RdXyk6P8r7fU5y/mMNZSWv99TBU/2dIsJ4RhcSp8o4dg1ESAHcP9FVN3hWG
         JDMPbLzzeNfH3Ia9rEdt2y5SF3OnVJHKWqE7s7xN5d78rTihO/a+AIWP7xdFeHujAm4W
         5wV1RNNn4fLgRSp+ne8rYGT9guiKM327w5iSkC4M9kefPpr7UFK1MXJ78al28Unr73/q
         3lF+jK8c+OBi4XNYes9WbuygxWaVrTXdInSnokBO5cnrlot12pwPVDmp/70pDEEmwbeI
         yFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VI+ZU/Nf/rOy+J3o4BitX8Vfb8OfZokjm3NDK+58vhQ=;
        b=ce/UL+GBK2sJS0r4o04v/csFW3PI1CnT/OVKt06HT0k9BvOOoc466eNoddgQwwnYTV
         EAyXsE+zuSB8ahFEdseWxpyJqUhv8b4QAnrjsMRn+IQcvqgPMEtS3Ty5eB4Wha31ivtA
         4uFKIEL+3NXEH/uK9XGvCH0MYu/6k9Dcbzo90julJw03K9/Fs8jEnPWUkaH6UVmm7Sfe
         MyvGTg1QioSJds267MOOvISiujNry2b0gTn1D9lZeJa0YufS0LExvnLJFcaawy14O0G8
         BoJEso7p/kIZlDn1mQtJ47qw+qk4ZDItbHOhmRrRt0UZqrgesBW5h804o2hLK1cFuETE
         ItFA==
X-Gm-Message-State: AOAM533ihaHxUQiWdpE8c8FLezP/sH7whPrRWOg5yQYMyQZ5tzsJHFt8
        1+cGLJb8O+5/3q5a95X5EFU=
X-Google-Smtp-Source: ABdhPJzvtvTgKK5LGuGTtY6DrNMY7abSfjkrsPwuSRDUT6yT4TM0bFNfgjOIrhvbWcd7tYXbONZILA==
X-Received: by 2002:a17:902:7d8c:b0:13d:e593:cdf3 with SMTP id a12-20020a1709027d8c00b0013de593cdf3mr3211249plm.28.1632802536639;
        Mon, 27 Sep 2021 21:15:36 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id w206sm18520417pfc.45.2021.09.27.21.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:15:36 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:45:34 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] samples: bpf: fix test_lru_dist
Message-ID: <20210928041534.dee5uqoz7ymrzfbr@apollo.localdomain>
References: <20210928023816.14488-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928023816.14488-1-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 08:08:16AM IST, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
>
> Fix this build error:
>
>   CC  samples/bpf/test_lru_dist
> samples/bpf/test_lru_dist.c:36:8: error: redefinition of ‘struct list_head’
>    36 | struct list_head {
>       |        ^~~~~~~~~
>

Description does not match the fix?

> This happens even after running `make headers_install`
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  samples/bpf/xdp_redirect_map_multi.bpf.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
> index 8f59d430cb64..bb0a5a3bfcf0 100644
> --- a/samples/bpf/xdp_redirect_map_multi.bpf.c
> +++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
> @@ -5,11 +5,6 @@
>  #include "xdp_sample.bpf.h"
>  #include "xdp_sample_shared.h"
>
> -enum {
> -	BPF_F_BROADCAST		= (1ULL << 3),
> -	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
> -};
> -

I sent what is hopefully the right fix for this in [0], also see [1] for
background.

[0]: https://lore.kernel.org/bpf/20210928041329.1735524-1-memxor@gmail.com
[1]: https://lore.kernel.org/bpf/87mtnyj9d4.fsf@toke.dk

>  struct {
>  	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
>  	__uint(key_size, sizeof(int));
> --
> 2.31.1
>

--
Kartikeya
