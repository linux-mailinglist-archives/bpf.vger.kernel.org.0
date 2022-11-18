Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6362EB78
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiKRB5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKRB5i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:38 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E47742F4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:37 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p12so3318077plq.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD5HfupGDvvHcy2CGNIioN851TZ+7EyEsiwJTVPvchI=;
        b=RybPgd67KVrBDBLnqi9V6vcKypmLrogLhhm723nLX+aJ7VfmNfbFgWbtYgtkwVUSXu
         +tiThN8wihZGRpU68ksdqcAG1FNoNjK80DXakV3SAhbFn4D3bcjigCvfaoc0X7o3NV3A
         8s9WkYkBdxZZYrE5uNzuPGUCZsi8EBXFHpwAg3QXuvsoSqRG1YD5pYn/k2m+z7Clocrb
         /x3natd4LvH4H8UyEubYFme4HUCS/jDxS2fC+dC0WQR6fGdtGVxWvKQF2PY7iQsA8W+w
         grnXwRZtr50b12fKQiQZPRPfb+jj7zUkyN/cXLOr40KRxjQpl788YUQ+KfWeA7BtXHg/
         h3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD5HfupGDvvHcy2CGNIioN851TZ+7EyEsiwJTVPvchI=;
        b=PSQ5O7HFNZg3ITowiFmKeGocnxqgFqYElxTwf++pOc7CvOpqHs8nypqn7njC9QxOja
         IQ+veO49nam39LuxU+o7XUy1+EI3tZLO/EnD7RkKbQ/EsQEDkbijPepW6qbQthbvFfTH
         GgEYb7DDKlE6/JxbSK/g7lb3r60FwUAjh32POutDTL9+ZICd+8KUjaGOTW9YxI2J0Pt/
         /dLTjvpEQvZfldJUAUvrTYf4ffHqLLeUDOtVoLDznNu0DfrOWG0i0gmrDJnbnub2sSwn
         dXy3rTpYVWWx8PzApLWP6W27H7g7mpbvovkXefo0h2pWdG44j6ZFnuXjNcavxTU+OUHe
         xraQ==
X-Gm-Message-State: ANoB5pneQxDkDMYPqGmnINOSnS7NC1uTYcetsXRevF5DPXFiQcckvbd8
        k7qer5U+iH6o0C+3ZA9l9ZywkOKkHXM=
X-Google-Smtp-Source: AA0mqf7XceSwrQ7IMlCpSjq2wjzS+otYPafN24UhLcErJhSnuw5ekTw5QrMCxoln17eYzK0pyokuEA==
X-Received: by 2002:a17:90a:7885:b0:20a:d81d:a8 with SMTP id x5-20020a17090a788500b0020ad81d00a8mr11273295pjk.177.1668736656968;
        Thu, 17 Nov 2022 17:57:36 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id r12-20020a63e50c000000b00476dc914262sm1743483pgh.1.2022.11.17.17.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:36 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 23/24] selftests/bpf: Add BTF sanity tests
Date:   Fri, 18 Nov 2022 07:26:13 +0530
Message-Id: <20221118015614.2013203-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17214; i=memxor@gmail.com; h=from:subject; bh=WKPqskdk/GQhBlmMbwrROr06Qo+X8CVlQtqqvM0/fQQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXP182g5Eov19z7xE+g+VfMgcaSpQ51Hz0PYxkC /X/2XleJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RynfLD/ 96tIMhPvKHeFAzCW8w9Ejn9HPLsvavB0K/CN4G6IyeRbwr+O2nuOuOCe7MPytpUkg06TFvNaXFh6zu rii9DeC9kJB4RNK5G6v+ZL/cz/ch2LFMYHGK9ktZlSMGh/76MBkIwG2Spd2/8iaWUJK2jqCoH70KJz WJj9QP2UslhFJ06bLnnAw3XORPBbmqfOOjGREuAPuFRXLkizw4QTRC1HowrwAcJw7JyNT2BOqKjrBi Bq9iB1VTeAok4QMBSyHcqhl0mb1V1qh4Sw0co26XvmYV9GwE1EEFp2FpWuV2qjwhXY9hsT6C755Cbq YjycHWm2tFRLjN7MkpRr2OXVPbS4g1tFOUSCai2DnEaCakL1LVEbmU2dRJrKV5z729FwQGLj/ku9LJ kiPxJhNWMCundMbd/50HSW6WDiWlI+1xDDckWaqTtQji14LWNISo4DW5l2OYyYA5nB3pZP6xxYe46D hyXCamND4y0OxkpeK8+YZyATc2y0iCpKaJiWJnOgxc+4uR+aWEP7aYqz6FeQxIewQBTsstINzuBypd d40P3tgfhbWPV/l7MQH/Y7KMJqhb2H48D7zsHzy+LfrHCdz9p+O6TYB4ge2IrSfbpCqoNY0phiv0kC iqEZazUmnOmMYgIh7dE+95rwMRGePc6726ikFeFG2QSONZUea+3xk1xTHRSg==
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
index 41e588807321..dd73d0a62c6e 100644
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

