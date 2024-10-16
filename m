Return-Path: <bpf+bounces-42140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDF99FEF8
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31EE1F21FE3
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40216D9AA;
	Wed, 16 Oct 2024 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Giii2B8Q"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198D1531CC;
	Wed, 16 Oct 2024 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046471; cv=none; b=KSK1iHhSZfhQIpjTH1FlTifPAq0KIcLQtx3WvAq8u4lxoPGih02IcP3n4UDAUzWVAnCxGIU5yabkbHl+/e0AeUAgAqViy2NdIcgHgLoQpHTIjsj87+W5es4Co655tJ8ea0h1sixUi3KQNnnpizsGVsdZI8SXaG13D28Y9DT5nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046471; c=relaxed/simple;
	bh=ys8gptlElzkicMoE5t34IbuCXUT2CNO8Pb2OWpgkyXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nxpm+37NaXWcMRB5tQPnoexJe5f9ZlE4l2CCW5wrGEd+PX3LcZ5mBFIN8GPERFooZyJoALdaoiau+O95DWRrMo90RSJkhVJp9jbSs2YZ5NxfrkVs310joP7hsF6zTIvaG7H1ttWRw44Aq4DITzfsZ/TFyt+vROY4C1C4fTByDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Giii2B8Q; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729046466; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9QMEN9fz2V+J79ftu33LIyzvfK8uBRbvpJpsFy/lS98=;
	b=Giii2B8QXimRxMpXDXeJf4dCjOmlmRBK6PM5SiX3kFs9HY6yj4YLLtkAUIANXpZoy4HtyXYv0Vq4HTJRROLaPY/oYCzxfFeg8R+1MzuYQNuvw+tHtCv70o9XyCjFpYX3KYBKNDJSiJc21iUAzHqTYiMt+PouJZSg1U6+GqeIR1g=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WHFMFNG_1729046460 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 10:41:05 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: Use BTF_ID to resolve task_struct
Date: Wed, 16 Oct 2024 10:41:00 +0800
Message-Id: <20241016024100.7409-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the searching time during bpf_scx_init.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/ext.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 609b9fb00d6f..1d11a96eefb8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5343,7 +5343,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 extern struct btf *btf_vmlinux;
 static const struct btf_type *task_struct_type;
-static u32 task_struct_type_id;
+BTF_ID_LIST_SINGLE(task_struct_btf_ids, struct, task_struct);
 
 static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
 			       enum bpf_access_type type,
@@ -5395,7 +5395,7 @@ static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
 		 */
 		info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
 		info->btf = btf_vmlinux;
-		info->btf_id = task_struct_type_id;
+		info->btf_id = task_struct_btf_ids[0];
 
 		return true;
 	}
@@ -5547,13 +5547,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 
 static int bpf_scx_init(struct btf *btf)
 {
-	s32 type_id;
-
-	type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
-	task_struct_type = btf_type_by_id(btf, type_id);
-	task_struct_type_id = type_id;
+	task_struct_type = btf_type_by_id(btf, task_struct_btf_ids[0]);
 
 	return 0;
 }
-- 
2.39.3


