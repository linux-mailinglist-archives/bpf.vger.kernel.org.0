Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B905D523DCF
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbiEKTqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347118AbiEKTqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:46:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740D2B243
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so2988444pjm.1
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A754DcZXU8OYbwE/Gdfl5NoK0LK3lXQ2H1gJmzXPgK0=;
        b=pMe/jnUMm1s693/SeKKK8lckMfhNkSPfwEEr3NUu9WhRg2tkW2defJ3YsdFjnzAuvG
         dXZDJr1aBVhrgcqs1M48oB/kgHjlybKQavZI75HenyR/JyQQR1nw2Dl1MdqoWzXph00R
         agYEZXLRTDyGHV8043w3K3+IjEa7LLBmlOU0V8ljSiEg8AbeGdmcj+Mt4CAPkcq0X8b5
         Wo1N3Q24ORtuOzN5FqhiiI/LC50mWmXx6YAFVf95hXLL5cjIFEk9W5QRMQuOsPgQTZw9
         9okC7VAuBjO0hgAZHVwXVg+kIa7+PbA5UPyl2R9sU+/Nm0E9LcCf1mqfN0c3ShuQcCE8
         MLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A754DcZXU8OYbwE/Gdfl5NoK0LK3lXQ2H1gJmzXPgK0=;
        b=zP79XPJpOhZWqw0cYvgGD4WLeGKZ9fGr4a5ThR7u+l0f5/6Onzgm0Lt5woHzxT/f68
         bNm3Vwl5hWortV8cStBNFMdIq+mockNkhHZ+AZWojt3D8yNH5zIfDMAyguJ/NUrNYsqr
         5tPwGLwRls0W7y3snb9yiTBlHRHnHExYrgXWdSIL49/nA+w9p7W2zRlfmXXHI5K7FrPl
         Gl/fFxxYK1AtCvXRSuD7wEBac8jaPbe3nYak1/D9xFmRVZ5J8wCGH6xkp20lPNfKImwj
         t1bTtJvM60X2FTPTow3R9feGuQsQ5Rzp7zAgsr4rm+xYMuQbx60bqpaqnUj/ZxrSQZgC
         lf8A==
X-Gm-Message-State: AOAM533Yrn9jUB+jq+G2T0fEFeB0v2kKqISUjwTkek5IQ7D/n+7PfVGt
        A1/tYB/2U7e43Rf4fGMxXRfZHjumV5I=
X-Google-Smtp-Source: ABdhPJyEUkIUe1nmsVWAIxaMdl0pChWPVeSnhjEMOVvPCHjvGxBvg6sWBepK3MNdGMozGv6zhNOPcA==
X-Received: by 2002:a17:90b:4b01:b0:1dc:6fee:508a with SMTP id lx1-20020a17090b4b0100b001dc6fee508amr7095641pjb.127.1652298399006;
        Wed, 11 May 2022 12:46:39 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0015e8d4eb2c7sm2269146ple.273.2022.05.11.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:46:38 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for kptr_ref refcounting
