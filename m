Return-Path: <bpf+bounces-18038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21638150E8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BBD1F2584E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095645C0F;
	Fri, 15 Dec 2023 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0GcXf2r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BB45BF6
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so1244926e87.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671070; x=1703275870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2QShfNMYTNkQiMpYuhiBqh+otMqXVhziiw2LYCI+tI=;
        b=X0GcXf2rkvS6TqK2nImkuKV11QX1A4mfJ0PeinUHskjz/5m5gknlG0uAmKUd3eHANC
         vXZMJHphIa3jPfYVWgMoqh2KA1gZq67ulfy8Y013YKHQ/igGMICi1l20Tcc0+q7fMKpK
         L1pdRh6x8T1o+gPy2TkhlZ4FUisltOI/KwqHrdq4W5zE2TjRX8gOkfv6snhb/9eq35Ho
         CCIqGvECTNST3Q+UBPUCqA2qKI5p1t6siALkVQqUOt2mapgssH+8iB2TwswrlHbyIyRk
         vTTG2UrozuFB9Ze604qXAhpJxiBo/5m57GVyObaPUbhoISijfJwtLfQV7F6+QgBlGepv
         ADzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671070; x=1703275870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2QShfNMYTNkQiMpYuhiBqh+otMqXVhziiw2LYCI+tI=;
        b=UckAanK8JEXXJPu5ljig5hMiUkWndAtPb7iqnd712npvo00jxOdTdhDDzKP1zh+wtj
         fLm7OcwEGho3eLeZflvt6zfUondNyHs1CIOsa785m5IYdk2P7mKXzia/YmXs9wxCvtVd
         5xvosqiWfL7gSGVh7vbYPS2lJdAIzWcCdsRvwDT0v7QFrJ22cnGD8z6DjzJBLApkgUgy
         60i/spflcItmMWbQ2SAu0HzFk6qhlM3j3RbNsxVgRu+5iNJ56tQUJGa+Fu3Z6sVZQEi+
         NKP5FBjCsHr/xnTbqeigZLuE2+ZHGGL000zRLf0SuFbmISBP0M86CNN7XwUtWAgAK/k8
         BzXA==
X-Gm-Message-State: AOJu0YwAGk5U+uzcz3nWBq0IYyQjsodmBrIiWDkaPfOjM2RV66yzZNk6
	w8VTxhwt2EGLNi6kxB6MRqQHoSlYCcz7kg==
X-Google-Smtp-Source: AGHT+IFwJ89d7PzPEjKQQ9ZrZi6JfJf5Nkbv6zePOUcwdy11efiIGIRhmLjFUt5QSjuh72/ugL0maA==
X-Received: by 2002:a05:6512:3b06:b0:50d:f786:f459 with SMTP id f6-20020a0565123b0600b0050df786f459mr3272454lfv.170.1702671070100;
        Fri, 15 Dec 2023 12:11:10 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm11031490ejd.28.2023.12.15.12.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:11:09 -0800 (PST)
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
Subject: [PATCH bpf-next v9 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Fri, 15 Dec 2023 21:07:10 +0100
Message-ID: <20231215200712.17222-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215200712.17222-1-9erthalion6@gmail.com>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
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
Changes in v8:
    - Cleanup, remove link opts and if condition around assert for the
      expected error, unneeded parts of the test bpf prog and some
      indendation improvements.

 .../bpf/prog_tests/recursive_attach.c         | 45 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 10 +++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 5b38783bcd16..1063b7924343 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -66,3 +66,48 @@ void test_recursive_fentry_attach(void)
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


