Return-Path: <bpf+bounces-60185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBCAD3AEC
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E9216AA47
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48429AB1D;
	Tue, 10 Jun 2025 14:15:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AC299928
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564946; cv=none; b=puAhd4fatVkSp4NrYGeyn6lidJmqplepqR/3FS070ZDdDW2lYHvJfobHGLAz8QH2kopiA4Bn9WN9oVAJkyZMK8Pj9u5xGvEqooqoxGZchLRgjX7/Q52uY0GmyYVejZM+/Wk4FTseGKSDudQF6d5NKMcSw9Au6RITvpl2zo0VrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564946; c=relaxed/simple;
	bh=y1zuGmgDKCQ4JfKujRiNKfXWfionnWV/Y/2QGWehNzY=;
	h=From:To:Subject:Date:Message-Id; b=tyLsg7fZ/KbjKlCYVVB+bBrBur+lWP72qhqYIcrBfrW12Hj/e67058xoBiThtdID5FocXNdqRWXkJjB5xcW4kC+P3Cv9HkYVwwdBsoE7csGRS+SEf57ChASn4qwAzkv1t2gvAw/B+1nsI6M0ZMveZluIKsiukyY8PwpuOMb8x5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=pass smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4bGrGh3n17z2FtkM; Tue, 10 Jun 2025 16:07:56 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: bpf@vger.kernel.org
Subject: [PATCH] bpf: adjust path to trace_output sample eBPF program
Date: Tue, 10 Jun 2025 16:07:56 +0200
Message-Id: <20250610140756.16332-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The sample file was renamed from trace_output_kern.c to
trace_output.bpf.c in commit d4fffba4d04b ("samples/bpf: Change _kern
suffix to .bpf with syscall tracing program"). Adjust the path in the
documentation comment for bpf_perf_event_output.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 194ed9891b40..39e7818cca80 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2409,7 +2409,7 @@ union bpf_attr {
  * 		into it. An example is available in file
  * 		*samples/bpf/trace_output_user.c* in the Linux kernel source
  * 		tree (the eBPF program counterpart is in
- * 		*samples/bpf/trace_output_kern.c*).
+ *		*samples/bpf/trace_output.bpf.c*).
  *
  * 		**bpf_perf_event_output**\ () achieves better performance
  * 		than **bpf_trace_printk**\ () for sharing data with user
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 194ed9891b40..39e7818cca80 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2409,7 +2409,7 @@ union bpf_attr {
  * 		into it. An example is available in file
  * 		*samples/bpf/trace_output_user.c* in the Linux kernel source
  * 		tree (the eBPF program counterpart is in
- * 		*samples/bpf/trace_output_kern.c*).
+ *		*samples/bpf/trace_output.bpf.c*).
  *
  * 		**bpf_perf_event_output**\ () achieves better performance
  * 		than **bpf_trace_printk**\ () for sharing data with user
-- 
2.48.1


