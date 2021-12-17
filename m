Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFE478CCE
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 14:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhLQNwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 08:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhLQNwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 08:52:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB1C061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 05:52:07 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r17so3842788wrc.3
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BXYvhD66m9qpew2FPguNtB1xEh61JrPI9dWMrSoJbWk=;
        b=IZVQ/4KE/ygWz48NKMaB/422pHUYknCW0AW7tISThNA4nyigvJ0yhCksx9N/bugl3B
         cNk66wY6RGIkYQ+vejm2m7imjiIFlljV2zdYcBLKDHOgflZr4e6wQj7FlqF6wE+olR4c
         O040JwtsGeTFir85IyLDMFOqStfE+jePrFP8kQebBoxt45CcSkv8HS0K3pRttCXpj2yD
         i261ZXYkFQu7VkcFQT0MIJQ0HHbXKezxWjEhRL3RQtJ542Drh9dAAHtEwDeMI7UjvIul
         /48KYT4Qg1SoSLV2i2xeWEAMNZAIHb7ZUGxDfPVLUwPaWcY8nNAEh/4zoo4KS7kd4YGu
         8Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BXYvhD66m9qpew2FPguNtB1xEh61JrPI9dWMrSoJbWk=;
        b=Fh4gbiuc1o4JSjxuqnUGNueISx3ucnPyQsPindPyOVRsw5R1ZJyEqygd1lonYEzt0/
         /fOGtk1BCnKQbY6b0+3KrwzykZf0dvX8etU1ItLifgv0TtPrXj0dZt1wAeB84c5jTH6y
         fMztA/lLxWL4KzUyYyyFx+p1guiwHa6b5ASE4h9ejHgwzR1v2hD4Jw+m4txfQr0Qka9m
         oZndG+mDOU/n1lE+PIQpFKWwc5GLU9pPjZfwXtc7FxKAH5jswH+cGWVb9y+paay+9pck
         r/cAu1Q73k8stGomC6gMcVVeB8kp5MLTYVuj0rmkgeLKT34+CXX5M1ooKFM+uugkBwL+
         eRag==
X-Gm-Message-State: AOAM5314Nibnl1OSNZ5Widc1l4D58oWpeudpwjn53nFh3T6D6/MKBxUS
        AnSQ8xge52AUHGoYjQX40nU3
X-Google-Smtp-Source: ABdhPJxVhD5h89F4ke06EdIJFLmfoLjffR4UZ++AajqsXFDHKBWoCgGesbzflTCLXqUZZrmIe1Ce2w==
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr2542102wrq.17.1639749126147;
        Fri, 17 Dec 2021 05:52:06 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id d2sm3606309wrw.26.2021.12.17.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:52:05 -0800 (PST)
Date:   Fri, 17 Dec 2021 14:52:04 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: Probe for bounded loop support
Message-ID: <7dfdf3f93467c619c14c40e957c54b87bb734294.1639748569.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduces a new probe to check whether the verifier supports
bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
bounded loops"). This patch will allow BPF users such as Cilium to probe
for loop support on startup and only unconditionally unroll loops on
older kernels.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
Changes in v2:
  - Resending to fix a format error. I had the good idea of saving the
    patch in Gmail as a draft before sending with mutt, which caused
    Gmail to remove the trailing space in the Git version signature.
    That then caused pathwork to generate an incorrect mbox file.

 tools/lib/bpf/libbpf.h        |  1 +
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 42b2f36fd9f0..3621aaaff67c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1058,6 +1058,7 @@ LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
 LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
 				 enum bpf_prog_type prog_type, __u32 ifindex);
 LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
+LIBBPF_API bool bpf_probe_bounded_loops(__u32 ifindex);
 
 /*
  * Get bpf_prog_info in continuous memory
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b3938b3f8fc9..059d168452d7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -423,6 +423,7 @@ LIBBPF_0.6.0 {
 LIBBPF_0.7.0 {
 	global:
 		bpf_btf_load;
+		bpf_probe_bounded_loops;
 		bpf_program__log_buf;
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4bdec69523a7..e5bd691059e4 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -356,3 +356,23 @@ bool bpf_probe_large_insn_limit(__u32 ifindex)
 
 	return errno != E2BIG && errno != EINVAL;
 }
+
+/*
+ * Probe for bounded loop support introduced in commit 2589726d12a1
+ * ("bpf: introduce bounded loops").
+ */
+bool bpf_probe_bounded_loops(__u32 ifindex)
+{
+	struct bpf_insn insns[4] = {
+		BPF_MOV64_IMM(BPF_REG_0, 10),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -2),
+		BPF_EXIT_INSN()
+	};
+
+	errno = 0;
+	probe_load(BPF_PROG_TYPE_SOCKET_FILTER, insns, ARRAY_SIZE(insns), NULL,
+		   0, ifindex);
+
+	return !errno;
+}
-- 
2.25.1

