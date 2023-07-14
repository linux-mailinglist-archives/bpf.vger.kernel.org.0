Return-Path: <bpf+bounces-5040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F85754289
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7B51C213F6
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224415AD6;
	Fri, 14 Jul 2023 18:28:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CA13715
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 18:28:09 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912D1BEB
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:28:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so1462451a91.3
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689359288; x=1691951288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNv0iCHepgqIW/JetOdH2vpprmQTsYdghliqOFxlxfQ=;
        b=QZPDS5MGZNBJpD9mGU/tenJagX8+KFrd/DopAPwqLphn+cinz+akV8+kojHi2lue4T
         CQ/AH9iH98d7rnxK7Nj6j/eTj/AUoSLtZVLBQ6yJ8sXppAegAQ4iZWQU0zdGGhNAQzZ5
         KqSM1BSs41tlSYPqBJBdh9yzFxXwL9G6CnG+Pzeo6iBBZo4YZ+vQNn/g+PDpsJp03HTH
         h43yzqwm2DJYPFVZUetox2IxIGZ4AKXErpX6KTyrjrUyE7s2eoygXiJWm2ZNb9IETtby
         T+qlCH2UyHgPuVN+4754YlyLhqlyNXhglOkEXh8jlZbUDpAdrJ0Kn4HpfaxoKc9Gcfqi
         M+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359288; x=1691951288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNv0iCHepgqIW/JetOdH2vpprmQTsYdghliqOFxlxfQ=;
        b=cbgsIje1jMYDKPzZPDFXV5MCWLNmxzMV8+/tcYxFjOjbzDVc6x/F5vhrJJMN0fVzYW
         4sAQizY/UXe9nXmT92XAB0DinGUCeW79g/RzqjqYa9c8EDhH4iAmG3dcvZZEDGO7GAIf
         thTzl5W1cuYn+MOHC5OXsYnBDWPfkKD4EgCF78dvhHYWlFYOS2iENC/8kZajDCrksYK5
         NQ4bw+M4vKImqXUROVQmeIEGxDctb1gumVIoC9oy0/HqQ1bfT7hoxqwag76NtsBV/5Rf
         PA42lf5vfmklFChwmntIKhVAmecCae6kPP+az8y49xAl1DBttG6f+Kx7H/gkWY5peeDM
         8xqw==
X-Gm-Message-State: ABy/qLb0Yz7C0EZedzmM8ZhNHP4g8tp0mrKEiUONv0Y04sHHzX+1T9Cm
	GFmMWK+YRXYk01AsKvWqBVE=
X-Google-Smtp-Source: APBJJlEXlxN959i4mA/URI9FtQJ0rhuhgUxYh/qu41NFLckADC8uqIga6n7X4fB65lkQvStMwoQZFA==
X-Received: by 2002:a17:90a:c582:b0:263:2495:c27f with SMTP id l2-20020a17090ac58200b002632495c27fmr4709018pjt.15.1689359287770;
        Fri, 14 Jul 2023 11:28:07 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090aba0d00b00263d15f0e87sm1374461pjr.42.2023.07.14.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:28:07 -0700 (PDT)
Date: Fri, 14 Jul 2023 11:28:05 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Fangrui Song <maskray@google.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
 instructions
Message-ID: <20230714182805.rvfrf4y4ctmrqbav@MacBook-Pro-8.local>
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060847.397969-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713060847.397969-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 11:08:47PM -0700, Yonghong Song wrote:
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index 751e657973f0..367f426d09a1 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -154,24 +154,27 @@ otherwise identical operations.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' refer
>  to the values of the source and destination registers, respectively.
>  
> -========  =====  ==========================================================
> -code      value  description
> -========  =====  ==========================================================
> -BPF_ADD   0x00   dst += src
> -BPF_SUB   0x10   dst -= src
> -BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
> -BPF_OR    0x40   dst \|= src
> -BPF_AND   0x50   dst &= src
> -BPF_LSH   0x60   dst <<= (src & mask)
> -BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = -src
> -BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
> -BPF_XOR   0xa0   dst ^= src
> -BPF_MOV   0xb0   dst = src
> -BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
> -BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
> -========  =====  ==========================================================
> +========  =====  ============  ==========================================================
> +code      value  offset value  description

