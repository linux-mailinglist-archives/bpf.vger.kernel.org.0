Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27B41A656
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 06:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhI1EPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 00:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhI1EPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 00:15:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7FC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:13:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id me1so13981978pjb.4
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IoAk+1apSDf4boqDE2/3It/gMgNLxmz9xE4SjIQYcI=;
        b=YNfcBXJyCWjmnpQ/Z7xNB9TpZoK+sre1T2dDoCNk95bMu1htyzetuXxguw+ffL9AAt
         iAAAMD5895AgTHkWm5GW2mRP81NfXp04fKKG+8Ci3rkRZaph0VzulpOxkvXME10Txl2i
         jVwfaTG6QJTk8KDXPYDyk/w5KcpJRhfaLzyPZ41Xsu70/Mvy6Zh1+UDyGJ1XsQHG8NSJ
         VXFJ8RSj1oZrmDRNsmqNOs65b8nHgfa7RuzjG4eXW4iv054uN2RLmKq3XwnoavOxyGGf
         bnU1LNDjRoST3WUeLgDePTos+UF9tesT18m5Cy5J96wSeYMtuwp3eiQ/5lIct3H+NYFV
         O51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IoAk+1apSDf4boqDE2/3It/gMgNLxmz9xE4SjIQYcI=;
        b=O9N5LcHhjjJHYV4u0ybRC9wg7eLh+CdhI7y/EXDDnPQt3gme+n0j5rWsyUqPiXcNZW
         i1TQ1fB4ltWG7Hw5QL4N1P0FbZYyBGJeKyze9Oij/7CcpBNnxlX/yNss9KvburziWU7u
         HhAZKGzi+7Gq2a5H1xAWowI1J0SpOweAbDLnV0Pwfh3p3uU55obLnr2qyzcaclgCnrJk
         t7KBG12Snf1KRd1HA3tCd74QUytFETjHmn7Aw+AW69faBWAb3VcXmLrhho/t6qllyO/Q
         hlYpEKfoUtOjhRTTQvz41Ph11rf2pgHcROFWJFztToVgoCwcnvJ0lNecfJWvj2Vu+f44
         iKYQ==
X-Gm-Message-State: AOAM531m+pc6jjaTJ7FyAhHZ4WGTB5WffvIdnYnThBs9VXwmeVwgZy7D
        PT+0cBiUwZv1thaI8QF/C3DRThyHuy8=
X-Google-Smtp-Source: ABdhPJwEbphyVKNvqqwiHrrqn/Hjx+IRL5ZBZulSysczB/4xWPdxFxsCjCesgBRUX2oI2rPLyLzcWg==
X-Received: by 2002:a17:902:8b83:b029:12c:cbce:a52f with SMTP id ay3-20020a1709028b83b029012ccbcea52fmr3266393plb.9.1632802419737;
        Mon, 27 Sep 2021 21:13:39 -0700 (PDT)
Received: from localhost ([2405:201:6014:d058:a28d:3909:6ed5:29e7])
        by smtp.gmail.com with ESMTPSA id 18sm18585894pfh.115.2021.09.27.21.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:13:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf] samples: bpf: Fix vmlinux.h generation for XDP samples
Date:   Tue, 28 Sep 2021 09:43:29 +0530
Message-Id: <20210928041329.1735524-1-memxor@gmail.com>
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
 samples/bpf/Makefile                     | 13 ++++++-------
 samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4dc20be5fb96..a05130e91403 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -324,15 +324,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h

 VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
+		     ./vmlinux
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

