Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56685526F67
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiENBOA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiENBN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 21:13:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB532FBE0
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:46:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x12so8919366pgj.7
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A72XN0PYiKlNvKMfjm4RN8XOy+GKxQ9/x8pKk0YN5Xs=;
        b=nemRP+e64mEOh3NAQuEM5YiDXf5VCW4NTaAx5gmZicqLl9mVnDUW+9AUEJrn33MRSj
         ybeC7E0mdKO9EzqIPdm+hdPV4DEIHdaZyEzIlL5HouR6jslmqdmGEV2NGidHg1STIxcm
         1PMQlIaJrshmLoUEH8VDfoRRV5uhAqxv0/C5FDiME0VJQqASZ/1kwAhOc9nNvabtX5fN
         DhRrK4KTX5FnBUA377TLRuxVluew6EdE4d35iGMFZWZwTmhNxzCvB/9mxNRiyAQ+Ukro
         5lm3udHjoSy2PCdU3GpTciaUBrZVQ6mBAY3RSnRm7v7AQLklOzXiqe86hAFuT9g4WYTf
         GsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A72XN0PYiKlNvKMfjm4RN8XOy+GKxQ9/x8pKk0YN5Xs=;
        b=jhZ+bEpfEAat0GeW0A0d5YwWjwo85B8eVmfrvKBDV/gsjy77rDbuS9lvfXCc4mNcxf
         JMY+C8x/v/Uij8P//tX7wtat+j2Y2oTxAj5VA9SfqRP8o7MOA7rjPJnGnOgw3u7l39f3
         2z4C9bW5vfZ4vdREf4Ha5sqkyOFVRriQMMSHVI/rR/Ez6oX4m5do8gCJsn62shv3CtJ/
         0fMUqqtpjpmr9bTeqXKWbKIsLG+yMuaQbku9d8LqEBcW3/f7vY3Se8mQyIX7z0qE25uB
         6DlOm8x69HfCHjCg2fv5kktwumsPzovi7f5gpHSMoil7OaPj79IZM8lJzViJ2uqrYXOb
         Rdsw==
X-Gm-Message-State: AOAM533zF7nu8XDZNQup0hGw8hGIzUhpeFFGy1zF6vz8WivZL6/LPhuI
        azSFpjkMdbwqSg1++8dw0xROHO0/Lys=
X-Google-Smtp-Source: ABdhPJylspnJP+6RTm74ySEgKHyE2s95Z5wT3+g5mFZSGMUgBJ+24XcAKz2IH7WQNsvyfsC4zoiLQA==
X-Received: by 2002:a65:6d06:0:b0:3c6:890:5609 with SMTP id bf6-20020a656d06000000b003c608905609mr5866541pgb.357.1652488884034;
        Fri, 13 May 2022 17:41:24 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090abc0200b001d9253a32fcsm2117081pjr.36.2022.05.13.17.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 17:41:23 -0700 (PDT)
