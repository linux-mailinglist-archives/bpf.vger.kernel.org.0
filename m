Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D875BC1C3
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiISDjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Sep 2022 23:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISDjN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Sep 2022 23:39:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56014D2F
        for <bpf@vger.kernel.org>; Sun, 18 Sep 2022 20:39:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MW9N84JvwzKK6p
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 11:37:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenNb5CdjTlU+BA--.58423S4;
        Mon, 19 Sep 2022 11:39:09 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next] selftests/bpf: Add test result messages for test_task_storage_map_stress_lookup
Date:   Mon, 19 Sep 2022 11:57:14 +0800
Message-Id: <20220919035714.2195144-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenNb5CdjTlU+BA--.58423S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4UZr4rZrW8Xry7Jw45GFg_yoW5Gr4Dpa
        yxA3WjkF1xt3Waqr1UGanruFWFg3Z3Z3y8Kr4qqrWayr4kJr92qr1xKF1UXr9xWrWFqan3
        ZwnagF1rur1kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add test result message when test_task_storage_map_stress_lookup()
succeeds or is skipped. The test case can be skipped due to the choose
of preemption model in kernel config, so export skips in test_maps.c and
increase it when needed.

The following is the output of test_maps when the test case succeeds or
is skipped:

  test_task_storage_map_stress_lookup:PASS
  test_maps: OK, 0 SKIPPED

  test_task_storage_map_stress_lookup SKIP (no CONFIG_PREEMPT)
  test_maps: OK, 1 SKIPPED

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/map_tests/task_storage_map.c | 6 +++++-
 tools/testing/selftests/bpf/test_maps.c                  | 2 +-
 tools/testing/selftests/bpf/test_maps.h                  | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 1adc9c292eb2..aac08c85240b 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -77,8 +77,11 @@ void test_task_storage_map_stress_lookup(void)
 	CHECK(err, "open_and_load", "error %d\n", err);
 
 	/* Only for a fully preemptible kernel */
-	if (!skel->kconfig->CONFIG_PREEMPT)
+	if (!skel->kconfig->CONFIG_PREEMPT) {
+		printf("%s SKIP (no CONFIG_PREEMPT)\n", __func__);
+		skips++;
 		return;
+	}
 
 	/* Save the old affinity setting */
 	sched_getaffinity(getpid(), sizeof(old), &old);
@@ -119,4 +122,5 @@ void test_task_storage_map_stress_lookup(void)
 	read_bpf_task_storage_busy__destroy(skel);
 	/* Restore affinity setting */
 	sched_setaffinity(getpid(), sizeof(old), &old);
+	printf("%s:PASS\n", __func__);
 }
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 1581a33b3f70..127c5c438a16 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -30,7 +30,7 @@
 #define ENOTSUPP 524
 #endif
 
-static int skips;
+int skips;
 
 static struct bpf_map_create_opts map_opts = { .sz = sizeof(map_opts) };
 
diff --git a/tools/testing/selftests/bpf/test_maps.h b/tools/testing/selftests/bpf/test_maps.h
index 77d8587ac4ed..f6fbca761732 100644
--- a/tools/testing/selftests/bpf/test_maps.h
+++ b/tools/testing/selftests/bpf/test_maps.h
@@ -14,4 +14,6 @@
 	}								\
 })
 
+extern int skips;
+
 #endif
-- 
2.29.2

