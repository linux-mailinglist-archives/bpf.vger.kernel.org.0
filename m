Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3D4E8197
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiCZOp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Mar 2022 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiCZOpl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CC216F9A
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 07:43:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s8so8832779pfk.12
        for <bpf@vger.kernel.org>; Sat, 26 Mar 2022 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RK2Z+oyhsk4J+g9Lm/iw5dIzfcQJf2YE8IxM8Ox8T8=;
        b=L6+n2qN0NB9H/y7g1TivQv/x4fR9f+2tqUK1xxQqydoD5cBIOD7UjqHGhLTerZ3YwM
         mjcDt1dLumznfbUAAck3R4Z/8Hkdn5xGl0sVQdBHoaMIqku9k/3MbA6/OGWFfBHU/ujO
         rCct+k2PlfMDjUcLu5rtAqZ61gSXZ1J8F78Ekh/lXSdw4QLMeR9VIPrOXAZDV2yNqHTs
         zfLf8zCPU/az4u/6xMiuOHgo4LmcNMyl9n0aV/X2t36HU5bW2S4Z+wmDgz8Bu2aPHVA4
         Eq1CQ/p/pjB8LAEwXQew3KVvmA+YWavXK9v/qCPdAiISBPcVXQ2pnE4yeaILu+piB8nq
         fd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RK2Z+oyhsk4J+g9Lm/iw5dIzfcQJf2YE8IxM8Ox8T8=;
        b=HRX6QKyIKn4acUadzzXUiOHeA2XYbWdmB+QE1npUzRnahBYCEEXX2vIzL+wHEs7hei
         oU7govI/aq4LR/4so36lkCYBMaosKHPLKnkahErMevG2X4AorHPPEI9LwWvSM68cKGuF
         W+2HmLujlAgwndmbNJL0AIvAPxq3d34oHnIw2iSK9wRi4NZv2WcJqd5WfjDa+EocNp3J
         dN8QCDc2rRFYV0IkTrCgYT+MVjYaCB1oywGSp0T1BvUH54cgB5tpqO+fUVr7KVMPAVoZ
         r8EXXkpJ7TR028tnw30zLlcZTPnLCdNFISFS1/5uhd8lVkB+8yHETwPz6KshtqkpLgzD
         PymQ==
X-Gm-Message-State: AOAM530tbVjplbRXu3TzgxOin/KxNQaeGCL+cG5teBaPrKmJvq0w729/
        r0C1av4D5O+jW5LM5MUdOdtImx5OQS8=
X-Google-Smtp-Source: ABdhPJzhAK6Fo02fJPu49mVhNR2IJC++Nh9vm9an8VeP3FAaqIMKkdvO9/vtvqd8ph7Fs2SsvVVhhg==
X-Received: by 2002:a63:d4e:0:b0:381:33fb:1538 with SMTP id 14-20020a630d4e000000b0038133fb1538mr3660900pgn.492.1648305827816;
        Sat, 26 Mar 2022 07:43:47 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm9281495pjd.15.2022.03.26.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:47 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs interface
Date:   Sat, 26 Mar 2022 22:43:20 +0800
Message-Id: <20220326144320.560939-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On some old kernels, kprobe auto-attach may fail when attach to symbols
like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
but don't allow attach to a symbol with '.' ([0]). Add a new option to
bpf_kprobe_opts to allow using the legacy kprobe attach directly.
This way, users can use bpf_program__attach_kprobe_opts in a dedicated
custom sec handler to handle such case.

  [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 9 ++++++++-
 tools/lib/bpf/libbpf.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 809fe209cdcc..9a294bb84bad 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10097,9 +10097,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
 	static int index = 0;
+	int i;

 	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
 		 __sync_fetch_and_add(&index, 1));
+
+	/* sanitize .isra.$n symbols */
+	for (i = 0; buf[i]; i++) {
+		if (!isalnum(buf[i]))
+			buf[i] = '_';
+	}
 }

 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
@@ -10189,7 +10196,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);

-	legacy = determine_kprobe_perf_type() < 0;
+	legacy = OPTS_GET(opts, legacy, false) || determine_kprobe_perf_type() < 0;
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
 					    func_name, offset,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 05dde85e19a6..88a3624e3f15 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -413,9 +413,11 @@ struct bpf_kprobe_opts {
 	size_t offset;
 	/* kprobe is return probe */
 	bool retprobe;
+	/* use the legacy debugfs interface */
+	bool legacy;
 	size_t :0;
 };
-#define bpf_kprobe_opts__last_field retprobe
+#define bpf_kprobe_opts__last_field legacy

 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
--
2.30.2
