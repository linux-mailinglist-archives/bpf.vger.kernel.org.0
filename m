Return-Path: <bpf+bounces-64742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA615B166A6
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CE11889B7F
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335F2E3B0D;
	Wed, 30 Jul 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB9t3eVK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B52E0400;
	Wed, 30 Jul 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901951; cv=none; b=eE2Ox6kdsjrRCfxGiOHBr0BjXj2ACh0X0NG1ul0fLlU9IFOMKoSZzpFa3plwVJuslrTBdeKGPiz4jM5OjbV5Y4xqxdLj0RaTYkMQGeFJxcQiCbqMhK9qXwdxZpByEXNrnMc2deu2tjuGzX98SOZ/mG24ayFLyL2v8PY4zC3f7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901951; c=relaxed/simple;
	bh=rvlI8d5DANTyLXYwEkRLTEYIhsqYoYxm1irjYuIbdlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8WV6DMmJyqcPx8rSD9/B2c5/e1xinpr7uqHi1sFHrcAgJ8s72URipt0ZOoND07B3QEC74Wcgt+XY6LDzHjzq6r8LTcKcg0TlKHgzHl5d0zMP2ctSYv/wdg/0Yq8HxQkD//xqWx8fyMB8FsMitEBM++AetSs6O1CEpCoLxMmqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB9t3eVK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23ffa7b3b30so2443055ad.1;
        Wed, 30 Jul 2025 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901949; x=1754506749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDWH1zRu6JQl7B7QrSY/f/7bYFARwqxp6h969F7hTj4=;
        b=KB9t3eVK1F7kAKSi4UJfKSUb7SkYpwv2B5VLDd1B53Bj9yAyDrvsThFN9BnbOFPNS1
         Z8O5WGg+xQJBOPkFMmOdLbvyUKegM+KgXhsbX4qhW9epsuS9cW1yEAibLac2FYIb6WMm
         hJRKYirh9+vzK2ZK5KSpqh+DEJH7YgLi9VUr2NsYvhSfxGACcn2VmWuyGr4k4XxPGkly
         4p3/GkTtYDNFjoWEaMvdFwOerAjg4YzySghLp/YRaulD6DgMbUQlt0XeKvcBS9Wh66OW
         i+mY9bmJMMan1jX5ltOV/J8lcOTHywCWa1J4bmIXJvH1nW+Y5vv9GgqTykZgyUnBhFjD
         gRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901949; x=1754506749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDWH1zRu6JQl7B7QrSY/f/7bYFARwqxp6h969F7hTj4=;
        b=hrCHf7f5wx/Ng2nV7jSPYdWhWbYhgZMVRKF904R94O6NeqbdeMyjoJxkktKcK9O8dj
         YzdpI6p8cV6iwX1Ltl58NzCab+P5txi3+U4ZGcquktJX2K1BTyEJs2RX71ls5lj9yED7
         WttWFxwQVJEizpjwL49T4C7t3U5t//oq9lV+b7bzVpcIR89F/ShmpvDrz8NbNMQTpi3A
         uxIwDjiTf4cSE40Ua7EnOQ4pe7YUwYNoQFcSRITilT+zRhE3p2Qiq60rlo4mi0HtMbpG
         HdvPhSTlYPE8FwxFZZrBmnxIG39lzkLtcT1PJmaAWe2q+pnLUCKEGXxRgpxMNZ4C1bmC
         JQXQ==
X-Gm-Message-State: AOJu0YzbiuYL+SwImusmWMC1VdKkpzw1xQYoR/5ozl3asKtnFFtOIY1R
	WrYPkf9N78a6ICYf72fdlCZ7T4rGzY9cZ+4gmpc14+fPVfKgNiCi/dXMR3ZD+g==
X-Gm-Gg: ASbGncsLweJl+dcpEORyUH911MtynYzqvqVaH9UPXXJbv9gsCS0rDdNBbaNi4ea8X/Q
	eu+REn0DHOImgw9Utmybbiqk/zNJr9p3zpf3rhM2B1VeYSJPci9v4NlvHPwORKTM7pM9WGS7S7E
	W9cYsQxeEOkIATODw9UyBtnAf2j7Oz8+aYpqvM4MfDgyCzC5XKKJkwDwPNpdnMcng6v0OEybaCS
	oSPbAfDencqCsrXYlUSN2OHWvlt40mt/P5DArP8SfLX3QgdehqW02wjLUmd70u9Bty3BtCwrw0n
	SbguATOJADujwzOZgu9Xyyl9Q6UfHvYzcpKJ7sseezhie/mY/AcdINHEwinZGtEMNv3JBKxsvlH
	N6GVSZp+tkGJCLA==
