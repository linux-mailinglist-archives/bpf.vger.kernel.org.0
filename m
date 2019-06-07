Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4538C52
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfFGOLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 10:11:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35567 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfFGOLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 10:11:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so3253697edr.2
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=A52/UPhaDFmKTtTG9exlP6gH+yrRJmVwrdz56ohUfKW1gwkj+x4/Dq2PHUdpuj6YZT
         3/pvcYZolg2Xqok2Jijpnu95I/Og/Kfeehoz+bDcnwAmyAxlDjhYJnx0Xz2dbAz90qQP
         Fa2uO6BTJrDA/X2hHq0xwrOt4Te63fRj1iUjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4BYbY0H/gJ/SBV0pW9HBq0oWfzuEg4LxLjaui3637c=;
        b=NZgXEztespVSVclsa/i4nIz7sDvFPmnn1O3y9cu6/XIyqJUSGgn/8ZC7FkqmgHGLUs
         xt8bhK9CpQzMRUHghTv5rmv/cGGb0oEW1enZkQdQ9znAKkKGc8Dzo0WWpal0qHhcDKNF
         qnnhM6w+rX25VqLwhxYk4bOFn+2NL/c8qxZ9ff66CeKuuGMbHGL20nbugHVG/sJ5+ZqE
         BXquRX3x11BvjZkMrpY3sXz5fKzdde1pIFfDe76nAlcocPnwj2yWUT0GIRsmEBcJgvNq
         bN4+c1n2k+eJzfNdgVx+jg6SW6P5Ymm3L2C1WUJrrzLYn29cQaQmjwHzYSkIZ6MeRbx8
         vUWg==
X-Gm-Message-State: APjAAAVsV2h8TnpWPFmJSDScTzOgsCMabdFaxbxNYDXk5UjlZhNIdgKS
        DfjnLzRRqkLn0kX2f/Mo/udjAA==
X-Google-Smtp-Source: APXvYqwLVNr+7w9/STmzWhSBQ6bLcxrBsjntrXkA1h+OPVqNKlLghZ1xop6URIiy5ZgptgoOzJHl7A==
X-Received: by 2002:a17:906:7388:: with SMTP id f8mr47614254ejl.231.1559916675852;
        Fri, 07 Jun 2019 07:11:15 -0700 (PDT)
Received: from locke-xps13.fritz.box (dslb-002-205-069-198.002.205.pools.vodafone-ip.de. [2.205.69.198])
        by smtp.gmail.com with ESMTPSA id a40sm546116edd.1.2019.06.07.07.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:11:15 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 4/4] selftests: bpf: verifier: read netns_dev and netns_ino from struct bpf_sock_ops
Date:   Fri,  7 Jun 2019 16:11:06 +0200
Message-Id: <20190607141106.32148-5-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607141106.32148-1-iago@kinvolk.io>
References: <20190607141106.32148-1-iago@kinvolk.io>
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

