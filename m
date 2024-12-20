Return-Path: <bpf+bounces-47454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5289F984B
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814171644C9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF723A580;
	Fri, 20 Dec 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYZzphal"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953D21B182;
	Fri, 20 Dec 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714867; cv=none; b=eJ2IEnkS+w7qEmIzt+3ixrtXi79ts3qQ+LKby10O9kpMHYR3uGXE5M7JqlexaT9O68IxWrqDlG+C/O4GFAIJq4XMq6HxL2Dyqe0Z5vOSV1L5OvJ9ya3P4/aWAgE7hhozdhBLsgq9vWpS4H4els/U6sEQWk3WYn/e8VzfIuu19eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714867; c=relaxed/simple;
	bh=+Gx9VfELhe5vdNlK/GhGA0AxXuthCSN/iLDGZt8uQDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpqxsq3VTqd44M2AH/3ymv9COy3aaSN2bSSh1EWDPKAEQFPxjCqkcJg7In+0lgAkYFY7rET6RqlPwcqIVY3Ty4X/UYPALjI//LHMSkSx6mh27srnvk8dnP+84tzMYO+WVBPcD6Yx7UMGIT39+ZXTZA/21fzEKUM5NmbeE1Yh+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYZzphal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3966AC4CED3;
	Fri, 20 Dec 2024 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714867;
	bh=+Gx9VfELhe5vdNlK/GhGA0AxXuthCSN/iLDGZt8uQDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYZzphaltlhmvJ7jmnfqNo7jJtCL/RnuGwk0ZYXCeVpt2Tx4W9Cv+UJDKoXxMPgCG
	 HbwhXqjiSk5nn/vzctCsye4UKTcrYT9mQcLLU2ndOXsH51TRg6LepzAthoLXf4uWaH
	 HV5htwr6alzLTYZbH6y7x/jvFcCekX50Wf/1btQb4XB+aqa0jANU59IlENi7z6dz8Z
	 Xshq5qkvbgOzOS8Pb6NjAVN/jcySfw4P6xSsw0S8JGf2guuNLAJDbFQQBogbASTkXy
	 iP3h3uXuSmbYJ0wzcBoW5/xlcOf+rlyz+wvWe3X1ruZcZDMDNiwdrWwyQ/Os5nPoQH
	 CI4lftrLDbrOg==
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
Subject: [PATCH AUTOSEL 5.4 3/6] bpf: fix potential error return
Date: Fri, 20 Dec 2024 12:14:17 -0500
Message-Id: <20241220171420.512513-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171420.512513-1-sashal@kernel.org>
References: <20241220171420.512513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
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
index dde21d23f220..9fb103426cf0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -496,6 +496,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -503,7 +505,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
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


