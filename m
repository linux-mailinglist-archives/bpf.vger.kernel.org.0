Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D14F42A696
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhJLOBr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbhJLOBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 10:01:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33288C06161C
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e3so33635220wrc.11
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+uJr5hp/PrwImyhLww643udSk+FgvtkOnzEH/iiMXA=;
        b=S54KEdJVG5PidXuDq9r16txvb2g/cP+3eW8Jwk8oD7+pSdOTA4ADJE+GWkNmKRn6xt
         E7ze+GwF/sNaoP3DUf9kqKEz1SuoC80Sab8lMxVpP4OZf9B9VIu8Cgce9Pqjgwvale19
         ffQIHz52YRLNkhSog3jdhhM1IWstr0eIylMJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+uJr5hp/PrwImyhLww643udSk+FgvtkOnzEH/iiMXA=;
        b=bVwSx6xdpxBIGeNm+nQ5J/0Qxda8XYMUs3dLuFmP5UChpdq58dUznZEn+zcFuzRkeI
         kryghHFLMR3fRmB66B26bO/vv+B+1yBXY4V7sbBzlr9Zyg4/+OCtvsIdVURVIVpjFRd8
         b7uBOcmrjZR59gr8Oe3woViF9DXi6YIVoCAgrXipiHjIX8MlVIhZBlEN0ZDjHsC3bl9X
         nffqEnjFUPhS73plX1JlxAQK0sKS+vJjkGVVSTPR5ypqKNl14LfIf+7m5Jvk4j3HxMMc
         n2vM8mLUdYwWprW0L1xIb9dmqm25wW7MIp3Egkg77ID6e52q5sdkVr0tfXUxn1VODLrE
         J06A==
X-Gm-Message-State: AOAM530PuhnmPueeY/BLOA3cGuuJAWBnY3ZXvZKYXEMrCxz8CtpfYpf9
        pgSZhnMfM0SWKB5evaBddBmDUA==
X-Google-Smtp-Source: ABdhPJylp2yWYbawmjfOTMiLcasdN+Z6efwR6pCAb6UhqxWGMRgLmOkn2eCFQKHgteNVV4kv6gQhYw==
X-Received: by 2002:adf:9bce:: with SMTP id e14mr31937800wrc.353.1634047183850;
        Tue, 12 Oct 2021 06:59:43 -0700 (PDT)
Received: from antares.. (d.5.b.3.f.b.d.4.c.0.9.7.6.8.3.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1386:790c:4dbf:3b5d])
        by smtp.gmail.com with ESMTPSA id o6sm14875894wri.49.2021.10.12.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:59:43 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     nicolas.dichtel@6wind.com, luke.r.nels@gmail.com,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] bpf: define bpf_jit_alloc_exec_limit for riscv JIT
Date:   Tue, 12 Oct 2021 14:59:32 +0100
Message-Id: <20211012135935.37054-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012135935.37054-1-lmb@cloudflare.com>
References: <20211012135935.37054-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Expose the maximum amount of useable memory from the riscv JIT.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/riscv/net/bpf_jit_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index fed86f42dfbe..0fee2cbaaf53 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -166,6 +166,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	return prog;
 }
 
+u64 bpf_jit_alloc_exec_limit(void)
+{
+	return BPF_JIT_REGION_SIZE;
+}
+
 void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-- 
2.30.2

