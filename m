Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3565BB903
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIQPNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIQPN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C6201A7
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDtX1XrKzlClX
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S11;
        Sat, 17 Sep 2022 23:13:26 +0800 (CST)
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
Subject: [PATCH bpf-next 07/10] selftests/bpf: Add two new dynptr_fail cases for map key
Date:   Sat, 17 Sep 2022 23:31:22 +0800
Message-Id: <20220917153125.2001645-8-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220917153125.2001645-1-houtao@huaweicloud.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S11
X-Coremail-Antispam: 1UD129KBjvJXoWxurWxKFWxJw1kAw4rWF45KFg_yoW5Ww4fpa
        4rC3y2qr1SqFsrtryfG397ZF4Sgr1kXrW5GFs3tryYvrnrZr93ur1xKF17Xr9xKrs5Cr4a
        v3y2qF4ruayUX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now bpf_dynptr is also not usable for map key, so add two test cases to
ensure that: one to directly use bpf_dynptr use as map key and another
to use a struct with embedded bpf_dynptr as map key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 43 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index bcf80b9f7c27..1df50fe1a741 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,8 @@ static struct {
 	{"ringbuf_invalid_api", "type=mem expected=alloc_mem"},
 	{"add_dynptr_to_map1", "invalid indirect read from stack"},
 	{"add_dynptr_to_map2", "invalid indirect read from stack"},
+	{"add_dynptr_to_key1", "invalid indirect read from stack"},
+	{"add_dynptr_to_key2", "invalid indirect read from stack"},
 	{"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
 	{"data_slice_out_of_bounds_map_value", "value is outside of the allowed memory range"},
 	{"data_slice_use_after_release1", "invalid mem access 'scalar'"},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b0f08ff024fb..85cc32999e8e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -35,6 +35,20 @@ struct {
 	__type(value, __u32);
 } array_map3 SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, struct bpf_dynptr);
+	__type(value, __u32);
+} hash_map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, struct test_info);
+	__type(value, __u32);
+} hash_map2 SEC(".maps");
+
 struct sample {
 	int pid;
 	long value;
@@ -206,6 +220,35 @@ int add_dynptr_to_map2(void *ctx)
 	return 0;
 }
 
+/* Can't use a dynptr as key of normal map */
+SEC("?raw_tp")
+int add_dynptr_to_key1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	get_map_val_dynptr(&ptr);
+	bpf_map_lookup_elem(&hash_map1, &ptr);
+
+	return 0;
+}
+
+/* Can't use a struct with an embedded dynptr as key of normal map */
+SEC("?raw_tp")
+int add_dynptr_to_key2(void *ctx)
+{
+	struct test_info x;
+
+	x.x = 0;
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &x.ptr);
+
+	/* this should fail */
+	bpf_map_lookup_elem(&hash_map2, &x);
+
+	bpf_ringbuf_submit_dynptr(&x.ptr, 0);
+
+	return 0;
+}
+
 /* A data slice can't be accessed out of bounds */
 SEC("?raw_tp")
 int data_slice_out_of_bounds_ringbuf(void *ctx)
-- 
2.29.2

