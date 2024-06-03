Return-Path: <bpf+bounces-31278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C668FA654
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 01:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CC5B24A31
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFF13CABB;
	Mon,  3 Jun 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2eSj/az"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17F1E49B
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456658; cv=none; b=m8HWK2EvLq7Rg0SzwZCltda8v5h6NSQPNBpsWs+a3UVOArfI4jUQlCzZDzarkQOqvNbg/6xj+5yiMOHo5MofqM8F6iufMVYqseFJFWS4sG9/CTepUfA8f/poyDJJrHuqSwI+ZEBiB5viRiMA3h9FCfM9HM1BONlRIX8wEmwnvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456658; c=relaxed/simple;
	bh=ZY6Zk9/nmbAxgm3FKkaBtYgNAaDWbv7PsePRVgeWcxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thxzstJoKHnPzXvTqe+0oODY0E7bnJNxIgRL/R6O9pFOe5yCfpw8dCOHknrqIACeH1L47JqwnnKTX8pgIpHSu3bbzAJytuDLK4XZmv/0sXWc7NCOtZtsPq6eAuswVd4V6X1UntPIW4YaHv+6rZLNxOyQ/3XfNDZ0F8nEOZ6AR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2eSj/az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545CDC2BD10;
	Mon,  3 Jun 2024 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717456658;
	bh=ZY6Zk9/nmbAxgm3FKkaBtYgNAaDWbv7PsePRVgeWcxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2eSj/azJPbiUNjWb0TX/U8NZ4w6epwD1YeI/bYSv1+9q+FPR9Dl5HHm1IbENPa1s
	 TwOgfxV3n6LE6Dti4QfIW1RyiIjAkL30M3kKUKyZDUqsdPtXdK3IglFzWOJ4gZjufY
	 rvbvCzeIeC2kc7mBy0/WR28Csz2Ci5bSMq/DgnUqHxgq3fPsyfqrtnSIFf/ZBYyvA5
	 0jUxfc9m+yQC0Yl9n4JHAYiSRFAgYj5rA9ylCHDNpcnrztlYU8ynzGtHhKmPTN6L8P
	 43OwcWOXUI76A1fYWH1Td9InRoubc6DJPoZJ8RqujWlFUJik0BGhrx1KahUo3RIULo
	 NaD55Q14+aZGQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: alan.maguire@oracle.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 4/5] bpftool: use BTF field iterator in btfgen
Date: Mon,  3 Jun 2024 16:17:18 -0700
Message-ID: <20240603231720.1893487-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603231720.1893487-1-andrii@kernel.org>
References: <20240603231720.1893487-1-andrii@kernel.org>
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


