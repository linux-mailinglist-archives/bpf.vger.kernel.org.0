Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8F484751
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiADSAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 13:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiADSAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 13:00:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0492AC061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 10:00:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so1887685wmb.0
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6wZh1urzx3jgq42hunOJWsEpPnLLAuBD2+D/o8QAvX4=;
        b=VcyDVOQJyaVvG+plCwMKn/EwIZVos/QxZ0Vls16gBc8oNMTozErZgavxvwsBOCuse9
         vdpXS3I1HKlUQ2V7IfFeW3C9v5oXZ3D+ttWqsTBEnN/bKcFY5Vt6Y58GYz1WMzFEuXQF
         ZzI9nTQo5/0Sjs4cLFrXao9pF88CpzHu5QPeF3YeD55OJ2JS6smEk+KUJeiQf8rNG1Bi
         TqmWJ10khbSF8bwnMNw7ipHSBvz2MgRvbgub09f8pWhjxVucDWRUQswpfw36qZBEqW5Q
         t/eat88v+dbEcNOWuhTa+V6DjtLy+bEORMfAeVYhCGWS0R7bXHUgkYjYOmftspuJa9kf
         9DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wZh1urzx3jgq42hunOJWsEpPnLLAuBD2+D/o8QAvX4=;
        b=ZetTGr6KxmyqaezCtf3hyI7UImZug1DL2ZkIU+VpcUpjCUussaqc3+RvvJnySf6Dx4
         WqP4aR/E96+uF3N5m4WadqrNUnH4d9aMD+TeICyueAvCWIvUvSvZ9gSh2pftR7f1/+9j
         YWrKm0+1IC8NKMnVOVAHBF7hHegEyzcE11ZoLlDWVQFie9cA0GTIqra74NKDzEP7Tc+4
         l/P0PPdOKETARtUeHCCInIUFf8jQI7E0F/LEHW5FKwn5xYGpLq5iGK7KXHXVqn4TnqJ9
         CElX2cSbnMWo5QE9laM4NLgLiiRR/e5XLJtYAsq5dvb2inIA6qz4Z7iwEu/pk6zrbIdL
         mJUQ==
X-Gm-Message-State: AOAM532saAXCVKk6CY0Pa187+KNZdHSzPQ8stI9EqGdJk2G3Y4ZGCtya
        GYhp2x7zSnd5eREEYJyuMosA
X-Google-Smtp-Source: ABdhPJzp3tC39ZWH4F8G5EifkjjkheK6fp2BHk+hR0RNoEp1FuNlY8N39VzKIgGIiNY7OFW6HtvKWw==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr43557563wmc.149.1641319198619;
        Tue, 04 Jan 2022 09:59:58 -0800 (PST)
Received: from Mem (2a01cb088160fc006dcbec8694cd1f89.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6dcb:ec86:94cd:1f89])
        by smtp.gmail.com with ESMTPSA id d143sm81984wmd.6.2022.01.04.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:59:58 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:59:57 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/3] bpftool: Probe for bounded loop support
Message-ID: <f7807c0b27d79f48e71de7b5a99c680ca4bd0151.1641314075.git.paul@isovalent.com>
References: <cover.1641314075.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641314075.git.paul@isovalent.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduces a new probe to check whether the verifier supports
bounded loops as introduced in commit 2589726d12a1 ("bpf: introduce
bounded loops"). This patch will allow BPF users such as Cilium to probe
for loop support on startup and only unconditionally unroll loops on
older kernels.

The results are displayed as part of the miscellaneous section, as shown
below.

  $ bpftool feature probe | grep loops
  Bounded loop support is available
  $ bpftool feature probe macro | grep LOOPS
  #define HAVE_BOUNDED_LOOPS
  $ bpftool feature probe -j | jq .misc
  {
    "have_large_insn_limit": true,
    "have_bounded_loops": true
  }

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 3da97a02f455..03579d113042 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -687,6 +687,27 @@ static void probe_large_insn_limit(const char *define_prefix, __u32 ifindex)
 			   "LARGE_INSN_LIMIT");
 }
 
+/*
+ * Probe for bounded loop support introduced in commit 2589726d12a1
+ * ("bpf: introduce bounded loops").
+ */
+static void
+probe_bounded_loops(const char *define_prefix, __u32 ifindex)
+{
+	struct bpf_insn insns[4] = {
+		BPF_MOV64_IMM(BPF_REG_0, 10),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -2),
+		BPF_EXIT_INSN()
+	};
+
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_bounded_loops",
+			   "Bounded loop support",
+			   "BOUNDED_LOOPS");
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -801,6 +822,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
 			    "/*** eBPF misc features ***/",
 			    define_prefix);
 	probe_large_insn_limit(define_prefix, ifindex);
+	probe_bounded_loops(define_prefix, ifindex);
 	print_end_section();
 }
 
-- 
2.25.1

