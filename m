Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1785F142F
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiI3UwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiI3UwP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:52:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A218F42E
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:52:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e68so5249679pfe.1
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8LxRjPlvu1HwTLy+4U9MapcBr7p5TVR/COu2OGUsSG8=;
        b=ePx2xZNV1nWDyi9i/fzJzPlI3W2ji11kTBatuCRjNCrXwQ/AigyTK89Wt6adrR8EQy
         FyJT/r42y7tg2tzfxV5jFyEKoRo2q8rFQA8DHf9BBpAEB/tOa8RmtRc+xZ7OgAdaC07H
         948nw/rZmxrt1k7HJ5lYsifHMJyomn1w3xEEye1IKWP1nVqysqBZCeehFEjuIFuVugxh
         KsHx3fYOGZ9oatonDWJmuReWu9To0JgbbLhwUcRAz7+MdluKNsGTW3H8Jh0d8vL6LAei
         YZL9LVpEaITaw0m6rLf4eriSl2mLMmqZ/hxnmxd80vcqgyzMNEQVe0lX+AumrLAkMV1u
         bTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8LxRjPlvu1HwTLy+4U9MapcBr7p5TVR/COu2OGUsSG8=;
        b=nUHUO+JUEtWHS2qOaKf2RBVOweN66K89kh16bkRWuxuXBTqludopw0oWqSzANnFJoh
         a9V1JeBaqeg0/XSe2eDAT5pxodAfDbrC9yIZvuB6y4gtwrYq5GCvPVgoz/1D08a9cEx9
         x1AIhB7b+oXmtnP8jX0LMTsq2fkE7xi4QGni9xEUaE2artTfVkXRgKBeaOXyRgg0JQi/
         9HF0lqXl21QMA6fUcRR9K9BgVI/ECoVT2G5+OGAK41O1R+CDYRhOXBqQEMKMVJ7bAbiJ
         0NDcC3nn0+Rc21CnT5f/Pb11adkCehujA35yMkQGh72MrNJAACy9RAtTXOwmBFYBwgBj
         N19w==
X-Gm-Message-State: ACrzQf2lPPfdVGlsfJtiLpuNN4H76cQcc0mgsn/TDkGWvSboi0RGc8ut
        yj/xhPklznPWd1YabswbwoY=
X-Google-Smtp-Source: AMsMyM6PcmmsDSJE2rtwLrHo4Fw5lXxxhcHgTNZVa99+DONtoGxwSwCrqVSlRKMISRJIWBo5gjja9w==
X-Received: by 2002:a63:68e:0:b0:438:e83a:c35c with SMTP id 136-20020a63068e000000b00438e83ac35cmr9266864pgg.312.1664571133829;
        Fri, 30 Sep 2022 13:52:13 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b0017825ab5320sm2343784plx.251.2022.09.30.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:52:13 -0700 (PDT)
Date:   Fri, 30 Sep 2022 13:52:11 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Message-ID: <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-7-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:50PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index a24bc5d53..3c5a63612 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -103,19 +103,26 @@ code      value  description
>  BPF_ADD   0x00   dst += src
>  BPF_SUB   0x10   dst -= src
>  BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst /= src
> +BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
>  BPF_OR    0x40   dst \|= src
>  BPF_AND   0x50   dst &= src
>  BPF_LSH   0x60   dst <<= src
>  BPF_RSH   0x70   dst >>= src
>  BPF_NEG   0x80   dst = ~src
> -BPF_MOD   0x90   dst %= src
> +BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>  BPF_XOR   0xa0   dst ^= src
>  BPF_MOV   0xb0   dst = src
>  BPF_ARSH  0xc0   sign extending shift right
>  BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>  ========  =====  ==========================================================
>  
> +Underflow and overflow are allowed during arithmetic operations,
> +meaning the 64-bit or 32-bit value will wrap.  If
> +eBPF program execution would result in division by zero,
> +the destination register is instead set to zero.
> +If execution would result in modulo by zero,
> +the destination register is instead left unchanged.
> +
>  ``BPF_ADD | BPF_X | BPF_ALU`` means::
>  
>    dst_reg = (uint32_t) dst_reg + (uint32_t) src_reg;
> @@ -135,6 +142,14 @@ where '(uint32_t)' indicates truncation to 32 bits.
>    src_reg = src_reg ^ imm32
>  
>  
> +Also note that the modulo operation often varies by language
> +when the dividend or divisor are negative, where Python, Ruby, etc.
> +differ from C, Go, Java, etc. This specification requires that
> +modulo use truncated division (where -13 % 3 == -1) as implemented
> +in C, Go, etc.:
> +
> +   a % n = a - n * trunc(a / n)
> +

Interesting bit of info, but I'm not sure how it relates to the ISA doc.

I think it's more important to say that BPF ISA only supports unsigned div/mod.
There are no instructions for signed div/mod.

>  Byte swap instructions
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.33.4
> 
