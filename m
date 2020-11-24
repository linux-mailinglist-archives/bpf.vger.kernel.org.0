Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79022C1E81
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgKXGuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 01:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXGuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 01:50:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49BC0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:50:07 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so9383211plb.4
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 22:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rt0VZ98yTW+ib5esQryQVRz7SwQo26Hsj75YBQujSoM=;
        b=qoDLWoJFZSBG0eoKZBFmW168qNWca+0qQMHcbBURQ+AtzliCxUYqjdzambKlBe5T88
         fE+puIvlHjAQVA45Z1u8SUShMiilWfKb+BIeXjomrD0D6GVEBaVUvaOzfBXgnVRwCEDF
         EfcwoX3Get19oLUG0FfufISaDudI2tqbT6ZOtJ8nFzIVBV1IyESN1ElmRxVpV+1bUcUq
         278rjkU7F7zwDk1VXtarZAsWbynqoXUoTB1FGtDLMTqS2+1n5RsYSyYepJih+JyEUfvT
         +AXs+oPKskKyvVY0PPgRXLBK81vTfswzAUtlkCxNFuE+fRnVBWjK1iXqauJ+ORQ/C1af
         zOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rt0VZ98yTW+ib5esQryQVRz7SwQo26Hsj75YBQujSoM=;
        b=EdT7fF/fkYiEvaBPS2+1v6JUhAGYsS1HoQGshon3ygyYF8b7R59GC+UMI75sHvT3Yj
         PbHxMc1H5ON/2SW8jVHbKj0CGdR4Vqz0vJOlkcyfa+C1FAWz9fu9hdCLZtajZi7qMuF5
         e69IYKtfcfyDTi7JATizLRNATMJsIYTmP453LMYVFq7/JN7qqnCxbD8r1HkOG6qbLda4
         7NzP67BLEUoJWQMrN7MckaqNFKtHBKbZxJu78S3CI7+bf65jLNaX4qvJpEyGKnjii3va
         HZ6x42pigdDb3x3S17xbEJaqjlJq7QvcXeFL06nBk7Fsx/jhb2Xgk4yXmFA2feb0fK6N
         UxVw==
X-Gm-Message-State: AOAM533TLLKeudwZhtXtH+9+Iz0CZs+EFHETz0QKDLHNPOeenIz0Gg1U
        /DAy1VE998xsYclWSFrl9DQ=
X-Google-Smtp-Source: ABdhPJxLavrI6a59SThdjBwIfyEH3xKApwj6M18Ed2d48bN74/KLz/KwgZhK17votf7n+WwyMUCr3Q==
X-Received: by 2002:a17:902:8d82:b029:d8:c5e8:9785 with SMTP id v2-20020a1709028d82b02900d8c5e89785mr2888146plo.5.1606200607108;
        Mon, 23 Nov 2020 22:50:07 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:2397])
        by smtp.gmail.com with ESMTPSA id a12sm1583562pjh.48.2020.11.23.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 22:50:06 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:50:04 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 3/7] bpf: Rename BPF_XADD and prepare to encode other
 atomics in .imm
Message-ID: <20201124065004.pdgjfkqvzywb5l2c@ast-mbp>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-4-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123173202.1335708-4-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 05:31:58PM +0000, Brendan Jackman wrote:
> A subsequent patch will add additional atomic operations. These new
> operations will use the same opcode field as the existing XADD, with
> the immediate discriminating different operations.
> 
> In preparation, rename the instruction mode BPF_ATOMIC and start
> calling the zero immediate BPF_ADD.
> 
> This is possible (doesn't break existing valid BPF progs) because the
> immediate field is currently reserved MBZ and BPF_ADD is zero.
> 
> All uses are removed from the tree but the BPF_XADD definition is
> kept around to avoid breaking builds for people including kernel
> headers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/networking/filter.rst           | 27 +++++++++-------
>  arch/arm/net/bpf_jit_32.c                     |  7 ++---
>  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++++---
>  arch/mips/net/ebpf_jit.c                      | 11 +++++--
>  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++++++---
>  arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++++---
>  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++++---
>  arch/s390/net/bpf_jit_comp.c                  | 26 +++++++++-------
>  arch/sparc/net/bpf_jit_comp_64.c              | 14 +++++++--
>  arch/x86/net/bpf_jit_comp.c                   | 30 +++++++++++-------
>  arch/x86/net/bpf_jit_comp32.c                 |  6 ++--

I think this massive rename is not needed.
BPF_XADD is uapi and won't be removed.
Updating documentation, samples and tests is probably enough.

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 1b62397bd124..ce19988fb312 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -261,13 +261,15 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>  
>  /* Atomic memory add, *(uint *)(dst_reg + off16) += src_reg */
>  
> -#define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
> +#define BPF_ATOMIC_ADD(SIZE, DST, SRC, OFF)			\
>  	((struct bpf_insn) {					\
> -		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
>  		.dst_reg = DST,					\
>  		.src_reg = SRC,					\
>  		.off   = OFF,					\
> -		.imm   = 0 })
> +		.imm   = BPF_ADD })
> +#define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */

