Return-Path: <bpf+bounces-16400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880C800ED3
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D3B1C20EF1
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57C4BA91;
	Fri,  1 Dec 2023 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQWUkqUe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685B10DE
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 07:51:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00191363c1so316355766b.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445883; x=1702050683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=mQWUkqUeQss+VpAoYYnBz5wWarR7Z9YvTQMqcwZt1WoMdiIy2VUcNGQLPCo5A6khqS
         N2Tup/374TrAar3704jc/T9xNXeru/Uld2AldJhgZPl59/i/X3nMAz1DYbeU8cZtV9Eh
         NLvrwu74FxQsynNpzEO0DwSwVJ8g3DqiqiN3Z+ShroLNjV8NFHNcLu91VOrmW2Af3anB
         faHJwoua/x8y/l9RcIfxj/z6xZXS1LcgLotPUIJ9jautdgJUDXXuN9JkDxVGDAk+HMmH
         dh+Y2fUKL9tTdNs34wFibeHCZqCEm2PTQ0GXSDaGbFiqWBUp+TrwfWTctat8K2g+F0vw
         99Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445883; x=1702050683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9rsC57otcPvRDJAp4KfgS6OnjP1RG0QZjfI6cDUsJc=;
        b=CAP0hBZeRvHd0YTMazc6tQ7e9h54KAy9TGZJwcuR3W7uG9BwbHlQGMcPWzgKfJzEnG
         boInLvtJgm3exyhjly03PQ7Q18/evAkNPkTl1Hb7oOtDTmKs0lxZbqqoXYvXk5kDPRop
         vl5mIMxIy52u4mcMM+b8B65i8LwbGJOIuj9nsL0331NvXGXxhfatMXXsZPXKMyJWiize
         52jjSuxMKmqLSQ4HWLtTk6RmH0nI/O0nBQ8mop9mOBQ1PMEGiCxVploUVkDp/mfRFKBA
         Awhyv10J5Sbs9BPeOm+lsiZ+aIrO++LvhWeVVw2ZXTlzzce6W9m6T0x3oJdcy2cHyp6f
         8g6Q==
X-Gm-Message-State: AOJu0YwoI3tG1RydcXVLibjFhtEhPA1+16qxiiJnEKC96D7LtKZNRhMH
	Oc+sYOy6ONPBluRF+Cm1uczjrfF/6UX3Bw==
X-Google-Smtp-Source: AGHT+IGq6NZNPuI0QNwUkl4qQR2cJHKdyHLdMYYDoQ8y6oRPNNE9h0CKSllQpjbFIvhSFCxz+0jYlg==
X-Received: by 2002:a17:906:2209:b0:a19:d40a:d1e9 with SMTP id s9-20020a170906220900b00a19d40ad1e9mr530418ejs.181.1701445883110;
        Fri, 01 Dec 2023 07:51:23 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906159600b00a16c1716a20sm2033118ejd.115.2023.12.01.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:51:22 -0800 (PST)
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
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Fri,  1 Dec 2023 16:47:33 +0100
Message-ID: <20231201154734.8545-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201154734.8545-1-9erthalion6@gmail.com>
References: <20231201154734.8545-1-9erthalion6@gmail.com>
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


