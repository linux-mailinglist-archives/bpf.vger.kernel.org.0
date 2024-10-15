Return-Path: <bpf+bounces-42091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3598799F5DA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB51C23A08
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DA2036E9;
	Tue, 15 Oct 2024 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="cFN923pM"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D32036E2
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017671; cv=none; b=JJTWSkPAxmxfSZiHcokDCdEETuQ8c23/C/YjwsM0naRGioNEECVbhrY07D2AlNdfJ+y8SFiq5nrM2+VSL4/h8Na6UeHl2Be4NzXIxETHrW8HyPm4MS+p9GYl1nXAeMUVuQ+FqrYEQNHvCoZEkUxGQ08CAK9hhPBQa0GQ2Sk8pmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017671; c=relaxed/simple;
	bh=/3ox40/rLt3HOkLdZWzlytXef7ZXeW0sXMlwN/+DJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk5C58/Es7SThjH2Piom3nVxQJ66cJrhSs7fUKv/iQJmetazXX+ns6ddOv4WTYxHLNjsfmO8Cl+eJEPPyb3MB8F6Hnoi/02pKT0gH76yCDR40JIyex9hg4cZchEgYS0vUfNHnCSttyegQ1n1koCNnVdqyr7nDholaMr9XWg2IBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=cFN923pM; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1729017665; x=1729622465; i=linux@jordanrome.com;
	bh=ZR/UjnhL4ZD3/tWrnCmzIQMxkPXISWKfS0nqMBrEGns=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cFN923pMlryexQrmfeffgsn/Ir1HhjzV9H55mH14vdXg1/S6MgPD0jIJnEUtVVCO
	 GdUBd3R4uVvt0xbxmNoNUYm0pS6ubbo58Wxs4JCxRd0IQxlekWCrS2Ym0mETGSQdy
	 zhBNMx9lT14tEJXyDHDtm8GUFCuVkHEB3idKQT5DNzk4zvYx/7ERcSCwrHEJyY8TN
	 D5SeGFw8unAybMZp7G+3F8W7qlrdf+D7zgX8vOfrs11F02NQUfZKZyq9GK/r0kr7O
	 5XzicVGVRCynsZcfFlyDPJccKX2dhtg1CcqL8J4nboCKDOtUkZH3xiQt+xxdcyFlH
	 PfDE7B9c/uBz2rz3Vg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([69.171.251.19]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M55Wy-1ts2sP1I2Y-010k5X; Tue, 15 Oct
 2024 20:27:23 +0200
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [bpf-next v1 2/2] bpf: properly test iter/task tid filtering
Date: Tue, 15 Oct 2024 11:27:07 -0700
Message-ID: <20241015182707.1746074-2-linux@jordanrome.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241015182707.1746074-1-linux@jordanrome.com>
References: <20241015182707.1746074-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NGv+hCTd5+bIGgo++7PIVq6H/+sfxdqDNhekr2pYdI220ru46Lp
 bIWFYVmDsj50EOmkCgHfzJw7RHlRfUinVj6dmbdW9DTR1K9GhqRd12blGeRZPwT5QyNzuQz
 XdWtgN8lwtnWnQl3rLyD7tnP/BR3xM6ed3raSU11uWHxl2Qy07ikhQdsmjykXDhXy7y23lu
 3slXaGku9QySld2ix5Khw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:At1mZZk0wY8=;lBWvPTYPSxAeiJ7dlzcAxBtJlID
 f4GY8c7Nye5+4R2ZHuabe3/Xc+NhBBSIZxq40xI/Kh/6gyOk0s9CeqTPVB8AIzT3zJfZWuuvP
 lJ5xxjKbBhTT7p7ate6BkgRjfqYqNbrtVtubKUZmorSs7qHbLU3xGGn5Owtw68R4BxzmXlgdB
 JKGYw+FGqiBcgVBLiGL1it3DYbWbFpR/CZsWLOvGvsj5O7mysggHVw7FN86/BK+rqp04n5F6p
 xp2fnWZL3CHQH6sBYpB/vYxwZx75U6l/6CKjnqgiX67s4p/sEcg2e3K1cJLMHEZ30siDlFPCx
 o0wA3wJ9WfJ6NvaWO+TPYS0A3z+sz+ERLRd2OjYoU1Yem0PT1LltuLz/f+FZGXpPIcOqkaTNM
 c8kMAp4BmZ1DdWP2A6BeWYNZR+xQst80rhQGfTDoEEtqb68qgd3jjTMm7Gwoi/dsjHAElDyTS
 8boWEoFLZhujgtBd0aggHDltW7Mu5pM4cRKpzNjOnpIyfHyq2XsM8zXk7RtwAtfa/0EyoSEWE
 APm71j9tJxjutYz4H3bqsbhPRe9WYuLq5YwGVvdyvXSnDrX7vBYbFlnWfMYBCSpfBxyl07bdZ
 O5nvSCRnGTJUYJnkeDgzKN+Luy0mULNMiZ0u5ekEJxjZ1zC6+TouFAi4gveaAeIgspIrjRq1x
 obnKfEbd69vwTStfFgJbbsBH2ZhE9Tjo7xTVOxUMKFKzlgamQED8quN+eueI5/dGR/cP5aIy7
 X9AodjTQMNG+2bfdOFxnD2GlrMHFChh+A==

Previously test_task_tid was setting `linfo.task.tid`
to `getpid()` which is the same as `gettid()` for the
parent process. Instead create a new child thread
and set `linfo.task.tid` to `gettid()` to make sure
the tid filtering logic is working as expected.

Signed-off-by: Jordan Rome <linux@jordanrome.com>
=2D--
 .../selftests/bpf/prog_tests/bpf_iter.c       | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/tes=
ting/selftests/bpf/prog_tests/bpf_iter.c
index 52e6f7570475..5b056eb5d166 100644
=2D-- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -226,7 +226,7 @@ static void test_task_common_nocheck(struct bpf_iter_a=
ttach_opts *opts,
 	ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
 		  "pthread_create");

-	skel->bss->tid =3D getpid();
+	skel->bss->tid =3D gettid();

 	do_dummy_read_opts(skel->progs.dump_task, opts);

@@ -249,25 +249,41 @@ static void test_task_common(struct bpf_iter_attach_=
opts *opts, int num_unknown,
 	ASSERT_EQ(num_known_tid, num_known, "check_num_known_tid");
 }

-static void test_task_tid(void)
+static void *run_test_task_tid(void *arg)
 {
+	ASSERT_NEQ(getpid(), gettid(), "check_new_thread_id");
 	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	union bpf_iter_link_info linfo;
 	int num_unknown_tid, num_known_tid;

 	memset(&linfo, 0, sizeof(linfo));
-	linfo.task.tid =3D getpid();
+	linfo.task.tid =3D gettid();
 	opts.link_info =3D &linfo;
 	opts.link_info_len =3D sizeof(linfo);
 	test_task_common(&opts, 0, 1);

 	linfo.task.tid =3D 0;
 	linfo.task.pid =3D getpid();
-	test_task_common(&opts, 1, 1);
+	// This includes the parent thread, this thread, and the do_nothing_wait=
 thread
+	test_task_common(&opts, 2, 1);

 	test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
-	ASSERT_GT(num_unknown_tid, 1, "check_num_unknown_tid");
+	ASSERT_GT(num_unknown_tid, 2, "check_num_unknown_tid");
 	ASSERT_EQ(num_known_tid, 1, "check_num_known_tid");
+
+	pthread_exit(arg);
+}
+
+static void test_task_tid(void)
+{
+	pthread_t thread_id;
+	void *ret;
+
+	// Create a new thread so pid and tid aren't the same
+	ASSERT_OK(pthread_create(&thread_id, NULL, &run_test_task_tid, NULL),
+		  "pthread_create");
+	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret !=3D NULL,
+		     "pthread_join");
 }

 static void test_task_pid(void)
=2D-
2.43.5


