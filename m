Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080F64521D
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLGCjQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCjQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:39:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBE3F06A
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:39:14 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y4so15792952plb.2
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 18:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCnP9PLWmBUxi189gu0gTV1Is0JytEfbhGLQPgjMHhQ=;
        b=Q2Ff0+wcirjHZbNqkCLOJNYURrNh4t9b0iCQLXH/Xuh1ZbV5n5uh4nCQ4s9nlHZ4Im
         hkPXrxot49OW+DW3UpAv7n2GVSyrc0yCg681LxhEkX+UBx466vQG8GtPHLyvsnGs98HW
         19FF6N8os0EB0OY1EAQQ/tvoo/EE5m+EylogLupqJbDAOxZX243yfBnIVX053xU2mdWf
         JQZPSDMtBQmAfG/h7MpIgNtR0ip+O0Xbtdo4IW+Tv6Ka3By34MLXadsECGwSRc/fRq5q
         gPzUvCwPuLQCNUINzTowa20Vjk3pwCkSnXQp51uVDlPTErj7wPECPJUXMfNFSUX/cGEQ
         34Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCnP9PLWmBUxi189gu0gTV1Is0JytEfbhGLQPgjMHhQ=;
        b=aDdNDRQ8/FqbSmV3ao0yDqFAqpDshQb9Uk96jVWzkWZHEdINCC2Vn6htfq//nZlhVi
         FyphQLmCW7jH6jSKbaoxlqK0JvBlJLTYPo2DfFG/wAQuUESlaCcSUVP0VX4FiFRc0tLv
         6TRVoDVveE4gYgEZeTxS925TUtqI/6GaecxkP6+uKMET1+qO2Wp/GljDOasngC4wSIn7
         P8TKL1S49Ub5OOnJaKzt3R56ssjsgvTQeOo/POwCn2w5g6F7r89t6TtmuJVGdMjpewL8
         6E/G0FAG6IrukbdR/mEm0/qMdOL9TLnpcHd5+VoAwCfppqVzEbMnIvigXmu1PQiSlN2V
         aoDA==
X-Gm-Message-State: ANoB5plbeaEPeRTa9h/l0vvtRuBWkfaQ0P0yYDJh+XtPactRjtIQ0L4D
        j8/qlW1nQwBtr/WoCKCaCXI=
X-Google-Smtp-Source: AA0mqf73Z9d9yKT0OJTIWGednAvbBR+/AC/iI2EDa9GOeYvQ+2Gz2nGC9Li/Uav9MDoCLrbNM/BM2Q==
X-Received: by 2002:a17:902:9a4c:b0:189:85ed:e947 with SMTP id x12-20020a1709029a4c00b0018985ede947mr454972plv.54.1670380753965;
        Tue, 06 Dec 2022 18:39:13 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00186cd4a8aedsm13208251plk.252.2022.12.06.18.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:39:13 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:39:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for
 insn->off < 0
Message-ID: <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-11-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:57PM -0800, Dave Marchevsky wrote:
> Current comment in BPF_PROBE_MEM jit code claims that verifier prevents
> insn->off < 0, but this appears to not be true irrespective of changes
> in this series. Regardless, changes in this series will result in an
> example like:
> 
>   struct example_node {
>     long key;
>     long val;
>     struct bpf_rb_node node;
>   }
> 
>   /* In BPF prog, assume root contains example_node nodes */
>   struct bpf_rb_node res = bpf_rbtree_first(&root);
>   if (!res)
>     return 1;
> 
>   struct example_node n = container_of(res, struct example_node, node);
>   long key = n->key;
> 
> Resulting in a load with off = -16, as bpf_rbtree_first's return is

Looks like the bug in the previous patch:
+                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
+                                  meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
+                               struct btf_field *field = meta.arg_rbtree_root.field;
+
+                               mark_reg_datastructure_node(regs, BPF_REG_0,
+                                                           &field->datastructure_head);

The R0 .off should have been:
 regs[BPF_REG_0].off = field->rb_node.node_offset;

node, not root.

PTR_TO_BTF_ID should have been returned with approriate 'off',
so that container_of() would it bring back to zero offset.

The apporach of returning untrusted from bpf_rbtree_first is questionable.
Without doing that this issue would not have surfaced.

All PTR_TO_BTF_ID need to have positive offset.
I'm not sure btf_struct_walk() and other PTR_TO_BTF_ID accessors
can deal with negative offsets.
There could be all kinds of things to fix.

