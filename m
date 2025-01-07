Return-Path: <bpf+bounces-48041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89690A03513
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 03:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FEB3A60FE
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E08139CFF;
	Tue,  7 Jan 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="2qt4ZKjI"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC814B087
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216459; cv=none; b=YYkjtcn+RReIqeNC7KR9YIJVziU7p6RnKp5RqZpBnfXzv0mnTARgDf7M9U1joa2sIsSrvZuz4JlauGThMA2SdDNoa2zfsntv0a2afKBOtaYWhOpYkt3KZ0c5xf3qdvVXp3eo4HdJ3OtJDV/rujOzZfSaCa33GFUZegTBAw+mlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216459; c=relaxed/simple;
	bh=ZDx92FCNvaaNTqkZp0+dbn9tgRERr2CZHcmu8V5PG4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9JdYq70uOWPlLv+mx/iR92EUq1+mP3Lsh9eYI5tfJ88Ei45v7csOUYezMZQeskVg0JzexdQD7/vXkxmeJKkol66mGyjEGXWop7amC/TYQHFTwqoynhUjoyTk6WQEh8nFFJUuICMzoXguqC5H+8HbYiLxdldJXyiekZjE+MZrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=2qt4ZKjI; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1736216451; x=1736821251; i=linux@jordanrome.com;
	bh=bFV8AAWE7WB5PNv7bnDePrI5cbphl4Nbhj6dGOr7osY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2qt4ZKjIv2ZksVlyZ7QPn+ytRBgd2e094acnTqeTFfO4h9m1Bvv9oHh1ntHwV6X2
	 ZhC7jzuJZ7uN7opotwpu94wVZMi293Kzk1Ms4koYefO2bBEJ6d/HrG3a7NXT7Q9Wh
	 ZgRE1xKp+d80hMgyQtfS1h86BRYkMSK/HX6jCUPSa45I/th3MgwOr2eHU8rZqocP6
	 NP+Q5Bxm42/Y9QN+y006mtS/b9X3owTG+3R8m3nkhQ0uLav94g8/VSBaAJ5iRyA1s
	 QczgWkKyRNMvRyVnGhnMuge3JpxHr9XyAl60xP8nK//oYZobLcr215C6lfDal171s
	 mFiehsPZgVcEjkffhQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.1]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MJmjN-1tBWKk0mAT-00OUD6; Tue, 07 Jan
 2025 03:06:47 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [bpf-next v2 2/2] selftests/bpf: Add tests for bpf_copy_from_user_task_str
Date: Mon,  6 Jan 2025 18:06:32 -0800
Message-ID: <20250107020632.170883-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107020632.170883-1-linux@jordanrome.com>
References: <20250107020632.170883-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1J9yVCZQ2NAHDr9yT0npIqJaYWAKXqcpvuue9cvHHU8bECyraFe
 TJN/mIMwB+l2oA2KtEmxyhlhfmONio2neaoKrXUeqWFW0cWVjQGKVV99WHFx5MuJqNjbCUh
 ePNCDTUCIxTBolx7MOtLZWg1guUOd7cFtHjx9su9Vg6ubPsY5q4TxtpDi9NmGX4P5bLW+3C
 PfKn7TtlYwsdPWUi5bQZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DwVnFgOqoBY=;eSP4JiBj9Knh/6QvamAu51cJkky
 eljl8MORGbL6bgpq8gXAYXweVcvZEwqVUZIDGfaVoD7HBt1IQax3dYQU0HJMkOAXYZ5iwxKiy
 F4uSbxosWTIkndaJe43LUOg99+8oreln3Twdt+wWnd36TUQdnUIjk3fz+9vZAFYIDos6rI8x4
 fBGR2+rNB4EmU3D8QOWaD+fusWO0x/g6FCVnV7SsSCT755VHTrrfhQnSrpmvG3yrxZ62lW1ak
 1gUqimO7Zd7NqfzV7EDffIvP3i9hz1X9yVTJF227yb/7xj86bznrLpFzHEvBm3SdlcwTkc3zV
 oreqgdLfHi7u50qSTfALwjVGTtTjryGIhMDF1WxesWvfbonV3ZKtXNA7WB5JxSjcl4i4vsGax
 BCpLYD+1Qh3OvIxA65Lo6qfgoLRj4Mh+4ybIBGzyauszWSsB1tGIRCoLIbOwSU49Hda0+BJrH
 Js+5uHmdgCElOTg2Pi9a4eFmRBTOWKbmdWXMWLxHugDEIODKe+/1EmTr4xELr62cS+HlSdlEC
 Pijq//aIpwJQUy9yNgAI5/Bzy/xP6oi93TnKIFZGvAgUG9ADkZXRf7HpUixawt7jEPWn6pNhW
 2Zw7lpXmZSXHkWAWd1QeE5b3OVuNabuhBhvR7C7i88cgyh5E4ZbErAZ/gmOu/ASlrWDDiAfQf
 5g5GpN46nEJa+vqTZdsET0Eg2MzXQTCfpGg7h3vGCORGhHDPaHPaQV2tUGNN0cYj5KMs5yqZN
 oRrN3WComWqYCFgbffYrP3mIprORC6voVv5zrYnZxTo34I2q+bZMaTcSbntVPFsJB4gWuhNPW
 FFOyNgbMWj1IwwIsEgf/LPEWvuR/3wzFvJb1faHMCiECKGxSTfsYEfx+lwiJe7JpEpv1FEh3J
 tDVtZ+ZhddCHeRWQ/JA6pj/jTX3g+5NWL6oemNBgKnO8CxwkPhqFslefZXXdLhwz5vzFbX9kc
 MyHpU4dGHLoGcBnZci3Uy0V1WT8PV5jXy7L2cDsjCJw2nEgAKyWQdrJvkWpDYpNJOlyBTUHhd
 /NBnNkYO/nhnmT64l0v8cGgduK0lUb7BEepe0qM

