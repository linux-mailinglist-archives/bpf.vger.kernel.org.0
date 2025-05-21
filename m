Return-Path: <bpf+bounces-58635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7BABEA65
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 05:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702607B61FE
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 03:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17822E3E3;
	Wed, 21 May 2025 03:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874E22DA1E
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797674; cv=none; b=gKCbmLPAR8V1C8rdj9jKaVUmoWqPF6mBjHTYu5TYMMNDPDKPBQyhVUSMsTn62M8y8z66vabP9KzpuVM/FYl6aQSdOtllHrCUzR0sazZejPIMDQeZcj4PjmfgVXOf71y3wbwZ0nKU7f+ZoXxXBSAf5qzsswAheCJLGrLVdwYEP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797674; c=relaxed/simple;
	bh=1d1TQcT9MI8zCazNhjQSrTGynne2JeAE7oy5/3ffBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roU5wiQ9fOBVvta4lmSc7fHIv1cYanhCRMP+hRrMGF6EGSR2aHQTn0LKVXcaBUvsGVum5AkRiqOyJVf/eviQMWQvcghYqPal/Ozy5mps/GTazpGV7i9n8HwlWSvvEZTUW2uUcB5hTGbNiUY/TPDW8KcS6aIhniEpfTuR/dB0Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EB2937E53FC2; Tue, 20 May 2025 20:20:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/3] bpf: Warn with bpf_unreachable() kfunc maybe due to uninitialized variable
Date: Tue, 20 May 2025 20:20:57 -0700
Message-ID: <20250521032057.1016838-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521032047.1015381-1-yonghong.song@linux.dev>
References: <20250521032047.1015381-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
uninitialized variable caused generating bpf prog binary code not
working as expected. The reproducer is in [1] where the flags
=E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning as t=
he compiler
takes advantage of uninitialized variable to do aggressive optimization.
The optimized code looks like below:

      ; {
           0:       bf 16 00 00 00 00 00 00 r6 =3D r1
      ;       bpf_printk("Start");
           1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D=
 0x0 ll
                    0000000000000008:  R_BPF_64_64  .rodata
           3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
           4:       85 00 00 00 06 00 00 00 call 0x6
      ; DEFINE_FUNC_CTX_POINTER(data)
           5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c)
      ;       bpf_printk("pre ipv6_hdrlen_offset");
           6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 =3D=
 0x6 ll
                    0000000000000030:  R_BPF_64_64  .rodata
           8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
           9:       85 00 00 00 06 00 00 00 call 0x6
      <END>

The verifier will report the following failure:
  9: (85) call bpf_trace_printk#6
  last insn is not an exit or jmp

The above verifier log does not give a clear hint about how to fix
the problem and user may take quite some time to figure out that
the issue is due to compiler taking advantage of uninitialized variable.

In llvm internals, uninitialized variable usage may generate
'unreachable' IR insn and these 'unreachable' IR insns may indicate
uninitialized variable impact on code optimization. So far, llvm
BPF backend ignores 'unreachable' IR hence the above code is generated.
With clang21 patch [2], those 'unreachable' IR insn are converted
to func bpf_unreachable(). In order to maintain proper control flow
graph for bpf progs, [2] also adds an 'exit' insn after bpf_unreachable()
if bpf_unreachable() is the last insn in the function.
The new code looks like:

      ; {
           0:       bf 16 00 00 00 00 00 00 r6 =3D r1
      ;       bpf_printk("Start");
           1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D=
 0x0 ll
                    0000000000000008:  R_BPF_64_64  .rodata
           3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
           4:       85 00 00 00 06 00 00 00 call 0x6
      ; DEFINE_FUNC_CTX_POINTER(data)
           5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c)
      ;       bpf_printk("pre ipv6_hdrlen_offset");
           6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 =3D=
 0x6 ll
                    0000000000000030:  R_BPF_64_64  .rodata
           8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
           9:       85 00 00 00 06 00 00 00 call 0x6
          10:       85 10 00 00 ff ff ff ff call -0x1
                    0000000000000050:  R_BPF_64_32  bpf_unreachable
          11:       95 00 00 00 00 00 00 00 exit
      <END>

In kernel, a new kfunc bpf_unreachable() is added. During insn
verification, any hit with bpf_unreachable() will result in
verification failure. The kernel is able to provide better
log message for debugging.

With llvm patch [2] and without this patch (no bpf_unreachable()
kfunc for existing kernel), e.g., for old kernels, the verifier
outputs
  10: <invalid kfunc call>
  kfunc 'bpf_unreachable' is referenced but wasn't resolved
Basically, kernel does not support bpf_unreachable() kfunc.
This still didn't give clear signals about possible reason.

With llvm patch [2] and with this patch, the verifier outputs
  10: (85) call bpf_unreachable#74479
  unexpected bpf_unreachable() due to uninitialized variable?
It gives much better hints for verification failure.

  [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
  [2] https://github.com/llvm/llvm-project/pull/131731

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c  | 5 +++++
 kernel/bpf/verifier.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..4852c36b1c51 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3273,6 +3273,10 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned lo=
ng *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
=20
+__bpf_kfunc void bpf_unreachable(void)
+{
+}
+
 __bpf_kfunc_end_defs();
=20
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3386,6 +3390,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SL=
EEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRU=
STED_ARGS)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF=
_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_unreachable)
 BTF_KFUNCS_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7be97a8419f8..b5be9ff34c60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12105,6 +12105,7 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_unlock,
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
+	KF_bpf_unreachable,
 };
=20
 BTF_ID_LIST(special_kfunc_list)
@@ -12170,6 +12171,7 @@ BTF_ID(func, bpf_res_spin_lock)
 BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
+BTF_ID(func, bpf_unreachable)
=20
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -13638,6 +13640,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			return err;
 		}
 		__mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
+	} else if (!insn->off && insn->imm =3D=3D special_kfunc_list[KF_bpf_unr=
eachable]) {
+		verbose(env, "unexpected bpf_unreachable() due to uninitialized variab=
le?\n");
+		return -EFAULT;
 	}
=20
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
--=20
2.47.1


