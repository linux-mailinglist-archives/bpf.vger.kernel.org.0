Return-Path: <bpf+bounces-47451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E589F98BB
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C1189D9C2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D4236908;
	Fri, 20 Dec 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phg8w5Hy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9F2368F7;
	Fri, 20 Dec 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714842; cv=none; b=ZlSg3e2pIR3CesvTiwK9Ubg6wWYyZMgw4ZVhG27FL90CGBmZdbUDrEx7nnE6BiGTRNE+BleJl/onoCDEGluaIuDtZz/RYpl8UVMXfcCd0ieMscBRxIh+grjWc/k/9avOjGt1cDHkQZa1JmdwHr0L4JYxT1KzcbcTWcH+BxnA6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714842; c=relaxed/simple;
	bh=Y37AQqmHPYXy1PIQtMA3SIyx78a+QDUMA5r8RvkeX8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoMbzW9coTfV68/0V7QagAhVW+uLqE+4ZmTMBTJfGEkkjf6/XVxDVCxXuZehnJWdTXXK0mJobOawGoRsA0fMReLXPWlMjti671oLbELO+6vUwga+bPtIYAtuRPQgqMd8emNSAO1UO20uxY/yBINxnl7ci//hMwK/WMyyuvdjk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phg8w5Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C874BC4CED7;
	Fri, 20 Dec 2024 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714841;
	bh=Y37AQqmHPYXy1PIQtMA3SIyx78a+QDUMA5r8RvkeX8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Phg8w5Hy8BdfsZSqlpvsCkVcMwDukoHScHAmI+aE2OCH1XI8kYi0r3BiEFGyjEjHf
	 tfcIUXPX4z1PQFVUWTGPZKhwFygf7XRLsjb7DPcra57gIb5RvqrPaFHyTOjrhIJNPs
	 m/uCIDErrrlxqQwKjvyPhUDxO6kA3ONSQQ9havwBMuU+6ICCPHpPlo3ECZDnQMnlYt
	 /yBlsrNcA8AStKJmlziRL5cN+XMXfVk6+lsW7VhluNCH0KNYkkVQEWEdsNKRO6RAUi
	 yBb1zEQWB14A3pgWOtLVbzOAByaJmZDPIHfF4oPLYZ7qknmtWtY8zkgJmzjSkViXTt
	 3NGapbCJaxGzg==
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
Subject: [PATCH AUTOSEL 5.15 6/9] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:13:44 -0500
Message-Id: <20241220171347.512287-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171347.512287-1-sashal@kernel.org>
References: <20241220171347.512287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
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
index f36f7b71dc07..d7dbca573df3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -504,6 +504,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -511,7 +513,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
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


