Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1158562E1BB
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiKQQ1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiKQQ0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:40 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787417C47B
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:26:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id k15so2271461pfg.2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwhI9UjMlgnSaJ4yIwRB3YYhVYaUoO/AJsMpZl09zdI=;
        b=JpK99aNQvbuJ5jirnR/eFPIYRPMeclp2acqrshsy1547C7uZgEKgQEn1+uICVdjZVd
         2QoIUwbJq2VZIOm7VrkXv+Kvqv4XwYx/b6TbHmakYvEgfnS8K4ti8BGung2PMB3QuvJD
         Gx4/K+E/drf7eIBCs2MxhXPS8+U0eKncZzAWkHDJA3bD3qlb20G0stWzhPPJlBOwovmT
         +UIyPAEJwWbf4+6JYSDjEinQurZIW56gUrjH9G0cq2t30WFGJFzmbb35T+vf8RH634cA
         XQHxctl0I2iPDGaV8bZiJZ8lR/1db3ujBXNV0yXZKQ/NMOJMhKbUrdINDqp06wtUqnoe
         Q3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwhI9UjMlgnSaJ4yIwRB3YYhVYaUoO/AJsMpZl09zdI=;
        b=PbS7hb/HDTNZeaEx5k9tzdDmibJz3p9tEjn3P7te69EGbCidPgbcFfkI10Jukz95Lp
         kq+8aJ2iFzyybIqBmN+ako0D29cx3ZlP84h3Yga+Ov4tJdOjkKONbX6h6u1MVj5ZTGAJ
         bcsMwzhy1MZ6DPYnP42YemG3KjFSf+5V/Rn2cEiZn+AECH7Kh1NBe/j1qMQ8lzae2Pjn
         3c+MpAsBXliHOj+OTQvh0iGjQiXvNUGJH1srHOaSCWcpqda5i1lUVzI99BnPTD2frIfY
         4axGhGIzdf++ixNXdaROBdpoAS5jjzTP/9j/DZO7FLLv30M0LtfBRbsU/YmGivml+4yf
         wAFQ==
X-Gm-Message-State: ANoB5pl9an6biJ0GgWXYsN0hqjg4AceTGPAEsYHx14VnTLbZCRlCFRAd
        UsoUSzgPAMWrdAKJdxa4YGZv3jO8Q4I=
X-Google-Smtp-Source: AA0mqf4i3OqB5unNqofB00QbAir2M4lIxp7ZAbY6tGl0kgq38va06ZpcjH/r+ZdcJ75cgbe2078Ebg==
X-Received: by 2002:a63:5a10:0:b0:476:c39b:bd67 with SMTP id o16-20020a635a10000000b00476c39bbd67mr2732902pgb.46.1668702369650;
        Thu, 17 Nov 2022 08:26:09 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b00188c5f0f9e9sm1543433plb.199.2022.11.17.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:26:09 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 22/22] selftests/bpf: Add BTF sanity tests
Date:   Thu, 17 Nov 2022 21:54:30 +0530
Message-Id: <20221117162430.1213770-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17214; i=memxor@gmail.com; h=from:subject; bh=m6mr5NFhPzJ/0Ot1CEDqx+U9ru5SwrUF5yhiRrCE9Tw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl8Br+BrcJbYD7UsjfSKLUkfQgC6fToUU+lmHaWE YhF9B8qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3ZfAQAKCRBM4MiGSL8RyrJ1D/ 0b68ItSJeCHiX8sKCuzWDIeBkmd/wmFVcCkBptavqHpnU+XIAj+cVgqQopDJPadkZU8+BG2cVNiNEf jsTh1no+bGkwW7/VXpteHuW9R0tCrGc2Q1IcyMRSzhhr2gwYkWb/vzE15qgZV+/Po16GBPIzaR03XJ MjmYVtl1x1AjiWGKtVPUruxfFN4qnD4mARA/f94JAuTqLPCddD6PXnCGzq6f7zrmhNQ0fdzRVl3eK6 o0Bn//K8REUDrVKRuqiQAt4neBAspL0HAJndj7+83CgQ70fQZGu+5dHbO3GjsQXycB7qS6S3LaFaVQ ME45i5H/DwmyEpw8NZuU/WjLLCxSQ960VPgBuG1cvSZAmciWEGC/Q4+WKhiaun5bHxl2R0cIzRhp9h OrtH43PC4q85TlMokIdlpUsrCvLtj/ZbmrohjMup0Rx/s9sLduI1/YrPDV+1aj1h6Cr3ebAdDeTXTP KqdsBu26oeLAT+QDCmx96BVQx75fGheEkT4WDQ408RYIIJeP4HPZVQgi+8IVspN6xsVXxLS3EWakvL zEct00l5A/szeGuvraNsJK2dfud7uuN6LkHaU+8JXANvqsvsvB/H9sgOke4cURV019kRfjRhEQTmoc rSu5A6K/LUC0Oqw5xT5DWealYyE2oo6e9g9vcPuoKXm8injR8Dd2CVRccrLA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preparing the metadata for bpf_list_head involves a complicated parsing
step and type resolution for the contained value. Ensure that corner
cases are tested against and invalid specifications in source are duly
rejected. Also include tests for incorrect ownership relationships in
the BTF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    | 485 ++++++++++++++++++
 1 file changed, 485 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 32ff1684a7d3..70241be92714 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <bpf/btf.h>
+#include <test_btf.h>
+#include <linux/btf.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 
@@ -235,6 +238,487 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	linked_list__destroy(skel);
 }
 
