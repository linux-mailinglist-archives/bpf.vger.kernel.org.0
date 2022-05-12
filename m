Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3540252514B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiELP3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiELP3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 11:29:45 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFAF994CB
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 08:29:42 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id u35so4580633qtc.13
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 08:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmgoK/J/F4oGk7HcZi5WYUnXHwCFG/+gIOWJLeNDZiE=;
        b=N3itA8mhI7/ATiShIxsogatVXCWnmMD8ZKJ62XVOixoAv0xe6u4jVrk3trnr6DQBzo
         w7EPmkxIbVhmc5yzcOqCXv2FRrYQaQ7Li0YGje+/Uj831fQ+PWqh/R6KIracfRbgRtMg
         xs81ZzFkcGKTImiZD2wRJ5lDggtmuFRUQO4KAW9iQrylgAZnf+BW97pjWbomFPepIt4t
         HgHS5O0f8e7jT8NKzpLnwj1FxZZc2dJiXWSaMsGfxgk8MvLDG8hZqZVWCGc1QVpfeXa9
         QTyyMfdpH0L3oXipje1v8I6YMwRVlBTxqC/gPKEY3yk4X2h3Dvq6wPjLiGgJnFtK1og4
         jdEg==
X-Gm-Message-State: AOAM531tnUSTXIQsc149ppbI3H0S56N2LcWJqpOKEd18nW8MryfiyJKe
        Pi7Ec3lRm10Nsr4H35uxgzw=
X-Google-Smtp-Source: ABdhPJy5Hwl6Q0dlAWDxmD8at3IEglMVgpeb2i/FNcO+Iy12yWyRPbCesC1NrFVchi9cq0IrI2mg2g==
X-Received: by 2002:a05:622a:284:b0:2f3:c6aa:6c96 with SMTP id z4-20020a05622a028400b002f3c6aa6c96mr305493qtw.512.1652369381115;
        Thu, 12 May 2022 08:29:41 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-005.fbsv.net. [2a03:2880:20ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id o1-20020ac872c1000000b002f39b99f6b9sm2958396qtp.83.2022.05.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:29:40 -0700 (PDT)
Date:   Thu, 12 May 2022 08:29:38 -0700
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 2/5] bpf: add get_reg_val helper
Message-ID: <20220512152938.hfm64odsrrqlvfiy@dev0025.ash9.facebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512074321.2090073-3-davemarchevsky@fb.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

Even though this patch only adds support for SSE, if the helper is meant to
be generic enough to support fetching any register, should the description
be updated to not imply that it's only meant for fetching SSE? IMO the
example below is sufficient to indicate that it can be used to fetch SSE
regs.

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

I know we do this in a few places in bpf.h, so please feel free to ignore
this, but the C standard (section 6.7.2.2.1) formally states that if no
value is specified for the first enumerator that its value is 0, so
specifying the value here is strictly unnecessary. We're inconsistent in
how we apply this in bpf.h, but IMHO if we're adding new enums, we should
do the "standard" thing and only define the first element if it's nonzero.

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
> +
> +/* bpf_get_reg_val flags */
> +enum {
> +	BPF_GETREG_F_NONE = 0,
> +	BPF_GETREG_F_CURRENT = (1U << 0),
> +};

Can you add a comment specifying what the BPF_GETREG_F_CURRENT flag does?
The commit summary is very helpful, but it would be good to persist this in
code as well.

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
> +}

Does any of this also need to be wrapped in CONFIG_X86? IIUC, everything in
struct thread_struct is arch specific, so I think this may fail to compile
on a number of other architectures. Per my suggestion below, maybe we
should just compile all of this logic out if we're not on x86, and update
bpf_get_reg_val() to only call bpf_read_sse_reg() on x86?

