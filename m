Return-Path: <bpf+bounces-57455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8795EAAB7BD
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD141C27677
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED162F5F10;
	Tue,  6 May 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq1jGJKU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75795284B43;
	Mon,  5 May 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487030; cv=none; b=qexqs3qhbLBvdbm0ypbphPIMdJS/1vafim2rhnRNCrMeXO91oKMEKL6lHnNoOrTEUoU9kMeV0L5RYWSughoBSN0Zm3PcHDmcVHVy17OkHrPtXQ29zMXpAx+wHPrXT32APIPkrXf0qpI56ZhcjtnNiSPF4jnb6zBcoc95KF1JMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487030; c=relaxed/simple;
	bh=W5BvD/MMeNpUVPucA4RW+iheSvN3jbLhn4vB0LdNV8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkSnYoj3UXvzFRqqtK77Zevd+BHj26P/OJAT5EGxnWYAMdPmIfApIYyUoxeDTnj0zt2e5pg2PGQTuaehQOCR9I1ygLxcaK6s7mZGk2gIJEBk7Em+8wK3WCOUJWtvmplqeF9GelhOOEQN3hsv8RQnm81IbUIQ+jIvHf3TSNr3DP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq1jGJKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E455C4CEEF;
	Mon,  5 May 2025 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487030;
	bh=W5BvD/MMeNpUVPucA4RW+iheSvN3jbLhn4vB0LdNV8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq1jGJKUvMhQC3QB9H1NVIxocksuSiOYZ+d+3Cfnjf6Wwk+Z+tbAQtbLwQWJoztwi
	 G/qZKdnnrWGOQSqWQMoO3aLV5ZvesVG/CqgOOPGGcrTcJcmv9RrT4GtHO/n53+5bD9
	 rpdPrb5Cbzi3RzqO0ri3upOaY3lAPc9pOyXC5p89kXrOmQtuPgQH6uyG2hwDj0KEtb
	 wB/RirKX+XWWYr+HuWzZdbXqKbZo5+zuvjHO1L/vx0r7OWyEJsYAzyiIC7w4nTxffu
	 ctpcXEWpaJvvahpw3OHoJIPfaaGAUErGkJnHFWhQzf9B78d5lnZSYjtHmlExEGc/6U
	 SjVfAqwVLBODQ==
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
Subject: [PATCH AUTOSEL 5.15 118/153] libbpf: fix LDX/STX/ST CO-RE relocation size adjustment logic
Date: Mon,  5 May 2025 19:12:45 -0400
Message-Id: <20250505231320.2695319-118-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 4016ed492d0c2..72eb47bf7f1ca 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -563,7 +563,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 {
 	const struct bpf_core_accessor *acc;
 	const struct btf_type *t;
-	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id;
+	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id, elem_id;
 	const struct btf_member *m;
 	const struct btf_type *mt;
 	bool bitfield;
@@ -586,8 +586,14 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 	if (!acc->name) {
 		if (relo->kind == BPF_FIELD_BYTE_OFFSET) {
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
@@ -647,7 +653,17 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 	case BPF_FIELD_BYTE_OFFSET:
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


