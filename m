Return-Path: <bpf+bounces-41647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC2999447
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EEC1C21378
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628351CDFD4;
	Thu, 10 Oct 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plDo/CUK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEE19DF61
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595054; cv=none; b=fJF3tBM74T80whvrdczOr0dpsuwcgMwSrppWHAewvwsHqEm6PkmEBHw5ljJfvCMeT6B8VPQwXZyDIle2xF0pgXm0RcL8Q+88fK2HYaiAevt68tWtCBG1FGuTXREn1hY6z6PN+hiuhFl6Quwj8UZbBgOoowk5kh/fIeq+UEHzy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595054; c=relaxed/simple;
	bh=beZjZRLb/GaGdqhxvIMJzpNAodTRhru6C/1wPVsw6SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSoPRjMqNu5ZqQozjUAH9DO4e3ObFZkQ8ATES7xRZNRM72i/PQG1sbvfNPNEFanRcr1fBlezLb27JRJr37TksqxIDjd1UBmNO/jdKI7PncYtjwFWZLGXR2GOu0UbXMj4CwauYOcgxtRVQP6R23gGGYtzdxGatsMI9xVErGbT4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plDo/CUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C192C4CEC5;
	Thu, 10 Oct 2024 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728595054;
	bh=beZjZRLb/GaGdqhxvIMJzpNAodTRhru6C/1wPVsw6SI=;
	h=From:To:Cc:Subject:Date:From;
	b=plDo/CUKR6paRbY03Qw4AYEtzrQTT8ytrWdLvIR7wwWCQJrACpRgHLgzgGER/2MjJ
	 DJ2yb/1a7+ZqMPiS6JPdz9c9/9+I/N9yU5510+EIlQeFwHzbTPE0nmM7bFJx6+h/gq
	 WuFQg7l3VTzPB3AZZSpiOU8kJk8WszcRjkhP0EeEWkFPnwyvvWkOmZuSsScf0hAxVO
	 GLodnZDnk8Tj/ZYStwQKTEfCe4E8yeyC+8+Hw0TqOLybamxwClMAcPo6VZvPYpvB5b
	 p1Heff/jfEOfos9VeoKR58/hngzrTtOEJMOcBaZ7qql26K9OCKj+VbnCsQEwKM9a8n
	 BH1ApkMEbh3Iw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] libbpf: never interpret subprogs in .text as entry programs
Date: Thu, 10 Oct 2024 14:17:30 -0700
Message-ID: <20241010211731.4121837-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Libbpf pre-1.0 had a legacy logic of allowing singular non-annotated
(i.e., not having explicit SEC() annotation) function to be treated as
sole entry BPF program (unless there were other explicit entry
programs).

This behavior was dropped during libbpf 1.0 transition period (unless
LIBBPF_STRICT_SEC_NAME flag was unset in libbpf_mode). When 1.0 was
released and all the legacy behavior was removed, the bug slipped
through leaving this legacy behavior around.

Fix this for good, as it actually causes very confusing behavior if BPF
object file only has subprograms, but no entry programs.

Fixes: bd054102a8c7 ("libbpf: enforce strict libbpf 1.0 behaviors")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05ad264ff09b..7c40286c3948 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4417,7 +4417,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog)
 {
-	return prog->sec_idx == obj->efile.text_shndx && obj->nr_programs > 1;
+	return prog->sec_idx == obj->efile.text_shndx;
 }
 
 struct bpf_program *
-- 
2.43.5


