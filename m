Return-Path: <bpf+bounces-28740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A68BD86C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330341F23E57
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322587E1;
	Tue,  7 May 2024 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klWmrLZv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC21652
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040822; cv=none; b=aF6M0MAGOVhtgPUFpZSLiKY74KI/NMc110/DvbFOF0wehrL7u2hQab6XI/pO9s9NB5s1LuqBfWVsv3nJZbt8O6kyq//AYjrKO5Y3ZVi4//5MVQKagqBEvJmZ+bjBoTMMKTD/AvuAUNOAOeunZTOR+qiz+DSPiBPWQpxW79zincQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040822; c=relaxed/simple;
	bh=VnZrZBbVFpaYeB7xyMBrp4QjGtWRcvFbZGgkUzR4TGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTO3SCUGIxQ8NzIN23yd8siK48MWhWPCuwbrQ43IFavrzpZberK7sr/uJAC3O1VJ5WUp+AVgjYea+iQkiKb86/chlccS3jA0V/syHjVngov8aqDOj55O08VxIJ1lOT/D33leg6BdcNoAAKd9VVuTxv5mv52C9Efcnd4fveR0xaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klWmrLZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62889C116B1;
	Tue,  7 May 2024 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040822;
	bh=VnZrZBbVFpaYeB7xyMBrp4QjGtWRcvFbZGgkUzR4TGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klWmrLZv9d/hG22Ng7b4llvkE2RpufXK16jFt9EhbryEd7TI12BWw/X8KXdUyO0J5
	 a4A7coz54WhUyWcj4P+0n+zU30SFS61FlmPDqSkyZdpRh3eZK1m6+48jF2BUSygmFT
	 SG+6WH3/eQ1zTZsSehQ0/HeXFqVzR/NVIeVtVPDpogm65ZCGHAwdlCku+Sx1Uq9fI1
	 NbaWgZl/mlF9s2u+Mm2yM4KSZ91POV4k6GYW32Gtaz1yvC6A9QaE1Xuy8PeJ/0Vzwm
	 BL/0MHkF7EgpUvBzjOYPkSMsZQd+ic2NNIdzOp7y/hD/tb0Nsre/NAcGvvXfexBuNA
	 2OY9wCJlbI3Gw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/7] libbpf: remove unnecessary struct_ops prog validity check
Date: Mon,  6 May 2024 17:13:29 -0700
Message-ID: <20240507001335.1445325-2-andrii@kernel.org>
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

libbpf ensures that BPF program references set in map->st_ops->progs[i]
during open phase are always valid STRUCT_OPS programs. This is done in
bpf_object__collect_st_ops_relos(). So there is no need to double-check
that in bpf_map__init_kern_struct_ops().

Simplify the code by removing unnecessary check. Also, we avoid using
local prog variable to keep code similar to the upcoming fix, which adds
similar logic in another part of bpf_map__init_kern_struct_ops().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3566a456bc8..7d77a1b158ce 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1152,22 +1152,15 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				return -ENOTSUP;
 			}
 
-			prog = st_ops->progs[i];
-			if (prog) {
+			if (st_ops->progs[i]) {
 				/* If we had declaratively set struct_ops callback, we need to
-				 * first validate that it's actually a struct_ops program.
-				 * And then force its autoload to false, because it doesn't have
+				 * force its autoload to false, because it doesn't have
 				 * a chance of succeeding from POV of the current struct_ops map.
 				 * If this program is still referenced somewhere else, though,
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				if (!is_valid_st_ops_program(obj, prog)) {
-					pr_warn("struct_ops init_kern %s: member %s is declaratively assigned a non-struct_ops program\n",
-						map->name, mname);
-					return -EINVAL;
-				}
-				prog->autoload = false;
+				st_ops->progs[i]->autoload = false;
 				st_ops->progs[i] = NULL;
 			}
 
-- 
2.43.0


