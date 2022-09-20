Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837005BDE9D
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiITHnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiITHmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 03:42:52 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DB61109;
        Tue, 20 Sep 2022 00:41:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWthL2zg9z6T76M;
        Tue, 20 Sep 2022 15:38:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgBH4mt1biljrIh4BA--.36206S3;
        Tue, 20 Sep 2022 15:40:39 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v4 1/2] bpf, cgroup: Reject prog_attach_flags array when effective query
Date:   Tue, 20 Sep 2022 15:42:32 +0000
Message-Id: <20220920154233.1494352-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920154233.1494352-1-pulehui@huaweicloud.com>
References: <20220920154233.1494352-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH4mt1biljrIh4BA--.36206S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1xGF47uw17Aw4UCw4rXwb_yoW7Cw43pF
        4kXFy7KF15XasrZFZ2k3yFqrWI9w1xJa1UCrW5Jr15uFWUWr18ArWxCFWY9FyYqFWqyw10
        ya4Yvr98Wa4DuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNEfYUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

Attach flags is only valid for attached progs of this layer cgroup,
but not for effective progs. For querying with EFFECTIVE flags,
exporting attach flags does not make sense. So when effective query,
we reject prog_attach_flags array and don't need to populate it.
Also we limit attach_flags to output 0 during effective query.

Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 include/uapi/linux/bpf.h       |  7 +++++--
 kernel/bpf/cgroup.c            | 28 ++++++++++++++++++----------
 tools/include/uapi/linux/bpf.h |  7 +++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 59a217ca2dfd..4eff7fc7ae58 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1233,7 +1233,7 @@ enum {
 
 /* Query effective (directly attached + inherited from ancestor cgroups)
  * programs that will be executed for events within a cgroup.
- * attach_flags with this flag are returned only for directly attached programs.
+ * attach_flags with this flag are always returned 0.
  */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
@@ -1432,7 +1432,10 @@ union bpf_attr {
 		__u32		attach_flags;
 		__aligned_u64	prog_ids;
 		__u32		prog_cnt;
-		__aligned_u64	prog_attach_flags; /* output: per-program attach_flags */
+		/* output: per-program attach_flags.
+		 * not allowed to be set during effective query.
+		 */
+		__aligned_u64	prog_attach_flags;
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4a400cd63731..22888aaa68b6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1020,6 +1020,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			      union bpf_attr __user *uattr)
 {
 	__u32 __user *prog_attach_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
+	bool effective_query = attr->query.query_flags & BPF_F_QUERY_EFFECTIVE;
 	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
 	enum bpf_attach_type type = attr->query.attach_type;
 	enum cgroup_bpf_attach_type from_atype, to_atype;
@@ -1029,8 +1030,12 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	int total_cnt = 0;
 	u32 flags;
 
+	if (effective_query && prog_attach_flags)
+		return -EINVAL;
+
 	if (type == BPF_LSM_CGROUP) {
-		if (attr->query.prog_cnt && prog_ids && !prog_attach_flags)
+		if (!effective_query && attr->query.prog_cnt &&
+		    prog_ids && !prog_attach_flags)
 			return -EINVAL;
 
 		from_atype = CGROUP_LSM_START;
@@ -1045,7 +1050,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	}
 
 	for (atype = from_atype; atype <= to_atype; atype++) {
-		if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
+		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
 			total_cnt += bpf_prog_array_length(effective);
@@ -1054,6 +1059,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		}
 	}
 
+	/* always output uattr->query.attach_flags as 0 during effective query */
+	flags = effective_query ? 0 : flags;
 	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
 		return -EFAULT;
 	if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total_cnt)))
@@ -1068,7 +1075,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	}
 
 	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
-		if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
+		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
 			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
@@ -1090,15 +1097,16 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 				if (++i == cnt)
 					break;
 			}
-		}
 
-		if (prog_attach_flags) {
-			flags = cgrp->bpf.flags[atype];
+			if (prog_attach_flags) {
+				flags = cgrp->bpf.flags[atype];
 
-			for (i = 0; i < cnt; i++)
-				if (copy_to_user(prog_attach_flags + i, &flags, sizeof(flags)))
-					return -EFAULT;
-			prog_attach_flags += cnt;
+				for (i = 0; i < cnt; i++)
+					if (copy_to_user(prog_attach_flags + i,
+							 &flags, sizeof(flags)))
+						return -EFAULT;
+				prog_attach_flags += cnt;
+			}
 		}
 
 		prog_ids += cnt;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59a217ca2dfd..4eff7fc7ae58 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1233,7 +1233,7 @@ enum {
 
 /* Query effective (directly attached + inherited from ancestor cgroups)
  * programs that will be executed for events within a cgroup.
- * attach_flags with this flag are returned only for directly attached programs.
+ * attach_flags with this flag are always returned 0.
  */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
@@ -1432,7 +1432,10 @@ union bpf_attr {
 		__u32		attach_flags;
 		__aligned_u64	prog_ids;
 		__u32		prog_cnt;
-		__aligned_u64	prog_attach_flags; /* output: per-program attach_flags */
+		/* output: per-program attach_flags.
+		 * not allowed to be set during effective query.
+		 */
+		__aligned_u64	prog_attach_flags;
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-- 
2.25.1

