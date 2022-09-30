Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A245F15A2
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiI3WBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiI3WBb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:01:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FF11FD1B
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:01:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v1so5053514plo.9
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=s/AGhAzN6Q2IG2xp9spicFaPm9ECowSjvsVk1SyRPmk=;
        b=VS7+9GQZp+xlt2zeLVRifMAjK6fX6JhD1w+3rc7Xi3OQxj1KOoDUrhC7z3oPOODA3O
         iPmQ0b14Y6WC20KgTl1JwxsyC1bEpUE/T/vn7ZLrpydwlt3wfwMdSVH/JNpZKR+mmAjF
         0tS/A1Evl5BoBr/LMu/tQgW7OCchZaLVrRyIsRuhGbg5LpOVFM3eUFPSO+DnKldsIRaM
         q1M+xeTO06P0nAGwaAazlwCAlyRldnYrqWyGuqOQLMXrBL4qvBhYK9f+MjCexGHuce/E
         mgyNoTsHJXGdI430eyy24870qLXt5qph7Uqpuv9UZ6FlMF3Oy1/Nw1cE62BZWwaWaSvc
         j2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=s/AGhAzN6Q2IG2xp9spicFaPm9ECowSjvsVk1SyRPmk=;
        b=JweTSgTL9FDuzRtDsjDpc2Pv3t5BLLcmriwTSwXNcE19k61UqaDDsCCBSm3LlYwQ5z
         9ElMI7KhjYJoKOQsap3UQx2d5Xdxbb3hWYKTFPMwiXOzUPapwh5QdX5gDyI8ImwuMTwt
         B+dQ14MOgb6pZwIce2oR/1w2br8rSEek7WinRyKiUiFtM8/qIBjYA3/KmGh+YIW77npt
         581xi2/pTnLXDfaq2V2oNP3IZjRZn4Eb6elFzTInUhybD5zAUsiaQUPYEKx2oKzRxBRg
         cANRsk1XDgXjH7U+lhtSDcOTPrM4vmUGv4EVAdJZodE9dcZH2nCwro4Tlk+d+TBcMNQG
         RORg==
X-Gm-Message-State: ACrzQf23gF2f2/+0nTY12R6LeuFWobVNJxGbIOj48vA+J77L+THQjidS
        5CLIpcKj6auDVZr0l9LRUrsWehsH0fA=
X-Google-Smtp-Source: AMsMyM42jjlMpgS6WZyptqKMDOIl3mcmaNuAi3YjVui/oj4pypkCpCuyBY9PFRLMnm3kdylkMgERnw==
X-Received: by 2002:a17:90b:3510:b0:202:f18c:fdb6 with SMTP id ls16-20020a17090b351000b00202f18cfdb6mr369894pjb.122.1664575281612;
        Fri, 30 Sep 2022 15:01:21 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090a2b0a00b001fd8316db51sm2197550pjc.7.2022.09.30.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:01:21 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:01:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 09/15] ebpf-docs: Explain helper functions
Message-ID: <20220930220119.wicafybgabixr2b3@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-9-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-9-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:52PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2987234eb..926957830 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -245,7 +245,7 @@ BPF_JSET  0x40   PC += off if dst & src
>  BPF_JNE   0x50   PC += off if dst != src
>  BPF_JSGT  0x60   PC += off if dst > src     signed
>  BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call
> +BPF_CALL  0x80   function call              see `Helper functions`_
>  BPF_EXIT  0x90   function / program return  BPF_JMP only
>  BPF_JLT   0xa0   PC += off if dst < src     unsigned
>  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> @@ -256,6 +256,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>  
> +Helper functions
> +~~~~~~~~~~~~~~~~
> +Helper functions are a concept whereby BPF programs can call into a
> +set of function calls exposed by the eBPF runtime.  Each helper
> +function is identified by an integer used in a ``BPF_CALL`` instruction.
> +The available helper functions may differ for each eBPF program type.
> +
> +Conceptually, each helper function is implemented with a commonly shared function
> +signature defined as:
> +
> +  uint64_t function(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4, uint64_t r5)
> +
> +In actuality, each helper function is defined as taking between 0 and 5 arguments,
> +with the remaining registers being ignored.  The definition of a helper function
> +is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
> +the number of arguments, and the type of each argument.

If we explain helpers in the doc then we should explain kfuncs and bpf-to-bpf calls as well.
Otherwise it looks incomplete and eventually will suffer the same issue as '64-bit instructionS'.
Here it's only one CALL insn.
Though 'imm' value can be interpreted differently bpf2bpf vs helper vs kfunc.
