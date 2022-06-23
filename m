Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F5556F78
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiFWAcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356387AbiFWAcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23AE41637
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d17so8595536pfq.9
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmkm8LUqLMPRLLj04Upjo1iLNrY0YeL6wYt31D9wn9c=;
        b=ouJqR47932CNc3bXd7J1Tx/spyOSdMx9ufdDtiPkGqsSyAlY5rWMgqkbF2EPpTxhdG
         eo+AyZZEnCkSV702OURVg1ljjakvjNBtw9JEFVI3ZZmUIE0jM30fEL96JhgSTm6B9mNo
         tnzkPtXl/MuGoOqopLE8FaMI3JvInEAaB6fBqi/u4LA8Z3KZz6iFYMxD78glhb8nLV9X
         Mvcz4x1uRDt7FBhHneFlkbFYUr9JNGkd/2RfyOPv27zb5T5MeZsh/+BEZSRKlv0P3CtE
         wbDIKx5QEHCo7q8FzSb6XjjI3N3AUym58N+V9+KF2D9PCsPA4vj9OdR2a2MDVSW6scqm
         mkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmkm8LUqLMPRLLj04Upjo1iLNrY0YeL6wYt31D9wn9c=;
        b=M4NHlmdz674km80jenVf5V1Q4+TTWx/XvtK5QnmSG32sE/L+ZmB/o9d2cKUmR08sGo
         wY5v6Jcrq8vid0kuSGBdqGPI234tMt/6YvaY3jbbBvmprmaZ0l76xl120cmGQPBSAPv5
         8tNjY+rvzbKZ9MMtanLajcPDz4Wez3Ij8jn4evHGE4hxRiILPn+IK7tLzXRgR1t2I3b9
         7j3lPD9opjJ0lXPvRxPABp7BSb2frI2h7684RLoVeo4nRt37rbqGCbDfeyCvyWNhQ0ry
         NR5iz+7hGygX1cru11NO5QV1XF/mmDkIlmHMUkfT3y8yz0/KJLrcNUJvbGjg3RkYMFw9
         odxw==
X-Gm-Message-State: AJIora/dA5ccxo5+g/fRmkuRd5Oz7K8yXfKderSBhAb1Yq3Z4akP73Qs
        doG/GUayC6+RjTfbs/P6GR8=
X-Google-Smtp-Source: AGRyM1uhWkUIzzuRn5UBWakegGOzsNVEpb17YQYBJAyFWMQiP+sc0iRlsSz8z4KdxnSdjHW3kxVzjw==
X-Received: by 2002:a05:6a00:150a:b0:525:3030:fe41 with SMTP id q10-20020a056a00150a00b005253030fe41mr14568266pfu.37.1655944366083;
        Wed, 22 Jun 2022 17:32:46 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a410800b001ecb5a6385bsm372959pjf.36.2022.06.22.17.32.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:45 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 3/5] selftests/bpf: Improve test coverage of test_maps
Date:   Wed, 22 Jun 2022 17:32:28 -0700
Message-Id: <20220623003230.37497-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
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

