Return-Path: <bpf+bounces-29503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106A8C2A42
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD0A287265
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E1481CD;
	Fri, 10 May 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6ykovTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5681E525
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367787; cv=none; b=tX+b8m7UOhJ+NpFGaqVW1HEIKFjJWmYKZyi4lpEH3/FA0+ywo2NdlyeeFgjen/1vmuYunbdARMt2tiBPn6JocxxN3tvlvPHN0LVkEVSqeftm08gRBTJR0SNxB9BbEfuHKGY5qM4U+KkXELwT7SVpHKF+SUyR4HSyKqq9rHfRoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367787; c=relaxed/simple;
	bh=o7PBn6L8KHD5r73yZ+KXTGgNNI8XrNjMpiFFTo119nE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZrE2zXQyM/kZ7p9RV0ah4Yv9agyMzbLD2WebIbCKSqwUo+mC/EtAdipyZanpdACNdKMbGVIqVpEFqGIh2r0fFbwOcNgE8tW+hYNOKnlluURsaJQQ9kx2RSDeH0pxlmjljNXfoKVS7VJfgZbU4iGz1msDMmAIDpk0+Qaq0Hk1L/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6ykovTM; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7dab89699a8so234258139f.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367785; x=1715972585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0npXBcT31rOcPOResCKMLES9ZP4MLJOzqmhEllV+e5Q=;
        b=v6ykovTMweY9c+QQma0E2m4ENBKnsJt92FT4yUEGZIHIyE2/4rqZZ+ms1QDFOVQOx0
         rD1rr/hKKpsm3SPLnG3GJsKxZX6ng3g3xobUv75oRTiw3n3v3BQd2sBuFepNfFJQiGf0
         4PRq4GBJ6zDgu3HO3qNkiWM1nxG5tdq8TW+u5nUqvG0mveYer/jus1BIvsFZNfuemlCF
         zCHgqPGKOxS12AuO9vFEtrAgkoWOztJqFh9OYyqoW6jK6LKU8j8tDC971Km3R7Qn8VkQ
         FP3VYyNqLaTISOLe+XR9AbD6KTqY1U7e3HkgjZW2ELOTNqH+55ndqkPPPaU7xgfqyQPO
         1Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367785; x=1715972585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0npXBcT31rOcPOResCKMLES9ZP4MLJOzqmhEllV+e5Q=;
        b=H5o/7gbOKA7fQ4nv5bhyKLjZuLfnnnPPl0MtVdIWEx1erXfb7MmzmSceOMh5D+PE7M
         BxVG5HfC/2s/oTrz+9Eg56/ceCw8GwBp3KtdbaxMEQuKfoNbQnrpENIAmoKePHOu6kV4
         bO47UFYd71oQ2h4v+EjFh0bu61TGOJFRtQlbPaa5NlCszyyQwlDdEL8AWOQenP4OH93E
         pM0MtJwZEfn7FhrQBA7xvLlXvPvZALi5h00urYOg237f3FIFIgMQgeg/bt3rBw9aTGKM
         ebjCDL5763H+RVBQUcMBrK7aEAxoGtHYNEn8PVriAVHIvY9ojRk642YkdE9Mc6LnmT3H
         +YDQ==
X-Gm-Message-State: AOJu0Yw8krYDz5HA22bUMTtdB5ThVV03mrSXx99NZc6mCphCVCZWEh1T
	XWmBIUUo650YKlfuxBKsHOrfS8u+9PecWxo03Fx0s1smQUZaiubzIMOQRfxZYPJmWSIQwRTVxA9
	pk/cJ6SJ1hvXR2MWj3u45ko8dg77znVh/N30gsCx7f5PhLWhTPJG54p8+QinDwpScyvfdIXYFRs
	eQF63xIr8l882rfaU0xyyH4P4=
X-Google-Smtp-Source: AGHT+IGZtITWsgx6zg8OE77gXG1kr4XzHCeKyGHBOMXXoh970ep5T0+pusZggk04pc+52Fju3a9U+uJ83A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:872a:b0:488:7a00:9343 with SMTP id
 8926c6da1cb9f-489589c27b6mr226053173.0.1715367785261; Fri, 10 May 2024
 12:03:05 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:27 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-11-jrife@google.com>
