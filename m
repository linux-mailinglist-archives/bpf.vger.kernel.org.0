Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC295BB904
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIQPNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIQPN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692492C129
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDt92dpkzKNy6
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S9;
        Sat, 17 Sep 2022 23:13:25 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next 05/10] libbpf: Add helpers for bpf_dynptr_user
Date:   Sat, 17 Sep 2022 23:31:20 +0800
Message-Id: <20220917153125.2001645-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220917153125.2001645-1-houtao@huaweicloud.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4DKFy5tF1kAr18Gw1xXwb_yoW8XF1Dpa
        yfK3y3Zr4rJFW3Cwn8JF4SyrW5uF4xXr1UKrWxK34rAr43XFZ8ZF1jkr1ayr1YyrWkWrWI
        vrZxKrW5WF18JF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add bpf_dynptr_user_init() to initialize a bpf_dynptr, and
bpf_dynptr_user_get_{data,size} to get the buffer address
and buffer length of bpf_dynptr_user.

Instead of exporting these symbols, simply adding these helpers as
inline functions.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/bpf.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9c50beabdd14..cd3e9dbaffa1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -371,6 +371,25 @@ LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
 
+/* sys_bpf() will check the validity of size */
+static inline void bpf_dynptr_user_init(void *data, __u32 size, struct bpf_dynptr_user *dynptr)
+{
+	/* Zero padding bytes */
+	memset(dynptr, 0, sizeof(*dynptr));
+	dynptr->data = (__u64)(unsigned long)data;
+	dynptr->size = size;
+}
+
+static inline __u32 bpf_dynptr_user_get_size(const struct bpf_dynptr_user *dynptr)
+{
+	return dynptr->size;
+}
+
+static inline void *bpf_dynptr_user_get_data(const struct bpf_dynptr_user *dynptr)
+{
+	return (void *)(unsigned long)dynptr->data;
+}
+
 struct bpf_prog_query_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 query_flags;
-- 
2.29.2

