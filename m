Return-Path: <bpf+bounces-4304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCBC74A501
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013DE2813FC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6325C2EC;
	Thu,  6 Jul 2023 20:42:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737FBA39
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:42:09 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA971992
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:42:06 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AE096C135DFD
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688676126; bh=yDfGxyQJXvfP+aImF/5ZCKsbPzQRx05M/KaPwKKz9Dc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gZaMbxQuFWcWpir3q+Woco23Xb+ddVVwuhly41fvnZgkAqvb2O/nN87YXxEVvmpOh
	 W+1c8mwFtATbLNo09SnEYMkIdJNKYPU4h7Frm8CRL9qJ/vjH0PFqek/5Yh4Cdc5oeV
	 Gcb64iE8qE1NNYFHMGtAyjSVph+WuLWNkxbV52Pw=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 13:42:06 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 894CDC151535;
	Thu,  6 Jul 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688676126; bh=yDfGxyQJXvfP+aImF/5ZCKsbPzQRx05M/KaPwKKz9Dc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=gZaMbxQuFWcWpir3q+Woco23Xb+ddVVwuhly41fvnZgkAqvb2O/nN87YXxEVvmpOh
	 W+1c8mwFtATbLNo09SnEYMkIdJNKYPU4h7Frm8CRL9qJ/vjH0PFqek/5Yh4Cdc5oeV
	 Gcb64iE8qE1NNYFHMGtAyjSVph+WuLWNkxbV52Pw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A1C96C151535
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 13:42:05 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.097
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iN0MuXnZl1e3 for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 13:42:03 -0700 (PDT)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6F316C14CE53
 for <bpf@ietf.org>; Thu,  6 Jul 2023 13:42:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b7fb1a82c4so6647065ad.1
 for <bpf@ietf.org>; Thu, 06 Jul 2023 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688676122; x=1691268122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uaq/3hgSO8O/iUaRjZXnma1YtiW123LroOYDKibtZqM=;
 b=ZVFMDqs2gl0lSPQi+NEmS7EWcTzgtKb7enWO2Tc9QlUPG/JrEGPlujdGCFrqvzMMKh
 inQC9r6hO/W+7UuxZJcWDBHdx/49lvR6JLCzsgJTqro33i0w37jzjj82lZHVjVYSwhQR
 apAy4+sb1J+1rSkuX+6gmWPaaY8k/t2BCmx+9IBKoqeOn8a5bMxLl+qDLRsrLrLSH4l+
 m5rHFfE2p2mVIulht5Qejm4mGvMn3U0WwotrX0tlWCpMOhFjZpDdUUBKvQWmQDTqo+fY
 Eqn/QlQcQf2jRJZ7vLJJp2KtnwF12t+cKcVjeitAFwhnpsbeBOCE/BXtbsfRzCeHzAI+
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688676122; x=1691268122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaq/3hgSO8O/iUaRjZXnma1YtiW123LroOYDKibtZqM=;
 b=RuTPOnRnBl6SUMTlsZFJfNHgU6jCcIM2jLpl5BUOpSHMBvD6mHlbbIHs1vJRev6vIp
 8O0sNkejCFzd6vjJhEsdQpYZLjk7OR3Y4Fvmpli618Dyht8fZsJVjEWov8PGyV1FJL3r
 1d4vGvRalJVNlISvdzSbf+cZtD35vzYAeOB3DqXiAcSMC4zlYBIY8UXIRVDCuzp9tfKj
 3pnThUlROfvWWgWsnm9B4PMNyp5BzI7uEFBtjBvmjnZnIHjPgphZmtmCuAXkbDdIkhv6
 UfrG1jUfvF+duvKFsKbbm4a3p/WVRwL9t97eBytphVrklW1VrkXcCzNKJlI6avTsHZf+
 iRqQ==
X-Gm-Message-State: ABy/qLaiwhdYctd1i5sd3cuXVQrh3v+iSlEIJEhYIh05yuJ8M86K5Wdu
 mfyWHu021nIl1eWMLJp4Pp8=
