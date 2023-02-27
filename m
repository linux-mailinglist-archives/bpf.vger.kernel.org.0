Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812766A474B
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 17:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjB0QwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0QwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 11:52:09 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27591EBFD
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 08:52:07 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id l13so7402065qtv.3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 08:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nouG2YMsT+cKpwN7t93GzZv4UX3B/uNJ/++sDq/PgpE=;
        b=l3x8pbFM19xU7Ub19GUKb7cE0dROfbAdGAfm3Z9qrWt8wgfKxc5T54BFFMelwuowvQ
         yIjC0o2iHAIFpH/8GzVat/wBfWVNUIAiN+NU8LqVG59Vo7wYFyuQ3nXYUYWtZWSMvdt1
         p0Ds9kIK6idPTiUPf7/k5SiK3pIZdvv9U87EszkSeWTJtVWGZz5Gnhd10EmYZGy13JIQ
         X7sRfx6aTdZWb/HXHfey5pnAekbZmFrcDNIuzjcprEQbao2DV9qgbrPWQdm2ppt6zRLU
         QDO3k2+Zj4yVKKB1iu7qXqraH3PomcTfcO/+RMMb3P/gNFpepmoQ39pxde8Zx9ErOvsl
         Z4KA==
X-Gm-Message-State: AO0yUKXji/eiIQxwMEdpxOm19g8S2ZxscG+seNhOSaXba8QbZ78wdTos
        IxtDjs01DPztWU0tBI6te9+bGGYH5NI6TA==
X-Google-Smtp-Source: AK7set/42sSChSbtJds0TAUh0dkfcfc9+MZYxJGciY9zx9pz3IdHKDYHlNKgdpiPOrq4iF+7syV7UA==
X-Received: by 2002:ac8:5ac8:0:b0:3bf:e2db:4c80 with SMTP id d8-20020ac85ac8000000b003bfe2db4c80mr2443211qtd.53.1677516726547;
        Mon, 27 Feb 2023 08:52:06 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id m27-20020a05620a13bb00b0073b587194d0sm5129988qki.104.2023.02.27.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:52:06 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:52:04 -0600
From:   David Vernet <void@manifault.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Message-ID: <Y/zftLx9nDF5tb9G@maniforge>
References: <87y1om25l4.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1om25l4.fsf@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 24, 2023 at 09:04:07PM +0100, Jose E. Marchesi wrote:
> 
> This patch modifies instruction-set.rst so it documents the encoding
> of BPF instructions in terms of how the bytes are stored (be it in an
> ELF file or as bytes in a memory buffer to be loaded into the kernel
> or some other BPF consumer) as opposed to how the instruction looks
> like once loaded.
> 
> This is hopefully easier to understand by implementors looking to
> generate and/or consume bytes conforming BPF instructions.
> 
> The patch also clarifies that the unused bytes in a pseudo-instruction
> shall be cleared with zeros.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>

Hi Jose,

Thanks for writing this up.

> ---
>  Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 01802ed9b29b..9b28c0e15bb6 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>    constant) value after the basic instruction for a total of 128 bits.
>  
> -The basic instruction encoding looks as follows for a little-endian processor,
> -where MSB and LSB mean the most significant bits and least significant bits,
> -respectively:
> +The fields conforming an encoded basic instruction are stored in the
> +following order:
>  
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   src_reg  dst_reg  opcode
> -=============  =======  =======  =======  ============
> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.

Unfortunately this won't render correctly. It'll look something like
this:

The fields conforming an encoded basic instruction are stored in the following order:

opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF. opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.

You'll have to add some extra newlines. You can test out your changes
with:

make SPHINXDIRS=bpf htmldocs

And then the output is put in Documentation/output/bpf

In general, this is sort of the problem we have with rst. We want to
strike a balance between readable in a text editor, and readable when
rendered in a web browser. I think we can strike such a balance here,
but it'll probably require a bit of rst-fu. As described below, I think
we can fix this with a literal code block by just adding a : to order:

> +The fields conforming an encoded basic instruction are stored in the
> +following order::


> +
> +Where,
>  
>  **imm**
>    signed integer immediate value
> @@ -64,16 +62,17 @@ imm            offset   src_reg  dst_reg  opcode
>  **opcode**
>    operation to perform
>  
> -and as follows for a big-endian processor:
> +Note that the contents of multi-byte fields ('imm' and 'offset') are
> +stored using big-endian byte ordering in big-endian BPF and
> +little-endian byte ordering in little-endian BPF.
>  
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   dst_reg  src_reg  opcode
> -=============  =======  =======  =======  ============
> +For example:
>  
> -Multi-byte fields ('imm' and 'offset') are similarly stored in
> -the byte order of the processor.
> +  opcode         offset imm          assembly
> +         src dst
> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
> +         dst src
> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big

This also won't render. rst will think it's a "definition list" (see
[0]), so it's interpreting the line with '// big' as a term that will be
defined on the next line.

[0]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks

If you do "For example::" it should render correctly. This applies
elsewhere to the patch. Let's just make all of these literal code
blocks.

Thanks,
David

>  
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.
> @@ -84,18 +83,18 @@ The 64 bits following the basic instruction contain a pseudo instruction
>  using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
>  and imm containing the high 32 bits of the immediate value.
>  
> -=================  ==================
> -64 bits (MSB)      64 bits (LSB)
> -=================  ==================
> -basic instruction  pseudo instruction
> -=================  ==================
> +This is depicted in the following figure:
> +
> +  basic_instruction                 pseudo_instruction
> +  code:8 regs:16 offset:16 imm:32 | unused:32 imm:32
>  
>  Thus the 64-bit immediate value is constructed as follows:
>  
>    imm64 = (next_imm << 32) | imm
>  
>  where 'next_imm' refers to the imm value of the pseudo instruction
> -following the basic instruction.
> +following the basic instruction.  The unused bytes in the pseudo
> +instruction shall be cleared to zero.
>  
>  Instruction classes
>  -------------------
> -- 
> 2.30.2
> 
> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf
