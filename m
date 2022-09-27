Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D275EBF9B
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiI0KV1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiI0KVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 06:21:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B2D4A96
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 03:21:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5167437wmq.1
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vgh002MbzGIvX+WNWBnASqpqcHfioqqk7UDCUr0BcD0=;
        b=c8x5vdCdVwrSPGUJ1zvOAX9uZUIiOuP+7WTSPGV0j+E5BC2CTlKzoCNqDCQK0dcCRJ
         RUvuyPK/+wwRCIZb1QH3UTRCnfH3yV8f8O64CKllJKBV8wUzPtHXJZeeHaJ0ARHobGmV
         pyK64xm5laaM1/dinPPzsezrdg22/KQc8PfkluC6Z1bg06nMaKYjsgKQBHJcQA6jBk+k
         1gUWEj5rPDlnsM6dKUFiOq+IzDP73Xo41tfX3G3BBlRZkaROLNOS0/wPk/ZaNsy6QfLn
         UmoyajtfWyLolR2Q4ZKet6eJQfNScXlzkaZ7rcj6Mj3ZioSuSC9cP7bnwo4XjnPmpztJ
         QTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vgh002MbzGIvX+WNWBnASqpqcHfioqqk7UDCUr0BcD0=;
        b=NX7PsDqu4MsFd8M2nuVUfq4JI//aQ6JozKCOi97bgE3SfUzzWIl0kbT1Lb5Xt5SF3t
         Q9AVVX+OqWlkj7IB7YNZlqbMIONjelpfgfGN7ZfbksfdVmkx1pzFn5OPKBQJHTd9sfe9
         dD10QPugaiLekIGvW4DGtOkC+Blgm3xZko9tmA/vnZ8332gCVYyHBKkdxlnR+srOPQfT
         r8JxSDaFFNGxh60uzO5sAwskINyMPp3VQ++2EfqyG+b/uoTOnjkLlz1VyPAWissipqj+
         MQBkY84KcHzj/txZYelIQe68QSGXnGako8dZwo9bUFJ2NcsN20QGX8rwrqLPRvQv4Biu
         DZwQ==
X-Gm-Message-State: ACrzQf1MfQPRbSV0cYDvPt+DC0iyAp7xUqdN5Ho2dNungr1V4amZQXXs
        68sdxFmApKwWrZ/dknsvDZIYug==
X-Google-Smtp-Source: AMsMyM5KigCTNRehqfnJPf5L8G60+lZ4zECOx1Of9PDTtLY1fplC++hd5EXvPKgw9T2j3xArGysK3A==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr2137807wmb.50.1664274082579;
        Tue, 27 Sep 2022 03:21:22 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4809000000b00228b3ff1f5dsm1503944wrq.117.2022.09.27.03.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:21:21 -0700 (PDT)
Message-ID: <c5c5cedb-4b32-2569-1d55-fc95cad1b260@isovalent.com>
Date:   Tue, 27 Sep 2022 11:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] libbpf: add fPIC option for static library
Content-Language: en-GB
To:     Xin Liu <liuxin350@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
        zhudi2@huawei.com, kongweibin2@huawei.com
References: <20220924101209.50653-1-liuxin350@huawei.com>
 <20220924101209.50653-2-liuxin350@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220924101209.50653-2-liuxin350@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sat Sep 24 2022 11:12:08 GMT+0100 ~ Xin Liu <liuxin350@huawei.com>
> Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,

Typo "depned"

> this will cause a similar error at compile time:
> 
> /usr/bin/ld: .../libbpf.a(libbpf-in.o): relocation
> R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which
> may bind externally can not be used when making a sharedobject;
> recompile with -fPIC
> 
> Use -fPIC for static library compilation to solve this problem.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 4c904ef0b47e..427e971f4fcd 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -91,9 +91,10 @@ override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
>  override CFLAGS += $(CLANG_CROSS_FLAGS)
> +override CFLAGS += -fPIC
>  
>  # flags specific for shared library
> -SHLIB_FLAGS := -DSHARED -fPIC
> +SHLIB_FLAGS := -DSHARED
>  
>  ifeq ($(VERBOSE),1)
>    Q =

Hi, the two patches look OK to me, but it would be nice to have a bit
more context on what the flags do other than “fixing this particular
issue” and how they improve bpftool security. It would also be
interesting to have a note on what it does on various architectures, my
understanding is that only some archs are supported (I read AArch64,
m68k, PowerPC and SPARC), I guess the flags are silently ignored on x86
for example?

Thanks,
Quentin
