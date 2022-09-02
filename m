Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60F5AB9E1
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIBVLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4165D8E32
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w139so3040765pfc.13
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fN5UTsD9/UNy4JwRwsLxsSRdDj8AsSF1mCpGXo1LAXw=;
        b=MzhJb7DeGqrdXTr68P9EuoEFICUOC+F3zkwB7lo4l3TqEH95m7Ve+aXypNk19AOh65
         yZM0CMp01BZtiR4vXFlq4EEevvOJ3oQ9RBArId6AYe6xSMGcYqVJW6tU+OGn2222jYR/
         7tfsLlZVy8VP0QZkj1BTy3Sews6BaMbsOzdTLZ1FUyIqthRuRTw4GdnmISsz6aKRflqZ
         8oRAON32QbXfkaVS4wbQw4MQhUGUB542Anpw2ESQv7RCQ4sOKlNmPWQN+eXBTMhO31dl
         HSWYQ4OlnSIJYxljp4c7UNYtBJZFh2nBrhKBmuRUNDiKMpYw3z5ddbBdbazRAew0lxL/
         BVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fN5UTsD9/UNy4JwRwsLxsSRdDj8AsSF1mCpGXo1LAXw=;
        b=vzC0UYXc51FxbnmDHAfm+WfXzQbUmS1sjlcMh9U5LDRuHz9Fpaec8eyQ4/M2nxDFQD
         ombnY9wSsWMbKcMxOHFtoC66JC/e0EDbJuhk4FA2wshD+b4uwwu1dqgujvhXY3pIWlT6
         YXEJOQUXLbEtmBDXGLVCA8kqbCYqQF5lDmaBLVQ8tKkmonKnhzYZl62TZWS/B9V9JBZD
         xhteVOVYPKW0JC/Y/TllqeMBcorYaa0vLMXkHdE3VOgK2RR5ZKYNY3sQQVwERJ5ESIMx
         kumLkEt9YMWa9tXYU0JW4TCcxGNtxHz2/BK4SVCaJ9Zin7rEkyVQklRpdDQcK92WKiQx
         AXqQ==
X-Gm-Message-State: ACgBeo1rTyUC9/pm55nmN6nayhBO/YnwcgX0ogPyVCdUWfujs3lmP9Ew
        rRwjmMtg9/qXY90FsAOvuHM=
X-Google-Smtp-Source: AA6agR4Aia0MYvf8H9EHnMwCgvO736xTHM4ggch+Tusz/FffOHXj94vbODIdwLjAsXKUMbxG2UXe9Q==
X-Received: by 2002:a63:564f:0:b0:425:f2cd:d0ce with SMTP id g15-20020a63564f000000b00425f2cdd0cemr31670185pgm.143.1662153073177;
        Fri, 02 Sep 2022 14:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79f88000000b0052e57ed8cdasm2321374pfr.55.2022.09.02.14.11.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:12 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 03/16] selftests/bpf: Improve test coverage of test_maps
Date:   Fri,  2 Sep 2022 14:10:45 -0700
Message-Id: <20220902211058.60789-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

Make test_maps more stressful with more parallelism in
update/delete/lookup/walk including different value sizes.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c | 38 ++++++++++++++++---------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index c49f2056e14f..00b9cc305e58 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -264,10 +264,11 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	close(fd);
 }
 
+#define VALUE_SIZE 3
 static int helper_fill_hashmap(int max_entries)
 {
 	int i, fd, ret;
-	long long key, value;
+	long long key, value[VALUE_SIZE] = {};
 
 	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
 			    max_entries, &map_opts);
