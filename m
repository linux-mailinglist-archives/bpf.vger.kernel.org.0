Return-Path: <bpf+bounces-64521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF55B13D13
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7380C165E8F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E226E706;
	Mon, 28 Jul 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ELsYKYLx"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2619ABD8
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712689; cv=none; b=qg//ntocAtH1+YKKx8XswLridqXm6XpAkbCAnXrcmC8ChyiVowB/8Kwu+tWS9Cigr2GCA2iTLpCtD7t87Fq5a6Z1TGUSyVxEqYLrET/0AFy8OwhEpINXHw5EtIBlUFPEN3Z0Q3K/sZzbSj3q8CkXz/+CVe5P4HC4bA1rS2wLEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712689; c=relaxed/simple;
	bh=ED3CCOq426OF0fJ1lhmOxsB7Z68ZL24wVPUHQfW0NOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlT6MuL3sTNAptTZiPFjUzs7FlUzYr5c8PbCPikX/W0SQX1EvJFzrlr9zm/A6tPICXnDX2ARkIU2UI5PdTsrOKlupqX1prYuRhbP3bFrmDW6zpqstqyDV4dNaRIPW3Nsoeq47QTh9uP6t7fLGnvoY02Yd5a1bzdLHmMe78Dgyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ELsYKYLx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rliYIeyepAntH3MdzeEe9oYIFqdGqX7XHhwh3URcEYk=;
	b=ELsYKYLx476IM4a9iNP2XICH/ACBwnQnUL/qVqWo+tcTbMKiw+pGTgOSkT847Rfr3R8VO5
	AikVfqu+vDbSrtwi/csIkSPNdrkYq9uEDflNju3xDXsg9/5EyjI/OEdBuuhVz7HGC8k8DG
	RJR+BjKLfb9+hk+8uVRegAxxil/yRag=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 3/5] bpf: Report freplace attach failure reason via extended syscall
Date: Mon, 28 Jul 2025 22:23:44 +0800
Message-ID: <20250728142346.95681-4-leon.hwang@linux.dev>
In-Reply-To: <20250728142346.95681-1-leon.hwang@linux.dev>
References: <20250728142346.95681-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch enables detailed error reporting when a freplace program fails
to attach to its target.

By leveraging the extended 'bpf()' syscall with common attributes, users
can now retrieve the failure reason through the provided log buffer.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ca7ce8474812..4d1f58b14a0a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3446,7 +3446,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
 				   u64 bpf_cookie,
-				   enum bpf_attach_type attach_type)
+				   enum bpf_attach_type attach_type,
+				   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3571,7 +3572,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
 					      &tgt_info);
 		if (err)
 			goto out_unlock;
@@ -4109,7 +4110,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, attach_type, NULL);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -5514,9 +5515,11 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 }
 
 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *common_attrs)
 {
+	struct bpf_verifier_log *log = NULL;
 	struct bpf_prog *prog;
+	u32 log_true_size;
 	int ret;
 
 	if (CHECK_ATTR(BPF_LINK_CREATE))
@@ -5529,10 +5532,23 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
+	if (common_attrs->log_buf) {
+		log = kvzalloc(sizeof(*log), GFP_KERNEL);
+		if (!log) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = bpf_vlog_init(log, BPF_LOG_FIXED,
+				    (char __user *) (unsigned long) common_attrs->log_buf,
+				    common_attrs->log_size);
+		if (ret)
+			goto out_free_log;
+	}
+
 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
 	if (ret)
-		goto out;
+		goto out_free_log;
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5549,7 +5565,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 					      attr->link_create.target_fd,
 					      attr->link_create.target_btf_id,
 					      attr->link_create.tracing.cookie,
-					      attr->link_create.attach_type);
+					      attr->link_create.attach_type,
+					      log);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
@@ -5569,7 +5586,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
 						      attr->link_create.tracing.cookie,
-						      attr->link_create.attach_type);
+						      attr->link_create.attach_type,
+						      log);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
@@ -5612,6 +5630,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = -EINVAL;
 	}
 
+	if (ret < 0 && log)
+		(void) bpf_vlog_finalize(log, &log_true_size);
+out_free_log:
+	if (log)
+		kvfree(log);
 out:
 	if (ret < 0)
 		bpf_prog_put(prog);
@@ -6099,7 +6122,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &common_attrs);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
-- 
2.50.1


