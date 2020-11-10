Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCDA2ADC54
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKJQnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgKJQnt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 11:43:49 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3CC0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so11877571wrr.13
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 08:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxXt+eoV5EbJWxm1MIc9HhkqHaHNp9DBdvUyF/Z4TxM=;
        b=EVBE0Hm6JdPCCZRbh8lQTL2EJJwuNa+lNcEcztmus/TEL44A847jYOO5+p/VnQXs+v
         fxLiipZ/k6geX/PqudiInJsR8R/s3F0GzxVI2qqRGtdlKjI0zpnwFKLTfqxOCjj9uZjO
         +Q2Di+nbeF5GwlZ7xDzwKPC2IQV6xkNHXDKQZNlXXis6GHtjK2VbABpIOULS3Zs87YSe
         iKzY7WviydlXNW0+DqDlEitS6yX7i9XZQi+DqWYYYSJkI4RqqINiaHLcmQeFO7GvDTKY
         x1GBL23NO43MVpfzY6ga35flWYeQeS36p4fyJft0ueKJT1W4qqm7Qy44goYpc9Zx0ZXx
         N7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxXt+eoV5EbJWxm1MIc9HhkqHaHNp9DBdvUyF/Z4TxM=;
        b=MqC2JXynO81RNbxrqpqLV7qmGsGepKhs2iBr+llc60XTimvzQRD80WaQtvCUOr0zw/
         5mn/GQbj21oHYwsWK2jP/eJI3iRnniSWIIPbmAHONz1D19e3CcVi2jTPIOo8T6NxDz35
         Wp3uEn0F68I8w8tNEugwG7Svl+dRSbIIaMwEcY1y0ifDVgIEOqcMtD771kZQ4AhbODv5
         d2lYTEC3UGkaBKRgD65TTs+ADve4rw7FdSALLoHWrPixU0pw827mZFxTaMHiYIDOgGPM
         iTgC3fZ2A9ZiSVXIlo7VPkFqF1ysWBvKtRHCULnNGlBulScWH6az9sLmsPmHZzE9p65E
         iuRQ==
X-Gm-Message-State: AOAM532eiuXd5Bn5eJWoR+62SmcDXcJcor3hHv963k1PwMTtYL9pjVTg
        KsjjTBfYGLa8WpIN5iSCmWdVxA==
X-Google-Smtp-Source: ABdhPJzn/MH5wfzgqaQAcyDVW/vKku1e9dYNsn++SLuHKTMPgix464tFv8CsM6Bc4CJEbyze51aOUg==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr25380591wrp.399.1605026628186;
        Tue, 10 Nov 2020 08:43:48 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n123sm3272268wmn.38.2020.11.10.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 08:43:47 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v3 6/7] tools/runqslower: Build bpftool using HOSTCC
Date:   Tue, 10 Nov 2020 17:43:10 +0100
Message-Id: <20201110164310.2600671-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201110164310.2600671-1-jean-philippe@linaro.org>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
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
index 0fc4d4046193..4d5ca54fcd4c 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -80,4 +80,5 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OU
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) $@
 
 $(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT)   \
+		    CC=$(HOSTCC) LD=$(HOSTLD)
-- 
2.29.1

