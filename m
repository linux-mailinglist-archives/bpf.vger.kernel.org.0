Return-Path: <bpf+bounces-47446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A775B9F97CD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A68189AE89
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435422836C;
	Fri, 20 Dec 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBEtDAIy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531F227575;
	Fri, 20 Dec 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714739; cv=none; b=kbgwWLcQpr+n1ohoypuLS4AQcbHRUAy+ffnrf2Z69dDe3nTUmqzrHTcSlMJ4WRW0dhdMWnhfZO95qKLWMcVfbNLL3qW4NcvpGrF4rGm9aSWAnycYjg6kTy57UBoONksBPB0NEt+Qnz0fGSCuETAwRgGGEgM/QmnXLGJOIJfH4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714739; c=relaxed/simple;
	bh=yYW/TzcSQn7RREEjIPrMgHcz34NkNKHLVWxh6C3QtWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xzl+UFEWEVy/+4CDp38tN3q6UsH5r6NVDtpewfc1h97urakC0KnEN+Cu1Mb465OPmDw31bYGNt06A/HdRECZ5Fu/R+6AZLaFc3y7W4gsviRVC04/0pPR6KaRaqY9LTyaS1tOE7Ujff0Nlu30N/aCFmRoO5fROlxP//yDrkAFD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBEtDAIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C49C4CECD;
	Fri, 20 Dec 2024 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714738;
	bh=yYW/TzcSQn7RREEjIPrMgHcz34NkNKHLVWxh6C3QtWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBEtDAIyn1oXVHjpJuJ2XJHhmuXlpZZ+d0dQxTCLEHhTSmWEUDAjJdIjkXknkmq0h
	 PmHHFQ//u0q6QVy6pnrCOT+n5Po9aMNHxYq6p69TeGwzCej2Bqv8j4BLWXwgHHUoU7
	 0y5THVvON+lX1Enr2ubxIFRtvJrFLSu0KoF0zAaUco5Thvrtk4oOzZqtO9Sjaoq/tr
	 +OyK2KZb9Po+FlS4hEJjMKWAyXcirEhFQYTVZKKHbNvL1GMrZTahpjdyzKYhJMtAQ3
	 6mIwD5plchdXpisRXIBMIi9Nq+zdy7gjggMFbVGVFA0j6L5o6PYlQknsz2R538mI7o
	 m+xHJz5Nr2zBA==
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
Subject: [PATCH AUTOSEL 6.12 20/29] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:11:21 -0500
Message-Id: <20241220171130.511389-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
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
index 233ea78f8f1b..3af5f42ea791 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -546,7 +548,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
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


