Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CF2F327D
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 15:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbhALOCr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 09:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbhALOCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BEC0617A2
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ga15so3677271ejb.4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpCVH5a6hvC4+S6dhiP+hhLVa4IrOyo2QyAihLIZoi8=;
        b=ZmOPNrpiH+mVTmTRz5FUC9VHUzKtgI31M0T9yLPHWEPJdDbLm9SvxRbXYVtn6t5zII
         jpxQU/YaeO2kNXl/wOGTxhTQraBdVFBl4boy+F+TtKZ/pcFzY0Ku4u9b3fCbL4NAcLzQ
         WKI0zb4eq0QH4+6LfXcx3ohR73VyEWu/cZnyOO1GMIU9d7IM1wm1vTcbCiQrHKSL44zE
         BGiov228ESMdD93HKT1Gwt+Pm2YOHK4luUDyDNxgie4VwCxz3IqxyZLIZLRR85RsWNll
         SzdDiYVDZz0F8TUQfUEFA/npi/OMY3EK8hM1mCnBmvfMwJCQDAVc+oA/UKWS1uj5SAeM
         M0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpCVH5a6hvC4+S6dhiP+hhLVa4IrOyo2QyAihLIZoi8=;
        b=aDw7ZcmyOwYYu+lXAHcIESP4uwVdWB06nu08hZPe5TCxcfx7deZ5V9dYs7GIU43+DH
         EKavbvXRlX4Pm5Qw1qO4p67oTf3W5asQthA80N0uAhdpEzQOsbgd4ZEI8c/cAJU57gGl
         S8iKBqVx4uhQp4n0MnQqvOtw2o6UnvNYN2wER1We5frNMk/eg/Mnm4DVHUodMK4jkXQV
         Kf11Tmv92IGF+NH05T1agA1YaRhQLDpeUxFjlJTz/g+EvmTxg+WixxwkRw8EZZ3Xwxhs
         8vCDRdG2CbK8dNYNd767m6euLhJ4OruE1+12EMQTMtCZ+S5jzjG5vYlnUon4YAu1FEG3
         ysSg==
X-Gm-Message-State: AOAM533btYG8FZbXc3yYE+IHK+RfzmX6oxIxSuRCDAOyIqMI6tXmnmv8
        FVkI0qRFCEmQ7FCiAO5HyKIgSNptXn4ZKg==
X-Google-Smtp-Source: ABdhPJxW01iw/VTh34sniz3jK20lfnTtc5wn7b/DerGex1x+RtQO/4s8z0Sly2bg7lsvfKIC0m/RMA==
X-Received: by 2002:a17:906:440e:: with SMTP id x14mr3310201ejo.77.1610460087614;
        Tue, 12 Jan 2021 06:01:27 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:27 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 2/5] selftests/bpf: Fix out-of-tree build
Date:   Tue, 12 Jan 2021 14:59:57 +0100
Message-Id: <20210112135959.649075-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112135959.649075-1-jean-philippe@linaro.org>
References: <20210112135959.649075-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building out-of-tree, the .skel.h files are generated into the
$(OUTPUT) directory, rather than $(CURDIR). Add $(OUTPUT) to the include
paths.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1d85565883ea..3ff7e79cc497 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -25,7 +25,7 @@ BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
 CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) $(SAN_CFLAGS)		\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR)					\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
 	  -Dbpf_prog_load=bpf_prog_test_load				\
 	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
-- 
2.30.0

