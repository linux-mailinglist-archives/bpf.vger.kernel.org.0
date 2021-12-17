Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B74478B1D
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 13:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhLQMM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 07:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLQMMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 07:12:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7AC06173E
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 04:12:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so3687563wrg.1
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=utqqd9ci6ew41O6zf0YypR+5F7H5LySynYJvMT/qY0g=;
        b=pPdHYvSd/UbI9WiPpDhuC+kvi0n2HmBey4Po86xsp+tkad8dPX8ize9kOeV6XGd351
         uMcP7pg39hcsAqd2oXbrPybnTcujE3WESIxQArZn3h+vtVSTmZ2i/YNytdlHTdcc9SHA
         tzETivfo6YDqOGbu48M8G57bC67T6IN2AlmpmNZYJpTzz/c8zPXoh3Pfy7VBfB3zflgj
         C1XOAkt00jIwokaRNpGf+EW/3Mk48FOEfFEugYdM/Ir4RSLOqYFCWobUJ94DCbe2fuYw
         ok9oRArgumiD62B2VhQgNvwnOTTPmTAhFuxSC8984mfMK0zAS6iQ6TuhOxNatODUIvuw
         Gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=utqqd9ci6ew41O6zf0YypR+5F7H5LySynYJvMT/qY0g=;
        b=WfQ3tComMc8B58ZFUfpvaDWwEGmerZcsg61kD4PU0GsnbMwuDn35R0E5DUM5VLP360
         m/bVGRKrFmiu7zd+XnYLsvZ6U4z/Xxq0GEFZASPUcKdjVkAZHTJQYG2pLN3353gp8K2E
         kSfVuTQHtu03wGmLT7P5evVYqZAAYDlDNr3SaXSBzfpYIz/GvWKNnWqY4xCm5obt/f4l
         TMuYAB0LLxqAuRrTKribvh1ICUZmEGR6FWbncXSaBFf/gMfCNXHX/KIdPlVtWK96ZxdO
         a0k9NF9vEdaRyceBTc296XF5wtgE2yNpQGMMQKHQPzN+j0edfq29pqrxi9fv1HIyQDrv
         C2og==
X-Gm-Message-State: AOAM531jl4W8hy68/g41xrhfPtWd4wTCD/VACjCTptwbdiFqxgypnPsJ
        LnICK79XtMzOhclGikpo5sfvbAzhTU3247A=
X-Google-Smtp-Source: ABdhPJx5sqf8scmxXWVBQ+EH+H7sAvMhMrx1KiO/VOA5/erUmIrficREs7csxe8cIPBGXkTF88u8RA==
X-Received: by 2002:adf:f252:: with SMTP id b18mr2341745wrp.341.1639743141114;
        Fri, 17 Dec 2021 04:12:21 -0800 (PST)
Received: from Mem (2a01cb088160fc0089020d359cf3dd66.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:8902:d35:9cf3:dd66])
        by smtp.gmail.com with ESMTPSA id g198sm8381296wme.23.2021.12.17.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 04:12:20 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:12:19 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/2] libbpf: Probe for bounded loop support
Message-ID: <CAHMuVOB16tif6TRjdNVN9YjGc-UpOOwuo35SM+vY7Bf5=1+oiQ@mail.gmail.com>
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
+               bpf_probe_bounded_loops;
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
+       struct bpf_insn insns[4] = {
+               BPF_MOV64_IMM(BPF_REG_0, 10),
+               BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+               BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -2),
+               BPF_EXIT_INSN()
+       };
+
+       errno = 0;
+       probe_load(BPF_PROG_TYPE_SOCKET_FILTER, insns, ARRAY_SIZE(insns), NULL,
+                  0, ifindex);
+
+       return !errno;
+}
--
2.25.1
