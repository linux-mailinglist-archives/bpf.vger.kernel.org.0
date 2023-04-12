Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADB6DF72A
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLN2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDLN2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 09:28:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143E6A40
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 06:28:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso12907066wmq.2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681306045; x=1683898045;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mmRBjnE+5jMO2xvU6ASHfM67DD3ZZge+9wZq6e0F68=;
        b=ZpSfYTFYiufEke2gGFSquiKowLG1jeR2Lx0WUBDFqv9YOUbUz6hGaCx7bprM//mq4/
         dTnsxsQqr8Yajl01HzbBNg2tsLVQrERcY1zk6HXL9qfbkTj/txf/jTq2esNYJmpghsHq
         JZPVf9CZx2LLXtpX0A57DPYCpA1SAnaDGhls8nSbWpmTAdL3yt7Tl6ym6Z1b7k4xsrjb
         v8st7yKaZmk6DmyyKvA5XFt4N07IgTIH54D3I2AbSNTa/adINTCjqggfsb9GZrWQdOR7
         Qo7el1a3wydXqJk7StMhDiR33tVrxn+vx8hZaZta/OaSscM1WaPt88MbOReFs7Z8zZ9q
         wzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306045; x=1683898045;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mmRBjnE+5jMO2xvU6ASHfM67DD3ZZge+9wZq6e0F68=;
        b=cpmVsmZoaI/np4OQ7o8atc6cr0fUtA88UsSgcejgS9GA8LhLeMkoFLUFNcXMTF/WH1
         b5To1Xc/MZ8628IFL+GbX7+iWiVmviqy/Hm5Plwrr73GLckXf4QpPJdkZ8ye8VXwnJ29
         37Wc3qqhExGu6qOSG/wMG+1RVzaN+Jka8FmY6Cn0rk02wiMGdOjL6bXfLiy1l0PFa/fu
         iS0sg4hVcYcHrLUDdkv9NdpE1Dg++HlLzbL+pGFEOApBCZcW6dHa1EFRtbxB9t2VxcTP
         my7ZgBbRViervyTWKAyuWrnuXsFgHfiA2Xsg5uW1HQ6iDbTMuSjyO0nEH/8LNwywOF6O
         iiEg==
X-Gm-Message-State: AAQBX9cZuDWHDOW0F1QBI96O2IEsvbBJivts/yFRzKspnfu9Z51b/bDx
        TZaZJ+bDICqQImQsNWQW0vnFRnjgK8HCaX34hF/YqA==
X-Google-Smtp-Source: AKy350a1IiABTRdfDQ/hd7uv3NzzsZ+kTyGueBt65A3/9CmK/QfUOuRVk87B1m4dKTILCUUHHwf9Hw==
X-Received: by 2002:a05:600c:2941:b0:3ed:2eb5:c2e8 with SMTP id n1-20020a05600c294100b003ed2eb5c2e8mr11928494wmd.10.1681306045408;
        Wed, 12 Apr 2023 06:27:25 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:53b:acfc:bce0:dc7d? ([2a02:8011:e80c:0:53b:acfc:bce0:dc7d])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ef36ef3833sm2540483wmo.8.2023.04.12.06.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:27:24 -0700 (PDT)
Message-ID: <3f952aed-0926-eb26-6472-2d0443c1a0ff@isovalent.com>
Date:   Wed, 12 Apr 2023 14:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] bpftool: fix broken compile on s390 for linux-next
 repository
Content-Language: en-GB
To:     Thomas Richter <tmricht@linux.ibm.com>, hca@linux.ibm.com,
        bpf@vger.kernel.org, linux-next@vger.kernel.org
References: <20230412123636.2358949-1-tmricht@linux.ibm.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230412123636.2358949-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-04-12 14:36 UTC+0200 ~ Thomas Richter <tmricht@linux.ibm.com>
> Commit 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> breaks the build of the perf tool on s390 in the linux-next repository.
> Here is the make output:
> 
> make -C tools/perf
> ....
> btf_dumper.c: In function 'dotlabel_puts':
> DEBUG: btf_dumper.c:838:25: error: '__fallthrough' undeclared \
> 		(first use in this function); did you mean 'fallthrough'?
> DEBUG:   838 |                         __fallthrough;
> DEBUG:       |                         ^~~~~~~~~~~~~
> DEBUG:       |                         fallthrough
> DEBUG: btf_dumper.c:838:25: note: each undeclared identifier is reported \
> 		only once for each function it appears in
> DEBUG: btf_dumper.c:837:25: warning: this statement may fall through \
>                 [-Wimplicit-fallthrough=]
> DEBUG:   837 |                         putchar('\\');
> DEBUG:       |                         ^~~~~~~~~~~~~
> DEBUG: btf_dumper.c:839:17: note: here
> DEBUG:   839 |                 default:
> DEBUG:       |                 ^~~~~~~
> DEBUG: make[3]: *** [Makefile:247: /builddir/build/BUILD/kernel-6.2.fc37/\
> 		        linux-6.2/tools/perf/util/bpf_skel/ \
> 		        .tmp/bootstrap/btf_dumper.o] Error 1
> 
> The compile fails because symbol __fallthrough unknown, but symbol
> fallthrough is known and works fine.
> 
> Fix this and replace __fallthrough by fallthrough.
> 
> With this change, the compile works.
> 
> Output after:
> 
>  # make -C tools/perf
>  ....
>  CC      util/bpf-filter.o
>  CC      util/bpf-filter-flex.o
>  LD      util/perf-in.o
>  LD      perf-in.o
>  LINK    perf
>  make: Leaving directory '/root/mirror-linux-next/tools/perf'
>  #
> 
> Fixes: 9fd496848b1c ("bpftool: Support inline annotations when dumping the CFG of a program")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 6c5e0e82da22..1b7f69714604 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -835,7 +835,7 @@ static void dotlabel_puts(const char *s)
>  		case '|':
>  		case ' ':
>  			putchar('\\');
> -			__fallthrough;
> +			fallthrough;
>  		default:
>  			putchar(*s);
>  		}

Also reported by Sven Schnelle, and discussed at
https://lore.kernel.org/all/yt9dttxlwal7.fsf@linux.ibm.com/.

This is for linux-next, it cannot go through bpf-next given that commit
f7a858bffcdd ("tools: Rename __fallthrough to fallthrough") is not in
there yet.

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
Quentin
