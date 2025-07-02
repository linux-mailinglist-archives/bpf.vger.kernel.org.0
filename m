Return-Path: <bpf+bounces-62161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6AAF5F91
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EB13A7973
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AE82FF473;
	Wed,  2 Jul 2025 17:11:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B327A907
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476308; cv=none; b=rUIECfT7P9FRabAA/+On09r63SBgykKyV8UDso1iDFd3wVrnFp18p8rVuUZhOFVY9g722YDssC8+1eSasX6CESI6sd+D478qFeWPzXpb4JLkZ2jSOUyXQX3/VdSxepnNWBvwzKvAT5fh7FQ6S87uZ7i5MrknLODAG4+7DUU9jT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476308; c=relaxed/simple;
	bh=rP+ltmIGkW0TR396EDm/9x6Udvow20e1FxA+fvfYSP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwPZi8jxlsHxbreUEQt2AfP7UAvAahccABDmulFwasIyCh/DORc9hJLqBixjX71PVG7FO25OoZ5tatALqRlsbsq0sVsvguntVnj4hOM4tsbj5wUj9zkhO8zp9jtS0aOUebJ9Lu8MwpCaL/BGRSUUGB6CkaDpt9MKCjGz2/XRiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5EB65ABB2E56; Wed,  2 Jul 2025 10:11:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/3] bpf: Simplify assignment to struct bpf_insn pointer in do_misc_fixups()
Date: Wed,  2 Jul 2025 10:11:39 -0700
Message-ID: <20250702171139.2370585-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171134.2370432-1-yonghong.song@linux.dev>
References: <20250702171134.2370432-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In verifier.c, the following code patterns (in two places)
  struct bpf_insn *patch =3D &insn_buf[0];
can be simplified to
  struct bpf_insn *patch =3D insn_buf;
which is easier to understand.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52e36fd23f40..8b0a25851089 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22102,7 +22102,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 		if (BPF_CLASS(insn->code) =3D=3D BPF_LDX &&
 		    (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
 		     BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)) {
-			struct bpf_insn *patch =3D &insn_buf[0];
+			struct bpf_insn *patch =3D insn_buf;
 			u64 uaddress_limit =3D bpf_arch_uaddress_limit();
=20
 			if (!uaddress_limit)
@@ -22153,7 +22153,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 		    insn->code =3D=3D (BPF_ALU64 | BPF_SUB | BPF_X)) {
 			const u8 code_add =3D BPF_ALU64 | BPF_ADD | BPF_X;
 			const u8 code_sub =3D BPF_ALU64 | BPF_SUB | BPF_X;
-			struct bpf_insn *patch =3D &insn_buf[0];
+			struct bpf_insn *patch =3D insn_buf;
 			bool issrc, isneg, isimm;
 			u32 off_reg;
=20
--=20
2.47.1


