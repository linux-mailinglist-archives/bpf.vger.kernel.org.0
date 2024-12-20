Return-Path: <bpf+bounces-47453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987299F9837
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0837A44FA
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28F2397AA;
	Fri, 20 Dec 2024 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDEkpKRz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF8239798;
	Fri, 20 Dec 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714855; cv=none; b=iIh0Slioezmfqd2RfmDiUPuHPFnLcF0MGB0ZguHIxqZVQE07XDR2beJ8Sw9pTZTh/qLMFpHs/inwFoS+q6nXEuSQ4SoeENfcObG0XSiLGBIM4L6IHLGVRRX6LCQqPtXHOeqP57LSg1tf/dRkuLyrXGxIDv0dkmK9VZ4bgEXvhCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714855; c=relaxed/simple;
	bh=IDTTOneDWKFiUraPvhxfxnzWJYF1RsC1Q4z87hZG6bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWVmvlGWtxQS6hNrKUdMyR7RNtbMyW/x1vMS+It6rzQ9xy1w3oS3awS5HSBAs9M5kjCU18WEh1HQnOxUm9tgHU6yGp1GVhQo4hySlD0mx6/Ho5FAAmmgo32olUf47Xne5sx1DwHMNFHTPauKPJ5Rp3733Fu6vUu83bALpWPHz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDEkpKRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E09EC4CED3;
	Fri, 20 Dec 2024 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714855;
	bh=IDTTOneDWKFiUraPvhxfxnzWJYF1RsC1Q4z87hZG6bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDEkpKRzIgOo99aU6bJctJY2VkiBiv3qW850pc0uRx9JYjqO6DTi4RBCW5QrQGVJf
	 WOKEIfLufpL7NQEkLaQOh6fr4uenDD2dJrBa2+E8hGZMYX2W7kofWRLI7Wrjt76Vgu
	 EvQEAJG1y+wBKMePNddbrCNjLHlDH1f7Zm8l9rAgkLd3vaH8ET2lpTHs19kU52C1/Z
	 Wp7s/tAzWeUKrJiNUSf5Ts+cHmH/3ATbEGGVrHPeUB9RIUbjbawUojin+6EkLjdBuP
	 YcgpOQN0wh5YUOifH1sW64xG1HpKfmKHu8Pmmu7fRLkdnXCrU7TTJvFHnIisMk5k2O
	 ++dKaMvcSQo/A==
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
Subject: [PATCH AUTOSEL 5.10 4/7] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:14:03 -0500
Message-Id: <20241220171406.512413-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171406.512413-1-sashal@kernel.org>
References: <20241220171406.512413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
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
index 33ea6ab12f47..db613a97ee5f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -501,6 +501,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -508,7 +510,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
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


