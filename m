Return-Path: <bpf+bounces-27925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A399C8B3704
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F1A1C21892
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9271145B1E;
	Fri, 26 Apr 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbFZWJAS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833C14532A
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133868; cv=none; b=XvPqXvccd71ivdwulciMJRI1AW5Bebg93eraXnJb/YelRBWFF2QXcZAjw11uhvBYp7MPLhmngZ/0RPeBAKq+VPyhMD8s4MWjdl9uJ2q8dR9TqFStI8IPhKph6giRyG4Ji7zqJGcGcJpj/4WwmQchUZUtqdDLJVHpo9gB4U2vjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133868; c=relaxed/simple;
	bh=bu80HnhvwcgDiciKC7uQFnfWm5ZezcI+v/gdgqjPk3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqFE4TRGVQtaVZyAr+YQWvM3Xo2IaSJZYuohVEnTsT9VTCkexw0dvyxnVB4jyMZKHiuJRHuAOPnhegz6KpB8yOj0UviAZwbtQFNG3ExtGTROK3HKvipaGsHIMXh4nzS8P73FZzdJV7RZEvyfbwWTHWGJsSyVXqENy/ig1Yrhq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbFZWJAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714133865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gqxWwDpS2Kk7S+1QA09QK3IaTtaYwbpujFb9sL+SXo=;
	b=QbFZWJASBqp9naknd2LUychzkDlWUtpXonzmUrgFEb9tsJQDVYYDwDsvnFQFUFasi741XE
	yXibJmQt6qq2d5eAnFBmO3t02UxC9rjnDuLCK7SGTnnR0JDLkrWQT/tO7rji7uwh+sl9jR
	wKR8xx90z96F1Hln4MOdcyC0A3bXqkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KVwoqBzfOdyKlF6peuf1FA-1; Fri, 26 Apr 2024 08:17:41 -0400
X-MC-Unique: KVwoqBzfOdyKlF6peuf1FA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C12D81B5AF;
	Fri, 26 Apr 2024 12:17:41 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 312291121313;
	Fri, 26 Apr 2024 12:17:38 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tests for the "module:function" syntax
Date: Fri, 26 Apr 2024 14:17:27 +0200
Message-ID: <665e725ca2da793566ac42f93b954b77c0d2f7fa.1714133551.git.vmalik@redhat.com>
In-Reply-To: <cover.1714133551.git.vmalik@redhat.com>
References: <cover.1714133551.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The previous patch added support for the "module:function" syntax for
tracing programs. This adds tests for explicitly specifying the module
name via the SEC macro and via the bpf_program__set_attach_target call.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
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