this is fine.

> +
>  
>  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3ca6146f001a..dcd08783647d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -19,7 +19,8 @@
>  
>  /* ld/ldx fields */
>  #define BPF_DW		0x18	/* double word (64-bit) */
> -#define BPF_XADD	0xc0	/* exclusive add */
> +#define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
> +#define BPF_XADD	0xc0	/* legacy name, don't add new uses */

I think the comment sounds too strong.
New uses of BPF_XADD are discouraged, but they're still correct.

>  
>  /* alu/jmp fields */
>  #define BPF_MOV		0xb0	/* mov reg to reg */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ff55cbcfbab4..48b192a8edce 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1317,8 +1317,8 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>  	INSN_3(STX, MEM,  H),			\
>  	INSN_3(STX, MEM,  W),			\
>  	INSN_3(STX, MEM,  DW),			\
> -	INSN_3(STX, XADD, W),			\
> -	INSN_3(STX, XADD, DW),			\
> +	INSN_3(STX, ATOMIC, W),			\
> +	INSN_3(STX, ATOMIC, DW),		\
>  	/*   Immediate based. */		\
>  	INSN_3(ST, MEM, B),			\
>  	INSN_3(ST, MEM, H),			\
> @@ -1626,13 +1626,25 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>  	LDX_PROBE(DW, 8)
>  #undef LDX_PROBE
>  
> -	STX_XADD_W: /* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
> -		atomic_add((u32) SRC, (atomic_t *)(unsigned long)
> -			   (DST + insn->off));
> +	STX_ATOMIC_W:
> +		switch (insn->imm) {
> +		case BPF_ADD:
> +			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
> +			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
> +				   (DST + insn->off));
> +		default:
> +			goto default_label;
> +		}
>  		CONT;
> -	STX_XADD_DW: /* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
> -		atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
> -			     (DST + insn->off));
> +	STX_ATOMIC_DW:
> +		switch (insn->imm) {
> +		case BPF_ADD:
> +			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
> +			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
> +				     (DST + insn->off));
> +		default:
> +			goto default_label;
> +		}

+1

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb2943ea715d..06885e2501f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3598,13 +3598,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  	return err;
>  }
>  
> -static int check_xadd(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> +static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)

+1

> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ca7d635bccd9..fbb13ef9207c 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -4295,7 +4295,7 @@ static struct bpf_test tests[] = {
>  		{ { 0, 0xffffffff } },
>  		.stack_depth = 40,
>  	},
> -	/* BPF_STX | BPF_XADD | BPF_W/DW */
> +	/* BPF_STX | BPF_ATOMIC | BPF_W/DW */

I would leave this comment as-is.
There are several uses of BPF_STX_XADD in that file.
So the comment is fine.

>  	{
>  		"STX_XADD_W: Test: 0x12 + 0x10 = 0x22",
>  		.u.insns_int = {
> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
> index 544237980582..db67a2847395 100644
> --- a/samples/bpf/bpf_insn.h
> +++ b/samples/bpf/bpf_insn.h
> @@ -138,11 +138,11 @@ struct bpf_insn;
>  
>  #define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
>  	((struct bpf_insn) {					\
> -		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
>  		.dst_reg = DST,					\
>  		.src_reg = SRC,					\
>  		.off   = OFF,					\
> -		.imm   = 0 })
> +		.imm   = BPF_ADD })
>  
>  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>  
> diff --git a/samples/bpf/sock_example.c b/samples/bpf/sock_example.c
> index 00aae1d33fca..41ec3ca3bc40 100644
> --- a/samples/bpf/sock_example.c
> +++ b/samples/bpf/sock_example.c
> @@ -54,7 +54,8 @@ static int test_sock(void)
>  		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
>  		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
>  		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
> -		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
> +		BPF_RAW_INSN(BPF_STX | BPF_ATOMIC | BPF_DW,
> +			     BPF_REG_0, BPF_REG_1, 0, BPF_ADD), /* xadd r0 += r1 */

+1

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> index b549fcfacc0b..79401a59a988 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> @@ -45,13 +45,15 @@ static int prog_load_cnt(int verdict, int val)
>  		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
>  		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
>  		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
> -		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
> +		BPF_RAW_INSN(BPF_STX | BPF_ATOMIC | BPF_DW,
> +			     BPF_REG_0, BPF_REG_1, 0, BPF_ADD), /* xadd r0 += r1 */

+1
