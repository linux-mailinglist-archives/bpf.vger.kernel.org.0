Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA53425C7F
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbhJGTq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbhJGTqt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:46:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ABC06176C
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 12:44:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i12so9838439wrb.7
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KwuZrvKj/nWbZxwowX3C1brtAZLHPAx17W+Fp0yX54=;
        b=6OhC5VeQI45lNxk40ykwOkdJzdusOv0ml1vSveYKxtXMeO4TZV/S5MgmWa2QHjqMF4
         Om3JIa0qqQvGMeuGAVrLYS1jKwYx6i/CT414wFp86b8TLmwUBCBwr3AvkNIrfHZSpsGN
         U2aMGK1a3rfxZDBj1EBIi1l0nfo3ONlQjj0jcqSyodm5Z6ILmyKY6HY5K7+7mogIc5Q0
         UXhK6GJ+2yWMsyAGRBGs5c0CcEx91hlB3laKtC/30dfmIWC9iMIkUjYgFhyjuHFtn/73
         +GT0d1Ow2C8qE3CqkAOlcJ56+Z6CZUTzdCt5xnsN2o/hFXAwmyGewd7QLJIa8DGa4q4f
         X6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KwuZrvKj/nWbZxwowX3C1brtAZLHPAx17W+Fp0yX54=;
        b=7KpW6pcc4/eMVtrYecAvYQjNESXGQUlsc/y+PxvmQYk72/3irQQzxBEPKG3nZdao8/
         yxaqjU0aTfQHwc/tprjV3+olLptq9bN4aK7PLfRfJ1QjojRrGKqNr+qyqeGTJYjIksO5
         Nv4f8xrX572kHZKHkIaAbdEpIktyTru0WqH1ahR9+FQEA3vQB7+ZKesqqYSJfvSy4hyi
         E8x8rn/Mg1r6UmsTnQY9Kirhw69cM9DdzRLaZngW2Pa/t5QNRSvkQVVxzo6d+qViB6IM
         erZOG4JZuJ4VyGLIR9/yPj18qbzItJfnaLw5B2XMy/Q1BY1CNadNiLJT/tSbpfmegwZd
         z7IA==
X-Gm-Message-State: AOAM531DTXxEkZEmUUFb3xgDvDyuncVJmALat2q85+Ynu+1ugahdpKNr
        Xx7CPVb5A1d4vbFSHz1KZlxhsA==
X-Google-Smtp-Source: ABdhPJzOedJonbjOi4wTULe7rp4mepUjUTH66EyU7qosjmJItOB/D2GJ+1NtDD8b02+51Gvnk6iviQ==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr6600316wmp.73.1633635891367;
        Thu, 07 Oct 2021 12:44:51 -0700 (PDT)
Received: from localhost.localdomain ([149.86.87.165])
        by smtp.gmail.com with ESMTPSA id u2sm259747wrr.35.2021.10.07.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:44:51 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 06/12] bpf: preload: install libbpf headers when building
Date:   Thu,  7 Oct 2021 20:44:32 +0100
Message-Id: <20211007194438.34443-7-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007194438.34443-1-quentin@isovalent.com>
References: <20211007194438.34443-1-quentin@isovalent.com>
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
index 1951332dd15f..469d35e890eb 100644
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
+$(obj)/iterators/iterators.o: | libbpf_hdrs
 
 bpf_preload_umd-objs := iterators/iterators.o
 bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz
-- 
2.30.2

