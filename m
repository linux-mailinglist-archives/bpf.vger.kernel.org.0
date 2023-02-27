Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34B6A4D06
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjB0VTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjB0VS7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:18:59 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D722DF3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:18:17 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d7so8255516qtr.12
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 13:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s5Q0LnbeKkyCMIqnM13rwWUtfHIlmhtxtsjdD+D3r0=;
        b=zK0ihw2nump3C0KkhRfVKWTpsbdKILu3ryeW836uY8Hhax2W1CpaP8iE5g94hzMj/T
         ktEG3Sa+9Kr9oNTD7XrOnkg85E+LVHGZEoUW732t6tAbGJnY/AgCe0uvrKdK2xd0QmQj
         0lkLKaPAmXN7WkV1OPicW8hgZ0AgvE0mMBpZSMwt3dcnt2pT7zOS695bJ4k1DktMN/AJ
         WrYMXL1pvP1beAz0T+ReELK5ub9PBY0G2OZO82FpxPBkEmR+4SpMjgficTnfOK9s6pAY
         wMHaTmZfLr+FqiELw1Hn3pocruzOIYGNaDkopkR9ELcsrDljIUwKJ3IDtY7YRPSkKLmW
         RVAw==
X-Gm-Message-State: AO0yUKWqOG1P/a5jtwwWyLVrhT4Gb4he9KtNr7L+SuSpHBhad/MySalJ
        EoDM3U5j3hEn/663AUYg5cY=
X-Google-Smtp-Source: AK7set+51hVPuSg5wNby/PNWErpPsfe+gkMxoPtf80s1lJGFHKFWNlpy14dMfsWeswz4yZ1NNfYCXw==
X-Received: by 2002:ac8:5aca:0:b0:3bf:dd4e:3426 with SMTP id d10-20020ac85aca000000b003bfdd4e3426mr1122873qtd.64.1677532691064;
        Mon, 27 Feb 2023 13:18:11 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:978f])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a136300b0073ba2c4ee2esm5518518qkl.96.2023.02.27.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:18:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 15:18:08 -0600
From:   David Vernet <void@manifault.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org
Subject: Re: [PATCH V3] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Message-ID: <Y/0eEFTMu7YtMEN+@maniforge>
References: <877cw295u8.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cw295u8.fsf@oracle.com>
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

On Mon, Feb 27, 2023 at 10:05:51PM +0100, Jose E. Marchesi wrote:
> 
> [Changes from V2:
> - Use src and dst consistently in the document.
> - Use a more graphical depiction of the 128-bit instruction.
> - Remove `Where:' fragment.
> - Clarify that unused bits are reserved and shall be zeroed.]
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

Looks great, thanks. Just one more small nit below that I'm only adding
because this doc is part of the standardization (perhaps Alexei or
someone else could also just add it when applying).

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/instruction-set.rst | 63 ++++++++++++++-------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 01802ed9b29b..fae2e48d6a0b 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -38,15 +38,11 @@ eBPF has two instruction encodings:
>  * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
>    constant) value after the basic instruction for a total of 128 bits.
>  
> -The basic instruction encoding looks as follows for a little-endian processor,
> -where MSB and LSB mean the most significant bits and least significant bits,
> -respectively:
> +The fields conforming an encoded basic instruction are stored in the
> +following order::
>  
> -=============  =======  =======  =======  ============
> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> -=============  =======  =======  =======  ============
> -imm            offset   src_reg  dst_reg  opcode
> -=============  =======  =======  =======  ============
> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
>  
>  **imm**
>    signed integer immediate value
> @@ -54,48 +50,55 @@ imm            offset   src_reg  dst_reg  opcode
>  **offset**
>    signed integer offset used with pointer arithmetic
>  
> -**src_reg**
> +**src**
>    the source register number (0-10), except where otherwise specified
>    (`64-bit immediate instructions`_ reuse this field for other purposes)
>  
> -**dst_reg**
> +**dst**
>    destination register number (0-10)
>  
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
> +For example::
>  
> -Multi-byte fields ('imm' and 'offset') are similarly stored in
> -the byte order of the processor.
> +  opcode         offset imm          assembly
> +         src dst
> +  07     0   1   00 00  44 33 22 11  r1 += 0x11223344 // little
> +         dst src
> +  07     1   0   00 00  11 22 33 44  r1 += 0x11223344 // big
>  
>  Note that most instructions do not use all of the fields.
>  Unused fields shall be cleared to zero.

We should probably also say "Unused fields are reserved and shall be
cleared to zero" here.

>  
> -As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
> -instruction uses a 64-bit immediate value that is constructed as follows.
> -The 64 bits following the basic instruction contain a pseudo instruction
> -using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
> -and imm containing the high 32 bits of the immediate value.
> +As discussed below in `64-bit immediate instructions`_, a 64-bit
> +immediate instruction uses a 64-bit immediate value that is
> +constructed as follows.  The 64 bits following the basic instruction
> +contain a pseudo instruction using the same format but with opcode,
> +dst, src, and offset all set to zero, and imm containing the high 32
> +bits of the immediate value.
>  
> -=================  ==================
> -64 bits (MSB)      64 bits (LSB)
> -=================  ==================
> -basic instruction  pseudo instruction
> -=================  ==================
> +This is depicted in the following figure::
> +
> +        basic_instruction
> +  .-----------------------------.
> +  |                             |
> +  code:8 regs:16 offset:16 imm:32 unused:32 imm:32
> +                                  |              |
> +                                  '--------------'
> +                                 pseudo instruction
>  
>  Thus the 64-bit immediate value is constructed as follows:
>  
>    imm64 = (next_imm << 32) | imm
>  
>  where 'next_imm' refers to the imm value of the pseudo instruction
> -following the basic instruction.
> +following the basic instruction.  The unused bytes in the pseudo
> +instruction are reserved and shall be cleared to zero.
>  
>  Instruction classes
>  -------------------
> @@ -137,7 +140,7 @@ code            source  instruction class
>    source  value  description
>    ======  =====  ==============================================
>    BPF_K   0x00   use 32-bit 'imm' value as source operand
> -  BPF_X   0x08   use 'src_reg' register value as source operand
> +  BPF_X   0x08   use 'src' register value as source operand
>    ======  =====  ==============================================
>  
>  **instruction class**
> -- 
> 2.30.2
> 
