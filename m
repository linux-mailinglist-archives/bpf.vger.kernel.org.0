Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8C254998
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH0PiK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0PiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A306AC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w14so5326847eds.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fd36SoaukC0l5zGafVzd+T8lzqSHsp7n1jfsvEATI9g=;
        b=mf8sXzw22RrfIN756eOzI/6RRyLndk6lUtoR2ko4hec0xIANX7CsZvZurbvtR71pdi
         JDTZfe5QrHg+5xUAF+tdUJA/TW2xQnjlzRDdt+oVWFDWOrfOsnAHy3HlzEkwATTHsYIK
         JAriLXOz/MNhQ8TSotMEDK0pIJwDb6zjRjWSm49sOKp7rn71sYXwZQ+Zn4kXJcbPczYQ
         3YP2DU1NpOHbdHkiKa4fRFVsfv43voWTxOYmDDCDBllDcV+bBzM3yVi+45zplzogJDoo
         Efangsb6gM7fIuUsumkyvsCb7TdypiKuOHw3HDvl0/HmuasRUgVhq/62rW0FyaBfYUj3
         GjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fd36SoaukC0l5zGafVzd+T8lzqSHsp7n1jfsvEATI9g=;
        b=rbxh8SiW33in9bUBVwcBLqddmvYPn+I/3wwxoI+nIVJwV1ip0du7N+i+KLYx85NSon
         Q+wm+PWZVMRyxiX7VCL9u5h+jeBZqzT59iYSAWUMRQzFvZBhlvUlga1VyIsVgXsF+nSr
         VRBTCAyJKeUkOyjznan17r18XSOM4SSYpdtSkYzxaDUmjORN1d4yZI7cwjiZplreT8C/
         i+eou5YR3dZPqOs/DpHhQi9u5S74pJT4UDm04eGkIzZvV3pejrWbcz3bHu8PD6hYeFZM
         tkerEPJlHreJJVtFzafmnKks3rbPGnejNlQqowJOsb0+Tu/wk3KagP7QuV84zu8VS9l7
         W1Hw==
X-Gm-Message-State: AOAM531uXU7Cp5z4r5HHiWPb6OakXIZ4PigZFO+jyto0Ge4YMO7TsBsc
        rJBD717xFsCMUZuhl1bFOceQ1A==
X-Google-Smtp-Source: ABdhPJzl8CqOV0PbM6k8YgOBCA2+Jn2A9fiYKtTMHMWgVbT55SkxOT5S/0HtSQSsROR9ExllTper/Q==
X-Received: by 2002:aa7:d9cd:: with SMTP id v13mr12295297eds.150.1598542687335;
        Thu, 27 Aug 2020 08:38:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 2/6] tools/bpftool: Force clean of out-of-tree build
Date:   Thu, 27 Aug 2020 17:36:26 +0200
Message-Id: <20200827153629.3820891-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
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
index 8462690a039b..26a0006f329d 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -27,11 +27,13 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
 
 BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
 
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
2.28.0

