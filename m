Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C843D626211
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiKKTeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiKKTep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:45 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753079D21
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:43 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q71so5124644pgq.8
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikZwvFVx43nJH39b53Lifsz5EBKM+wB7iSYfgKZ+Cw0=;
        b=CtWPSgnFu0fcJi1zMBYcdFqcRN0qTbgR0r37AVQq47lthBbK0z4HDkVGwDiyqXFk4s
         Xzpi+dXKz8LJsALYYZuVnrVqBch4l+c0Y8S7XhGaZcADLBhZCDkyvxSKrOubqg96Ws9i
         vpHAP+iNraNu+cuWBvKsKykyTAKp42+Pq1DR04MOw+ltlWjpLjLQBQkqeKbA8dQiyZ5K
         WURimCLVNR4S7gTiS1eCpTSFsbzThu1AuKFBPSpPiJIP2IOel7sBSBYw4u8ywHweYVCj
         oGCvgW2oZ9QsIgT9M8E+VHTKyljFKI9l5oLH3+FTrQ1pRYaMX/jqYA/qARF+JKs+BRx6
         my8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikZwvFVx43nJH39b53Lifsz5EBKM+wB7iSYfgKZ+Cw0=;
        b=BwINidYnip+zn+DL/guyosnImxG95y0nx+gzCTgCFG5R3GkvYWAP5UpVSV3p5j97OR
         LOXc4UkkKIh9KcEL12K34pKJ2bOlebuDuFaDcMP68RQkvFEF06Xl0Vc1OSvuh9HlTaud
         GRg+3/9hL8iCJcPjiQkT/m54TizpsuJzqAOxKMtAJ+CNgjSnwNrpWZ0+nSpJD/7KxpKv
         R2K+VrSELTbM7TbKjLoTMeaqoOTRsMjwuXL80yy5fmyr4PG90SojanKPW54Wm6yNXh9b
         mKVo9X16+x067cCvIKrf/7HWZyYO6KO9Gi4lPXIyfgnsuxsD50SFzGULlunbga563cao
         ovAg==
X-Gm-Message-State: ANoB5pkUYOoL/uTEoY6Ljz86IlPXJ1GsgA8GtJV9HQB03mq8tqM8sw2O
        EjrOhzDuzEgkQswDBGDbNChrO5tM0xaStw==
X-Google-Smtp-Source: AA0mqf43Yl2gcde3XHGHed7LGnACoziIcQJf7cU3snz53p+RMHeznkeyPPYUj+DDJtF4yhc/wwpBFg==
X-Received: by 2002:a63:d642:0:b0:46f:d2d4:bac4 with SMTP id d2-20020a63d642000000b0046fd2d4bac4mr2888369pgj.178.1668195283156;
        Fri, 11 Nov 2022 11:34:43 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b00212d9a06edcsm5213024pjb.42.2022.11.11.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 26/26] selftests/bpf: Add BTF sanity tests
Date:   Sat, 12 Nov 2022 01:02:24 +0530
Message-Id: <20221111193224.876706-27-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17214; i=memxor@gmail.com; h=from:subject; bh=v1LI+fTgGiLUO8irIiQN9nGTkKTb9ImcS7iWlL1GYas=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIpCJRIpIn4JAqKr4qE23QDsjdcoPPPSP3mg+KN HkCcjVGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKQAKCRBM4MiGSL8Ryqq0D/ 435TAP3YiWBnh35HVPeXIygx3L7/qwrv0A+BZIrUC0KuBfKY+S1Hfnnk13jrvxb9+JzboiTBLkEhk6 bG4GM7C4Ui5F8N/VbELdJ60Qyb+5JGilopKqNSOglt/AeycpaG7ZUnzleDCQ0FJWmdLsezbfzM4yE0 GKg/6PHgxLhZwT3DjxR8GE1jgxsZ6/0NBXoBu3+8jbQOGju5axg8sv+UmhUmLbBMPBOhsEkZtJAF9A IN8c0mgKcNA0FRFRMoBpHSUp4WeKLaBNewTocNHRDcEaZ1GVI5XV3yOLyA95Hyk3QE+DKlbHwDt04M r05flQQ50P/fM7Vr4oeZgKimvpJUFeK5U22IKlXNt+KRIyUj87pxAAN8cTV/zQHq0vz2kvC/ZngbMi KHT2WBMyGjTt1XQxvlUqOHs+9THYEF9h8IWQqxFjaiQQmLn2eN+FkjNYaaVBcm6I8Lkl6Tf6qpM7Wk nAF8SonoBiydS/Nt6Jrmi7QLC9WW6OJdvQzSGj6Ou/jkXEvpiTUH/x/UVExo4fU+RG0M2rfFu2yloP CQvuSwzdjgDuFi5v7knGfuhvvhCStzDT6/yP7StlUGaaEhnZb4i46R22Mjvfx6lxkIjUijOAih7kMv Ov96ZCiPjq0LuPxMUpSlQ4NgZd63b4ZjTezSxvlHYioK5JnqbZL3L+8KKafA==
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
index e8569db2f3bc..bdc5a4f82e79 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <bpf/btf.h>
+#include <test_btf.h>
+#include <linux/btf.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 
@@ -233,6 +236,487 @@ static void test_linked_list_success(int mode, bool leave_in_map)
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
@@ -243,6 +727,7 @@ void test_linked_list(void)
 		test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
 					   linked_list_fail_tests[i].err_msg);
 	}
+	test_btf();
 	test_linked_list_success(PUSH_POP, false);
 	test_linked_list_success(PUSH_POP, true);
 	test_linked_list_success(PUSH_POP_MULT, false);
-- 
2.38.1

