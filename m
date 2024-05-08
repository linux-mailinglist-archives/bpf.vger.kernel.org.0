Return-Path: <bpf+bounces-29052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA298BFAE6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645C1F23C1B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708597E59A;
	Wed,  8 May 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/CYq3Lr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AF2575A;
	Wed,  8 May 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164024; cv=none; b=sq4bDhyL4R6uNuNkJgw/7Gip14GsjKBnxUa1dIlH/8JJ4a+3gscwHM310wkKMClmfSM/Me8N7orkrKMlMem6Na9kOE2nGU9sEeynSN/KOQpRxHayTGQOMfDvYaTbN6jNlUygx7jDABButL8YM9Qq9NPtoqlmefWqbbFI2hbeRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164024; c=relaxed/simple;
	bh=a9LJVsfpkf9Px0ybdQKegPbSIpTN8PO6xfWRp8iYXlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szIr8OVJRt8y2/ty7t+r4+rN1Lh/5el36Q4OdkVc3yXhWJQd15fpmoxn45fGb4Q7khjVHXPvuTePoKFBCajHoXlPRkJDZLBnckzZcipChBWaO9C0HJley/0E89fAcF6DHSNvzxN/80gpETTvrtP4+UXd9GyAX3qTxgCfdbz6Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/CYq3Lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123B0C4AF17;
	Wed,  8 May 2024 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715164023;
	bh=a9LJVsfpkf9Px0ybdQKegPbSIpTN8PO6xfWRp8iYXlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k/CYq3Lr1UdnWlpUXLveXvXXiP4RSHVPCRWu3FWSv0S6aovF7zswtOEofkR6/x+vF
	 dN0KhvDeA4feDxlDi1wasmZMpuCRpLSiz3KzBU49UVD9x4lGUvbbAGWr4hTp3/oK+4
	 lVtr9qpVZczepZAi5TN6NFsqsVCn1G4KN/CsWk1RweeN1tVH5/m2rwE5UtVOTN8S28
	 TyZQhpEh7TVvPd/iUjPMdaj46lFSnxn9E5JHTsF/5EzTu0jKw2KShi+xEcarzM92ao
	 buu57h8eqDNi74itwP+WLeukM4yaSQeVxxxQfWdrTnHneQD5NRGxTkj0cSEv8IIbOS
	 By7Wwu61CgWPg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 08 May 2024 12:26:36 +0200
Subject: [PATCH RFC HID 1/7] HID: bpf: change the prog run logic
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-hid_bpf_async_fun-v1-1-558375a25657@kernel.org>
References: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
In-Reply-To: <20240508-hid_bpf_async_fun-v1-0-558375a25657@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715164017; l=35499;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=a9LJVsfpkf9Px0ybdQKegPbSIpTN8PO6xfWRp8iYXlk=;
 b=RxicqOIkALqLIzq4dY160kp4fkAH4TScBDNkZhhnQKmwK0KUrVWs0aDSksO1rnHqxJidpyevV
 4T52UFufWXWCZQ+u+b6JUQOp9i+/ZFlkL3hL8Qws7t/d84Yd2eoVUhK
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We were previously relying on a pre-loaded tracing bpf program which runs
bpf_tail_call(). However we can simplify this by a lot by relying on
the new __async suffix which gives us basically a function pointer to
the bpf program itself. This way, we rely on a much simpler process,
ditching entirely the prog fd array and that tracing bpf program.

Note the selftests will break and are handled in the later patch.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/entrypoints/Makefile            |  93 ---------
 drivers/hid/bpf/entrypoints/README              |   4 -
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c   |  25 ---
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h | 248 ------------------------
 drivers/hid/bpf/hid_bpf_dispatch.c              |  94 ++-------
 drivers/hid/bpf/hid_bpf_dispatch.h              |   8 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c             | 174 +++--------------
 include/linux/hid_bpf.h                         |   3 -
 8 files changed, 51 insertions(+), 598 deletions(-)

