Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A665E8CFF
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIXNSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIXNSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9122B5E7F
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MZV0M5pP8zl8LZ
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S6;
        Sat, 24 Sep 2022 21:18:19 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 02/13] bpf: Add helper btf_find_dynptr()
Date:   Sat, 24 Sep 2022 21:36:09 +0800
Message-Id: <20220924133620.4147153-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxAryfKF47Jw4DCFyfZwb_yoW8Zryfpa
        yDA3y7Zr48JFWagw1DWa13Cw43Kw4UWw4akFy2g343tFWYqr9rXF4DKr1xur90yrWjkr47
        Zr4ag398A34xA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOE_MDUUUU
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

Add helper btf_find_dynptr() to check whether or not the passed btf type
is bpf_dynptr. It can be extend to find an embedded dynptr in passed btf
type if needed later.

It will be used by bpf map (e.g. qp-trie) with bpf_dynptr key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/btf.h |  1 +
 kernel/bpf/btf.c    | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9aababc5d78..5bf508c2bad2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -165,6 +165,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t);
+int btf_find_dynptr(const struct btf *btf, const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a44ad4b347ff..fefbe84c6998 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3522,6 +3522,19 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+/* Now only allow to use 'struct bpf_dynptr' as map key.
+ * Map key with embedded bpf_dynptr is not allowed.
+ */
+int btf_find_dynptr(const struct btf *btf, const struct btf_type *t)
+{
+	/* Only allow struct type */
+	if (__btf_type_is_struct(t) && t->size == sizeof(struct bpf_dynptr) &&
+	    !strcmp("bpf_dynptr", __btf_name_by_offset(btf, t->name_off)))
+		return 0;
+
+	return -EINVAL;
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
-- 
2.29.2

