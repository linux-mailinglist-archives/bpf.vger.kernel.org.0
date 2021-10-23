Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4243856A
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJWUy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 16:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJWUyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 16:54:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2903C061767
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e4so4660752wrc.7
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1WVOZzTNh/27joMu9FrakmExxycTJXl4iU2zUCXEpI=;
        b=E7mTjdCnzNu7fTtcv4huP0x9ptCPFwdMYkzVsiL4s8m/XOsFU+EBFV5Coz9i4d1Y2N
         P95uGIg/MYsv/4B9ObjDV14Xiw6VM/KMt0Wi01LZrjRiwwi9giNxORWzNyebpHfi0jZp
         gq3wjtPBuhqfn5FPNBsXlUboOeDu9y2mENvijmAP2dKdNuj/xLxhZ14+WzFeYBHRYb50
         cWetwT6G3yulvPOwtplL8npUXV/Ifzjay8fEpeZect3AAP9ouAzxN4/sPMN491SIgNqW
         QZAHadUnofP4WIaXfDh/g44dPPqaXzFviRhMGcVYIWB8J1z6dMLh9Y76Ze4kyVKuVgVS
         olqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1WVOZzTNh/27joMu9FrakmExxycTJXl4iU2zUCXEpI=;
        b=Hcn2i9EJ4BdaQMtLUI5/wfX8xFkeI2+T3Wk3+W93Pj7shHfgEPNXN6RbYD7Y3ai5IO
         9C21DnBwzMYzJmuxi9w5VWaIC4FBnLrMvBa9NWkhZhRlRdLlFOJVgIRDTS6oGigqU3Dv
         wWH14c5oTRHlNvgwxqDaQ/XcnXH0PPbPsZ1UQd+CUitCbkrEthxWFFaWnHGFhGta5hcD
         OJMhmRX1v5Q/oi3LcMYIVkDVp+ZoPEdOCx2p2XCqidCYvmq6ivReiEmfrg5yk9kf0R0k
         BTg4PIdWepWhl6jOKA4E5X97gVPIaJJCZcqRkD3I18lPFyabRJXyyzG232k/p1xy10Se
         6KQg==
X-Gm-Message-State: AOAM5323Arojcz6g7/r4BtS2o6dvIIYuH7NnknLT7/CAYzI5L8JFPFjU
        0KJiYL+7GerkisNvedzy+mOi6Q==
X-Google-Smtp-Source: ABdhPJwVr4UelzHEpzNVZSRpeOp+gjTZlDra/SRPpPPRcdidctBXC/zlPYvlymlifHu4rlDEQS9/2A==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr10309607wro.104.1635022321571;
        Sat, 23 Oct 2021 13:52:01 -0700 (PDT)
Received: from localhost.localdomain ([149.86.74.50])
        by smtp.gmail.com with ESMTPSA id u16sm13555398wmc.21.2021.10.23.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:52:01 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/5] bpftool: Remove Makefile dep. on $(LIBBPF) for $(LIBBPF_INTERNAL_HDRS)
Date:   Sat, 23 Oct 2021 21:51:50 +0100
Message-Id: <20211023205154.6710-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023205154.6710-1-quentin@isovalent.com>
References: <20211023205154.6710-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dependency is only useful to make sure that the $(LIBBPF_HDRS_DIR)
directory is created before we try to install locally the required
libbpf internal header. Let's create this directory properly instead.

This is in preparation of making $(LIBBPF_INTERNAL_HDRS) a dependency to
the bootstrap bpftool version, in which case we want no dependency on
$(LIBBPF).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 098d762e111a..939b0fca5fb9 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -39,14 +39,14 @@ ifeq ($(BPFTOOL_VERSION),)
 BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
 endif
 
-$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
+$(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR):
 	$(QUIET_MKDIR)mkdir -p $@
 
 $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) \
 		DESTDIR=$(LIBBPF_DESTDIR) prefix= $(LIBBPF) install_headers
 
-$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h $(LIBBPF)
+$(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_DIR)
 	$(call QUIET_INSTALL, $@)
 	$(Q)install -m 644 -t $(LIBBPF_HDRS_DIR) $<
 
-- 
2.30.2

