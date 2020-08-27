Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0225499C
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgH0PiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH0PiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B2C06121B
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so8293131ejp.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0FgighIwdmM/GwCv8tksYLJpYPYvU6sl0BqpPn2H6s=;
        b=l8oxS2MIS5ymcvd2DzvHjvFpQCZU7T1S1yljxP0yRdqoNskUq0gjLFybxd/ySXAyaN
         B1q+RikCsT72yE6bGRemR99UjziVE/8Lq75KmnPGpkCsYJh1/ecM9droa9WegRMj6P65
         Niie3+may9hLnssUX9Qk5zgjUnTYB7jBha/AB+3UwF8hegdXW9YFt0wf0n3mGTtOlpjC
         YNHbK0ZwgBTO6XmQOzWiD1gl9FaJ8Y6rWm5mEIxpRnOJx7rf0d/D0mzb/hEaKG4zCVVX
         +pYxhLo4KHd3t9yo/TyStaLgLPgWEvTFtK1LnPWvzz/GoIVAd8wV64xA7wyb+1LU5Sf1
         /JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0FgighIwdmM/GwCv8tksYLJpYPYvU6sl0BqpPn2H6s=;
        b=ShxOEqv8u6t4+ODteJudyK5zh7fyAbKE3uk43CJNHBaG09KuK5SdO71ZavEtdweJjg
         xf7jsp1hDbieOVNOoJoNBIExGEE/Lkw9bKAlDoYxci7oTHpmrYOM4g/Zv/6WWAzVTdxp
         1azQBm4dp6i9OsLHURSWHbtzbbZ0Zn1R4KvJW6UGUbMOViUPEsyuxRrm2W2yCteStPRF
         OdGHdjUGAUNjlyuxwLVJ+6e6xtTZMl1/cL0cZqoVmdEJthEVHV2hM5ADySfNtZ2LKt+P
         r12AC4ZWlZGaY6Xe0vzH1utJ4fxECTLKZxhrdHOArN6jeFOO5KXg+xAuLBOP/Rq+xrpw
         uUMQ==
X-Gm-Message-State: AOAM532LS4BXWRLHiYbFuEkodhJ0L/WvFAiHGwMGFYC6whWF8GoVnQIE
        WgRFV4ijW1PlmUqMR0lGaMFx0g==
X-Google-Smtp-Source: ABdhPJwyQCaAezpLu/msj4Wm8kAo6W6LLXcDXbhHWJsOLToMqCuFqw2GWb8nAUs7Z/NrJdmFc5gxow==
X-Received: by 2002:a17:906:1719:: with SMTP id c25mr22440976eje.487.1598542691776;
        Thu, 27 Aug 2020 08:38:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:11 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 6/6] tools/runqslower: Build bpftool using HOSTCC
Date:   Thu, 27 Aug 2020 17:36:30 +0200
Message-Id: <20200827153629.3820891-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When cross building runqslower for an other architecture, the
intermediate bpftool used to generate a skeleton must be built using the
host toolchain. Pass HOSTCC and HOSTLD, defined in Makefile.include, to
the bpftool Makefile.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/bpf/runqslower/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index 861f4dcde960..fa5c18b70dd0 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -85,7 +85,8 @@ $(BPFOBJ)-clean: $(BPFOBJ_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) clean
 
 $(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
+		    CC=$(HOSTCC) LD=$(HOSTLD)
 
 $(DEFAULT_BPFTOOL)-clean: $(BPFTOOL_OUTPUT)
 ifeq ($(DEFAULT_BPFTOOL),$(BPFTOOL))
-- 
2.28.0

