Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FFD19D6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbfJIUlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 16:41:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44741 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbfJIUlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id q12so2657229lfc.11
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=tfJRZwLztmeYnFVdBAyxDdd+TZuqCcbbHvU5t2tVbgAMeD89v9awCNcvPek+HEsinA
         K1LAR52j6GCLiPMmHzsyATIhO8GEAHwsq1kzMxTb+kqnSKYNYd/61S+suugTWtGL+xYl
         hYzte2ORZ6ds9SEIuh1GeM64BiH81APaqQ8DuaBD1dx9qk2i1Er8JYdmwhNet5xJn8FY
         UA4s3/ng5TBA92c8PW22hDa8b8CpZzr4neRtwwxFfBh7XCXe0ywARrnUdf3onmDwFKSE
         KtyiZ5pt88z1zElieeXhqhh6EmSJxDY15JKWCgIFMyvdMpMSehHPchYNTgjgh1TOKi7m
         700g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=o8V2Ir+X2ZbI1r+Wqmm0dJTTutLZoWad49+1tVO/QtEPD17EjzMXI/atotYDej/Joy
         cP/DpVHkrby0WvlmjlZ8L2doL6+gHVASX2gmKA9PN1LK+arXTp+RRm1DMEcr8La+IVxC
         Kxof+9cw6UUU9xyojw3ufsVscQrC7yBoAjBqccTtJfWoz8vgwwurbfsO6fKSCA1psfTd
         Yti58ASK3b/CKGwYLK+mlPAXxve7/UexjazNI2Wj3sgWBMhneJWd1R4iSra0VbdlyUwG
         mrm0nwuHYYKG3ZTK3tCs6a5Dsx6Y8o0KJSOMkUXwbDontBddIGYFUZeIgowO7R0qkZz5
         /VAw==
X-Gm-Message-State: APjAAAXqL70DHbhrkYX+AAEpC3tmgRzCtcmC9hvXibxY/QvvempyzE/3
        Ocn7VYMD9hjeqikjtYyqWWqBpA==
X-Google-Smtp-Source: APXvYqz1bKEUNoy2hw6TiSEtk/s+AI2BPUnSPgf5bemrwMHPwBezXWN9I4nngequORm4JiAuSncpjg==
X-Received: by 2002:a19:380b:: with SMTP id f11mr637307lfa.81.1570653703810;
        Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 03/15] samples/bpf: use --target from cross-compile
Date:   Wed,  9 Oct 2019 23:41:22 +0300
Message-Id: <20191009204134.26960-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 045fa43842e6..9c8c9872004d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -195,7 +195,7 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
-CLANG_ARCH_ARGS = -target $(ARCH)
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

