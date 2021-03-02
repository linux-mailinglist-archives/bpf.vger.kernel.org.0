Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9032B358
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352537AbhCCDvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346410AbhCBTLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 14:11:23 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF67C0698CD
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so14260959pgk.5
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hu2fl/gdmtemcdYzHoBNdDwL+TolrGxintCby5qolro=;
        b=gUeXZS2tsNTXS18Z4VONyksNUoioo/xd+y0QiZIsR+hxzg2BxZmWY/v7YFh3MicoyF
         Fcqm8KlHlNsXyIns2a0V9XbeqGHNqfAv/W++vmNiX9pfZM2W6JslFu/MQf823Y40U+AX
         xNfh0wj7eTi2NxM+BFt37IssX7tV0gE4zYELLAijxoewKKLulYTDpSLosnfHOkO2Pe2m
         WHIaJSecBWQJqWGG5sq29pl+t8gaUsOwUTrKKoVxoRaQZ2BIHBkBaTfxoGsJT3bsUXgi
         iYBwcfsN4k4nrNeAmodfhSHVCOXooHe+4w23bmUblDg7kD67WLx0wld/EezzdsvanNHk
         ZlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hu2fl/gdmtemcdYzHoBNdDwL+TolrGxintCby5qolro=;
        b=kd2ZeVVBqlib1AFhRCBPB6D6XgEd3zKbPauaFESEoLfCXQcsl1L+gbPi/kN9QZQsbr
         pbRr7acKKeYq3Kbk4IDPsm/KgsagUvmYhYjMEUjfbmUF3xUG+RYjw4wVFx72W5rQiKjj
         aJ7li5WVgpw2bNQadYugx8JLBLc+rM4UenA753OozcnPP8BgWpfH0M2cwPm67QVStpC7
         4zckBWO5hIpICVU8MaMcSf+nz87+2Il9OkFpojMh0QJL9RPr5h9tB0Zu1caUss6MHZve
         +aWerY9BsiRkCJJx9KzcfH1yHeORKBVT+ey7CeSeBOztlXPPq9Pn6BiNCP6Rt+wfCfbl
         Z9Bg==
X-Gm-Message-State: AOAM530lh0ZF4PTgGAU4Hsr8+8KoJGfako/MgEu3yAQ6SIP5FKybE5ge
        gzTkU00CrkXsW7IqJi1o8GZsCnyr9JyQm+0f
X-Google-Smtp-Source: ABdhPJzBegCXpYGBPuhfMSwsZrbAutCvoiFoc06DUlOYmxG7LD63nqFLBzLNBKT72gRfSqvMLazo0g==
X-Received: by 2002:a62:ea19:0:b029:1ee:5911:c516 with SMTP id t25-20020a62ea190000b02901ee5911c516mr4070769pfh.67.1614705646358;
        Tue, 02 Mar 2021 09:20:46 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:45 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 11/15] tools/bpf: Remove bpf-helpers from bpftool docs
Date:   Tue,  2 Mar 2021 09:19:43 -0800
Message-Id: <20210302171947.2268128-12-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This logic is used for validating the manual pages from selftests, so
move the infra under tools/testing/selftests/bpf/ and rely on selftests
for validation rather than tying it into the bpftool build.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 tools/bpf/bpftool/.gitignore                  |  1 -
 tools/bpf/bpftool/Documentation/Makefile      | 11 +++----
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 20 +++++++++---
 .../selftests/bpf/Makefile.docs}              | 32 ++++++++++---------
 .../selftests/bpf/test_bpftool_build.sh       | 21 ------------
 tools/testing/selftests/bpf/test_doc_build.sh | 13 ++++++++
 7 files changed, 50 insertions(+), 49 deletions(-)
 rename tools/{bpf/Makefile.helpers => testing/selftests/bpf/Makefile.docs} (64%)
 create mode 100755 tools/testing/selftests/bpf/test_doc_build.sh

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 944cb4b7c95d..05ce4446b780 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -3,7 +3,6 @@
 /bootstrap/
 /bpftool
 bpftool*.8
-bpf-helpers.*
 FEATURE-DUMP.bpftool
 feature
 libbpf
diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index f33cb02de95c..c49487905ceb 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -16,15 +16,12 @@ prefix ?= /usr/local
 mandir ?= $(prefix)/man
 man8dir = $(mandir)/man8
 
-# Load targets for building eBPF helpers man page.
-include ../../Makefile.helpers
-
 MAN8_RST = $(wildcard bpftool*.rst)
 
 _DOC_MAN8 = $(patsubst %.rst,%.8,$(MAN8_RST))
 DOC_MAN8 = $(addprefix $(OUTPUT),$(_DOC_MAN8))
 
-man: man8 helpers
+man: man8
 man8: $(DOC_MAN8)
 
 RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
@@ -46,16 +43,16 @@ ifndef RST2MAN_DEP
 endif
 	$(QUIET_GEN)( cat $< ; printf "%b" $(call see_also,$<) ) | rst2man $(RST2MAN_OPTS) > $@
 
-clean: helpers-clean
+clean:
 	$(call QUIET_CLEAN, Documentation)
 	$(Q)$(RM) $(DOC_MAN8)
 
-install: man helpers-install
+install: man
 	$(call QUIET_INSTALL, Documentation-man)
 	$(Q)$(INSTALL) -d -m 755 $(DESTDIR)$(man8dir)
 	$(Q)$(INSTALL) -m 644 $(DOC_MAN8) $(DESTDIR)$(man8dir)
 
-uninstall: helpers-uninstall
+uninstall:
 	$(call QUIET_UNINST, Documentation-man)
 	$(Q)$(RM) $(addprefix $(DESTDIR)$(man8dir)/,$(_DOC_MAN8))
 	$(Q)$(RMDIR) $(DESTDIR)$(man8dir)
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index c0c48fdb9ac1..a0d5ec3cfc24 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+bpf-helpers*
 test_verifier
 test_maps
 test_lru_map
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a81af15e4ded..b5827464c6b5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -68,6 +68,7 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
+	test_docs_build.sh \
 	test_xsk.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
@@ -103,6 +104,7 @@ override define CLEAN
 	$(call msg,CLEAN)
 	$(Q)$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C bpf_testmod clean
+	$(Q)$(MAKE) docs-clean
 endef
 
 include ../lib.mk
@@ -180,6 +182,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL)
 		    cp $(SCRATCH_DIR)/runqslower $@
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
+$(TEST_GEN_FILES): docs
 
 $(OUTPUT)/test_dev_cgroup: cgroup_helpers.c
 $(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c
@@ -200,11 +203,16 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    CC=$(HOSTCC) LD=$(HOSTLD)				       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install
-	$(Q)mkdir -p $(BUILD_DIR)/bpftool/Documentation
-	$(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)	       \
-		    -C $(BPFTOOLDIR)/Documentation			       \
-		    OUTPUT=$(BUILD_DIR)/bpftool/Documentation/		       \
-		    prefix= DESTDIR=$(SCRATCH_DIR)/ install
+
+docs:
+	$(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)	\
+	            -f Makefile.docs					\
+	            prefix= OUTPUT=$(OUTPUT)/ DESTDIR=$(OUTPUT)/ $@
+
+docs-clean:
+	$(Q)$(MAKE) $(submake_extras)					\
+	            -f Makefile.docs					\
+	            prefix= OUTPUT=$(OUTPUT)/ DESTDIR=$(OUTPUT)/ $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   ../../../include/uapi/linux/bpf.h                                   \
@@ -477,3 +485,5 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature								\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc bpf_testmod.ko)
+
+.PHONY: docs docs-clean
diff --git a/tools/bpf/Makefile.helpers b/tools/testing/selftests/bpf/Makefile.docs
similarity index 64%
rename from tools/bpf/Makefile.helpers
rename to tools/testing/selftests/bpf/Makefile.docs
index a26599022fd6..546c4a763b46 100644
--- a/tools/bpf/Makefile.helpers
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -1,13 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef allow-override
-  include ../scripts/Makefile.include
-  include ../scripts/utilities.mak
-else
-  # Assume Makefile.helpers is being run from bpftool/Documentation
-  # subdirectory. Go up two more directories to fetch bpf.h header and
-  # associated script.
-  UP2DIR := ../../
-endif
+
+include ../../../scripts/Makefile.include
+include ../../../scripts/utilities.mak
 
 INSTALL ?= install
 RM ?= rm -f
