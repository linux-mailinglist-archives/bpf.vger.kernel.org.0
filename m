Return-Path: <bpf+bounces-17582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02780F753
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1AA28200E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DA52759;
	Tue, 12 Dec 2023 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkHX4tt2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD1A6
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be24167efso7054429e87.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702411094; x=1703015894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2QShfNMYTNkQiMpYuhiBqh+otMqXVhziiw2LYCI+tI=;
        b=JkHX4tt2sczvcv1VqNpf9MekXsni/d9yS9VceVhTicjklZtaOPwL5HHD7WhwbcQhqS
         iZ+dpP971Z0iDTN31zrDBKTSHbiiHcHUXS9lRagRujKewYWMVG7skoVpcsqaaPePwf/i
         fEZjHVqRDYBoz+XSnk6XmyvGZG94QYH9l4Q+Wijngq7wjlp6O5VQbWJvrKjCdCJ+qh/m
         vDw/11rpitCa4G6p5sdGcLZzobNFByuAgZHxvfv8n4HKhkizOJC4nzZAyuwItXHgWKLw
         ZYPENCSDEsgdZuaIBng0GMDMUcyZCffAUPqiBZxh2h1xXODiXq6cvrderM8unDy8WsJa
         mRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411094; x=1703015894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2QShfNMYTNkQiMpYuhiBqh+otMqXVhziiw2LYCI+tI=;
        b=XdozCfiJj9vKeH+eJHxmnfUfFF6urw3L2gaD7fQjmhkSXnh2kGvhU8NVabyx+3CHSk
         0fDvg6MWIvUrUEcftCr5GcvBTlMa4LGRFgHZo9Xc7qrg9NSb2nzd8NPN1QQuZiGqisnh
         SiEk6HlW3RdRP5I+hMw2aYznr0XwcsHQUVMpQ6drxcWC3wshfczsAHWm8XphaOjZItem
         Xh3YewY9yYZwRZ8rxaEPK39hpJN9FDYfK3xsG+bcqgtzBwMLLHDZ0b7ZiFLBDlgpLr4P
         rtCJpIupsXCj7XtTme/SYr96NCSeH6hXccGiLsLBKmPwzQd9SMmBzZttWdT0rGJ+L4gn
         q1Ug==
X-Gm-Message-State: AOJu0YyLk2BNJltvd/KDblNRUUfbDeQe0tdJ7HPXZYmo/lgiOZLtPi4k
	vG+/p75NoYeunUIeH3KiaX1HB9KVDdHGaQ==
X-Google-Smtp-Source: AGHT+IH0yoSx2CHrJqLhrbxuuN3IZmvUpZISUIKaE74D55f+1qftaukjv7cwXS6uRAl8RkIELkcWZA==
X-Received: by 2002:ac2:54a8:0:b0:50b:eadf:f173 with SMTP id w8-20020ac254a8000000b0050beadff173mr1300961lfk.73.1702411094263;
        Tue, 12 Dec 2023 11:58:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:608d:69b3:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm6677386ejc.73.2023.12.12.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:13 -0800 (PST)
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
Subject: [PATCH bpf-next v8 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Tue, 12 Dec 2023 20:54:09 +0100
Message-ID: <20231212195413.23942-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212195413.23942-1-9erthalion6@gmail.com>
References: <20231212195413.23942-1-9erthalion6@gmail.com>
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


