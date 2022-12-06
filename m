Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EEB643DE0
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 08:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLFHzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 02:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiLFHzt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 02:55:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0215835;
        Mon,  5 Dec 2022 23:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE50B80DF3;
        Tue,  6 Dec 2022 07:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D69C433C1;
        Tue,  6 Dec 2022 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670313345;
        bh=Ws+/WeLvxVRVftbMkKZ45KNmqftKhEp+4sJrpNSl7W8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Akt6EXK463zbJVk8vj7pqEFLR0sdb/4Yob2ZKUli/56Vf/35f9UzxgX2xjFgkpDZX
         KNSo4q9Ngdo3c4XuIU9VXbXERskeiNCubROjs2lmFvd6+qu0oY75x3gni7p+dGu+mW
         J/WiEknNLgmLlmUFLIWy7MqhjimYk0Qeahju301o0jy1+BJ+aBjQN7/F+TfVB2vCOH
         cCPw/3+/1K64HF3622QTf6ZOd2pndNYBBQmSoUuS9QSHDMKbNc2x+Pxx4vnb+IfcHL
         quPT49Mx1L/W8GXWfpkEge3Ng9ROmFZinxeLlCLdcQkBRy+mlqHv+F4WKFA19t+qzL
         wmG4Hn25bz1ww==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf v2] riscv, bpf: Emit fixed-length instructions for
 BPF_PSEUDO_FUNC
In-Reply-To: <0ade59ea-6863-4d68-607c-22e4b9405a0d@huaweicloud.com>
References: <20221202094837.3872444-1-pulehui@huaweicloud.com>
 <87y1rq848x.fsf@all.your.base.are.belong.to.us>
 <0ade59ea-6863-4d68-607c-22e4b9405a0d@huaweicloud.com>
Date:   Tue, 06 Dec 2022 08:55:42 +0100
Message-ID: <87359t3r0h.fsf@all.your.base.are.belong.to.us>
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

> Sorry for replying so late. For BPF_PSEUDO_FUNC instruction, verifier=20
> will set insn[0].imm and insn[1].imm to 1 that make addr to 0x100000001=20
> before extra pass, and also ctx->insns is NULL in iteration stage, all=20
> of these make off out of range of AUIPC-ADDI range, and return failed.=20
> We could add some special handling at different stages, but that seems a=
=20
> little weird. By the way, I do not really like emit_addr function with=20
> return value.

My rational is that *if* for some reason the jit is passed an address
that auipc/addi can't represent, we'd like to catch that and not emit
broken code.

> While a proper address is at least 2B alignment, and the valid address=20
> is from 0xffffffff00000000 to 0xffffffffffffffff, we can make address=20
> shifed 1 place to right, and addr >> 1 will always in the range of=20
> AUIPC-ADDI range. We can get rid of the range detection. The=20
> implementation is as follows:
>
> static void emit_addr(u8 rd, u64 addr, struct rv_jit_context *ctx)
> {
>           s64 imm =3D addr >> 1;
>           s64 upper =3D (imm + (1 << 11)) >> 12;
>           s64 lower =3D imm & 0xfff;
>
>           emit(rv_lui(rd, upper), ctx);
>           emit(rv_addi(rd, rd, lower), ctx);
>           emit(rv_slli(rd, rd, 1), ctx);
> }
>
> What do you think?

That's a code generation penalty, instead of catching it at code
gen. Don't like! :-) I much prefer the auipc/addi version.

What do you think about the diff (on-top of your work) below?

--8<--
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index aa9410eef77c..7acaf28cb3be 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -137,15 +137,21 @@ static bool in_auipc_jalr_range(s64 val)
 }
=20
 /* Emit fixed-length instructions for address */
-static void emit_addr(u8 rd, u64 addr, struct rv_jit_context *ctx)
+static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct rv_jit_conte=
xt *ctx)
 {
 	u64 ip =3D (u64)(ctx->insns + ctx->ninsns);
 	s64 off =3D addr - ip;
 	s64 upper =3D (off + (1 << 11)) >> 12;
 	s64 lower =3D ((off & 0xfff) << 52) >> 52;
=20
+	if (extra_pass && !in_auipc_jalr_range(off)) {
+		pr_err("bpf-jit: target offset 0x%llx is out of range\n", off);
+		return -ERANGE;
+	}
+
 	emit(rv_auipc(rd, upper), ctx);
 	emit(rv_addi(rd, rd, lower), ctx);
+	return 0;
 }
=20
 /* Emit variable-length instructions for 32-bit and 64-bit imm */
@@ -1061,13 +1067,17 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
 	{
 		struct bpf_insn insn1 =3D insn[1];
 		u64 imm64;
+		int ret;
=20
 		imm64 =3D (u64)insn1.imm << 32 | (u32)imm;
-		if (bpf_pseudo_func(insn))
+		if (bpf_pseudo_func(insn)) {
 			/* fixed-length insns for extra jit pass */
-			emit_addr(rd, imm64, ctx);
-		else
+			ret =3D emit_addr(rd, imm64, extra_pass, ctx);
+			if (ret)
+				return ret;
+		} else {
 			emit_imm(rd, imm64, ctx);
+		}
=20
 		return 1;
 	}

--8<--

Wouldn't that work?


Bj=C3=B6rn
