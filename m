Return-Path: <bpf+bounces-6066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE37651E4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732732822D2
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5D156E1;
	Thu, 27 Jul 2023 11:01:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767CAD2E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 11:01:49 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B11FEC;
	Thu, 27 Jul 2023 04:01:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso38725566b.1;
        Thu, 27 Jul 2023 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690455706; x=1691060506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHfvgh8rSSrdkQk5e+JkE++Yn7WaF+CVtRWpok9XC9Y=;
        b=bRqxGL26+Cd4UDJMsCRgvHHMbT81l6+oh+WQ2BqDYUGtTo2K3iTnsbNqccRgY/Byz/
         vPTwqRRFSrPzJpytHiM28SzqGji9BPWO15KZPEvup3CQnvFvmTFzESAYuHycDgwKiPCa
         MuoOQdSAgoLgmr2wkrqPECTLGd8mdI9SeZj5LBE14vMx2qYPhrwXbcO5UuyWNGtiOIck
         jky8AGRxvfIKKr+qHyZ/JqPG/hpATQmDozL0O6tSm37W5PUT3XnjWVSwTUEOyFc6lK/b
         rQUV+kox2Rs5IBQ/Ic1X9hohq1x4QWvZtt7SGI4bbL4TXB0mQsE39lHid+Bg8EsQFvDc
         4wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690455706; x=1691060506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHfvgh8rSSrdkQk5e+JkE++Yn7WaF+CVtRWpok9XC9Y=;
        b=Ai37Gn0oqMZSQFFHmyvY76jf+oXyHPAFRnorri+ylwa30ZRjlYnEK0rIfDK9F3E4lj
         acpEMEOsqYTnLS4v2jcgEJCShioS+Kk/hKcR1UDrXr0kXkXUfsR9nhZO92E8jqFgrdSf
         /0JUZIo1BfE8wgerFzcAEj0c2QWHg8mVS1RSz73uSNAfqtbzvQrnqrVC+UM01ufIYMzj
         n6085oedJ6vRwSV3pMG8lW4Oi+jAoHtMY77xrM40ZAYh3iWc8UFCQdjQkeHlY6QA4Bze
         C0V/Zw927PhJLzHlrjvLVxNRRNGF83IfmeyPjEGGg98NcTZuSzwozohHl4vq41Esjh77
         QwBw==
X-Gm-Message-State: ABy/qLbKZfFQdKrpLNU8e5rh2XI21xGfK4zG+WSn6tS1H72wLmwxnH4g
	W7ctKxiZmOhlHWBPPbTerKtTmNH5JcY=
X-Google-Smtp-Source: APBJJlHcPaJ1NwM9+BwKxljX/Y1e7qZR3xAoj+zouHwkhYPy0b2mQN0JduuiJF3a/uJPaZ2Eq8zdWw==
X-Received: by 2002:a17:906:10cd:b0:99b:d243:157c with SMTP id v13-20020a17090610cd00b0099bd243157cmr1845316ejv.31.1690455706292;
        Thu, 27 Jul 2023 04:01:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0099bd86f9248sm631649eju.63.2023.07.27.04.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:01:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 27 Jul 2023 13:01:43 +0200
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off'
 may be used uninitialized"
Message-ID: <ZMJOl5uLrK9rucXB@krava>
References: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 04:25:36PM +0800, Xiangyu Chen wrote:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
> 
> When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
> and following warnings would be reported as below:

curious, what's the gcc version? I can't reproduce that,
and we already have all warnings enabled:

  CFLAGS += -Werror -Wall

they seem like false warnings also, because ARRAY_SIZE(pads)
will be always > 0

jirka

> 
> | btf_dump.c: In function 'btf_dump_emit_bit_padding':
> | btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> |   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
> |       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |   917 |      in_bitfield ? new_off - cur_off : 0);
> |       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> |   929 |   if (bits == pad_bits) {
> |       |      ^
> | btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> |   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
> |       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> |   HOSTLD  scripts/mod/modpost
> 
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>  tools/lib/bpf/btf_dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 4d9f30bf7f01..79923c3b8777 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>  	} pads[] = {
>  		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
>  	};
> -	int new_off, pad_bits, bits, i;
> -	const char *pad_type;
> +	int new_off = 0, pad_bits = 0, bits, i;
> +	const char *pad_type = NULL;
>  
>  	if (cur_off >= next_off)
>  		return; /* no gap */
> -- 
> 2.34.1
> 
> 

