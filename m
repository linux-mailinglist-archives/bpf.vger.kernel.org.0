Return-Path: <bpf+bounces-17295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750980B142
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A629FB20BFF
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC90080E;
	Sat,  9 Dec 2023 01:10:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CFDA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 17:10:17 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8M1RA7013204
	for <bpf@vger.kernel.org>; Fri, 8 Dec 2023 17:10:17 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uudj661dt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 17:10:16 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 8 Dec 2023 17:10:15 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 473263CD4E3E9; Fri,  8 Dec 2023 17:09:59 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack with BPF_ST_MEM instruction
Date: Fri, 8 Dec 2023 17:09:57 -0800
Message-ID: <20231209010958.66758-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5TVfsdhx4YRrToE85L4yngq8HLEF1F8T
X-Proofpoint-ORIG-GUID: 5TVfsdhx4YRrToE85L4yngq8HLEF1F8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_16,2023-12-07_01,2023-05-22_02

When verifier validates BPF_ST_MEM instruction that stores known
constant to stack (e.g., *(u64 *)(r10 - 8) =3D 123), it effectively spill=
s
a fake register with a constant (but initially imprecise) value to
a stack slot. Because read-side logic treats it as a proper register
fill from stack slot, we need to mark such stack slot initialization as
INSN_F_STACK_ACCESS instruction to stop precision backtracking from
missing it.

Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from st=
ack in precision tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb690539d5f6..727a59e4a647 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4498,7 +4498,6 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type =3D SCALAR_VALUE;
 		save_register_state(env, state, spi, &fake_reg, size);
-		insn_flags =3D 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size !=3D BPF_REG_SIZE) {
--=20
2.34.1


