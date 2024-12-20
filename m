Return-Path: <bpf+bounces-47463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069B9F9A0A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DCA1885E59
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FE2206AE;
	Fri, 20 Dec 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="CC4DnTE1"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435621E087
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721901; cv=none; b=CXqE6dLIgNRSBAmRHVsilCHUgfBIXEFFvS9wypWKwNacFtMlXEfz+vm7BsL+uXt71mDUV+CHcnGmQgTZEeEbD8oeqJiya5oo9dYZpMC4Shnhguh8kGG1cfPGfFbrQC6uiDjUUi8e58pCkawUVx3f0Sjw+DIQDr8HIGYzVWtGU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721901; c=relaxed/simple;
	bh=ZDx92FCNvaaNTqkZp0+dbn9tgRERr2CZHcmu8V5PG4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn9/faW9xMdBKHZW2MB5mUEoFDi/vbn/R9jKhP26YZX80UgJRZnT8Zes74tzL4EM7XfpW2WjywyCJwUL6njv/5O0mOcJKfg6WqeK+Oym53ZRbhUOOVA9cE2qwLFODwOqT3lHgbxoiPNuuiig4oGbHIax+bhfmfGuyJaPhMGfHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=CC4DnTE1; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1734721867; x=1735326667; i=linux@jordanrome.com;
	bh=bFV8AAWE7WB5PNv7bnDePrI5cbphl4Nbhj6dGOr7osY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CC4DnTE1mM2LbQBIQhERFew8CVlNAxULDVF+pQaFgIZryJhuemZrhYMqHDa3tMY0
	 9z3HLZ9fCM2ktP16slBwbFMHReL7+6kqofQrWiWThmL8wBexYRpiWiC/xQcTfC8Qj
	 SeytwB1a+wGEW4eDj2TpFURu+TqLS8DCtiGt5cMbTYOLpjDVcGz9URm38NyvzBQ5F
	 PK6c5FcS3hXR0j9/FoFaUrTdUmF0/vUimctiO0PeG22ymmITr9V3GRt+qg5y7FK3o
	 wxJeTwXO+HE3VAt+NlrVu3Zu8/J80uTCt3j/ziLsHTNUNz5raRs6ZVxsLYhhfvnhF
	 Eiaug/a8krf1K2qTGA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.17]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Ma1LU-1t1bUV2Q0S-00RY6U; Fri, 20 Dec
 2024 20:11:07 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [bpf-next v1 2/2] selftests/bpf: Add tests for bpf_copy_from_user_task_str
Date: Fri, 20 Dec 2024 11:10:52 -0800
Message-ID: <20241220191052.1066250-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241220191052.1066250-1-linux@jordanrome.com>
References: <20241220191052.1066250-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3YPzK3zH6uRLIxMDY+gj/1+UrBpP5upetgT6hfo4xmcWEzocgo/
 tslmhoR9p1bjy2bffimY5c2GKXLEGscp8XhmjJ+IyxDjCO0i2D7pz//XtQ9i6IpaFG5Dhzr
 vehsUzjvzHlX+e1ALeAaiB47s+NP8BDb4OetI10lpBEw8iOtvb2Sk/JatRB6gn/3FjpB8Us
 ZPy46vdJE8hDZ6q7Tv7KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sdbn4NDl3Bc=;BI4Ci9PneXHWXw40oIXSJlsmzmF
 oiJC9L4yCxSEVlTvUJ42fVmANeyRZdfI/qmtHdFNbTrFDKna4QKhOn98E8ijN86yeL7bEZs5j
 YXVuCe65pywYtxBf2oWKyznDJD++1FCmB6JjDAnB1Tmueiu6DvFV2YFFeu+x5eY7gZLfgD5fP
 38lh5idbTWwLjRJ75s37rSdjZcIcdyg7A83RmAIwQYaEquFRU6L/jCycCb+V41tYwEj+QDcM/
 XAzV1HK6wNJN+h5VK7+RotKVn0H8T8Kb93w4g8BvIMOz0yoe/nmUM0/yYpjnkW8BZj+b2d4ze
 JhT7cgUs0XcjopZfK/RBErTWDbFRIcUFsCtrpgzJQP8Gf8R1dtlwaSg38CN5RSVy4psEMw3RV
 MFGEsIgxbXYfy4AptS3NCTGcyzAieM6yPXiDXLlmeEg3KhNyIHVfuXEKecW14yQVZKC+/HtzJ
 rqp6a9QQPpQzh6XqX+SIbMdJzCQ/H0Rf2B8dOQ20hby9uunOqu7c1tPyPMzK5y0Tsq9gB9dz1
 7kZgOJhLfOqxD36bJX2sQX+QU/P3AsYomkpYd6pvPd4NMMw3jsYlBvre73Mg7EhkN3yvuiJBg
 a9E7TOZdxrLlygBj6iPWVOEH1JSuHClCG2a8EKTLJT1jMTOYF+b9CByRuBUZpElR1YRD0t4Px
 OMQ0lZyNl9/1sfCURcumh8PiKOaxS0ncZHFQC/PlTNYvLD9wwgUQzjuqcMW8YacAR18fsSvhP
 s9IBpsl1NVa2BHf4dxhf/hKBW4+DKKCWCGEag5UKyTwIBkrMkWXamm439EYtjV9WiRnJTubXz
 0v3dDABBFjpIFgR23gMAhjEX2fFbN49A+8aYFBYOtRNdM6AjHzsgDePa0LqG/MBb4+TfrqqUT
 bMAyZmqGNkKUfk9CxiDEgwAKQrglS7mhhqGLIf61KxAjBFMsJ1Mo9QQI3OGR2GifqeXye6rOu
 QufN0RtuMMU6VCGvyGobsQgZT0Z6r3V1GD/XZWBFhhxBBafIO0s8bukTzAOZiqwyTo0aq3NmG
 /0/tWnKUzRFK+WjeIZg00zxJ9Gp7VT8WSeRhX1X

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


