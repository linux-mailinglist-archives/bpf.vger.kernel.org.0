Return-Path: <bpf+bounces-34140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4692AABB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788C728317A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D013C806;
	Mon,  8 Jul 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQHasucg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E043BBC1
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471554; cv=none; b=IbcZm7Eg33r220oq3bMXDqAqW9/+4Aw+2xSoF1FNLeWJI9I1MHQBgXT7U7z6QtbkEe56dW+gCgiOdbL2CjFJS51nXqdxviE9nnz5yCQNuOTSeXWYqIo0t4mJv+dQEmMtocMcQvu6qA0Q9tYrpGysObY0l03Ax3Apm6XlrDuNg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471554; c=relaxed/simple;
	bh=9QjlSzsd57R9TaWK0wk+O8Lq1ZoK2iQF9cqsqj72IbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m75GnX7kNsVo6GLwI2F5ghwQE+HhJIDCdc0ZKAX0KskFM/qniUI0SkBA/Ia6W5BdqutgCoQfJRrfhqteV5gcdQ+YFNhL/wDxT1Dd6c/HxF9zhgCcL4/HZtiIUDmkqTyFSMab89si57I9UHY4cQVd2i2q0jB6wcoNfRrIvHPcv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQHasucg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CB2C116B1;
	Mon,  8 Jul 2024 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720471554;
	bh=9QjlSzsd57R9TaWK0wk+O8Lq1ZoK2iQF9cqsqj72IbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQHasucg2ImHxO7Cjr95QGIHkaiviO27vIaHDybVkZl1yOpu/CgeXVEAQwQDH1jvt
	 oFwsDnRww8AN6UCz6RkWJGg9pqD77LAa3Fq7M7qru1XxLySLBgY/3KVSDu4IojHLcM
	 6dwsx9tktoGOGLUGhXzl+abRaRkFnUUjTZkPSPN3xMr7hrwdiUly3YidfHhzvKqE48
	 4rHTLOHl8Ft4r0w3vet//+hTdVUA4dN53Hf3LY9+HvoLwNKa6dWHbu/DWOXPRnw+oJ
	 VUE+kVNb+3pWNigA0vRSt5/elU2eaR2qPReoouh6DFrka9VOmbBz6i7VBGB8t3L2vq
	 H4fcJa8cW8aIA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/3] libbpf: improve old BPF skeleton handling for map auto-attach
Date: Mon,  8 Jul 2024 13:45:40 -0700
Message-ID: <20240708204540.4188946-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708204540.4188946-1-andrii@kernel.org>
References: <20240708204540.4188946-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve how we handle old BPF skeletons when it comes to BPF map
auto-attachment. Emit one warn-level message per each struct_ops map
that could have been auto-attached, if user provided recent enough BPF
skeleton version. Don't spam log if there are no relevant struct_ops
maps, though.

This should help users realize that they probably need to regenerate BPF
skeleton header with more recent bpftool/libbpf-cargo (or whatever other
means of BPF skeleton generation).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8625c948f60a..a3be6f8fac09 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13967,32 +13967,34 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		 */
 	}
 
-	/* Skeleton is created with earlier version of bpftool
-	 * which does not support auto-attachment
-	 */
-	if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
-		return 0;
 
 	for (i = 0; i < s->map_cnt; i++) {
 		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
 		struct bpf_map *map = *map_skel->map;
-		struct bpf_link **link = map_skel->link;
+		struct bpf_link **link;
 
 		if (!map->autocreate || !map->autoattach)
 			continue;
 
-		if (*link)
-			continue;
-
 		/* only struct_ops maps can be attached */
 		if (!bpf_map__is_struct_ops(map))
 			continue;
-		*link = bpf_map__attach_struct_ops(map);
 
+		/* skeleton is created with earlier version of bpftool, notify user */
+		if (s->map_skel_sz < offsetofend(struct bpf_map_skeleton, link)) {
+			pr_warn("map '%s': BPF skeleton version is old, skipping map auto-attachment...\n",
+				bpf_map__name(map));
+			continue;
+		}
+
+		link = map_skel->link;
+		if (*link)
+			continue;
+
+		*link = bpf_map__attach_struct_ops(map);
 		if (!*link) {
 			err = -errno;
-			pr_warn("map '%s': failed to auto-attach: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to auto-attach: %d\n", bpf_map__name(map), err);
 			return libbpf_err(err);
 		}
 	}
-- 
2.43.0


