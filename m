Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB651628926
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiKNTRY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNTRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:17:11 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB82654F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:17:10 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso14764979pjc.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikZwvFVx43nJH39b53Lifsz5EBKM+wB7iSYfgKZ+Cw0=;
        b=JDvyCBGFS7FQdipJCzkdxh3jwb1NwCtL58SeBmBbC9PLNJ4bmwiKTO3GTPwcv1+94R
         WjityXnxysfMjk8bm3xEb7d2aEn4anDi3GJvoBv75aigFwIfPjWgRwCMAZO/eQJxnZDR
         8m9S2k9Lcz7Vnv85VcMMvKGg03AGU7IZtkhntDG7iEMB5gbRmtO4V3yOcyKXFlBA2lJt
         Ld15uf4sk/Y/jyREBbp5sCIC5Y+J/W//cLyvOSph77oZKhiTyRJ1mC1y9zy5rAogfmFi
         l2fQfQikaK2qLV8zsKkLckIWIbJSNOPDXuPcSkPAafbtXxN9g4A4czNVsPqpzZMaSk0c
         r9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikZwvFVx43nJH39b53Lifsz5EBKM+wB7iSYfgKZ+Cw0=;
        b=WK7+N32b6Uf5yBJiO65C9yhpObj+UigZ2GooysQK+vlr9nDwi1qwlcR/XHtu+TgfaT
         uxpVzsA2PG8daJvXJ59f1pJACKNYD7qZhFkzlmHk9L+g8mKqpNJaxfVJIhklQ++Od2Ec
         6uXjTGPYerupCTjRum50Pl6RIqQ5LFc8MnKuu0r6FdnwZG56bXo6dwCFyfIAHIPZfxo2
         EKFVTm6Bkx7tVbL31vzs/1Ja7f0kADVDv6VHvRtnjNuG4th3y7AIUKsuY6zwRVWOmHRb
         nhuB9uveoHbnRLp9yhc2G1OKVzS5ykasOoT2UAgev61orkLI2qbOV0yxRLL/AmxPobSw
         KsAg==
X-Gm-Message-State: ANoB5pkK0L1t+d5pcePeBvUCFguTI4oD/FWqqyosATtMciZ50Eo/G0kC
        /8yDTahrdUPRY1T0NVAU3ZSWp6gyTsWSRw==
X-Google-Smtp-Source: AA0mqf7QkxMpU2C5MEspUcz2ItbKThJNNKpyNDMvfwqDDNPm2C8CnRHnGA4Fqh0qykBCEmp+j2PW3A==
X-Received: by 2002:a17:902:b183:b0:186:d5b9:fbcd with SMTP id s3-20020a170902b18300b00186d5b9fbcdmr690778plr.64.1668453429760;
        Mon, 14 Nov 2022 11:17:09 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00172cb8b97a8sm7998615plh.5.2022.11.14.11.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:17:09 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 26/26] selftests/bpf: Add BTF sanity tests
Date:   Tue, 15 Nov 2022 00:45:47 +0530
Message-Id: <20221114191547.1694267-27-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17214; i=memxor@gmail.com; h=from:subject; bh=v1LI+fTgGiLUO8irIiQN9nGTkKTb9ImcS7iWlL1GYas=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPKCJRIpIn4JAqKr4qE23QDsjdcoPPPSP3mg+KN HkCcjVGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTygAKCRBM4MiGSL8Rym8eEA DDWwcSUIO07IO/hreP3tMGGpsma1v44kAANn4fm9KMeNH/+kdVtboyQG/GwkFiRolQwcM+VQ3iUe5v qrGKt1m4spoeG9n+n7Q7gLMcSOub3CI/H5twrgI+EMljl5I10eLfh6fddcQafFixwI2zeBQJ3cDYS3 A5Sldeghaxpbsf5mqs/hO3lk+Mg7pgpZ21rM3jRbt00R8QZ/5oG9n52OyyTq+KZlxRQgq7MnPSyQ8f TgdFBIEO457cMurwFppOZeDt4iJy5L1Agv6wQaDN9uxCzugiDeI3dU+nH7S5WJIA+QjgeErUmtqlgH c9izRhr+7iH65RP0xPz+ENq8Hk5z1Atpal0jymTknMuzf9EE/yHDHsroGdGlmZKflu1AmsakGbl56A RX0HRvQ9tcAc8N3SZjEIOPhO1c3fNmBzOmpJDDTRkdt6oU6sscnVmdRsKNQtP15wDxWIdz/jEnSqqh IjAc+IaFKuitsUXf17UD9GsbBu8ZTcw20xhNDpqgZT43Bkj9PWCOpd5hTpmAsJ/eQ8SRauLfMFGyjC h073eZHTm9cgTFZpWLcePnXpZISp2XvP8lMfhuDhNR2cLiB2xvtxTSP0JiZeqVkRs106eg4GbfcWZR sUaoQa5ye1eRlUcDJfTx328EtSuzI0rGi/sTL9ZLxJvv3s6iwi7zUSrCSPPg==
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

