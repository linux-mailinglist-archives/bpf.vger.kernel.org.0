Return-Path: <bpf+bounces-50712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59593A2B864
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF250166541
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F97DA67;
	Fri,  7 Feb 2025 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn7Sg3bQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C92417E9
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892891; cv=none; b=ceqakKPD5BHBmZm00m1FepuoEMBt/VKfXyno1El8JU833QUpEy3oUNnWaAnDFtakx+QjJE3auufQUNuxpnDSDn7ekb0gHUvFOKL3BrHJhJstn+ZgQNs5LR6sNbka8M0UoGrvk4D12gyZSu571GWP7rz3WsUOWHMP2jjTZ3eqJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892891; c=relaxed/simple;
	bh=bCGi8O1vPFmMa+R055GJmctrcT/0HglzAUfTAqAq0Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkfierS+u50JOYiV0kjAKEpjijonq2U514w9lUbTYBjMO5hK/GVQ5PXEA/Pf0L5qAPHjZpKaJvGEbbtQVjkAAr1k2tmUVJExkc5zb5GYo1xYZ1pLZZErb3uX8WWNeXOQnbjmbRGSeyHCWzy/gTWyiIZFgDFOSLJcr0+KmwcpmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn7Sg3bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1741C4CEDD;
	Fri,  7 Feb 2025 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738892891;
	bh=bCGi8O1vPFmMa+R055GJmctrcT/0HglzAUfTAqAq0Uk=;
	h=From:To:Cc:Subject:Date:From;
	b=Zn7Sg3bQ/tZVwTvI1x/NiMjRFpbhvV13rSac0vCG9Hmd4utuHqiRtCsTZ8bfdjTfO
	 jCA8iGiYalVHqPKX2eVaoBXXcl81XUgZ0VEZwsJg2WczGSb4autRkBrvUG6++3SoeM
	 oTgMnZSPVqtBRXF7797gVsH1vhYIb+Q9IMuxhEWwLy7BtZvl8jNyJThHU53xtdlQ+5
	 KkayrqGx4Q+ZTR/WuTIRI12eLK4oQEQV4l1euTsflcnfvMErbNgvUll3kIOIXE6zbr
	 6qyAeKyVL19xk0BBsJgoJWqO8vyCvM9o79s0KeCEsvHf478ZySiIciGEHK+E7d7uS6
	 FGUGk3DX2JSIg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/2] libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
Date: Thu,  6 Feb 2025 17:48:08 -0800
Message-ID: <20250207014809.1573841-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 tools/lib/bpf/relo_core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 7632e9d41827..2b83c98a1137 100644
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
2.43.5


