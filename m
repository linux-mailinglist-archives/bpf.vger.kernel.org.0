Return-Path: <bpf+bounces-58365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E6AB917E
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD31188B39E
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4EA27F75F;
	Thu, 15 May 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbTjDBKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D991FFC59;
	Thu, 15 May 2025 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343773; cv=none; b=H7CzNSt2OwzWtwx4BFiUOuFz4/QFhw3JvEwM2dZ/64RrJUpU/89qPynJiSpSMM+1DQBc54sVuJ0MuHazaDgTWlDKg+TgYtGyBlHif7EEaz6LpJCdD1lSAyZ4xGNfUVNm2l/9XeNyqb3pAOmpzTZTQqWbi6MHxav3zZuNcqEmiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343773; c=relaxed/simple;
	bh=9nUnCuCcmIQrMWVt+lIRxSDT5dWwf7z7QeMSilnPqag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF3us77SbGNwMnzt1iPwA70lLJPbzfOW97YsX0mm9rb1hKfccSBRZ1HZV2su0+VGaB/Yb6UARp2csJLrZLvc5XJ0bpEHhPHgqu3kd47igT/IkG73V8iKrjTekC1TpHwDpf3ZFL1RsN/NIevMOq9dnOhDEuipZgszm0QMeej9Rw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbTjDBKW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1483364b3a.2;
        Thu, 15 May 2025 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343771; x=1747948571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KaesVsFIm14fYgwJFF3sLqz3tX811tjxxTcFdNyVvY=;
        b=GbTjDBKW3lkr0NjECML+xHFqkifvtw2iPfhp+H0ieeAR/VSZlvX8EfAv9XnnTGFaZS
         M4zTaknEP+fwPKaSiIWv4jG/A/WFWP4l76kWYS62Y0Yzsh6y92D+N8jOJeLXEdtNc6Oy
         r/SwGTMpffoo52AydtrSzpH2NLopAjAf5iGInZgKXlA8goSwOZXQZkkotrlRMxPGP38O
         SbYW5j/KJcok9WVh0T6y+eY2OU0YDltj2oleUlEVf9ZIMjzcky3hosHR0SZFRHK2Mh3f
         N4c0UpsSMmywTSDlafkW2b3MxEBmY9XIzzhOa8KBhDjC0bPgaCUiZVV5aUdXV2dWhQ6b
         L7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343771; x=1747948571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KaesVsFIm14fYgwJFF3sLqz3tX811tjxxTcFdNyVvY=;
        b=aZUMGYIC454xV4TM9CnERd9V+DHH0q67plHI+1PZHjpbKIKGwyEtg4P6VuW4kzECg8
         eLKFxf21dyYmR0a2227AAvAyc1oKNOpoJAcN6FfbQGPlzE2k9MUJV5jK/MRb2MXfL5Ld
         JpE3gp9+Ty7B3mcs8PGijOwErWH6LGTvGXRu86bLCuSyeCoW77NePF4YzG/syrs27ZSF
         LGfAHxNRuxZeqF4JLA8t+0Gtn1x53ip1IKnECCj6vNIxEhrHLCg4/uQsIOSuEUIeTlWs
         PSvb9mmIjwR10RFAUp39UJ6RgUjFLi5kfqOTjnbyyC/iYpSNC/8vb021tKjoIgLKrVuP
         PS6A==
X-Gm-Message-State: AOJu0YzyQkXTZX6qHAf6xMR0NMoaTkoSzNZ2YRnT1qIoKgpXD7HWn1Bf
	c4tJChPpo5N0Hl90wTo4w5Sg/F0tEOM5bn/gTCl+d78OIxffWxncwDk5jhtQ6g==
