Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ACD39EBC2
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFHCAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 22:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFHCAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Jun 2021 22:00:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156BC061574
        for <bpf@vger.kernel.org>; Mon,  7 Jun 2021 18:58:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h16so10970205pjv.2
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlWgfkoUgGIc2S4tGp4Ufu0o8ncYa2wVT2C8owdEgiA=;
        b=0G8Elb9LyGWUIGG+u+a1npCzrmscBGlb8sVtEqDDI5lvCIf0gjyJ/PuTAiP13K3g4L
         yfeFrGpSZB2gZK2xusRoW6w0pnWObjRGQkPDxCVQfCbAzZuS8LR1VA0Msp0aerVBGHOB
         WCnJubtEpD2LeztbbN1kj13y/l7VIODpEMpU3Kd1sIP+qVnQNWdtkGq1c8wEMshig8Es
         97Xhq162x4fxQrmrz+2rjwk0v4KF+GBX33c1IBubLnRntDmaShFdArizyLdBRxmEGH4u
         0jHIRMcEVHyDFZmxCYThNN9niu0kuopnJd1LS3tfBTOCfMyL9Nnl8NFs3hMAtHBHK3x4
         JB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlWgfkoUgGIc2S4tGp4Ufu0o8ncYa2wVT2C8owdEgiA=;
        b=ttwSvGWwT63jhDVarwTTM6HdwiqjZmYWNZaW2oR4s08lXZHUDzyZc4HUvV9KgpKlkF
         ZmeqZ+pgilMTogGd+6WtyRo9qQYeK9HKzYN2R2UErdeTNldEOB/eMFK0YxHwRE2/7jFZ
         qJsmOn2IDumZ/ktqKvboAsa5/k7q/niGCwxYDLrtE4/cA0IJjjPZtP/5iYTUqLk/Tj2f
         OcsP50AnAPxlV1P8sbhgLpMleG2xsKAJKrT5GZF+JShgommn6miApCLvm/B67N4dV2DM
         kKn69mR9NKLVLMNTb+IBv664X+pTNh7w4EI9TPPI0x0FXWVJ6Q/9titwhM7cnaBU10Dc
         kGyw==
X-Gm-Message-State: AOAM530toiCS172/Y5RlxqL/59oPim+zg0uGkSTFNyY0cf6ZMduhnKhD
        5+oBFwrZfYw+aEIy7Iw4ZM8coqpq4DMtmw==
X-Google-Smtp-Source: ABdhPJy/52PzjJNkiC/FhgVFuWiWVnVJOxXUqnSDGj+SGbefsdgYh7KvS4y1s2wswET7Je2jv5KdGQ==
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr23388242pjl.192.1623117479548;
        Mon, 07 Jun 2021 18:57:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id l20sm13115348pjq.38.2021.06.07.18.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:57:59 -0700 (PDT)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, quentin@isovalent.com
Subject: [PATCHv2 bpf-next] selftests/bpf: Make docs tests fail more reliably
Date:   Mon,  7 Jun 2021 18:57:56 -0700
Message-Id: <20210608015756.340385-1-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, if rst2man caught errors, then these would be ignored and
the output file would be written anyway. This would allow developers to
introduce regressions in the docs comments in the BPF headers.

Additionally, even if you instruct rst2man to fail out, it will still
write out to the destination target file, so if you ran the tests twice
in a row it would always pass. Use a temporary file for the initial run
to ensure that if rst2man fails out under "--strict" mode, subsequent
runs will not automatically pass.

Tested via ./tools/testing/selftests/bpf/test_doc_build.sh

Signed-off-by: Joe Stringer <joe@cilium.io>
---
v2: Pass --exit-status=1 to rst2man instead of --strict
    Ignore *.tmp files from the build
---
 tools/testing/selftests/bpf/.gitignore        | 1 +
 tools/testing/selftests/bpf/Makefile.docs     | 3 ++-
 tools/testing/selftests/bpf/test_doc_build.sh | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index a18f57044014..eae6fc7d3ed8 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -37,5 +37,6 @@ test_cpp
 /runqslower
 /bench
 *.ko
+*.tmp
 xdpxceiver
 xdp_redirect_multi
diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index ccf260021e83..eb6a4fea8c79 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -52,7 +52,8 @@ $(OUTPUT)%.$2: $(OUTPUT)%.rst
 ifndef RST2MAN_DEP
 	$$(error "rst2man not found, but required to generate man pages")
 endif
-	$$(QUIET_GEN)rst2man $$< > $$@
+	$$(QUIET_GEN)rst2man --exit-status=1 $$< > $$@.tmp
+	$$(QUIET_GEN)mv $$@.tmp $$@
 
 docs-clean-$1:
 	$$(call QUIET_CLEAN, eBPF_$1-manpage)
diff --git a/tools/testing/selftests/bpf/test_doc_build.sh b/tools/testing/selftests/bpf/test_doc_build.sh
index 7eb940a7b2eb..ed12111cd2f0 100755
--- a/tools/testing/selftests/bpf/test_doc_build.sh
+++ b/tools/testing/selftests/bpf/test_doc_build.sh
@@ -1,5 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+set -e
 
 # Assume script is located under tools/testing/selftests/bpf/. We want to start
 # build attempts from the top of kernel repository.
-- 
2.27.0

