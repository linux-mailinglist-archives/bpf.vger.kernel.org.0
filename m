Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E550B671661
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 09:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjARIhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 03:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjARIhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 03:37:10 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 123247EE5B;
        Tue, 17 Jan 2023 23:56:58 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxrvBJpsdjy0kCAA--.7296S3;
        Wed, 18 Jan 2023 15:56:57 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+RHpsdjVzUbAA--.17363S2;
        Wed, 18 Jan 2023 15:56:55 +0800 (CST)
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
Subject: [PATCH bpf-next v2] selftests/bpf: Fix build errors if CONFIG_NF_CONNTRACK=m
Date:   Wed, 18 Jan 2023 15:56:44 +0800
Message-Id: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxf+RHpsdjVzUbAA--.17363S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFykGr17ZryxCFyDXr4fZrb_yoW5XrW8pa
        48Z3s0yr4kGw4UuF1xAFZ7Zr4rKFs29a4UJw1kJrWSkrZ5Xr1Utr1xKr43Ar9xurW09ay3
        Za42gry7AFyrAaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jwnYwUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.

$ make -C tools/testing/selftests/bpf/

  CLNG-BPF [test_maps] test_bpf_nf.bpf.o
progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
                bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
                                                       ^
progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
                bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
                                                       ^
2 errors generated.

Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
Do not fail build if CONFIG_NF_CONNTRACK=m/n").

Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e..9fc603c 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -34,6 +34,11 @@ __be16 dport = 0;
 int test_exist_lookup = -ENOENT;
 u32 test_exist_lookup_mark = 0;
 
+enum nf_nat_manip_type___local {
+	NF_NAT_MANIP_SRC___local,
+	NF_NAT_MANIP_DST___local
+};
+
 struct nf_conn;
 
 struct bpf_ct_opts___local {
@@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
 int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
 int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
 int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
-			int port, enum nf_nat_manip_type) __ksym;
+			int port, enum nf_nat_manip_type___local) __ksym;
 
 static __always_inline void
 nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
@@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 
 		/* snat */
 		saddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
+		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
 		/* dnat */
 		daddr.ip = bpf_get_prandom_u32();
-		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
+		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
 
 		ct_ins = bpf_ct_insert_entry(ct);
 		if (ct_ins) {
-- 
2.1.0

