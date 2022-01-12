Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A062148BBC8
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 01:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiALAZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 19:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiALAZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 19:25:08 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98449C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 16:25:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p16-20020a170902a41000b0014992c5d56bso819853plq.19
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vlRniYjFJS8GXTiQcavbR3Q+xuXRc84rf1pjpwDnwgg=;
        b=df+gpApiwun2GvAf38KC9NfFl7J6EAynZgVzNNFQkSADXGenAgGcqOLHLlVcZCeTxl
         PM13+5GoBj3Xq8UO58xP3qzjtwkVMBGVQHzsQXOe26QheVTOBfaD6nAasM+5+1sm7uHm
         XY2Oi83aWBGkdAN4Mq/s3CQzkFF5VOkCKCDuCZPcLa+6TSM7YuyEJQUaST3xCns1ea3y
         UeJzJtk/cUYV3ZZht5PX/iFfjfgJZ5Zpt1nHw1myAnwmJdLjKN7UoLzgP3Q/+K/1+Aod
         tlN+ggeCtLMSkAgTZT7Xxbz7LpvfU9AX3wjNjaQ2g7Ruyiv90CU2Fs/jARkVbgya+grH
         t6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vlRniYjFJS8GXTiQcavbR3Q+xuXRc84rf1pjpwDnwgg=;
        b=o4OVk8MS14zwnR1h0V/DKs02oCiSOfPyTxafPfcF27ICUBBApHYNwPpRKUGYwpC+ub
         LJYnVOc4cQ5IfEhklh0/oSWqbTfGMbG8gAscgbE6WxxA0I9zkPeLwCRs7f7ZDpLtbbXm
         mlJ16BIi7Oxq76xYLidRvDWbmkCOY+Wrs9kkg/xHHOpzTQEplH3F7Mne/M7ax2OBAUn8
         wjINvqdi3JN1JD6PxWrb7DxQRujT/NyDG0IFPsACYN6wnArMeTOD7YlwFrUSgD5yO7xx
         NOm5W571gacXSXcjhtiXtkAR1Wo9FrBi4zGSbLFMuDNmFbiGcX6bVSEkBssmPf1WLezK
         hITQ==
X-Gm-Message-State: AOAM531o14/E+CMJcNuuzcnPkmCeoYc+OlQ8jP/PP0FPzC3mCX3Ya9JE
        xjZBGPLRAqxRLOtdQqTSvqJo1wKEGijQ
X-Google-Smtp-Source: ABdhPJwRSPJ9w2VH9jxXZL7U+jG+KqHxLna8R9IbOO47LvXY9HDELLu9W/eathbshbZ8HlUeiShOF/GHIWd9
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:aa7:85c7:0:b0:4bc:ac23:64a2 with SMTP id
 z7-20020aa785c7000000b004bcac2364a2mr7007514pfn.20.1641947108064; Tue, 11 Jan
 2022 16:25:08 -0800 (PST)
Date:   Wed, 12 Jan 2022 00:25:03 +0000
Message-Id: <20220112002503.115968-1-connoro@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH bpf] tools/resolve_btfids: build with host flags
From:   "Connor O'Brien" <connoro@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

resolve_btfids is built using $(HOSTCC) and $(HOSTLD) but does not
pick up the corresponding flags. As a result, host-specific settings
(such as a sysroot specified via HOSTCFLAGS=--sysroot=..., or a linker
specified via HOSTLDFLAGS=-fuse-ld=...) will not be respected.

Fix this by setting CFLAGS to KBUILD_HOSTCFLAGS and LDFLAGS to
KBUILD_HOSTLDFLAGS.

Also pass the cflags through to libbpf via EXTRA_CFLAGS to ensure that
the host libbpf is built with flags consistent with resolve_btfids.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 9ddeca947..a7f87cdf1 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -20,6 +20,8 @@ LD       = $(HOSTLD)
 ARCH     = $(HOSTARCH)
 RM      ?= rm
 CROSS_COMPILE =
+CFLAGS  := $(KBUILD_HOSTCFLAGS)
+LDFLAGS := $(KBUILD_HOSTLDFLAGS)
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
@@ -47,10 +49,10 @@ $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
 
 $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
-		    DESTDIR=$(LIBBPF_DESTDIR) prefix=			       \
+		    DESTDIR=$(LIBBPF_DESTDIR) prefix= EXTRA_CFLAGS="$(CFLAGS)" \
 		    $(abspath $@) install_headers
 
-CFLAGS := -g \
+CFLAGS += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
-- 
2.34.1.575.g55b058a8bb-goog

