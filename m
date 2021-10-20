Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335B434846
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhJTJur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJTJuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 05:50:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562BC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:48:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so8738164wmz.2
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ougTqSI43mpGEeXGGeV7HdH0kcNeLAHBNKcw/aNxG0Q=;
        b=b9VIkLl2FKsPXXxC0LoBkICKqF/6ewaqbHX0OrRlH/k651tDOplC8ta20geQDjMJFa
         SBwbY4ElBbzCOh2weKYrXj8MK4PmJfzPlrnuSCbaQ/H85p7k3Gtvegn0oO+vruKhhTh8
         ufTb04S72GOzYmPRnMqoD7A7egn+zlj8JGb04bbnkDdDLHSPOp/PSaoTynmrQUQHsHIs
         tk3CU0+umkpjGjVr3SFb/sPGiJGyEevN32LqU9gLMTmuzKquCwTUJzL9zMZ8PdCnyCAC
         8Frv6xssDkqGXNfktPShCU0Wo620LO+Iut0w5eoGfNpkb8zS+YQT+sAI9iEzfJQ9ibHp
         diGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ougTqSI43mpGEeXGGeV7HdH0kcNeLAHBNKcw/aNxG0Q=;
        b=yOl5W/BSlp0yPUYEY/tf8Vw+4MmecpPrXh6RX2JwbPLlUjOoP/uWV1PHq06UGTDRQS
         815fQNYm1E8KJC5Sorc74vpN7tSah3tfN8nQE8drOWMmBmr5BloDCW//Sebs9N1Dx6SY
         iNl9esB23/NhJlmTYrLgizIzTuD6q4su1rFTaaWyjarR9bHKJn/StnZqdj6pjiOTTvr5
         sM8gbceagXwlaQMAGJEPY+D3uoQnr8vXmZX8OSVR0hJ0BeZZGHxnDYG4TCw9MxpFH/9F
         ZvXXBPoJ+xD4QxqfZWE72gwOmZOtaSGRAWcJQBg9mX54MpZG8IyTl+BLl5e8WPnNVxG+
         Qfeg==
X-Gm-Message-State: AOAM530A8mWYnnEkJafBkiq2RZ148jREFIf4FbEUaHDnHw5+21O1jChC
        d+wX/L+CPi77sWd6uiBNWUnHtQ==
X-Google-Smtp-Source: ABdhPJy/CzoTxj+QZZDk1GlgYzq8p1gpOuW7IIGVTwniW042eJfBVNe4akk+8mjOQ5dywpWd2T7RtQ==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr51246252wro.101.1634723310488;
        Wed, 20 Oct 2021 02:48:30 -0700 (PDT)
Received: from localhost.localdomain ([149.86.71.75])
        by smtp.gmail.com with ESMTPSA id n12sm1767020wri.22.2021.10.20.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:48:30 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpftool: remove useless #include to <perf-sys.h> from map_perf_ring.c
Date:   Wed, 20 Oct 2021 10:48:26 +0100
Message-Id: <20211020094826.16046-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The header is no longer needed since the event_pipe implementation
was updated to rely on libbpf's perf_buffer. This makes bpftool free of
dependencies to perf files, and we can update the Makefile accordingly.

Fixes: 9b190f185d2f ("tools/bpftool: switch map event_pipe to libbpf's perf_buffer")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile        | 3 +--
 tools/bpf/bpftool/map_perf_ring.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index abcef1f72d65..098d762e111a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -73,8 +73,7 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(LIBBPF_INCLUDE) \
 	-I$(srctree)/kernel/bpf/ \
 	-I$(srctree)/tools/include \
-	-I$(srctree)/tools/include/uapi \
-	-I$(srctree)/tools/perf
+	-I$(srctree)/tools/include/uapi
 CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
 ifneq ($(EXTRA_CFLAGS),)
 CFLAGS += $(EXTRA_CFLAGS)
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 825f29f93a57..b98ea702d284 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -22,7 +22,6 @@
 #include <sys/syscall.h>
 
 #include <bpf/bpf.h>
-#include <perf-sys.h>
 
 #include "main.h"
 
-- 
2.30.2