Subject: [PATCH v1 bpf-next 10/17] selftests/bpf: Migrate expected_attach_type tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Migrates tests from progs/test_sock_addr.c ensuring that programs fail
to load when the expected attach type does not match.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 96 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 84 ----------------
 2 files changed, 96 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index e3c450d11b9ef..8c7c56f997549 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -490,6 +490,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: load prog with wrong expected attach type",
+		bind_v4_prog_load,
+		bind_v4_prog_destroy,
+		BPF_CGROUP_INET6_BIND,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_BIND,
 		"bind6: bind (stream)",
@@ -522,6 +538,22 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: load prog with wrong expected attach type",
+		bind_v6_prog_load,
+		bind_v6_prog_destroy,
+		BPF_CGROUP_INET4_BIND,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 
 	/* bind - kernel calls */
 	{
@@ -622,6 +654,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: load prog with wrong expected attach type",
+		connect_v4_prog_load,
+		connect_v4_prog_destroy,
+		BPF_CGROUP_INET6_CONNECT,
+		&user_ops,
+		AF_INET,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect6: connect (stream)",
@@ -654,6 +702,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: load prog with wrong expected attach type",
+		connect_v6_prog_load,
+		connect_v6_prog_destroy,
+		BPF_CGROUP_INET4_CONNECT,
+		&user_ops,
+		AF_INET6,
+		SOCK_STREAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
 		"connect_unix: connect (stream)",
@@ -786,6 +850,22 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SYSCALL_EPERM,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: load prog with wrong expected attach type",
+		sendmsg_v4_prog_load,
+		sendmsg_v4_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET,
+		SOCK_DGRAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg6: sendmsg (dgram)",
@@ -866,6 +946,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: load prog with wrong expected attach type",
+		sendmsg_v6_prog_load,
+		sendmsg_v6_prog_destroy,
+		BPF_CGROUP_UDP4_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		NULL,
+		0,
+		NULL,
+		0,
+		NULL,
+		LOAD_REJECT,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 85fb2a793be50..4ecbc72477f1f 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -97,20 +97,6 @@ static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
 	/* bind */
-	{
-		"bind4: load prog with wrong expected attach type",
-		bind4_prog_load,
-		BPF_CGROUP_INET6_BIND,
-		BPF_CGROUP_INET4_BIND,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"bind4: attach prog with wrong attach type",
 		bind4_prog_load,
@@ -125,20 +111,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"bind6: load prog with wrong expected attach type",
-		bind6_prog_load,
-		BPF_CGROUP_INET4_BIND,
-		BPF_CGROUP_INET6_BIND,
-		AF_INET6,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"bind6: attach prog with wrong attach type",
 		bind6_prog_load,
@@ -155,20 +127,6 @@ static struct sock_addr_test tests[] = {
 	},
 
 	/* connect */
-	{
-		"connect4: load prog with wrong expected attach type",
-		connect4_prog_load,
-		BPF_CGROUP_INET6_CONNECT,
-		BPF_CGROUP_INET4_CONNECT,
-		AF_INET,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"connect4: attach prog with wrong attach type",
 		connect4_prog_load,
@@ -183,20 +141,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"connect6: load prog with wrong expected attach type",
-		connect6_prog_load,
-		BPF_CGROUP_INET4_CONNECT,
-		BPF_CGROUP_INET6_CONNECT,
-		AF_INET6,
-		SOCK_STREAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"connect6: attach prog with wrong attach type",
 		connect6_prog_load,
@@ -213,20 +157,6 @@ static struct sock_addr_test tests[] = {
 	},
 
 	/* sendmsg */
-	{
-		"sendmsg4: load prog with wrong expected attach type",
-		sendmsg4_rw_asm_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP4_SENDMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"sendmsg4: attach prog with wrong attach type",
 		sendmsg4_rw_asm_prog_load,
@@ -255,20 +185,6 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: load prog with wrong expected attach type",
-		sendmsg6_rw_asm_prog_load,
-		BPF_CGROUP_UDP4_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		NULL,
-		0,
-		NULL,
-		0,
-		NULL,
-		LOAD_REJECT,
-	},
 	{
 		"sendmsg6: attach prog with wrong attach type",
 		sendmsg6_rw_asm_prog_load,
-- 
2.45.0.118.g7fe29c98d7-goog


