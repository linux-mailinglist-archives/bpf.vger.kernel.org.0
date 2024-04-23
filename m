Return-Path: <bpf+bounces-27580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DA8AF6B7
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B59B25087
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDF1422BA;
	Tue, 23 Apr 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI11Pq6M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC411420A8;
	Tue, 23 Apr 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897352; cv=none; b=AeK7GlUs80mTzlqP0UmopQLse0WdO+BBMzOgZWzVFRgyH+vkXSzROWOtpqT4g8AjVkDwNZVv6jNqOX1wCqT61O3+gepq6aEgXZ2kKAo9Nw4L4AK8N60/IdmxV1suwlI9KolpPVPOyjeoQzNSY8ETwGbCz1dqXEMt3Y4VHDJBvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897352; c=relaxed/simple;
	bh=VAWU1PNulVK6IrSoDcMmfCG+WwNrpOQsTXkWrjjLLxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9hNjwHXZ6xgfDIyIXI3V6Eb5Qx1nzid9aSThtShBkQckATluIwntU6ikYjNSBm7UINjvN0vRQ8+XD7oN4UPKZgMAwtKkioT5blhCFta3jR6vRHPxWXffu1Z62HRstGG9jadBInfvolqZjfsF/i5NI2klLOgaHxrVzvlDptfhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI11Pq6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFB1C32781;
	Tue, 23 Apr 2024 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713897352;
	bh=VAWU1PNulVK6IrSoDcMmfCG+WwNrpOQsTXkWrjjLLxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uI11Pq6M8MCVirry+w9cSegnSm+JXY6YgEsjYNL0vW0Y0lv5lkhFcJniY+jz1LoSu
	 Bh6gsPhZJjxXb9bmp6o0JxljPYVDveZvqU8CPTW37dqbaFPxiMB8Lnf8DN2CWjdeGs
	 kQTprwuF8+U9T+nUJwjqAER0IC/0Bzc+NAxSSC7dN83tg4GbufYPZKc3gvFZnVDQ7Q
	 HJhgYyLDud0rGjTmnvemvOu5TgscboIqF6XG05xfTQgdoRhxsvun7ulKfJJd7+zjOo
	 1PTB+orU9//Vs9EWOdq7lZeRTgjwzTafX2A0L4527+pRg9Vh+kqHQW1PBCQwH3+lrE
	 59YH4pDFGOCvg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: extract BPF building logic from the Makefile
Date: Tue, 23 Apr 2024 11:35:42 -0700
Message-ID: <20240423183542.3807234-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423183542.3807234-1-kuba@kernel.org>
References: <20240423183542.3807234-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF sample building code looks a little bit spaghetti-ish
so move it out to its own Makefile snippet. Similar in the spirit
to how we include lib.mk. libynl will soon get a similar snippet.

There is a small change hiding in the move, the relative
paths (../../.., ../.. etc) are replaced with variables
from lib.mk such as top_srcdir and selfdir.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile | 53 +---------------------------
 tools/testing/selftests/net/bpf.mk   | 53 ++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/net/bpf.mk

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c388308ff517..5befca249452 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -108,55 +108,4 @@ $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
-# Rules to generate bpf objs
-CLANG ?= clang
-SCRATCH_DIR := $(OUTPUT)/tools
-BUILD_DIR := $(SCRATCH_DIR)/build
-BPFDIR := $(abspath ../../../lib/bpf)
-APIDIR := $(abspath ../../../include/uapi)
-
-CCINCLUDE += -I../bpf
-CCINCLUDE += -I../../../../usr/include/
-CCINCLUDE += -I$(SCRATCH_DIR)/include
-
-BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
-
-MAKE_DIRS := $(BUILD_DIR)/libbpf
-$(MAKE_DIRS):
-	$(call msg,MKDIR,,$@)
-	$(Q)mkdir -p $@
-
-# Get Clang's default includes on this system, as opposed to those seen by
-# '--target=bpf'. This fixes "missing" files on some architectures/distros,
-# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
-#
-# Use '-idirafter': Don't interfere with include mechanics except where the
-# build would have failed anyways.
-define get_sys_includes
-$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
-	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
-endef
-
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
-
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-
-BPF_PROG_OBJS := $(patsubst %.c,$(OUTPUT)/%.o,$(wildcard *.bpf.c))
-
-$(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
-	$(call msg,BPF_PROG,,$@)
-	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
-	-c $< -o $@
-
-$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
-	   $(APIDIR)/linux/bpf.h					       \
-	   | $(BUILD_DIR)/libbpf
-	$(call msg,MAKE,,$@)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
-		    EXTRA_CFLAGS='-g -O0'				       \
-		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
-
-EXTRA_CLEAN := $(SCRATCH_DIR)
+include bpf.mk
diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
new file mode 100644
index 000000000000..a4f6755dd894
--- /dev/null
+++ b/tools/testing/selftests/net/bpf.mk
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+# Rules to generate bpf objs
+CLANG ?= clang
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+BPFDIR := $(top_srcdir)/tools/lib/bpf
+APIDIR := $(top_srcdir)/tools/include/uapi
+
+CCINCLUDE += -I$(selfdir)/bpf
+CCINCLUDE += -I$(top_srcdir)/usr/include/
+CCINCLUDE += -I$(SCRATCH_DIR)/include
+
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+
+MAKE_DIRS := $(BUILD_DIR)/libbpf
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+
+BPF_PROG_OBJS := $(patsubst %.c,$(OUTPUT)/%.o,$(wildcard *.bpf.c))
+
+$(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
+	$(call msg,BPF_PROG,,$@)
+	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
+	-c $< -o $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+	   $(APIDIR)/linux/bpf.h					       \
+	   | $(BUILD_DIR)/libbpf
+	$(call msg,MAKE,,$@)
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+EXTRA_CLEAN += $(SCRATCH_DIR)
-- 
2.44.0


