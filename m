Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F522ADC50
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJQnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbgKJQnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:46 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C599C0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so9473568wrw.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyxsQyLla1zclispG+4axUyIMnk5XI6pp50Xi/hRHCg=;
        b=lRvu9QeDUXvFCpJx6aJDdw5xyVT4J992cOM4YPW2ZCQ0qWixjkRccsTG2ZebUB1oxW
         V7ZMw1sKC+Vpx1dGAdYEnrexKIcP0fDyWxjpeMj0wyfZHbdVi8ui2Ia0LKT+83yz7Ice
         1eJvMHYP/iBrApt/tFTqWWOtlXat6RhEJNRr0jJgGGYQr+2qKf3ps9uZ26BlgriEwJj6
         1tPftHBExXomBI5Tdq95gv4TEzy3UUn7aoTkkwq5TnNiKQHoaWFv39caLiGh380VNuVB
         dsjgC4qlLS7bcyWX6awbBrPsVdOcll0pxlQyYWKCe/HH34n9dzNQct+NsX2uHmfR7NHe
         RyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyxsQyLla1zclispG+4axUyIMnk5XI6pp50Xi/hRHCg=;
        b=QcqA7snscOcyBnwLXvtCfv7rlSUAHR2tYSf8ZKY95Kgi4e7tQMG9q+9MJW3z1IrqP7
         +Xw/pBcYjgCJIN23bGLfoRR6NhaDW+1DghXedh+TUkDQ/mMxAvyDfWiCUcMH4pFM0ZLY
         twvJcZVlMmfycfkvz3ZprtzeWr4AcwT9EIOra4ebuyDIe2Dc8uzAw0S9m4MyoNvs8rVl
         iYdKEgjt8gEFz/egwZYeG1OqGi43I72p/y+04K34r4ebdD+SdV487MX+IcDh+6bUJBTq
         yh6dmtApi96Q3SJFp754Nn8zeW+DDw2AuABqQuJqZDaB8cM9GEYW22OBg2u2a1LbIEap
         CK5w==
X-Gm-Message-State: AOAM531S82Wv6XtgIBUXiq2qIGvzV+u5EQzKOVen0vk2ktc9qkPbxtP0
        Ldc+lD3K6JTOkR3NERVCGv48SA==
X-Google-Smtp-Source: ABdhPJzYQi3SiNNG6uhpQ32ZgSPvA4i+S4zQ2Y7aG43xODiLADxgdushkfONnwJl1oDyvbQHSHTM7A==
X-Received: by 2002:adf:c143:: with SMTP id w3mr24702098wre.62.1605026623908;
        Tue, 10 Nov 2020 08:43:43 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:43 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 2/7] tools/bpftool: Force clean of out-of-tree build
Date:   Tue, 10 Nov 2020 17:43:06 +0100
Message-Id: <20201110164310.2600671-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cleaning a partial build can fail if the output directory for libbpf
wasn't created:

$ make -C tools/bpf/bpftool O=/tmp/bpf clean
/bin/sh: line 0: cd: /tmp/bpf/libbpf/: No such file or directory
tools/scripts/Makefile.include:17: *** output directory "/tmp/bpf/libbpf/" does not exist.  Stop.
make: *** [Makefile:36: /tmp/bpf/libbpf/libbpf.a-clean] Error 2

As a result make never gets around to clearing the leftover objects. Add
the libbpf output directory as clean dependency to ensure clean always
succeeds (similarly to the "descend" macro). The directory is later
removed by the clean recipe.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/bpftool/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f60e6ad3a1df..1358c093b812 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -27,11 +27,13 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
 
 BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
 
-$(LIBBPF): FORCE
-	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
+$(LIBBPF_OUTPUT):
+	$(QUIET_MKDIR)mkdir -p $@
+
+$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
 
-$(LIBBPF)-clean:
+$(LIBBPF)-clean: $(LIBBPF_OUTPUT)
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
 
-- 
2.29.1