X-Google-Smtp-Source: APBJJlH6Q2+QIkCJ3etohbgNJM9D+WGgnGWJt7RxMYSpgcAX1a3RqPnM8PVZ75Tt7SjXc0tbc03ZDg==
X-Received: by 2002:a17:902:d485:b0:1b8:b48a:5e7f with SMTP id
 c5-20020a170902d48500b001b8b48a5e7fmr3045986plg.25.1688676122359; 
 Thu, 06 Jul 2023 13:42:02 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::5:e96a])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a170903328500b001b53be3d942sm1804705plb.232.2023.07.06.13.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 13:42:01 -0700 (PDT)
Date: Thu, 6 Jul 2023 13:41:59 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Message-ID: <20230706204159.7tzacql7wdk3yszc@macbook-pro-8.dhcp.thefacebook.com>
References: <20230706160537.1309-1-dthaler1968@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230706160537.1309-1-dthaler1968@googlemail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/oaEg3RbyrD6MghFmOCWW6h2B8x0>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Improve English readability
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:05:37PM +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> --
> V1 -> V2: addressed comments from Alexei
> ---
>  Documentation/bpf/instruction-set.rst | 59 ++++++++++++++++++++-------
>  Documentation/bpf/linux-notes.rst     |  5 +++
>  2 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 751e657973f..740989f4c1e 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -7,6 +7,9 @@ eBPF Instruction Set Specification, v1.0
>  
>  This document specifies version 1.0 of the eBPF instruction set.
>  
> +The eBPF instruction set consists of eleven 64 bit registers, a program counter,
> +and an implementation-specific amount (e.g., 512 bytes) of stack space.
> +
>  Documentation conventions
>  =========================
>  
> @@ -27,12 +30,24 @@ The eBPF calling convention is defined as:
>  * R6 - R9: callee saved registers that function calls will preserve
>  * R10: read-only frame pointer to access stack
>  
> -R0 - R5 are scratch registers and eBPF programs needs to spill/fill them if
> -necessary across calls.
> +Registers R0 - R5 are caller-saved registers, meaning the BPF program needs to either
> +spill them to the BPF stack or move them to callee saved registers if these
> +arguments are to be reused across multiple function calls. Spilling means
> +that the value in the register is moved to the BPF stack. The reverse operation
> +of moving the variable from the BPF stack to the register is called filling.
> +The reason for spilling/filling is due to the limited number of registers.

imo this extended explanation goes too far.
It's also not entirely correct. We could have an ISA with limited number of registers
where every register is callee saved. A bit absurd, but possible.
Or went with SPARC style register windows.

> +
> +Upon entering execution of an eBPF program, registers R1 - R5 initially can contain
> +the input arguments for the program (similar to the argc/argv pair for a typical C program).

argc/argv is only for main(). We don't have main() concept in BPF ISA.
argc/argv is also not a property of ISA.

> +The actual number of registers used, and their meaning, is defined by the program type;
> +for example, a networking program might have an argument that includes network packet data
> +and/or metadata.

that makes things even more confusing.

tbh none of the above changes make the doc easier to read.

>  Instruction encoding
>  ====================
>  
> +An eBPF program is a sequence of instructions.

Kinda true, but it opens the door for plenty of bike shedding.
Is it contiguous sequence? what about subprograms?
Is BPF program a one function or multiple functions?
etc.
Just not worth it.
This is ISA doc.

> +
>  eBPF has two instruction encodings:
>  
>  * the basic instruction encoding, which uses 64 bits to encode an instruction
> @@ -74,7 +89,7 @@ For example::
>    07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
>  
>  Note that most instructions do not use all of the fields.
> -Unused fields shall be cleared to zero.
> +Unused fields must be set to zero.

How is this better?

>  
>  As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
>  instruction uses a 64-bit immediate value that is constructed as follows.
> @@ -103,7 +118,9 @@ instruction are reserved and shall be cleared to zero.
>  Instruction classes
>  -------------------
>  
> -The three LSB bits of the 'opcode' field store the instruction class:
> +The encoding of the 'opcode' field varies and can be determined from
> +the three least significant bits (LSB) of the 'opcode' field which holds
> +the "instruction class", as follows:

same question. Don't see an improvement in wording.

>  
>  =========  =====  ===============================  ===================================
>  class      value  description                      reference
> @@ -149,7 +166,8 @@ code            source  instruction class
>  Arithmetic instructions
>  -----------------------
>  
> -``BPF_ALU`` uses 32-bit wide operands while ``BPF_ALU64`` uses 64-bit wide operands for
> +Instruction class ``BPF_ALU`` uses 32-bit wide operands (zeroing the upper 32 bits
> +of the destination register) while ``BPF_ALU64`` uses 64-bit wide operands for

