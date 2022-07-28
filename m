Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84195840D4
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiG1OPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 10:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiG1OPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 10:15:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEC4D4E3
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 07:15:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a11so1029885wmq.3
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=PmqGrKsQt7NxusCMw3WJnzIlzO39Xolz7zz2v+PNg6I=;
        b=EQTC2b1KHSVlk6R/1XHWnYv6hxxEqUQ3hSNJBQV/ijpr4RGEFY9sXY+b4T7QlodHk5
         O8JSAmOfE21aYDECRKHZ5iFJaAVDnjoz1L6O0/jibOKseGH/a1pN3F3mglk6IyrcKD9f
         5BortCaGoPL6x6xpw2QHo4cVkAIhd2MJbC+JUMh+Ro6fimqWI0cwiXwA1Q7u9XJf04Cp
         M8FJ/bBjNqvLFaAWbdi68joIghF+p1UAwCZboDQjz/v/OfFmwfcvZcAa7DRwueKprnCL
         YwAzYkKIWNnMJGXlDxGDCqZhxbsTHExXC1fsM0dGx6NOqaHqdIN8ElA7hC/FwCw64a8v
         F3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=PmqGrKsQt7NxusCMw3WJnzIlzO39Xolz7zz2v+PNg6I=;
        b=gP/Ru2OY/uM5vgZPclLitI/Pgf8qRpxybq5qJHr8F355NfO+iEfPCeDHdC/KnEqxu+
         pLR+sUsTrBS855bbqp+cXxTfG4I/LmTLqkfgXhWgLo+T3cyk18t+avZjBoN0fZB1EaEW
         ElJNejRy1xNcUFXTf3OOSbJylDMCAsDAgwDu0hm95iQ9BH0DS400GtK1AG/Fskrks0t4
         JXg6olOm+Qz88OtVppcnSQsd+cK6uwtIf4vKVWwHyHX8QVNVdOa8arfbxJ3vh8KnH2/r
         5zMuJXui6DqWT+ws9qxS4hb1sEf1asuFC2ZQuPHXhAI2KXCP7ufQdvieEuTihCd2vw5H
         HeNQ==
X-Gm-Message-State: AJIora/Aq51RjEEyuL5/w/F8bSZ/vtqkOEno3HhLCsDLhuSzEocm3/sA
        QLb+57s6fTd2ypWzGFSuANY=
X-Google-Smtp-Source: AGRyM1t0IIbO29/6yuZN8ROdmssOngo3+oBqXaBnDBt8hPoOhCG/ApwNcCP/vJHJ7wsyiVAeIegVHg==
X-Received: by 2002:a05:600c:3d88:b0:3a3:63ae:178c with SMTP id bi8-20020a05600c3d8800b003a363ae178cmr6547703wmb.92.1659017752347;
        Thu, 28 Jul 2022 07:15:52 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id j2-20020a05600c1c0200b003a30c3d0c9csm6360969wms.8.2022.07.28.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:15:52 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 28 Jul 2022 16:15:50 +0200
To:     David Faust <david.faust@oracle.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: avoid mmap for size 0 sections
Message-ID: <YuKaFiZ+ksB5f0Ye@krava>
References: <20220727204808.13210-1-david.faust@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727204808.13210-1-david.faust@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 27, 2022 at 01:48:08PM -0700, David Faust wrote:
> When populating maps in bpf_object__init_global_data_maps(), recognized
> sections with no data (e.g. a .bss with size 0) lead to an mmap of 0
> bytes which fails with EINVAL.
> 
> Add a check to skip mapping sections which are present, but empty.
> 
> Signed-off-by: David Faust <david.faust@oracle.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b01fe01b0761..4e7ceb4f5a27 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>  	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
>  		sec_desc = &obj->efile.secs[sec_idx];
>  
> +		/* Skip recognized sections with size 0. */
> +		if (sec_desc->data && sec_desc->data->d_size == 0)
> +		  continue;

nit missing tab indent

also we seem to check for size in bpf_object__elf_collect
before adding SEC_DATA/SEC_RODATA but not SEC_BSS

I think the check should be rather in bpf_object__elf_collect
before we add the desc for it

jirka

> +
>  		switch (sec_desc->sec_type) {
>  		case SEC_DATA:
>  			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
> -- 
> 2.36.1
> 
