Return-Path: <bpf+bounces-57404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D4AAA5E0
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F11886B89
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26531A0CA;
	Mon,  5 May 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdrjVgXT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13949319A7E;
	Mon,  5 May 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484283; cv=none; b=butpdBNZ5Vuay2SQLe2iDGKeLHJAtjRqq3qtvteKi08T61iqgTga3eSAls0AREjvFhSwwa5Coz+PHWRYN1rbYghgXQBxyx3UxEHnqbNXVm+KQGYU61EYSGDVTNp+MzMrRXnbvl4L3PIUgT/Bs5WjXI2nT5IYO/3QYPRkZyac9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484283; c=relaxed/simple;
	bh=G12M4CtKtx7qFHucINM394sfRrI8vnfPPtR1s1+9uxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlwNeAioLzEFascJELwCsBXstvxUplX/Qm104FTvmpOvbfl3SaIY0CyrsXD5TArloekD2Wqp8E/FpV0LFrTxSV5jLH1nohLdAbVn/c7mB13Dp44OAmW2NHI9iQf8u2nqiruRTdmrycXlr0QAdFXFq0Su15sl5/HJlZULoSvnfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdrjVgXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87637C4CEEF;
	Mon,  5 May 2025 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484282;
	bh=G12M4CtKtx7qFHucINM394sfRrI8vnfPPtR1s1+9uxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdrjVgXTC3DCIBOtvGAPgt4XVRp5Yo1MQg2X3p37ilRbREMJQAceORGOAPqmtA4Gb
	 gu4C15U8PMVspWDwjEMO5Y/PMuj/hI19rowP7+R1755B9eOtBt9nTHTCUQymhu8d3w
	 dLQZV5k/9u5z6t/BaXNOO9ksRVtAZvrtkZ8MZ/TSdqBg/I4+UMFulItbAi6xf4Xcgk
	 0Klx9BWePWDKjJ0XaWf1haAfd4PGR1wSBQshyYZql4URve2o+QZrwbaJtizkndX4cS
	 vWAMs8+ZOemMR/vCkjYoc0ONZssVTCO+q8pyRw3fJgv4fN4f73M5u7ElIQ0kVcSeRB
	 Iw6mZ+/i0/8kA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 433/642] libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
Date: Mon,  5 May 2025 18:10:49 -0400
Message-Id: <20250505221419.2672473-433-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 06096d19ee3897a7e70922580159607fe315da7a ]

Libbpf has a somewhat obscure feature of automatically adjusting the
"size" of LDX/STX/ST instruction (memory store and load instructions),
based on originally recorded access size (u8, u16, u32, or u64) and the
actual size of the field on target kernel. This is meant to facilitate
using BPF CO-RE on 32-bit architectures (pointers are always 64-bit in
BPF, but host kernel's BTF will have it as 32-bit type), as well as
generally supporting safe type changes (unsigned integer type changes
can be transparently "relocated").

One issue that surfaced only now, 5 years after this logic was
implemented, is how this all works when dealing with fields that are
arrays. This isn't all that easy and straightforward to hit (see
selftests that reproduce this condition), but one of sched_ext BPF
programs did hit it with innocent looking loop.

Long story short, libbpf used to calculate entire array size, instead of
making sure to only calculate array's element size. But it's the element
that is loaded by LDX/STX/ST instructions (1, 2, 4, or 8 bytes), so
that's what libbpf should check. This patch adjusts the logic for
arrays and fixed the issue.

Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20250207014809.1573841-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/relo_core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 7632e9d418271..2b83c98a11372 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -683,7 +683,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 {
 	const struct bpf_core_accessor *acc;
 	const struct btf_type *t;
-	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id;
+	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id, elem_id;
 	const struct btf_member *m;
 	const struct btf_type *mt;
 	bool bitfield;
@@ -706,8 +706,14 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 	if (!acc->name) {
 		if (relo->kind == BPF_CORE_FIELD_BYTE_OFFSET) {
 			*val = spec->bit_offset / 8;
-			/* remember field size for load/store mem size */
-			sz = btf__resolve_size(spec->btf, acc->type_id);
+			/* remember field size for load/store mem size;
+			 * note, for arrays we care about individual element
+			 * sizes, not the overall array size
+			 */
+			t = skip_mods_and_typedefs(spec->btf, acc->type_id, &elem_id);
+			while (btf_is_array(t))
+				t = skip_mods_and_typedefs(spec->btf, btf_array(t)->type, &elem_id);
+			sz = btf__resolve_size(spec->btf, elem_id);
 			if (sz < 0)
 				return -EINVAL;
 			*field_sz = sz;
@@ -767,7 +773,17 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 	case BPF_CORE_FIELD_BYTE_OFFSET:
 		*val = byte_off;
 		if (!bitfield) {
-			*field_sz = byte_sz;
+			/* remember field size for load/store mem size;
+			 * note, for arrays we care about individual element
+			 * sizes, not the overall array size
+			 */
+			t = skip_mods_and_typedefs(spec->btf, field_type_id, &elem_id);
+			while (btf_is_array(t))
+				t = skip_mods_and_typedefs(spec->btf, btf_array(t)->type, &elem_id);
+			sz = btf__resolve_size(spec->btf, elem_id);
+			if (sz < 0)
+				return -EINVAL;
+			*field_sz = sz;
 			*type_id = field_type_id;
 		}
 		break;
-- 
2.39.5