@@ -276,8 +277,8 @@ static int helper_fill_hashmap(int max_entries)
 	      "err: %s, flags: 0x%x\n", strerror(errno), map_opts.map_flags);
 
 	for (i = 0; i < max_entries; i++) {
-		key = i; value = key;
-		ret = bpf_map_update_elem(fd, &key, &value, BPF_NOEXIST);
+		key = i; value[0] = key;
+		ret = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
 		CHECK(ret != 0,
 		      "can't update hashmap",
 		      "err: %s\n", strerror(ret));
@@ -288,8 +289,8 @@ static int helper_fill_hashmap(int max_entries)
 
 static void test_hashmap_walk(unsigned int task, void *data)
 {
-	int fd, i, max_entries = 1000;
-	long long key, value, next_key;
+	int fd, i, max_entries = 10000;
+	long long key, value[VALUE_SIZE], next_key;
 	bool next_key_valid = true;
 
 	fd = helper_fill_hashmap(max_entries);
@@ -297,7 +298,7 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
 		key = next_key;
-		assert(bpf_map_lookup_elem(fd, &key, &value) == 0);
+		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
 	}
 
 	assert(i == max_entries);
@@ -305,9 +306,9 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
 	for (i = 0; next_key_valid; i++) {
 		next_key_valid = bpf_map_get_next_key(fd, &key, &next_key) == 0;
-		assert(bpf_map_lookup_elem(fd, &key, &value) == 0);
-		value++;
-		assert(bpf_map_update_elem(fd, &key, &value, BPF_EXIST) == 0);
+		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
+		value[0]++;
+		assert(bpf_map_update_elem(fd, &key, value, BPF_EXIST) == 0);
 		key = next_key;
 	}
 
@@ -316,8 +317,8 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	for (i = 0; bpf_map_get_next_key(fd, !i ? NULL : &key,
 					 &next_key) == 0; i++) {
 		key = next_key;
-		assert(bpf_map_lookup_elem(fd, &key, &value) == 0);
-		assert(value - 1 == key);
+		assert(bpf_map_lookup_elem(fd, &key, value) == 0);
+		assert(value[0] - 1 == key);
 	}
 
 	assert(i == max_entries);
@@ -1371,16 +1372,16 @@ static void __run_parallel(unsigned int tasks,
 
 static void test_map_stress(void)
 {
+	run_parallel(100, test_hashmap_walk, NULL);
 	run_parallel(100, test_hashmap, NULL);
 	run_parallel(100, test_hashmap_percpu, NULL);
 	run_parallel(100, test_hashmap_sizes, NULL);
-	run_parallel(100, test_hashmap_walk, NULL);
 
 	run_parallel(100, test_arraymap, NULL);
 	run_parallel(100, test_arraymap_percpu, NULL);
 }
 
-#define TASKS 1024
+#define TASKS 100
 
 #define DO_UPDATE 1
 #define DO_DELETE 0
@@ -1432,6 +1433,8 @@ static void test_update_delete(unsigned int fn, void *data)
 	int fd = ((int *)data)[0];
 	int i, key, value, err;
 
+	if (fn & 1)
+		test_hashmap_walk(fn, NULL);
 	for (i = fn; i < MAP_SIZE; i += TASKS) {
 		key = value = i;
 
@@ -1455,7 +1458,7 @@ static void test_update_delete(unsigned int fn, void *data)
 
 static void test_map_parallel(void)
 {
-	int i, fd, key = 0, value = 0;
+	int i, fd, key = 0, value = 0, j = 0;
 	int data[2];
 
 	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
@@ -1466,6 +1469,7 @@ static void test_map_parallel(void)
 		exit(1);
 	}
 
+again:
 	/* Use the same fd in children to add elements to this map:
 	 * child_0 adds key=0, key=1024, key=2048, ...
 	 * child_1 adds key=1, key=1025, key=2049, ...
@@ -1502,6 +1506,12 @@ static void test_map_parallel(void)
 	key = -1;
 	assert(bpf_map_get_next_key(fd, NULL, &key) < 0 && errno == ENOENT);
 	assert(bpf_map_get_next_key(fd, &key, &key) < 0 && errno == ENOENT);
+
+	key = 0;
+	bpf_map_delete_elem(fd, &key);
+	if (j++ < 5)
+		goto again;
+	close(fd);
 }
 
 static void test_map_rdonly(void)
-- 
2.30.2

