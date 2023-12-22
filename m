Return-Path: <bpf+bounces-18620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C581CC04
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84381F280E7
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FD28DAE;
	Fri, 22 Dec 2023 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnsPdh9B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C852837D
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2699ee30d1so169229366b.2
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257929; x=1703862729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO7oGe2mNdMLhRsQuD/r7huaBZOKYf65/O4A8DyjtzM=;
        b=FnsPdh9B6io44bmQz4dHkTdyFnaEpN+BpCFRS8FJJ6JBEwb/thYmpITMHdBQ0Jf0d4
         pigM61br/wX5sz/baa88fE+DKGNjDw93ZBmnBZhNi7cXwjz5TSp/UaPAM1j2OvZqMhHW
         DSXpeL2BFXQde/r7/RS8khDBcviWzaPq34IDKym4iDn0pbALeNu+nP3OcnEXXKy03vvr
         I8VYwPU4j8PxjZtnNPldA2tSLPqvSzua+npMfw8eku14WPo21fU+SaCKtFf3AXNTXcVU
         CHQq+QqC5h/EaB2VZK+3U3bHOtBIO7n2F/8ouK1RaN9OYvWgEmYRoAAblEgSas6jWxDI
         tlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257929; x=1703862729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO7oGe2mNdMLhRsQuD/r7huaBZOKYf65/O4A8DyjtzM=;
        b=F15JaIh2mxCyPGVA/P6vvMAz9VmTYEn6YnXVe+VHVZhn0jxjJfiviBpF6/bm2DjN0h
         XMGPUX9e21hsDQkwt142hFzGz3l0qKjRIY47XwanAVcvKtAp2wZR0sQ2/J3UGovRLFgv
         TP5FcZ9bUH3iITwlv27zTX1zNnc/Q/TInpcdqG7Czt3TCIL3YAuv6bFC8fj5KVdmT59Q
         HuMACOaxKdjGL7rxWK+Mt9AkIKX5bZmT/crgpmcH36t6hAexNh1exAbrs43yMh9rFcQV
         innl9Wrabix9YkUCn8lB3I3KkGx93g9vXal/y7UqpvxKy0yIDXq8/eWwCyKargAIZr2j
         UmXA==
X-Gm-Message-State: AOJu0YxikdtEFBAL7S1ujmJmkkRe/X6MHxe8gjOKctwZ7vVxmse5ATI8
	4xui0qdJ8NRRuGqL37ddIzhwCnXU+O0UNw==
X-Google-Smtp-Source: AGHT+IGlWD7ekaaDVl5YmncY3/9fY1N56bVFTRIJU3gi+4/j3W+wk6SdQ2n0y/WKrzSPADn42sWPGw==
X-Received: by 2002:a17:907:7da1:b0:a26:a4bf:e8c0 with SMTP id oz33-20020a1709077da100b00a26a4bfe8c0mr1157315ejc.21.1703257928592;
        Fri, 22 Dec 2023 07:12:08 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a236f815a1fsm2111162ejb.200.2023.12.22.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:08 -0800 (PST)
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
Subject: [PATCH bpf-next v11 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Fri, 22 Dec 2023 16:11:50 +0100
Message-ID: <20231222151153.31291-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222151153.31291-1-9erthalion6@gmail.com>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
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
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v8:
    - Cleanup, remove link opts and if condition around assert for the
      expected error, unneeded parts of the test bpf prog and some
      indendation improvements.

 .../bpf/prog_tests/recursive_attach.c         | 45 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 10 +++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index e9e576de6723..124c57e27387 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -109,3 +109,48 @@ void test_recursive_fentry(void)
 	if (test__start_subtest("detach"))
 		test_recursive_fentry_chain(true, true);
 }
+
+/*
+ * Test that a tracing prog reattachment (when we land in
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


