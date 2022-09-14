Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3365B82C1
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiINIQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 04:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiINIQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 04:16:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D8543FF;
        Wed, 14 Sep 2022 01:15:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSClw1bcSzKPts;
        Wed, 14 Sep 2022 16:14:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgB3yXK6jSFjj9FPAw--.59270S3;
        Wed, 14 Sep 2022 16:15:56 +0800 (CST)
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
        Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 1/2] bpf, cgroup: Don't populate prog_attach_flags array when effective query
Date:   Wed, 14 Sep 2022 16:17:41 +0000
Message-Id: <20220914161742.3180731-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914161742.3180731-1-pulehui@huaweicloud.com>
References: <20220914161742.3180731-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3yXK6jSFjj9FPAw--.59270S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykZr45GF15tr13ur1fXrb_yoW5Ar4UpF
        48ZFy2gFn8Gr9FqF4Dt39Yv3yrWa1xX3yUCrWUJw1YkFWjgr1I9ryxCFWY9F15Ga4vyw10
        y3WYvr1DJw1DuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        39aBUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

Attach flags is only valid for attached progs of this layer cgroup,
but not for effective progs. For querying with EFFECTIVE flags,
exporting attach flags does not make sense. so we don't need to
populate prog_attach_flags array when effective query.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/cgroup.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 00c7f864900e..45b1bc47f84e 100644
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
@@ -1030,7 +1031,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	u32 flags;
 
 	if (type == BPF_LSM_CGROUP) {
-		if (attr->query.prog_cnt && prog_ids && !prog_attach_flags)
+		if (attr->query.prog_cnt && prog_ids &&
+		    !effective_query && !prog_attach_flags)
 			return -EINVAL;
 
 		from_atype = CGROUP_LSM_START;
@@ -1045,7 +1047,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	}
 
 	for (atype = from_atype; atype <= to_atype; atype++) {
-		if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
+		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
 			total_cnt += bpf_prog_array_length(effective);
@@ -1068,7 +1070,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	}
 
 	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
-		if (attr->query.query_flags & BPF_F_QUERY_EFFECTIVE) {
+		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
 			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
@@ -1090,15 +1092,16 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
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
-- 
2.25.1

