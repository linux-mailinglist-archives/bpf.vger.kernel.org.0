Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48842DB77
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJNO2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhJNO2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:28:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445EC061753
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so20046075wrv.9
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+uJr5hp/PrwImyhLww643udSk+FgvtkOnzEH/iiMXA=;
        b=x2fzdmMSRhyCU3dbpcXq3f4TOFHCtRAG3Q2rGhe2H5ELOT1CpqVXnBWY1E3z6p5u6C
         W2kl7W/6+YTDBSd7Xj3o7MEX3e1NCRMRa4TPCQ3Ns9C12d4kU5pd2phJhneXg8LJ0J4r
         8Q8mXJ3vykXbQQ4lxkMZBGAQL7gL65H60WsU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+uJr5hp/PrwImyhLww643udSk+FgvtkOnzEH/iiMXA=;
        b=4A3RZdY8wF2xe5tCn4d2CyaezIl7iylv5rmsoOwqu9EgNfdHtF6e/sw8vCjo1DY6Q9
         xJDbgesspeA9C52ButGxPRwQ6MoEYtQ+fnu///6WOaFa+Lf1Ueim6/I0fq2UXuEzYcru
         5Q1f5QQzCWbu/X9viAYrt7GBLPIfaQFIqKB5Cuu22YWpvVas1T15Zo9Ns1CjxE9Ilyfp
         p7VkE+YbGkLkXtq+Xqr/V4D8Hqkvwn7q9mutdvPBN+PlOvFmaXiaOicQFfmENz5+76Us
         GLzgj1rMysZrv02rau2anknHFzXlyqAQ+RwIwAkyRbRO4sumCSRwz1slhlJjyQjAEacd
         VoAQ==
X-Gm-Message-State: AOAM533G9JwvHoS9auRwXZ9mkf0+YGVdJcK4UKvKKBvQeTmeiS9MquVh
        MVRLcM2cr5atu0FAyKLGq2hadQ==
X-Google-Smtp-Source: ABdhPJxSreZiUluGclCO7ih/fTRXwuaw9OMXuN55jnTqByIvdDxPXk6++hqqara4PlR/5NHW91bnrg==
X-Received: by 2002:adf:aadc:: with SMTP id i28mr7004852wrc.320.1634221564751;
        Thu, 14 Oct 2021 07:26:04 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id e8sm3731111wrg.48.2021.10.14.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:26:04 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     nicolas.dichtel@6wind.com, luke.r.nels@gmail.com,
        Xi Wang <xi.wang@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] bpf: define bpf_jit_alloc_exec_limit for riscv JIT
Date:   Thu, 14 Oct 2021 15:25:51 +0100
Message-Id: <20211014142554.53120-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014142554.53120-1-lmb@cloudflare.com>
References: <20211014142554.53120-1-lmb@cloudflare.com>
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

