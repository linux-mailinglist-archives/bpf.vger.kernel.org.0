Return-Path: <bpf+bounces-47450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580F69F97FF
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EA77A1857
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D023236C;
	Fri, 20 Dec 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRM1ou6F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513E231CA1;
	Fri, 20 Dec 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714816; cv=none; b=n0Fm3Lfyi8/X8hUs7u1bhZW+d74OnOtp1JcWAWsKYrwW8r9O/0FKbRp3TU34lY/LFb8ev6knbRANemzHz0GnzrilM2EBRXyJaO0K/bphgm1hWQhtAXDobNua009FDyFfuuFPP/61Ek/i8Cdo4dHTmn6vfcImi9N/uKQ6l+9kRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714816; c=relaxed/simple;
	bh=Re2/xzreWzH2qBLyWafylmdHdboJcmq5CLaoHQR1E+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjjEU9bjQvwNn0Qku91STyYO3J0KjprVxg99GTy5CH8mAMEHT2UMDBLpI6SSo/ydFPdWh11+xpp8OjHufqiooV7eEXfX+0GquNsVhbZUzYtUNd1mgjyv5XOUUH8owXkKXKgVcZZ5qfIiLtRaV40nCKu4rK9Iolbfzk8Z1R0JDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRM1ou6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4A0C4CEDC;
	Fri, 20 Dec 2024 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714816;
	bh=Re2/xzreWzH2qBLyWafylmdHdboJcmq5CLaoHQR1E+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRM1ou6F9UM7cCtDYhu6kozC8nt7AGU24ejfg5YrswwEQIOyHYY6ye2GsFwv9v0Kn
	 evxJARz2zMdvoCAr8NV54jtZeWnOtK9sXBSsCpaFVds+7CCVLx5HnJi1dk46qdvgH1
	 tV15AcRYGgVOJR+tqOk6OOaCsw/7UR0f5j9v+n4WNssYzE27Z3oC07fAbIJm7g2Nv8
	 uMlmtf3mQKMKwiNJXRZ5cplkHWQLlcdNEcubONXpIUd/Ius0UscApyAPSATijN2nUc
	 8LqJVogwt4DHx6Qy5XiGzOHKFEd8vkwHcprQCXQCJWxS9fEZAnHM0EKy3F2CbsI1JS
	 A+BMiMIdx97WA==
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
Subject: [PATCH AUTOSEL 6.1 07/12] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:13:12 -0500
Message-Id: <20241220171317.512120-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171317.512120-1-sashal@kernel.org>
References: <20241220171317.512120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
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
index 0ea0d50a7c16..83b416af4da1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -523,6 +523,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -530,7 +532,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
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