diff --git a/drivers/hid/bpf/entrypoints/Makefile b/drivers/hid/bpf/entrypoints/Makefile
deleted file mode 100644
index 43b99b5575cf..000000000000
--- a/drivers/hid/bpf/entrypoints/Makefile
+++ /dev/null
@@ -1,93 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-OUTPUT := .output
-abs_out := $(abspath $(OUTPUT))
-
-CLANG ?= clang
-LLC ?= llc
-LLVM_STRIP ?= llvm-strip
-
-TOOLS_PATH := $(abspath ../../../../tools)
-BPFTOOL_SRC := $(TOOLS_PATH)/bpf/bpftool
-BPFTOOL_OUTPUT := $(abs_out)/bpftool
-DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
-
-LIBBPF_SRC := $(TOOLS_PATH)/lib/bpf
-LIBBPF_OUTPUT := $(abs_out)/libbpf
-LIBBPF_DESTDIR := $(LIBBPF_OUTPUT)
-LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)/include
-BPFOBJ := $(LIBBPF_OUTPUT)/libbpf.a
-
-INCLUDES := -I$(OUTPUT) -I$(LIBBPF_INCLUDE) -I$(TOOLS_PATH)/include/uapi
-CFLAGS := -g -Wall
-
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
-
-ifeq ($(V),1)
-Q =
-msg =
-else
-Q = @
-msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
-MAKEFLAGS += --no-print-directory
-submake_extras := feature_display=0
-endif
-
-.DELETE_ON_ERROR:
-
-.PHONY: all clean
-
-all: entrypoints.lskel.h
-
-clean:
-	$(call msg,CLEAN)
-	$(Q)rm -rf $(OUTPUT) entrypoints
-
-entrypoints.lskel.h: $(OUTPUT)/entrypoints.bpf.o | $(BPFTOOL)
-	$(call msg,GEN-SKEL,$@)
-	$(Q)$(BPFTOOL) gen skeleton -L $< > $@
-
-
-$(OUTPUT)/entrypoints.bpf.o: entrypoints.bpf.c $(OUTPUT)/vmlinux.h $(BPFOBJ) | $(OUTPUT)
-	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 --target=bpf $(INCLUDES)			      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
-	$(LLVM_STRIP) -g $@
-
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
-ifeq ($(VMLINUX_H),)
-	$(call msg,GEN,,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
-else
-	$(call msg,CP,,$@)
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
-
-$(OUTPUT) $(LIBBPF_OUTPUT) $(BPFTOOL_OUTPUT):
-	$(call msg,MKDIR,$@)
-	$(Q)mkdir -p $@
-
-$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abspath $(dir $@))/ prefix=		       \
-		    DESTDIR=$(LIBBPF_DESTDIR) $(abspath $@) install_headers
-
-ifeq ($(CROSS_COMPILE),)
-$(DEFAULT_BPFTOOL): $(BPFOBJ) | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
-		    OUTPUT=$(BPFTOOL_OUTPUT)/				       \
-		    LIBBPF_BOOTSTRAP_OUTPUT=$(LIBBPF_OUTPUT)/		       \
-		    LIBBPF_BOOTSTRAP_DESTDIR=$(LIBBPF_DESTDIR)/ bootstrap
-else
-$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFTOOL_SRC)			       \
-		    OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
-endif
diff --git a/drivers/hid/bpf/entrypoints/README b/drivers/hid/bpf/entrypoints/README
deleted file mode 100644
index 147e0d41509f..000000000000
--- a/drivers/hid/bpf/entrypoints/README
+++ /dev/null
@@ -1,4 +0,0 @@
-WARNING:
-If you change "entrypoints.bpf.c" do "make -j" in this directory to rebuild "entrypoints.skel.h".
-Make sure to have clang 10 installed.
-See Documentation/bpf/bpf_devel_QA.rst
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c b/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
deleted file mode 100644
index c22921125a1a..000000000000
--- a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2022 Benjamin Tissoires */
-
-#include ".output/vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-#define HID_BPF_MAX_PROGS 1024
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(max_entries, HID_BPF_MAX_PROGS);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
-} hid_jmp_table SEC(".maps");
-
-SEC("fmod_ret/__hid_bpf_tail_call")
-int BPF_PROG(hid_tail_call, struct hid_bpf_ctx *hctx)
-{
-	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
-
-	return 0;
-}
-
-char LICENSE[] SEC("license") = "GPL";
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h b/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
deleted file mode 100644
index 35618051598c..000000000000
--- a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
+++ /dev/null
@@ -1,248 +0,0 @@
-/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
-#ifndef __ENTRYPOINTS_BPF_SKEL_H__
-#define __ENTRYPOINTS_BPF_SKEL_H__
-
-#include <bpf/skel_internal.h>
-
-struct entrypoints_bpf {
-	struct bpf_loader_ctx ctx;
-	struct {
-		struct bpf_map_desc hid_jmp_table;
-	} maps;
-	struct {
-		struct bpf_prog_desc hid_tail_call;
-	} progs;
-	struct {
-		int hid_tail_call_fd;
-	} links;
-};
-
-static inline int
-entrypoints_bpf__hid_tail_call__attach(struct entrypoints_bpf *skel)
-{
-	int prog_fd = skel->progs.hid_tail_call.prog_fd;
-	int fd = skel_raw_tracepoint_open(NULL, prog_fd);
-
-	if (fd > 0)
-		skel->links.hid_tail_call_fd = fd;
-	return fd;
-}
-
-static inline int
-entrypoints_bpf__attach(struct entrypoints_bpf *skel)
-{
-	int ret = 0;
-
-	ret = ret < 0 ? ret : entrypoints_bpf__hid_tail_call__attach(skel);
-	return ret < 0 ? ret : 0;
-}
-
-static inline void
-entrypoints_bpf__detach(struct entrypoints_bpf *skel)
-{
-	skel_closenz(skel->links.hid_tail_call_fd);
-}
-static void
-entrypoints_bpf__destroy(struct entrypoints_bpf *skel)
-{
-	if (!skel)
-		return;
-	entrypoints_bpf__detach(skel);
-	skel_closenz(skel->progs.hid_tail_call.prog_fd);
-	skel_closenz(skel->maps.hid_jmp_table.map_fd);
-	skel_free(skel);
-}
-static inline struct entrypoints_bpf *
-entrypoints_bpf__open(void)
-{
-	struct entrypoints_bpf *skel;
-
-	skel = skel_alloc(sizeof(*skel));
-	if (!skel)
-		goto cleanup;
-	skel->ctx.sz = (void *)&skel->links - (void *)skel;
-	return skel;
-cleanup:
-	entrypoints_bpf__destroy(skel);
-	return NULL;
-}
-
-static inline int
-entrypoints_bpf__load(struct entrypoints_bpf *skel)
-{
-	struct bpf_load_and_run_opts opts = {};
-	int err;
-
-	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = 2856;
-	opts.data = (void *)"\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9f\xeb\x01\0\
-\x18\0\0\0\0\0\0\0\x60\x02\0\0\x60\x02\0\0\x12\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
-\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
-\0\0\x04\0\0\0\x03\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
-\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\
-\0\0\0\x02\x08\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x04\0\0\0\0\
-\0\0\0\x04\0\0\x04\x20\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\
-\x40\0\0\0\x2a\0\0\0\x07\0\0\0\x80\0\0\0\x33\0\0\0\x07\0\0\0\xc0\0\0\0\x3e\0\0\
-\0\0\0\0\x0e\x09\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x0c\0\0\0\x4c\0\0\0\0\0\0\
-\x01\x08\0\0\0\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x5f\0\0\0\x0b\0\0\0\x63\
-\0\0\0\x01\0\0\x0c\x0d\0\0\0\x09\x01\0\0\x05\0\0\x04\x20\0\0\0\x15\x01\0\0\x10\
-\0\0\0\0\0\0\0\x1b\x01\0\0\x12\0\0\0\x40\0\0\0\x1f\x01\0\0\x10\0\0\0\x80\0\0\0\
-\x2e\x01\0\0\x14\0\0\0\xa0\0\0\0\0\0\0\0\x15\0\0\0\xc0\0\0\0\x3a\x01\0\0\0\0\0\
-\x08\x11\0\0\0\x40\x01\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\x02\x13\
-\0\0\0\0\0\0\0\0\0\0\x0a\x1c\0\0\0\x4d\x01\0\0\x04\0\0\x06\x04\0\0\0\x5d\x01\0\
-\0\0\0\0\0\x6e\x01\0\0\x01\0\0\0\x80\x01\0\0\x02\0\0\0\x93\x01\0\0\x03\0\0\0\0\
-\0\0\0\x02\0\0\x05\x04\0\0\0\xa4\x01\0\0\x16\0\0\0\0\0\0\0\xab\x01\0\0\x16\0\0\
-\0\0\0\0\0\xb0\x01\0\0\0\0\0\x08\x02\0\0\0\xec\x01\0\0\0\0\0\x01\x01\0\0\0\x08\
-\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\xf1\x01\0\0\0\
-\0\0\x0e\x18\0\0\0\x01\0\0\0\xf9\x01\0\0\x01\0\0\x0f\x20\0\0\0\x0a\0\0\0\0\0\0\
-\0\x20\0\0\0\xff\x01\0\0\x01\0\0\x0f\x04\0\0\0\x19\0\0\0\0\0\0\0\x04\0\0\0\x07\
-\x02\0\0\0\0\0\x07\0\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\
-\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\x5f\
-\x65\x6e\x74\x72\x69\x65\x73\0\x6b\x65\x79\x5f\x73\x69\x7a\x65\0\x76\x61\x6c\
-\x75\x65\x5f\x73\x69\x7a\x65\0\x68\x69\x64\x5f\x6a\x6d\x70\x5f\x74\x61\x62\x6c\
-\x65\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\
-\0\x63\x74\x78\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\x66\x6d\
-\x6f\x64\x5f\x72\x65\x74\x2f\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\
-\x69\x6c\x5f\x63\x61\x6c\x6c\0\x2f\x68\x6f\x6d\x65\x2f\x62\x74\x69\x73\x73\x6f\
-\x69\x72\x2f\x53\x72\x63\x2f\x68\x69\x64\x2f\x64\x72\x69\x76\x65\x72\x73\x2f\
-\x68\x69\x64\x2f\x62\x70\x66\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\
-\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\x2e\x62\x70\x66\x2e\x63\0\x69\
-\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x68\x69\x64\x5f\x74\x61\x69\
-\x6c\x5f\x63\x61\x6c\x6c\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x68\x69\x64\x5f\
-\x62\x70\x66\x5f\x63\x74\x78\x20\x2a\x68\x63\x74\x78\x29\0\x68\x69\x64\x5f\x62\
-\x70\x66\x5f\x63\x74\x78\0\x69\x6e\x64\x65\x78\0\x68\x69\x64\0\x61\x6c\x6c\x6f\
-\x63\x61\x74\x65\x64\x5f\x73\x69\x7a\x65\0\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\
-\x70\x65\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\
-\x74\0\x68\x69\x64\x5f\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\x70\x65\0\x48\x49\
-\x44\x5f\x49\x4e\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x4f\
-\x55\x54\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x46\x45\x41\
-\x54\x55\x52\x45\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x52\x45\x50\x4f\
-\x52\x54\x5f\x54\x59\x50\x45\x53\0\x72\x65\x74\x76\x61\x6c\0\x73\x69\x7a\x65\0\
-\x5f\x5f\x73\x33\x32\0\x30\x3a\x30\0\x09\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\
-\x63\x61\x6c\x6c\x28\x63\x74\x78\x2c\x20\x26\x68\x69\x64\x5f\x6a\x6d\x70\x5f\
-\x74\x61\x62\x6c\x65\x2c\x20\x68\x63\x74\x78\x2d\x3e\x69\x6e\x64\x65\x78\x29\
-\x3b\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x2e\x6d\x61\x70\x73\0\
-\x6c\x69\x63\x65\x6e\x73\x65\0\x68\x69\x64\x5f\x64\x65\x76\x69\x63\x65\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8a\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\
-\0\0\0\x04\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\x64\x5f\
-\x6a\x6d\x70\x5f\x74\x61\x62\x6c\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x12\0\0\0\0\0\0\x61\x23\0\0\0\0\
-\0\0\x18\x52\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\0\0\0\x0c\0\0\0\xb7\0\0\0\0\0\0\0\
-\x95\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0\0\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\x48\0\0\
-\x01\0\0\0\x8e\0\0\0\xba\x01\0\0\x02\x50\0\0\x05\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\
-\x48\0\0\x08\0\0\0\x0f\0\0\0\xb6\x01\0\0\0\0\0\0\x1a\0\0\0\x07\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\
-\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\0\0\0\0\x1a\0\0\0\0\0\0\0\
-\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x01\0\
-\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x5f\
-\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\
-\0\0";
-	opts.insns_sz = 1192;
-	opts.insns = (void *)"\
-\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
-\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x11\0\0\0\0\0\x61\
-\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
-\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
-\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\
-\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\
-\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xa8\x09\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\xa4\x09\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x98\x09\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\
-\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\xb7\x03\0\0\x1c\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd7\xff\0\0\0\0\x63\x7a\x78\
-\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\xbc\x09\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\
-\0\0\0\xb0\x09\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\
-\0\xc5\x07\xca\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf8\x09\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\
-\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0a\0\0\x18\x61\0\0\
-\0\0\0\0\0\0\0\0\x88\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\x38\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\x40\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0a\0\0\
-\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x0a\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\0\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0a\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x9c\x0a\0\0\x63\x01\0\0\0\0\0\0\x79\x60\
-\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\
-\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0a\0\0\x63\x01\0\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0b\0\0\xb7\x02\0\0\x14\0\0\0\xb7\x03\0\0\
-\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
-\x91\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x80\x0a\0\0\x63\x70\x6c\0\0\0\0\0\
-\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x80\x0a\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf0\x0a\0\0\x61\x01\0\0\0\0\0\0\xd5\
-\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x7f\xff\0\0\
-\0\0\x63\x7a\x80\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\
-\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\x28\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\
-\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
-	err = bpf_load_and_run(&opts);
-	if (err < 0)
-		return err;
-	return 0;
-}
-
-static inline struct entrypoints_bpf *
-entrypoints_bpf__open_and_load(void)
-{
-	struct entrypoints_bpf *skel;
-
-	skel = entrypoints_bpf__open();
-	if (!skel)
-		return NULL;
-	if (entrypoints_bpf__load(skel)) {
-		entrypoints_bpf__destroy(skel);
-		return NULL;
-	}
-	return skel;
-}
-
-__attribute__((unused)) static void
-entrypoints_bpf__assert(struct entrypoints_bpf *s __attribute__((unused)))
-{
-#ifdef __cplusplus
-#define _Static_assert static_assert
-#endif
-#ifdef __cplusplus
-#undef _Static_assert
-#endif
-}
-
-#endif /* __ENTRYPOINTS_BPF_SKEL_H__ */
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 10289f44d0cc..81073db6c617 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/fdtable.h>
 #include <linux/filter.h>
 #include <linux/hid.h>
 #include <linux/hid_bpf.h>
