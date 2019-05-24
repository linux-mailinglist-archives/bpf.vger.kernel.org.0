Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6122629BA2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbfEXP7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 11:59:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34209 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390669AbfEXP7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 11:59:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so10569907wrt.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=E9gKK7YmH0pR7gk3fLXm/ealfjAQNJ0sgX7bsR0M8h9rsjPzo2jBg/Dit9A2OTUzGU
         XZmGXfZ3u/SFQ8a7AdJZUk8tqhFc5M9wKvDy1/TBykNAv77+kYmhe8JPB0Cmh19SrITx
         GGKi/V+syqcDUQVs9V3ZxOt0Dom732G+0ESyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=ZybEi7vyjTE4yIt5lXPMZ/Q5AxqQ+oY6Rm6nw5EwakwcRyOs2QFRhnGS7M2lV91HjD
         +WilnBvfNsDFvWp+60QciXUXVV6uYJnPPbHnyd8WCf05wXAqzB7H8D6HLUmgpfXgSi2V
         EZuiT1a+p749fAZk3nnmptw4ZsR43xGekmU2v2oywyRxXjVZ6t3PQL/438chTNT9SjLO
         z9cdWKYuA5D2Z6UFeCc5zc2jVn2G40hVF710jiOKo1l+ieZLXG2BO0GSpNWF4+iwmcEN
         SSBRfosVnocu3mVzKUTjrZxiuMRcfw0KXJFSqLiqXnYfCGLgM0ZhIj2dnzo7s6ybQwbu
         yt9Q==
X-Gm-Message-State: APjAAAXa6aLIwA/bQ07bxscAKDC4DbjgyCSw4AXYsZckRG2Ez4KgHrl2
        2PTUQTcbv7Rn+IO7N/SIMmKK0g==
X-Google-Smtp-Source: APXvYqywt/PoLflYA+NpdNVy44D4ERB1Ci5BUNDxQ1MXj4L11orInMGwVat9DDAcLlir0teyGDpJ1A==
X-Received: by 2002:adf:f988:: with SMTP id f8mr3227533wrr.254.1558713588616;
        Fri, 24 May 2019 08:59:48 -0700 (PDT)
Received: from locke-xps13.localdomain (69.pool85-58-237.dynamic.orange.es. [85.58.237.69])
        by smtp.gmail.com with ESMTPSA id i185sm4535054wmg.32.2019.05.24.08.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:59:47 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 4/4] selftests: bpf: verifier: read netns_dev and netns_ino from struct bpf_sock_ops
Date:   Fri, 24 May 2019 17:59:31 +0200
Message-Id: <20190524155931.7946-5-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524155931.7946-1-iago@kinvolk.io>
References: <20190524155931.7946-1-iago@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Tested with:
> $ sudo ./test_verifier
> ...
> #905/p sockops accessing bpf_sock_ops->netns_dev, ok OK
> #906/p sockops accessing bpf_sock_ops->netns_ino, ok OK
> ...
> Summary: 1421 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v1:
- This is a new selftest (review from Song)

Changes since v2:
- test partial reads on netns_dev (review from Y Song)
- split in two tests
---
 .../testing/selftests/bpf/verifier/var_off.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..9e4c6c78eb9d 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -246,3 +246,56 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
+{
+	"sockops accessing bpf_sock_ops->netns_dev, ok",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 2),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 6),
+
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev)),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 2),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 3),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 4),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 5),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 6),
+	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_dev) + 7),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+},
+{
+	"sockops accessing bpf_sock_ops->netns_ino, ok",
+	.insns = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_sock_ops,
+							   netns_ino)),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+},
-- 
2.21.0

