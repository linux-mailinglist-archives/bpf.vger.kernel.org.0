Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3556E550D5F
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiFSWB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFSWB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 18:01:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFDF10F5
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 15:01:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a10so4859367wmj.5
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=7Z9tDV2LqrB8IS76zUtMfJVE/NgW8s330KRzLpM6Lk8=;
        b=ALhqI5373arK/GlIVFtn2VZTkcMubEWNAUcAqP5G8hDdUYtxhLxgoYTgwdlGOR+pOx
         jVEroFyOuZQkicgVdOjZVcnD5B2adJSydEDhBSxIeCIffYxhktQ4Q7mWJJ1udwx+TK4K
         AcZEmf0+vRbNloUs5FvuBV9QP/paQ2ne/dZuSlERKStv0hYRmTklpFZHD0ZPtE3kyPP4
         mxWHwwQOFWnnMrWDW1eyJBcqpITR33FJ3Bf+UksbYlK89G03T9zaiAbc0J2nRe8aw5Ss
         W9Gadq4tdOfK2j5rhVycIeS4jzaFVSdC70fY1CJpEPLlGkYFFPiruclHl2/VUQFsgTFo
         uffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=7Z9tDV2LqrB8IS76zUtMfJVE/NgW8s330KRzLpM6Lk8=;
        b=Y8gB61WhJlDskHvO0rAa9HHq344UwmS0ZmcfUc1yBxjOhh2Hop7O8RBK52n48wmgqy
         GMlS6HzXGcs1UmGJwueP36b7Wu9t6kIFBVh3xmhVN8agbK1+rm4cC9EpKj3HqZdpwB/l
         +HEcfDpyr6S9YAOEes3HPmVHHUfCD5nx5qXdf11BTEu7j5EnIIlMpavqRnLXf93AKMnV
         PKNhRt8DM0rJk/izSi8xwkJJr0ic8Msh3taVxTv5nYL956/n6kFxT6eKZ7canULVzkgL
         Q3ZcuiejnXKNd7mV8L6pcyriefvL6r8ULFtdHpmuV6CBSbUEkBai6JgSWWcFEu7QsORg
         O+QQ==
X-Gm-Message-State: AJIora+P/v7K6t98Y7krAcQwAswzgzy/cLD5IVZTNFqErOhJ+8HvN/q3
        Y6CVNE/yn832s+yv62uRDgo=
X-Google-Smtp-Source: AGRyM1uD6ni7KEI10tRnWBnwVEu0T49cEzT48FxrZNHE4hL3Cfb5GloIBh2/XdrnjtoKpHkqJEZr6A==
X-Received: by 2002:a05:600c:4e09:b0:39c:6c5d:c753 with SMTP id b9-20020a05600c4e0900b0039c6c5dc753mr21591380wmq.34.1655676085873;
        Sun, 19 Jun 2022 15:01:25 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0039c50d2d28csm17025595wmq.44.2022.06.19.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 15:01:24 -0700 (PDT)
Message-ID: <b3441513293da1e7e25767446ed5c30592d190e4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 20 Jun 2022 01:01:22 +0300
In-Reply-To: <20220619211028.tuhgxmtivvwkzo7m@macbook-pro-3.dhcp.thefacebook.com>
References: <20220613205008.212724-1-eddyz87@gmail.com>
         <20220613205008.212724-4-eddyz87@gmail.com>
         <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
         <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
         <20220619211028.tuhgxmtivvwkzo7m@macbook-pro-3.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, 2022-06-19 at 14:10 -0700, Alexei Starovoitov wrote:
[...]
> yes.
> Just BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0) and ,1) in the other branch
> should do it.
> The 'mov' won't make the register precise.
>=20
> So something like below:
>=20
> r0 =3D random_u32
> r6 =3D random_u32
> if (r0)
>    goto L;
>=20
> r4 =3D 0
>=20
> pruning_point:
> if (r6) goto next;
> next:
> /* load callback address to r2 */
> BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 5)=
,
> BPF_RAW_INSN(0, 0, 0, 0, 0),
> BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> BPF_EXIT_INSN(),
>=20
> L:
> r4 =3D 1
> goto pruning_point
>=20
> The fallthrough path will proceed with r4=3D0
> and pruning will trigger is_state_visited() with r4=3D1
> which regsafe will incorrectly recognize as equivalent.
>=20

Actually this was the first thing I tried. Here is the pseudo code
above translated to BPF instructions:

	/* main */
	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_0),
	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
	BPF_ALU64_REG(BPF_MOV, BPF_REG_7, BPF_REG_0),
	BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 9),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 0),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 7),
	BPF_RAW_INSN(0, 0, 0, 0, 0),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
	BPF_EXIT_INSN(),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
	BPF_JMP_IMM(BPF_JA, 0, 0, -10),
	/* callback */
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
	BPF_EXIT_INSN(),=09

