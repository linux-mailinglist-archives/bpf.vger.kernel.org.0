Return-Path: <bpf+bounces-51056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43724A2FCF1
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1413A413C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802D2505A4;
	Mon, 10 Feb 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="tf4ri1w2"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC8264609
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226174; cv=none; b=mmMMl6XQNRFE/Iv2bzg9E3g/A2r2+JQ+7VZtEeYmOXnAIbVxJDnXaNfHmk87bp1eax8eLf6lBHI2tK56Ra34ny9oj0YF8HmYB5YckZ3k9t2+ymd2eiUaRfkkLeV5BhAdpo3RcF4wU5wrAIqr8FFEfJr17ssdNl5zOK+6PoPWQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226174; c=relaxed/simple;
	bh=sC2j8xRGHe7nr+QNZ5ZANfcvHGfTRLLs3oKofC73OZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8knAp5nkCKC029ltXuLDb3Uj9M1327KeQ3WkV7GQbYe9iFScaGK9Ve5Kd/iW+fRMu1jIybbvsuJ7Wv9Abxa1EFGDfhcpb8vUu6BaEAd6ZMC8USXpZ7la+fH7vyXCJjRek9daU2dHdaXnY2I3RUfD05PaI7TejWG0VKM1vs6hsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=tf4ri1w2; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1739226168; x=1739830968; i=linux@jordanrome.com;
	bh=LhJJH5WuMX5aq6LX3M5eXAA/nYkW+PydFm8hbRxet3Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tf4ri1w2C/qJmnvGD1iSsNWkNnlIa+yLWezihtXNGXR06x5Tn1Dkap1yUqo91LOM
	 Y7SZ0lLbvK9Izi6fUNOU8eXEfctnrcrShtX6P0fyn1tBi4XRru9TxBsD7P710u/PF
	 iuFEh2+j7dDjpwJ6oKL26tnIMCQ23M1SyVlqfdoPww3eec4Hj/5eK5H/IxTZAENUi
	 cg0QMgC34ClUUGEuBGFJzfwEjqupcEzN3i4mKqXHxVDf3mbmWmuJFLRPQLAlmvqh1
	 u0oxBVsIj0o43+Q9eNLXdIZUg0PjPuFfY3KWR9S0Z84BvJFJ0J4tKGVGCiAd3p590
	 OW6+iQx809EMTlzjgw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.8]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXJY3-1tw4Xl2evN-00WYTR; Mon, 10 Feb
 2025 23:16:40 +0100
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
Subject: [bpf-next v7 3/3] selftests/bpf: Add tests for bpf_copy_from_user_task_str
Date: Mon, 10 Feb 2025 14:16:26 -0800
Message-ID: <20250210221626.2098522-3-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250210221626.2098522-1-linux@jordanrome.com>
References: <20250210221626.2098522-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rodj2MYcuAbXFChH1oH6zsmF7imrjIQv8jjEaoyBkAjNHKmW9ts
 1bmnnXCS0Wvj7gGViaayE/+897AdXvzD6W8sNnWtz3CmIAQsbB+guqKq/c+gFcqWPZMd0ei
 +ebdl9g75+L6TdDY4HP5u6J7wmX68ZPgmgKKSqmutCaReZCPYlOV7qEVYF7yZoBhrzkwHgj
 gixScR+f+Xo3trU4r6RiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EQfHNllidnE=;F9Ne9M5Bcb+F6FKfhZTBVCmfKyp
 eQwgHIERzRPN82Ng3bTDDPnoCw8U74vOrwakGPApdFqL4HhcqiwOkaXfICmDjIK+h3l8KV0dl
 AVOHUT62+h7ohEfAwHPuN+kW19GUm8miFSphuPN6pWhZWG9LEBYOREx+H1a+DyWM/3DijPS8j
 PWVQ/UkceUrL95OLf3EoimfAj070Ui8P2g5m3DMkdBg4kD27dN4M70uGv1rM8LZVq4dcX2qBw
 Rd6k8J9vLrQFU+I49SspJm4bwG2Pw4j+X8qtNZYlVCgGgEb/NtCTAXIUjHTSeFWYH4h+E+yie
 GL6v9xCOQBkbtOci1WxDFh8WxrJPm4VlLIOd/JWBiNRtEFP6Q/19tZxaBrRHyiCoYvAkx5mPS
 eyAdHZKaUD3lNBRfs9FASkP1AgCIO8E0h93D8b+j11gzqeo+Zr/WbJvKp452xG4klJ5COXnF7
 YGPKMWnATYR5bBKHfaXQqCu2bq/0vU22K7wbpuPyJ78Ys8fbjJP4N6JLnKUrjkhiJstymkSPe
 4isbbvTPqc/Pf0/OUWElOd0TYX15kWYSzwAJfnPK7UKU7TGtgbAukX31xfdmbjWeiq23kJLm0
 9bpxM7me+mhEutN/HzhZN9fU0dFGGoWYHLygEC6hrzBWxGmZJku4AEMJ4AojluQPbLFkT7Ipw
 XQ3dN60mVEx8SvL1ywLZULrgNDJ6UDHaJ6fLqo7qk7r6BoZNofKYNMLw4PKZO7TdyHzikdxhi
 6yDKMSKJIdbFiI+2dmdqYBsxzhtq5VVJ+2YHLmla6GD3fAMrL1QC4A3+CichGMYWpBheaYndU
 HUTsr+KM/v3pOTYUtI8t9lhRLTLPNnWR8OCb61/0UQx9XRLyfIfaVGp5mqlvVIOuFvzJ65c+/
 Q0p0scwsjQt/DkxHVP+WPLnaXAXZCGdVgLJxQFbahqytoVxJLtXtogQhd9DpBXggZLpJj0z4/
 tZxDcXcBzRF0O1ozE9S3dvA7YXpwlYQpXlDQAqW20lQ+U6LOpdnBqfR4fH4Gh4Mo2khu6zxsc
 PYLSUVjWaJRVDLhl7kfhIfq53sTDB5eZCIPxfW9ZfMSmiMn5Ttx2+EtxAG8gvX5+s/UKV3NMr
 OT/A5HJW/9M5RQfbppa2Iy/ngnRbBXhZw/Z94mPmqnXAAc/MQV8kY2/a6BZITBwFQjzMOXWxe
 G5GDx+YwiNT2M20vUxx1Hjt47HLhEHYAtg2BuR1CaUiK3rsSS1pE0iUJSS8Bq6AjE/Xsrqt8q
 Km+cggIGcQBskbzEkeLCzboIILNEaUJ4DR0Mx7Q8/f7dbL2efMHsMwrtlA0cPVxkaOdRBdHTE
 zRSmSw2ICW0epxnTRiI0l08FOWJyVl6RHRyvm7/C9wd31I=

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
index bc10c4e4b4fa..966ee5a7b066 100644
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
+	if (ret >=3D 0 || task_str1[9] !=3D 'a' || task_str1[0] !=3D '\0') {
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
+	if (ret >=3D 0 || task_str1[9] !=3D '\0' || task_str1[0] !=3D '\0') {
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


