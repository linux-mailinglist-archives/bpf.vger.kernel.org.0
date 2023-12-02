Return-Path: <bpf+bounces-16518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E7801E36
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E361F21120
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E420B3F;
	Sat,  2 Dec 2023 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXPzwFj+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC23125
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:19:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso2109266a12.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701544790; x=1702149590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=gXPzwFj+zuhaRIrd7jTYBiYPsQI0TUwZ2/klCMKqCA/qVO7IVvo2nUhjiyU0g+cZ3R
         ZdM8sl7jF5l9zdfDmimDbfjo3AcrLtErEn/vg8c/FGNS3QcyruOK5KeAJ65lYSWaTDdv
         v60m/UCUb1v+GxlaOxb6Hm6ZF9ajxp4yqQxAZFL+GGDZTwoyg3TkZb+8Cnhejt/EcKXr
         cMhS2zA7nC0zv4IkH9jyKO62jzgYX3X6G9qbD9kbnDvhiEPQKcP1yEy5sdQrKukzm7YK
         1ozBbkWtanPn1lUC8wno1Rsx0EznjPtkQ8H9YPDI/4LblYbHTD/W20wTimVILEYmspxL
         wRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701544790; x=1702149590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=MMlBXM8nkchm16P5/6N97IbCP/3YZHLHWlrQWI36n1KJIpgqA41OmLACRboIJvWYtN
         3ObDiP+9rMZarymVhaD2zs1ZiGdJ4XbKCoP+VEeT53MDRAS75vyvZSV7CLhgptAoxlDV
         oMKklKQ5PcaQ0tskfcZFlfpUyuukM8WbXAYHrZWV6G6MeI1b8AHPZhAHYu7nJb/a4fR2
         Vd0YeNroi4waNfEjEJ2P1BaJw1gIkZJf/MHNHqs7bbwnmRw+r0Qy/b4bEkmGRKeVwBCM
         W8SeOD4R8oMlGwIsTCSCXDFpSXgSI5nNAS8V3HuX/P/vgQupy70ae2K+q2PjgBl41cF1
         fCBw==
X-Gm-Message-State: AOJu0YyPPJIhzbHZkjAvEGNLym2FctdwiMX9RqTZfW7tVuYibyrfUo69
	O3mMOs0/avJPBk4X0ZBvGlhh9GK42dzduw==
X-Google-Smtp-Source: AGHT+IFkedhEEPWqR7c4obhyGMwjvI/L7TXvawkHY4LOwlHuBKOdELD32tJYmSv2eQ3ZCoCjD9NMjQ==
X-Received: by 2002:a17:907:86a1:b0:a19:c22:f66e with SMTP id qa33-20020a17090786a100b00a190c22f66emr4049233ejc.55.1701544789899;
        Sat, 02 Dec 2023 11:19:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:6008:6fb9:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a18ed83ce42sm3127814eja.15.2023.12.02.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 11:19:49 -0800 (PST)
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
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Sat,  2 Dec 2023 20:15:50 +0100
Message-ID: <20231202191556.30997-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231202191556.30997-1-9erthalion6@gmail.com>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
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


