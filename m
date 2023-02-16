Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC03698A63
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 03:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBPCNR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 21:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPCNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 21:13:17 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7B2007D
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 18:13:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHJPy2bCWz4f3jJ2
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 10:13:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLA2ke1j8zzSDg--.19561S4;
        Thu, 16 Feb 2023 10:13:12 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        David Vernet <void@manifault.com>, houtao1@huawei.com
Subject: [PATCH bpf-next] bpf: Only allocate one bpf_mem_cache for bpf_cpumask_ma
Date:   Thu, 16 Feb 2023 10:41:34 +0800
Message-Id: <20230216024134.2094999-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLA2ke1j8zzSDg--.19561S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4xur1kWr1UAFW3Jw4rAFb_yoW5Gry3pF
        n7JrW0krWDtF4kGw17X3WxAa45G34vgwn2ka4UWry5uFyfWw4kGF4DXFy7XFn09rWDCayx
        Ar9Ygr409ryUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The size of bpf_cpumask is fixed, so there is no need to allocate many
bpf_mem_caches for bpf_cpumask_ma, just one bpf_mem_cache is enough.
Also add comments for bpf_mem_alloc_init() in bpf_mem_alloc.h to prevent
future miuse.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h | 7 +++++++
 kernel/bpf/cpumask.c          | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3e164b8efaa9..a7104af61ab4 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -14,6 +14,13 @@ struct bpf_mem_alloc {
 	struct work_struct work;
 };
 
+/* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
+ * Alloc and free are done with bpf_mem_cache_{alloc,free}().
+ *
+ * 'size = 0' is for bpf_mem_alloc which manages many fixed-size objects.
+ * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
+ * the returned object is given by the size argument of bpf_mem_alloc().
+ */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 52b981512a35..711434b556fb 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -55,7 +55,7 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
 	/* cpumask must be the first element so struct bpf_cpumask be cast to struct cpumask. */
 	BUILD_BUG_ON(offsetof(struct bpf_cpumask, cpumask) != 0);
 
-	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
+	cpumask = bpf_mem_cache_alloc(&bpf_cpumask_ma);
 	if (!cpumask)
 		return NULL;
 
@@ -123,7 +123,7 @@ __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 
 	if (refcount_dec_and_test(&cpumask->usage)) {
 		migrate_disable();
-		bpf_mem_free(&bpf_cpumask_ma, cpumask);
+		bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
 		migrate_enable();
 	}
 }
@@ -468,7 +468,7 @@ static int __init cpumask_kfunc_init(void)
 		},
 	};
 
-	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, 0, false);
+	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sieof(struct bpf_cpumask), false);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
-- 
2.29.2

