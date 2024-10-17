Return-Path: <bpf+bounces-42270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7C9A18B8
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC27B21615
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535864EB50;
	Thu, 17 Oct 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v63lt+hZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13C2E634;
	Thu, 17 Oct 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133066; cv=none; b=QniCERm37qxH7QFiFqW1OmdsJS4c5dG0j5yVhRLdq4sD8JsvASLKMl69jM8JWN9zT41XFRxX6StypT0uC7Trsa3NJt1+oJt5/ui1PlzsekKg1TfnEySoY0LzM4aeTMArxrjBeed19CqnystjuJYmZq51SoQn55RJcyPzqM7xxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133066; c=relaxed/simple;
	bh=8KoZ2kpEd03wl3lrz7JRhdiv71toJ7tTlc3ik+/I4z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iP/xOCZnCG9cy8iMEx+Es615lkX+bqZWv8lUN8V9trSqIfWOyT11F38T0V2FsWOxsJHvHFQNIwb5RPeQPLS7XMlQ0fhVFwd+dY+SdUVA2ShXII+PEtnkTgbQkZ7Vu0Sj2SZw58EVbnmoQ+eRthMwk9NhN1u91L/H4Y2cqHwnzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v63lt+hZ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729133060; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vfoyBX3kAainjACegyR5c2rdGok5MTh08dlMmJ6ZTPY=;
	b=v63lt+hZ4RizVd85yC9u80BZ4cgucdAL0nVAw4rOg6ewUSVE+p/yn/TZtlNl3XtrY/kaw9K9+vUrEnq4oSx/5iCT/57pdAYRL88bc54EBz3afpahcioUU/29+wqr0DcqzVlBeWsVJBpTxOxA0os1hpWxIeJ79tbUnTIgQzxMMPs=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WHJBthg_1729133053 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:44:20 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2] sched_ext: Use btf_ids to resolve task_struct
Date: Thu, 17 Oct 2024 10:44:12 +0800
Message-Id: <20241017024412.16914-1-dtcccc@linux.alibaba.com>
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
v2:
Use the existing btf_tracing_ids[BTF_TRACING_TYPE_TASK].

v1: https://lore.kernel.org/all/20241016024100.7409-1-dtcccc@linux.alibaba.com/
---
 kernel/sched/ext.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 609b9fb00d6f..09fe4e1552bb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5343,7 +5343,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 extern struct btf *btf_vmlinux;
 static const struct btf_type *task_struct_type;
-static u32 task_struct_type_id;
 
 static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
 			       enum bpf_access_type type,
@@ -5395,7 +5394,7 @@ static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
 		 */
 		info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
 		info->btf = btf_vmlinux;
-		info->btf_id = task_struct_type_id;
+		info->btf_id = btf_tracing_ids[BTF_TRACING_TYPE_TASK];
 
 		return true;
 	}
@@ -5547,13 +5546,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 
 static int bpf_scx_init(struct btf *btf)
 {
-	s32 type_id;
-
-	type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
-	if (type_id < 0)
-		return -EINVAL;
-	task_struct_type = btf_type_by_id(btf, type_id);
-	task_struct_type_id = type_id;
+	task_struct_type = btf_type_by_id(btf, btf_tracing_ids[BTF_TRACING_TYPE_TASK]);
 
 	return 0;
 }
-- 
2.39.3


