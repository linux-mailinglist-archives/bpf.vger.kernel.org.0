Return-Path: <bpf+bounces-28240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C48B6EA8
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71146B248F9
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC93129E9C;
	Tue, 30 Apr 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djcwP+ao"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA2129E8C
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469911; cv=none; b=FkHqT4tzAd6NNmZou77GPwmBdWaiNrwLTvrWja0LZBalK7GEfLss+ldV+0zWF5iWKo+xMynzRw2sMohbtLNZ4bLGRhATonBcwMIs9bsdOLPy4lM1/oLLO+w4XjTmg4+/e/JJlpbpCn0/Ykljz7MwmsDwvNaRyvDtrWIgZ7U/c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469911; c=relaxed/simple;
	bh=NNM58qHLgWUEaok6EoQHzrdjYFEu56kOzSeXNnjKWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8i33zANNa/5thxjuGIknLRPEptXOra1O4y79Bk7YGbEj3nerrxvzwry0aWEGJka1mGpeGGhUzkNjFyeNRODOQGvNI6gOXEVXGzGW0zCKgj/gvd+kb5JxzVuc1mtX0cc5wEgfYTH6ag2Aq+b/ffNZZT0IoA7tTNOKwSfv/p2SSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djcwP+ao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714469909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g/lfOzAHQ847/IQB5rMC5+e8BmgY1z2+AkRogtNL5w=;
	b=djcwP+aoP0TPCVro6keuGrvPC/jwM3Bh7d/fxEicKUNZk928F8OMgzwFznt+61eox1HvNu
	zyXzEZvpz16t9UYAcr1bvm4LPzSIca7Qft39QvRE60uKrh5J/zMV1cA5+zwRvY4SwDCZVo
	5L9Db5BcxxGRqg20/CQD+95bDOxcVdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-NWAAKhwNOYuszWwGOn98lA-1; Tue, 30 Apr 2024 05:38:22 -0400
X-MC-Unique: NWAAKhwNOYuszWwGOn98lA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE3E489A7E5;
	Tue, 30 Apr 2024 09:38:21 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7983F2166B31;
	Tue, 30 Apr 2024 09:38:18 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for the "module:function" syntax
Date: Tue, 30 Apr 2024 11:38:07 +0200
Message-ID: <8a076168ed847f7c8a6c25715737b1fea84e38be.1714469650.git.vmalik@redhat.com>
In-Reply-To: <cover.1714469650.git.vmalik@redhat.com>
References: <cover.1714469650.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The previous patch added support for the "module:function" syntax for
tracing programs. This adds tests for explicitly specifying the module
name via the SEC macro and via the bpf_program__set_attach_target call.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/module_attach.c  |  6 +++++
 .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index f53d658ed080..6d391d95f96e 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -51,6 +51,10 @@ void test_module_attach(void)
 					     0, "bpf_testmod_test_read");
 	ASSERT_OK(err, "set_attach_target");
 
+	err = bpf_program__set_attach_target(skel->progs.handle_fentry_explicit_manual,
+					     0, "bpf_testmod:bpf_testmod_test_read");
+	ASSERT_OK(err, "set_attach_target_explicit");
+
 	err = test_module_attach__load(skel);
 	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
 		return;
@@ -70,6 +74,8 @@ void test_module_attach(void)
 	ASSERT_EQ(bss->tp_btf_read_sz, READ_SZ, "tp_btf");
 	ASSERT_EQ(bss->fentry_read_sz, READ_SZ, "fentry");
 	ASSERT_EQ(bss->fentry_manual_read_sz, READ_SZ, "fentry_manual");
+	ASSERT_EQ(bss->fentry_explicit_read_sz, READ_SZ, "fentry_explicit");
+	ASSERT_EQ(bss->fentry_explicit_manual_read_sz, READ_SZ, "fentry_explicit_manual");
 	ASSERT_EQ(bss->fexit_read_sz, READ_SZ, "fexit");
 	ASSERT_EQ(bss->fexit_ret, -EIO, "fexit_tet");
 	ASSERT_EQ(bss->fmod_ret_read_sz, READ_SZ, "fmod_ret");
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 8a1b50f3a002..cc1a012d038f 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -73,6 +73,29 @@ int BPF_PROG(handle_fentry_manual,
 	return 0;
 }
 
+__u32 fentry_explicit_read_sz = 0;
+
+SEC("fentry/bpf_testmod:bpf_testmod_test_read")
+int BPF_PROG(handle_fentry_explicit,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	fentry_explicit_read_sz = len;
+	return 0;
+}
+
+
+__u32 fentry_explicit_manual_read_sz = 0;
+
+SEC("fentry")
+int BPF_PROG(handle_fentry_explicit_manual,
+	     struct file *file, struct kobject *kobj,
+	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	fentry_explicit_manual_read_sz = len;
+	return 0;
+}
+
 __u32 fexit_read_sz = 0;
 int fexit_ret = 0;
 
-- 
2.44.0


