Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22F5A1F07
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiHZCot (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiHZCor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:44:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B746B84
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso6804243pjl.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hvVDteQ6MmazqwXbIHyqt6el95iRuYgeBC1SCE7DUYk=;
        b=M8K7ILJxVqeQg1MNWt9822zwi7fMIWuDdpVgOocafAiiLoLbcfstRLY0MLeFUhQRIT
         L4p+HUSDVhaEu3gqQ8OWhW9R1dlQaj+8k7kfi7wmYoByiBdiiPvOAwBa47f+/2uFiMB1
         len7kLW/SS1nsWlvRC7EPKReBAe4UhWO28hFV96Ll8EnCfGzfWW7zeoC0eWKqeNRLbWf
         Sj2A8W1VBupzMDIXFuW1XLsqnSdIE9t3bcKF/JecI9dEiOE1wkfDo+YnTSJHfmXn/MR5
         piSeRlV5/uWMAzeR9acxkNJlo7VjNYvkWR93krewmRZ+/8d/v0Qi/biTlWvl4zDxiew9
         VZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hvVDteQ6MmazqwXbIHyqt6el95iRuYgeBC1SCE7DUYk=;
        b=z7+I+g4pPzqkWsyvfyplQ+PQEuuuwEGgPqaGlugPiPqtnXtNKKissUmkuSOfIrs1ge
         sO9+q5/LwPvDyRT7r7LtHs0X++GeCd4Ul1akLoXH7/PWfH5f0q45Ayxqk5veUIr0BOm/
         EbTvlrZUGf48+PJWKPcNSb9XR6gPDhgTASRO/aWLlmHEzZbOybEFEtFiWQjqY0BbUcPe
         TtlILhA+FFSNSWG0j5YZAv/maU0ICAIs+8niWr7Ct8KGW/JjwOOl1XDLrj0/c5U3538M
         98kwO6NuBW5vrD7v6mC6d0eqSBUyHqpxkWyIMx1ky+e8oqYAWuGU0tOZpW5mk5bkILdO
         qSkQ==
X-Gm-Message-State: ACgBeo2G7I/3530KTH0TOHtGsWqCLPnF+Xl2M5oB2YTrHM5ZmvgYQC6G
        Ca8Bjh1lrzrzkc6OakhRmqgRKPhwas4=
X-Google-Smtp-Source: AA6agR6z2bSWVECy8ZaxZXZnjCl/5iGEY2CA3BNQSzUPMZae9sItw74m+5WO67D7+KCzP5ecC+N2sQ==
X-Received: by 2002:a17:902:7b87:b0:172:8ae9:2015 with SMTP id w7-20020a1709027b8700b001728ae92015mr1885670pll.112.1661481885939;
        Thu, 25 Aug 2022 19:44:45 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b0016f02fceff4sm290150plg.57.2022.08.25.19.44.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:45 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 03/15] selftests/bpf: Improve test coverage of test_maps
Date:   Thu, 25 Aug 2022 19:44:18 -0700
Message-Id: <20220826024430.84565-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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

