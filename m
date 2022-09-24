Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E85E8D02
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIXNS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIXNSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C11B6555
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MZV0P01q5zl8rr
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S8;
        Sat, 24 Sep 2022 21:18:20 +0800 (CST)
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
Subject: [PATCH bpf-next v2 04/13] bpf: Support bpf_dynptr-typed map key in verifier
Date:   Sat, 24 Sep 2022 21:36:11 +0800
Message-Id: <20220924133620.4147153-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4fKw1rArW3Xr4kZryfCrg_yoW8JFyDpF
        1kGry2qr48KFsI93W3ZFs7ArW5Jw10g3y7C3ySy3ySvF17Xr98urWFkF13Wry5trWkt34F
        yr42vFWFv34UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
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

For map with dynptr key, only allow a bpf_dynptr on stack to be used as
a map key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/verifier.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..5d2868a798d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6020,9 +6020,20 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
-					      NULL);
+		/* Allow bpf_dynptr to be used as map key */
+		if (map_key_has_dynptr(meta->map_ptr)) {
+			if (base_type(reg->type) != PTR_TO_STACK ||
+			    !is_dynptr_reg_valid_init(env, reg) ||
+			    !is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR)) {
+				verbose(env, "expect R%d to be dynptr instead of %s\n",
+					regno, reg_type_str(env, reg->type));
+				return -EACCES;
+			}
+		} else {
+			err = check_helper_mem_access(env, regno,
+						      meta->map_ptr->key_size, false,
+						      NULL);
+		}
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
-- 
2.29.2