X-Google-Smtp-Source: AGHT+IGZLzLVn1tdggCunsQhWzdct3HGJDpnQzCrGPseMuIFd+duLUWoFSVekNX46GaBAikBuHd/Lg==
X-Received: by 2002:a17:903:289:b0:240:418c:b9f6 with SMTP id d9443c01a7336-24096b56b5emr62999175ad.49.1753901948752;
        Wed, 30 Jul 2025 11:59:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f13bsm89314095ad.172.2025.07.30.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:59:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	linux-lists@etsalapatis.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Test concurrent task local data key creation
Date: Wed, 30 Jul 2025 11:58:55 -0700
Message-ID: <20250730185903.3574598-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730185903.3574598-1-ameryhung@gmail.com>
References: <20250730185903.3574598-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test thread-safety of tld_create_key(). Since tld_create_key() does
not rely on locks but memory barriers and atomic operations to protect
the shared metadata, the thread-safety of the function is non-trivial.
Make sure concurrent tld_key_create(), both valid and invalid, can not
race and corrupt metatada, which may leads to TLDs not being thread-
specific or duplicate TLDs with the same name.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_task_local_data.c     | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 2e77d3fa2534..3b5cd2cd89c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -185,8 +185,113 @@ static void test_task_local_data_basic(void)
 	test_task_local_data__destroy(skel);
 }
 
+#define TEST_RACE_THREAD_NUM (TLD_MAX_DATA_CNT - 3)
+
+void *test_task_local_data_race_thread(void *arg)
+{
+	int err = 0, id = (intptr_t)arg;
+	char key_name[32];
+	tld_key_t key;
+
+	key = tld_create_key("value_not_exist", TLD_PAGE_SIZE + 1);
+	if (tld_key_err_or_zero(key) != -E2BIG) {
+		err = 1;
+		goto out;
+	}
+
+	/* Only one thread will succeed in creating value1 */
+	key = tld_create_key("value1", sizeof(int));
+	if (!tld_key_is_err(key))
+		tld_keys[1] = key;
+
+	/* Only one thread will succeed in creating value2 */
+	key = tld_create_key("value2", sizeof(struct test_tld_struct));
+	if (!tld_key_is_err(key))
+		tld_keys[2] = key;
+
+	snprintf(key_name, 32, "thread_%d", id);
+	tld_keys[id] = tld_create_key(key_name, sizeof(int));
+	if (tld_key_is_err(tld_keys[id]))
+		err = 2;
+out:
+	return (void *)(intptr_t)err;
+}
+
+static void test_task_local_data_race(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	pthread_t thread[TEST_RACE_THREAD_NUM];
+	struct test_task_local_data *skel;
+	int fd, i, j, err, *data;
+	void *ret = NULL;
+
+	skel = test_task_local_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	tld_keys = calloc(TLD_MAX_DATA_CNT, sizeof(tld_key_t));
+	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
+		goto out;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
+	tld_keys[0] = value0_key;
+
+	for (j = 0; j < 100; j++) {
+		reset_tld();
+
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
+			/*
+			 * Try to make tld_create_key() race with each other. Call
+			 * tld_create_key(), both valid and invalid, from different threads.
+			 */
+			err = pthread_create(&thread[i], NULL, test_task_local_data_race_thread,
+					     (void *)(intptr_t)(i + 3));
+			if (CHECK_FAIL(err))
+				break;
+		}
+
+		/* Wait for all tld_create_key() to return */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
+			pthread_join(thread[i], &ret);
+			if (CHECK_FAIL(ret))
+				break;
+		}
+
+		/* Write a unique number to each TLD */
+		for (i = 0; i < TLD_MAX_DATA_CNT; i++) {
+			data = tld_get_data(fd, tld_keys[i]);
+			if (CHECK_FAIL(!data))
+				break;
+			*data = i;
+		}
+
+		/* Read TLDs and check the value to see if any address collides with another */
+		for (i = 0; i < TLD_MAX_DATA_CNT; i++) {
+			data = tld_get_data(fd, tld_keys[i]);
+			if (CHECK_FAIL(*data != i))
+				break;
+		}
+
+		/* Run task_main to make sure no invalid TLDs are added */
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
+		ASSERT_OK(err, "run task_main");
+		ASSERT_OK(opts.retval, "task_main retval");
+	}
+out:
+	if (tld_keys) {
+		free(tld_keys);
+		tld_keys = NULL;
+	}
+	tld_free();
+	test_task_local_data__destroy(skel);
+}
+
 void test_task_local_data(void)
 {
 	if (test__start_subtest("task_local_data_basic"))
 		test_task_local_data_basic();
+	if (test__start_subtest("task_local_data_race"))
+		test_task_local_data_race();
 }
-- 
2.47.3


