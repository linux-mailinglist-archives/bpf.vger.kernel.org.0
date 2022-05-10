Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3826522635
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiEJVRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiEJVRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:17:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5150B36
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o69so339475pjo.3
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv3FmdT/C04wTY/7IU4S3jeXHrRadJrM6ycSbz0/lpQ=;
        b=ZkUq0QNr0behOTMaHhc0niJ+OaJoPWrDBpFcHSqXWz+f25wEknRFqYmaV6tW/TfznQ
         Ixe3yX8tCR4u2K3vN8UKjUCvXzMutFy6i/csXU2Yatkx52HcioVVSy0cNgOOLu/4Xryd
         GJk/T/J3HquTE+vFcVSWU0DfUiGiHpA7ezEeIZVx+9uylbEcoqWnsra9Eoi3nw5+uh22
         MlB8GiTs7ylcf9+qZNkVbBR8V+R/wzqcBinhnN3s2I/zFtVcCR+dS4ZaIzu9Hjs1OoP8
         xHr24Q0NY6EFqc55XGD64jYBMbOfB4Lr6MAvPnxxwG7TxL6y1gq0LHmUsr/Z+oUd8f1f
         hVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv3FmdT/C04wTY/7IU4S3jeXHrRadJrM6ycSbz0/lpQ=;
        b=xuQkJD3OGJM47HsQtR3NA32QXnwOA/hEq6xcYJ0s20lrEXpy+7qrsXM0QpEK0X6Znl
         7ouULZadp4cj39BJoXel9HSa6Rh04esnE2WD4CuhK+uOCNuEVc2f86DqqAYmoddpakSr
         mtPVmlVmLP7EyzC/ppy3QxxFRLGtAA3onY5ZUI0gJxdRg1ozBnzBb37N0UTCiWMimNVl
         SVMcnqOclTkavvCJdWB5z/B1ddxblg3LUlMfx4X94mhW4j3uUVObyD/m9L7EetQLNMVX
         qx6ZBrAOn/5ETIb81CQfbe+QNxZVZrveHm5Ek2kl0NJtK/2kdM8pgDTQSPyWCCBCBD2f
         BFaA==
X-Gm-Message-State: AOAM532XVkv7RLqhVTptVwFtxQE5Yic+V6wIG7/IXb5CxWgtir1NDKHP
        Jz2yKNVy6Sh36hVRokVTbcD9H9/pZRk=
X-Google-Smtp-Source: ABdhPJz3HIX0JUadlI2uh1i4Ur4DwXb+/57Hag4ucd3WEn25C38MKthXBDPJ0Yoxng/T6dCV8LLKcg==
X-Received: by 2002:a17:902:d50c:b0:15e:9455:19b2 with SMTP id b12-20020a170902d50c00b0015e945519b2mr21987445plg.140.1652217435371;
        Tue, 10 May 2022 14:17:15 -0700 (PDT)
Received: from localhost ([112.79.164.242])
        by smtp.gmail.com with ESMTPSA id b15-20020a056a0002cf00b0050dc76281c4sm2067pft.158.2022.05.10.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:17:14 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add tests for kptr_ref refcounting
Date:   Wed, 11 May 2022 02:47:27 +0530
Message-Id: <20220510211727.575686-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510211727.575686-1-memxor@gmail.com>
References: <20220510211727.575686-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5775; h=from:subject; bh=ibdNFv8R/LyxLH/8CN0QcQyhFKMejnH2v3V6RDcv7Ic=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBietZj3eIvP76MwGEcu8uF1oWGjbXe7cnPmvZsREmB 1egZEbWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnrWYwAKCRBM4MiGSL8RyrHQD/ 4tULlZu5MV8hMx6lwGHnRNXfXyCn+Ya6wgw3UiE32KSHuv5WypkSTSPHEBLiXXSAIaD7+XyH/3PCv5 fCblpfyq7gh6c5nQ8IiZJLFtjfko+Z+Grp4cwk0TNkQT6SfhnURCOPer1kfZJLxN3ggg04F4mDejDe pr0yPQVcVFqgBgbC8jG7irLRMq2arudL2AY9Bt2Obpzy2SVdevgmut8sX4podrXfbn5Eshhbvj38jb Q1QhQGo6HjqHb6svSqWotcTSaNtbmHTdtnkgE2voHjtLBpzNDPMbDRwyo6+ZoNUwgxzxzii7aUx8wo ly4i+WI7lgxDBPSmSKZTSYqN9R+GCoH9mIi5Mj/8mQwZWs/KMrDWIy2oUtblJKl/8iUlOMtvLlmPCZ 9zJj+fGMT3I0vLRldkeHGFBOzoVOnNRrIvYPqe3+QcYbpOuf4Z8YxR5uEH8/3AnYkJ0vwPaLQJWC38 eSmyhhIuIRunThLobtbdoQ1Sg9cz9SIb2xTZv/ZEADBnlXvEz91s+4OxZS5dsdDE5r8vfTfffOVevp GYBebGw0ibB9q3z/g+UKs6AsM/iU7h/G3QkgmCvbaU9CoKEfs6Fu0rTzXTWo48pOBbOjZK1VE1pm5F t05A0ZFw6+AkSvZb+O0/HJisyaZXNzzaHsSphZ1uGrmggGIyrxnx1NpgA4jw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check at runtime how various operations for kptr_ref affect its refcount
and verify against the actual count. We use the per-CPU prog_test_struct
to get an isolated object to inspect the refcount of.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  28 ++++-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 109 +++++++++++++++++-
 2 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index ffef3a319bac..bcee3e54e3ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 #include "map_kptr.skel.h"
 #include "map_kptr_fail.skel.h"
