Return-Path: <bpf+bounces-42791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70209AB214
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85E91C21D6E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314B1AD3E2;
	Tue, 22 Oct 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYElJWcZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A41A3056
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610964; cv=none; b=oBOzXJxmdzPmd6FGjDdbxoHaphLY2DRB2mReNGn6NFxqEYsMU1dwzWoRO8YvCdwqED8s7q9GykXIyU454uDGm3fwLxBkKmTfmSbrTX/kcrEw4NwmxdlrQ/BXz/SRxlyZf0ttpx1JslbFid20t19jelaM/JJS7rIs++TQiy3kkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610964; c=relaxed/simple;
	bh=3qLyPOB/ZouuEbuTECDdTIHS6tRCR9JHU62sQnKCWKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQoA9Ce0e/QHoD4FSMsQpcoZF3gpA4fcTxYr4i/ujDht3GyDeRVBXLvFZzNbPom8jxb5feMHi9weeaYMDVtZ1EqD7ZFhg/6LPNNvGxQ6tRlCxRraUz6LJgw0OpLcJpavUZRLBN7Aozbba4rI78AL6Az1j5ANO+/lEbkCeI1FHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYElJWcZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3c638cc27so99011517b3.0
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610962; x=1730215762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCjbbljoI9jzFIh4A06ghACAZm6MQI0CcikHIHbYsM=;
        b=uYElJWcZWRMA9TESuifRnN0TPAarDwSXizHWjWr9EeduaopRgIQthhzvLd7td9aWEm
         n92TkGkhwXNVk+FdgRnPU9RlmEASzYLma9VsTUiBS1zz/tA3hV9bB93N2wfua5Xm/t9N
         kdxzg0DzzQBtYQjTyOvC7b48wYzRw9KC8jkG/9VF+yYPjEjb1YutZ0lkPRxZp8h7OlZR
         4+4nTSNALDsdPxmsE8dkppWjFhsFFAZOZsycYaRaxONw6Nai1TILoAu+KdiJhxC85Rik
         xeb5x3kRJYPYtSmToQ3xZ4sxhpq8FKd+S/P7u+gMk6WRMMjJlzaWlBQKvb8xVWyBV7AL
         Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610962; x=1730215762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCjbbljoI9jzFIh4A06ghACAZm6MQI0CcikHIHbYsM=;
        b=GaJm2B47Bpkr8HRKX1YopSONa60ZQSTMLGbPhISyKUeg3Ej3i4BAd6FygOq7o1r71E
         pH1P9IgQZk0xrn4SCv+RFCdrqvOEbwUd8y4Cax0u+V+LrwqAiXl6oUXggUfNvsyFoFc/
         Xq4QYvKFSjwzgGDR2/zh5bBvlwdac5gwuM2JK+eTw4/1+kxSgcwersdTC5guyEm5S3VF
         gmiLl+lvMBqgpobIjZwXOjQvPyhxmoP/dqQr1NWu2vK1M5woWzB0MPa0m0Dg0AHh7Pg/
         m+4n7BIA/0Zr1pBKOMIzfuJUaSfg3DEZs+E3hqLvCw7JDxo0BiSQiTaBbz//AM3LFWig
         l3Sw==
X-Gm-Message-State: AOJu0YzmXhgE1+YpC1HTuYMlNRPsNArEz3iFYx4RVy3DqsrCBBVoSYLK
	UXNtlQlKYy17Fw8u2nU8y3b1dawei1+nHG0bFD8yRoLFeQfDW/bhC+PmdvKXmG/lAcxL2o3io93
	Xhku+jQrW3QVt9zgGgc6W6k1+FrtlIskJPVYcqpT1bkRGc5YfxDzk3dYKkOK6o/F5/O3wB2LU10
	kg5ZbfXI8i0ZqiwjjIIxerm60=
X-Google-Smtp-Source: AGHT+IF5Qzl4E1YzPe65Wb29Sgrc2HFfLaCNohGBGUfp4TZa7t5neoeyoWwHzW3x6GrdLBjYC9RP4+2Kkw==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a05:690c:6f85:b0:6db:bd8f:2c59 with SMTP id
 00721157ae682-6e5bfbdab09mr3656147b3.4.1729610961939; Tue, 22 Oct 2024
 08:29:21 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:03 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-4-jrife@google.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE
 test cases to prog_tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the "load w/o expected_attach_type" test case to
prog_tests/sock_create.c and drop the remaining test case, as it is made
redundant with the existing coverage inside prog_tests/sock_create.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_create.c    | 35 +++++++++++++------
 tools/testing/selftests/bpf/test_sock.c       | 28 ---------------
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_create.c b/tools/testing/selftests/bpf/prog_tests/sock_create.c
index 17a3713621dd..187ffc5e60c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_create.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_create.c
@@ -237,6 +237,19 @@ static struct sock_create_test {
 
 		.error = DENY_CREATE,
 	},
+	{
+		.descr = "load w/o expected_attach_type (compat mode)",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = 0,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_STREAM,
+	},
 };
 
 static int load_prog(const struct bpf_insn *insns,
@@ -291,16 +304,18 @@ static int run_test(int cgroup_fd, struct sock_create_test *test)
 		goto detach_prog;
 	}
 
-	err = getsockopt(sock_fd, SOL_SOCKET, test->optname, &optval, &optlen);
-	if (err) {
-		log_err("Failed to call getsockopt");
-		goto cleanup;
-	}
-
-	if (optval != test->optval) {
-		errno = 0;
-		log_err("getsockopt returned unexpected optval");
-		goto cleanup;
+	if (test->optname) {
+		err = getsockopt(sock_fd, SOL_SOCKET, test->optname, &optval, &optlen);
+		if (err) {
+			log_err("Failed to call getsockopt");
+			goto cleanup;
+		}
+
+		if (optval != test->optval) {
+			errno = 0;
+			log_err("getsockopt returned unexpected optval");
+			goto cleanup;
+		}
 	}
 
 	ret = test->error != OK;
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 26dff88abbaa..f97850f1d84a 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -47,34 +47,6 @@ struct sock_test {
 };
 
 static struct sock_test tests[] = {
-	{
-		.descr = "sock_create load w/o expected_attach_type (compat mode)",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = 0,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 8097,
-		.result = SUCCESS,
-	},
-	{
-		.descr = "sock_create load w/ expected_attach_type",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_0, 1),
-			BPF_EXIT_INSN(),
-		},
-		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
-		.domain = AF_INET,
-		.type = SOCK_STREAM,
-		.ip = "127.0.0.1",
-		.port = 8097,
-		.result = SUCCESS,
-	},
 };
 
 static size_t probe_prog_length(const struct bpf_insn *fp)
-- 
2.47.0.105.g07ac214952-goog


