Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C062F484752
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiADSAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiADSAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 13:00:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59105C061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 10:00:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso157018wml.0
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 10:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1++MdtwGUVKvSetDOO4bDdTjL/q4+438yAaGXU8tCPQ=;
        b=QL7ucGr+v953FpdQy20GW+4eUvFQNE5lg5JTWpTNEofUYbOFXpnx1g4bYTtj/5ekkB
         ib6yjmeIasxu8X1inYdo4ziXfM1AnzZjD0kw82Q7ItIYrAZCQlQIP8b5wNt1W3HRkbIW
         8XwTNU1OYeSyYJOeuWD3ict2AohJ3mkvZa55mYVJZz2XGm84YLQA8GGPyoav4809E9Wl
         jXxxDeMBNswkl2Z/56bfyED4pluW8FuXvx/vjjcrnneggi1W2Wgy6kVGM/G5J7Aa7XNn
         2PacIwq1R7Ut2NKbP7pbopMrOM6U0m5KvKNWmq0aATRuMrCSLBO8TLj6QBU1TdIxRVud
         vMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1++MdtwGUVKvSetDOO4bDdTjL/q4+438yAaGXU8tCPQ=;
        b=XwjsqcumgDWsJ4HV9lG/Eyap7hiQkML7mQzdjTne/BcfDe3OHH38+0TrQKmcQHh7a7
         cgJa1Yj8uj2cCCtEWiggE5q8hjMTGinvdG8C+SiFjg67t335IImJE698sxWWv5jPSttE
         JCO8s1pe7X+J21pBPFG8lK4eCZKl5oCmFC9BP+IpsPWHRM+oRtJQ/xtHwXPlt/9Yd9m1
         43d7qgFGiWAu7xCqLz++UOHjl1oxWBn+nKVgQeMNNMZnIsL9C6gKT/ZqGhKgT76i8n+H
         ehNLifyhZuV1BbOSCVJKvUmRsAlJPXeyx/R+mvYlYD9MRpObif8n07c6LXfxTYqqJ7kK
         UCjQ==
X-Gm-Message-State: AOAM533ydkNZ/gBiwptbqLk+a/n2rqn4vYZHvL/R1eVK0QePRmbqKo2h
        fh0zww3QRWmCJheC9A1XHlTu
X-Google-Smtp-Source: ABdhPJyO7UHSRS5jYj19PIbjeBCB0ljBQs1SwDCXigNdPMUI0mxY2nF6AchTrsBt8o2WNfiuLkIceg==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr18912866wmc.75.1641319214934;
        Tue, 04 Jan 2022 10:00:14 -0800 (PST)
Received: from Mem (2a01cb088160fc006dcbec8694cd1f89.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6dcb:ec86:94cd:1f89])
        by smtp.gmail.com with ESMTPSA id l13sm43334786wrs.73.2022.01.04.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:00:14 -0800 (PST)
Date:   Tue, 4 Jan 2022 19:00:13 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/3] bpftool: Probe for instruction set extensions
Message-ID: <3bfedcd9898c1f41ac67ca61f144fec84c6c3a92.1641314075.git.paul@isovalent.com>
References: <cover.1641314075.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641314075.git.paul@isovalent.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduces new probes to check whether the kernel supports
instruction set extensions v2 and v3. The first introduced eBPF
instructions BPF_J{LT,LE,SLT,SLE} in commit 92b31a9af73b ("bpf: add
BPF_J{LT,LE,SLT,SLE} instructions"). The second introduces 32-bit
variants of all jump instructions in commit 092ed0968bb6 ("bpf:
verifier support JMP32").

These probes are useful for userspace BPF projects that want to use newer
instruction set extensions on newer kernels, to reduce the programs'
sizes or their complexity. LLVM already provides an mcpu=probe option to
automatically probe the kernel and select the newest-supported
instruction set extension. That is however not flexible enough for all
use cases. For example, in Cilium, we only want to use the v3
instruction set extension on v5.10+, even though it is supported on all
kernels v5.1+.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 03579d113042..e999159fa28d 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -708,6 +708,48 @@ probe_bounded_loops(const char *define_prefix, __u32 ifindex)
 			   "BOUNDED_LOOPS");
 }
 
+/*
+ * Probe for the v2 instruction set extension introduced in commit 92b31a9af73b
+ * ("bpf: add BPF_J{LT,LE,SLT,SLE} instructions").
+ */
+static void
+probe_v2_isa_extension(const char *define_prefix, __u32 ifindex)
+{
+	struct bpf_insn insns[4] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JLT, BPF_REG_0, 0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN()
+	};
+
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_v2_isa_extension",
+			   "ISA extension v2",
+			   "V2_ISA_EXTENSION");
+}
+
+/*
+ * Probe for the v3 instruction set extension introduced in commit 092ed0968bb6
+ * ("bpf: verifier support JMP32").
+ */
+static void
+probe_v3_isa_extension(const char *define_prefix, __u32 ifindex)
+{
+	struct bpf_insn insns[4] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP32_IMM(BPF_JLT, BPF_REG_0, 0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN()
+	};
+
+	probe_misc_feature(insns, ARRAY_SIZE(insns),
+			   define_prefix, ifindex,
+			   "have_v3_isa_extension",
+			   "ISA extension v3",
+			   "V3_ISA_EXTENSION");
+}
+
 static void
 section_system_config(enum probe_component target, const char *define_prefix)
 {
@@ -823,6 +865,8 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
 			    define_prefix);
 	probe_large_insn_limit(define_prefix, ifindex);
 	probe_bounded_loops(define_prefix, ifindex);
+	probe_v2_isa_extension(define_prefix, ifindex);
+	probe_v3_isa_extension(define_prefix, ifindex);
 	print_end_section();
 }
 
-- 
2.25.1