Date:   Thu, 12 May 2022 01:16:54 +0530
Message-Id: <20220511194654.765705-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511194654.765705-1-memxor@gmail.com>
References: <20220511194654.765705-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5092; h=from:subject; bh=/8ERg4Ebc8W3D3klet1218bcwD0vXrbR8j9kI67AGfM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBifBG7XIzf0+og0d1gM82+WZY+PZhOMX1c4IcolKcC Y79WAWyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnwRuwAKCRBM4MiGSL8RykkLEA CnCJX27Tt+UO3TZdQ33MtvVyhC4hxcIfQ0dn3/B5bFCctTvuc8Yves62tqR8jVWJXpp61iGt77KRTF 7cy6YabVnkE/jd/C5ivauBy8cZMhibnm/Z+u4jikSOF5wSOTZk5Fwjk6+hYRSqFjfaDfq6UYCxWPmo KZZrg9l+AqOCshrsJYLEr+D7Knw97N26m0KAJTRadbgtJk5a0b0d1wxaU6PRl5KWxjVV6aduCuGnQ+ ca6Jc65CSB0NLt6jGT109aODdlrVcJGlAsWN3Nznw0ol9TfkPNb1Y4UL8+bx8NxWUTb8GZfWMTTqSh WVOyPVZ+4qRXTlJLrLbyDYwzNFJK0R9gjhVqFwhEA+tlSd6Uoyn2BFJE4b98OzOwsSgIYJX55539YW orfDJNLBlQ7K1HYW9CWLr9uHmJFrxLus9hXjHrxvIZV1ybvhHxzbwdGZGhBYHWoO1PvvWZmhOIW3Or C+3wvP8hmTGOZxhxkMU4wna1Pu753yzsy/TcaLIPCUdU82KoQB8eu9dXZIa1gY2rFf39lsIq7FAc53 LsOkkVsOnaVnEcyW0LKiur6TCwqnACwVFyw23x1hHHZwvIWJXHs2qwgSGiVHom+QNnMpv/0TwiFR6D JD+qhKxga9UtlGd0+DMiUbgpcacQl4qmclp+FmXF+QBOCFEQDrvB3MW5y0rg==
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
and verify against the actual count.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  27 ++++-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 106 +++++++++++++++++-
 2 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 00819277cb17..8142dd9eff4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 #include "map_kptr.skel.h"
 #include "map_kptr_fail.skel.h"
@@ -81,8 +82,13 @@ static void test_map_kptr_fail(void)
 	}
 }
 
-static void test_map_kptr_success(void)
+static void test_map_kptr_success(bool test_run)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
 	struct map_kptr *skel;
 	int key = 0, ret;
 	char buf[24];
@@ -91,6 +97,16 @@ static void test_map_kptr_success(void)
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
@@ -116,7 +132,12 @@ static void test_map_kptr_success(void)
 
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
index 1b0e0409eaa5..eb8217803493 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -141,7 +141,7 @@ SEC("tc")
 int test_map_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
-	int i, key = 0;
+	int key = 0;
 
 #define TEST(map)					\
 	v = bpf_map_lookup_elem(&map, &key);		\
@@ -162,7 +162,7 @@ SEC("tc")
 int test_map_in_map_kptr(struct __sk_buff *ctx)
 {
 	struct map_value *v;
-	int i, key = 0;
+	int key = 0;
 	void *map;
 
 #define TEST(map_in_map)                                \
@@ -187,4 +187,106 @@ int test_map_in_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("tc")
+int test_map_kptr_ref(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p, *p_st;
+	unsigned long arg = 0;
+	struct map_value *v;
+	int key = 0, ret;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 1;
+
+	p_st = p->next;
+	if (p_st->cnt.refs.counter != 2) {
+		ret = 2;
+		goto end;
+	}
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v) {
+		ret = 3;
+		goto end;
+	}
+
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		ret = 4;
+		goto end;
+	}
+	if (p_st->cnt.refs.counter != 2)
+		return 5;
+
+	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
+	if (!p)
+		return 6;
+	if (p_st->cnt.refs.counter != 3) {
+		ret = 7;
+		goto end;
+	}
+	bpf_kfunc_call_test_release(p);
+	if (p_st->cnt.refs.counter != 2)
+		return 8;
+
+	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
+	if (!p)
+		return 9;
+	bpf_kfunc_call_test_release(p);
+	if (p_st->cnt.refs.counter != 1)
+		return 10;
+
+	p = bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 11;
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		ret = 12;
+		goto end;
+	}
+	if (p_st->cnt.refs.counter != 2)
+		return 13;
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
+	struct prog_test_ref_kfunc *p, *p_st;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&array_map, &key);
+	if (!v)
+		return 1;
+
+	p_st = v->ref_ptr;
+	if (!p_st || p_st->cnt.refs.counter != 2)
+		return 2;
+
+	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
+	if (!p)
+		return 3;
+	if (p_st->cnt.refs.counter != 2) {
+		bpf_kfunc_call_test_release(p);
+		return 4;
+	}
+
+	p = bpf_kptr_xchg(&v->ref_ptr, p);
+	if (p) {
+		bpf_kfunc_call_test_release(p);
+		return 5;
+	}
+	if (p_st->cnt.refs.counter != 2)
+		return 6;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.35.1

