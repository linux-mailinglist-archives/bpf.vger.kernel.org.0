Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F325BF3BA
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIUCoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiIUCoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:44:12 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C717D784;
        Tue, 20 Sep 2022 19:44:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXN3l2yJpz6T8t2;
        Wed, 21 Sep 2022 10:42:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgD3xCh3eipjRFhmBA--.50399S5;
        Wed, 21 Sep 2022 10:44:09 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v5 3/3] selftests/bpf: Adapt cgroup effective query uapi change
Date:   Wed, 21 Sep 2022 10:46:04 +0000
Message-Id: <20220921104604.2340580-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921104604.2340580-1-pulehui@huaweicloud.com>
References: <20220921104604.2340580-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgD3xCh3eipjRFhmBA--.50399S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUXw1xJr43ZF47XF48Crg_yoW8uw1kpF
        ykZ34Ut3WrWr1agF1kA3s2vrWI9FsxW3WIyF4UJrW3ZFy2vr10vr1xKws0vF1rJrWvyw4F
        va4Yy398XF4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjTRNzVbUUUUU
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

The attach flags is meaningless for effective query and
its value will always be set as 0 during effective query.
Root cg's effective progs is always its attached progs,
so we use non-effective query to get its progs count and
attach flags. And we don't need the remain attach flags
check.

Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_link.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
index 9e6e6aad347c..15093a69510e 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_link.c
@@ -71,10 +71,9 @@ void serial_test_cgroup_link(void)
 
 	ping_and_check(cg_nr, 0);
 
-	/* query the number of effective progs and attach flags in root cg */
+	/* query the number of attached progs and attach flags in root cg */
 	err = bpf_prog_query(cgs[0].fd, BPF_CGROUP_INET_EGRESS,
-			     BPF_F_QUERY_EFFECTIVE, &attach_flags, NULL,
-			     &prog_cnt);
+			     0, &attach_flags, NULL, &prog_cnt);
 	CHECK_FAIL(err);
 	CHECK_FAIL(attach_flags != BPF_F_ALLOW_MULTI);
 	if (CHECK(prog_cnt != 1, "effect_cnt", "exp %d, got %d\n", 1, prog_cnt))
@@ -85,17 +84,15 @@ void serial_test_cgroup_link(void)
 			     BPF_F_QUERY_EFFECTIVE, NULL, NULL,
 			     &prog_cnt);
 	CHECK_FAIL(err);
-	CHECK_FAIL(attach_flags != BPF_F_ALLOW_MULTI);
 	if (CHECK(prog_cnt != cg_nr, "effect_cnt", "exp %d, got %d\n",
 		  cg_nr, prog_cnt))
 		goto cleanup;
 
 	/* query the effective prog IDs in last cg */
 	err = bpf_prog_query(cgs[last_cg].fd, BPF_CGROUP_INET_EGRESS,
-			     BPF_F_QUERY_EFFECTIVE, &attach_flags,
-			     prog_ids, &prog_cnt);
+			     BPF_F_QUERY_EFFECTIVE, NULL, prog_ids,
+			     &prog_cnt);
 	CHECK_FAIL(err);
-	CHECK_FAIL(attach_flags != BPF_F_ALLOW_MULTI);
 	if (CHECK(prog_cnt != cg_nr, "effect_cnt", "exp %d, got %d\n",
 		  cg_nr, prog_cnt))
 		goto cleanup;
-- 
2.25.1