> +
> +#undef __xmm_space_off
> +
> +static bool getreg_is_xmm(u32 reg)
> +{
> +	return reg >= BPF_GETREG_X86_XMM0 && reg <= BPF_GETREG_X86_XMM15;

I think it's a bit confusing that we have a function here which confirms
that a register is xmm, but then we have ifdef CONFIG_X86_64 in large
switch statements in functions where we actually read the register and then
return -EINVAL.  Should we just update this to do the CONFIG_X6_64
preprocessor check, and then we can assume in getreg_read_xmm_fxsave() and
bpf_read_sse_reg() that the register is a valid xmm register, and avoid
having to do these switch statements at all? Note that this wouldn't change
the existing behavior at all, as we'd still be returning -EINVAL on 32-bit
x86 in either case.

> +}
> +
> +#define __bpf_sse_read(regno)							\
> +	case BPF_GETREG_X86_XMM ## regno:					\
> +		asm("movdqa %%xmm" #regno ", %0" : "=m"(*(char *)data));	\
> +		break;
> +
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
> +		err = getreg_read_xmm_fxsave(reg, tsk, data);
> +		local_irq_restore(irq_flags);
> +		return err;
> +	}

Should we move the checks for current and fpregs_state_valid() above where
we actually read the registers? That way we can avoid doing the xmm read if
we'd have to read the fxsave region anyways. Not sure if that's common in
practice or really necessary at all. What you have here seems fine as well.

> +
> +	return 0;
> +#else
> +	return -ENOENT;
> +#endif /* CONFIG_X86 */
> +}
> +
> +#undef __bpf_sse_read
> +
> +BPF_CALL_5(get_reg_val, void *, dst, u32, size,
> +	   u64, getreg_spec, struct pt_regs *, regs,
> +	   struct task_struct *, tsk)
> +{
> +	u32 reg, flags;
> +
> +	reg = (u32)(getreg_spec >> 32);
> +	flags = (u32)getreg_spec;
> +	if (reg >= __MAX_BPF_GETREG)
> +		return -EINVAL;
> +
> +	if (getreg_is_xmm(reg)) {
> +#ifndef CONFIG_X86
> +		return -ENOENT;

On CONFIG_X86 but !CONFIG_X86_64, we return -EINVAL if we try to access the
wrong xmm register. Should we just change this to be return -EINVAL to keep
the return value consistent between architectures? Or we should update the
32 bit x86 case to return -ENOENT as well, and probably update the last
return -EINVAL statement in the function to be return -ENOENT. In general,
I'd say that returning -ENOENT if a register is specified that's
< __MAX_BPF_GETREG seems like the most intuitive API.

> +#else

Is it necessary to have this ifdef check here if you also have it in
bpf_read_sse_reg()? Maybe it makes more sense to keep this preprocessor
check, and compile out bpf_read_sse_reg() altogether on other
architectures? I think that probably makes sense given that we likely also
want to wrap __bpf_sse_read() in an ifdef given that it emits x86 asm, and
getreg_read_xmm_fxsave() which relies on the x86 definition of struct
thread_struct.

> +		if (size != XMM_REG_SZ)
> +			return -EINVAL;
> +
> +		return bpf_read_sse_reg(reg, flags, tsk, dst);
> +	}
> +
> +	return -EINVAL;
> +#endif
> +}
> +
> +BTF_ID_LIST(bpf_get_reg_val_ids)
> +BTF_ID(struct, pt_regs)
> +
> +static const struct bpf_func_proto bpf_get_reg_val_proto = {
> +	.func	= get_reg_val,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg2_type	= ARG_CONST_SIZE,
> +	.arg3_type	= ARG_ANYTHING,
> +	.arg4_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
> +	.arg4_btf_id	= &bpf_get_reg_val_ids[0],
> +	.arg5_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
> +	.arg5_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
> +};
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -1287,6 +1433,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_find_vma_proto;
>  	case BPF_FUNC_trace_vprintk:
>  		return bpf_get_trace_vprintk_proto();
> +	case BPF_FUNC_get_reg_val:
> +		return &bpf_get_reg_val_proto;
>  	default:
>  		return bpf_base_func_proto(func_id);
>  	}
> diff --git a/kernel/trace/bpf_trace.h b/kernel/trace/bpf_trace.h
> index 9acbc11ac7bb..b4b55706c2dd 100644
> --- a/kernel/trace/bpf_trace.h
> +++ b/kernel/trace/bpf_trace.h
> @@ -29,6 +29,7 @@ TRACE_EVENT(bpf_trace_printk,
>  
>  #undef TRACE_INCLUDE_PATH
>  #define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE bpf_trace
>  
>  #include <trace/define_trace.h>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 444fe6f1cf35..3ef8f683ed9e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
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
> -- 
> 2.30.2
> 
