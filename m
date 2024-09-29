Return-Path: <bpf+bounces-40485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15D9893DF
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA75E1C20E61
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49113E8A5;
	Sun, 29 Sep 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7QAsts6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C513B5A1;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599684; cv=none; b=WAAAK6ATVd9gOJNbBW7Mkpmi92tv5hEZD7TBNfpiwO5/6M1+T10KvSdgkncKXVMmN/QdZ8aRhaPA9IokGNWlHY7zuPMmxBBhqW/6RsK0zQa5wKujq+0WWnuHTRECQRLOhf0unb80DeAspzwMJ3DIX2A0A/Npy5uUA14X8VlWbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599684; c=relaxed/simple;
	bh=f6dz0eAovQ9H45vR8uatX5g6TKGH79bTRxSnAHxNIeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJLCLFFQ1sUeTkez/9Ju8kFEoxl1W41r9C96WJKilaZY3NnnhfqwGxKwZ0XXOZqR1nWsqqrAGTjQICcZj7DqED1g/mrt119lnC4GEQpC3ExSzRo3CY/Mv/+Tn3DsRpdKNMgPs56uJ5Zf60ofjZ6Htei0hYeBLIkIozOJ3THZczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7QAsts6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C8F0C4CECE;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727599684;
	bh=f6dz0eAovQ9H45vR8uatX5g6TKGH79bTRxSnAHxNIeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R7QAsts6NHF5g24Ikxq1ZB61V8/Fut/dHkednFH/u1Lwqu+9oO61qHHb7EYH6TV0H
	 SnQUVloQ+dL7twZM9stgai78wA4U5Ss32Hjxrq9jeTmwYUP3y2F1CS4dWoENN7ZT5V
	 jWolvgsStE454NVDL4UjThUR0qNj+T68t6vQh53GtloIPe9/URwiYbKcTsR80lwOmJ
	 1anlNIH0ROH3/Px7OHWWiGOg4zIXKMfTBU6D3aVebvdqFyDpxmMQFJSMr5h3jhTuPn
	 fzqCKyD+sQJFC3JcKhSmynkvDO/f0UCIxMKs92Z4WQEM/hUybrS7AE2LObZH3Mcpq9
	 0hm/+tVx8Krow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69587CF6498;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Sun, 29 Sep 2024 16:48:00 +0800
Subject: [PATCH bpf-next 1/2] libbpf: do not resolve size on duplicate
 FUNCs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-libbpf-dup-extern-funcs-v1-1-df15fbd6525b@hack3r.moe>
References: <20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=cVkc6Hjsq020lv+rt+oCh7q9xtjmEGtFpGZ2Rx2LwNU=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGk/RZx3P4hjjK4QvqBjePHy6uavUz+94N/Szfdci11h+
 v8JvnrfOkpZGMS4GGTFFFm2HP6jlqDfvWkJ95xymDmsTCBDGLg4BWAi2QIM/zMbfRoOy3Um+y13
 +5gYFnbO3O+3VW+emeLigsvhOy9o3mf4n3L2wfHr8/Pd2+asO+tfquArXMXs/zvq7LMJ/xO6Q64
 mcAMA
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
 tools/lib/bpf/linker.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..a2a7075038f898053b468a8256b93460edc29de6 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2449,20 +2449,24 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 			 * the same extern VARs/FUNCs.
 			 */
 			if (glob_sym && glob_sym->var_idx >= 0) {
+				const struct btf_type *t = btf__type_by_id(linker->btf, glob_sym->underlying_btf_id);
+				int kind = btf_kind(t);
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
+				if (kind != BTF_KIND_FUNC && kind != BTF_KIND_FUNC_PROTO) {
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