Date:   Fri, 13 May 2022 17:41:21 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 2/5] bpf: add get_reg_val helper
Message-ID: <20220514004121.qkbj3jgibpih3sxy@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512074321.2090073-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 12:43:18AM -0700, Dave Marchevsky wrote:
> Add a helper which reads the value of specified register into memory.
> 
> Currently, bpf programs only have access to general-purpose registers
> via struct pt_regs. Other registers, like SSE regs %xmm0-15, are
> inaccessible, which makes some tracing usecases impossible. For example,
> User Statically-Defined Tracing (USDT) probes may use SSE registers to
> pass their arguments on x86. While this patch adds support for %xmm0-15
> only, the helper is meant to be generic enough to support fetching any
> reg.
> 
> A useful "value of register" definition for bpf programs is "value of
> register before control transfer to kernel". pt_regs gives us this
> currently, so it's the default behavior of the new helper. Fetching the
> actual _current_ reg value is possible, though, by passing
> BPF_GETREG_F_CURRENT flag as part of input.
> 
> For SSE regs we try to avoid digging around in task's fpu state by first
> reading _current_ value, then checking to see if the state of cpu's
> floating point regs matches task's view of them. If so, we can just
> return _current_ value.
> 
> Further usecases which are straightforward to support, but
> unimplemented:
>   * using the helper to fetch general-purpose register value.
>   currently-unused pt_regs parameter exists for this reason.
> 
>   * fetching rdtsc (w/ BPF_GETREG_F_CURRENT)
> 
>   * other architectures. s390 specifically might benefit from similar
>   fpu reg fetching as USDT library was recently updated to support that
>   architecture.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/uapi/linux/bpf.h       |  40 +++++++++
>  kernel/trace/bpf_trace.c       | 148 +++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.h       |   1 +
>  tools/include/uapi/linux/bpf.h |  40 +++++++++
>  4 files changed, 229 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 444fe6f1cf35..3ef8f683ed9e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5154,6 +5154,18 @@ union bpf_attr {
>   *		if not NULL, is a reference which must be released using its
>   *		corresponding release function, or moved into a BPF map before
>   *		program exit.
> + *
> + * long bpf_get_reg_val(void *dst, u32 size, u64 getreg_spec, struct pt_regs *regs, struct task_struct *tsk)
> + *	Description
> + *		Store the value of a SSE register specified by *getreg_spec*
> + *		into memory region of size *size* specified by *dst*. *getreg_spec*
> + *		is a combination of BPF_GETREG enum AND BPF_GETREG_F flag e.g.
> + *		(BPF_GETREG_X86_XMM0 << 32) | BPF_GETREG_F_CURRENT.*
> + *	Return
> + *		0 on success
> + *		**-ENOENT** if the system architecture does not have requested reg
> + *		**-EINVAL** if *getreg_spec* is invalid
> + *		**-EINVAL** if *size* != bytes necessary to store requested reg val
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -5351,6 +5363,7 @@ union bpf_attr {
>  	FN(skb_set_tstamp),		\
>  	FN(ima_file_hash),		\
>  	FN(kptr_xchg),			\
> +	FN(get_reg_val),		\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -6318,6 +6331,33 @@ struct bpf_perf_event_value {
>  	__u64 running;
>  };
>  
> +/* bpf_get_reg_val register enum */
> +enum {
> +	BPF_GETREG_X86_XMM0 = 0,
> +	BPF_GETREG_X86_XMM1,
> +	BPF_GETREG_X86_XMM2,
> +	BPF_GETREG_X86_XMM3,
> +	BPF_GETREG_X86_XMM4,
> +	BPF_GETREG_X86_XMM5,
> +	BPF_GETREG_X86_XMM6,
> +	BPF_GETREG_X86_XMM7,
> +	BPF_GETREG_X86_XMM8,
> +	BPF_GETREG_X86_XMM9,
> +	BPF_GETREG_X86_XMM10,
> +	BPF_GETREG_X86_XMM11,
> +	BPF_GETREG_X86_XMM12,
> +	BPF_GETREG_X86_XMM13,
> +	BPF_GETREG_X86_XMM14,
> +	BPF_GETREG_X86_XMM15,
> +	__MAX_BPF_GETREG,
> +};

Can we do BPF_GETREG_X86_XMM plus number instead?
Enumerating every possible register will take quite some space in uapi
and bpf progs probably won't be using these enum values directly anyway.
usdt spec will have something like "xmm5" as a string.

> +
> +/* bpf_get_reg_val flags */
> +enum {
> +	BPF_GETREG_F_NONE = 0,
> +	BPF_GETREG_F_CURRENT = (1U << 0),
> +};
> +
>  enum {
>  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
>  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f15b826f9899..0de7d6b3af5b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -28,6 +28,10 @@
>  
>  #include <asm/tlb.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/fpu/context.h>
> +#endif
> +
>  #include "trace_probe.h"
>  #include "trace.h"
>  
> @@ -1166,6 +1170,148 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>  
> +#define XMM_REG_SZ 16
> +
> +#define __xmm_space_off(regno)				\
> +	case BPF_GETREG_X86_XMM ## regno:		\
> +		xmm_space_off = regno * 16;		\
> +		break;
> +
> +static long getreg_read_xmm_fxsave(u32 reg, struct task_struct *tsk,
> +				   void *data)
> +{
> +	struct fxregs_state *fxsave;
> +	u32 xmm_space_off;
> +
> +	switch (reg) {
> +	__xmm_space_off(0);
> +	__xmm_space_off(1);
> +	__xmm_space_off(2);
> +	__xmm_space_off(3);
> +	__xmm_space_off(4);
> +	__xmm_space_off(5);
> +	__xmm_space_off(6);
> +	__xmm_space_off(7);
> +#ifdef	CONFIG_X86_64
> +	__xmm_space_off(8);
> +	__xmm_space_off(9);
> +	__xmm_space_off(10);
> +	__xmm_space_off(11);
> +	__xmm_space_off(12);
> +	__xmm_space_off(13);
> +	__xmm_space_off(14);
> +	__xmm_space_off(15);
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	fxsave = &tsk->thread.fpu.fpstate->regs.fxsave;
> +	memcpy(data, (void *)&fxsave->xmm_space + xmm_space_off, XMM_REG_SZ);
> +	return 0;

It's all arch specific.
This one and majority of other functions should probably go
into arch/x86/net/bpf_jit_comp.c? instead of generic code.
bpf_trace.c doesn't fit.

Try to avoid all ifdef-s. It's a red flag.

> +static long bpf_read_sse_reg(u32 reg, u32 flags, struct task_struct *tsk,
> +			     void *data)
> +{
> +#ifdef CONFIG_X86
> +	unsigned long irq_flags;
> +	long err;
> +
> +	switch (reg) {
> +	__bpf_sse_read(0);
> +	__bpf_sse_read(1);
> +	__bpf_sse_read(2);
> +	__bpf_sse_read(3);
> +	__bpf_sse_read(4);
> +	__bpf_sse_read(5);
> +	__bpf_sse_read(6);
> +	__bpf_sse_read(7);
> +#ifdef CONFIG_X86_64
> +	__bpf_sse_read(8);
> +	__bpf_sse_read(9);
> +	__bpf_sse_read(10);
> +	__bpf_sse_read(11);
> +	__bpf_sse_read(12);
> +	__bpf_sse_read(13);
> +	__bpf_sse_read(14);
> +	__bpf_sse_read(15);
> +#endif /* CONFIG_X86_64 */
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (flags & BPF_GETREG_F_CURRENT)
> +		return 0;
> +
> +	if (!fpregs_state_valid(&tsk->thread.fpu, smp_processor_id())) {
> +		local_irq_save(irq_flags);

why disable irqs?

> +		err = getreg_read_xmm_fxsave(reg, tsk, data);
> +		local_irq_restore(irq_flags);
> +		return err;
> +	}

What is the use case to read other task regs?
