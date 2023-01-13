Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F06699D6
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjAMOP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjAMOOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 09:14:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B86E410
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:13:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so11977068wru.13
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=err590LR8LkYoQOEeBoYDEBfiAezl/1jVMvlPjzbkF0=;
        b=3Ak5tOWoCSbgTi12CjktyaTnX6MmECDFYj5hHdK5+Lu4k0mxZ9/lx86dvA98kbMdBM
         AP4LOjtku/7aivggaGhMjfknW9PmrfX0Q9D9MgqypbnVDlujcynOg1VRGOqQ5C1m9hMt
         j/yUOjtlXgqK/bhOeBy1+3X5yDtbKLamYqsWgzFzTS5F92OBHy19zOTsiTwhAoa197Lo
         DAHNUvIVH02nKpy0rimKmfCCHhFcBW6BdzAMRmr7JjkDTFhcjzDK+S8Nkri6LahNaX3d
         MoWwesoJ5KbJSje5mYjA8QxKuh4jEyQHaRas9s130LIDUsIS5US8iZhz7arzYq+u3JLL
         dCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=err590LR8LkYoQOEeBoYDEBfiAezl/1jVMvlPjzbkF0=;
        b=G5GM+kMbzJEcx5RpMN4AuWM+dgb6OQVNUPUZb05XNbSWj41RJRVLoI4+rnVIkiMF+V
         OW4GvVLMyqo5ZuFEOarzMF2zzOhFd79VsDsxt0fjssKdTg73R46AL5uxZCvQqO5fPohA
         5c49nQZAS2+3i/ZeVratyWO0LTly7Bfyx/1g5s+SNMjRmTfv8vPvVP19DHi+U1EZcgsL
         gaXxL5utOSNcooeEoGbXtmTzQu2CTxMfVhaj5PYdaXtujL2yPM5VjBsijI7KqmYsRlli
         Je8BEYpxnYZolppWZFt1pvA96rWyc9x9djF3OuQd3XSXSXpeefQbhKQ6TtGajY7IX/lN
         NTmg==
X-Gm-Message-State: AFqh2ko43tqsXgZsrV7Kwn3qoUJr2YvFQagEDXAiY1yl/Um7uo7XUbdb
        hkXoE8J5Ai7GaqTbW4qp+cHyDXGfPNsamn84G1c=
X-Google-Smtp-Source: AMrXdXsKR+oA3sRqbFHeLIpN8Ue6FdCbdQQMgOQAuNFgaPqPGvSv3rcqrEDdGx8jnC1V1ztK0Wrxxg==
X-Received: by 2002:a5d:5257:0:b0:2a8:e91d:ad31 with SMTP id k23-20020a5d5257000000b002a8e91dad31mr23784648wrc.62.1673619200771;
        Fri, 13 Jan 2023 06:13:20 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id bj7-20020a0560001e0700b002b6667d3adfsm19108137wrb.80.2023.01.13.06.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 06:13:20 -0800 (PST)
Message-ID: <6bd4e7e8-451f-b5f3-3828-d7db84c0ee15@isovalent.com>
Date:   Fri, 13 Jan 2023 14:13:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] bpftool: Always disable stack protection for clang
Content-Language: en-GB
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        bpf@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
References: <74cd9d2e-6052-312a-241e-2b514a75c92c@applied-asynchrony.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <74cd9d2e-6052-312a-241e-2b514a75c92c@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-13 14:49 UTC+0100 ~ Holger Hoffstätte
<holger@applied-asynchrony.com>
> 
> When the clang toolchain has stack protection enabled in order to be
> consistent
> with gcc - which just happens to be the case on Gentoo - the bpftool build
> fails:
> 
> clang \
>     -I. \
>     -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
>     -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
>     -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o pid_iter.bpf.o
> clang \
>     -I. \
>     -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
>     -I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
>     -g -O2 -Wall -target bpf -c skeleton/profiler.bpf.c -o profiler.bpf.o
> skeleton/profiler.bpf.c:40:14: error: A call to built-in function
> '__stack_chk_fail' is not supported.
> int BPF_PROG(fentry_XXX)
>              ^
> skeleton/profiler.bpf.c:94:14: error: A call to built-in function
> '__stack_chk_fail' is not supported.
> int BPF_PROG(fexit_XXX)
>              ^
> 2 errors generated.
> 
> Since stack-protector makes no sense for the BPF bits just unconditionally
> disable it.
> 
> Bug: https://bugs.gentoo.org/890638
> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> 
> --snip--
> 
> diff a/src/Makefile b/src/Makefile
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -205,7 +205,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c
> $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
>          -I$(or $(OUTPUT),.) \
>          -I$(srctree)/include/uapi/ \
>          -I$(LIBBPF_BOOTSTRAP_INCLUDE) \
> -        -g -O2 -Wall -target bpf -c $< -o $@
> +        -g -O2 -Wall -fno-stack-protector -target bpf -c $< -o $@
>      $(Q)$(LLVM_STRIP) -g $@
>  
>  $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)

Right, I understand we don't want it when compiling the BPF program from
the skeleton. Looks good, thank you!

Acked-by: Quentin Monnet <quentin@isovalent.com>