@@ -29,13 +23,21 @@ MAN7_RST = $(HELPERS_RST)
 _DOC_MAN7 = $(patsubst %.rst,%.7,$(MAN7_RST))
 DOC_MAN7 = $(addprefix $(OUTPUT),$(_DOC_MAN7))
 
+DOCTARGETS := helpers
+
+docs: $(DOCTARGETS)
 helpers: man7
 man7: $(DOC_MAN7)
 
 RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
 
-$(OUTPUT)$(HELPERS_RST): $(UP2DIR)../../include/uapi/linux/bpf.h
-	$(QUIET_GEN)$(UP2DIR)../../scripts/bpf_doc.py --filename $< > $@
+# Configure make rules for the man page bpf-$1.$2.
+# $1 - target for scripts/bpf_doc.py
+# $2 - man page section to generate the troff file
+define DOCS_RULES =
+$(OUTPUT)bpf-$1.rst: ../../../../include/uapi/linux/bpf.h
+	$$(QUIET_GEN)../../../../scripts/bpf_doc.py $1 \
+		--filename $$< > $$@
 
 $(OUTPUT)%.7: $(OUTPUT)%.rst
 ifndef RST2MAN_DEP
@@ -43,18 +45,18 @@ ifndef RST2MAN_DEP
 endif
 	$(QUIET_GEN)rst2man $< > $@
 
-helpers-clean:
+docs-clean:
 	$(call QUIET_CLEAN, eBPF_helpers-manpage)
 	$(Q)$(RM) $(DOC_MAN7) $(OUTPUT)$(HELPERS_RST)
 
-helpers-install: helpers
+docs-install: helpers
 	$(call QUIET_INSTALL, eBPF_helpers-manpage)
 	$(Q)$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
 	$(Q)$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
-helpers-uninstall:
+docs-uninstall:
 	$(call QUIET_UNINST, eBPF_helpers-manpage)
 	$(Q)$(RM) $(addprefix $(DESTDIR)$(man7dir)/,$(_DOC_MAN7))
 	$(Q)$(RMDIR) $(DESTDIR)$(man7dir)
 
-.PHONY: helpers helpers-clean helpers-install helpers-uninstall
+.PHONY: docs docs-clean docs-install docs-uninstall
diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index 2db3c60e1e61..ac349a5cea7e 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -85,23 +85,6 @@ make_with_tmpdir() {
 	echo
 }
 
-make_doc_and_clean() {
-	echo -e "\$PWD:    $PWD"
-	echo -e "command: make -s $* doc >/dev/null"
-	RST2MAN_OPTS="--exit-status=1" make $J -s $* doc
-	if [ $? -ne 0 ] ; then
-		ERROR=1
-		printf "FAILURE: Errors or warnings when building documentation\n"
-	fi
-	(
-		if [ $# -ge 1 ] ; then
-			cd ${@: -1}
-		fi
-		make -s doc-clean
-	)
-	echo
-}
-
 echo "Trying to build bpftool"
 echo -e "... through kbuild\n"
 
@@ -162,7 +145,3 @@ make_and_clean
 make_with_tmpdir OUTPUT
 
 make_with_tmpdir O
-
-echo -e "Checking documentation build\n"
-# From tools/bpf/bpftool
-make_doc_and_clean
diff --git a/tools/testing/selftests/bpf/test_doc_build.sh b/tools/testing/selftests/bpf/test_doc_build.sh
new file mode 100755
index 000000000000..7eb940a7b2eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_doc_build.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+# Assume script is located under tools/testing/selftests/bpf/. We want to start
+# build attempts from the top of kernel repository.
+SCRIPT_REL_PATH=$(realpath --relative-to=$PWD $0)
+SCRIPT_REL_DIR=$(dirname $SCRIPT_REL_PATH)
+KDIR_ROOT_DIR=$(realpath $PWD/$SCRIPT_REL_DIR/../../../../)
+cd $KDIR_ROOT_DIR
+
+for tgt in docs docs-clean; do
+	make -s -C $PWD/$SCRIPT_REL_DIR $tgt;
+done
-- 
2.27.0

