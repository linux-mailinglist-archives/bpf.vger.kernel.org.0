Return-Path: <bpf+bounces-49823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EBA1C7BC
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07E01887565
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706A146BF;
	Sun, 26 Jan 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="eYsALRRH"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2725A62E
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737895665; cv=none; b=VhRhns1es95oKpkP7vTl2Alyhr8CZPzXKvJe/+WCWlzcp35QJWrcVRwNgFfU4DQsjAaMTrU9dii2JLms2o2350wDv3Ovek9vQKaQZzSOKWqj3qDskKersMvJoP+g/U0uSeX7XCR432YdQN5nB15IE9k8T+jz87pg/ssktWfIoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737895665; c=relaxed/simple;
	bh=2NQFRqjEfpotVZ3Q1enwFzoWwPj9Bx/64TC0OWvDNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpPsOEoWgweUeZpISEqcSxL8fkHeihgX6d8KfSEhM0IUfOM0L5szJpwSBJFjDfSxhO57ZJNRQf+gDLYkKwhJGVKt14qDu6lPMlzxjqrzihXhmrzQTtiPzRiWXglXgSOFoG6hHHk8WCcasTkI5fLOrGUWTcU+sBadz35W4EVtSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=eYsALRRH; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1737895661; x=1738500461; i=linux@jordanrome.com;
	bh=HG7NmkGE4Q8UUQeNmJUgfaTIop0wi3oa5KvZ9qE7040=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eYsALRRHMxzb+aOIRMWtuDMvLEPtjNqjUeM6I1UtOMet8wNzYtHzRHw4DN6qHnHJ
	 EAbPjNZPgNUXmd6FxMB/TTqyTmg7T9pEtr4nZ+H4hEf/8iWZS1pLnhmkhMgYmzoDT
	 L4VeNS2kxmRdSB5/wFHH+TJvSBJv6kCpmQC0wLV7k1xSb6v9DjzVlHma0DIKDiPE5
	 9iiEuQan2x/40s8l9h2CNZNJK5Cf5HODYKNcwoBkDhlO1UIozXWB5yjLPxGvIjNIz
	 cstKivbMMm4WRGky5I+qro/gmc75z0n9pv0tmTJNV/nwCwa1CqDMsmeD1fWe5k/RU
	 DibjuDV8BeFN1uWKLQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.4]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MYQD9-1tyM4c3gn3-00KmA8; Sun, 26 Jan
 2025 13:42:00 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>