@@ -19,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/workqueue.h>
 #include "hid_bpf_dispatch.h"
-#include "entrypoints/entrypoints.lskel.h"
 
 struct hid_bpf_ops *hid_bpf_ops;
 EXPORT_SYMBOL(hid_bpf_ops);
@@ -203,25 +203,17 @@ int hid_bpf_reconnect(struct hid_device *hdev)
 	return 0;
 }
 
-static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct bpf_prog *prog,
+static int do_hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
+				  hid_bpf_cb_t prog_fn, struct bpf_prog *prog,
 				  __u32 flags)
 {
-	int fd, err, prog_type;
+	int fd, err;
 
-	prog_type = hid_bpf_get_prog_attach_type(prog);
-	if (prog_type < 0)
-		return prog_type;
+	err = hid_bpf_allocate_event_data(hdev);
+	if (err)
+		return err;
 
-	if (prog_type >= HID_BPF_PROG_TYPE_MAX)
-		return -EINVAL;
-
-	if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
-		err = hid_bpf_allocate_event_data(hdev);
-		if (err)
-			return err;
-	}
-
-	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, prog, flags);
+	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fn, prog, flags);
 	if (fd < 0)
 		return fd;
 
@@ -277,10 +269,12 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
  */
 /* called from syscall */
 __bpf_kfunc int
-hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
+hid_bpf_attach_prog_impl(unsigned int hid_id, enum hid_bpf_prog_type prog_type,
+			 hid_bpf_cb_t prog_fn__async, __u32 flags, void *prog__aux)
 {
+	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)prog__aux;
+	struct bpf_prog *prog = aux->prog;
 	struct hid_device *hdev;
-	struct bpf_prog *prog;
 	struct device *dev;
 	int err, fd;
 
@@ -290,6 +284,9 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 	if ((flags & ~HID_BPF_FLAG_MASK))
 		return -EINVAL;
 
+	if (prog_type < 0 || prog_type >= HID_BPF_PROG_TYPE_MAX)
+		return -EINVAL;
+
 	dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
 	if (!dev)
 		return -EINVAL;
@@ -300,13 +297,13 @@ hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
 	 * take a ref on the prog itself, it will be released
 	 * on errors or when it'll be detached
 	 */
-	prog = bpf_prog_get(prog_fd);
+	prog = bpf_prog_inc_not_zero(prog);
 	if (IS_ERR(prog)) {
 		err = PTR_ERR(prog);
 		goto out_dev_put;
 	}
 
-	fd = do_hid_bpf_attach_prog(hdev, prog_fd, prog, flags);
+	fd = do_hid_bpf_attach_prog(hdev, prog_type, prog_fn__async, prog, flags);
 	if (fd < 0) {
 		err = fd;
 		goto out_prog_put;
@@ -538,12 +535,9 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 }
 __bpf_kfunc_end_defs();
 
