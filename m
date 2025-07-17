Return-Path: <bpf+bounces-63638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C11B0922A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1B4A2BAE
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904D2FD5B9;
	Thu, 17 Jul 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6pt3NAR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552F2FCFE9;
	Thu, 17 Jul 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770929; cv=none; b=JITNMtL/0x++B1ez3PjbgQp4uetvEsy39PjPQoGbnST1U2KL+cFCIzfq3lTjVQeMoz7OBpw1WJiPu0Hqx6gnbMnaBB+MpDufWwe4IrgYBt/avqgqW3cIalhgWYAISfdTTbfNG9vn0P6m+um+9Ut6lhQi3L5uVr/5dsa5S/xfGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770929; c=relaxed/simple;
	bh=+6R6eFeS8klpjDrG0RXi6/fDpojVtggjpEQiVioJAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buY311nbxc59kNakhB93kCgzuASc+oI5Ays6RUY2aEL6C75CJGu1vy+Wt2NAO/i+xUPXH5TjqTgYuUXYK797bzt22B0fVnyiPBNan3Ty5wdVmj3Ls2QFbRqfHtGmSsw2C1sCSh3ey8zZT2l30iZXoIiet5RW86OelrmKABPQKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6pt3NAR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23c703c471dso25002295ad.0;
        Thu, 17 Jul 2025 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770927; x=1753375727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GVnlofJ6YJg6lZtTEUlEpu78JvxhwvFnaVvyUE/X6Y=;
        b=d6pt3NARAFf7vKqaIrDhdQ1gSk7fK2a7F+tM0gyctOeGm18Z2nAL4vm0FVR/N+HGQQ
         IoMP11Ta70vEBsJKd6FIDcXqAkoadoV1Mwh3to/Wu7Pqa6XmkIg21Hm13kx8ao+Jm+TC
         QNAyLoOq1V8/q9PEncxfffw0krgRSC2LnKZIeHsSdZ7+rAPLP8BFY92OABWkYdQb2QSr
         jW6rN/oBq5h0FOHsneF81V8CfCVrnziwMGZDmBZ0MD6KP7cTm6RMEv+KAxKNnpodujEh
         91hAgKL9bufq9JZxFlez51xuem6oE+1NNm4qg4h98N0oZo4WjPG3eLlNrK0kXebk2UAW
         VJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770927; x=1753375727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GVnlofJ6YJg6lZtTEUlEpu78JvxhwvFnaVvyUE/X6Y=;
        b=iyIFOiuQUUT9qCl0cdhdxfHAcjt1/3IH5lr02cDONnG8TIR1xE94czuTq0LUCfIcMa
         PZx7DRk4dAj6QGDOP1BGCHHwbiDfE6ZPJ/eFfNuTH/M4jWsJ3lQCqAmJzB0irHBSmXBY
         +Qe8q4lNy8R++6FFujmAA8+Sj2a4rZ1exSa9v4rJEiC0JMM4OGoSSaJ+qL1Bt7rWJLRE
         R52jsBwm9K8JczxuKplQeCgWsBglhD3bGL8XiylSbah9nKGP3i7HHAirNchOUsmGLJh7
         tOrS0HN3qQK/jBImnyM5WEbeC1TS5cuB+P9ipL1zlRPwiw1gnlEGH4CEhuLKa33Z/zuN
         4nvA==
X-Gm-Message-State: AOJu0YyL9RCymsI7cJsy3SpLeCGbYhN7JzkGMtB+L8a0MTev1dn/OHVO
	YTCdWq9EA68yze3Bs/DdYtz2POGBpyyYEjXO/rb0hzj8zbJf/9rAEoHD8TDcKw==
X-Gm-Gg: ASbGncvyD+tIi1jcjybAZPGFNERqKxBLmcwABI0VAhaJ/xYw3VKNLD6XegivQfI11TW
	hp9DLXpTmh8J6Xe0S3DulYET3np9IxtkwLadPRQf3Qdb2NEldey4VzF7o1JdLNawX3ljf5bWNCg
	Eh/hx10qOuvb7Ooyx6jlY6IxCTV2dTmRpTDlgrJtyUq4z9gaxOan7sKn44h63KZH4G4Z/okkztC
	TReINCKb/QwFX9cCyE6vAXTKMk7sriD4qd+pv43BwdeRynO/PIsVBTsfb8bAl06JCY2CYImoWjB
	RF0DgvZLmB7NxRQAbHuklea1hjk4FEm8h3lml1EMrzem4aCbi5dDO3WEW4AA983WZRcl49P/S7K
	0JLbY8PSzIeX83A==
X-Google-Smtp-Source: AGHT+IGOXGEE34Gwz0xjDvGihMnZqNTKLL8OQrUpj9JzZGP6sPdoACfgevQWMb92eqVfPnnrcM354Q==
X-Received: by 2002:a17:903:1b4d:b0:236:10b1:50cb with SMTP id d9443c01a7336-23e2f7bbd6cmr57755555ad.26.1752770926707;
        Thu, 17 Jul 2025 09:48:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333c90sm145052795ad.157.2025.07.17.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:48:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/3] selftests/bpf: Test concurrent task local data key creation
Date: Thu, 17 Jul 2025 09:48:41 -0700
Message-ID: <20250717164842.1848817-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717164842.1848817-1-ameryhung@gmail.com>
References: <20250717164842.1848817-1-ameryhung@gmail.com>
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
index fde4a030ab42..1d3ccb98b5db 100644
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
2.47.1


