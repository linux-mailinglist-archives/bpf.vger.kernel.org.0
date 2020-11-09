Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0642AB62F
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKILKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:34 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CAC0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:34 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id o20so8291423eds.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TyxsQyLla1zclispG+4axUyIMnk5XI6pp50Xi/hRHCg=;
        b=S0KMe+EcjhdCKdSpjGtExB7KW6g4Si/CJPGyUQQ03oV5i4s5u1xAyl/hJ8+tQ7fjD5
         jO8+DmE9TrQYKpHaaJCkSO45sU4+M7SU9kC2EETJoKFcmhRHSw5BJC2fZwg9oLulku1Z
         x4dx7NrVq7a7piDHNnnOj33Yb2ZiOgqdf1PMFgAOyPFwyZNj9os/EnHI7pT9I1zwSyUb
         BMZDbi+Jb3OiWecrOTU1TVdbExr8Ghc2Xs3dOaR1nSCo69Lp6niBSkGoqzK9ijnNFtta
         0RUmvy5neeQV6NfjfSwfXA0Ab14he0y778dkMnnsTQbYfWvSiQsuehAJePp889r5hDDO
         cLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TyxsQyLla1zclispG+4axUyIMnk5XI6pp50Xi/hRHCg=;
        b=T3Uzb3Ta47bEJtNfvLKucFrvf4o3Iy6z0dTDyjiQXOMJBxIhTWKHYB5KaTAMiUObdc
         PjyK2WfUUz1SYh9VcL7diSXGK5wypHsiQmAEAPm4gDhE8T/MHOtiiQcxn/fRv+bvG1Vi
         LsL4AFFheJOhgfmPWpZnbjl0RYdsjgN2tNeRUVahMdPQ9VbEgZzwQYiAIOQ9kG3uJutj
         JidPJa//gacSHZ5NZFuemFwsY8KMGizGrSyGZkOI9YvKr6/n+KRhgN7iIYF3kjgn68r5
         n8iIatmMOzXnUDKFWX/9OfRHNcpODoWHM4J/+x8I7O7ahu5ae5EMq+jgqU1A4VXdjAEQ
         r29A==
X-Gm-Message-State: AOAM533XqOp4D7MKwuwOinqL7aH1AYXn0V1K4iD0GYNcFWJTKdhlUaJB
        6NS6L/JSfbD3ioCxEXnH1eIkvw==
X-Google-Smtp-Source: ABdhPJxp1PG9Ezb/ljNExOD3M7lpFvlXIRWcODERVZnICc6Fm04r7sMx2DTUrW67Tjkpkh15S4Jt4Q==
X-Received: by 2002:a05:6402:b8e:: with SMTP id cf14mr14240703edb.86.1604920233369;
        Mon, 09 Nov 2020 03:10:33 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:32 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 2/6] tools/bpftool: Force clean of out-of-tree build
Date:   Mon,  9 Nov 2020 12:09:26 +0100
Message-Id: <20201109110929.1223538-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
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