-/*
- * The following set contains all functions we agree BPF programs
- * can use.
- */
 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
+BTF_ID_FLAGS(func, hid_bpf_attach_prog_impl, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
@@ -556,33 +550,6 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 	.set   = &hid_bpf_kfunc_ids,
 };
 
-/* our HID-BPF entrypoints */
-BTF_SET8_START(hid_bpf_fmodret_ids)
-BTF_ID_FLAGS(func, hid_bpf_device_event)
-BTF_ID_FLAGS(func, hid_bpf_rdesc_fixup)
-BTF_ID_FLAGS(func, __hid_bpf_tail_call)
-BTF_SET8_END(hid_bpf_fmodret_ids)
-
-static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
-	.owner = THIS_MODULE,
-	.set   = &hid_bpf_fmodret_ids,
-};
-
-/* for syscall HID-BPF */
-BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
-BTF_ID_FLAGS(func, hid_bpf_attach_prog)
-BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
-BTF_ID_FLAGS(func, hid_bpf_hw_request)
-BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
-BTF_ID_FLAGS(func, hid_bpf_input_report)
-BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
-
-static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
-	.owner = THIS_MODULE,
-	.set   = &hid_bpf_syscall_kfunc_ids,
-};
-
 int hid_bpf_connect_device(struct hid_device *hdev)
 {
 	struct hid_bpf_prog_list *prog_list;
@@ -636,29 +603,9 @@ static int __init hid_bpf_init(void)
 	 * will not be available, so nobody will be able to use the functionality.
 	 */
 
-	err = register_btf_fmodret_id_set(&hid_bpf_fmodret_set);
-	if (err) {
-		pr_warn("error while registering fmodret entrypoints: %d", err);
-		return 0;
-	}
-
-	err = hid_bpf_preload_skel();
-	if (err) {
-		pr_warn("error while preloading HID BPF dispatcher: %d", err);
-		return 0;
-	}
-
-	/* register tracing kfuncs after we are sure we can load our preloaded bpf program */
-	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
-	if (err) {
-		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
-		return 0;
-	}
-
-	/* register syscalls after we are sure we can load our preloaded bpf program */
-	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_kfunc_set);
 	if (err) {
-		pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
+		pr_warn("error while setting HID BPF kfuncs: %d", err);
 		return 0;
 	}
 
