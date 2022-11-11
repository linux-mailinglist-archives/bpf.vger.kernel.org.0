Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F354D625A95
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 13:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKKMjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 07:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiKKMj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 07:39:27 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658E7B20B;
        Fri, 11 Nov 2022 04:39:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7yvD2yLsz4f3w0C;
        Fri, 11 Nov 2022 20:39:20 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgDX+9h6Qm5j+2ZmAQ--.47155S2;
        Fri, 11 Nov 2022 20:39:23 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf] bpf: Fix offset calculation error in __copy_map_value and zero_map_value
Date:   Fri, 11 Nov 2022 07:56:20 -0500
Message-Id: <20221111125620.754855-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDX+9h6Qm5j+2ZmAQ--.47155S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDJFy8Kr4ktry3uFWfZrb_yoW8GF4kpF
        Z8KFyjkr1kXrWjqrZ8Xw1xCr95Aw4qkw1UGr98CayrtF1fJrnFqryxGF42q398Gr4vvr4U
        ZF12qFZYk3yIqrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Function __copy_map_value and zero_map_value miscalculated copy offset,
resulting in possible copy of unwanted data to user or kernel.

Fix it.

Fixes: cc48755808c6 ("bpf: Add zero_map_value to zero map value with special fields")
Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 74c6f449d81e..c1bd1bd10506 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -315,7 +315,7 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
 		u32 next_off = map->off_arr->field_off[i];
 
 		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		curr_off = next_off + map->off_arr->field_sz[i];
 	}
 	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
 }
@@ -344,7 +344,7 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 		u32 next_off = map->off_arr->field_off[i];
 
 		memset(dst + curr_off, 0, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		curr_off = next_off + map->off_arr->field_sz[i];
 	}
 	memset(dst + curr_off, 0, map->value_size - curr_off);
 }
-- 
2.30.2

