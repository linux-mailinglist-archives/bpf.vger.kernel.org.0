Return-Path: <bpf+bounces-40489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FC98948C
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775B51F23F5F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8514EC7D;
	Sun, 29 Sep 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm6Sf9ix"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBE13C9DE;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602279; cv=none; b=qdZtFMXkY+fwtwCRmxFqhOU4bSfeI7JzSLSRJPzkEBPIrtn8cm+lM6hUn8ve+HYOcPrso9wbQnU44qVrDQjalekNkRkwnDXdQaZe+uz6g4kVQsu3hV3fant76cQSU9BF2NP+VOwSUMz0EzgNGSj+1Bzd0sz0ak3HbXX+3VBK0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602279; c=relaxed/simple;
	bh=sFianhQKsFtxBsQioYB24lpKpEdOhPptwbiDCislZd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8AoCiFBpn4CYRz0ngyQE5n0db7oiisw4s9xc2+ptyNKU+pPojye3ShsErJ8qxm/g8KDt/kKLbYnX//7VIS4htpq9fDPkp8mFgHsdWrvnPStZQHGikaJxAMo/bITpbEd2ttOxM1Oc1Z6UoExrI0rA/d6DyFO81UdCtaQ3dAkg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm6Sf9ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61277C4CECE;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727602278;
	bh=sFianhQKsFtxBsQioYB24lpKpEdOhPptwbiDCislZd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pm6Sf9ixCrTgxzQxV6aw2pTChawo6rQ83vPHiSv5xttgEQhwaxRv1A2Ae0Qi1ttRC
	 6N+ZfeoACCILU5caEIyJscvuMmGDTxwk1WCZlktuO0LGV+AXUFq1+0DPBM5RR/jplK
	 depZ6ZvQn+N/NQ60NCQmTv0F1eY8FIvidYz7Fl7laEKZCfxG0RmZMcgG8RQ6oLtb9F
	 UOBjxFSNtb70bINzFFBk8WvjV0b6/G5dtdkaR97j/F9vghDEk/hSHRh4lh/Se74Jfe
	 RAmGoee+xly9VPJLJSvidaTKF5Jzuc8vUMv2By3rBliYTz+meo/CtAdZEqZE3AkayN
	 OmP3vhU45YljQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593FBCF6495;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Sun, 29 Sep 2024 17:31:14 +0800
Subject: [PATCH bpf-next v2 1/2] libbpf: do not resolve size on duplicate
 FUNCs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=win3dEA5LsS0+wCbt4UeGT2PjkspJzu11T/KTqEDaew=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGk/5VIfLVbZsWL6Ogv5v8lRZdsPPH9nd/3auZnHzv66/
 uuP4/Q76h2lLAxiXAyyYoosWw7/UUvQ7960hHtOOcwcViaQIQxcnAIwEcclDL+YjD3su0q49U1d
 bntW/5aTXcD893CPzsE8ReEu1mnfAlQZGb5v+2WaY2FpdnNnfOVLv3sBbnsfbp7guVpgXWG0Xtk
 CBkYA
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

From: Eric Long <i@hack3r.moe>

FUNCs do not have sizes, thus currently btf__resolve_size will fail
with -EINVAL. Add conditions so that we only update size when the BTF
object is not function or function prototype.

Signed-off-by: Eric Long <i@hack3r.moe>
---
 tools/lib/bpf/linker.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..cffb388fa40ef054c2661b8363120f8a4d3c3784 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2452,17 +2452,20 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 				__s64 sz;
 
 				dst_var = &dst_sec->sec_vars[glob_sym->var_idx];
-				/* Because underlying BTF type might have
-				 * changed, so might its size have changed, so
-				 * re-calculate and update it in sec_var.
-				 */
-				sz = btf__resolve_size(linker->btf, glob_sym->underlying_btf_id);
-				if (sz < 0) {
-					pr_warn("global '%s': failed to resolve size of underlying type: %d\n",
-						name, (int)sz);
-					return -EINVAL;
+				t = btf__type_by_id(linker->btf, glob_sym->underlying_btf_id);
+				if (btf_kind(t) != BTF_KIND_FUNC && btf_kind(t) != BTF_KIND_FUNC_PROTO) {
+					/* Because underlying BTF type might have
+					 * changed, so might its size have changed, so
+					 * re-calculate and update it in sec_var.
+					 */
+					sz = btf__resolve_size(linker->btf, glob_sym->underlying_btf_id);
+					if (sz < 0) {
+						pr_warn("global '%s': failed to resolve size of underlying type: %d\n",
+							name, (int)sz);
+						return -EINVAL;
+					}
+					dst_var->size = sz;
 				}
-				dst_var->size = sz;
 				continue;
 			}
 

-- 
2.46.2



