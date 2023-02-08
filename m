Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4631668F1A9
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBHPLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 10:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBHPKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 10:10:38 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556184ABF0
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 07:10:36 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id q10so11554980qvt.10
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 07:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rgwoey5BjGrasvBJMMYVHNC74BueJ7ASHB9AuHL/l4=;
        b=74RsuSLLP4sZiZfoDdX2qoVWeuAZ5tkoVHUdsIRrH+RfF2l29zHMsvJehaV2a2otVl
         IZ9OF7pPAuQSGN+m7yNlU/tNBaOZZbZNa1wi1htl14kTg9jRDzkFgx0c16HuZbLLG6LP
         OZVJs4+caShPSrYUdLjUi+EMjJRp2DxLW2AtlsQfigh5eak0KixrUEkBnO2lZegYTTqa
         xd1dW5d99ypFHGwNEYZVgrJKiRqtgeXrjgu0ivtmxFnO6Y03hQL6IZYnhmZjBrzdoS7l
         AbUwimy20QiJo97FlUIk4JoVThPYaTZ9LrburhGcX6xPsCVoNl7bn69hk6nYo3wyeDYg
         JTXw==
X-Gm-Message-State: AO0yUKV/FFUByaEZe5p8JNuDxriNFtwjpsS+IhQXVE8H7zHdsGCJBRrg
        tUDw3YACbmLYlVWlZ3tBuYc=
X-Google-Smtp-Source: AK7set8bzLPiKAF/xI0N2lqU/07s/Ha0vS0m39E3whjJMVRHpCrJ/yeft6Z/vt2mzAdZ8Rhjar1P+Q==
X-Received: by 2002:a05:6214:d43:b0:537:6574:e55c with SMTP id 3-20020a0562140d4300b005376574e55cmr13430012qvr.13.1675869035158;
        Wed, 08 Feb 2023 07:10:35 -0800 (PST)
Received: from maniforge.lan ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b00705cef9b84asm11517857qkh.131.2023.02.08.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:10:34 -0800 (PST)
Date:   Wed, 8 Feb 2023 09:10:39 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc:     bpf@vger.kernel.org, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Message-ID: <Y+O7b5iKBUpskWLg@maniforge.lan>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206191647.2075-1-dthaler1968@googlemail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 06, 2023 at 07:16:47PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Add text explaining helper functions.
> Note that text about runtime functions (kfuncs) is part of a separate patch,
> not this one.
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
> V1 -> V2: addressed comments from Alexei and Stanislav
> ---
>  Documentation/bpf/clang-notes.rst     |  5 +++++
>  Documentation/bpf/instruction-set.rst | 22 +++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
> index 528feddf2db..40c6185513a 100644
> --- a/Documentation/bpf/clang-notes.rst
> +++ b/Documentation/bpf/clang-notes.rst
> @@ -20,6 +20,11 @@ Arithmetic instructions
>  For CPU versions prior to 3, Clang v7.0 and later can enable ``BPF_ALU`` support with
>  ``-Xclang -target-feature -Xclang +alu32``.  In CPU version 3, support is automatically included.
>  
> +Reserved instructions
> +====================

small nit: Missing a =

> +
> +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d) instruction if ``-O0`` is used.

Are we calling this out here to say that BPF_CALL in clang -O0 builds is
not supported? That would seem to be the case given that we say that
BPF_CALL | BPF_X | BPF_JMP in reserved and not permitted in
instruction-set.rst. If that's not the case, can we add a bit more
verbiage here describing why this is done / why it's interesting and/or
relevant to the reader?

FWIW, most of our selftests don't seem to compile with clang -O0.

> +Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
> +would be read from a specified register, is reserved and currently not permitted.

> +
>  Atomic operations
>  =================
>  
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 2d3fe59bd26..89a13f1cdeb 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -191,7 +191,7 @@ BPF_JSET  0x40   PC += off if dst & src
>  BPF_JNE   0x50   PC += off if dst != src
>  BPF_JSGT  0x60   PC += off if dst > src     signed
>  BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call
> +BPF_CALL  0x80   function call              see `Helper functions`_
>  BPF_EXIT  0x90   function / program return  BPF_JMP only
>  BPF_JLT   0xa0   PC += off if dst < src     unsigned
>  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> @@ -202,6 +202,26 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>  
> +Helper functions
> +~~~~~~~~~~~~~~~~
> +
> +Helper functions are a concept whereby BPF programs can call into a
> +set of function calls exposed by the runtime.  Each helper
> +function is identified by an integer used in a ``BPF_CALL`` instruction.
> +The available helper functions may differ for each program type.
> +
> +Conceptually, each helper function is implemented with a commonly shared function
> +signature defined as:
> +
> +  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> +
> +In actuality, each helper function is defined as taking between 0 and 5 arguments,
> +with the remaining registers being ignored.  The definition of a helper function
> +is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
> +the number of arguments, and the type of each argument.
> +
> +Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function integer
> +would be read from a specified register, is reserved and currently not permitted.
>  
>  Load and store instructions
>  ===========================
> -- 
> 2.33.4
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf
