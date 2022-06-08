Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9A543978
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbiFHQtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiFHQtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30164140DD
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 09:49:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k16so29142529wrg.7
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=PzuOUchy9ZfZFjXNIc+ELR/UX4tjssvPKt2uKRrMCJE=;
        b=wYfGVrl1MI5uvtz/gvwJ2hiqqlimqnqmoJEsqjmpPfuE0mmmHR5Lj8txgVpcCxBY2i
         IVaCQ3bE63sgPgGv6nh19fk1QyJDraRDZ9ZgZtCo3tfLHH82olSQqtz5Z++uvbpRmJu8
         K9p8cyhYWHxuGZ/bkFdI9s53dLThptj5ZSfP8wGJoy5pFM66nEOlJmvlCQaOmJ+vdMQf
         9kMlPObjafvspSyC41879a7CzZysz3r+C2umkhCs8q1cCqdc8Xi9285fIakP8HMRJjTa
         AUG/fuQ9JdY6rNJ+iuWigCkoLPShHVfdiH3OWd6UBJZWGzVwtxebtru27pdV684WCHty
         yWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=PzuOUchy9ZfZFjXNIc+ELR/UX4tjssvPKt2uKRrMCJE=;
        b=tb5AOY3u28vQgqze0xvKlZtMLbRIGwccBopeSnsf6iTHKkwTpph1Bc6bMAfnxjVqeN
         QbnwffBfPqP894OJ03Sf6gcecuusr6R6ttgV0DEjEfdfcoqkPUkAfsGQBMhG+s7hXyoz
         Q2Plw43yblWy1m7Z6scGvoY8dRHEMc3wUN50gu6yqL+u7/YVykkRWvNX5/hO2JroJ5t3
         mjyLIgQqpYo8KovkbL4/bgYc7+dN7z+JmQ8W5RgWMvtcFC+fEeghOTpuA9VOtJFeON1D
         j3jb6BxlCHQLrEDD7UV83rMd4ln7XGONivaMvA1if/7QRz/CLnmpkaoDeInq0eyrROAf
         NJ7g==
X-Gm-Message-State: AOAM533uWShKzMaPvb0OuUbnYpvJBbr752OzJ+nf/nbVMXJYterPMfOl
        s69wp5f4SqgZkIu1YlSKw6zjrg==
X-Google-Smtp-Source: ABdhPJxvc81NCwNNijPtzC4PSfjvMFwObZpw2Fz4HaX07RbnN3nZuYLjcjonOT5gnbJdvnIX+Bs8Cw==
X-Received: by 2002:a5d:504d:0:b0:210:24fd:add1 with SMTP id h13-20020a5d504d000000b0021024fdadd1mr33765936wrt.630.1654706982655;
        Wed, 08 Jun 2022 09:49:42 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039482d95ab7sm25442574wmc.24.2022.06.08.09.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 09:49:42 -0700 (PDT)
Message-ID: <474e37a8-0ce2-9d2e-5632-755a0746c8a8@isovalent.com>
Date:   Wed, 8 Jun 2022 17:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] bpftool: Fix bootstrapping during a cross compilation
Content-Language: en-GB
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-06-08 14:29 UTC+0000 ~ Shahab Vahedi <Shahab.Vahedi@synopsys.com>
> This change adjusts the Makefile to use "HOSTAR" as the archive tool
> to keep the sanity of the build process for the bootstrap part in
> check. For the rationale, please continue reading.
> 
> When cross compiling bpftool with buildroot, it leads to an invocation
> like:
> 
> $ AR="/path/to/buildroot/host/bin/arc-linux-gcc-ar" \
>   CC="/path/to/buildroot/host/bin/arc-linux-gcc"    \
>   ...
>   make
> 
> Which in return fails while building the bootstrap section:
> 
> ----------------------------------8<----------------------------------
> 
>   make: Entering directory '/src/bpftool-v6.7.0/src'
>   ...                        libbfd: [ on  ]
>   ...        disassembler-four-args: [ on  ]
>   ...                          zlib: [ on  ]
>   ...                        libcap: [ OFF ]
>   ...               clang-bpf-co-re: [ on  ] <-- triggers bootstrap
> 
>   .
>   .
>   .
> 
>     LINK     /src/bpftool-v6.7.0/src/bootstrap/bpftool
>   /usr/bin/ld: /src/bpftool-v6.7.0/src/bootstrap/libbpf/libbpf.a:
>                error adding symbols: archive has no index; run ranlib
>                to add one
>   collect2: error: ld returned 1 exit status
>   make: *** [Makefile:211: /src/bpftool-v6.7.0/src/bootstrap/bpftool]
>             Error 1
>   make: *** Waiting for unfinished jobs....
>     AR       /src/bpftool-v6.7.0/src/libbpf/libbpf.a
>     make[1]: Leaving directory '/src/bpftool-v6.7.0/libbpf/src'
>     make: Leaving directory '/src/bpftool-v6.7.0/src'
> 
> ---------------------------------->8----------------------------------
> 
> This occurs because setting "AR" confuses the build process for the
> bootstrap section and it calls "arc-linux-gcc-ar" to create and index
> "libbpf.a" instead of the host "ar".
> 
> Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
> ---
>  tools/bpf/bpftool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index c6d2c77d0252..c19e0e4c41bd 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -53,7 +53,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
>  $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
>  	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
>  		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR:/=) prefix= \
> -		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
> +		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) $@ install_headers
>  
>  $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
>  	$(call QUIET_INSTALL, $@)

+Cc Jean-Philippe

Looks good to me, thank you!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
