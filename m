Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25FB2B01D2
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLJNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKLJNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 04:13:11 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FC8C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:13:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so4788324wme.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMWvNM2NKod6RH0DDPnwOY4cTCe7IjFnchx3Ae0804Y=;
        b=Sj+Svp1yoLQ2iUoh0GrPBV/dZOTWBU7Y4oxJQcNYgm69y92cdOLxBsYA2X2D2x3ZQ/
         PkpXOPfRs9aU3J1YcvbSwgxWxoZ/q8WNxcnzJSjm6yzgtX3hoTuxYBP8A3ULCbMrbDt1
         IinrWuXm/PPwKWXellmHSI0I/n9F7ppeuJpWal+pmtIkqP1F67ouswqxf1dlu303nFdL
         PWBD2epxT0Mpj72HZtSQILSR/EDDKrLZcNiQbndpUQ9ww8Nq2pTLrr9/QRTEuL3VhKUd
         th+5d7E6qkD4meL8WpH/duGRjoNUD1nRyz/d7wk5LsiwvpEDFdr22qvVV3R6EMWGZXMS
         gJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMWvNM2NKod6RH0DDPnwOY4cTCe7IjFnchx3Ae0804Y=;
        b=FPF1p2Siq4dHURTn8RDHghRGuI7Wc1AcxHUA6xFMO+DR/fAHfI038t8QzJBu2xZbwy
         ab5+BrQYhUAXOnIWGm+mkhVXgHIRK4Zs+MZiCJ7UqnjhtqfWI7giiUqqKDfYmSVxNBVD
         djLCwyQjOa3iw2KemwVcboUaXWZPkksTc6P5mH4CPzFYlNBKB5jN4LNM9I36kq7e4NvW
         mCVd+tdc0pbDLuYNCHAY5PDiw+dPE3zCldSiJdd5VwPMA3uBtTxIjph7tkkPRqdUVWaf
         gvPYP4XZnngiQM5aAvCMu+g6nXPQd6jdkeZwLi2+FB7tU9yAMYNzNm/UuIv+qdUlDAta
         4ieg==
X-Gm-Message-State: AOAM532breSTLpY4a1BCw8RQ4oTc10ZtW8tSay+MJ5aHQ1q6CmJmS/KB
        19iS734MSvbUDjvEfwPGEny/7A==
X-Google-Smtp-Source: ABdhPJz62MxTExtiTz1EKqcvrEUYLtyxElcPDk9VEvpXa7GJKc6fCb8EGfSgRvTN35+V82ePDMjLog==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr8952292wmc.156.1605172389896;
        Thu, 12 Nov 2020 01:13:09 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p4sm5945118wrm.51.2020.11.12.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:13:09 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 2/2] tools/bpf: Always run the *-clean recipes
Date:   Thu, 12 Nov 2020 10:10:52 +0100
Message-Id: <20201112091049.3159055-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112091049.3159055-1-jean-philippe@linaro.org>
References: <20201112091049.3159055-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make $(LIBBPF)-clean and $(LIBBPF_BOOTSTRAP)-clean .PHONY targets, in
case those files exist. And keep consistency within the Makefile by
making the directory dependencies order-only.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
See https://lore.kernel.org/bpf/CAEf4BzZqiFeLVYq-X7Z7cypRYSgLFw3dr=-EEoyzWaDJVFfzug@mail.gmail.com/
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 804ade95929f..f897cb5fb12d 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -44,11 +44,11 @@ $(LIBBPF_BOOTSTRAP): FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
 		ARCH= CC=$(HOSTCC) LD=$(HOSTLD) $@
 
-$(LIBBPF)-clean: $(LIBBPF_OUTPUT)
+$(LIBBPF)-clean: FORCE | $(LIBBPF_OUTPUT)
 	$(call QUIET_CLEAN, libbpf)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
 
-$(LIBBPF_BOOTSTRAP)-clean: $(LIBBPF_BOOTSTRAP_OUTPUT)
+$(LIBBPF_BOOTSTRAP)-clean: FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
 	$(call QUIET_CLEAN, libbpf-bootstrap)
 	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) clean >/dev/null
 
-- 
2.29.1

