Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7CC4A7A11
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 22:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbiBBVNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 16:13:39 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33661 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347455AbiBBVNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 16:13:36 -0500
Received: by mail-wr1-f47.google.com with SMTP id e8so1041766wrc.0;
        Wed, 02 Feb 2022 13:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2Gqq2MTfanNuVcAI9pdQHLlI3S1ptsWVHsIqdxZljo=;
        b=OziXhb67AlrEpXGIFgXElrzIpe94yxZsgIH4pHtxD3Jh8XVQd7ghyJwBDCCVpmkhdY
         bD3iS21FzQuyrE6CHE6n5ZfZ0hjQW4xeSojPrMIimlFsfYKY+MY98sZTDnsmSfYBObSF
         j+Ylrmko3XnmWVH0OXJpOXj4iyGCfT9pB4HfhdU17DvckHXB1HtFqVs3PO53sW+n4nSX
         rda4JyGTtyevid3ZLxKqoz1hBgzBZ4ASJka1v1mm+RZwR7JCk3Vi34OKG1oJJa7ktAlW
         zjspmhUv9h2tanjT3Jay0ac2OPNSc0t+GFA9yIenvUcPy5kTj+7OdfFmfjqEKryXUM5x
         Ofzg==
X-Gm-Message-State: AOAM530zNFiSDDpe1ezeqwTmvB245hPq7rWdbpsAafitFl+H9EgbaJ6n
        YcBcTmXbmTS5yvYn+oevJkM=
X-Google-Smtp-Source: ABdhPJyNiOA1C3C0c/vkkmFaa0CHhtAQeoW6+YA/OW+xpW3cz4rdJuQir6nJ6X8wVOXgLQt8W0yn/g==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr27885019wru.551.1643836415489;
        Wed, 02 Feb 2022 13:13:35 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id f5sm13914322wry.64.2022.02.02.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:13:35 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test maximum recursion depth for bpf_core_types_are_compat()
Date:   Wed,  2 Feb 2022 22:13:28 +0100
Message-Id: <20220202211328.176481-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202211328.176481-1-mcroce@linux.microsoft.com>
References: <20220202211328.176481-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

bpf_core_types_are_compat() was limited to 2 recursion levels, which are
enough to parse a function prototype.
Add a test which checks the existence of a function prototype, so to
test the bpf_core_types_are_compat() code path.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  3 +++
 tools/testing/selftests/bpf/progs/core_kern.c      | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 595d32ab285a..a457071a7751 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -13,6 +13,9 @@
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
 
+typedef int (*func_proto_typedef)(long);
+func_proto_typedef funcp = NULL;
+
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
 
 noinline void
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
index 13499cc15c7d..bfea86b42563 100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -101,4 +101,18 @@ int balancer_ingress(struct __sk_buff *ctx)
 	return 0;
 }
 
+typedef int (*func_proto_typedef___match)(long);
+typedef void (*func_proto_typedef___doesnt_match)(char*);
+
+int out[2];
+
+SEC("raw_tracepoint/sys_enter")
+int core_relo_recur_limit(void *ctx)
+{
+	out[0] = bpf_core_type_exists(func_proto_typedef___match);
+	out[1] = bpf_core_type_exists(func_proto_typedef___doesnt_match);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.34.1

