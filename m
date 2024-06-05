Return-Path: <bpf+bounces-31398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3B8FC058
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 02:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A57284C2B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961BEEDE;
	Wed,  5 Jun 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM17y/w+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3134A3D
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546605; cv=none; b=lQzVeSptNCVlPnby1iU/wAAJ8KjV6UBOYvgy+xxs8JikuvVTspSMcuCQBFxm/qZNwuwEEma1WaHj7U/PgqgJ5NhNjuYMuI3IWb1DWu7U/xqTpztcMiNLebu4UN2D4Lz5kDRhoWTyVNhtX0ZATHdhQlkH6MX4eGqfpl/uLgxzwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546605; c=relaxed/simple;
	bh=tYvQbptov8smx+gz/K9UKtzdwum+xG1GyCm2t8sIE1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/4oSEZppOAo40cdRmiNnJanZSduIBcUvKDifOAu/v8pR43TlTsaZnFO3HmBQ4GR0HUkf94KxxhY4+wHD7clT+avFZ2vyro6bcpNd35i0PN1tV2NEBrZMNx6nnS2D0yiYMimpKVpJdy5LPqz0CKji9h+lyYtwmxDYcZ/hhtxLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM17y/w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F7C2BBFC;
	Wed,  5 Jun 2024 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546604;
	bh=tYvQbptov8smx+gz/K9UKtzdwum+xG1GyCm2t8sIE1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM17y/w+8wt542qdnytSgXZDXlZLMMlieMDN5rH8z49/A/L+FqE/k2lD/flfLOUES
	 FWeUBjAHKhHmkVtgjQj0SNYhu28mAsLRIicQgXmogoVZlYCXwB42wyf31/QZ2qo4CU
	 gygqvf0FbMnP9F4K3YF9wyDx1UkKY4PBatCa9WddrycGZmrUwX7R8+P/FzJdZerbZY
	 c6hBNg1tSiZNNUIPwQ5kxhF8NeHYJlG5m41DaswSk32vmcGXsnmXjWFJ7KRROXI3UA
	 jU6OOIaKK0dJ1JXGKn5TNsDC849odz2tZv+fL2BG9LMjGLGNho9oD3E12QOfWGCd/L
	 SuueIDgKq/3rA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 4/5] bpftool: use BTF field iterator in btfgen
Date: Tue,  4 Jun 2024 17:16:28 -0700
Message-ID: <20240605001629.4061937-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605001629.4061937-1-andrii@kernel.org>
References: <20240605001629.4061937-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch bpftool's code which is using libbpf-internal
btf_type_visit_type_ids() helper to new btf_field_iter functionality.

This makes bpftool code simpler, but also unblocks removing libbpf's
btf_type_visit_type_ids() helper completely.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b3979ddc0189..d244a7de387e 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -2379,15 +2379,6 @@ static int btfgen_record_obj(struct btfgen_info *info, const char *obj_path)
 	return err;
 }
 
-static int btfgen_remap_id(__u32 *type_id, void *ctx)
-{
-	unsigned int *ids = ctx;
-
-	*type_id = ids[*type_id];
-
-	return 0;
-}
-
 /* Generate BTF from relocation information previously recorded */
 static struct btf *btfgen_get_btf(struct btfgen_info *info)
 {
@@ -2467,10 +2458,15 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 	/* second pass: fix up type ids */
 	for (i = 1; i < btf__type_cnt(btf_new); i++) {
 		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);
+		struct btf_field_iter it;
+		__u32 *type_id;
 
-		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);
+		err = btf_field_iter_init(&it, btf_type, BTF_FIELD_ITER_IDS);
 		if (err)
 			goto err_out;
+
+		while ((type_id = btf_field_iter_next(&it)))
+			*type_id = ids[*type_id];
 	}
 
 	free(ids);
-- 
2.43.0


