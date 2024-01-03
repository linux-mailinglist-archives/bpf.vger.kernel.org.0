Return-Path: <bpf+bounces-18895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB45823556
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7CE1C23D02
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5C1CAB7;
	Wed,  3 Jan 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhMfTU9O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004271CAA6
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so7945248e87.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308782; x=1704913582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1JseKIlQsZOty5Nzo7u3mVw8gttQ7ph+BCdoxW/xzQ=;
        b=hhMfTU9OSDNLO1Xp3oigzP6BYD5WEmfm+KN4wLt131uxhWeoH0XGhnHr5MapyxungQ
         7XsCOOmQZb0M5PlFqJDQkLBjoOzpunYvWCRk5TIeQ52yYaMJ5/3u8CII28PvJFb/nPJx
         a8VYbgnrqdnn00OmTsH9X5pc3OLhnVKwiMPzXcE3cPRFDfaCK2Dbyx1/QZ2jDie+cv2R
         yylMzq0bRm+4l+XEjm+Jn1G79OlS8fopCCTeo/1CwbyT/F/NmUiFvaMhBdtqKvNDcdxD
         36OfxDr479X4FtjoYdSPPXyD/JOOnoVprJy4F6Sgo1KhWo+Xue24H6ApI/3r7jV9XFAX
         HX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308782; x=1704913582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1JseKIlQsZOty5Nzo7u3mVw8gttQ7ph+BCdoxW/xzQ=;
        b=NGj7MCFlYyHVtfZv6JegNimt5JOzVNCmOg3kFetZOyVWID6VNhjt/65RhQDHiNswhf
         SpKIiZh4LZ81IF4tpk77BduBJ5QWXXxfaKHnn3pgyMtzHkZb6Gx5zfMnMED1Kc/5pC+a
         rReZYfXV9CDYVKX4Q+QSPZmDIbgJwODUuzKmBDv3DttyAvn3AXPDPWSyFRz1JtX6X7o7
         sr1+mYhKvYmJEmluNdf9OYOWZBaZTPLs+nX4+x7QdCOjPWGffSy+hdC3kyU3DJPsyr5n
         Pzut2DUOluzzqOojCXN67ANZyA/JmImQwsbh7cg05Ypp2gL8CIB4leW4I0ZFnUGxADDW
         7b0Q==
X-Gm-Message-State: AOJu0YxsA3oXQ0SO+baa5NwljJLK9G7/tP6ZP6lJdI64HPKcwQpPNq39
	TagapsA7JEM4jFw/7++NLvAY1dnmQLyRGg==
X-Google-Smtp-Source: AGHT+IGjRPHJOxtcJIzTnSYheFhHJaiTC8w9oHS1dwKb87oayqWiCnY3X0ANC/qwB2ShaHe2STuvOA==
X-Received: by 2002:a19:5f54:0:b0:50e:6878:a70b with SMTP id a20-20020a195f54000000b0050e6878a70bmr6805060lfj.54.1704308781946;
        Wed, 03 Jan 2024 11:06:21 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id wj20-20020a170907051400b00a28a8a7de10sm605772ejb.159.2024.01.03.11.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:06:21 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v12 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Wed,  3 Jan 2024 20:05:47 +0100
Message-ID: <20240103190559.14750-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103190559.14750-1-9erthalion6@gmail.com>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to verify the fix for "prog->aux->dst_trampoline and
tgt_prog is NULL" branch in bpf_tracing_prog_attach. The sequence of
events:

1. load rawtp program
2. load fentry program with rawtp as target_fd
3. create tracing link for fentry program with target_fd = 0
4. repeat 3

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v12:
    - Adjust comments style.

Changes in v8:
    - Cleanup, remove link opts and if condition around assert for the
      expected error, unneeded parts of the test bpf prog and some
      indendation improvements.

 .../bpf/prog_tests/recursive_attach.c         | 44 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 10 +++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 4bd0a0e4231e..8100509e561b 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -105,3 +105,47 @@ void test_recursive_fentry(void)
 	if (test__start_subtest("detach"))
 		test_recursive_fentry_chain(true, true);
 }
+
+/* Test that a tracing prog reattachment (when we land in
+ * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
+ * bpf_tracing_prog_attach) does not lead to a crash due to missing attach_btf
+ */
+void test_fentry_attach_btf_presence(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_skel = NULL;
+	struct bpf_program *prog;
+	int err, link_fd, tgt_prog_fd;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+
+	tracing_skel = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(tracing_skel, "fentry_recursive__open"))
+		goto close_prog;
+
+	prog = tracing_skel->progs.recursive_attach;
+	tgt_prog_fd = bpf_program__fd(target_skel->progs.fentry_target);
+	err = bpf_program__set_attach_target(prog, tgt_prog_fd, "fentry_target");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto close_prog;
+
+	err = fentry_recursive__load(tracing_skel);
+	if (!ASSERT_OK(err, "fentry_recursive__load"))
+		goto close_prog;
+
+	tgt_prog_fd = bpf_program__fd(tracing_skel->progs.recursive_attach);
+	link_fd = bpf_link_create(tgt_prog_fd, 0, BPF_TRACE_FENTRY, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		goto close_prog;
+
+	fentry_recursive__detach(tracing_skel);
+
+	err = fentry_recursive__attach(tracing_skel);
+	ASSERT_ERR(err, "fentry_recursive__attach");
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	fentry_recursive__destroy(tracing_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
index 6e0b5c716f8e..51af8426da3a 100644
--- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -15,3 +15,13 @@ int BPF_PROG(test1, int a)
 {
 	return 0;
 }
+
+/*
+ * Dummy bpf prog for testing attach_btf presence when attaching an fentry
+ * program.
+ */
+SEC("raw_tp/sys_enter")
+int BPF_PROG(fentry_target, struct pt_regs *regs, long id)
+{
+	return 0;
+}
-- 
2.41.0