And here is the verification log for this program:

	#195/p don't inline bpf_loop call, flags non-zero 2 , verifier log:
	func#0 @0
	func#1 @16
	reg type unsupported for arg#0 function main#6
=09
	from -1 to 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
	0: (85) call bpf_jiffies64#118        ; R0_w=3DPscalar()
	1: (bf) r6 =3D r0                       ; R0_w=3DPscalar(id=3D1) R6_w=3DPs=
calar(id=3D1)
	2: (85) call bpf_jiffies64#118        ; R0_w=3DPscalar()
	3: (bf) r7 =3D r0                       ; R0_w=3DPscalar(id=3D2) R7_w=3DPs=
calar(id=3D2)
	4: (55) if r6 !=3D 0x0 goto pc+9        ; R6_w=3DP0
-->	5: (b7) r4 =3D 0                        ; R4_w=3DP0
	6: (55) if r7 !=3D 0x0 goto pc+0        ; R7_w=3DP0
	7: (b7) r1 =3D 1                        ; R1_w=3DP1
	8: (18) r2 =3D 0x7                      ; R2_w=3Dfunc(off=3D0,imm=3D0)
	10: (b7) r3 =3D 0                       ; R3_w=3DP0
	11: (85) call bpf_loop#181
	reg type unsupported for arg#1 function callback#7
	caller:
	 R6=3DP0 R7=3DP0 R10=3Dfp0
	callee:
	 frame1: R1=3DPscalar() R2_w=3DP0 R10=3Dfp0 cb
	16: frame1: R1_w=3DPscalar() R2_w=3DP0 cb
	16: (b7) r0 =3D 1                       ; frame1: R0_w=3DP1 cb
	17: (95) exit
	returning from callee:
	 frame1: R0_w=3DP1 R1_w=3DPscalar() R2_w=3DP0 R10=3Dfp0 cb
	to caller at 12:
	 R0_w=3DPscalar() R6=3DP0 R7=3DP0 R10=3Dfp0
=09
	from 17 to 12: R0_w=3DPscalar() R6=3DP0 R7=3DP0 R10=3Dfp0
	12: (b7) r0 =3D 0                       ; R0_w=3DP0
	13: (95) exit
	propagating r4
=09
	from 6 to 7: safe
=09
	from 4 to 14: R0=3DPscalar(id=3D2) R6=3DPscalar(id=3D1) R7=3DPscalar(id=3D=
2) R10=3Dfp0
-->	14: (b7) r4 =3D 1                       ; R4_w=3DP1
	15: (05) goto pc-10
	6: (55) if r7 !=3D 0x0 goto pc+0        ; R7=3DP0
	7: (b7) r1 =3D 1                        ; R1_w=3DP1
	8: (18) r2 =3D 0x7                      ; R2_w=3Dfunc(off=3D0,imm=3D0)
	10: (b7) r3 =3D 0                       ; R3_w=3DP0
	11: (85) call bpf_loop#181
	[...]

Note that for instructions [5] and [14] R4 is marked as precise. I
actually verified in the debugger that this happens because of the
following processing logic for MOV:

#0  check_alu_op (...) at kernel/bpf/verifier.c:9177
#1  ... in do_check (...) at kernel/bpf/verifier.c:12100
#2  do_check_common (...) at kernel/bpf/verifier.c:14552
#3  ... in do_check_main () at kernel/bpf/verifier.c:14615

The C code for relevant functions is below. Note that call to
`__mark_reg_unknown` will mark the register as precise when
`env->subprog_cnt > 1`, but for this test case it is 2.

static int do_check(struct bpf_verifier_env *env)
{
	...
		if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
12100:			err =3D check_alu_op(env, insn);
			if (err)
				return err;

		} else ...
	...
}

static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn=
)
{
	...
	else if (opcode =3D=3D BPF_MOV) {
		...
		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
			...
		} else {
			/* case: R =3D imm
			 * remember the value we stored into this reg
			 */
			/* clear any state __mark_reg_known doesn't set */
			mark_reg_unknown(env, regs, insn->dst_reg);
			regs[insn->dst_reg].type =3D SCALAR_VALUE;
			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
9177:				__mark_reg_known(regs + insn->dst_reg,
						 insn->imm);
			} else {
				__mark_reg_known(regs + insn->dst_reg,
						 (u32)insn->imm);
			}
		}
		...
	}
	...
}

/* Mark a register as having a completely unknown (scalar) value. */
static void __mark_reg_unknown(const struct bpf_verifier_env *env,
			       struct bpf_reg_state *reg)
{
	...
	reg->precise =3D env->subprog_cnt > 1 || !env->bpf_capable;
	...
}

static void mark_reg_unknown(struct bpf_verifier_env *env,
			     struct bpf_reg_state *regs, u32 regno)
{
	...
	__mark_reg_unknown(env, regs + regno);
}

Thanks,
Eduard