Subject: [bpf-next v4 3/3] selftests/bpf: Add tests for bpf_copy_from_user_task_str
Date: Sun, 26 Jan 2025 04:41:47 -0800
Message-ID: <20250126124147.3154108-3-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250126124147.3154108-1-linux@jordanrome.com>
References: <20250126124147.3154108-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWTJwAxb+id7fL4BjntpqNqgIcH3atbrD3oI1oa6Wwi1d6Hyx/n
 lKkZz9WaIW6hdWXuQIfToU6jQ7r9jUY/Z282qG8W77kLRzmrZU8Ipr56QTlWv6R6S3jZVKB
 8Wyxk6oqj0v3bzG4hP5EmzYxFuISxQ2Mkow6tRBWS2Fmkma79c1kDVhrykFIDPdfo9kf9Ar
 Btt802nJ8WQe/RzefKF6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QBEUf+27ax0=;fL+3l6QhyGx68BbSyn32ng9uq8O
 JJAtTkt0U9JDREHS1RgZpXPaJdbbVDtt97gViF62ApQQIwtzfaGek/MLdHvNf747L/c6nr7tU
 l90gyidPExT0emwvdMKip/ueP/9pLya2NcpQlQ4KWZJWqNMIPutaxs+HXaLKvsF5yHDGyyaBs
 +VvzhoGN6ZnxUevJT3bNTQ9ejXklcZyv1S8tI50lxODRxA2+B/reAI7CFTl3Zb27DYTflnWtz
 hmp6HuOJvg4hA28MjC6qLcRRQgcP/CCOLyNTd0ejy7DICXt39x4SuJkto2Ba1OnuLttg7xKMf
 NZdCgTE3OKpbmqRLl5MYru4ml735EWU28mXPzSz7LfD0V6t+T/xTb3AOyb1jNPoKeh/og0eT3
 WDD6FX/sEjC4d1I3gbrCGdqcx9ViQmdIzi0p3utGYg7bdrxSEF6OG0UqN5S/WX7Uai2v8Mj5o
 0G7tQjpHpbfbjs1rJXdO3DGY46VJxGBmm0yGa2zivAU1Zl27luzxxRSwDHQsjA3UaKkuakAzU
 +E8l2kMOnZUG746mHSfwbyU9ponpl6phdc2aIejg2+2GStrZZdEwmiTLxtliPLWRb/uGLLEcO
 M9VHnqQgAyc9k+jnHX4PpVy1btRVrqHaXnNPHyVosCyXFLhlhj76aSZKnwNvwwrcDOM5ufPH4
 vr0A+4BK3UM8RuCzBsJNy8r0z6iXFyPNSRkC8332yKm8PvewuCyYi89Vma/0BSlQRRZ/27WR1
 yfUB8ieNtnqL2ho/Mf3TIN/7AwLP3HIy4g22Dzgg2Yzan6Agn77qbi2pRcPOTKo3zs5Ta8lhS
 V88Ev4qimoT5Lk4733hBEEBhUzZ+Gz/xmxn6rMQWqh1I8Pk+Lz0GxZqIbRB2MNDljR7zuXp01
 Gj8KCQZ3UcLAcqAsmbpr73Sx39zrf143160/tPsKn8XvZkKcwEWM7xMch3pFcaXdAa+vQmnr5
 ZQBtycWmnUqw0TG5aMunIuCkx7HQSp+f5LHZzI2Y4D7eDKJEoTF9HfFttIHhChnciNOF8cHAt
 gsPd7M4DEKLlyrOYbikoOTANTBXh/HJFrK3ZsWhsDOmkNtMfFeAFN20CqT/FpCibREF+t0YTC
 SnrAx32y66uwFqv8dkyk3iO8aLORi2TBqTmIqeqO29aDANHFjodgxDfk4q0fgBteMxk0G/GVD
 MUGxmky8xrlamOV2GW2zK+p2zoPq3AijET4ZlTOxF8sxYw4/TEJbZBliUbLw+73w/xMCtoDda
 OiN0kai8bzDWvroy2sGx0Wo4rA4CNBjzUA==

This adds tests for both the happy path and the
error path (with and without the BPF_F_PAD_ZEROS flag).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/bpf_iter.c       |  68 +++++++++++
 .../selftests/bpf/prog_tests/read_vsyscall.c  |   1 +
 .../selftests/bpf/progs/bpf_iter_tasks.c      | 110 ++++++++++++++++++
 .../selftests/bpf/progs/read_vsyscall.c       |  11 +-
 4 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/tes=
ting/selftests/bpf/prog_tests/bpf_iter.c
index 6f1bfacd7375..add4a18c33bd 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -323,19 +323,87 @@ static void test_task_pidfd(void)
 static void test_task_sleepable(void)
 {
 	struct bpf_iter_tasks *skel;
+	int pid, status, err, data_pipe[2], finish_pipe[2], c;
+	char *test_data =3D NULL;
+	char *test_data_long =3D NULL;
+	char *data[2];
+
+	if (!ASSERT_OK(pipe(data_pipe), "data_pipe") ||
+	    !ASSERT_OK(pipe(finish_pipe), "finish_pipe"))
+		return;

 	skel =3D bpf_iter_tasks__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;

+	pid =3D fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return;
+
+	if (pid =3D=3D 0) {
+		/* child */
+		close(data_pipe[0]);
+		close(finish_pipe[1]);
+
+		test_data =3D malloc(sizeof(char) * 10);
+		strncpy(test_data, "test_data", 10);
+		test_data[9] =3D '\0';
+
+		test_data_long =3D malloc(sizeof(char) * 5000);
+		for (int i =3D 0; i < 5000; ++i) {
+			if (i % 2 =3D=3D 0)
+				test_data_long[i] =3D 'b';
+			else
+				test_data_long[i] =3D 'a';
+		}
+		test_data_long[4999] =3D '\0';
+
+		data[0] =3D test_data;
+		data[1] =3D test_data_long;
+
+		write(data_pipe[1], &data, sizeof(data));
+
+		/* keep child alive until after the test */
+		err =3D read(finish_pipe[0], &c, 1);
+		if (err !=3D 1)
+			exit(-1);
+
+		close(data_pipe[1]);
+		close(finish_pipe[0]);
+		_exit(0);
+	}
+
+	/* parent */
+	close(data_pipe[1]);
+	close(finish_pipe[0]);
+
+	err =3D read(data_pipe[0], &data, sizeof(data));
+	ASSERT_EQ(err, sizeof(data), "read_check");
+
+	skel->bss->user_ptr =3D data[0];
+	skel->bss->user_ptr_long =3D data[1];
+	skel->bss->pid =3D pid;
+
 	do_dummy_read(skel->progs.dump_task_sleepable);

 	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
 		  "num_expected_failure_copy_from_user_task");
 	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
 		  "num_success_copy_from_user_task");
