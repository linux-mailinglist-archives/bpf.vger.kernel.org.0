Return-Path: <bpf+bounces-17227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3680AC93
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B251C20CF5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0D481A8;
	Fri,  8 Dec 2023 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0UC4PU1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71711F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 11:00:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso32874131fa.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702062002; x=1702666802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=H0UC4PU1D17ow9fVmsOkL0hinQP/7g58Oae2Zp/WentgKzihaBpaJv/mew2rIyMe2O
         spIRBPOyMqy5MW8tJdBKRfjczCMapCekfDd5MSMC+sDqR+/Bp4pxDcZugF0XvrfDz7Z3
         Vjj4phYu42s6g7UYZtjxB+mllV2iDKwsUxcplhdg1wBlo68H8Jqda4ZaxRf6O0DQqE/2
         qux3Pr4LxEaPWoQbj+6cBuddRFw9fJy9uFoiC+nAmEAgloN0DBqpQHDbsDcKTnY4s2bC
         p7mOSseW+NmWRDB7g+IVMj+TF1FCZEHqdIMrko2tIys3BsLLUWAhKduzGnSyU9d0xMPB
         xKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062002; x=1702666802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=XtfkFc8Je5n2sRcNayk2/BSn86vCjkyBHavG/y1EAIkdnPe8AS1Rid5uZTbxMXlyKs
         mGoVntjWEpJCe7L591IJzdWy3XCA7zZXYUWpQwia1WD6ygjBTYs/l9mNqxpZ6OgcevM+
         QUTkZXWCxHfLiUp4bcN3bRapEtZGsLmWTqfivgRF7HAtNXGRUi7LFOXpJ1s7G7dkPsvw
         Fz3lwRCTJfcTqYAYAFSjyDY4/MALBMDsKMDhA0EKhea1tupL9b6cH6XQbaflmOKOneVz
         82H6qFoJGbpeDFjQII/z1C1/Dzf6tXHN3UdyKLZenk9GYitvUdgAIQcxChT1gM8ZDWfb
         H4dQ==
X-Gm-Message-State: AOJu0Yy17Vv/tYLjfmpE7dngfXk1yWpjeSgmEACKku8yHqUHiKV4U0nJ
	3dTo71fDh22QQv1DazmzR3rLxrIP06lleA==
X-Google-Smtp-Source: AGHT+IGB+yzezHtRw+Fr8jF7BpFK51S1XcPV3s9syBhQQfc+qLSjz9VmhyyyLOYkzUnHr37IK/JbHA==
X-Received: by 2002:a19:710f:0:b0:50b:f2f8:4948 with SMTP id m15-20020a19710f000000b0050bf2f84948mr154156lfc.40.1702062002291;
        Fri, 08 Dec 2023 11:00:02 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id le9-20020a170907170900b00a1e2aa3d090sm1295702ejc.206.2023.12.08.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:00:02 -0800 (PST)
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
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Fri,  8 Dec 2023 19:55:56 +0100
Message-ID: <20231208185557.8477-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208185557.8477-1-9erthalion6@gmail.com>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
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

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 .../bpf/prog_tests/recursive_attach.c         | 48 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 11 +++++
 2 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 7248d0661ee9..6296bcf95481 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -67,3 +67,51 @@ void test_recursive_fentry_attach(void)
 			fentry_recursive__destroy(tracing_chain[i]);
 	}
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
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	link_fd = bpf_link_create(bpf_program__fd(tracing_skel->progs.recursive_attach),
+							  0, BPF_TRACE_FENTRY, &link_opts);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		goto close_prog;
+
+	fentry_recursive__detach(tracing_skel);
+
+	err = fentry_recursive__attach(tracing_skel);
+	if (!ASSERT_ERR(err, "fentry_recursive__attach"))
+		goto close_prog;
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	fentry_recursive__destroy(tracing_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
index b6fb8ebd598d..f812d2de0c3c 100644
--- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -18,3 +18,14 @@ int BPF_PROG(test1, int a)
 	test1_result = a == 1;
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
+	test1_result = id == 1;
+	return 0;
+}
-- 
2.41.0


