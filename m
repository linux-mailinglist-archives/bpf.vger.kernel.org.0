Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539659A7E4
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiHSVms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHSVmr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1E10DCD5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo8673153pjd.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dmkm8LUqLMPRLLj04Upjo1iLNrY0YeL6wYt31D9wn9c=;
        b=g5Ax/6Xv9cqCyyR94zcUzn0wGeLtY1TKEosUBJ3ox+a3VDhK/7ZUH11/R6GkotOzt0
         ro+XXiAhrilK2OhvjomOAEeCMX/Nu9apno/sJIaykK/d0p1W6SiTClj4Ft9PHf/0I7T6
         tX9cT9v2GsuW5+b/7NGU5Tjkm65e9cLVV1C5EGyu1uXgSFaNIP7grIQYVhfWYyZzOWwM
         hzhHB8NBGVUO6n9V0RbJlPznK4cmecaimKajYRj7PDLIU2/LWbLuT93c20EL4TBAWWx3
         VGqcCDfoIGU1FpapPDBzfNoTNWg499kyfd+bXnmW5x52luQiQ6QLLO5cKMC+5Kwln6vt
         fxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dmkm8LUqLMPRLLj04Upjo1iLNrY0YeL6wYt31D9wn9c=;
        b=PTrMNpIqrFGUfkWPLhYa0FBZ3mAQ32HQy9ydxkk/L/DDb9WiUKgevgtjmFRVYL4I+v
         hBsgfbDQCiXWraxdImBRdU0uWWgwocUOKXlufSQEhuNrQDhTAf8aT7F51DiSq5y8/b/F
         T1061FchHPLrgoeiYZsl8we3PemiS5TU+a/K70uPMj7XyhGcUyL62HO/Oi98aXM6trNj
         LdOarFySJExTiANp3b89Gkf403wz77pgobZEVKwsGgOMl5ZgMRKCLq6F+8auMxgSWg6E
         25vs2cA9ZEwoCInXni6SuoQGwWsj7XuW2iabxgJqxU48mNnEwrUScgnOcbuZ4A564xCe
         CzSg==
X-Gm-Message-State: ACgBeo3vEu5rZwtXD2wy5Lp0dvvsUPZUmsGS790hOS/yjRpX3NB5IKfm
        /XPAvCr4awTfwGBBS3aC5dw=
X-Google-Smtp-Source: AA6agR6XIbzCUUYxE9qqryXKyHB5woeKhQiUWWYtqbletzdvYojvwWCjYx6ctJR/Zrt848tUy436pQ==
X-Received: by 2002:a17:903:187:b0:172:65c3:e229 with SMTP id z7-20020a170903018700b0017265c3e229mr9212966plg.97.1660945366434;
        Fri, 19 Aug 2022 14:42:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id n2-20020a622702000000b0052e7f103138sm3850793pfn.38.2022.08.19.14.42.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:45 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 03/15] selftests/bpf: Improve test coverage of test_maps
Date:   Fri, 19 Aug 2022 14:42:20 -0700
Message-Id: <20220819214232.18784-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c | 38 ++++++++++++++++---------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index cbebfaa7c1e8..d1ffc76814d9 100644
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