+	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task_str, 0,
+		  "num_expected_failure_copy_from_user_task_str");
+	ASSERT_GT(skel->bss->num_success_copy_from_user_task_str, 0,
+		  "num_success_copy_from_user_task_str");

 	bpf_iter_tasks__destroy(skel);
+
+	write(finish_pipe[1], &c, 1);
+	err =3D waitpid(pid, &status, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+	ASSERT_EQ(status, 0, "zero_child_exit");
+
+	close(data_pipe[0]);
+	close(finish_pipe[1]);
 }

 static void test_task_stack(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tool=
s/testing/selftests/bpf/prog_tests/read_vsyscall.c
index c7b9ba8b1d06..a8d1eaa67020 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
@@ -24,6 +24,7 @@ struct read_ret_desc {
 	{ .name =3D "copy_from_user", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user_task", .ret =3D -EFAULT },
 	{ .name =3D "copy_from_user_str", .ret =3D -EFAULT },
+	{ .name =3D "copy_from_user_task_str", .ret =3D -EFAULT },
 };

 void test_read_vsyscall(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_tasks.c
index bc10c4e4b4fa..d28d642a64c3 100644
=2D-- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -9,6 +9,13 @@ char _license[] SEC("license") =3D "GPL";
 uint32_t tid =3D 0;
 int num_unknown_tid =3D 0;
 int num_known_tid =3D 0;
+void *user_ptr =3D 0;
+void *user_ptr_long =3D 0;
+uint32_t pid =3D 0;
+
+static char big_str1[5000];
+static char big_str2[5005];
+static char big_str3[4996];

 SEC("iter/task")
 int dump_task(struct bpf_iter__task *ctx)
@@ -35,7 +42,9 @@ int dump_task(struct bpf_iter__task *ctx)
 }

 int num_expected_failure_copy_from_user_task =3D 0;
+int num_expected_failure_copy_from_user_task_str =3D 0;
 int num_success_copy_from_user_task =3D 0;
+int num_success_copy_from_user_task_str =3D 0;

 SEC("iter.s/task")
 int dump_task_sleepable(struct bpf_iter__task *ctx)
@@ -44,6 +53,9 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
 	struct task_struct *task =3D ctx->task;
 	static const char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
 	struct pt_regs *regs;
+	char task_str1[10] =3D "aaaaaaaaaa";
+	char task_str2[10], task_str3[10];
+	char task_str4[20] =3D "aaaaaaaaaaaaaaaaaaaa";
 	void *ptr;
 	uint32_t user_data =3D 0;
 	int ret;
@@ -78,8 +90,106 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
 		BPF_SEQ_PRINTF(seq, "%s\n", info);
 		return 0;
 	}
+
 	++num_success_copy_from_user_task;

+	/* Read an invalid pointer and ensure we get an error */
+	ptr =3D NULL;
+	ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1)=
, ptr, task, 0);
+	if (ret >=3D 0 || task_str1[9] !=3D 'a') {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Read an invalid pointer and ensure we get error with pad zeros flag *=
/
+	ptr =3D NULL;
+	ret =3D bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1)=
,
+					  ptr, task, BPF_F_PAD_ZEROS);
+	if (ret >=3D 0 || task_str1[9] !=3D '\0') {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	++num_expected_failure_copy_from_user_task_str;
+
+	/* Same length as the string */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str2, 10, user_ptr, tas=
k, 0);
+	/* only need to do the task pid check once */
+	if (bpf_strncmp(task_str2, 10, "test_data\0") !=3D 0 || ret !=3D 10 || t=
ask->tgid !=3D pid) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Shorter length than the string */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str3, 2, user_ptr, task=
, 0);
+	if (bpf_strncmp(task_str3, 2, "t\0") !=3D 0 || ret !=3D 2) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Longer length than the string */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, tas=
k, 0);
+	if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D 10
+	    || task_str4[sizeof(task_str4) - 1] !=3D 'a') {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Longer length than the string with pad zeros flag */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, tas=
k, BPF_F_PAD_ZEROS);
+	if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D 10
+	    || task_str4[sizeof(task_str4) - 1] !=3D '\0') {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Longer length than the string past a page boundary */
+	ret =3D bpf_copy_from_user_task_str(big_str1, 5000, user_ptr, task, 0);
+	if (bpf_strncmp(big_str1, 10, "test_data\0") !=3D 0 || ret !=3D 10) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* String that crosses a page boundary */
+	ret =3D bpf_copy_from_user_task_str(big_str1, 5000, user_ptr_long, task,=
 BPF_F_PAD_ZEROS);
+	if (bpf_strncmp(big_str1, 4, "baba") !=3D 0 || ret !=3D 5000
+	    || bpf_strncmp(big_str1 + 4996, 4, "bab\0") !=3D 0) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	for (int i =3D 0; i < 4999; ++i) {
+		if (i % 2 =3D=3D 0) {
+			if (big_str1[i] !=3D 'b') {
+				BPF_SEQ_PRINTF(seq, "%s\n", info);
+				return 0;
+			}
+		} else {
+			if (big_str1[i] !=3D 'a') {
+				BPF_SEQ_PRINTF(seq, "%s\n", info);
+				return 0;
+			}
+		}
+	}
+
+	/* Longer length than the string that crosses a page boundary */
+	ret =3D bpf_copy_from_user_task_str(big_str2, 5005, user_ptr_long, task,=
 BPF_F_PAD_ZEROS);
+	if (bpf_strncmp(big_str2, 4, "baba") !=3D 0 || ret !=3D 5000
+	    || bpf_strncmp(big_str2 + 4996, 5, "bab\0\0") !=3D 0) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Shorter length than the string that crosses a page boundary */
+	ret =3D bpf_copy_from_user_task_str(big_str3, 4996, user_ptr_long, task,=
 0);
+	if (bpf_strncmp(big_str3, 4, "baba") !=3D 0 || ret !=3D 4996
+	    || bpf_strncmp(big_str3 + 4992, 4, "bab\0") !=3D 0) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	++num_success_copy_from_user_task_str;
+
 	if (ctx->meta->seq_num =3D=3D 0)
 		BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");

diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/tes=
ting/selftests/bpf/progs/read_vsyscall.c
index 39ebef430059..395591374d4f 100644
=2D-- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -8,14 +8,16 @@

 int target_pid =3D 0;
 void *user_ptr =3D 0;
-int read_ret[9];
+int read_ret[10];

 char _license[] SEC("license") =3D "GPL";

 /*
- * This is the only kfunc, the others are helpers
+ * These are the kfuncs, the others are helpers
  */
 int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ks=
ym;
+int bpf_copy_from_user_task_str(void *dst, u32, const void *,
+				struct task_struct *, u64) __weak __ksym;

 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int do_probe_read(void *ctx)
@@ -47,6 +49,11 @@ int do_copy_from_user(void *ctx)
 	read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
 	read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), user_pt=
r, 0);
+	read_ret[9] =3D bpf_copy_from_user_task_str((char *)buf,
+						  sizeof(buf),
+						  user_ptr,
+						  bpf_get_current_task_btf(),
+						  0);

 	return 0;
 }
=2D-
2.43.5


