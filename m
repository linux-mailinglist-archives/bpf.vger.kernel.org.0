Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1A5F1427
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI3UuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiI3UtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:49:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DE63FD1
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:49:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso708622pjk.1
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hcyAey201mpQl/139mkfoiz+RI1ZPkqdPRuXMmKLkvw=;
        b=bnuP0bN+5tHc9tsVU3H7qv/bIdj2lDiURKntxAIbci4QOh9ShB9LlrCQ4Ygrt0b33I
         37yOXwF4zhnngf0QqbA7LX4P7pbrW6zF0snTAPO6b6oiLbUKN0abH2j0JI3dLdE3PNbf
         6jbr/l4WCpowhtQInAxOKnjEy308yX21z86FpeA8ENmncqme5bX6EweFBZXxrfyyUS9D
         uRRIJ4xEmq5vNj/y9npgSWCXbU5oOsRUvJc7FxjnPnnGJGZUAr396Z5k6R2QjQEHv71x
         blZ7X+Ddlfy1mxjEHWJB3yYoEqzOApiWzqo8x5tTzLo/XCE//Pw+xDqSdgnGJS0nOW1N
         9tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hcyAey201mpQl/139mkfoiz+RI1ZPkqdPRuXMmKLkvw=;
        b=mxpBkPpQFb/6BJlyhnek0VWsZK3DU8DjRnjCDlbvurQS8YlgRRZJF2L9LdVJlA2MgA
         g0JLGsQVIy5KE0I9gebMDhFZyWlUC1aP5KGWWmS7OcrUMBUiQj4VG/zW6VDiOSYjJtYv
         8GvfK7Ipz2B0ZV+Dc9iJKbUYJivtTqhac+VpyFotl9roC/XKBRW383muWk6jgN7ZRMNF
         nNcoy5fQqyrsKxzo6uL99u5boH23+fZIN+WaK/Itk6RLQz9vsoYnoKFAZmzzQrSOi4rp
         pIreGOGD/Y7JjRbS7ztnmZpJ7C4GU2nZS2/+9lPD/F17u1KxbQ6IvK/H0WTcOiW8vFzl
         0VSg==
X-Gm-Message-State: ACrzQf1W9qgQf+OZ9aczuZwzDeW/la3LTPrTvYmEDBA4A4iyjmeCRe5o
        IVabrYPjJar/+Az7rpJRK08=
X-Google-Smtp-Source: AMsMyM7AMf+GVFOfiDpZQC5m1mry70v7PNNyJsY24MXbqHQn1aGVADH2n2/C4usDDmENJdWdf6KrJw==
X-Received: by 2002:a17:90b:4a8a:b0:202:8eec:b87a with SMTP id lp10-20020a17090b4a8a00b002028eecb87amr128851pjb.48.1664570962948;
        Fri, 30 Sep 2022 13:49:22 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id x6-20020a63f706000000b00429c5270710sm2133314pgh.1.2022.09.30.13.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:49:22 -0700 (PDT)
Date:   Fri, 30 Sep 2022 13:49:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 06/15] ebpf-docs: Use standard type convention in
 standard doc
Message-ID: <20220930204920.gamkmalcr5g5u3bg@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-6-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-6-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:49PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>

Please always add commit log even it's just a copy paste of a subject line.

The patch subj should be 'bpf, docs:'.
I fixed it up while applying the first 5 patches.

> ---
>  Documentation/bpf/instruction-set.rst | 14 ++++++++++----
>  Documentation/bpf/linux-notes.rst     |  6 ++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 4997d2088..a24bc5d53 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -7,6 +7,10 @@ eBPF Instruction Set Specification, v1.0
>  
>  This document specifies version 1.0 of the eBPF instruction set.
>  
> +Documentation conventions
> +=========================
> +
> +This specification uses the standard C types (uint32_t, etc.) in documentation.
>  
>  Registers and calling convention
>  ================================
> @@ -114,7 +118,9 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>  
>  ``BPF_ADD | BPF_X | BPF_ALU`` means::
>  
> -  dst_reg = (u32) dst_reg + (u32) src_reg;
> +  dst_reg = (uint32_t) dst_reg + (uint32_t) src_reg;
> +
> +where '(uint32_t)' indicates truncation to 32 bits.

This part I'm not excited about.
imo the "standard" types are too verbose. They make the doc harder to read.
I think it would be just fine for the standard to say in the conventions section
that u32 is a 32-bit unsigned integer and that's how it's used in the doc.
u32 would be a name that the doc uses. Name match with linux type is 'accidental'.

>  ``BPF_ADD | BPF_X | BPF_ALU64`` means::
>  
> @@ -122,7 +128,7 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>  
>  ``BPF_XOR | BPF_K | BPF_ALU`` means::
>  
> -  src_reg = (u32) src_reg ^ (u32) imm32
> +  src_reg = (uint32_t) src_reg ^ (uint32_t) imm32
>  
>  ``BPF_XOR | BPF_K | BPF_ALU64`` means::
>  
> @@ -276,11 +282,11 @@ BPF_XOR   0xa0   atomic xor
>  
>  ``BPF_ATOMIC | BPF_W  | BPF_STX`` with 'imm' = BPF_ADD means::
>  
> -  *(u32 *)(dst_reg + off16) += src_reg
> +  *(uint32_t *)(dst_reg + off16) += src_reg
>  
>  ``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
>  
> -  *(u64 *)(dst_reg + off16) += src_reg
> +  *(uint32_t *)(dst_reg + off16) += src_reg

Bug.
And the later patch fixes it :(
Let's not add it in the first place.

>  In addition to the simple atomic operations, there also is a modifier and
>  two complex atomic operations:
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 1c31379b4..522ebe27d 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -7,6 +7,12 @@ Linux implementation notes
>  
>  This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
>  
> +Arithmetic instructions
> +=======================
> +
> +While the eBPF instruction set document uses the standard C terminology as the cross-platform specification,
> +in the Linux kernel, uint32_t is expressed as u32, uint64_t is expressed as u64, etc.
> +
>  Byte swap instructions
>  ======================
>  
> -- 
> 2.33.4
> 
