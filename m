Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3739A32B34F
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhCCDus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbhCBRlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:41:46 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A5C0698D3
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q204so13193904pfq.10
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdfyObE0E1JspOvROEYz/USdJ0MsLAvmGmtxjKiuziw=;
        b=hX1Bi349HGCRg4XxhEuiHPv8IhO8nCMLe1NF8WCH6A8WDN//ph/h8lvaH5r2lczDV1
         wrB0kZ8auZwVQ++e7AnrEtrDanbuws/DC5Namddhl3/vNLA8kGdngV51GGXhpZV1xade
         TZHIOt6Agm3XH6WZL1D2jgzJRHFQgj6lzRyCmk+k7+FRzXF2j1SyAnxREGC2vfgVjdwt
         /o6FcUOFQigEC9sLMr9LX8X3mUyiIJM0BhlCghAY1B24xST7eaMJ1m84cV3lH3les6Rf
         iaiokLMplzD2gO1jSgVAxEPR7CMzIv0B7+wYO2hZpo1g9G62jJjOdh0engpN8omOwBZu
         yS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdfyObE0E1JspOvROEYz/USdJ0MsLAvmGmtxjKiuziw=;
        b=GChdgHXQMm6Rc8BsY+uu2nX3xN6KxI5smIeDI80rSJK3JCF3MJ6uxLR/RYE2Cpk6HU
         QzLQH1Cy54YbO1a3TeqV4Lohak2O1ZVDVI/9wkxQm9ic88S1OUlR67ObmKNZEYWTsENq
         Xe1LpVMqqnAJZyYQEMxdPmEMpYkBzjjBHAi7iOhyJd5o4FwLTE8Rmt6j+pS3ZHeDICfo
         p6vGeZ0CwKaNguPm2JV0f1KZnXEuhiUk4iyyrEeaJulWNvFZp5TfO6UCpF7OOuUH/juJ
         FoMCY8qkj5hIx89wwmVJB93Sx2vB3lLGEYBLzNfu9Ro1RCV4Z15E3oJf7XT45Etmb8BS
         O05w==
X-Gm-Message-State: AOAM533rzgk0yq2VnZPV17ZgMO7b//hYSd/ntI9fAyOgcd5MFmhCBxgi
        31oOAc9DGYhKMsrvfCmwnYc/khD+V+hwEwo4
X-Google-Smtp-Source: ABdhPJxu2ccLPZxQduQGZaDo7/+I565sDXZiuNJfYVTL+2FXqWypan6o8vAXbJYeQe0VhYMkd+Z72Q==
X-Received: by 2002:a62:6304:0:b029:1c0:d62d:d213 with SMTP id x4-20020a6263040000b02901c0d62dd213mr4045441pfb.79.1614705648725;
        Tue, 02 Mar 2021 09:20:48 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:48 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 13/15] selftests/bpf: Test syscall command parsing
Date:   Tue,  2 Mar 2021 09:19:45 -0800
Message-Id: <20210302171947.2268128-14-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add building of the bpf(2) syscall commands documentation as part of the
docs building step in the build. This allows us to pick up on potential
parse errors from the docs generator script as part of selftests.

The generated manual pages here are not intended for distribution, they
are just a fragment that can be integrated into the other static text of
bpf(2) to form the full manual page.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 tools/testing/selftests/bpf/.gitignore    |  1 +
 tools/testing/selftests/bpf/Makefile.docs | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index a0d5ec3cfc24..4866f6a21901 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 bpf-helpers*
+bpf-syscall*
 test_verifier
 test_maps
 test_lru_map
diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index f39ad19317c8..ccf260021e83 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -15,18 +15,27 @@ endif
 
 prefix ?= /usr/local
 mandir ?= $(prefix)/man
+man2dir = $(mandir)/man2
 man7dir = $(mandir)/man7
 
+SYSCALL_RST = bpf-syscall.rst
+MAN2_RST = $(SYSCALL_RST)
+
 HELPERS_RST = bpf-helpers.rst
 MAN7_RST = $(HELPERS_RST)
 
+_DOC_MAN2 = $(patsubst %.rst,%.2,$(MAN2_RST))
+DOC_MAN2 = $(addprefix $(OUTPUT),$(_DOC_MAN2))
+
 _DOC_MAN7 = $(patsubst %.rst,%.7,$(MAN7_RST))
 DOC_MAN7 = $(addprefix $(OUTPUT),$(_DOC_MAN7))
 
-DOCTARGETS := helpers
+DOCTARGETS := helpers syscall
 
 docs: $(DOCTARGETS)
+syscall: man2
 helpers: man7
+man2: $(DOC_MAN2)
 man7: $(DOC_MAN7)
 
 RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
@@ -64,9 +73,10 @@ endef
 
 # Create the make targets to generate manual pages by name and section
 $(eval $(call DOCS_RULES,helpers,7))
+$(eval $(call DOCS_RULES,syscall,2))
 
 docs-clean: $(foreach doctarget,$(DOCTARGETS), docs-clean-$(doctarget))
 docs-install: $(foreach doctarget,$(DOCTARGETS), docs-install-$(doctarget))
 docs-uninstall: $(foreach doctarget,$(DOCTARGETS), docs-uninstall-$(doctarget))
 
-.PHONY: docs docs-clean docs-install docs-uninstall man7
+.PHONY: docs docs-clean docs-install docs-uninstall man2 man7
-- 
2.27.0

