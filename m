Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2666B6C1
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 05:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjAPEzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 23:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjAPEzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 23:55:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA2F559F;
        Sun, 15 Jan 2023 20:55:16 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax3eqz2MRjp84BAA--.5634S3;
        Mon, 16 Jan 2023 12:55:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+Sx2MRjIQ8aAA--.13747S2;
        Mon, 16 Jan 2023 12:55:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build errors of test_bpf_nf.c
Date:   Mon, 16 Jan 2023 12:55:08 +0800
Message-Id: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxX+Sx2MRjIQ8aAA--.13747S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF13Kr4kCFW3Xr17ZryrWFg_yoW8JFW3pa
        48Z3s0yFs5Ka1UuFn3CrW2vr4FyFs2vayUJw18ArW3Kr95Xr17tr4xKF47Jr9xGrWFq3s3
        Za4IgFZrZF18A3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Z2-UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

$ make -C tools/testing/selftests/bpf/

  CLNG-BPF [test_maps] test_bpf_nf.bpf.o
progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
                bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
                                                       ^
progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
                bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
                                                       ^
2 errors generated.

Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c
to fix the above build errors.

Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e..114f961 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -34,6 +34,11 @@ __be16 dport = 0;
 int test_exist_lookup = -ENOENT;
 u32 test_exist_lookup_mark = 0;
 
+enum nf_nat_manip_type {
+	NF_NAT_MANIP_SRC,
+	NF_NAT_MANIP_DST
+};
+
 struct nf_conn;
 
 struct bpf_ct_opts___local {
-- 
2.1.0

