Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A484A5208
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiAaWFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiAaWFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057FC061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so533869pjt.5
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zKq2PZXAx/qg7Z0UrTBdBykuUzrcXoLH7EvUQPd0q4=;
        b=WAdUrb5kajkRD/FfFQu187MCQ2LcQ/rCY95OSy9hSG3RTi/YedQKZhmJjxGXx3WqlS
         SiwOS9o3haUcbQcAWQkXfsmI/4F0afp4gONFBmKpEOk8xEvUa5Fiuf3SZrc1wnEE33nt
         4LaM/MeLwNa8t3X/mWBfMil7M75VnzgCujrThLuHmV2PW1Yjn5g3epSZQvakMbIx/JyH
         nhPjL8+hyEFj654W7Zc+SaOQqeeBtHwDqgPmZHLDo4QFoac1sc/kEKXGulxqOiZaVoWn
         PGgtByD2rnXe5dZ7wDDTkL80qSlzGchOOgetWqsH0ForqszQv+0TfsGPpHdGNWFRg1zV
         bj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zKq2PZXAx/qg7Z0UrTBdBykuUzrcXoLH7EvUQPd0q4=;
        b=Szl1KU4yxJk7FNQQHWm19Q5qAPfI8tLT4ccfZIdrw1md9/ghvioJTYszHl4GPFNR1b
         NfxfCRIp9npQT8RqL1cbPgEhEBylyPx2Vybsy35LLLLiaEdMf3nPFE3YizswA4YeJOJ7
         du6e6A0KhaoofukyWzm+XH+6xPWaTLMsUZy9rPfJmMYEufaQpO+g+brG0ZsGWiC5zdNt
         cTvJ/EfPFdOrdfGT4O4T1QyHMa8E4WC1MRnPXrkemN/OYklSuLx7Ywwg5UzTy0A3t/Qr
         nm1h+OcR8A0Mit8GrjHdSwrQTacpFIGq/P2rOhkezubkHfeWIIMmji6XRrrDqxcvOU/Z
         RanQ==
X-Gm-Message-State: AOAM5322W65d1eBgS9kO6vfPlFslG1MGzVQWmCY+m+yh0o+VDoIIhFco
        qOjpTHoiwJu2aqkB+c+5s8E=
X-Google-Smtp-Source: ABdhPJw5kyz4Xypm311qWv54hatBOva2hEl9FkZagPI2LxiOeRBD4mNJbaC4MhDEowSW6Z1+eAZM/w==
X-Received: by 2002:a17:90b:350c:: with SMTP id ls12mr26624379pjb.44.1643666751208;
        Mon, 31 Jan 2022 14:05:51 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id n2sm7728142pgf.74.2022.01.31.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:50 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 7/7] bpf: Drop libbpf, libelf, libz dependency from bpf preload.
Date:   Mon, 31 Jan 2022 14:05:28 -0800
Message-Id: <20220131220528.98088-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Drop libbpf, libelf, libz dependency from bpf preload.
This reduces bpf_preload_umd binary size
from 1.7M to 30k unstripped with debug info
and from 300k to 19k stripped.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/preload/Makefile | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 1400ac58178e..baf47d9c7557 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -1,40 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 LIBBPF_SRCS = $(srctree)/tools/lib/bpf/
-LIBBPF_OUT = $(abspath $(obj))/libbpf
-LIBBPF_A = $(LIBBPF_OUT)/libbpf.a
-LIBBPF_DESTDIR = $(LIBBPF_OUT)
-LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
-
-# Although not in use by libbpf's Makefile, set $(O) so that the "dummy" test
-# in tools/scripts/Makefile.include always succeeds when building the kernel
-# with $(O) pointing to a relative path, as in "make O=build bindeb-pkg".
-$(LIBBPF_A): | $(LIBBPF_OUT)
-	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(LIBBPF_OUT)/ OUTPUT=$(LIBBPF_OUT)/   \
-		DESTDIR=$(LIBBPF_DESTDIR) prefix=			       \
-		$(LIBBPF_OUT)/libbpf.a install_headers
-
-libbpf_hdrs: $(LIBBPF_A)
-
-.PHONY: libbpf_hdrs
-
-$(LIBBPF_OUT):
-	$(call msg,MKDIR,$@)
-	$(Q)mkdir -p $@
+LIBBPF_INCLUDE = $(LIBBPF_SRCS)/..
 
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
 	-I $(LIBBPF_INCLUDE) -Wno-unused-result
 
 userprogs := bpf_preload_umd
 
-clean-files := libbpf/
-
-$(obj)/iterators/iterators.o: | libbpf_hdrs
-
 bpf_preload_umd-objs := iterators/iterators.o
-bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz
 
-$(obj)/bpf_preload_umd: $(LIBBPF_A)
+$(obj)/bpf_preload_umd:
 
 $(obj)/bpf_preload_umd_blob.o: $(obj)/bpf_preload_umd
 
-- 
2.30.2

