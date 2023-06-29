Return-Path: <bpf+bounces-3740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F196742818
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471221C20323
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAAE12B60;
	Thu, 29 Jun 2023 14:16:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A50290C
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:16:19 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED13596
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:16:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so6173085e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688048176; x=1690640176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF4MPoUhcpQ47mq2xIf3lsE32kat+DEVVLvp7jbvGT4=;
        b=Hgkan+Jk+lnEkHYlHuL1X1HwRpUL/rMckHOQvOa3MugeivCm+Y5R3nD75ttHbgDvqr
         7v8aQSNRPCF+JTVArcyu2OnlMrfD4BkHcqyXdSUP7z+BBUXw87whJ3k1cBh5vF9G4Ron
         e+kHNuXNpEWC5ilT9v0RjBl4lXwiqmNOMdJXL1CfMwIe1Z7ygWofpK6W3dLV4AJQeD3S
         t3zKCbCS7etotcFSXO9lDXOVrx0Qouf+oMk274JKZNKIsxn0LDGeMhNb3dxhqgHkSAgA
         vZG5Lm7LY9y/Xyh5jwnky1YUeYGca2cjQ5XL3Hh56OQFMSX9mVCkxlSWU6fHoLXKJa0r
         p29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688048176; x=1690640176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF4MPoUhcpQ47mq2xIf3lsE32kat+DEVVLvp7jbvGT4=;
        b=HAE7AUdgjU2GW50XBxMsH34evpZoVho5Ou5SUQaIguRgDSXXFmYLjmbR0BcMuey061
         lQYYE9+ddZyclgIBDCnoxWet9BCha4uESOpMF2r+MrdP/iWCXioyO1eHsF2YRw1mOuZA
         bxc+7+dDMl6bq3BTXxUy4cNorHM4EhuuVEYs0pM4xFvnAjI9HTzIhEsDy+IarMR3K4wt
         /k1hV/2IIRZY7PtsXS6fZp/ZY5BGHbmGLfwT8eYl18fnuTJa8VafrUCdEtySHI+ikuFB
         m2O3I29sqNd6fEDstQjQp4WSWjBzDIo7NQts3R5uFlEyl5Ox/GRlNu4dQwVRjr+SBwu+
         HsyQ==
X-Gm-Message-State: AC+VfDyVI9D5LmK5MgRJiCC8gdNSDXc9yGupGV4d8rOAsTjvECuaJAt2
	4ryqhcJlJjzOxU3r/3nkPZMWeg==
X-Google-Smtp-Source: ACHHUZ6ljDiWXFyQK12m9Bb/88SSFku2OJhbIYFutBGbX/euMoYRCWTH+HTE6gRfndRa8ffF0WCMhA==
X-Received: by 2002:a05:600c:2050:b0:3fa:8422:158d with SMTP id p16-20020a05600c205000b003fa8422158dmr63429wmg.18.1688048176382;
        Thu, 29 Jun 2023 07:16:16 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003fb41491670sm9144526wmj.24.2023.06.29.07.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:16:16 -0700 (PDT)
Message-ID: <b3877772-0596-63f4-4f4e-2d83a8e0d96c@isovalent.com>
Date: Thu, 29 Jun 2023 15:16:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 8/9] bpftool: update doc to describe bpftool
 btf dump .. format meta
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-9-alan.maguire@oracle.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230616171728.530116-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-16 18:17 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> ...and provide an example of output.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-btf.rst | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index 342716f74ec4..6dd779dddbde 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -28,7 +28,7 @@ BTF COMMANDS
>  |	**bpftool** **btf help**
>  |
>  |	*BTF_SRC* := { **id** *BTF_ID* | **prog** *PROG* | **map** *MAP* [{**key** | **value** | **kv** | **all**}] | **file** *FILE* }
> -|	*FORMAT* := { **raw** | **c** }
> +|	*FORMAT* := { **raw** | **c** | **meta** }
>  |	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* }
>  |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* }
>  
> @@ -67,8 +67,8 @@ DESCRIPTION
>  		  typically produced by clang or pahole.
>  
>  		  **format** option can be used to override default (raw)
> -		  output format. Raw (**raw**) or C-syntax (**c**) output
> -		  formats are supported.
> +		  output format. Raw (**raw**), C-syntax (**c**) and
> +                  BTF metadata (**meta**) formats are supported.

Please fix the indent, we're using a mix of tabs then spaces here (I
should try to fix that one day).

Any chance we get a one-sentence description of the metadata format,
please? :)

>  
>  	**bpftool btf help**
>  		  Print short help message.
> @@ -266,3 +266,13 @@ All the standard ways to specify map or program are supported:
>    [104859] FUNC 'smbalert_work' type_id=9695 linkage=static
>    [104860] FUNC 'smbus_alert' type_id=71367 linkage=static
>    [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
> +
> +
> + **# bpftool btf dump file vmlinux format meta**
> +
> + ::

Missing blank line here

> + size 4904369
> + magic 0xeb9f       version 1          flags 0x0          hdr_len 24
> + type      len 2893508    off 0
> + str       len 2010837    off 2893508
> +

And please fix the indent here as well, the double-column should have no
indent but the example itself should have some (other examples on the
page use two spaces here).

Thanks a lot for the doc, and adding the example!

Quentin

