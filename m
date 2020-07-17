Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5090E223974
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQKgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgGQKf7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC30C08C5C0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so12008918ljj.10
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2020 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5grnw5yA7a34ptPfpYZRmkNxHU+5rkM7nQ6am7lk8c=;
        b=XBG78jnwqMDVnAAaKrHTqDPFRvqvWKnPnA+TJDM/54cZRaqb0s/wXUcVGkb08ayXeh
         7ifzOMA6GOvuQ8qC1D2rDMpMvY8hr1J+aQ+wOcLmjCEdlMEb4+DUvzEDOQZoFg5nU671
         bFlG7qxR6+79bKKLrfZZOrSrsPJ1owwiVT7eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5grnw5yA7a34ptPfpYZRmkNxHU+5rkM7nQ6am7lk8c=;
        b=hmWvMu2suWCGbxxMS2VC1gSVius0+bCZEXc4P2DCrlme4s+2yt0uwP3mMyh5AhWRhJ
         p1Bu7Ho33cIbVnjUDINLqn8xm+zYi4ud9lMgb1aCQd3mGu1/qZfNMAXmipduFWPK3T3D
         6vP7waoULWsljcb1tLM6tLXKoKldF7kHCwYHj79YBHefNGmi+DZFryiwklhuEx20aViu
         PJjnLG1xjanXUfj9zS86g1kPm1CliDrei72ezfckpmpQ3ZFcvj9AhNRrEmf5mb2SZkV/
         ld+H3Fz/4SzcJ8IvlgMfE7VDLBeGEhg4raNRholzz0+fY9oXS0JF/CQkXXwCFrQph+Yr
         xQbg==
X-Gm-Message-State: AOAM532HjV21/lch436LAE5hjgN8X9F2AX1lyaHCfybiRkVrfjFoq5Tl
        O6YovyBGSc+f9PEFCUuGe6R5/mJ3Lukb+w==
X-Google-Smtp-Source: ABdhPJwbpEgdIjJeEQGDVqtsZGaOZcSMPRFXls1XxR6F6tVOY2yC89rT9TN9PoOWCbGXWVuZQps03g==
X-Received: by 2002:a2e:5141:: with SMTP id b1mr3924747lje.336.1594982157197;
        Fri, 17 Jul 2020 03:35:57 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id p8sm1871754ljn.117.2020.07.17.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:35:56 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v5 12/15] libbpf: Add support for SK_LOOKUP program type
Date:   Fri, 17 Jul 2020 12:35:33 +0200
Message-Id: <20200717103536.397595-13-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717103536.397595-1-jakub@cloudflare.com>
References: <20200717103536.397595-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of the newly added program type, and assign it a
section name.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Notes:
    v4:
    - Add trailing slash to section prefix ("sk_lookup/"). (Andrii)
    
    v3:
    - Move new libbpf symbols to version 0.1.0.
    - Set expected_attach_type in probe_load for new prog type.
    
    v2:
    - Add new libbpf symbols to version 0.0.9. (Andrii)

 tools/lib/bpf/libbpf.c        | 3 +++
 tools/lib/bpf/libbpf.h        | 2 ++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_probes.c | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f55fd8a5c008..846164c79df1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6799,6 +6799,7 @@ BPF_PROG_TYPE_FNS(perf_event, BPF_PROG_TYPE_PERF_EVENT);
 BPF_PROG_TYPE_FNS(tracing, BPF_PROG_TYPE_TRACING);
 BPF_PROG_TYPE_FNS(struct_ops, BPF_PROG_TYPE_STRUCT_OPS);
 BPF_PROG_TYPE_FNS(extension, BPF_PROG_TYPE_EXT);
+BPF_PROG_TYPE_FNS(sk_lookup, BPF_PROG_TYPE_SK_LOOKUP);
 
 enum bpf_attach_type
 bpf_program__get_expected_attach_type(struct bpf_program *prog)
@@ -6981,6 +6982,8 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 						BPF_CGROUP_SETSOCKOPT),
 	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
+	BPF_EAPROG_SEC("sk_lookup/",		BPF_PROG_TYPE_SK_LOOKUP,
+						BPF_SK_LOOKUP),
 };
 
 #undef BPF_PROG_SEC_IMPL
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2335971ed0bd..c2272132e929 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -350,6 +350,7 @@ LIBBPF_API int bpf_program__set_perf_event(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_tracing(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_struct_ops(struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extension(struct bpf_program *prog);
+LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__get_type(struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
@@ -377,6 +378,7 @@ LIBBPF_API bool bpf_program__is_perf_event(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_tracing(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_struct_ops(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__is_extension(const struct bpf_program *prog);
+LIBBPF_API bool bpf_program__is_sk_lookup(const struct bpf_program *prog);
 
 /*
  * No need for __attribute__((packed)), all members of 'bpf_map_def'
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c5d5c7664c3b..6f0856abe299 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -287,6 +287,8 @@ LIBBPF_0.1.0 {
 		bpf_map__type;
 		bpf_map__value_size;
 		bpf_program__autoload;
+		bpf_program__is_sk_lookup;
 		bpf_program__set_autoload;
+		bpf_program__set_sk_lookup;
 		btf__set_fd;
 } LIBBPF_0.0.9;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 10cd8d1891f5..5a3d3f078408 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -78,6 +78,9 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 		xattr.expected_attach_type = BPF_CGROUP_INET4_CONNECT;
 		break;
+	case BPF_PROG_TYPE_SK_LOOKUP:
+		xattr.expected_attach_type = BPF_SK_LOOKUP;
+		break;
 	case BPF_PROG_TYPE_KPROBE:
 		xattr.kern_version = get_kernel_version();
 		break;
-- 
2.25.4