X-Gm-Gg: ASbGnctmk6CFoCX6IMk7QKUUnWDq9zG9pQlfEsEyRDdd783/wUA/u/Czsd85JfnC0GQ
	JhhaJ20vC9Tf/Uyt6Z42KQq0l824BC2bhCxgYym6HVLCaPT802nxcw2eo1IuyUKwF3y1K94H9ry
	R0u2IqP5urjjqPYycLVrXdnp4W8x80LGWcv+ZmRON429jmJqfwjPQJBnvL8TRcUZooKaGBavKmW
	oURRiuYNUtzfrTR+OfuyeimskRRdzP9gDbFozqh5RjU8lwxmMS4gWDww8TZ0/EmCA9EjKGd4EkL
	Zcvpm4DF3LMbtj5wI7xNunZFW2iUEUXJFKlRaVGqX54=
X-Google-Smtp-Source: AGHT+IG3XHcvKMx09g5xIMSvZ1NzT3Euw4+LJIerbvrc2gBhHhvutVBG/2rqDoquwufNOMAULCWnJg==
X-Received: by 2002:a05:6a00:3985:b0:742:a334:466a with SMTP id d2e1a72fcca58-742a97eb677mr1055601b3a.12.1747343770886;
        Thu, 15 May 2025 14:16:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876e62sm246102b3a.147.2025.05.15.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:16:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Test concurrent task local data key creation
Date: Thu, 15 May 2025 14:16:02 -0700
Message-ID: <20250515211606.2697271-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515211606.2697271-1-ameryhung@gmail.com>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/test_task_local_data.c     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 738fc1c9d8a4..5743b753a4a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -156,8 +156,99 @@ static void test_task_local_data_basic(void)
 		pthread_join(thread[i], NULL);
 }
 
+#define TEST_RACE_THREAD_NUM 61
+
+void *test_task_local_data_race_thread(void *arg)
+{
+	char key_name[32];
+	tld_key_t key;
+	int id, fd;
+
+	id = (intptr_t)arg & 0x0000ffff;
+	fd = ((intptr_t)arg & 0xffff0000) >> 16;
+
+	key = tld_create_key(fd, "value_not_exist", PAGE_SIZE + 1);
+	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
+
+	/*
+	 * If more than one thread succeed in creating value1 or value2,
+	 * some threads will fail to create thread_<id> later.
+	 */
+	key = tld_create_key(fd, "value1", sizeof(int));
+	if (!tld_key_is_err(key))
+		tld_keys[TEST_RACE_THREAD_NUM] = key;
+	key = tld_create_key(fd, "value2", sizeof(struct test_struct));
+	if (!tld_key_is_err(key))
+		tld_keys[TEST_RACE_THREAD_NUM + 1] = key;
+
+	snprintf(key_name, 32, "thread_%d", id);
+	tld_keys[id] = tld_create_key(fd, key_name, sizeof(int));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[id]), "tld_create_key");
+
+	pthread_exit(NULL);
+}
+
+static void test_task_local_data_race(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	pthread_t thread[TEST_RACE_THREAD_NUM];
+	struct test_task_local_data *skel;
+	int fd, i, j, err, *data, arg;
+
+	skel = test_task_local_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
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
+			arg = i | fd << 16;
+			err = pthread_create(&thread[i], NULL, test_task_local_data_race_thread,
+					     (void *)(intptr_t)arg);
+			if (!ASSERT_OK(err, "pthread_create"))
+				goto out;
+		}
+
+		/* Wait for all tld_create_key() to return */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++)
+			pthread_join(thread[i], NULL);
+
+		/* Run task_init to make sure no invalid TLDs are added */
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_init), &opts);
+		ASSERT_OK(err, "run task_init");
+		ASSERT_OK(opts.retval, "task_init retval");
+
+		/* Write a unique number in the range of [0, TEST_RACE_THREAD_NUM) to each TLD */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
+			data = tld_get_data(fd, tld_keys[i]);
+			if (!ASSERT_OK_PTR(data, "tld_get_data"))
+				goto out;
+			*data = i;
+		}
+
+		/* Read TLDs and check the value to see if any address collides with another */
+		for (i = 0; i < TEST_RACE_THREAD_NUM; i++) {
+			data = tld_get_data(fd, tld_keys[i]);
+			if (!ASSERT_OK_PTR(data, "tld_get_data"))
+				goto out;
+			ASSERT_EQ(*data, i, "check TLD");
+		}
+	}
+out:
+	tld_free();
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


