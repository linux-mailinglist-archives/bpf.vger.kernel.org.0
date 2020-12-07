Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950BA2D1C87
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLGV5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 16:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgLGV5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 16:57:45 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384E9C06179C;
        Mon,  7 Dec 2020 13:57:05 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id p126so17180911oif.7;
        Mon, 07 Dec 2020 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JzNJLFb4lAYSbW6/KJMdrY9DpvzM0R/b2u1XF5c6kDc=;
        b=ducwIV9pdGFJcWzvFjfKbwhqSQ4edoGEKENLKY0/MhKOsS7QCF2wj2ZKMdPZMVNo3Q
         iLL+VH96hffegYfWHcF/dgHJmYLhijkH2/sEKC3Q0ambnPdtnm0amflIRlaPNS3GN0l2
         ol673ETyGTkMuOkKKabGkfdWLVkmU9BkhUIJbor0DGjZqnrbl7z0Vic7Dwu5x7dlizEa
         mGkejXeDoJVIpfBU0r4lfxGiBAGBx7wXegZj7kmy3mc6n8I9qTmLrgubMGCS1iPK5ZV9
         TOUPbnhBEIspQHoE/1h0AO2cJ0KgBypELn+6XV5/MJHYTuOqOocApa6K2gUKU22qBPsf
         STPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JzNJLFb4lAYSbW6/KJMdrY9DpvzM0R/b2u1XF5c6kDc=;
        b=lN8cj13R+jzpxVuz5GpZsanTXGpPVemHZ7Sqq1ivxi9FBfwZN/pGoCbYf7qYTDIhHE
         6Pr8s9YD1R7ApA0t6zqM12NRQT3ommkUAcrLnn/AhxUgyp2d3KtXFJYKzzDPLP9eO2tq
         5pR5r+yovqLkJ05B7VgnraloIx9wJvfmMjU2ntEPSh5JqTJ53snxozaARccDmlbolh8K
         cYjA46JN/tWjXPHyjfaPkaspxtMpkGbpPXQUI2bEevyGtmZY8GiWrFRcd9MUVrxV/1MR
         hfMYlt1G2s3W9L+tYw0rNfmIF2mEhmJyoysibOY8DLDimtaAiUzLYRHyCwnQ5ciIZA/P
         QH/A==
X-Gm-Message-State: AOAM533dz2JFdEpMmVk/hvrTv+XdbeSlvjoPPKa0X/gvr2w/6I3tpM4B
        0HjZfKZ2+lhtSC0u5DHS09k=
X-Google-Smtp-Source: ABdhPJwUritBdIFT/PVN8OF41qU/kF6kgk9wpVfYv+bYjNAWm30j51HvDqbHR8YgRsTu9fCHdynXGg==
X-Received: by 2002:aca:60c4:: with SMTP id u187mr660267oib.42.1607378224627;
        Mon, 07 Dec 2020 13:57:04 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id i43sm2944368ota.39.2020.12.07.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:57:03 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:56:53 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fcea525c4971_5a96208bd@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-5-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-5-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 04/11] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
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
>  Documentation/networking/filter.rst           | 30 ++++++++-----
>  arch/arm/net/bpf_jit_32.c                     |  7 ++-
>  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++--
>  arch/mips/net/ebpf_jit.c                      | 11 +++--
>  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++---
>  arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++--
>  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++--
>  arch/s390/net/bpf_jit_comp.c                  | 27 ++++++-----
>  arch/sparc/net/bpf_jit_comp_64.c              | 17 +++++--
>  arch/x86/net/bpf_jit_comp.c                   | 45 ++++++++++++++-----
>  arch/x86/net/bpf_jit_comp32.c                 |  6 +--
>  drivers/net/ethernet/netronome/nfp/bpf/jit.c  | 14 ++++--
>  drivers/net/ethernet/netronome/nfp/bpf/main.h |  4 +-
>  .../net/ethernet/netronome/nfp/bpf/verifier.c | 15 ++++---
>  include/linux/filter.h                        | 29 ++++++++++--
>  include/uapi/linux/bpf.h                      |  5 ++-
>  kernel/bpf/core.c                             | 31 +++++++++----
>  kernel/bpf/disasm.c                           |  6 ++-
>  kernel/bpf/verifier.c                         | 24 +++++-----
>  lib/test_bpf.c                                | 14 +++---
>  samples/bpf/bpf_insn.h                        |  4 +-
>  samples/bpf/cookie_uid_helper_example.c       |  6 +--
>  samples/bpf/sock_example.c                    |  2 +-
>  samples/bpf/test_cgrp2_attach.c               |  5 ++-
>  tools/include/linux/filter.h                  | 28 ++++++++++--
>  tools/include/uapi/linux/bpf.h                |  5 ++-
>  .../bpf/prog_tests/cgroup_attach_multi.c      |  4 +-
>  .../selftests/bpf/test_cgroup_storage.c       |  2 +-
>  tools/testing/selftests/bpf/verifier/ctx.c    |  7 ++-
>  .../bpf/verifier/direct_packet_access.c       |  4 +-
>  .../testing/selftests/bpf/verifier/leak_ptr.c | 10 ++---
>  .../selftests/bpf/verifier/meta_access.c      |  4 +-
>  tools/testing/selftests/bpf/verifier/unpriv.c |  3 +-
>  .../bpf/verifier/value_illegal_alu.c          |  2 +-
>  tools/testing/selftests/bpf/verifier/xadd.c   | 18 ++++----
>  35 files changed, 317 insertions(+), 149 deletions(-)
> 

