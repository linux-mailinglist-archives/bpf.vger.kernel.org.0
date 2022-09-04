Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B75AC681
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiIDUma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIDUmY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373212CDD8
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s11so8995991edd.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Rll5Y/SH2+xolqDbXnPylpG7Mz5O0uAf2HSd4SUGyFE=;
        b=Fo/xxab9J9N/iweuIXykuaTyTXbjTMMnlGTImN+U6lcvRxZUXUXR17qa+EpF83Dlba
         jqCAe98nsSOA2v6hRoOTY2jmLLawVC2VfkxclsoR3UaI99pgkRNPTZsIslf/dp67CVKE
         lCArW/tEZu5d/UanZ5yJ64lhKjHSULlTqaxDJUVp8tVzGjXbY648vbL3nSk9Z58weBwe
         NJvLOTAX2eb7yu2mW4c1mZhQfu31PFQHQMpKtMWY5eraAsc0iLSnc7g6t02bE0HJFVeR
         HDpaSWnJ45XK6HJp436PA5Cm+bICXr+yatUYBaQ3bBiFwv+ZTFlI4vNgW83sfGXQZsxX
         yRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Rll5Y/SH2+xolqDbXnPylpG7Mz5O0uAf2HSd4SUGyFE=;
        b=yu0ZAOM2wqjjtzcupnM+hIENgaYpnc7ZjnMEy10aHZJtmcbVw9ZjtgDx8aVI7/amY/
         pkrVG3rqDf8yA4Ah+IIq0l3Lt44J5UxW1YyaVnYRPcA1zR0kv47bf0wIuuhJt3JEFIX+
         ukGyX/7L4qHZDSN8XqwVuFP7fYeMXij1aNQ89IS6xeFIs5f2ALdXIgIU6ekrbxgrFHrZ
         osXAt/mMljESMC0YnOCXgQ6HvLLRynErOQPIe5f0rpTmCL646qIC7bGLjnuq2HA3ZQH/
         xsW9+jJvd7auGk+D5vDRAWWKbO5d/rnBScnWXpesIUtam6+Xpr9yIeZbyIpLcK85W8W2
         c5rw==
X-Gm-Message-State: ACgBeo0KiOOkorhKIr299l8Qqi6NRAKd0JVqq+Ox/EwOnLoGAEYrNihd
        2Cq/Y1igkAbDscFI3k6S9ptP31jMgcJsHg==
X-Google-Smtp-Source: AA6agR56K9vdQRPmMh2R3ilZW0FdJGjEVFTEIGsXi+cTqdgphUpk87erHcxI5wJ0+zp4QzMGrHh4QA==
X-Received: by 2002:a05:6402:f21:b0:446:19c5:59ea with SMTP id i33-20020a0564020f2100b0044619c559eamr41573320eda.371.1662324142607;
        Sun, 04 Sep 2022 13:42:22 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id ch29-20020a0564021bdd00b0044657ecfbb5sm5282614edb.13.2022.09.04.13.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:22 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 32/32] selftests/bpf: Add referenced local kptr tests
Date:   Sun,  4 Sep 2022 22:41:45 +0200
Message-Id: <20220904204145.3089-33-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=memxor@gmail.com; h=from:subject; bh=4NmgtZzdhfQr8lQeL+WliqY9f63S6v5Gw1dtTf4qzFk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1yMrnbUnbNdDqiL2tbCkFAItvxSUWhHxEa7pc0 253qxeuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcgAKCRBM4MiGSL8RyllbEA CA9XOrLjww3qcEkZ5dwIGMVTlDowXFMtKLbSutsch38rlxmABOkPS0TEyyqguCIpRxt72glZla1xGP fopEe9TpvpTReEDBcJPNhfs8q0EiXgxgI7ep+0UjldS+myLgAUCdVu2Cp6S4ihTHy16kXjPowhtG9g mQwMihW3YtUNPeg6NHLDRsxiRkbGXCclVNx5jq9eXbVfzUauV6z2/AaqnPBeA2incuGa8BQFHP/L4J A+YiCUybgPt7tFlM2y7FR/yLj4svUVOYXkpH3dUMcxMpqqnTdFdv+ad2/TwuQ6M6KhaTjv2j/Z7JnQ ojINzwjrn21Vgqck3f4Qx7MpZcoM9VIT62im5WrdMbL2f3CN498nPxg/TTaaq+QcwPLdZap/Se1QMH zOKBY+Pt7KOsH9R6frfv6K7rc2gvdD/j8mAoVMLHW6VgkRXQenG8DPmiycd0bfM2k4QwXqVG9lmIlX tg4ditvLpD4Lhrp1ZMHabZDTxwPbptRgueVGuWmxofx2guo/xhsjdByPvx6B5yi00N2e2WXdE76FLZ rfwqXYojWBFeAc6VCKTX62fdmj52ggvWojWI+X13+FFAiQ3WtCsQILtxwlbw2nTzVPZn0HQaKkQBZP x5l451u/IyjhWpTNgetoOA8OgwhEfLEFHyZH3FI0hSoefyhQMRV5erqyFkBQ==
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

Add some cases where success and failure at verification time is
tested.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c  | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index fdcea7a61491..f2608a3e4e0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -91,7 +91,7 @@ static void test_map_kptr_success(bool test_run)
 	);
 	struct map_kptr *skel;
 	int key = 0, ret;
-	char buf[16];
+	char buf[24];
 
 	skel = map_kptr__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index eb8217803493..30c981be008b 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -2,10 +2,17 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+struct foo {
+	int data;
+};
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr *unref_ptr;
 	struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
+	struct foo __kptr_ref __local *lref_ptr;
 };
 
 struct array_map {
@@ -130,11 +137,42 @@ static void test_kptr_get(struct map_value *v)
 	bpf_kfunc_call_test_release(p);
 }
 
+static void test_local_kptr_ref(struct map_value *v)
+{
+	struct foo *p;
+
+	p = v->lref_ptr;
+	if (!p)
+		return;
+	if (p->data > 100)
+		return;
+	/* store NULL */
+	p = bpf_kptr_xchg(&v->lref_ptr, NULL);
+	if (!p)
+		return;
+	if (p->data > 100) {
+		p->data = 0;
+		bpf_kptr_free(p);
+		return;
+	}
+	bpf_kptr_free(p);
+
+	p = bpf_kptr_alloc(bpf_core_type_id_local(struct foo), 0);
+	if (!p)
+		return;
+	/* store ptr_ */
+	p = bpf_kptr_xchg(&v->lref_ptr, p);
+	if (!p)
+		return;
+	bpf_kptr_free(p);
+}
+
 static void test_kptr(struct map_value *v)
 {
 	test_kptr_unref(v);
 	test_kptr_ref(v);
 	test_kptr_get(v);
+	test_local_kptr_ref(v);
 }
 
 SEC("tc")
-- 
2.34.1

