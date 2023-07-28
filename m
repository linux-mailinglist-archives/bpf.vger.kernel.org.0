Return-Path: <bpf+bounces-6263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8B76772B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 22:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E9F2826E1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0A1BB2D;
	Fri, 28 Jul 2023 20:43:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A24EDC
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 20:43:41 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31A2728
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 13:43:39 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76af2cb7404so199951285a.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 13:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690577019; x=1691181819;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1je410IndVAuCQIqFKB1JhqiJXDrRLKr/jUvDgctIxg=;
        b=kZnrjvbjKqK5TW6VORKU8Y7MMGzFDdrZdINsIoLbqhOcY/etS3yRM/sldAXbhpEyUT
         W2BXfQRJ2MqVjqfTVOepII8XeJNXEFr8ZY7pMLoPVPrEKi47hGRJYfYBzMrd6CSVTMut
         QTrSobr+HSfe8Xogg2hFuvuJaesOFE5fCOuzUACryIFWDuzGQyynn+durFbHrB+5Au7A
         GJhCTRITe/EBqzcp+eCqFuvxIjHKkQrHDWtnJtvDDVhoeBYMg93pP8p3V9XMy92+1zTt
         aBsea5RrrpYjCuur5/VR3XnVTZbW0Ao/5sceiMxWGZ6Wj6I7EWVZmd8ltRXqL2juIjYO
         0wvw==
X-Gm-Message-State: ABy/qLZ+inxGT/iZUOpg92DuoYev8B2Tr4pVbi9sO/umL5XIQ2x171To
	o0peZ5P+g2OsVvgxd3MrgrkzDUJGSj0xxQ==
X-Google-Smtp-Source: APBJJlFOzagdnf318g2Fq9cGk0Wg2k8bOFq2lqq1/htXzi2xWa3vxpBqlBnBcTCnMFJ5c283A2V7dA==
X-Received: by 2002:a05:620a:1a0b:b0:76c:44f1:4fa with SMTP id bk11-20020a05620a1a0b00b0076c44f104famr4757178qkb.23.1690577018780;
        Fri, 28 Jul 2023 13:43:38 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5bb1])
        by smtp.gmail.com with ESMTPSA id pa2-20020a05620a830200b007682af2c8aasm1389276qkn.126.2023.07.28.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 13:43:38 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:43:36 -0500
From: David Vernet <void@manifault.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@ietf.org
Subject: Re: [PATCH bpf-next] docs/bpf: Improve documentation for cpu=v4
 instructions
Message-ID: <20230728204336.GC7328@maniforge>
References: <20230728185852.3572290-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728185852.3572290-1-yonghong.song@linux.dev>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 11:58:52AM -0700, Yonghong Song wrote:
> Improve documentation for cpu=v4 instructions based on
> David's suggestions.
> 
> Cc: bpf@ietf.org
> Suggested-by: David Vernet <void@manifault.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

LGTM, thanks Yonghong. Just left one nit below.

Acked-by: David Vernet <void@manifault.com>

