Return-Path: <bpf+bounces-62286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD50AF76C9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC26E7B53FF
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C22E7F2F;
	Thu,  3 Jul 2025 14:11:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2368F2E7185
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551881; cv=none; b=jbzoB81A4e6QZd4wlz68vqxyZOeLE01BmweNmZhR/6rszrMcZ3Hks1VpNy4eP+gdjB08BX0wAAbEpqf+HmLfH28RdktqOZ/dKjEjSgJOClwVG3L/EHOP2G8Mft0qrIMNuBVaSajABCkHHrVSc74cbaGWj0uVJa8qforWQnJ39Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551881; c=relaxed/simple;
	bh=J1AK0Qa4Viw2rN/IKNKiUiCjdKs7wrS3qtaf4OpZXcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFvBwchWbx/fGEGmIJx1aSWShdOQFk8smChWdGkMWm50oxrtlW47OInUemb46koXpmyz+21vQXqasiZ5rHXv4dYpXxRYP5ojxTCiS4pDEn8Q87s+5WNzcHbtGl92v5wHZonUEeJmC0wq/gf//R/GXLk48KfC+f7Yjh6AWdOZOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CED63AC9F5BA; Thu,  3 Jul 2025 07:11:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Simplify assignment to struct bpf_insn pointer in do_misc_fixups()
Date: Thu,  3 Jul 2025 07:11:06 -0700
Message-ID: <20250703141106.1483216-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703141101.1482025-1-yonghong.song@linux.dev>
References: <20250703141101.1482025-1-yonghong.song@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


