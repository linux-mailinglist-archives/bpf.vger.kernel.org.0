Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8704203A1
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhJCTYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 15:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhJCTYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 15:24:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B01C0613EC
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 12:22:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so10869429wrc.10
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evgkFwhvFSVV29jlx7/vaHeZoUosgpKpRXmwxiTaD3k=;
        b=iT/R2KGcGYE0s3qZZUBBk45Xl++27wr8ko/XRGVWsC15NaZnuW/qFzmqCjtWK3g9Fb
         iXWKQ1U+cczRcsTj3QpLjB9LugXaOG0pQTdkYpDw7WfcjHJAQPnjL60lV/RVZpgLaK9E
         ugzF6S48fQ9FpT9h4Hbgu+Wm9p5kA0E1eRnr2l5Sba/2aoY7Up3/SGUUkTR0+Xn/zjTw
         sLIQQsgqvKnsxOn/VgR/W3Se5pCgL8EO/YhcMpGuQwsP2K3oZMzyejLk7g/N2qLuBkGD
         PSpXucoHL+YRGmiQSsDNIxd00uPPmGD4sjdwo8oJdrYwaEbextF8INFrfvFlLMPteill
         84xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evgkFwhvFSVV29jlx7/vaHeZoUosgpKpRXmwxiTaD3k=;
        b=7Bi3yIgLk+jlqhDHJz4yH1CE1UVMRtjGKNn9k1KGoarpWNcDO2ikmoDo5iJDP7vwnl
         UW/pDrLeXOaEk4fMsDFvIvI4lT7UBETJ2fPOSeEJXH6JvsNZzwopI0VsDLHplh6g75fS
         xQbUUdDZ00NvOKkPVAWgCncLZAIVNHNQAfPGobIUVNvWzXljgqB1MDQ6QXkgBmDrZ3HE
         vnqh7bnlq4d9jDgtvAdT34dJdozBMBCwWMRTTVzDVQc3ceEGbxOJt4dbK6AwYcRieDdV
         L8/XzQHlLpr7HCERJETBLVLjlIpRS+683qDfXdTqnqWaa5EusGRbRIC6oDNf1PvK1Sfn
         1zmQ==
X-Gm-Message-State: AOAM533Sct+2jETV8sNxLZ+dUHsEeRZrteNFLGeBZWSr8kLirN9XQioZ
        JsRwIovbuz62zKRUjx/BCcLYug==
X-Google-Smtp-Source: ABdhPJxkfHBPXFOiIPz+ZRvUBNgytyA9laAZs29RZUW+zLQ1XKNOyFVnEzzxXePI2xfYga4ImqKd2Q==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr4383947wrd.340.1633288943993;
        Sun, 03 Oct 2021 12:22:23 -0700 (PDT)
Received: from localhost.localdomain ([149.86.88.77])
        by smtp.gmail.com with ESMTPSA id d3sm14124642wrb.36.2021.10.03.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 12:22:23 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 05/10] bpf: preload: install libbpf headers when building
Date:   Sun,  3 Oct 2021 20:22:03 +0100
Message-Id: <20211003192208.6297-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003192208.6297-1-quentin@isovalent.com>
References: <20211003192208.6297-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

API headers from libbpf should not be accessed directly from the
library's source directory. Instead, they should be exported with "make
install_headers". Let's make sure that bpf/preload/Makefile installs the
headers properly when building.

Note that we declare an additional dependency for iterators/iterators.o:
having $(LIBBPF_A) as a dependency to "$(obj)/bpf_preload_umd" is not
sufficient, as it makes it required only at the linking step. But we
need libbpf to be compiled, and in particular its headers to be
exported, before we attempt to compile iterators.o. The issue would not
occur before this commit, because libbpf's headers were not exported and
were always available under tools/lib/bpf.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 kernel/bpf/preload/Makefile | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 1951332dd15f..efccf857f7ed 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -1,21 +1,36 @@
 # SPDX-License-Identifier: GPL-2.0
 
 LIBBPF_SRCS = $(srctree)/tools/lib/bpf/
-LIBBPF_A = $(obj)/libbpf.a
-LIBBPF_OUT = $(abspath $(obj))
+LIBBPF_OUT = $(abspath $(obj))/libbpf
+LIBBPF_A = $(LIBBPF_OUT)/libbpf.a
+LIBBPF_DESTDIR = $(LIBBPF_OUT)
+LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 
 # Although not in use by libbpf's Makefile, set $(O) so that the "dummy" test
 # in tools/scripts/Makefile.include always succeeds when building the kernel
 # with $(O) pointing to a relative path, as in "make O=build bindeb-pkg".
-$(LIBBPF_A):
-	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(LIBBPF_OUT)/ OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
+$(LIBBPF_A): | $(LIBBPF_OUT)
+	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(LIBBPF_OUT)/ OUTPUT=$(LIBBPF_OUT)/   \
+		DESTDIR=$(LIBBPF_DESTDIR) prefix=			       \
+		$(LIBBPF_OUT)/libbpf.a install_headers
+
+libbpf_hdrs: $(LIBBPF_A)
+
+.PHONY: libbpf_hdrs
+
+$(LIBBPF_OUT):
+	$(call msg,MKDIR,$@)
+	$(Q)mkdir -p $@
 
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
-	-I $(srctree)/tools/lib/ -Wno-unused-result
+	-I $(LIBBPF_INCLUDE) -Wno-unused-result
 
 userprogs := bpf_preload_umd
 
 clean-files := $(userprogs) bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
+clean-files += $(LIBBPF_OUT) $(LIBBPF_DESTDIR)
+
+$(obj)/iterators/iterators.o: libbpf_hdrs
 
 bpf_preload_umd-objs := iterators/iterators.o
 bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz
-- 
2.30.2

