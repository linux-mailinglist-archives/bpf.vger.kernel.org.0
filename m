Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE441A73E
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 07:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbhI1Frv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 01:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Fru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 01:47:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E981C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:46:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g14so18004474pfm.1
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RIB34ck9x4xhZjBRT9gV4MhWdDLY2gLPXg+YsEUDEg=;
        b=o77R8TmR6nAGr3vvelMAWtSLVvjJl4C3nLtoHdPIIURlxMa+pa7xH6m5fEHF9pBgty
         XQH1Yic2DQqlqEpf2bchP3NHH5cg5OccGWx5P1n4Dt/SZKnDjKMMO0zg6RcF5+z1eEPp
         u5QGp+gV7oKDCiRbDqnyffWs5TE5QDoRtlkb7Wq9+SokS23V63m6oeUal44tkH3Xkddh
         Br/5t3QiJif+J93SYb8Il1RKLdtYrDiHBQxSM2Ai9pMLE/ReqXSRxFHISlhW8LRCFH0z
         W32deIulMmiAREjN3dnlJMXA0fwqwDOjvmXgWHG0jf+g0hcPa+1RcLvaEheK6a5wOdhw
         mPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RIB34ck9x4xhZjBRT9gV4MhWdDLY2gLPXg+YsEUDEg=;
        b=JoOdPPQ0to+DCMLJ9cJrtvFA986DrZ0iW44tbuta5SSwL2bEJQK31geCK9uSqgYWVH
         JQyiebr7R6jVfW6ko/qWElyl1Lj350uLjW/0M44abfG55e2hPHgmQ/g3RgPkVZ0I75Jr
         TmR5uriiRu7jRxgqOE5bD5b8XiDRKYmU16IWk7oVyQU1GlEing3LX2jxUOGWbUf+pmeT
         /f1FdTASu37XWPmUcCzFNSKXYEhu3Ps8xD8T/KeXCbZQeGuPB8G5GV3xVGmIUPuaxlZt
         646TIHYI1AmCOb48LQ86MtqNHPC62yItlAhizv8QVqvjIKtxQJsYaqQwWWpaWynSvRZo
         oBHg==
X-Gm-Message-State: AOAM5332+KAAJb1H456aU40zd7CnKT7QpMi+qVGaAG+Jyk+lJuhvdEX7
        zqH7kJlFJrZcxfTivhHZ+vglG9TOpqE=
X-Google-Smtp-Source: ABdhPJxH1bQpdhUpSgcbvuRjooSXZPcWVrbkUNdA43xlvNWgcTd4XJdU+9CfJscTZy0q8rFuie6y8g==
X-Received: by 2002:a63:7d0f:: with SMTP id y15mr3010715pgc.446.1632807971396;
        Mon, 27 Sep 2021 22:46:11 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id e1sm21791900pgi.43.2021.09.27.22.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 22:46:11 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf v2] samples: bpf: Fix vmlinux.h generation for XDP samples
Date:   Tue, 28 Sep 2021 11:16:08 +0530
Message-Id: <20210928054608.1799021-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Generate vmlinux.h only from the in-tree vmlinux, and remove enum
declarations that would cause a build failure in case of version
mismatches.

There are now two options when building the samples:
1. Compile the kernel to use in-tree vmlinux for vmlinux.h
2. Override VMLINUX_BTF for samples using something like this:
   make VMLINUX_BTF=/sys/kernel/btf/vmlinux -C samples/bpf

This change was tested with relative builds, e.g. cases like:
 * make O=build -C samples/bpf
 * make KBUILD_OUTPUT=build -C samples/bpf
 * make -C samples/bpf
 * cd samples/bpf && make

When a suitable VMLINUX_BTF is not found, the following message is
printed:
/home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
VMLINUX_BTF variable.  Stop.

Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
v1->v2
Use abspath for VMLINUX_BTF_PATHS items (Andrii)
---
 samples/bpf/Makefile                     | 17 ++++++++---------
 samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4dc20be5fb96..5fd48a8d4f10 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -322,17 +322,11 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h

 -include $(BPF_SAMPLES_PATH)/Makefile.target

-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
+		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
+		     $(abspath ./vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))

-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
-
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
 	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
@@ -340,6 +334,11 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif

+ifeq ($(VMLINUX_BTF),)
+	$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)",\
+		build the kernel or set VMLINUX_BTF variable)
+endif
+
 clean-files += vmlinux.h

 # Get Clang's default includes on this system, as opposed to those seen by
diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
index 8f59d430cb64..bb0a5a3bfcf0 100644
--- a/samples/bpf/xdp_redirect_map_multi.bpf.c
+++ b/samples/bpf/xdp_redirect_map_multi.bpf.c
@@ -5,11 +5,6 @@
 #include "xdp_sample.bpf.h"
 #include "xdp_sample_shared.h"

-enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
-};
-
 struct {
 	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
 	__uint(key_size, sizeof(int));
--
2.33.0

