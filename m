Return-Path: <bpf+bounces-61789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E58FAEC311
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0003AEA81
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4D292B42;
	Fri, 27 Jun 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir3i0yOg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5D291C34;
	Fri, 27 Jun 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067606; cv=none; b=ZygzlH0OFCuqvpx4ugpBpKeqqxUb3nuPPjJWgN4xq/E7zqzLJOSw1BZx5q1P76qQAbdJ7QeMdmDUW8/SLQHjUzasBlcHn6UDmmJH9qfc6XpdiCEqyUnyjH2EEEJmAIEW/EwBBK+n8UetePl5S96lsda/RmmCl9M94mar3Wqn4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067606; c=relaxed/simple;
	bh=xUGX55h8nFeANftT7sLX3g8kJGakPkOONRo0TbD4WFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUL9FkMfBGqeXNNvrYIN6vS0eA5Nqfb4H6lWFoiJ1n75Ct70mze5N5BQ0wij4snSsl+C/OD1q86/WK9rvtMw7MmkY0+FYdfimxbVn4nKmkGcMKFQsQ2QlzFIBLUxDbkbGXstJ652Qwc4HfR9jCVrrrUrAM80dLGnAUpiYomW0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir3i0yOg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237e6963f63so550195ad.2;
        Fri, 27 Jun 2025 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751067604; x=1751672404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iObp/3c6/tNbk6nfNMkT56WdCpWJQbF1znOFK9fVavA=;
        b=Ir3i0yOg5e1gcDRdCl7h1v5j0LWsMMkxcy5XMcalHv4I4v9g09kSawDopmnoM84wYQ
         fxpI9sNgEzCdXqfvn5AURf2qgv4utjJnBS7tC0f7MW/beqyPK0EVzfqN7vCaYqDbpG0X
         Mn4ccPAveqFpcqOWj0JW9PMRnYfWItGZJ1UZaS6RByRoGJRGVkA/HPHrp8XmGY6dS6kF
         3R2d7AHL932TgcR/IyxoZcv9HlzJbYNp41wZjyCa0OTHZ3GXdZH+1a1rAvTbJQIRn9S1
         qzU6ECoaVSleRqjkkKDfdIcl3DnmQfon0+H8ZyVp6Y/W50gUVi0XvKDNzJD6Vgj2S30J
         6x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067604; x=1751672404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iObp/3c6/tNbk6nfNMkT56WdCpWJQbF1znOFK9fVavA=;
        b=hhT5PYI1Tit0zddU0yIRXIRHqlUi/ttPAwO185jIYN8x1KPTMGDnZHGMLWnRdcbVg1
         avYjKyrEoBncTo2lfThdtmNHarHb9RJ3mfV3btN2b50UZ+0tYexEDZOUEz3W2JCeDU6Z
         9tMUAdLup8GJO+Oy50/TCm8b8L+kOl1wwk9oiWVPQiJTCoSpbJUNttlddgjAeeyW3eeG
         PK4QM8C0IKfivw48AikHijI70236zcr25kxdjezcAyCdNnT/xKw2dLFQmQmakea8ABa9
         jxHn61EZ/5JzZHTkj/+uo5yVffDXtsw+UkBy5RkXiLMugXfjzEUAWipQD26cUd8lCi/5
         ns/A==
X-Gm-Message-State: AOJu0Yw8yqAB9Rawnnrb42I6N1XyA7pzEak0gXq/Gi1h78D/+f8Lt1XE
	5nlnkjXAJ/yXS04r/r3HV/ZJxuH7KNh+qT6YdQF61eI8hzv9h3TiMEvFLA8IGQ==
X-Gm-Gg: ASbGncupDYgWp6QdGuJS1XBR+AVEA8mCVCxoP1JAurdf+3i11HUX/ryD0I92bEjCpLu
	stNojlbIgJ2aia+fQi91sdC+aFZlJA1oZJb/PKlqWofOwZ1/rjTqhvdPhwDWxFFDln5P/e6jWcA
	YEAsqIu4B4MH4v3kMw/cZvb4D43PnBgxwyGdL5zTjqfJQ/LwPm5PDhtbzNqUisw0cPuR+EYoC0l
	f9/etrjfa/MfQQJy70TLOO2uMYc+ldYV+aiyHxdvL57rVjkHas4EbcMPq3KXWNAunMcwn1bI0+0
	Ex8GWFwt56H2jUknxtrt34VY8UqrpULhVvZDqYnq9tb0duVUaeEc
X-Google-Smtp-Source: AGHT+IGJ837FxfipMc5AaN6FNNOihgI5Bcq+9yqrLL1XpaK4HTlYPmLP88ITsxEPdUX5eX5ujyF0pQ==
X-Received: by 2002:a17:903:2983:b0:234:aa98:7d41 with SMTP id d9443c01a7336-23ac4685adbmr82539415ad.42.1751067604171;
        Fri, 27 Jun 2025 16:40:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1d0csm24588255ad.56.2025.06.27.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:40:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test concurrent task local data key creation
Date: Fri, 27 Jun 2025 16:39:57 -0700
Message-ID: <20250627233958.2602271-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250627233958.2602271-1-ameryhung@gmail.com>
References: <20250627233958.2602271-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/test_task_local_data.c     | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 53cdb8466f8e..99a1ddaf3e67 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -184,8 +184,111 @@ static void test_task_local_data_basic(void)
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
+	/*
+	 * If more than one thread succeed in creating value1 or value2,
+	 * some threads will fail to create thread_<id> later.
+	 */
+	key = tld_create_key("value1", sizeof(int));
+	if (!tld_key_is_err(key))
+		tld_keys[TEST_RACE_THREAD_NUM] = key;
+	key = tld_create_key("value2", sizeof(struct test_struct));
+	if (!tld_key_is_err(key))
+		tld_keys[TEST_RACE_THREAD_NUM + 1] = key;
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
+	tld_keys = calloc(TEST_RACE_THREAD_NUM + 2, sizeof(tld_key_t));
+	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
+		goto out;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
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
+					     (void *)(intptr_t)i);
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
+		/* Write a unique number in the range of [0, TEST_RACE_THREAD_NUM) to each TLD */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
+			data = tld_get_data(fd, tld_keys[i]);
+			if (CHECK_FAIL(!data))
+				break;
+			*data = i;
+		}
+
+		/* Read TLDs and check the value to see if any address collides with another */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
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
2.47.1


