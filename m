Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A75ECC89
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiI0TAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI0TAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645515EFB5
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so9370065pfh.6
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=K6vZLe238Y7tE+rPfNhu7j1O8qFZl2EZ8BObf2TsFU4=;
        b=krw7jRcUX4Bzk62xSG7mUNgEQFKS7NHF9JAwOo2hKsAY7JGKd4jwggrVXf3ioLvS3O
         7qjREpZq4+CZUzRCLpVnU/eq0QWEcLX13EITdtsMvbcxHNQtN0AaDUTN5glC5ACwoKL8
         t/kAiqYE0LI37KwfKwvd1fseKkRL4nDFjpOjFoOmLXsgUlhLxcXgwKN4WnYU2xeuKWFN
         d0D86iPujDGUVdwiuJZAaKkZTYPm85tlNzrSCv17/JduLzhtS3cgLO1WfY7P82vnAUj4
         DxYyShKzMkAYORCsoZujEWzZXfBPSSvN/FqORa1Ogp43IAio3gsbq+eg7SNaUdrnS4Uo
         nBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K6vZLe238Y7tE+rPfNhu7j1O8qFZl2EZ8BObf2TsFU4=;
        b=uzVZdIK16BZWrcKlPqRVnSMmi6HsKtDqj8rtoTa6icPr7uXIwWMb5AMaImN7wb+ifM
         Eg1g3gV8hpk6UJYgL7P1rOQcsF55va5UZ90ZKJRkr35YTeknTl/q6pJxof6pEvsAENcM
         zuc+H7kUuKx5WIEciWKUwNcrWmgT6mhqU60PDBk8gcJNzXYDCzOWoNePkRtc79rglQzA
         XHUTa7+rJFXCXqhylJcaQjQA6Kc01+36bv6iXea5A5YfaW4wQLsjlNeeQ7U6T5SpOyk3
         9wMm4Yp5PGe6RActPMTXM6ar1arR1GR9CIX0IIpCbIgp+xkHW8LUZYHiVYu8kA5ObIjY
         CnsQ==
X-Gm-Message-State: ACrzQf1nDC5NWU5AFmrRV3Lipw92zUgXzxIuE5VGV9quSfLz18+AP+8D
        Tf1YeVeGogqP071TS7CP2WCbWLYquns=
X-Google-Smtp-Source: AMsMyM4G57H9loIYcF/uhH7YoEdRMl/MfT8dHUEQecf4V2Yml5bwye020CaY3Mr/y74TGYNjEcMPcQ==
X-Received: by 2002:a63:4243:0:b0:439:2031:be87 with SMTP id p64-20020a634243000000b004392031be87mr26089162pga.592.1664305218290;
        Tue, 27 Sep 2022 12:00:18 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:17 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 03/15] ebpf-docs: Move Clang notes to a separate file
Date:   Tue, 27 Sep 2022 18:59:46 +0000
Message-Id: <20220927185958.14995-3-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/clang-notes.rst     | 24 ++++++++++++++++++++++++
 Documentation/bpf/instruction-set.rst |  6 ------
 2 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/bpf/clang-notes.rst

diff --git a/Documentation/bpf/clang-notes.rst b/Documentation/bpf/clang-notes.rst
new file mode 100644
index 000000000..b15179cb5
--- /dev/null
+++ b/Documentation/bpf/clang-notes.rst
@@ -0,0 +1,24 @@
+.. contents::
+.. sectnum::
+
+==========================
+Clang implementation notes
+==========================
+
+This document provides more details specific to the Clang/LLVM implementation of the eBPF instruction set.
+
+Versions
+========
+
+Clang defined "CPU" versions, where a CPU version of 3 corresponds to the current eBPF ISA.
+
+Clang can select the eBPF ISA version using ``-mcpu=v3`` for example to select version 3.
+
+Atomic operations
+=================
+
+Clang can generate atomic instructions by default when ``-mcpu=v3`` is
+enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
+Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
+the atomics features, while keeping a lower ``-mcpu`` version, you can use
+``-Xclang -target-feature -Xclang +alu32``.
diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 1735b91ec..541483118 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -303,12 +303,6 @@ The ``BPF_CMPXCHG`` operation atomically compares the value addressed by
 value that was at ``dst_reg + off`` before the operation is zero-extended
 and loaded back to ``R0``.
 
-Clang can generate atomic instructions by default when ``-mcpu=v3`` is
-enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
-Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
-the atomics features, while keeping a lower ``-mcpu`` version, you can use
-``-Xclang -target-feature -Xclang +alu32``.
-
 64-bit immediate instructions
 -----------------------------
 
-- 
2.33.4

