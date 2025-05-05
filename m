Return-Path: <bpf+bounces-57429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C9AAAF74
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21666189F421
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97913BEEFD;
	Mon,  5 May 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCDoGC7+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6537941A;
	Mon,  5 May 2025 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486710; cv=none; b=EmDUWgJgb5o58SWAh1GWWolFzAgyOOJ5eZOsf+zyePJk6/7o7dgOE9CbdOP3D6TrLNm/PDKZZY8sTzRWlzEbuYndoSf9kzaaSHkOQvjqwK0mSc2h5WL6DeXYHA5xQGoDLpHjjMSCPPI5ZEdFs+Xfyl6pXGrSdelM4x1NfwUrCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486710; c=relaxed/simple;
	bh=C43Pz/hDzcDNEKIbrxLCPDxsolFRO71goEUky3/G04A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyleawBRtfG9JbiOGoGHzahGO7fWz1PGEaq+hH4GJCu6UHOuS28W83vFkzWVdbmvG11N/po/7IgSo98EPUyyC4RU7pESBiytcrNQEpwj/7MgnGzikwW6RSfFJQxVRKxcKkFJM/xibFTM13d0S92WzEPXZaa4kCCETqrroe5vdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCDoGC7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EBEC4CEE4;
	Mon,  5 May 2025 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486708;
	bh=C43Pz/hDzcDNEKIbrxLCPDxsolFRO71goEUky3/G04A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCDoGC7+HF2d1yZdJiFd+nu0c6d99soE0h6awJSET1IdWdqegQNKbQwIk47Oup/pB
	 cSOyHy+Rab+W5+XK3lvu6MxerPCPGz/vD/WwjLqOguaquT8j543qHttz695psX+ssu
	 X5BzQ5vcEUYc7YL910Kq6UbLvRDZQvAH8GHdw0Ej3QYhoX5ZJw7m57sx43/bnlQoWb
	 88DR9O+3ZsSV6DWKkgnGh08b4dlDvf5TNIJF4vZ8GrusdCSU8s1HXTgQcPp9PNPm8V
	 eEXjNJBUkBVKDTnbo/8j/Mjq3qF7H15U7TQDLVtTTZoJCryyOrVqVCqW2ItkM12g3j
	 gjMpcVs1NFv+A==
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
Subject: [PATCH AUTOSEL 6.1 165/212] libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
Date: Mon,  5 May 2025 19:05:37 -0400
Message-Id: <20250505230624.2692522-165-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index c4b0e81ae2931..84f26b36f664c 100644
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


