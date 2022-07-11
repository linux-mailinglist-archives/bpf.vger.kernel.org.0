Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0F570CEE
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 23:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiGKVnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 17:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGKVnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 17:43:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65F85D7B;
        Mon, 11 Jul 2022 14:43:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so11050932ejb.4;
        Mon, 11 Jul 2022 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgIah/WzMnKhRRHSrerKHP0CE4Q2RBXBqax3bRA8pj4=;
        b=LvvKbFgz+BMiBQfnPqEd4ysVHmd+ca6zHkm+eOPznjEiQRLLM6MSzeMUZm96LFJCkN
         lmHult8YMT9K0Mq5Fi0ScdjSW8t5WBXpS5LATBJhHBgWL/e8BgJK21BX0PImfJjlnDUe
         Wt4uPKcD0k8PKnHvIv5lGVBMzueo762GDU1EcSIBUSYJgPZIkGvyIHYYpn5wKpfe9gbQ
         f9WzGesmGdlnYy9wdklVCRup3IVt3iNb2/98DCYl5zB5FxVBKlx8ghsRqEcLwo+QEdxk
         KNB6wz3WhRr8ODtNZLIf7+btC254WVlrrbMl0/i25ASQbw2/b3VDyoAf7sOqEor00l1Z
         e5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgIah/WzMnKhRRHSrerKHP0CE4Q2RBXBqax3bRA8pj4=;
        b=kJx0kFyFN74NAauuqmGS/URblfpsfBuMTIIIBJpvxaF0QncALLVGvEPdPRGH1sCZkp
         o2JxPeJHMXjWgEF+vI0TUIpUI9UyXE+elZ5//x3Xdm12+pIioy5eQ+EOz3C5epHIa7Q+
         Uy1auNlAIqhlE3Iku5ZpZ4EE43ys7b3uL3UL3jwZ2bhmI8ab/jZhRYw4jC5a1xKJbVDp
         uOAMq7ULOpNRhkWWYJ14CHuSKZ4pBcCkr8i9JXCWw1+cPieq21zis2FKuoQO6ALA5/QZ
         0e2G2q0TsHOoVDdZF/dvD4kcvJGGjHUfq3uAnDFn82DnX7MKiHJhOlPHyYWaiiWroFEl
         Wd3w==
X-Gm-Message-State: AJIora8P27Czn8RUH/VosEPl2k2aEZma3LCFpPgHqzj+aB8nUE9/yvrD
        RNfo4tYdMGRqVd7AZa76cJo=
X-Google-Smtp-Source: AGRyM1vW0qWN8yJW3sjsNtiOBO7TER09cpxV3ljVD2sem1Oik+Zcu2rqOc4ul+LoY+IiD6pzk6kMHQ==
X-Received: by 2002:a17:907:7d91:b0:72b:4d74:f4f6 with SMTP id oz17-20020a1709077d9100b0072b4d74f4f6mr9164329ejc.314.1657575795252;
        Mon, 11 Jul 2022 14:43:15 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00705cdfec71esm3106114eja.7.2022.07.11.14.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:43:14 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 23:42:59 +0200
To:     Fedor Tokarev <ftokarev@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: btf: Fix vsnprintf return value check
Message-ID: <YsyZY/tFm3hi5srl@krava>
References: <20220711211317.GA1143610@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711211317.GA1143610@laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 11:13:17PM +0200, Fedor Tokarev wrote:
> vsnprintf returns the number of characters which would have been written if
> enough space had been available, excluding the terminating null byte. Thus,
> the return value of 'len_left' means that the last character has been
> dropped.

should we have test for this in progs/test_snprintf.c ?

jirka

> 
> Signed-off-by: Fedor Tokarev <ftokarev@gmail.com>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index eb12d4f705cc..a9c1c98017d4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6519,7 +6519,7 @@ static void btf_snprintf_show(struct btf_show *show, const char *fmt,
>  	if (len < 0) {
>  		ssnprintf->len_left = 0;
>  		ssnprintf->len = len;
> -	} else if (len > ssnprintf->len_left) {
> +	} else if (len >= ssnprintf->len_left) {
>  		/* no space, drive on to get length we would have written */
>  		ssnprintf->len_left = 0;
>  		ssnprintf->len += len;
> -- 
> 2.25.1
> 
