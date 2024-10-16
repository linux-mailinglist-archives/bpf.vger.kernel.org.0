Return-Path: <bpf+bounces-42241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0F9A148E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C332842B1
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9191D2F46;
	Wed, 16 Oct 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="j9V4jSIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18A1D175F
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112494; cv=none; b=MLEVS7N0OXIDxGPXF3rIfaGJlaSTGc8B98bJSNUzMi4Q14F86niTIBsWI0ESow9WOh53XxwOR42fgLPERXHJe9vbT+ZnLdOWhJpwPRxYC+tugo0rv97JrwXWWCqZCwFcZWrGTwAemDlhscG6XU/S2WuBpdBEsYRnOC93FOTf45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112494; c=relaxed/simple;
	bh=egoEILchqN2+nW14V8v2e8QWemsaQvSxH+eKjOfE3B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzQuB3289TPcHUAhfSWKtyfhohLqYhPgczz2h7vwEUFqm8toQBtKwj/z/h5cRL4lMwPP2pZY8OU8+ncv6VOU+b3j8M9szedPjq5WFU1LTqdjtqgvOtb+svBjFr05VQ2D28CNmrNFYPGajWWNs4FvYbJup0p6J0urfr8UVebibLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=j9V4jSIQ; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729112466; x=1729717266; i=linux@jordanrome.com;
	bh=L0jvzN5FIznqHtYde8BnFrwdWYUFqZZtLXEJXLSXtCU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j9V4jSIQdjLyFkLN5yUkCEt6HKAKZUVfuTwffPK1c1xMNSSkoJKkRkl9Dj9m3GlC
	 0nh/rKBhtw/ZI/Dl6cW2tXHrVAhjftkCW2Lze+7WmyM5AmbV9USxuhs1NwseMVUTy
	 kVeRKJWzbyEyd6WAyfkuB35hUOfqKhzgmIucG9TrgFv++meTeWK1SJSd+W3QcBnEV
	 bhg8GvmGlaZhL2cG218+J2HZJMJZDR6B48L1PrTIvVQv6uxFrVmc7H6hF3pM8qlME
	 4alKRkAf5l6By1OuVVHW8vM0fXhDRZ/QeLwP93EA1W8orMG1ySKidIWIpULcAes+n
	 GtT36cIq6iR4Zrdctw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.113]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LufPq-1u0wk53lwm-00xxze; Wed, 16 Oct
 2024 23:01:06 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [PATCH bpf v2 2/2] bpf: properly test iter/task tid filtering
Date: Wed, 16 Oct 2024 14:00:48 -0700
Message-ID: <20241016210048.1213935-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016210048.1213935-1-linux@jordanrome.com>
References: <20241016210048.1213935-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oKqS+1ZFkNNoHdnGlUo2rmSsPrM2zb0Kpmr5+l8wwpcM/JIiz7e
 iGk+LpIWChDtdrK0K1HXmRBGwk9SUGSoXXi+hiv4HY3yjmWxLfk79dMOKqjQS6hZRtRbvWs
 rPHmAhNTDQmYfc3xREI2Q4I8ZK4eS8uAVThlgVDCtlhmR4SLcliUpzYDMoBUYUu0/TrBuad
 RV8vsrrJhyqffOIf35D+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F9J7QFOxcew=;R4qY2IPVyX4MLSZytMyOugZU/Rw
 3ehcmzT11ma4swSO5LO+RzeD0EV9NaCiQqKYbknkRSBQuTcXu2mrFPMW3ynsYLe8OhxJJSm+U
 2dhkb69xg22nKsbXHtFalXLjMsf9fbg2XiAs8xa7dIgiZSlHAbPcFncmyr1pdB5yZJGp/qfDW
 XNcUlR7nrxaKSBaVY74JqlSZG2oqtgx5XUSzYoobH5x02+y96yZUhYm8CldAx3m1EJ34ye/Wd
 SISeZWLAZjFpsVLlLSGrZUBlzeJqu0hdDnKDE730dPbWuJKoo7wU6pPLQxNPQi+0AWXEQs3ZE
 FlZLIaDZZ0QjnKpbzzx++IXWgl14Fk0jrv409tLzLiRSGnBsE8+I+b9B7FYSeuqIAhdBtHPb0
 O26c0aIums0T/tcVyYrvbvCUBuvoJclcnzLYN90J6HS/KNt3Hou4Lc/C4kng3HlNRpcKcKKvM
 WQgeRqit11Ofooc9KWppSGj7HzHLYgO/RP1II9giQE/vg4p1hAtFSARMXDTyeGKqEYLchlt0N
 UT2JjITcTiN2B5jEde5AIH3LNGtu1EI9j7Zg0oszoz6g9ZrqhthJjJxLfxI3picRBWiRpGRan
 uTcnY5osVdqtkAuDDsCKkjg4//8z9pT6iump8aReXOk5LS8cAUzsjzt6Dq3c6z3hAhJtwjz0L
 4G+XT6RkYlsYOLwsdizwF2IQJnMkykSNHfqPkESQZj/N/Nhycx/w7LDY6ebXNJTcMRFTZJ/fv
 6dHgD+F5N70ph+qblZw55feYtOr1CpOnQ==

Previously test_task_tid was setting `linfo.task.tid`
to `getpid()` which is the same as `gettid()` for the
parent process. Instead create a new child thread
and set `linfo.task.tid` to `gettid()` to make sure
the tid filtering logic is working as expected.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/bpf_iter.c       | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/tes=
ting/selftests/bpf/prog_tests/bpf_iter.c
index 52e6f7570475..f0a3a9c18e9e 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_a=
ttach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");

-	skel->bss->tid =3D getpid();
+	skel->bss->tid =3D gettid();

 	do_dummy_read_opts(skel->progs.dump_task, opts);

@@ -249,25 +249,42 @@ static void test_task_common(struct bpf_iter_attach_=
opts *opts, int num_unknown,
 	ASSERT_EQ(num_known_tid, num_known, "check_num_known_tid");
 }

-static void test_task_tid(void)
+static void *run_test_task_tid(void *arg)
 {
 	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;

+	ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");
+
 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid =3D getpid();
+	linfo.task.tid =3D gettid();
 	opts.link_info =3D &linfo;
 	opts.link_info_len =3D sizeof(linfo);
 	test_task_common(&opts, 0, 1);

 	linfo.task.tid =3D 0;
 	linfo.task.pid =3D getpid();
-	test_task_common(&opts, 1, 1);
+	/* This includes the parent thread, this thread,
+	 * and the do_nothing_wait thread
+	 */
+	test_task_common(&opts, 2, 1);

 	test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
-	ASSERT_GT(num_unknown_tid, 1, "check_num_unknown_tid");
+	ASSERT_GT(num_unknown_tid, 2, "check_num_unknown_tid");
 	ASSERT_EQ(num_known_tid, 1, "check_num_known_tid");
+
+	return NULL;
+}
+
+static void test_task_tid(void)
+{
+	pthread_t thread_id;
+
+	/* Create a new thread so pid and tid aren't the same */
+	ASSERT_OK(pthread_create(&thread_id, NULL, &run_test_task_tid, NULL),
+		  "pthread_create");
+	ASSERT_FALSE(pthread_join(thread_id, NULL), "pthread_join");
 }

 static void test_task_pid(void)
=2D-
2.43.5


