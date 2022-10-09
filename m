Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8B5F8B5A
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJIMxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJIMxu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 08:53:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28308B492;
        Sun,  9 Oct 2022 05:53:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d26so12841610eje.10;
        Sun, 09 Oct 2022 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZESD6ey7LAoCvYqteYGKHRcvT5xH2VgJgOZK6wnuVJU=;
        b=e47bf7q8ORFWnHRIliB9uWOqvqtG3S3kBFknWpss4c43ofG8tCdrrlYtL58iSXRY18
         b/4QSouKbAmdBGaiq8ALf0RB+yY2d5XiF5FGxh8dsVyKKYYV0yLQb1igTeEaUyUZqH8S
         Pw+hm4PpC/lR2adpL1AX76ToB/ax5xPrRId8ivI76kOFbCsCPYo8q1P/Rhz7YuvOMzdF
         MGz7XKDjUQYgfCws6hM9vylH4b4+BgxmZa0ia+oCgeVoyhYacBnB+Kmw7T1uVBwDWJOv
         +/TzLofMv1+OaQk/nDbc4mCVBPhlr+E0eSjff3qAxHrD+mMGTw35sx0UruuxEBDajk4X
         3hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZESD6ey7LAoCvYqteYGKHRcvT5xH2VgJgOZK6wnuVJU=;
        b=Hh9R7zxDJZEhNneemrFkSAbyE9+CL3LdV3YK03ireSDpcdYairwHaW0PSTAjMtsE51
         Pog+tqQZdBpQcfB4nrVUZrgT2gSCCAeeAN7v5rMYcWaKPE50Pkeyjh3olR0d4GZHygGt
         dxlF20LdvNOf5mNjz8hRlvSgBOtSvHUDaEAY2+0Jj9TOwKhMBdnRkORpY6QzN1i//2WR
         xG+WGNtg5uW4WKcYTDdFgmF2E7Et999EkyPv+yQjIfv4PENnyvBY+dB3mKMeuQawWmoc
         TB2oomL5qd1BwVlsNqE2co89Qhf9Uc1rH060agIOdQrlvr/asxJ6qAVu7XW7LmGXg+RI
         AJNQ==
X-Gm-Message-State: ACrzQf3gStD97q0/C0f8hbRUq04c7m8ZEI3lt3WB5AHEkMIlfd968N2P
        DtASi9yUEYQUIpeY6zWlP3k=
X-Google-Smtp-Source: AMsMyM5QFoJMnh9+uhemwsIEXhMTcAfJqGRhBbH2BAqIf/LU/boRfqSxotDU3R/rhI3Cng/USX8iFw==
X-Received: by 2002:a17:906:1e08:b0:73d:c724:4876 with SMTP id g8-20020a1709061e0800b0073dc7244876mr10975002ejj.62.1665320027534;
        Sun, 09 Oct 2022 05:53:47 -0700 (PDT)
Received: from krava ([83.240.62.156])
        by smtp.gmail.com with ESMTPSA id i24-20020a50d758000000b00458a03203b1sm5146741edj.31.2022.10.09.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 05:53:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 9 Oct 2022 14:53:42 +0200
To:     Li kunyu <kunyu@nfschina.com>
Cc:     lkp@intel.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, kbuild-all@lists.01.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH] lib: bpf: Optimized variable usage in the btf_parse_elf
 function
Message-ID: <Y0LEVuvk/O93xBAn@krava>
References: <202210082050.nPzAbV1v-lkp@intel.com>
 <20221009070827.525694-2-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009070827.525694-2-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 09, 2022 at 03:08:28PM +0800, Li kunyu wrote:
> The following changes were made in the btf_parse_elf function:
> 1. The initialization assignments of err, fd, scn and elf variables are
> removed, and they do not affect function security after analysis.
> 2. Remove unnecessary assignments to err variable (-error).
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  tools/lib/bpf/btf.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d14f1a52d7a..fa9d5fa03da4 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -910,10 +910,10 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>  				 struct btf_ext **btf_ext)
>  {
>  	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
> -	int err = 0, fd = -1, idx = 0;
> +	int err, fd, idx = 0;
>  	struct btf *btf = NULL;
> -	Elf_Scn *scn = NULL;
> -	Elf *elf = NULL;
> +	Elf_Scn *scn;
> +	Elf *elf;
>  	GElf_Ehdr ehdr;
>  	size_t shstrndx;
>  
> @@ -924,9 +924,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>  
>  	fd = open(path, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
> -		err = -errno;
>  		pr_warn("failed to open %s: %s\n", path, strerror(errno));
> -		return ERR_PTR(err);
> +		return ERR_PTR(-errno);

hum, pr_warn could potentionally change errno

jirka

>  	}
>  
>  	err = -LIBBPF_ERRNO__FORMAT;
> @@ -987,8 +986,6 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>  		}
>  	}
>  
> -	err = 0;
> -
>  	if (!btf_data) {
>  		err = -ENOENT;
>  		goto done;
> -- 
> 2.18.2
> 
