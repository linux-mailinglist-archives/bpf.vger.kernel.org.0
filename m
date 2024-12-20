Return-Path: <bpf+bounces-47449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832269F980C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BB0189BA00
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A6022E410;
	Fri, 20 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDCCTQQU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70022E3FF;
	Fri, 20 Dec 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714784; cv=none; b=s4SlgmhSaa4c0TBW2c+McXY86uVIX4RBMrarIXexHkh/gFHHVPKzZoNB6FIZPJ7VlSXOhOCOM5MRLf2H+v5P5M1FTozg9TuiWavKhVmzt0V4jX9qrePmZG2V9l1YmtltG4NpOuyrM77/FTrRHJVPEWI3DDD7NjjfJuCHgStrjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714784; c=relaxed/simple;
	bh=xICDyWUVmS8BBSbGPY10PTvwGXgx88LAFq4dytI1puw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfCNm3Wln+wnTH+rc1lLXUpXnnoRyqt5O0EGDbYcI2Y+Bjv/OBLN3fi7kyPnCkwUlLm1f99iyDWOjpNdIX73lZOqKM4qsHkSg70hBh7lR1rUTDQKqXVrv3NcSY0HO+RZfwYGUC8lcR935owVsMwxNG+8WRFJbLWj9YRmRrJ0Sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDCCTQQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CFC4CED7;
	Fri, 20 Dec 2024 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714784;
	bh=xICDyWUVmS8BBSbGPY10PTvwGXgx88LAFq4dytI1puw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDCCTQQUpLlXMk2mlBjt8Rq6h2VQmc9OvNS1Gs6vPeSF57aPn9wl8xoPMMGIKf6lW
	 I+U8bgLQMXMaw8m8xHinOuXN0VHkpYzqRIbiUu5MYiYFP1RtF33xYNE6Rz/t4zejiK
	 o/KtQ17bfSZSahB+TeMZPLFpSqGPZXCIrDzQr3QqqAbNCLzD9Ev1Wlb/NZuMgRPEKE
	 nY7YkNaOSSwoqp8QFBxu6LnnPPwxvDxZHJ1nPpilOlHbKh1KDGzFGeoRjZu4cK9FkQ
	 8KCx47J2iJ/Sc8Pmg+XOElwkVBvCaKp0QKyPstqiW69p++9nOrr3pGjqcu8TYa5qYY
	 TlQIxO9cm0soA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/16] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:12:33 -0500
Message-Id: <20241220171240.511904-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
Content-Transfer-Encoding: 8bit

From: Anton Protopopov <aspsk@isovalent.com>

[ Upstream commit c4441ca86afe4814039ee1b32c39d833c1a16bbc ]

The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
error is a result of bpf_adj_branches(), and thus should be always 0
However, if for any reason it is not 0, then it will be converted to
boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
error value. Fix this by returning the original err after the WARN check.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241210114245.836164-1-aspsk@isovalent.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 58ee17f429a3..02f327f05fd6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -529,6 +529,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -536,7 +538,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.39.5


