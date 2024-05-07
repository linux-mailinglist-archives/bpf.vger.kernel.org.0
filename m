Return-Path: <bpf+bounces-28741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CE8BD86D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB71C22658
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8E64A;
	Tue,  7 May 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lADgsd8D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB310E6
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040826; cv=none; b=Oc9RnaH6KhLMy8ox/7KcE/bofQ8nE/xHbuD2pv7PV+VtOildxELKYdqAX/r3NOC7P+mpWzkA3ODagtWgZniH6U2R+CVdYQfjLcjXsWpScxyKRE8BjeN8Y2RstKuZvhnhUbf6sx9gI7c6wq7m0br9cze3OBZ9s+NgvVXC6dtFM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040826; c=relaxed/simple;
	bh=Aw6vFEBFJ2UDRus8piXKw/61yZeVfzYsvvDvjrhBqVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrFlfrggMxPHsnXSgHBb6+72f4WD1CXpA/lQEFTHXNX2I1/wnIj3iZtQvMF1DtIwq6vWDUFVLmuZgnChW3eod/dqknzVvWSheTKq+CDsTRIuWhXDp1UPuR1F8ssLZovPbV6MsP1iETbvmH240a8qqHyGELnvzcY8kTyZ6dnDEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lADgsd8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E0CC116B1;
	Tue,  7 May 2024 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040825;
	bh=Aw6vFEBFJ2UDRus8piXKw/61yZeVfzYsvvDvjrhBqVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lADgsd8DNDH7vneFKWnoReI9TAkdkE1Pfb+/SNyFCGpVvUEdAyGHC6TDGzb0rZX9Z
	 RjVp3a5GX1wmHVSbID7oMCamgcOwAzhxhI+Dd3VDwH6rnlngAk8qN6g24aDNf2Zbyb
	 /F/W0Y2e+hnjdpMWvYM1D3DSpqbJE79/b/mgC4one5h50FCYss8r0L6ud91RhxCrj2
	 ytP9kTA30W5KvNFJyUgJufU1f5FKcgdC4xcp49PrRpYcTDrOLiAQTkdxjRFrz+nMUw
	 LZNgd1fj8Dj/nOZM0sN8QHagT9ijycSwu6MXKndTd/rbvGKlESpPkYFDGBw01/24aB
	 qhN3/6AVq53qg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/7] libbpf: handle yet another corner case of nulling out struct_ops program
Date: Mon,  6 May 2024 17:13:30 -0700
Message-ID: <20240507001335.1445325-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507001335.1445325-1-andrii@kernel.org>
References: <20240507001335.1445325-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is yet another corner case where user can set STRUCT_OPS program
reference in STRUCT_OPS map to NULL, but libbpf will fail to disable
autoload for such BPF program. This time it's the case of "new" kernel
which has type information about callback field, but user explicitly
nulled-out program reference from user-space after opening BPF object.

Fix, hopefully, the last remaining unhandled case.

Fixes: 0737df6de946 ("libbpf: better fix for handling nulled-out struct_ops program")
Fixes: f973fccd43d3 ("libbpf: handle nulled-out program in struct_ops correctly")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7d77a1b158ce..04de4fb81785 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1193,11 +1193,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		if (btf_is_ptr(mtype)) {
-			/* Update the value from the shadow type */
 			prog = *(void **)mdata;
+			/* just like for !kern_member case above, reset declaratively
+			 * set (at compile time) program's autload to false,
+			 * if user replaced it with another program or NULL
+			 */
+			if (st_ops->progs[i] && st_ops->progs[i] != prog)
+				st_ops->progs[i]->autoload = false;
+
+			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
 			if (!prog)
 				continue;
+
 			if (!is_valid_st_ops_program(obj, prog)) {
 				pr_warn("struct_ops init_kern %s: member %s is not a struct_ops program\n",
 					map->name, mname);
-- 
2.43.0