@@ -670,7 +617,6 @@ static void __exit hid_bpf_exit(void)
 	/* HID depends on us, so if we hit that code, we are guaranteed that hid
 	 * has been removed and thus we do not need to clear the HID devices
 	 */
-	hid_bpf_free_links_and_skel();
 }
 
 late_initcall(hid_bpf_init);
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index fbe0639d09f2..60455a2af216 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -10,10 +10,10 @@ struct hid_bpf_ctx_kern {
 	u8 *data;
 };
 
-int hid_bpf_preload_skel(void);
-void hid_bpf_free_links_and_skel(void);
-int hid_bpf_get_prog_attach_type(struct bpf_prog *prog);
-int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type, int prog_fd,
+typedef int (*hid_bpf_cb_t)(struct hid_bpf_ctx *hid_ctx);
+
+int __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
+			  int (prog_fn__async)(struct hid_bpf_ctx *hid_ctx),
 			  struct bpf_prog *prog, __u32 flags);
 void __hid_bpf_destroy_device(struct hid_device *hdev);
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index aa8e1c79cdf5..8d53d41b599b 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/workqueue.h>
 #include "hid_bpf_dispatch.h"
-#include "entrypoints/entrypoints.lskel.h"
 
 #define HID_BPF_MAX_PROGS 1024 /* keep this in sync with preloaded bpf,
 				* needs to be a power of 2 as we use it as
@@ -37,11 +36,15 @@ struct hid_bpf_prog_entry {
 	u16 idx;
 };
 
+struct hid_bpf_prog_cb {
+	struct bpf_prog *prog;
+	void *fn;
+};
+
 struct hid_bpf_jmp_table {
-	struct bpf_map *map;
 	struct hid_bpf_prog_entry entries[HID_BPF_MAX_PROGS]; /* compacted list, circular buffer */
 	int tail, head;
-	struct bpf_prog *progs[HID_BPF_MAX_PROGS]; /* idx -> progs mapping */
+	struct hid_bpf_prog_cb prog_cbs[HID_BPF_MAX_PROGS]; /* idx -> progs mapping */
 	unsigned long enabled[BITS_TO_LONGS(HID_BPF_MAX_PROGS)];
 };
 
@@ -56,10 +59,6 @@ static void hid_bpf_release_progs(struct work_struct *work);
 
 static DECLARE_WORK(release_work, hid_bpf_release_progs);
 
