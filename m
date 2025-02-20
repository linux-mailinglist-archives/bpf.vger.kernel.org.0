Return-Path: <bpf+bounces-52013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C01A3CE17
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93407A8CBC
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC11BF58;
	Thu, 20 Feb 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbuSnR8/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3E1805E
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011324; cv=none; b=fkJGU9bKQMPl0e5edzZjB5jqfqe2QwSRgRh2f7bKlsDUeCQIV6umPleE9NgP2YHPdnlsZilkBoTomY5yi26s0UxwJ+ApPluimHVNpHL0xHHOrvha9L/MN3KKLT/Z42tdqFhNeNffbFvsiG0QcSv6Ru/xKn9BZ2brbVlo7ogZaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011324; c=relaxed/simple;
	bh=S34FQzJoYAPSreN/XTRW+BHAvOs3NOzEsi+nzODG9YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t941ek0tIpFGxwgrTjjeGDKiO0qr3hOunlyTqpYOpFR3aJAvOVGbkQf0O+f7jYzK5FcqUFUa4LgQdM4bdbvdqyHl5TVdfN0WTKRmwNFlsXe3hIM6X4htowA0ugybkOMhYuomScuEc6ie0HhMKPi4T2ini2fVD6Zz93Ehp8AaBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbuSnR8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD589C4CED1;
	Thu, 20 Feb 2025 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740011324;
	bh=S34FQzJoYAPSreN/XTRW+BHAvOs3NOzEsi+nzODG9YM=;
	h=From:To:Cc:Subject:Date:From;
	b=PbuSnR8/783I9A4q36vN9Ojr3gFTIOXL//CcA/jPlk04N6WYpshMj6332HgCb2o+J
	 L7GaONy5nxq55/MBbMt2u3Rqu2GzKhTA2pO3zzRzokr1Woj45D5CYpmv8jEHETWkSs
	 r2nFSQms0YTfpy4FyZgtYVLbQBrajr5CizrYr3cSNRLNtZjtl82sZhAjVmH3a7wS4i
	 tair/4PV0xja/RyhAim3mUN5SwFykH/HCk4yjGdyXm6eqLMvvbNt6cd574jvbzm/TK
	 L3L08wRKDxqKhGByjeAyffuFHDofoxWSWtsDMa+73Cw5BurUbtn2XVbSXHTLEoi2Yk
	 j8Qssc0daWc5Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: fix hypothetical STT_SECTION extern NULL deref case
Date: Wed, 19 Feb 2025 16:28:21 -0800
Message-ID: <20250220002821.834400-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix theoretical NULL dereference in linker when resolving *extern*
STT_SECTION symbol against not-yet-existing ELF section. Not sure if
it's possible in practice for valid ELF object files (this would require
embedded assembly manipulations, at which point BTF will be missing),
but fix the s/dst_sym/dst_sec/ typo guarding this condition anyways.

Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/linker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index b52f71c59616..800e0ef09c37 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2163,7 +2163,7 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 
 	obj->sym_map[src_sym_idx] = dst_sym_idx;
 
-	if (sym_type == STT_SECTION && dst_sym) {
+	if (sym_type == STT_SECTION && dst_sec) {
 		dst_sec->sec_sym_idx = dst_sym_idx;
 		dst_sym->st_value = 0;
 	}
-- 
2.43.5