[...]

> +++ a/arch/mips/net/ebpf_jit.c

[...]

> -		if (BPF_MODE(insn->code) == BPF_XADD) {
> +		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
> +			if (insn->imm != BPF_ADD) {
> +				pr_err("ATOMIC OP %02x NOT HANDLED\n", insn->imm);
> +				return -EINVAL;
> +			}
> +
>  			/*
[...]
> +++ b/arch/powerpc/net/bpf_jit_comp64.c

> -		case BPF_STX | BPF_XADD | BPF_W:
> +		case BPF_STX | BPF_ATOMIC | BPF_W:
> +			if (insn->imm != BPF_ADD) {
> +				pr_err_ratelimited(
> +					"eBPF filter atomic op code %02x (@%d) unsupported\n",
> +					code, i);
> +				return -ENOTSUPP;
> +			}
[...]
> @@ -699,8 +707,15 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
> -		case BPF_STX | BPF_XADD | BPF_DW:
> +		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			if (insn->imm != BPF_ADD) {
> +				pr_err_ratelimited(
> +					"eBPF filter atomic op code %02x (@%d) unsupported\n",
> +					code, i);
> +				return -ENOTSUPP;
> +			}
[...]
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +		if (insn->imm != BPF_ADD) {
> +			pr_info_once(
> +				"bpf-jit: not supported: atomic operation %02x ***\n",
> +				insn->imm);
> +			return -EFAULT;
> +		}
[...]
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		if (insn->imm != BPF_ADD) {
> +			pr_err("bpf-jit: not supported: atomic operation %02x ***\n",
> +			       insn->imm);
> +			return -EINVAL;
> +		}

Can we standardize the error across jits and the error return code? It seems
odd that we use pr_err, pr_info_once, pr_err_ratelimited and then return
ENOTSUPP, EFAULT or EINVAL.

granted the error codes might not propagate all the way out at the moment but
still shouldn't hurt.

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 0a4182792876..f973e2ead197 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -1205,18 +1205,23 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,

For example this will return -1 regardless of error from insn->imm != BPF_ADD.
[...]
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +		if (insn->imm != BPF_ADD) {
> +			pr_err("Unknown atomic operation %02x\n", insn->imm);
> +			return -1;
> +		}
> +
[...]

> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -259,15 +259,38 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>  		.off   = OFF,					\
>  		.imm   = 0 })
>  
> -/* Atomic memory add, *(uint *)(dst_reg + off16) += src_reg */
> +
> +/*
> + * Atomic operations:
> + *
> + *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> + */
> +
> +#define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_DW | BPF_ATOMIC,		\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = OP })
> +
> +#define BPF_ATOMIC32(OP, DST, SRC, OFF)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_W | BPF_ATOMIC,		\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = OP })
> +
> +/* Legacy equivalent of BPF_ATOMIC{64,32}(BPF_ADD, ...) */

Not sure I care too much. Does seem more natural to follow
below pattern and use,

  BPF_ATOMIC(OP, SIZE, DST, SRC, OFF)

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

[...]

Otherwise LGTM, I'll try to get the remaining patches reviewed tonight
I need to jump onto something else this afternoon. Thanks!
