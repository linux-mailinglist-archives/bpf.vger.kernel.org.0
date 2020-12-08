Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581022D2795
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 10:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgLHJ1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 04:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgLHJ1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 04:27:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F8BC061749
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 01:26:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so15550573wrt.0
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXgYA9CeIM+j5i7wHnRUH6RMd2r+QbmdOpQX79NtK20=;
        b=mqYC7iQ7YUDJkvX3hxzjnG724VOSfrqn1/fCQ70RUDrjVMya7Nvg+O5VWKT2jO8zfa
         GVIhxGGGD0dNn3aLIkneJuFy2vtgiWfQf4t1HqBnXTp9h74DNgV3ljygWwyhjzKgDE2B
         eUDUyiZXEOjvNMMF+Wo0Gwia+0qRFkWXepoTmgUZp3JhvY8DnX30VUzjONykGjKeMCPT
         L+DEnJkf2fdRx5h9De345u7aRYQZYg/pw/lqhxPQHnkESIvWB/9kSyi5v8l69C0kJExZ
         t7+BKjx1yMwVqTazbgIOp2S2roy4Rv0JRpop+3GyqZ6VvK22ZLIaZSwhZffRvAohXB/n
         q0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXgYA9CeIM+j5i7wHnRUH6RMd2r+QbmdOpQX79NtK20=;
        b=sAKDVvi46gz1YCjpsSKWNBiO3OzgTUB6/Xt2GNQ87HMsLC2VhsGdafUOqr+/TZ/MhC
         l2J0VrZoIOb60ru+BcuIQ3FyHD6tOHWrQMCv1hMrI5RG0KosYvC6CquWJYcbAd7xGiM+
         bh86gUammJfmndOGoaQmRyMvDnnFwx9WP1rqbiDO6imLpbfdwQ8tnhrpyPapRYXP96AV
         hhmU641sTs6WwI7P8RC64/qbIf/DRNqrHZvKBTv63Mxb/nzRmCwCTGbju4DilbH6I1M0
         ec8e+OiMdsL91cU3cZjgN5g6yNiiBKh1bZtEj67N7W7zee7Tba3+Yx3GXpcg91sliaZ3
         zxww==
X-Gm-Message-State: AOAM532cv+xIe0yRI6jBfQOCgLYgneUBCy16brp3rVgyrlp1CJXfh47E
        gJKWUG/y4F9QfCJ4VA64a5t9Dg==
X-Google-Smtp-Source: ABdhPJxnjG8DP3SGg0ussYjOKPxpckG9YCL0g57TL1TOTJglEEcL6p54WHOJyjPXm0ueQrY/nQzJbQ==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr7078158wrw.264.1607419614931;
        Tue, 08 Dec 2020 01:26:54 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id i9sm12810706wrs.70.2020.12.08.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:26:54 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:26:50 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 04/11] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
Message-ID: <X89G2kItO2o60+A6@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-5-jackmanb@google.com>
 <5fcea525c4971_5a96208bd@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcea525c4971_5a96208bd@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi John, thanks a lot for the reviews!

