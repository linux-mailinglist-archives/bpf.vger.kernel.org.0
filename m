Return-Path: <bpf+bounces-20769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1C842D00
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7601C24F70
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308C7B3FA;
	Tue, 30 Jan 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5pqsy5S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF67B3EF
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643424; cv=none; b=G3F9wpFk/krPq05tJJd2hrkeZlGqZ4cJT9YDnEEdA06yhuC6hRU/bnuUEvVryRSYlNUiOUk/MTBLAiXg1xpG3Onwyvtx4kkDQji2RdmxMADOCeHvHzjCrVgRu6BU6Lz9nyAOQuxoWRtqPEvujVcRMLhxzAW7/BEFLFXLuKTGk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643424; c=relaxed/simple;
	bh=0IqmjUKDIAH+n/U558cKShOSrC+VrizWFbQILbOrWwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+mAx1kXUzaTDKNc1vbIYqtWNJH0dKY++Xd8ruC8EdIGVo3LAoo+ex+wbi8MWP6qN5aNRCfzLzQYZNPzZ1PLmIYGOlwwSSJFc9RhULP6JmNrd4duB51/Jo5WaAd4hvYz1iZnuj7YHfsdmlv10tzqtU5wJQiE7lzklyYRKi2RHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5pqsy5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418DBC433F1;
	Tue, 30 Jan 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643424;
	bh=0IqmjUKDIAH+n/U558cKShOSrC+VrizWFbQILbOrWwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5pqsy5SbC1ka567+CE+Dvwg4/vMj7iJ5wf0eecBePA2yLY2qAhwrw5XN/pHVzXva
	 S7uipww0u5/6Zpsu+HRVxMy3aRGUG8u1m+LhE6b+HhFGYrXbDzbcTndh9k2bzIdRgG
	 dx5f6Srp945imBmKEfaH0KQbM68Dmb3rmO8Wb2eYsYCkK7jv0VRINO5/kY9CGqATbq
	 CsSpfryVgzwlzky/UsXNpCF4JhBaJG6X2S2enGrD5koTQ2NnlHbTcx9soE0c51+jBZ
	 KLLdMSaH1M9q6zTUdHT+msJaoDY3V8bnLGFiGnQ/eyD/F3DnZkCAQrEGUWp5TqCiJv
	 l4n7qFWRNG+kw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 4/5] libbpf: add missed btf_ext__raw_data() API
Date: Tue, 30 Jan 2024 11:36:48 -0800
Message-Id: <20240130193649.3753476-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130193649.3753476-1-andrii@kernel.org>
References: <20240130193649.3753476-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another API that was declared in libbpf.map but actual implementation
was missing. btf_ext__get_raw_data() was intended as a discouraged alias
to consistently-named btf_ext__raw_data(), so make this an actuality.

Fixes: 20eccf29e297 ("libbpf: hide and discourage inconsistently named getters")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c      | 6 +++++-
 tools/lib/bpf/libbpf.map | 2 +-
 tools/lib/bpf/linker.c   | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 845034d15420..a17b4c9c4213 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3050,12 +3050,16 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
-const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size)
+const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size)
 {
 	*size = btf_ext->data_size;
 	return btf_ext->data;
 }
 
+__attribute__((alias("btf_ext__raw_data")))
+const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size);
+
+
 struct btf_dedup;
 
 static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 386964f572a8..86804fd90dd1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -325,7 +325,6 @@ LIBBPF_0.7.0 {
 		bpf_xdp_detach;
 		bpf_xdp_query;
 		bpf_xdp_query_id;
-		btf_ext__raw_data;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
@@ -413,4 +412,5 @@ LIBBPF_1.4.0 {
 	global:
 		bpf_token_create;
 		btf__new_split;
+		btf_ext__raw_data;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 16bca56002ab..0d4be829551b 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2732,7 +2732,7 @@ static int finalize_btf(struct bpf_linker *linker)
 
 	/* Emit .BTF.ext section */
 	if (linker->btf_ext) {
-		raw_data = btf_ext__get_raw_data(linker->btf_ext, &raw_sz);
+		raw_data = btf_ext__raw_data(linker->btf_ext, &raw_sz);
 		if (!raw_data)
 			return -ENOMEM;
 
-- 
2.34.1