> modified by verifier to be PTR_TO_BTF_ID of example_node w/ offset =
> offsetof(struct example_node, node), instead of PTR_TO_BTF_ID of
> bpf_rb_node. So it's necessary to support negative insn->off when
> jitting BPF_PROBE_MEM.

I'm not convinced it's necessary.
container_of() seems to be the only case where bpf prog can convert
PTR_TO_BTF_ID with off >= 0 to negative off.
Normal pointer walking will not make it negative.

> In order to ensure that page fault for a BPF_PROBE_MEM load of *src_reg +
> insn->off is safely handled, we must confirm that *src_reg + insn->off is
> in kernel's memory. Two runtime checks are emitted to confirm that:
> 
>   1) (*src_reg + insn->off) > boundary between user and kernel address
>   spaces
>   2) (*src_reg + insn->off) does not overflow to a small positive
>   number. This might happen if some function meant to set src_reg
>   returns ERR_PTR(-EINVAL) or similar.
> 
> Check 1 currently is sligtly off - it compares a
> 
>   u64 limit = TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
> 
> to *src_reg, aborting the load if limit is larger. Rewriting this as an
> inequality:
> 
>   *src_reg > TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off)
>   *src_reg - abs(insn->off) > TASK_SIZE_MAX + PAGE_SIZE
> 
> shows that this isn't quite right even if insn->off is positive, as we
> really want:
> 
>   *src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
>   *src_reg > TASK_SIZE_MAX + PAGE_SIZE - insn_off
> 
> Since *src_reg + insn->off is the address we'll be loading from, not
> *src_reg - insn->off or *src_reg - abs(insn->off). So change the
> subtraction to an addition and remove the abs(), as comment indicates
> that it was only added to ignore negative insn->off.
> 
> For Check 2, currently "does not overflow to a small positive number" is
> confirmed by emitting an 'add insn->off, src_reg' instruction and
> checking for carry flag. While this works fine for a positive insn->off,
> a small negative insn->off like -16 is almost guaranteed to wrap over to
> a small positive number when added to any kernel address.
> 
> This patch addresses this by not doing Check 2 at BPF prog runtime when
> insn->off is negative, rather doing a stronger check at JIT-time. The
> logic supporting this is as follows:
> 
> 1) Assume insn->off is negative, call the largest such negative offset
>    MAX_NEGATIVE_OFF. So insn->off >= MAX_NEGATIVE_OFF for all possible
>    insn->off.
> 
> 2) *src_reg + insn->off will not wrap over to an unexpected address by
>    virtue of negative insn->off, but it might wrap under if
>    -insn->off > *src_reg, as that implies *src_reg + insn->off < 0
> 
> 3) Inequality (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + PAGE_SIZE)
>    must be true since insn->off is negative.
> 
> 4) If we've completed check 1, we know that
>    src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off)
> 
> 5) Combining statements 3 and 4, we know src_reg > (TASK_SIZE_MAX + PAGE_SIZE)
> 
> 6) By statements 1, 4, and 5, if we can prove
>    (TASK_SIZE_MAX + PAGE_SIZE) > -MAX_NEGATIVE_OFF, we'll know that
>    (TASK_SIZE_MAX + PAGE_SIZE) > -insn->off for all possible insn->off
>    values. We can rewrite this as (TASK_SIZE_MAX + PAGE_SIZE) +
>    MAX_NEGATIVE_OFF > 0.
> 
>    Since src_reg > TASK_SIZE_MAX + PAGE_SIZE and MAX_NEGATIVE_OFF is
>    negative, if the previous inequality is true,
>    src_reg + MAX_NEGATIVE_OFF > 0 is also true for all src_reg values.
>    Similarly, since insn->off >= MAX_NEGATIVE_OFF for all possible
>    negative insn->off vals, src_reg + insn->off > 0 and there can be no
>    wrapping under.
> 
> So proving (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 implies
> *src_reg + insn->off > 0 for any src_reg that's passed check 1 and any
> negative insn->off. Luckily the former inequality does not need to be
> checked at runtime, and in fact could be a static_assert if
> TASK_SIZE_MAX wasn't determined by a function when CONFIG_X86_5LEVEL
> kconfig is used.
> 
> Regardless, we can just check (TASK_SIZE_MAX + PAGE_SIZE) +
> MAX_NEGATIVE_OFF > 0 once per do_jit call instead of emitting a runtime
> check. Given that insn->off is a s16 and is unlikely to grow larger,
> this check should always succeed on any x86 processor made in the 21st
> century. If it doesn't fail all do_jit calls and complain loudly with
> the assumption that the BPF subsystem is misconfigured or has a bug.
> 
> A few instructions are saved for negative insn->offs as a result. Using
> the struct example_node / off = -16 example from before, code looks
> like:

This is quite complex to review. I couldn't convince myself
that droping 2nd check is safe, but don't have an argument to
prove that it's not safe.
Let's get to these details when there is need to support negative off.

> 
> BEFORE CHANGE
>   72:   movabs $0x800000000010,%r11
>   7c:   cmp    %r11,%rdi
>   7f:   jb     0x000000000000008d         (check 1 on 7c and here)
>   81:   mov    %rdi,%r11
>   84:   add    $0xfffffffffffffff0,%r11   (check 2, will set carry for almost any r11, so bug for
>   8b:   jae    0x0000000000000091          negative insn->off)
>   8d:   xor    %edi,%edi                  (as a result long key = n->key; will be 0'd out here)
>   8f:   jmp    0x0000000000000095
>   91:   mov    -0x10(%rdi),%rdi
>   95:
> 
> AFTER CHANGE:
>   5a:   movabs $0x800000000010,%r11
>   64:   cmp    %r11,%rdi
>   67:   jae    0x000000000000006d     (check 1 on 64 and here, but now JNC instead of JC)
>   69:   xor    %edi,%edi              (no check 2, 0 out if %rdi - %r11 < 0)
>   6b:   jmp    0x0000000000000071
>   6d:   mov    -0x10(%rdi),%rdi
>   71:
> 
> We could do the same for insn->off == 0, but for now keep code
> generation unchanged for previously working nonnegative insn->offs.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 123 +++++++++++++++++++++++++++---------
>  1 file changed, 92 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 36ffe67ad6e5..843f619d0d35 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -11,6 +11,7 @@
>  #include <linux/bpf.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> +#include <linux/limits.h>
>  #include <asm/extable.h>
>  #include <asm/set_memory.h>
>  #include <asm/nospec-branch.h>
> @@ -94,6 +95,7 @@ static int bpf_size_to_x86_bytes(int bpf_size)
>   */
>  #define X86_JB  0x72
>  #define X86_JAE 0x73
> +#define X86_JNC 0x73
>  #define X86_JE  0x74
>  #define X86_JNE 0x75
>  #define X86_JBE 0x76
> @@ -950,6 +952,36 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>  	*pprog = prog;
>  }
>  
> +/* Check that condition necessary for PROBE_MEM handling for insn->off < 0
> + * holds.
> + *
> + * This could be a static_assert((TASK_SIZE_MAX + PAGE_SIZE) > -S16_MIN),
> + * but TASK_SIZE_MAX can't always be evaluated at compile time, so let's not
> + * assume insn->off size either
> + */
> +static int check_probe_mem_task_size_overflow(void)
> +{
> +	struct bpf_insn insn;
> +	s64 max_negative;
> +
> +	switch (sizeof(insn.off)) {
> +	case 2:
> +		max_negative = S16_MIN;
> +		break;
> +	default:
> +		pr_err("bpf_jit_error: unexpected bpf_insn->off size\n");
> +		return -EFAULT;
> +	}
> +
> +	if (!((TASK_SIZE_MAX + PAGE_SIZE) > -max_negative)) {
> +		pr_err("bpf jit error: assumption does not hold:\n");
> +		pr_err("\t(TASK_SIZE_MAX + PAGE_SIZE) + (max negative insn->off) > 0\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>  
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> @@ -967,6 +999,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>  	u8 *prog = temp;
>  	int err;
>  
> +	err = check_probe_mem_task_size_overflow();
> +	if (err)
> +		return err;
> +
>  	detect_reg_usage(insn, insn_cnt, callee_regs_used,
>  			 &tail_call_seen);
>  
> @@ -1359,20 +1395,30 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_MEM | BPF_DW:
>  		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
>  			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
> -				/* Though the verifier prevents negative insn->off in BPF_PROBE_MEM
> -				 * add abs(insn->off) to the limit to make sure that negative
> -				 * offset won't be an issue.
> -				 * insn->off is s16, so it won't affect valid pointers.
> -				 */
> -				u64 limit = TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
> -				u8 *end_of_jmp1, *end_of_jmp2;
> -
>  				/* Conservatively check that src_reg + insn->off is a kernel address:
> -				 * 1. src_reg + insn->off >= limit
> -				 * 2. src_reg + insn->off doesn't become small positive.
> -				 * Cannot do src_reg + insn->off >= limit in one branch,
> -				 * since it needs two spare registers, but JIT has only one.
> +				 * 1. src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
> +				 * 2. src_reg + insn->off doesn't overflow and become small positive
> +				 *
> +				 * For check 1, to save regs, do
> +				 * src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off) call rhs
> +				 * of inequality 'limit'
> +				 *
> +				 * For check 2:
> +				 * If insn->off is positive, add src_reg + insn->off and check
> +				 * overflow directly
> +				 * If insn->off is negative, we know that
> +				 *   (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + PAGE_SIZE)
> +				 * and from check 1 we know
> +				 *   src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off)
> +				 * So if (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 we can
> +				 * be sure that src_reg + insn->off won't overflow in either
> +				 * direction and avoid runtime check entirely.
> +				 *
> +				 * check_probe_mem_task_size_overflow confirms the above assumption
> +				 * at the beginning of this function
>  				 */
> +				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - insn->off;
> +				u8 *end_of_jmp1, *end_of_jmp2;
>  
>  				/* movabsq r11, limit */
>  				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
> @@ -1381,32 +1427,47 @@ st:			if (is_imm8(insn->off))
>  				/* cmp src_reg, r11 */
>  				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
>  				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
> -				/* if unsigned '<' goto end_of_jmp2 */
> -				EMIT2(X86_JB, 0);
> -				end_of_jmp1 = prog;
> -
> -				/* mov r11, src_reg */
> -				emit_mov_reg(&prog, true, AUX_REG, src_reg);
> -				/* add r11, insn->off */
> -				maybe_emit_1mod(&prog, AUX_REG, true);
> -				EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
> -				/* jmp if not carry to start_of_ldx
> -				 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
> -				 * that has to be rejected.
> -				 */
> -				EMIT2(0x73 /* JNC */, 0);
> -				end_of_jmp2 = prog;
> +				if (insn->off >= 0) {
> +					/* cmp src_reg, r11 */
> +					/* if unsigned '<' goto end_of_jmp2 */
> +					EMIT2(X86_JB, 0);
> +					end_of_jmp1 = prog;
> +
> +					/* mov r11, src_reg */
> +					emit_mov_reg(&prog, true, AUX_REG, src_reg);
> +					/* add r11, insn->off */
> +					maybe_emit_1mod(&prog, AUX_REG, true);
> +					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
> +					/* jmp if not carry to start_of_ldx
> +					 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
> +					 * that has to be rejected.
> +					 */
> +					EMIT2(X86_JNC, 0);
> +					end_of_jmp2 = prog;
> +				} else {
> +					/* cmp src_reg, r11 */
> +					/* if unsigned '>=' goto start_of_ldx
> +					 * w/o needing to do check 2
> +					 */
> +					EMIT2(X86_JAE, 0);
> +					end_of_jmp1 = prog;
> +				}
>  
>  				/* xor dst_reg, dst_reg */
>  				emit_mov_imm32(&prog, false, dst_reg, 0);
>  				/* jmp byte_after_ldx */
>  				EMIT2(0xEB, 0);
>  
> -				/* populate jmp_offset for JB above to jump to xor dst_reg */
> -				end_of_jmp1[-1] = end_of_jmp2 - end_of_jmp1;
> -				/* populate jmp_offset for JNC above to jump to start_of_ldx */
>  				start_of_ldx = prog;
> -				end_of_jmp2[-1] = start_of_ldx - end_of_jmp2;
> +				if (insn->off >= 0) {
> +					/* populate jmp_offset for JB above to jump to xor dst_reg */
> +					end_of_jmp1[-1] = end_of_jmp2 - end_of_jmp1;
> +					/* populate jmp_offset for JNC above to jump to start_of_ldx */
> +					end_of_jmp2[-1] = start_of_ldx - end_of_jmp2;
> +				} else {
> +					/* populate jmp_offset for JAE above to jump to start_of_ldx */
> +					end_of_jmp1[-1] = start_of_ldx - end_of_jmp1;
> +				}
>  			}
>  			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>  			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
> -- 
> 2.30.2
> 