@@ -81,8 +82,14 @@ static void test_map_kptr_fail(void)
 	}
 }
 
-static void test_map_kptr_success(void)
+static void test_map_kptr_success(bool test_run)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+		.cpu = 0,
+	);
 	struct map_kptr *skel;
 	int key = 0, ret;
 	char buf[24];
@@ -91,6 +98,16 @@ static void test_map_kptr_success(void)
 	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
 		return;
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref retval");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref2), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref2 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref2 retval");
+
+	if (test_run)
+		return;
+
 	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
 	ASSERT_OK(ret, "array_map update");
 	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
@@ -116,7 +133,12 @@ static void test_map_kptr_success(void)
 
 void test_map_kptr(void)
 {
-	if (test__start_subtest("success"))
-		test_map_kptr_success();
+	if (test__start_subtest("success")) {
+		test_map_kptr_success(false);
+		/* Do test_run twice, so that we see refcount going back to 1
+		 * after we leave it in map from first iteration.
+		 */
+		test_map_kptr_success(true);
+	}
 	test_map_kptr_fail();
 }
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 1b0e0409eaa5..569d7522bb9f 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -61,6 +61,7 @@ extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp
 extern struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
 extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+extern struct prog_test_ref_kfunc prog_test_struct __ksym;
 
 static void test_kptr_unref(struct map_value *v)
 {
@@ -141,7 +142,7 @@ SEC("tc")
 int test_map_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
-	int i, key = 0;
+	int key = 0;
 
 #define TEST(map)					\
 	v = bpf_map_lookup_elem(&map, &key);		\
@@ -162,7 +163,7 @@ SEC("tc")
 int test_map_in_map_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
-	int i, key = 0;
+	int key = 0;
 	void *map;
 
 #define TEST(map_in_map)                                \
@@ -187,4 +188,108 @@ int test_map_in_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("tc")
+int test_map_kptr_ref(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *volatile p, *p_cpu;
+	unsigned long arg = 0;
+	struct map_value *v;
+	int key = 0, ret;
+
+	p_cpu = bpf_this_cpu_ptr(&prog_test_struct);
+	if (p_cpu->cnt.refs.counter != 1)
+		return 1;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 2;
+	if (p != p_cpu || p_cpu->cnt.refs.counter != 2) {
+		ret = 3;
+		goto end;
+	}
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v) {
+		ret = 4;
+		goto end;
+	}
+
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		ret = 5;
+		goto end;
+	}
+	if (p_cpu->cnt.refs.counter != 2)
+		return 6;
+
+	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
+	if (!p)
+		return 7;
+	if (p_cpu->cnt.refs.counter != 3) {
+		ret = 8;
+		goto end;
+	}
+	bpf_kfunc_call_test_release(p);
+	if (p_cpu->cnt.refs.counter != 2)
+		return 9;
+
+	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
+	if (!p)
+		return 10;
+	bpf_kfunc_call_test_release(p);
+	if (p_cpu->cnt.refs.counter != 1)
+		return 11;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 12;
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		ret = 13;
+		goto end;
+	}
+	if (p_cpu->cnt.refs.counter != 2)
+		return 14;
+	/* Leave in map */
+
+	return 0;
+end:
+	bpf_kfunc_call_test_release(p);
+	return ret;
+}
+
+SEC("tc")
+int test_map_kptr_ref2(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *volatile p, *p_cpu;
+	struct map_value *v;
+	int key = 0;
+
+	p_cpu = bpf_this_cpu_ptr(&prog_test_struct);
+	if (p_cpu->cnt.refs.counter != 2)
+		return 1;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 2;
+
+	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
+	if (!p)
+		return 3;
+	if (p != p_cpu || p_cpu->cnt.refs.counter != 2) {
+		bpf_kfunc_call_test_release(p);
+		return 4;
+	}
+
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		bpf_kfunc_call_test_release(p);
+		return 5;
+	}
+	if (p_cpu->cnt.refs.counter != 2)
+		return 6;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.35.1

