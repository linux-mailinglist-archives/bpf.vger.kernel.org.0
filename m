Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6011CA8D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfLLKXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfLLKXL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so1673026lja.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnepzN6uUxdyQgIygcy+mBz8kPKU6vbsUnCY86T0924=;
        b=IqjccSwa3c1lkMhESUS6vDVI6rOjypFyF9TIMGZV7fVwG8JrYDTVUoiK8cjJEadKuq
         +yltPoiILOMfw3SejKOfgwLX5A9MEb0Gbi6yA8nsWwTzHj5fIP1pwuHQ6/716H9fIJkk
         Og5/OuqlM4M+cklwRUBIW+t/ayMlTclm2js6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnepzN6uUxdyQgIygcy+mBz8kPKU6vbsUnCY86T0924=;
        b=Ayk+LEhFRfZlvgxzkodDvqEXeTLoSEQmqf4ntoXl6awr0w3cq1FoeD2KH+aEI7+UF3
         t24ylc30Gv6zMJg7B3lgBf+3J8EzdmbREBVaeziBJT4CQUAK897kz8xa92TIUzoXa22x
         tm5Fl0QI9SCIWTBgtj+20ntH7WRKZwJuGVH/OcPF6xKwg7TCL0S+o11GlbabvnHpsJ0U
         gkVocES5EXjnk97fJqlPF0U11BHL3xHF1jtu6tfWs3xzJnrUydGkB/6MGU4L1JOsL52w
         HOkjdIeXkO0xs8k/01vVBwWgENdAn2oU+jXLgeEmXtMLRiPBlZRbFebehnQD6zofyrnI
         83RQ==
X-Gm-Message-State: APjAAAUB6gQs4GEdGaA5vzrzg+BPPoa1T1g69P8pO5R0d7Gn0gaCYjAo
        PHZaDqCy0C+XuEkHvDgCXJYlA4LsH+gTZw==
X-Google-Smtp-Source: APXvYqxWSNelS8ivrXRcNaS58ppmDYp3Omqam6puTK64Y3GN7VHT01wzylbPZBMJ5z4c1f8UYitiag==
X-Received: by 2002:a2e:7f08:: with SMTP id a8mr5143517ljd.164.1576146188443;
        Thu, 12 Dec 2019 02:23:08 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id z13sm2771507ljh.21.2019.12.12.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:07 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 06/10] selftests/bpf: Run reuseport tests in a loop
Date:   Thu, 12 Dec 2019 11:22:55 +0100
Message-Id: <20191212102259.418536-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for switching reuseport tests to test_progs framework. Loop over
the tests and perform setup/cleanup for each test separately, remembering
that with test_progs we can select tests to run.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/test_select_reuseport.c     | 55 ++++++++++++-------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index 63ce2e75e758..cfff958da570 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -643,7 +643,8 @@ static void prepare_sk_fds(int type, sa_family_t family, bool inany)
 	}
 }
 
-static void setup_per_test(int type, sa_family_t family, bool inany)
+static void setup_per_test(int type, sa_family_t family, bool inany,
+			   bool no_inner_map)
 {
 	int ovr = -1, err;
 
@@ -652,9 +653,18 @@ static void setup_per_test(int type, sa_family_t family, bool inany)
 				  BPF_ANY);
 	CHECK(err == -1, "update_elem(tmp_index_ovr_map, 0, -1)",
 	      "err:%d errno:%d\n", err, errno);
+
+	/* Install reuseport_array to outer_map? */
+	if (no_inner_map)
+		return;
+
+	err = bpf_map_update_elem(outer_map, &index_zero, &reuseport_array,
+				  BPF_ANY);
+	CHECK(err == -1, "update_elem(outer_map, 0, reuseport_array)",
+	      "err:%d errno:%d\n", err, errno);
 }
 
-static void cleanup_per_test(void)
+static void cleanup_per_test(bool no_inner_map)
 {
 	int i, err;
 
@@ -662,6 +672,10 @@ static void cleanup_per_test(void)
 		close(sk_fds[i]);
 	close(epfd);
 
+	/* Delete reuseport_array from outer_map? */
+	if (no_inner_map)
+		return;
+
 	err = bpf_map_delete_elem(outer_map, &index_zero);
 	CHECK(err == -1, "delete_elem(outer_map)",
 	      "err:%d errno:%d\n", err, errno);
@@ -700,31 +714,30 @@ static const char *sotype_str(int sotype)
 
 static void test_config(int type, sa_family_t family, bool inany)
 {
-	int err;
+	const struct test {
+		void (*fn)(int sotype, sa_family_t family);
+		bool no_inner_map;
+	} tests[] = {
+		{ test_err_inner_map, true /* no_inner_map */ },
+		{ test_err_skb_data },
+		{ test_err_sk_select_port },
+		{ test_pass },
+		{ test_syncookie },
+		{ test_pass_on_err },
+		{ test_detach_bpf },
+	};
+	const struct test *t;
 
 	printf("######## %s/%s %s ########\n",
 	       family_str(family), sotype_str(type),
 	       inany ? " INANY  " : "LOOPBACK");
 
-	setup_per_test(type, family, inany);
-
-	test_err_inner_map(type, family);
-
-	/* Install reuseport_array to the outer_map */
-	err = bpf_map_update_elem(outer_map, &index_zero,
-				  &reuseport_array, BPF_ANY);
-	CHECK(err == -1, "update_elem(outer_map)",
-	      "err:%d errno:%d\n", err, errno);
-
-	test_err_skb_data(type, family);
-	test_err_sk_select_port(type, family);
-	test_pass(type, family);
-	test_syncookie(type, family);
-	test_pass_on_err(type, family);
-	/* Must be the last test */
-	test_detach_bpf(type, family);
+	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
+		setup_per_test(type, family, inany, t->no_inner_map);
+		t->fn(type, family);
+		cleanup_per_test(t->no_inner_map);
+	}
 
-	cleanup_per_test();
 	printf("\n");
 }
 
-- 
2.23.0

