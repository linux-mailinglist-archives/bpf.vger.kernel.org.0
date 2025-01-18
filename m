Return-Path: <bpf+bounces-49266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBCA15E93
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 20:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D83A65A5
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56201B0427;
	Sat, 18 Jan 2025 19:20:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B593194A73
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737228044; cv=none; b=Znii6zwBEzo8/J8snnsEaW14XCiuLHL1zxbVtoAl9UJdLmxDXnkpFEMTKWASR4u8vCvKjm9dcy67ACMV615L/fwMB2mG+fglQE8BLVxcNo90sUVPx+LlgA0AFoEfdYoBaOn9ZFNDL2WbUiPcFBqZcpT5rZSVU8VvU6y5sx7WpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737228044; c=relaxed/simple;
	bh=Mk0vZdqlUlkE0vlkuQHay0lp97Rj7BPgdJya+LKOjic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP29bODo7s+t/x5EKAnxCllnKwX0xVKZN0d9XPacMAsFC4mj1Mhy7MhrGNoO8INzSnCMg44RDzXKEHrJUBzdCvrsmWQy1og4XFT8LNRDonFwZKfH3pd+5UHeyk9X3aTALFvnQzTmvo8piTrx4K7Q/D71ARMGwlPEw8o9glvTY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8D546D1B48FF; Sat, 18 Jan 2025 11:20:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/3] bpf: Remove 'may_goto 0' instruction in opt_remove_nops()
Date: Sat, 18 Jan 2025 11:20:29 -0800
Message-ID: <20250118192029.2124584-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250118192019.2123689-1-yonghong.song@linux.dev>
References: <20250118192019.2123689-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since 'may_goto 0' insns are actually no-op, let us remove them.
Otherwise, verifier will generate code like
   /* r10 - 8 stores the implicit loop count */
   r11 =3D *(u64 *)(r10 -8)
   if r11 =3D=3D 0x0 goto pc+2
   r11 -=3D 1
   *(u64 *)(r10 -8) =3D r11

which is the pure overhead.

The following code patterns (from the previous commit) are also
handled:
   may_goto 2
   may_goto 1
   may_goto 0

With this commit, the above three 'may_goto' insns are all
eliminated.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 963dfda81c06..784547aa40a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20187,20 +20187,25 @@ static const struct bpf_insn NOP =3D BPF_JMP_IM=
M(BPF_JA, 0, 0, 0);
=20
 static int opt_remove_nops(struct bpf_verifier_env *env)
 {
+	const struct bpf_insn may_goto_0 =3D BPF_RAW_INSN(BPF_JMP | BPF_JCOND, =
0, 0, 0, 0);
 	const struct bpf_insn ja =3D NOP;
 	struct bpf_insn *insn =3D env->prog->insnsi;
 	int insn_cnt =3D env->prog->len;
+	bool is_may_goto_0, is_ja;
 	int i, err;
=20
 	for (i =3D 0; i < insn_cnt; i++) {
-		if (memcmp(&insn[i], &ja, sizeof(ja)))
+		is_may_goto_0 =3D !memcmp(&insn[i], &may_goto_0, sizeof(may_goto_0));
+		is_ja =3D !memcmp(&insn[i], &ja, sizeof(ja));
+
+		if (!is_may_goto_0 && !is_ja)
 			continue;
=20
 		err =3D verifier_remove_insns(env, i, 1);
 		if (err)
 			return err;
 		insn_cnt--;
-		i--;
+		i -=3D (is_may_goto_0 && i > 0) ? 2 : 1;
 	}
=20
 	return 0;
--=20
2.43.5


