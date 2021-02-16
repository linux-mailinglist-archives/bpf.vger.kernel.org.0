Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E331C943
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBPLCj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 06:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBPLAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 06:00:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E7C061797
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n6so12357304wrv.8
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBv+5MRiPKNFrO7CQEt+NYcgc+kgvHjv52FGJd36h2Q=;
        b=i86ku6Ry9W6yu653Vazsiiih6hdh/ynxtulsqZuUH0AWZgDZ0M3qAcGjws9m1v69pc
         UqjOogxVEz+LxC7z2B2pNDXrqjmnnopYCOhrU5TDtJ6Pm8UgBwiCvc3GGxyEVlU4nvM/
         +qS9+DYO8ChiKKBNJcRoB2i1fVnHDHX/j/Zbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBv+5MRiPKNFrO7CQEt+NYcgc+kgvHjv52FGJd36h2Q=;
        b=FBdy3nXID1GuSoHSXuK8zyZ2+PkbeXg1XnApm/GKYNaj3k1fJQ6R0/61y59L2kT63g
         cxyxXSfrjtaQjjGlFZni8mp3muw85Aj1vM5mIyuK7R6Wyvuwe2QQIJ+eltp7xZQbmvE1
         LCMOoZmciKXokdSBjNkMBfb11T+lQ2N/kTbMkZ7gMEsqS0WyS8sJ3Sx28leNPIPxxD4y
         lfjL6Vh988UrLeuiTDXHpSE+FHMs78LCtJa3ueeYsyXdMUFYh3DOEDgcb0nO/DsPN8EF
         Z1vK/8Np8WzDKXyM0DvAQYueXCFkPm8jlhNp2wQCuh7RZ+AryET4HLhV2C2f/ZgQNfak
         Od+w==
X-Gm-Message-State: AOAM532iWHGws9aEXg8WaxwfZHKmD9AKy0LLjtYKwKrfRjg7vRoCztay
        9FG65J6POwJLRTIr8hIE75e1Yg==
X-Google-Smtp-Source: ABdhPJyNZL0iXaYzqkb2LjvXU4CpSaA/7gfgQSux3cXygbPa3aJKaVL3dVFgsVBRKqw/UbIUsELxxA==
X-Received: by 2002:adf:c6c1:: with SMTP id c1mr23474650wrh.326.1613473099806;
        Tue, 16 Feb 2021 02:58:19 -0800 (PST)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l1sm2820238wmi.48.2021.02.16.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 02:58:19 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jakub@cloudflare.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 5/8] tools: libbpf: allow testing program types with multi-prog semantics
Date:   Tue, 16 Feb 2021 10:57:10 +0000
Message-Id: <20210216105713.45052-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210216105713.45052-1-lmb@cloudflare.com>
References: <20210216105713.45052-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a wrapper bpf_prog_test_run_array that allows testing
multiple programs for supported program types.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/lib/bpf/bpf.c      | 16 +++++++++++++++-
 tools/lib/bpf/bpf.h      |  3 +++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index bba48ff4c5c0..95ec1a3f0931 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -765,6 +765,14 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
 }
 
 int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
+{
+	__u32 fd = prog_fd;
+
+	return bpf_prog_test_run_array(&fd, 1, opts);
+}
+
+int bpf_prog_test_run_array(__u32 *prog_fds, __u32 prog_fds_cnt,
+			       struct bpf_test_run_opts *opts)
 {
 	union bpf_attr attr;
 	int ret;
@@ -773,7 +781,6 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 		return -EINVAL;
 
 	memset(&attr, 0, sizeof(attr));
-	attr.test.prog_fd = prog_fd;
 	attr.test.cpu = OPTS_GET(opts, cpu, 0);
 	attr.test.flags = OPTS_GET(opts, flags, 0);
 	attr.test.repeat = OPTS_GET(opts, repeat, 0);
@@ -787,6 +794,13 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
 	attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
 
+	if (prog_fds_cnt == 1) {
+		attr.test.prog_fd = prog_fds[0];
+	} else {
+		attr.test.prog_fds = ptr_to_u64(prog_fds);
+		attr.test.prog_fds_cnt = prog_fds_cnt;
+	}
+
 	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
 	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 875dde20d56e..47a05fdc9867 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -278,6 +278,9 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+LIBBPF_API int bpf_prog_test_run_array(__u32 *prog_fds, __u32 prog_fds_cnt,
+					  struct bpf_test_run_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1c0fd2dd233a..bc3a0b2d645f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -340,6 +340,7 @@ LIBBPF_0.2.0 {
 
 LIBBPF_0.3.0 {
 	global:
+		bpf_prog_test_run_array;
 		btf__base_btf;
 		btf__parse_elf_split;
 		btf__parse_raw_split;
-- 
2.27.0

