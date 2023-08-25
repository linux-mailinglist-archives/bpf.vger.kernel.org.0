Return-Path: <bpf+bounces-8554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A378822E
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E996B281792
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942B3FE6;
	Fri, 25 Aug 2023 08:36:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D413D60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E58CC433C7;
	Fri, 25 Aug 2023 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692952604;
	bh=SoOIZhPy+BH1lhh+PkibmCi/a28e+9FwfvE7RWdGdTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l8zFt9TnpPicBKDMUvdOLhXOmD0jypML3YAdrq07kg9QizPhjHluajOQkrOCuj9jg
	 8a8xpdCd+ywjdbeVd8bu5PLwcRLwypSQ3IhZ2wsgwlaBnSoT/xadaXFoXZJfBlxxbi
	 OkEeTAAp5uw+xKuqWYmvNnfJm/RUlr/wC49kcl1kKc1cmv/OJx58+Z08Cq+OpoYdAd
	 fHHCB2elSPTEf9YKOXbVV2Ouic9MUfF3XK5Ktyxh75rTJl2UrUiDN8PKZrJD3o5UkF
	 dImrZjg8bCp2P8MlX54lOUvF/MjTU6TYsMpNQ1oVCaiYGLnYq3af36hn++tq6vZawL
	 VC6dDlqTRx1Dg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 25 Aug 2023 10:36:32 +0200
Subject: [PATCH 2/3] selftests/hid: do not manually call headers_install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-2-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=1935;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SoOIZhPy+BH1lhh+PkibmCi/a28e+9FwfvE7RWdGdTc=;
 b=R9Znvk2sGB/OjwoSxK6aPdlfboNJEpepCTlCc1wBNAygDf9Fbz1fE3Gv4qJ5OQpVYiwWg35tY
 WeEjnIWm+7sAYt+lui27uQf+gzDSerrE+pvsqGmnHb3ypUwo/+3XkCU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

"make headers" is a requirement before calling make on the selftests
dir, so we should not have to manually install those headers

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 01c0491d64da..c5522088ece4 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
 
-CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(KHDR_INCLUDES) -I$(OUTPUT)
+CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
@@ -65,7 +65,6 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
-KHDR_INCLUDES := $(SCRATCH_DIR)/uapi/include
 BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 ifneq ($(CROSS_COMPILE),)
 HOST_BUILD_DIR		:= $(BUILD_DIR)/host
@@ -151,9 +150,6 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(KHDR_INCLUDES)/linux/hid.h: $(top_srcdir)/include/uapi/linux/hid.h
-	$(MAKE) -C $(top_srcdir) INSTALL_HDR_PATH=$(SCRATCH_DIR)/uapi headers_install
-
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
@@ -231,7 +227,7 @@ $(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
 	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
 	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
 
-$(OUTPUT)/%.o: %.c $(BPF_SKELS) $(KHDR_INCLUDES)/linux/hid.h
+$(OUTPUT)/%.o: %.c $(BPF_SKELS)
 	$(call msg,CC,,$@)
 	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 

-- 
2.39.1


