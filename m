Return-Path: <bpf+bounces-69040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC25B8BBA2
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6688A189E4A0
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B1D23815D;
	Sat, 20 Sep 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6pnqjv3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574823183A;
	Sat, 20 Sep 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329980; cv=none; b=aGOeFS5Bg+tOvIQz3mVhG8ZfFQiEH98LUpUa7l9t2/Q1wHlbtbhRt1UAgCmYx6L6/0Z+L9YtGhxgsTZ5np9UEoOHsSSvwdM1onxG5eV1MIPqjkUGxDh6r3fimcn4UcKNW5MReFDKZcYZ1n3Ez/+TO9dCkyFBvt4IeXRNEICN504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329980; c=relaxed/simple;
	bh=+aVfihu6YNzjff5HXcBiauQcIyue2N+htiTwTi60o/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObiVzcY6hgDbfwsyzaBZB7fKkNVsLhx4IX9RRbi6w/FsD0e+gjTWOaYt4aQE/ofpTOzg6txgx6LHwLtAeUidLzg+ocnxEoYDE1xcw85a6COqXjnRAo+l74uhSDnCloI9yptlrYuwa3f7ItYo16+OI8v7pz8cHS1aSO9aPFoCcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6pnqjv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A724C4CEF9;
	Sat, 20 Sep 2025 00:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329980;
	bh=+aVfihu6YNzjff5HXcBiauQcIyue2N+htiTwTi60o/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6pnqjv3hRSjX9KkXDIEWPeJ+lVPWbaZenrbzfR91+RtLEb9qy74kwEnB9ptCOB/N
	 zbRnFdUw1OufmR5rU5hVmj10XrxP4MuedQTnRrkU860Fricjap916tijfvuzKa6x5w
	 0HqL7CXmsUdAJc+yByyMR7M2xH6dGqzbnAtqNOAVXUb37aGSg+/Wn6Odm4dbBXAd9Z
	 RGwfNRL08QRzVrPvRDqxYIabRlNA33T9peJ+1FHzo+3kR/6PM9f4efzZeKbk0NjOye
	 bqa17bNnnxPWcGXCPZJvy0lm+gfthCjKFgMJJ8byFACBvNxGeqvA32mw2j4YIt5m++
	 LHeHmU5InI93A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/46] sched_ext: Make qmap dump operation non-destructive
Date: Fri, 19 Sep 2025 14:58:29 -1000
Message-ID: <20250920005931.2753828-7-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qmap dump operation was destructively consuming queue entries while
displaying them. As dump can be triggered anytime, this can easily lead to
stalls. Add a temporary dump_store queue and modify the dump logic to pop
entries, display them, and then restore them back to the original queue.
This allows dump operations to be performed without affecting the
scheduler's queue state.

Note that if racing against new enqueues during dump, ordering can get
mixed up, but this is acceptable for debugging purposes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 69d877501cb7..cd50a94326e3 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -56,7 +56,8 @@ struct qmap {
   queue1 SEC(".maps"),
   queue2 SEC(".maps"),
   queue3 SEC(".maps"),
-  queue4 SEC(".maps");
+  queue4 SEC(".maps"),
+  dump_store SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
@@ -578,11 +579,26 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 			return;
 
 		scx_bpf_dump("QMAP FIFO[%d]:", i);
+
+		/*
+		 * Dump can be invoked anytime and there is no way to iterate in
+		 * a non-destructive way. Pop and store in dump_store and then
+		 * restore afterwards. If racing against new enqueues, ordering
+		 * can get mixed up.
+		 */
 		bpf_repeat(4096) {
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
+			bpf_map_push_elem(&dump_store, &pid, 0);
 			scx_bpf_dump(" %d", pid);
 		}
+
+		bpf_repeat(4096) {
+			if (bpf_map_pop_elem(&dump_store, &pid))
+				break;
+			bpf_map_push_elem(fifo, &pid, 0);
+		}
+
 		scx_bpf_dump("\n");
 	}
 }
-- 
2.51.0