-BTF_ID_LIST(hid_bpf_btf_ids)
-BTF_ID(func, hid_bpf_device_event)			/* HID_BPF_PROG_TYPE_DEVICE_EVENT */
-BTF_ID(func, hid_bpf_rdesc_fixup)			/* HID_BPF_PROG_TYPE_RDESC_FIXUP */
-
 static int hid_bpf_max_programs(enum hid_bpf_prog_type type)
 {
 	switch (type) {
@@ -99,15 +98,11 @@ static int hid_bpf_program_count(struct hid_device *hdev,
 	return n;
 }
 
-__weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
-{
-	return 0;
-}
-
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 		     struct hid_bpf_ctx_kern *ctx_kern)
 {
 	struct hid_bpf_prog_list *prog_list;
+	bpf_callback_t prog_fn;
 	int i, idx, err = 0;
 
 	rcu_read_lock();
@@ -123,7 +118,10 @@ int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 			continue;
 
 		ctx_kern->ctx.index = idx;
-		err = __hid_bpf_tail_call(&ctx_kern->ctx);
+		prog_fn = jmp_table.prog_cbs[idx].fn;
+		migrate_disable();
+		err = prog_fn((u64)(long)&ctx_kern->ctx, 0, 0, 0, 0);
+		migrate_enable();
 		if (err < 0)
 			break;
 		if (err)
@@ -187,25 +185,18 @@ static int hid_bpf_populate_hdev(struct hid_device *hdev, enum hid_bpf_prog_type
 	return 0;
 }
 
-static void __hid_bpf_do_release_prog(int map_fd, unsigned int idx)
+static void __hid_bpf_do_release_prog(unsigned int idx)
 {
-	skel_map_delete_elem(map_fd, &idx);
-	jmp_table.progs[idx] = NULL;
+	bpf_prog_put(jmp_table.prog_cbs[idx].prog);
+	jmp_table.prog_cbs[idx].prog = NULL;
+	jmp_table.prog_cbs[idx].fn = NULL;
 }
 
 static void hid_bpf_release_progs(struct work_struct *work)
 {
-	int i, j, n, map_fd = -1;
+	int i, j, n;
 	bool hdev_destroyed;
 
-	if (!jmp_table.map)
-		return;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-	if (map_fd < 0)
-		return;
-
 	mutex_lock(&hid_bpf_attach_lock); /* protects against attaching new programs */
 
 	/* detach unused progs from HID devices */
@@ -264,7 +255,7 @@ static void hid_bpf_release_progs(struct work_struct *work)
 			continue;
 
 		if (entry->prog)
-			__hid_bpf_do_release_prog(map_fd, entry->idx);
+			__hid_bpf_do_release_prog(entry->idx);
 	}
 
 	/* compact the entry list */
@@ -282,46 +273,22 @@ static void hid_bpf_release_progs(struct work_struct *work)
 	jmp_table.head = n;
 
 	mutex_unlock(&hid_bpf_attach_lock);
-
-	if (map_fd >= 0)
-		close_fd(map_fd);
-}
-
-static void hid_bpf_release_prog_at(int idx)
-{
-	int map_fd = -1;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-	if (map_fd < 0)
-		return;
-
-	__hid_bpf_do_release_prog(map_fd, idx);
-
-	close(map_fd);
 }
 
 /*
- * Insert the given BPF program represented by its fd in the jmp table.
+ * Insert the given BPF program represented by its function call in the jmp table.
  * Returns the index in the jump table or a negative error.
  */
-static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
+static int hid_bpf_insert_prog(struct bpf_prog *prog, hid_bpf_cb_t prog_fn)
 {
-	int i, index = -1, map_fd = -1, err = -EINVAL;
-
-	/* retrieve a fd of our prog_array map in BPF */
-	map_fd = skel_map_get_fd_by_id(jmp_table.map->id);
-
-	if (map_fd < 0) {
-		err = -EINVAL;
-		goto out;
-	}
+	int i, index = -1, err = -EINVAL;
 
 	/* find the first available index in the jmp_table */
 	for (i = 0; i < HID_BPF_MAX_PROGS; i++) {
-		if (!jmp_table.progs[i] && index < 0) {
+		if (!jmp_table.prog_cbs[i].prog && index < 0) {
 			/* mark the index as used */
-			jmp_table.progs[i] = prog;
+			jmp_table.prog_cbs[i].fn = prog_fn;
+			jmp_table.prog_cbs[i].prog = prog;
 			index = i;
 			__set_bit(i, jmp_table.enabled);
 		}
@@ -331,37 +298,15 @@ static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
 		goto out;
 	}
 
-	/* insert the program in the jump table */
-	err = skel_map_update_elem(map_fd, &index, &prog_fd, 0);
-	if (err)
-		goto out;
-
 	/* return the index */
 	err = index;
 
  out:
 	if (err < 0)
-		__hid_bpf_do_release_prog(map_fd, index);
-	if (map_fd >= 0)
-		close_fd(map_fd);
+		__hid_bpf_do_release_prog(index);
 	return err;
 }
 
-int hid_bpf_get_prog_attach_type(struct bpf_prog *prog)
-{
-	int prog_type = HID_BPF_PROG_TYPE_UNDEF;
-	int i;
-
-	for (i = 0; i < HID_BPF_PROG_TYPE_MAX; i++) {
-		if (hid_bpf_btf_ids[i] == prog->aux->attach_btf_id) {
-			prog_type = i;
-			break;
-		}
-	}
-
-	return prog_type;
-}
-
 static void hid_bpf_link_release(struct bpf_link *link)
 {
 	struct hid_bpf_link *hid_link =
@@ -395,7 +340,7 @@ static const struct bpf_link_ops hid_bpf_link_lops = {
 /* called from syscall */
 noinline int
 __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
-		      int prog_fd, struct bpf_prog *prog, __u32 flags)
+		      hid_bpf_cb_t prog_fn, struct bpf_prog *prog, __u32 flags)
 {
 	struct bpf_link_primer link_primer;
 	struct hid_bpf_link *link;
@@ -425,7 +370,7 @@ __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 		goto err_unlock;
 	}
 
-	prog_table_idx = hid_bpf_insert_prog(prog_fd, prog);
+	prog_table_idx = hid_bpf_insert_prog(prog, prog_fn);
 	/* if the jmp table is full, abort */
 	if (prog_table_idx < 0) {
 		err = prog_table_idx;
@@ -451,7 +396,7 @@ __hid_bpf_attach_prog(struct hid_device *hdev, enum hid_bpf_prog_type prog_type,
 	/* finally store the index in the device list */
 	err = hid_bpf_populate_hdev(hdev, prog_type);
 	if (err) {
-		hid_bpf_release_prog_at(prog_table_idx);
+		__hid_bpf_do_release_prog(prog_table_idx);
 		goto err_unlock;
 	}
 
@@ -498,68 +443,3 @@ void __hid_bpf_destroy_device(struct hid_device *hdev)
 	/* schedule release of all detached progs */
 	schedule_work(&release_work);
 }
-
-#define HID_BPF_PROGS_COUNT 1
-
-static struct bpf_link *links[HID_BPF_PROGS_COUNT];
-static struct entrypoints_bpf *skel;
-
-void hid_bpf_free_links_and_skel(void)
-{
-	int i;
-
-	/* the following is enough to release all programs attached to hid */
-	if (jmp_table.map)
-		bpf_map_put_with_uref(jmp_table.map);
-
-	for (i = 0; i < ARRAY_SIZE(links); i++) {
-		if (!IS_ERR_OR_NULL(links[i]))
-			bpf_link_put(links[i]);
-	}
-	entrypoints_bpf__destroy(skel);
-}
-
-#define ATTACH_AND_STORE_LINK(__name) do {					\
-	err = entrypoints_bpf__##__name##__attach(skel);			\
-	if (err)								\
-		goto out;							\
-										\
-	links[idx] = bpf_link_get_from_fd(skel->links.__name##_fd);		\
-	if (IS_ERR(links[idx])) {						\
-		err = PTR_ERR(links[idx]);					\
-		goto out;							\
-	}									\
-										\
-	/* Avoid taking over stdin/stdout/stderr of init process. Zeroing out	\
-	 * makes skel_closenz() a no-op later in iterators_bpf__destroy().	\
-	 */									\
-	close_fd(skel->links.__name##_fd);					\
-	skel->links.__name##_fd = 0;						\
-	idx++;									\
-} while (0)
-
-int hid_bpf_preload_skel(void)
-{
-	int err, idx = 0;
-
-	skel = entrypoints_bpf__open();
-	if (!skel)
-		return -ENOMEM;
-
-	err = entrypoints_bpf__load(skel);
-	if (err)
-		goto out;
-
-	jmp_table.map = bpf_map_get_with_uref(skel->maps.hid_jmp_table.map_fd);
-	if (IS_ERR(jmp_table.map)) {
-		err = PTR_ERR(jmp_table.map);
-		goto out;
-	}
-
-	ATTACH_AND_STORE_LINK(hid_tail_call);
-
-	return 0;
-out:
-	hid_bpf_free_links_and_skel();
-	return err;
-}
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 17b08f500098..99ebe7bbb02a 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -81,9 +81,6 @@ int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
  * Below is HID internal
  */
 
-/* internal function to call eBPF programs, not to be used by anybody */
-int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx);
-
 #define HID_BPF_MAX_PROGS_PER_DEV 64
 #define HID_BPF_FLAG_MASK (((HID_BPF_FLAG_MAX - 1) << 1) - 1)
 

-- 
2.44.0


