Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73B162BB4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgBRRKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 12:10:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38578 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBRRKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 12:10:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id e8so2387267wrm.5
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmbffH+g37NHt3dwjQ9IfXr7+PZ9rnec7B/SNJAih/g=;
        b=Dsq7NGKDmu9yqfRAvznbBHzsMUHitadEoAvlpTK6RJtP2FZGD/KJNACgwBah3dKpqv
         t+ysWo0z14FJgbR+r+AISS0WfVYLBPqEoU+rkA417wDEHudRFcbLoG/3jDIAAF7HKJZV
         xNORrfpW3mgEhQRDI+SWq2WJBlaoK3scfhViM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmbffH+g37NHt3dwjQ9IfXr7+PZ9rnec7B/SNJAih/g=;
        b=bAN8wBgtI3ySutkeUf1vCJyYW6UCNAXkLcuzQ3N/ja6mpsjFi0YWI8a1W67/+mdIaS
         NzXVFu66w19jWvgpWZYC1bAM2KaIKpkXbwOeAIIwCWqrmX/1V/WLJoe+4J9g8kzK1AmH
         eMAgmQ3+s1pCSvTm5Vf2eVaKDVWQ21Q0xrbZY8eMqgu/zMqiZ3RGIcBHGy8ueyszUyOt
         y9j0RQdPjT4UXVQwGHKVWFZU5T5RoPv+T4ZtOUIVkdnvF4YZDeo5yKn4nshdypcoaFnz
         Awrh+euJaAgKEhBmnIuROHn2gvqRw5gd54/3lZXSpjZiA89YnaWH9YCN0dAxfaH9rVKe
         8r+A==
X-Gm-Message-State: APjAAAVV89vaGN/wjLxYv+8/4S3fMtLlZtLVPfNsxFXGA7GLNlTc6h65
        3MebyZgqXULU9KWYGXbHdtp765nW7jpgCeNp
X-Google-Smtp-Source: APXvYqyO8Cj+cWN+9AsTlFeZIutW3QwCvBTedw2Qp1MWRv8ZfvwtMMtPbT48eDGQkwsVxAlZYOLhEw==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr28590822wrt.4.1582045841528;
        Tue, 18 Feb 2020 09:10:41 -0800 (PST)
Received: from cloudflare.com ([88.157.168.82])
        by smtp.gmail.com with ESMTPSA id z4sm6841505wrt.47.2020.02.18.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:10:41 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v7 10/11] selftests/bpf: Extend SK_REUSEPORT tests to cover SOCKMAP/SOCKHASH
Date:   Tue, 18 Feb 2020 17:10:22 +0000
Message-Id: <20200218171023.844439-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218171023.844439-1-jakub@cloudflare.com>
References: <20200218171023.844439-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Parametrize the SK_REUSEPORT tests so that the map type for storing sockets
is not hard-coded in the test setup routine.

This, together with careful state cleaning after the tests, lets us run the
test cases for REUSEPORT_ARRAY, SOCKMAP, and SOCKHASH to have test coverage
for all supported map types. The last two support only TCP sockets at the
moment.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 63 ++++++++++++++++---
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 098bcae5f827..9ed0ab06fd92 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -36,6 +36,7 @@ static int result_map, tmp_index_ovr_map, linum_map, data_check_map;
 static __u32 expected_results[NR_RESULTS];
 static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
+static enum bpf_map_type inner_map_type;
 static int select_by_skb_data_prog;
 static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
@@ -63,13 +64,15 @@ static union sa46 {
 	}								\
 })
 
-static int create_maps(void)
+static int create_maps(enum bpf_map_type inner_type)
 {
 	struct bpf_create_map_attr attr = {};
 
+	inner_map_type = inner_type;
+
 	/* Creating reuseport_array */
 	attr.name = "reuseport_array";
-	attr.map_type = BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
+	attr.map_type = inner_type;
 	attr.key_size = sizeof(__u32);
 	attr.value_size = sizeof(__u32);
 	attr.max_entries = REUSEPORT_ARRAY_SIZE;
@@ -726,12 +729,36 @@ static void cleanup_per_test(bool no_inner_map)
 
 static void cleanup(void)
 {
-	if (outer_map != -1)
+	if (outer_map != -1) {
 		close(outer_map);
-	if (reuseport_array != -1)
+		outer_map = -1;
+	}
+
+	if (reuseport_array != -1) {
 		close(reuseport_array);
-	if (obj)
+		reuseport_array = -1;
+	}
+
+	if (obj) {
 		bpf_object__close(obj);
+		obj = NULL;
+	}
+
+	memset(expected_results, 0, sizeof(expected_results));
+}
+
+static const char *maptype_str(enum bpf_map_type type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
+		return "reuseport_sockarray";
+	case BPF_MAP_TYPE_SOCKMAP:
+		return "sockmap";
+	case BPF_MAP_TYPE_SOCKHASH:
+		return "sockhash";
+	default:
+		return "unknown";
+	}
 }
 
 static const char *family_str(sa_family_t family)
@@ -779,13 +806,21 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	const struct test *t;
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		snprintf(s, sizeof(s), "%s/%s %s %s",
+		snprintf(s, sizeof(s), "%s %s/%s %s %s",
+			 maptype_str(inner_map_type),
 			 family_str(family), sotype_str(sotype),
 			 inany ? "INANY" : "LOOPBACK", t->name);
 
 		if (!test__start_subtest(s))
 			continue;
 
+		if (sotype == SOCK_DGRAM &&
+		    inner_map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
+			/* SOCKMAP/SOCKHASH don't support UDP yet */
+			test__skip();
+			continue;
+		}
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
@@ -814,13 +849,20 @@ static void test_all(void)
 		test_config(c->sotype, c->family, c->inany);
 }
 
-void test_select_reuseport(void)
+void test_map_type(enum bpf_map_type mt)
 {
-	if (create_maps())
+	if (create_maps(mt))
 		goto out;
 	if (prepare_bpf_obj())
 		goto out;
 
+	test_all();
+out:
+	cleanup();
+}
+
+void test_select_reuseport(void)
+{
 	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
 	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
 	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)
@@ -831,8 +873,9 @@ void test_select_reuseport(void)
 	if (disable_syncookie())
 		goto out;
 
-	test_all();
+	test_map_type(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
+	test_map_type(BPF_MAP_TYPE_SOCKMAP);
+	test_map_type(BPF_MAP_TYPE_SOCKHASH);
 out:
-	cleanup();
 	restore_sysctls();
 }
-- 
2.24.1

