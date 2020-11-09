Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6422AB633
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgKILKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:39 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76715C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:39 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v4so8294105edi.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYdzYjuylIGj+H8L+sypn/5zvVxkpuKj9MVryD6kBvI=;
        b=vUURe5cJ9dxB1rRI5GD/dhPlOPkXat/uEOEFlAkRfljdipvr/RQNb46O2uFbk2VyOW
         +EbW0Wmgcu01BROcEYXAPiMep3PmISzfBUTCj/3o9jpkWKdIwi6RjjEMumnsVGlAGPYe
         ul9EaTYAN8d1UrisOPHWarUM1LwJurFQOGF+k7N0lEhaHFJSSY8tZXrnKAjoMOrshDxq
         G3yl7GqWoZ4MER7g582fc7N3m8Ti8FJHi/Bi6R8kEwR+cCQBpd4Gp+t4IwnBdDO8DyVG
         xA1MeZ+7273ad+mbJYY05e7L6qNbpkOF6PgGZDSDFC9qHpxPaEC2us6moR7/QPTVwemv
         FHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYdzYjuylIGj+H8L+sypn/5zvVxkpuKj9MVryD6kBvI=;
        b=uAX0BfVUjjSof+4fbBWqqY/qM6ohHn2YmgcsPBYWTq0OFO3BQOgtZ+BGjT0P8rx7U+
         QPt15h8anmShl8BQ5UTXvvua9ydVAM8toofhx7Bi5vlWVET2/IPx5iJYZG2XKeAWqBbp
         Gebrkjt7qW1UT6UualbZiNo+CtpZqMgqfVbvpujbOBmOqH5fgy8fleIxJJ+2E5aH2S2Q
         +drWUg0N2cYJ/FcGRFVDLeRpjuqMsvR1JkCFack90bHw3gjWXO1DNB7eYHuIV2wV7NLD
         2KqJcKqCJF7w2flnPpH6LEyHdY/DOTtyPlLDqJ1F4B79W0AJtKJvB6enEE9V+Y9QgNzF
         lGCQ==
X-Gm-Message-State: AOAM530BYkfUkuZ/8KdaVaEscCfY/ujoEcBxwR+Hj477D6SxSyeM/uGM
        FYs7JOtsrdRIqLdr9zYxfCIDyA==
X-Google-Smtp-Source: ABdhPJx+HwCuV3lTXcioyOaDiKl1VSDFz1rzG7+i0p/MBQkQNHjeJ/+Wl8H2pwPZBPY4U16y2wqo4w==
X-Received: by 2002:a50:a689:: with SMTP id e9mr4768686edc.233.1604920238175;
        Mon, 09 Nov 2020 03:10:38 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:37 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 6/6] tools/runqslower: Build bpftool using HOSTCC
Date:   Mon,  9 Nov 2020 12:09:30 +0100
Message-Id: <20201109110929.1223538-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.29.1

