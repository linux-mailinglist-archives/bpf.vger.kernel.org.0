Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2864E2ADC55
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgKJQnw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgKJQnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF6C0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so3693288wmd.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6r4PFRYC/yAw5fMVcsDzlSlLBCzPKL22KiXEE0wNo4=;
        b=iYxIhrc+6XJLC4kM3DU46C9PUL41e3RVJesow/wAHp8WUu/oUd/PknCs6+wdXCP3Mz
         dH66X+vMBWgxlAj5lRzOzrcEp32H4zly56jpzBmlL1N5+GhxrMuCxS/hg7+DTkTvnQkt
         cnlrbJHkv2utMcKdAVBsJd5DSM/CkKqbgEamUkzulPiQOwVTqrt/UuxbZzpU1+AM/lg+
         FfhAYYz4GaMqb1foaZhpujO3RiHIrZWvWgFARjMjy1Lq2h2Gr+dkzweMgO4PqCdpJi+v
         JpnwmZhvIhKtTNPlM4fJrG8xDTYMYPxssAwfRz53n3KjV7zN4cFLTR1/Qi4hSgfsYygH
         33+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6r4PFRYC/yAw5fMVcsDzlSlLBCzPKL22KiXEE0wNo4=;
        b=b05TGcl4nLFASqplTyGDvZgg2HcmkwiqlaaUvWIJPSiRZm5VKYyhLBVKxvTdwHkS2Q
         qphs3zevmssQFnSQZWvtnU6lGq/s3MEmY6TMVZu88i3cYPt5WAGktv7tKKgxy9k/lguf
         aL8/dVADcJ4n7RAi64UmNTUjCVTDnPD5NIqANSLuxpvD2smIifXtxIA737rSZYH7XKlm
         q4wwBSrk99r7KdhgH/EAe0GfVI58DmJwxXQI0xA8p0IRtMBSr328/IRCJFG6m7H6kM6e
         wySoG8y8TquKnAWK3SY2RY4yTB5BrnEqsJ9ruQa9NIz6kLe4Qli0PJWzkpoH+pcVpKbZ
         YoGw==
X-Gm-Message-State: AOAM531xawx60b8mSqajQWlr1+5bsrbwOtEPZ0DqY8avubf6KBvqs4rA
        bcaHV2FcjFWDHBDmTLLpYPRH2A==
X-Google-Smtp-Source: ABdhPJxg+D0pLAXXLub727WcS7irxL0rJkmPgfXN65yKW2RTUobs0dyUODKmWC5uPpemrzLsA0MpKw==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr636537wmc.36.1605026629382;
        Tue, 10 Nov 2020 08:43:49 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:48 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 7/7] tools/bpftool: Fix build slowdown
Date:   Tue, 10 Nov 2020 17:43:11 +0100
Message-Id: <20201110164310.2600671-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit ba2fd563b740 ("tools/bpftool: Support passing BPFTOOL_VERSION to
make") changed BPFTOOL_VERSION to a recursively expanded variable,
forcing it to be recomputed on every expansion of CFLAGS and
dramatically slowing down the bpftool build. Restore BPFTOOL_VERSION as
a simply expanded variable, guarded by an ifeq().

Fixes: ba2fd563b740 ("tools/bpftool: Support passing BPFTOOL_VERSION to make")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v3: new
---
 tools/bpf/bpftool/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index d566bced135e..804ade95929f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -30,7 +30,9 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
 LIBBPF_BOOTSTRAP_OUTPUT = $(BOOTSTRAP_OUTPUT)libbpf/
 LIBBPF_BOOTSTRAP = $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
 
-BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
+ifeq ($(BPFTOOL_VERSION),)
+BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
+endif
 
 $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT):
 	$(QUIET_MKDIR)mkdir -p $@
-- 
2.29.1