This adds tests for both the happy path and the
error path (with and without the BPF_F_PAD_ZEROS flag).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/bpf_iter.c       |  7 +++
 .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
 .../selftests/bpf/progs/bpf_iter_tasks.c      | 55 +++++++++++++++++++
 .../selftests/bpf/progs/read_vsyscall.c       |  6 +-
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/tes=
ting/selftests/bpf/prog_tests/bpf_iter.c
index 6f1bfacd7375..8ed864793bd1 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -34,6 +34,8 @@
 #include "bpf_iter_ksym.skel.h"
 #include "bpf_iter_sockmap.skel.h"

+static char test_data[] =3D "test_data";
+
 static void test_btf_id_or_null(void)
 {
 	struct bpf_iter_test_kern3 *skel;
@@ -328,12 +330,17 @@ static void test_task_sleepable(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;

+	skel->bss->user_ptr =3D test_data;
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
 }
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
index bc10c4e4b4fa..90691e34b915 100644
=2D-- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -9,6 +9,7 @@ char _license[] SEC("license") =3D "GPL";
 uint32_t tid =3D 0;
 int num_unknown_tid =3D 0;
 int num_known_tid =3D 0;
+void *user_ptr =3D 0;

 SEC("iter/task")
 int dump_task(struct bpf_iter__task *ctx)
@@ -35,7 +36,9 @@ int dump_task(struct bpf_iter__task *ctx)
 }

 int num_expected_failure_copy_from_user_task =3D 0;
+int num_expected_failure_copy_from_user_task_str =3D 0;
 int num_success_copy_from_user_task =3D 0;
+int num_success_copy_from_user_task_str =3D 0;

 SEC("iter.s/task")
 int dump_task_sleepable(struct bpf_iter__task *ctx)
@@ -44,6 +47,9 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
 	struct task_struct *task =3D ctx->task;
 	static const char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
 	struct pt_regs *regs;
+	char task_str1[10] =3D "aaaaaaaaaa";
+	char task_str2[10], task_str3[10];
+	char task_str4[20] =3D "aaaaaaaaaaaaaaaaaaaa";
 	void *ptr;
 	uint32_t user_data =3D 0;
 	int ret;
@@ -78,8 +84,57 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
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
, ptr, task, BPF_F_PAD_ZEROS);
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
+	if (bpf_strncmp(task_str2, 10, "test_data\0") !=3D 0 || ret !=3D 10) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Shorter length than the string */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str3, 9, user_ptr, task=
, 0);
+	if (bpf_strncmp(task_str3, 9, "test_dat\0") !=3D 0 || ret !=3D 9) {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Longer length than the string */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, tas=
k, 0);
+	if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D 10 || t=
ask_str4[sizeof(task_str4) - 1] !=3D 'a') {
+		BPF_SEQ_PRINTF(seq, "%s\n", info);
+		return 0;
+	}
+
+	/* Longer length than the string with pad zeros flag */
+	ret =3D bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, tas=
k, BPF_F_PAD_ZEROS);
+	if (bpf_strncmp(task_str4, 10, "test_data\0") !=3D 0 || ret !=3D 10 || t=
ask_str4[sizeof(task_str4) - 1] !=3D '\0') {
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
index 39ebef430059..623c1c5bd2d0 100644
=2D-- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
+++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
@@ -8,14 +8,15 @@

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
+int bpf_copy_from_user_task_str(void *dst, u32, const void *, struct task=
_struct *, u64) __weak __ksym;

 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int do_probe_read(void *ctx)
@@ -47,6 +48,7 @@ int do_copy_from_user(void *ctx)
 	read_ret[7] =3D bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
 					      bpf_get_current_task_btf(), 0);
 	read_ret[8] =3D bpf_copy_from_user_str((char *)buf, sizeof(buf), user_pt=
r, 0);
+	read_ret[9] =3D bpf_copy_from_user_task_str((char *)buf, sizeof(buf), us=
er_ptr, bpf_get_current_task_btf(), 0);

 	return 0;
 }
=2D-
2.43.5