On Mon, Dec 07, 2020 at 01:56:53PM -0800, John Fastabend wrote:
> Brendan Jackman wrote:
> > A subsequent patch will add additional atomic operations. These new
> > operations will use the same opcode field as the existing XADD, with
> > the immediate discriminating different operations.
> > 
> > In preparation, rename the instruction mode BPF_ATOMIC and start
> > calling the zero immediate BPF_ADD.
> > 
> > This is possible (doesn't break existing valid BPF progs) because the
> > immediate field is currently reserved MBZ and BPF_ADD is zero.
> > 
> > All uses are removed from the tree but the BPF_XADD definition is
> > kept around to avoid breaking builds for people including kernel
> > headers.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  Documentation/networking/filter.rst           | 30 ++++++++-----
> >  arch/arm/net/bpf_jit_32.c                     |  7 ++-
> >  arch/arm64/net/bpf_jit_comp.c                 | 16 +++++--
> >  arch/mips/net/ebpf_jit.c                      | 11 +++--
> >  arch/powerpc/net/bpf_jit_comp64.c             | 25 ++++++++---
> >  arch/riscv/net/bpf_jit_comp32.c               | 20 +++++++--
> >  arch/riscv/net/bpf_jit_comp64.c               | 16 +++++--
> >  arch/s390/net/bpf_jit_comp.c                  | 27 ++++++-----
> >  arch/sparc/net/bpf_jit_comp_64.c              | 17 +++++--
> >  arch/x86/net/bpf_jit_comp.c                   | 45 ++++++++++++++-----
> >  arch/x86/net/bpf_jit_comp32.c                 |  6 +--
> >  drivers/net/ethernet/netronome/nfp/bpf/jit.c  | 14 ++++--
> >  drivers/net/ethernet/netronome/nfp/bpf/main.h |  4 +-
> >  .../net/ethernet/netronome/nfp/bpf/verifier.c | 15 ++++---
> >  include/linux/filter.h                        | 29 ++++++++++--
> >  include/uapi/linux/bpf.h                      |  5 ++-
> >  kernel/bpf/core.c                             | 31 +++++++++----
> >  kernel/bpf/disasm.c                           |  6 ++-
> >  kernel/bpf/verifier.c                         | 24 +++++-----
> >  lib/test_bpf.c                                | 14 +++---
> >  samples/bpf/bpf_insn.h                        |  4 +-
> >  samples/bpf/cookie_uid_helper_example.c       |  6 +--
> >  samples/bpf/sock_example.c                    |  2 +-
> >  samples/bpf/test_cgrp2_attach.c               |  5 ++-
> >  tools/include/linux/filter.h                  | 28 ++++++++++--
> >  tools/include/uapi/linux/bpf.h                |  5 ++-
> >  .../bpf/prog_tests/cgroup_attach_multi.c      |  4 +-
> >  .../selftests/bpf/test_cgroup_storage.c       |  2 +-
> >  tools/testing/selftests/bpf/verifier/ctx.c    |  7 ++-
> >  .../bpf/verifier/direct_packet_access.c       |  4 +-
> >  .../testing/selftests/bpf/verifier/leak_ptr.c | 10 ++---
> >  .../selftests/bpf/verifier/meta_access.c      |  4 +-
> >  tools/testing/selftests/bpf/verifier/unpriv.c |  3 +-
> >  .../bpf/verifier/value_illegal_alu.c          |  2 +-
> >  tools/testing/selftests/bpf/verifier/xadd.c   | 18 ++++----
> >  35 files changed, 317 insertions(+), 149 deletions(-)
> > 
> 
> [...]
> 
> > +++ a/arch/mips/net/ebpf_jit.c
> 
> [...]
> 
> > -		if (BPF_MODE(insn->code) == BPF_XADD) {
> > +		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
> > +			if (insn->imm != BPF_ADD) {
> > +				pr_err("ATOMIC OP %02x NOT HANDLED\n", insn->imm);
> > +				return -EINVAL;
> > +			}
> > +
> >  			/*
> [...]
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> 
> > -		case BPF_STX | BPF_XADD | BPF_W:
> > +		case BPF_STX | BPF_ATOMIC | BPF_W:
> > +			if (insn->imm != BPF_ADD) {
> > +				pr_err_ratelimited(
> > +					"eBPF filter atomic op code %02x (@%d) unsupported\n",
> > +					code, i);
> > +				return -ENOTSUPP;
> > +			}
> [...]
> > @@ -699,8 +707,15 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
> > -		case BPF_STX | BPF_XADD | BPF_DW:
> > +		case BPF_STX | BPF_ATOMIC | BPF_DW:
> > +			if (insn->imm != BPF_ADD) {
> > +				pr_err_ratelimited(
> > +					"eBPF filter atomic op code %02x (@%d) unsupported\n",
> > +					code, i);
> > +				return -ENOTSUPP;
> > +			}
> [...]
> > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > +		if (insn->imm != BPF_ADD) {
> > +			pr_info_once(
> > +				"bpf-jit: not supported: atomic operation %02x ***\n",
> > +				insn->imm);
> > +			return -EFAULT;
> > +		}
> [...]
> > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> > +		if (insn->imm != BPF_ADD) {
> > +			pr_err("bpf-jit: not supported: atomic operation %02x ***\n",
> > +			       insn->imm);
> > +			return -EINVAL;
> > +		}
> 
> Can we standardize the error across jits and the error return code? It seems
> odd that we use pr_err, pr_info_once, pr_err_ratelimited and then return
> ENOTSUPP, EFAULT or EINVAL.

That would be a noble cause but I don't think it makes sense in this
patchset: they are already inconsistent, so here I've gone for intra-JIT
consistency over inter-JIT consistency.

I think it would be more annoying, for example, if the s390 JIT returned
-EOPNOTSUPP for a bad atomic but -1 for other unsupported ops, than it
is already that the s390 JIT returns -1 where the MIPS returns -EINVAL.

> granted the error codes might not propagate all the way out at the moment but
> still shouldn't hurt.
> 
> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> > index 0a4182792876..f973e2ead197 100644
> > --- a/arch/s390/net/bpf_jit_comp.c
> > +++ b/arch/s390/net/bpf_jit_comp.c
> > @@ -1205,18 +1205,23 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
> 
> For example this will return -1 regardless of error from insn->imm != BPF_ADD.
> [...]
> > +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > +		if (insn->imm != BPF_ADD) {
> > +			pr_err("Unknown atomic operation %02x\n", insn->imm);
> > +			return -1;
> > +		}
> > +
> [...]
> 
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -259,15 +259,38 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> >  		.off   = OFF,					\
> >  		.imm   = 0 })
> >  
> > -/* Atomic memory add, *(uint *)(dst_reg + off16) += src_reg */
> > +
> > +/*
> > + * Atomic operations:
> > + *
> > + *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> > + */
> > +
> > +#define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_DW | BPF_ATOMIC,		\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = OP })
> > +
> > +#define BPF_ATOMIC32(OP, DST, SRC, OFF)				\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_W | BPF_ATOMIC,		\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = OP })
> > +
> > +/* Legacy equivalent of BPF_ATOMIC{64,32}(BPF_ADD, ...) */
> 
> Not sure I care too much. Does seem more natural to follow
> below pattern and use,
> 
>   BPF_ATOMIC(OP, SIZE, DST, SRC, OFF)
> 
> >  
> >  #define BPF_STX_XADD(SIZE, DST, SRC, OFF)			\
> >  	((struct bpf_insn) {					\
> > -		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_XADD,	\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> >  		.dst_reg = DST,					\
> >  		.src_reg = SRC,					\
> >  		.off   = OFF,					\
> > -		.imm   = 0 })
> > +		.imm   = BPF_ADD })
> >  
> >  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
> >  
> 
> [...]
> 
> Otherwise LGTM, I'll try to get the remaining patches reviewed tonight
> I need to jump onto something else this afternoon. Thanks!