How about just 'offset' ?

> +========  =====  ============  ==========================================================
> +BPF_ADD   0x00   0             dst += src
> +BPF_SUB   0x10   0             dst -= src
> +BPF_MUL   0x20   0             dst \*= src
> +BPF_DIV   0x30   0             dst = (src != 0) ? (dst / src) : 0
> +BPF_SDIV  0x30   1             dst = (src != 0) ? (dst s/ src) : 0
> +BPF_OR    0x40   0             dst \|= src
> +BPF_AND   0x50   0             dst &= src
> +BPF_LSH   0x60   0             dst <<= (src & mask)
> +BPF_RSH   0x70   0             dst >>= (src & mask)
> +BPF_NEG   0x80   0             dst = -src
> +BPF_MOD   0x90   0             dst = (src != 0) ? (dst % src) : dst
> +BPF_SMOD  0x90   1             dst = (src != 0) ? (dst s% src) : dst
> +BPF_XOR   0xa0   0             dst ^= src
> +BPF_MOV   0xb0   0             dst = src
> +BPF_MOVSX 0xb0   8/16/32       dst = (s8,16,s32)src
> +BPF_ARSH  0xc0   0             sign extending dst >>= (src & mask)
> +BPF_END   0xd0   0             byte swap operations (see `Byte swap instructions`_ below)
> +========  =====  ============  ==========================================================
>  
>  Underflow and overflow are allowed during arithmetic operations, meaning
>  the 64-bit or 32-bit value will wrap. If eBPF program execution would
> @@ -198,11 +201,19 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>  
>    dst = dst ^ imm32
>  
> -Also note that the division and modulo operations are unsigned. Thus, for
> -``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas
> -for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
> -interpreted as an unsigned 64-bit value. There are no instructions for
> -signed division or modulo.
> +Note that most instructions have instruction offset of 0. But three instructions
> +(BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
> +
> +The devision and modulo operations support both unsigned and signed flavors.
> +For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is first
> +interpreted as an unsigned 32-bit value, whereas for ``BPF_ALU64``, 'imm' is
> +first sign extended to 64 bits and the result interpreted as an unsigned 64-bit
> +value.  For signed operation (BPF_SDIV and BPF_SMOD), for both ``BPF_ALU`` and
> +``BPF_ALU64``, 'imm' is interpreted as a signed value.

Probably worth clarifying that in case of S[DIV|MOD] | ALU64 the imm is sign
extended from 32 to 64 and interpreted as signed 64-bit.

> +
> +Instruction BPF_MOVSX does move operation with sign extension. For ``BPF_ALU``
> +mode, 8-bit and 16-bit sign extensions to 32-bit are supported. For ``BPF_ALU64``,
> +8-bit, 16-bit and 32-bit sign extenstions to 64-bit are supported.

How about:

Instruction BPF_MOVSX does move operation with sign extension. 
BPF_ALU | MOVSX sign extendes 8-bit and 16-bit into 32-bit and upper 32-bit are zeroed.
BPF_ALU64 | MOVSX sign extends 8-bit, 16-bit and 32-bit into 64-bit.

>  
> +``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16 means::
> +
> +  dst = bswap16(dst)

Worth spelling out imm 32 and 64 too ?

>  
> +The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
> +instructions that transfer data between a register and memory.
> +
> +``BPF_MEMSX | <size> | BPF_LDX`` means::
> +
> +  dst = *(sign-extension size *) (src + offset)
> +

How about:

``BPF_MEM | <size> | BPF_LDX`` means::

  dst = *(unsigned size *) (src + offset)

``BPF_MEMSX | <size> | BPF_LDX`` means::

  dst = *(signed size *) (src + offset)


