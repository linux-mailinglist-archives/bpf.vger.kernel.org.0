Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869C65C5CD
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 19:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjACSMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 13:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjACSMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 13:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FAE7F;
        Tue,  3 Jan 2023 10:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0199A614B8;
        Tue,  3 Jan 2023 18:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB502C433EF;
        Tue,  3 Jan 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769525;
        bh=xPTONxYTtJqAfLr329AYZvkB7QNlHmA83t7R/LUR6tk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UitcWki67SW8Yaw+gzxlB+xfxHuJUYr5//DsFeyELyyhtzpfQBr293EID2MYOCC2+
         Cx8YmX5Tx52hkCAAZgpV5lcUztlxLcqY6egDV6miPF391jPIDXarRKeBOtHn+LhLGz
         oea6rMnLEU3BWg7EZffrInAHyFn4o5mc63+hLBPwTn6y6HHKTJVtugJq1IKHv2Nf5G
         YjYTIj5xQSaMBZSYNoEQ0wxhYlvFup/ouPUmIuNxsX6zraGPyJpFFDWLzPF9QMdaln
         YX5swWnvzQ+sKFfNkANzymsEBX/099LLHhpwWXsZWSVHBGESdCjbYbBtaq2dAe4Xfg
         LPFrkOKtuht1g==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [RFC PATCH RESEND bpf-next 3/4] riscv, bpf: Add
 bpf_arch_text_poke support for RV64
In-Reply-To: <20221220021319.1655871-4-pulehui@huaweicloud.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-4-pulehui@huaweicloud.com>
Date:   Tue, 03 Jan 2023 19:12:02 +0100
Message-ID: <871qobqyh9.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Implement bpf_arch_text_poke for RV64. For call scenario,
> ftrace framework reserve 4 nops for RV64 kernel function
> as function entry, and use auipc+jalr instructions to call
> kernel or module functions. However, since the auipc+jalr
> call instructions is non-atomic operation, we need to use
> stop-machine to make sure instruction patching in atomic
> context. As for jump scenario, since we only jump inside
> the trampoline, a jal instruction is sufficient.

Hmm, is that really true? More below!

>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h        |   5 ++
>  arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
>  2 files changed, 134 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index d926e0f7ef57..bf9802a63061 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
>  	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
>  }
>=20=20
> +static inline u32 rv_nop(void)
> +{
> +	return rv_i_insn(0, 0, 0, 0, 0x13);
> +}
> +
>  /* RVC instrutions. */
>=20=20
>  static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index bf4721a99a09..fa8b03c52463 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -8,6 +8,8 @@
>  #include <linux/bitfield.h>
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
> +#include <linux/memory.h>
> +#include <linux/stop_machine.h>
>  #include "bpf_jit.h"
>=20=20
>  #define RV_REG_TCC RV_REG_A6
> @@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, struc=
t rv_jit_context *ctx)
>  	if (!is_tail_call)
>  		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>  	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
> -		  is_tail_call ? 4 : 0, /* skip TCC init */
> +		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
>  		  ctx);
>  }
>=20=20
> @@ -615,6 +617,127 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>  	return 0;
>  }
>=20=20
> +struct text_poke_args {
> +	void *addr;
> +	const void *insns;
> +	size_t len;
> +	atomic_t cpu_count;
> +};
> +
> +static int do_text_poke(void *data)
> +{
> +	int ret =3D 0;
> +	struct text_poke_args *patch =3D data;
> +
> +	if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()) {
> +		ret =3D patch_text_nosync(patch->addr, patch->insns, patch->len);
> +		atomic_inc(&patch->cpu_count);
> +	} else {
> +		while (atomic_read(&patch->cpu_count) <=3D num_online_cpus())
> +			cpu_relax();
> +		smp_mb();
> +	}
> +
> +	return ret;
> +}
> +
> +static int bpf_text_poke_stop_machine(void *addr, const void *insns, siz=
e_t len)
> +{
> +	struct text_poke_args patch =3D {
> +		.addr =3D addr,
> +		.insns =3D insns,
> +		.len =3D len,
> +		.cpu_count =3D ATOMIC_INIT(0),
> +	};
> +
> +	return stop_machine(do_text_poke, &patch, cpu_online_mask);
> +}
> +
> +static int gen_call_or_nops(void *target, void *ip, u32 *insns)
> +{
> +	int i, ret;
> +	s64 rvoff;
> +	struct rv_jit_context ctx;
> +
> +	ctx.ninsns =3D 0;
> +	ctx.insns =3D (u16 *)insns;
> +
> +	if (!target) {
> +		for (i =3D 0; i < 4; i++)
> +			emit(rv_nop(), &ctx);
> +		return 0;
> +	}
> +
> +	rvoff =3D (s64)(target - ip);
> +	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
> +	ret =3D emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
> +	if (ret)
> +		return ret;
> +	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
> +
> +	return 0;
> +
> +}
> +
> +static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
> +{
> +	int ret;
> +	u32 old_insns[4], new_insns[4];
> +
> +	ret =3D gen_call_or_nops(old_addr, ip + 4, old_insns);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D gen_call_or_nops(new_addr, ip + 4, new_insns);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&text_mutex);
> +	if (memcmp(ip, old_insns, sizeof(old_insns))) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	if (memcmp(ip, new_insns, sizeof(new_insns)))
> +		ret =3D bpf_text_poke_stop_machine(ip, new_insns,
> sizeof(new_insns));

I'd rather see that you added a patch_text variant to
arch/riscv/kernel/patch.c (something like your
bpf_text_poke_stop_machine()), and use that here. Might be other users
of that as well -- Andy's ftrace patch maybe? :-)

> +out:
> +	mutex_unlock(&text_mutex);
> +	return ret;
> +}
> +
> +static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
> +{
> +	int ret;
> +	u32 old_insn, new_insn;
> +
> +	old_insn =3D old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) >> 1) =
: rv_nop();
> +	new_insn =3D new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) >> 1) =
: rv_nop();
> +
> +	mutex_lock(&text_mutex);
> +	if (memcmp(ip, &old_insn, sizeof(old_insn))) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	if (memcmp(ip, &new_insn, sizeof(new_insn)))
> +		ret =3D patch_text_nosync(ip, &new_insn, sizeof(new_insn));
> +out:
> +	mutex_unlock(&text_mutex);
> +	return ret;
> +}
> +
> +int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
> +		       void *old_addr, void *new_addr)

AFAIU there's nothing in the bpf_arch_text_poke() API that say that
BPF_MOD_JUMP is jumps within the trampoline. That is one usage, but not
the only one. In general, the jal might not have enough reach.

I believe that this needs to be an auipc/jalr pair similar to
BPF_MOD_CALL (w/o linked register).=20


And again, thanks for working on the RV trampoline!
Bj=C3=B6rn
