Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255AE483DDB
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiADIL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 03:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbiADILI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 03:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1Sn68YOpfQdWqtYtUrgCV+sac3UqaI1SOKuBByB+TA=;
        b=Wr7BspMT4Wy8BClTlj9lsyG274ejeHucLvlStKKnW0/HhOsT9t8t2weypvcpNq1uRY8aNF
        2VD8kQmCZV0bhBMbUcsVhNwsAIWuUh21LJ9Umrn7KW7w+Gu3290Dqx/6IKNm+X/zDXunCc
        B3Q/ZdEYgcc5C5dxuzPjHo9i+a8MtG0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-E0vQpq_FNYi5qtc_ah_ZRQ-1; Tue, 04 Jan 2022 03:11:05 -0500
X-MC-Unique: E0vQpq_FNYi5qtc_ah_ZRQ-1
Received: by mail-ed1-f72.google.com with SMTP id ch27-20020a0564021bdb00b003f8389236f8so24470995edb.19
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 00:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1Sn68YOpfQdWqtYtUrgCV+sac3UqaI1SOKuBByB+TA=;
        b=AwMz36w5yj3x/viBQc/kxNfFO/F7L11KYwdRFy0tWhdpK1FoEZaTyLInKgOyf7vjaF
         +hpnRMBNc7CLK8nb9Wv3ugtTGkFqRQ90zBDR7mUCGGqWTTcZgOStlb7lQKp1qctZF/5u
         7hEMWnw1l65kxhAbEPChKsptIvLYRp2xhhBZ5EDJ4IV9NHZq4kLwj0z6I2wZQy6o556I
         WLV3RVxY+jMlFEXG8PcilKE/CrpPHBnASY6qcBQZxvElhbp8N5/bVCNgr16WtpJkVz4w
         D0Qd6oxBxQ9zVDM0roszkQH1QvyAx+CuUHTNdUAec6uWwmKIS+H4284JWQ8fJH5N8g6Y
         n+3g==
X-Gm-Message-State: AOAM531FAdCDMcIyo9K1AMjYrKiApOzlSmMq3tv3jl1T+wbhvPPRNAV7
        8THt4hKZqteOTssk/Jg+eEcVFgOpHlTdBTHn0Yi3F07iDAn3ISBj5HF2F2bRHmqM3BR+cH4hEDF
        w69i6bzIFzJq0
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr40732551ejc.196.1641283864069;
        Tue, 04 Jan 2022 00:11:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY0vOWIbWrowC6YTp97SbKilX2ZYMN/pSg5z78CfP/qlYGdHEk+p7bdrBYems4kOONH6Q1LQ==
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr40732544ejc.196.1641283863934;
        Tue, 04 Jan 2022 00:11:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id v8sm14318341edt.10.2022.01.04.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:11:03 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 13/13] selftest/bpf: Add bpf_cookie test for raw_k[ret]probe
Date:   Tue,  4 Jan 2022 09:09:43 +0100
Message-Id: <20220104080943.113249-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_cookie test for raw_k[ret]probes.

Using the bpf_link_create interface directly and single
trampoline program to trigger the bpf_fentry_test1
execution.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 42 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 5eea3c3a40fe..aee01dd3a823 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -57,6 +57,46 @@ static void kprobe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(retlink2);
 }
 
+static void rawkprobe_subtest(struct test_bpf_cookie *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
+	int err, prog_fd, link1_fd = -1, link2_fd = -1;
+	__u32 duration = 0, retval;
+	__u64 addr;
+
+	kallsyms_find("bpf_fentry_test1", &addr);
+
+	opts.kprobe.addrs = (__u64) &addr;
+	opts.kprobe.cnt = 1;
+	opts.kprobe.bpf_cookie = 0x1;
+	prog_fd = bpf_program__fd(skel->progs.handle_raw_kprobe);
+
+	link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_KPROBE, &opts);
+	if (!ASSERT_GE(link1_fd, 0, "link1_fd"))
+		return;
+
+	opts.flags = BPF_F_KPROBE_RETURN;
+	opts.kprobe.bpf_cookie = 0x2;
+	prog_fd = bpf_program__fd(skel->progs.handle_raw_kretprobe);
+
+	link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_KPROBE, &opts);
+	if (!ASSERT_GE(link2_fd, 0, "link2_fd"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.raw_trigger);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->raw_kprobe_res, 0x1, "raw_kprobe_res");
+	ASSERT_EQ(skel->bss->raw_kretprobe_res, 0x2, "raw_kretprobe_res");
+
+cleanup:
+	close(link1_fd);
+	close(link2_fd);
+}
+
 static void uprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
@@ -243,6 +283,8 @@ void test_bpf_cookie(void)
 
 	if (test__start_subtest("kprobe"))
 		kprobe_subtest(skel);
+	if (test__start_subtest("rawkprobe"))
+		rawkprobe_subtest(skel);
 	if (test__start_subtest("uprobe"))
 		uprobe_subtest(skel);
 	if (test__start_subtest("tracepoint"))
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
index 2d3a7710e2ce..409f87464b1f 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -8,8 +8,9 @@
 int my_tid;
 
 int kprobe_res;
-int kprobe_multi_res;
 int kretprobe_res;
+int raw_kprobe_res;
+int raw_kretprobe_res;
 int uprobe_res;
 int uretprobe_res;
 int tp_res;
@@ -37,6 +38,27 @@ int handle_kretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("kprobe/bpf_fentry_test1")
+int handle_raw_kprobe(struct pt_regs *ctx)
+{
+	update(ctx, &raw_kprobe_res);
+	return 0;
+}
+
+SEC("kretprobe/bpf_fentry_test1")
+int handle_raw_kretprobe(struct pt_regs *ctx)
+{
+	update(ctx, &raw_kretprobe_res);
+	return 0;
+}
+
+/* just to trigger bpf_fentry_test1 through tracing test_run */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(raw_trigger)
+{
+	return 0;
+}
+
 SEC("uprobe/trigger_func")
 int handle_uprobe(struct pt_regs *ctx)
 {
-- 
2.33.1

