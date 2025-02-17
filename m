Return-Path: <bpf+bounces-51752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04358A387ED
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF2E173D00
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EAE224B17;
	Mon, 17 Feb 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fm+yWrnS"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAD224882
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807049; cv=none; b=BAuYkT5k/GsNqSXj3gKDmJ/kFY+aVrizZRRaC/o1Oszm1dL6O3rJlYgoMjb+XEXXuH6phTFicLbvIHdYY28eGjfR7Vyjd1Va+vnBsgRuA5ReaAcWR+E080ZO6J9OR/SLDBH71Ft4l6ZbJSprbtGlj4elWq3gQXCKpBH6qgFH9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807049; c=relaxed/simple;
	bh=ntT/F2HrTU7R+7urokz7jPX2+BPKjPr76Lya51jX3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjiH8ac9TSX0ywvp7RwWHJVFzU7VryR2Mwvjf4xZ9/dkGlhbrOde4Sh7OK+6HTXb1W2bVmqXUDd1MHjnmxzXxGQpMSuqw8O7osNLsoAUzBVDfSsvD9fc24+6F4amfmEtv/P1oB8UBC8AuoF5m06+9mBRos73HqQraaqwxohI7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fm+yWrnS; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739807046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vz1s9Yz6Ba603QOaXuD0IG8RUHaHGm3l2KxEpKWn9c=;
	b=Fm+yWrnSc62bIdyop7y5RBmXBEs5WKXHaFSXOKQI49wJP7bZWYicUT/zuAQXdiyE8Oo5Wn
	9sRAtAm+Wj9RCRU9u6lSCtN9Z33TEbzJudZP6JCgt2C0o6S01v/gzv3MNpe+yrwwG/0xE+
	4WbyBiw6OJC0g1n89799ehhJgnbYjEQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/4] bpf: Improve error reporting for freplace attachment failure
Date: Mon, 17 Feb 2025 23:43:16 +0800
Message-ID: <20250217154318.76145-3-leon.hwang@linux.dev>
In-Reply-To: <20250217154318.76145-1-leon.hwang@linux.dev>
References: <20250217154318.76145-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a freplace program fails to attach to a target, the error message
lacks details, making debugging difficult. This patch enhances error
reporting by providing a log that explains why the attachment failed.

For example, if a freplace program tries to attach to a static function,
the log now includes:

libbpf: prog 'new_test_pkt_access': failed to attach to freplace: -EINVAL
libbpf: prog 'new_test_pkt_access': attach log: subprog_tail() is not a global function

Changes:

* Added verifier log to capture the log of freplace attachment failure.
* Updated bpf_tracing_prog_attach() to accept verifier log.
* Extended struct bpf_attr with a user-supplied log buffer for tracing
  programs.

This improves debugging by giving clear feedback when a freplace
attachment fails.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h |  2 ++
 kernel/bpf/syscall.c     | 51 +++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a2..bea4d802d4463 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1759,6 +1759,8 @@ union bpf_attr {
 				 * accessible through bpf_get_attach_cookie() BPF helper
 				 */
 				__u64		cookie;
+				__aligned_u64	log_buf;	/* user supplied buffer */
+				__u32		log_size;	/* size of user buffer */
 			} tracing;
 			struct {
 				__u32		pf;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c87..f41d1eea102a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3412,7 +3412,8 @@ static const struct bpf_link_ops bpf_tracing_link_lops = {
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 				   int tgt_prog_fd,
 				   u32 btf_id,
-				   u64 bpf_cookie)
+				   u64 bpf_cookie,
+				   struct bpf_verifier_log *log)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_prog *tgt_prog = NULL;
@@ -3537,7 +3538,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
+		err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
 					      &tgt_info);
 		if (err)
 			goto out_unlock;
@@ -3949,7 +3950,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 			tp_name = prog->aux->attach_func_name;
 			break;
 		}
-		return bpf_tracing_prog_attach(prog, 0, 0, 0);
+		return bpf_tracing_prog_attach(prog, 0, 0, 0, NULL);
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
@@ -5311,9 +5312,13 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 }
 
 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
+	struct bpf_verifier_log *log;
+	u32 log_true_size, log_size;
 	struct bpf_prog *prog;
+	__aligned_u64 log_buf;
+	bool use_log;
 	int ret;
 
 	if (CHECK_ATTR(BPF_LINK_CREATE))
@@ -5326,10 +5331,33 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
+	switch (prog->type) {
+	case BPF_PROG_TYPE_EXT:
+		log_buf = attr->link_create.tracing.log_buf;
+		log_size = attr->link_create.tracing.log_size;
+		use_log = true;
+		break;
+	default:
+		use_log = false;
+	}
+
+	if (use_log) {
+		log = kvzalloc(sizeof(*log), GFP_KERNEL);
+		if (!log) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = bpf_vlog_init(log, BPF_LOG_FIXED,
+				    (char __user *) (unsigned long) log_buf,
+				    log_size);
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
@@ -5345,7 +5373,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_tracing_prog_attach(prog,
 					      attr->link_create.target_fd,
 					      attr->link_create.target_btf_id,
-					      attr->link_create.tracing.cookie);
+					      attr->link_create.tracing.cookie,
+					      log);
 		break;
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_TRACING:
@@ -5363,7 +5392,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
 						      attr->link_create.target_btf_id,
-						      attr->link_create.tracing.cookie);
+						      attr->link_create.tracing.cookie,
+						      NULL);
 		break;
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
@@ -5406,6 +5436,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = -EINVAL;
 	}
 
+	if (ret < 0 && use_log)
+		(void) bpf_vlog_finalize(log, &log_true_size);
+out_free_log:
+	if (use_log)
+		kvfree(log);
 out:
 	if (ret < 0)
 		bpf_prog_put(prog);
@@ -5861,7 +5896,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, size);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
-- 
2.47.1


