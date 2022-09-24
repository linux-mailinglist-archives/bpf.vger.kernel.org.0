Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A45E8D00
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIXNSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXNSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:23 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4502B5E76
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MZV0M1WWczl8lW
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S5;
        Sat, 24 Sep 2022 21:18:18 +0800 (CST)
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
Subject: [PATCH bpf-next v2 01/13] bpf: Export bpf_dynptr_set_size()
Date:   Sat, 24 Sep 2022 21:36:08 +0800
Message-Id: <20220924133620.4147153-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3KFW7Jr43tFy7XF1DWrg_yoW8urWkpF
        1kC347Zr48tFW2gw4UJFs7Zw4Yga1UWr17Gry0k34FkrWqqr9xur1jgry7Gr98t3s8GrW3
        Arn7KrWFvF18XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjpB-UUUUU=
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

For map with bpf_dynptr-typed key, lookup and update procedures will use
bpf_dynptr_get_size() to get the length of key, and iteration procedure
will use bpf_dynptr_set_size() to set the length of returned key.

The implementation of bpf_dynptr_set_size() is taken from Joanne's patch
"bpf: Add bpf_dynptr_trim and bpf_dynptr_advance". Also add a const
qualifier to dynptr argument of bpf_dynptr_get_size().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 3 ++-
 kernel/bpf/helpers.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edd43edb27d6..66a18dc67b46 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2660,7 +2660,8 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
+void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b069517a3da0..a9ca2de8f8cd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1408,11 +1408,18 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
+void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
+{
+	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
+
+	ptr->size = new_size | metadata;
+}
+
 int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
-- 
2.29.2