> ---
>  .../bpf/standardization/instruction-set.rst   | 54 +++++++++++--------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 23e880a83a1f..95079a53a35b 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -174,7 +174,7 @@ BPF_MOV   0xb0   0        dst = src
>  BPF_MOVSX 0xb0   8/16/32  dst = (s8,s16,s32)src
>  BPF_ARSH  0xc0   0        sign extending dst >>= (src & mask)
>  BPF_END   0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
> -========  =====  ============  ==========================================================
> +========  =====  =======  ==========================================================
>  
>  Underflow and overflow are allowed during arithmetic operations, meaning
>  the 64-bit or 32-bit value will wrap. If eBPF program execution would
> @@ -201,26 +201,32 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>  
>    dst = dst ^ imm32
>  
> -Note that most instructions have instruction offset of 0. But three instructions
> -(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
> +Note that most instructions have instruction offset of 0. Only three instructions
> +(``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
>  
>  The devision and modulo operations support both unsigned and signed flavors.
> -For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
> -interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
> -first sign extended to 64 bits and the result interpreted as an unsigned 64-bit
> -value.  For signed operation (BPF_SDIV and BPF_SMOD), for ``BPF_ALU``, 'imm' is
> -interpreted as a signed value. For ``BPF_ALU64``, the 'imm' is sign extended
> -from 32 to 64 and interpreted as a signed 64-bit value.
>  
> -Instruction BPF_MOVSX does move operation with sign extension.
> -``BPF_ALU | MOVSX`` sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.
> -``BPF_ALU64 | MOVSX`` sign extends 8-bit, 16-bit and 32-bit into 64-bit.
> +For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
> +'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
> +'imm' is first sign extended from 32 to 64 bits, and then interpreted as
> +a 64-bit unsigned value.
> +
> +For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
> +'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
> +is first sign extended from 32 to 64 bits, and then interpreted as a
> +64-bit signed value.
> +
> +The ``BPF_MOVSX`` instruction does a move operation with sign extension.
> +``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
> +bit operands, and zeroes the remaining upper 32 bits.
> +``BPF_ALU64 | BPF_MOVSX`` sign extends 8-bit, 16-bit, and 32-bit
> +operands into 64 bit operands.
>  
>  Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
>  for 32-bit operations.
>  
>  Byte swap instructions
> -~~~~~~~~~~~~~~~~~~~~~~
> +----------------------
>  
>  The byte swap instructions use instruction classes of ``BPF_ALU`` and ``BPF_ALU64``
>  and a 4-bit 'code' field of ``BPF_END``.
> @@ -228,16 +234,17 @@ and a 4-bit 'code' field of ``BPF_END``.
>  The byte swap instructions operate on the destination register
>  only and do not use a separate source register or immediate value.
>  
> -For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to select what byte
> -order the operation convert from or to. For ``BPF_ALU64``, the 1-bit source operand
> -field in the opcode is not used and must be 0.
> +For ``BPF_ALU``, the 1-bit source operand field in the opcode is used to
> +select what byte order the operation converts from or to. For
> +``BPF_ALU64``, the 1-bit source operand field in the opcode is reserved
> +and must be set to 0.
>  
>  =========  =========  =====  =================================================
>  class      source     value  description
>  =========  =========  =====  =================================================
>  BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little endian
>  BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big endian
> -BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
> +BPF_ALU64  Reserved   0x00   do byte swap unconditionally
>  =========  =========  =====  =================================================
>  
>  The 'imm' field encodes the width of the swap operations.  The following widths
> @@ -305,9 +312,12 @@ where 's>=' indicates a signed '>=' comparison.
>  
>  where 'imm' means the branch offset comes from insn 'imm' field.
>  
> -Note there are two flavors of BPF_JA instrions. BPF_JMP class permits 16-bit jump offset while
> -BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be converted to a <16bit
> -conditional jmp plus a 32-bit unconditional jump.
> +Note that there are two flavors of ``BPF_JA`` instructions. The
> +``BPF_JMP`` class permits a 16-bit jump offset specified by 'offset'

s/by 'offset'/by the 'offset'

> +field, whereas the ``BPF_JMP32`` class permits a 32-bit jump offset
> +specified by the 'imm' field. A > 16-bit conditional jump may be
> +converted to a < 16-bit conditional jump plus a 32-bit unconditional
> +jump.
>  
>  Helper functions
>  ~~~~~~~~~~~~~~~~
> @@ -385,7 +395,7 @@ instructions that transfer data between a register and memory.
>    dst = *(unsigned size *) (src + offset)
>  
>  Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
> -'unsigned size' is one of u8, u16, u32 and u64.
> +'unsigned size' is one of u8, u16, u32 or u64.
>  
>  The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
>  instructions that transfer data between a register and memory.
> @@ -395,7 +405,7 @@ instructions that transfer data between a register and memory.
>    dst = *(signed size *) (src + offset)
>  
>  Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``, and
> -'signed size' is one of s8, s16 and s32.
> +'signed size' is one of s8, s16 or s32.
>  
>  Atomic operations
>  -----------------
> -- 
> 2.34.1
> 

