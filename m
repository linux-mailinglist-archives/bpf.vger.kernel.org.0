Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF85755B3
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiGNTRC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiGNTRB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:17:01 -0400
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373843DBDA
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:17:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkPN63gVvz9xGP4;
        Fri, 15 Jul 2022 03:15:50 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:16:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v8 09/12] selftests/bpf: Test kfuncs with __maybe_null suffix
Date:   Thu, 14 Jul 2022 21:14:52 +0200
Message-ID: <20220714191455.2101834-10-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the test in kfunc_call_test.c to call the newly defined functions
bpf_kfunc_call_test4() and bpf_kfunc_call_test_mem_len_pass2(), which have
a parameter with the __maybe_null suffix. Ensure that the eBPF program is
executed successfully.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 net/bpf/test_run.c                              | 11 +++++++++++
 .../selftests/bpf/prog_tests/kfunc_call.c       |  4 ++++
 .../selftests/bpf/progs/kfunc_call_test.c       | 17 +++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2ca96acbc50a..22b4efe72ce9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -551,6 +551,11 @@ struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
 	return sk;
 }
 
+struct sock *noinline bpf_kfunc_call_test4(struct sock *sk__maybe_null)
+{
+	return sk__maybe_null;
+}
+
 struct prog_test_member1 {
 	int a;
 };
@@ -683,6 +688,10 @@ noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
+noinline void bpf_kfunc_call_test_mem_len_pass2(u64 *mem__maybe_null)
+{
+}
+
 noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
@@ -699,6 +708,7 @@ BTF_SET_START(test_sk_check_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test1)
 BTF_ID(func, bpf_kfunc_call_test2)
 BTF_ID(func, bpf_kfunc_call_test3)
+BTF_ID(func, bpf_kfunc_call_test4)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
 BTF_ID(func, bpf_kfunc_call_memb_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
@@ -712,6 +722,7 @@ BTF_ID(func, bpf_kfunc_call_test_fail1)
 BTF_ID(func, bpf_kfunc_call_test_fail2)
 BTF_ID(func, bpf_kfunc_call_test_fail3)
 BTF_ID(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID(func, bpf_kfunc_call_test_mem_len_pass2)
 BTF_ID(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_SET_END(test_sk_check_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index c00eb974eb85..4b90abb950b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -30,6 +30,10 @@ static void test_main(void)
 	ASSERT_OK(err, "bpf_prog_test_run(test2)");
 	ASSERT_EQ(topts.retval, 3, "test2-retval");
 
+	prog_fd = skel->progs.kfunc_call_test4.prog_fd;
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run(test4)");
+
 	prog_fd = skel->progs.kfunc_call_test_ref_btf_id.prog_fd;
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "bpf_prog_test_run(test_ref_btf_id)");
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 5aecbb9fdc68..258fa89f23b2 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -6,6 +6,7 @@
 extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
 extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				  __u32 c, __u64 d) __ksym;
+extern struct sock *bpf_kfunc_call_test4(struct sock *sk__maybe_null) __ksym;
 
 extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
 extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
@@ -13,8 +14,23 @@ extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
 extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+extern void bpf_kfunc_call_test_mem_len_pass2(u64 *mem__maybe_null) __ksym;
 extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
+SEC("tc")
+int kfunc_call_test4(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk = skb->sk;
+
+	if (!sk)
+		return -1;
+
+	sk = bpf_sk_fullsock(sk);
+
+	bpf_kfunc_call_test4((struct sock *)sk);
+	return 0;
+}
+
 SEC("tc")
 int kfunc_call_test2(struct __sk_buff *skb)
 {
@@ -87,6 +103,7 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
 	bpf_kfunc_call_test_mem_len_pass1(&c, sizeof(c));
 	bpf_kfunc_call_test_mem_len_pass1(&d, sizeof(d));
 	bpf_kfunc_call_test_mem_len_pass1(&e, sizeof(e));
+	bpf_kfunc_call_test_mem_len_pass2(NULL);
 	bpf_kfunc_call_test_mem_len_fail2(&b, -1);
 
 	return 0;
-- 
2.25.1