The other part of the doc mentions zeroing. No need to repeat.

>  otherwise identical operations.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' refer
>  to the values of the source and destination registers, respectively.
> @@ -216,8 +234,9 @@ The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
>  The byte swap instructions operate on the destination register
>  only and do not use a separate source register or immediate value.
>  
> -The 1-bit source operand field in the opcode is used to select what byte
> -order the operation convert from or to:
> +Byte swap instructions use the 1-bit 'source' field in the 'opcode' field
> +as follows.  Instead of indicating the source operator, it is instead
> +used to select what byte order the operation converts from or to:

+1 to this part.

>  
>  =========  =====  =================================================
>  source     value  description
> @@ -235,16 +254,21 @@ Examples:
>  
>    dst = htole16(dst)
>  
> +where 'htole16()' indicates converting a 16-bit value from host byte order to little-endian byte order.
> +
>  ``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
>  
>    dst = htobe64(dst)
>  
> +where 'htobe64()' indicates converting a 64-bit value from host byte order to big-endian byte order.
> +
>  Jump instructions
>  -----------------
>  
> -``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
> +Instruction class ``BPF_JMP32`` uses 32-bit wide operands while ``BPF_JMP`` uses 64-bit wide operands for
>  otherwise identical operations.
> -The 'code' field encodes the operation as below:
> +
> +The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
>  
>  ========  =====  ===  ===========================================  =========================================
>  code      value  src  description                                  notes
> @@ -311,7 +335,8 @@ For load and store instructions (``BPF_LD``, ``BPF_LDX``, ``BPF_ST``, and ``BPF_
>  mode          size    instruction class
>  ============  ======  =================
>  
> -The mode modifier is one of:
> +mode
> +  one of:
>  
>    =============  =====  ====================================  =============
>    mode modifier  value  description                           reference
> @@ -323,7 +348,8 @@ The mode modifier is one of:
>    BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
>    =============  =====  ====================================  =============
>  
> -The size modifier is one of:
> +size
> +  one of:
>  
>    =============  =====  =====================
>    size modifier  value  description
> @@ -334,6 +360,9 @@ The size modifier is one of:
>    BPF_DW         0x18   double word (8 bytes)
>    =============  =====  =====================
>  
> +instruction class
> +  the instruction class (see `Instruction classes`_)
> +
>  Regular load and store operations
>  ---------------------------------
>  
> @@ -352,7 +381,7 @@ instructions that transfer data between a register and memory.
>  
>    dst = *(size *) (src + offset)
>  
> -Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> +where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
>  
>  Atomic operations
>  -----------------
> @@ -366,7 +395,9 @@ that use the ``BPF_ATOMIC`` mode modifier as follows:
>  
>  * ``BPF_ATOMIC | BPF_W | BPF_STX`` for 32-bit operations
>  * ``BPF_ATOMIC | BPF_DW | BPF_STX`` for 64-bit operations
> -* 8-bit and 16-bit wide atomic operations are not supported.
> +
> +Note that 8-bit (``BPF_B``) and 16-bit (``BPF_H``) wide atomic operations are not currently supported,
> +nor is ``BPF_ATOMIC | <size> | BPF_ST``.
>  
>  The 'imm' field is used to encode the actual atomic operation.
>  Simple atomic operation use a subset of the values defined to encode
> @@ -390,7 +421,7 @@ BPF_XOR   0xa0   atomic xor
>  
>    *(u64 *)(dst + offset) += src
>  
> -In addition to the simple atomic operations, there also is a modifier and
> +In addition to the simple atomic operations above, there also is a modifier and
>  two complex atomic operations:
>  
>  ===========  ================  ===========================
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 508d009d3be..724579fd62d 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -7,6 +7,11 @@ Linux implementation notes
>  
>  This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
>  
> +Stack space
> +======================
> +
> +Linux currently supports 512 bytes of stack space.

I wouldn't open this door.
The verifier enforces 512 stack space for bpf prog plus all of its subprogs that it calls directly.
There is no good way to describe it concisely. And such description doesn't belong in ISA doc.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