+#define SPIN_LOCK 2
+#define LIST_HEAD 3
+#define LIST_NODE 4
+
+static struct btf *init_btf(void)
+{
+	int id, lid, hid, nid;
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return NULL;
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_EQ(id, 1, "btf__add_int"))
+		goto end;
+	lid = btf__add_struct(btf, "bpf_spin_lock", 4);
+	if (!ASSERT_EQ(lid, SPIN_LOCK, "btf__add_struct bpf_spin_lock"))
+		goto end;
+	hid = btf__add_struct(btf, "bpf_list_head", 16);
+	if (!ASSERT_EQ(hid, LIST_HEAD, "btf__add_struct bpf_list_head"))
+		goto end;
+	nid = btf__add_struct(btf, "bpf_list_node", 16);
+	if (!ASSERT_EQ(nid, LIST_NODE, "btf__add_struct bpf_list_node"))
+		goto end;
+	return btf;
+end:
+	btf__free(btf);
+	return NULL;
+}
+
+static void test_btf(void)
+{
+	struct btf *btf = NULL;
+	int id, err;
+
+	while (test__start_subtest("btf: too many locks")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 24);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_struct foo::a"))
+			break;
+		err = btf__add_field(btf, "b", SPIN_LOCK, 32, 0);
+		if (!ASSERT_OK(err, "btf__add_struct foo::a"))
+			break;
+		err = btf__add_field(btf, "c", LIST_HEAD, 64, 0);
+		if (!ASSERT_OK(err, "btf__add_struct foo::a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -E2BIG, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: missing lock")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 16);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_struct foo::a"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:baz:a", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:baz:a"))
+			break;
+		id = btf__add_struct(btf, "baz", 16);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct baz"))
+			break;
+		err = btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field baz::a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EINVAL, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: bad offset")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 36);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:foo:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:foo:b"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EEXIST, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: missing contains:")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 24);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_HEAD, 64, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EINVAL, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: missing struct")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 24);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_HEAD, 64, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:bar", 5, 1);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:bar"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -ENOENT, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: missing node")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 24);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_HEAD, 64, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:foo:c", 5, 1);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:foo:c"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		btf__free(btf);
+		ASSERT_EQ(err, -ENOENT, "check btf");
+		break;
+	}
+
+	while (test__start_subtest("btf: node incorrect type")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 20);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:a", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:a"))
+			break;
+		id = btf__add_struct(btf, "bar", 4);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", SPIN_LOCK, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EINVAL, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: multiple bpf_list_node with name b")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 52);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::c"))
+			break;
+		err = btf__add_field(btf, "d", SPIN_LOCK, 384, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::d"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:foo:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:foo:b"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -EINVAL, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning | owned AA cycle")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 36);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:foo:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:foo:b"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -ELOOP, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning | owned ABA cycle")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 36);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
+			break;
+		id = btf__add_struct(btf, "bar", 36);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:foo:b", 7, 0);
+		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:foo:b"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -ELOOP, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning -> owned")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 20);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:a", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:a"))
+			break;
+		id = btf__add_struct(btf, "bar", 16);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, 0, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning -> owning | owned -> owned")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 20);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
+			break;
+		id = btf__add_struct(btf, "bar", 36);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:baz:a", 7, 0);
+		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:baz:a"))
+			break;
+		id = btf__add_struct(btf, "baz", 16);
+		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
+			break;
+		err = btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field baz:a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, 0, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning | owned -> owning | owned -> owned")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 36);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
+			break;
+		id = btf__add_struct(btf, "bar", 36);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar:a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar:b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar:c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:baz:a", 7, 0);
+		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:baz:a"))
+			break;
+		id = btf__add_struct(btf, "baz", 16);
+		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
+			break;
+		err = btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field baz:a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -ELOOP, "check btf");
+		btf__free(btf);
+		break;
+	}
+
+	while (test__start_subtest("btf: owning -> owning | owned -> owning | owned -> owned")) {
+		btf = init_btf();
+		if (!ASSERT_OK_PTR(btf, "init_btf"))
+			break;
+		id = btf__add_struct(btf, "foo", 20);
+		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::a"))
+			break;
+		err = btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field foo::b"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
+		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
+			break;
+		id = btf__add_struct(btf, "bar", 36);
+		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:baz:b", 7, 0);
+		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag"))
+			break;
+		id = btf__add_struct(btf, "baz", 36);
+		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
+			break;
+		err = btf__add_field(btf, "a", LIST_HEAD, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::a"))
+			break;
+		err = btf__add_field(btf, "b", LIST_NODE, 128, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::b"))
+			break;
+		err = btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		if (!ASSERT_OK(err, "btf__add_field bar::c"))
+			break;
+		id = btf__add_decl_tag(btf, "contains:bam:a", 9, 0);
+		if (!ASSERT_EQ(id, 10, "btf__add_decl_tag contains:bam:a"))
+			break;
+		id = btf__add_struct(btf, "bam", 16);
+		if (!ASSERT_EQ(id, 11, "btf__add_struct bam"))
+			break;
+		err = btf__add_field(btf, "a", LIST_NODE, 0, 0);
+		if (!ASSERT_OK(err, "btf__add_field bam::a"))
+			break;
+
+		err = btf__load_into_kernel(btf);
+		ASSERT_EQ(err, -ELOOP, "check btf");
+		btf__free(btf);
+		break;
+	}
+}
+
 void test_linked_list(void)
 {
 	int i;
@@ -245,6 +729,7 @@ void test_linked_list(void)
 		test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
 					   linked_list_fail_tests[i].err_msg);
 	}
+	test_btf();
 	test_linked_list_success(PUSH_POP, false);
 	test_linked_list_success(PUSH_POP, true);
 	test_linked_list_success(PUSH_POP_MULT, false);
-- 
2.38.1

