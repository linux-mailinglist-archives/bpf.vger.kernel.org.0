Return-Path: <bpf+bounces-79414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 226FBD39CD6
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9545C3001828
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97126E6F9;
	Mon, 19 Jan 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zbg3D1MW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337621FF30
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793265; cv=none; b=dIgJOlzTX/LuS8aNLCpe5uUjahQqh6ry+UVhP8WOJlkeMSbRQnvo4r4DHJ9gg0lV8C5c9saRdwmmVOIpW8afLKoQ9cwdoUOTw8zWtEofQum7RFHS1HtYJre3H2pg7v4uI3RRZisW9PAhYYc17svwpPAF4p2k97sixmDC09NVueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793265; c=relaxed/simple;
	bh=aCbZkW8kghpGHxk1L3WWQksjBwASoq8bfVrudB8THwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5yNI3eGuXEjpZiyXdleuG8oo1bxT6V+nvK0rY8aSLa/eJYAibazFV7Fp1/4SkMRD1L44q0rtKOQx78Wv8oqa/esh+oCv/QyYRZZc/Hk9X4MP8AGKbgUUV7Hlf/QFkPLqfu8uQOy+xP+ShoKZtT2hZGkluwLHazfhnHxsKGRSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zbg3D1MW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7e1a7E+uvRoZBCO9NzWoxFmszs+807PaqpN5o4A8o3o=;
	b=Zbg3D1MWbpx5dIHg5m3baTdF8azdeeAPxgqIY74vVJH8rR18R1OFRizrbDIS1BeZWS8L3R
	CXjxAySRJqyzsn8xLIdvF2ymVsNBdFFZVMZQqth2N/+v7btp8hrhLF3IuJaq2TYSeMdeHP
	azgLQApstukodavW++VEcajZawlu84U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-clfPM9rKOCWoZFDTAR5pXA-1; Sun,
 18 Jan 2026 22:27:38 -0500
X-MC-Unique: clfPM9rKOCWoZFDTAR5pXA-1
X-Mimecast-MFC-AGG-ID: clfPM9rKOCWoZFDTAR5pXA_1768793256
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8063119560B2;
	Mon, 19 Jan 2026 03:27:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AB861955F22;
	Mon, 19 Jan 2026 03:27:25 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 12/13] tools/kexec: Introduce a bpf-prog to parse zboot image format
Date: Mon, 19 Jan 2026 11:24:23 +0800
Message-ID: <20260119032424.10781-13-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This BPF program aligns with the convention defined in the kernel file
kexec_pe_parser_bpf.lskel.h. This can be easily achieved by include
"template.c", which includes:
    four maps:
                    struct bpf_map_desc ringbuf_1;
                    struct bpf_map_desc ringbuf_2;
                    struct bpf_map_desc ringbuf_3;
                    struct bpf_map_desc ringbuf_4;
    four sections:
                    struct bpf_map_desc rodata;
                    struct bpf_map_desc data;
                    struct bpf_map_desc bss;
                    struct bpf_map_desc rodata_str1_1;

The only left thing is to implement a prog
SEC("fentry.s/kexec_image_parser_anchor")
int BPF_PROG(parse_pe, struct kexec_context *context, unsigned long parser_id)

This BPF program only uses ringbuf_1, so it minimizes the size of the
other three ringbufs to one byte. The size of ringbuf_1 is derived from
the size of the uncompressed file 'vmlinux.bin', which is usually less
than 64MB. With the help of the BPF kfunc bpf_buffer_parser(), the BPF
program passes instructions to the kexec BPF component to perform the
appropriate actions.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile           |  83 ++++++++++++++++++++++++
 tools/kexec/template.c         |  68 ++++++++++++++++++++
 tools/kexec/zboot_parser_bpf.c | 114 +++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/template.c
 create mode 100644 tools/kexec/zboot_parser_bpf.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
new file mode 100644
index 0000000000000..88db6d11bde61
--- /dev/null
+++ b/tools/kexec/Makefile
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Ensure Kbuild variables are available
+include ../scripts/Makefile.include
+
+srctree := $(patsubst %/tools/kexec,%,$(CURDIR))
+VMLINUX = $(srctree)/vmlinux
+TOOLSDIR := $(srctree)/tools
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+ARCH ?= $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/ -e s/riscv64/riscv/ -e s/loongarch.*/loongarch/)
+# At present, zboot image format is used by arm64, riscv, loongarch
+# And arch/$(ARCH)/boot/vmlinux.bin is the uncompressed file instead of arch/$(ARCH)/boot/Image
+ifeq ($(ARCH),$(filter $(ARCH),arm64 riscv loongarch))
+	EFI_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinuz.efi
+	KERNEL_IMAGE := $(srctree)/arch/$(ARCH)/boot/vmlinux.bin
+else
+	@echo "Unsupported architecture: $(ARCH)"
+	@exit 1
+endif
+
+
+CC = clang
+CFLAGS = -O2
+BPF_PROG_CFLAGS = -g -O2 -target bpf -Wall -I $(BPFDIR) -I .
+BPFTOOL = bpftool
+
+# List of generated target files
+HEADERS = vmlinux.h bpf_helper_defs.h image_size.h
+ZBOOT_TARGETS = zboot_parser_bpf.o zboot_parser_bpf.lskel.h bytecode.c bytecode.o
+
+
+# Targets
+zboot: $(HEADERS) $(ZBOOT_TARGETS)
+
+# Rule to generate vmlinux.h from vmlinux
+vmlinux.h: $(VMLINUX)
+	@command -v $(BPFTOOL) >/dev/null 2>&1 || { echo >&2 "$(BPFTOOL) is required but not found. Please install it."; exit 1; }
+	@$(BPFTOOL) btf dump file $(VMLINUX) format c > vmlinux.h
+
+bpf_helper_defs.h: $(srctree)/tools/include/uapi/linux/bpf.h
+	@$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
+		--file $(srctree)/tools/include/uapi/linux/bpf.h > bpf_helper_defs.h
+
+image_size.h: $(KERNEL_IMAGE)
+	@{ \
+		if [ ! -f "$(KERNEL_IMAGE)" ]; then \
+			echo "Error: File '$(KERNEL_IMAGE)' does not exist"; \
+			exit 1; \
+		fi; \
+		FILE_SIZE=$$(stat -c '%s' "$(KERNEL_IMAGE)" 2>/dev/null); \
+		POWER=4096; \
+		while [ $$POWER -le $$FILE_SIZE ]; do \
+			POWER=$$((POWER * 2)); \
+		done; \
+		RINGBUF_SIZE=$$POWER; \
+		echo "#define IMAGE_SIZE_POWER2_ALIGN $$RINGBUF_SIZE" > $@; \
+		echo "#define IMAGE_SIZE $$FILE_SIZE" >> $@; \
+	}
+
+
+# Rule to generate zboot_parser_bpf.o, depends on vmlinux.h
+zboot_parser_bpf.o: zboot_parser_bpf.c vmlinux.h bpf_helper_defs.h
+	@$(CC) $(BPF_PROG_CFLAGS) -c zboot_parser_bpf.c -o zboot_parser_bpf.o
+
+# Generate zboot_parser_bpf.lskel.h using bpftool
+zboot_parser_bpf.lskel.h: zboot_parser_bpf.o
+	@$(BPFTOOL) gen skeleton -L zboot_parser_bpf.o > zboot_parser_bpf.lskel.h
+
+# Then, extract the opts_data[] and opts_insn[] arrays and remove 'static'
+# keywords to avoid being optimized away.
+bytecode.c: zboot_parser_bpf.lskel.h
+	@sed -n '/static const char opts_data\[\]/,/;/p' zboot_parser_bpf.lskel.h | sed 's/static const/const/' > $@
+	@sed -n '/static const char opts_insn\[\]/,/;/p' zboot_parser_bpf.lskel.h | sed 's/static const/const/' >> $@
+
+bytecode.o: bytecode.c
+	@$(CC) -c $< -o $@
+
+# Clean up generated files
+clean:
+	@rm -f $(HEADERS) $(ZBOOT_TARGETS)
+
+.PHONY: all clean
diff --git a/tools/kexec/template.c b/tools/kexec/template.c
new file mode 100644
index 0000000000000..9f17a4952ecd4
--- /dev/null
+++ b/tools/kexec/template.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2026 Red Hat, Inc
+//
+// Original file: kernel/kexec_bpf/template.c
+//
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+/* Command to kernel kexec bpf loader, which is defined on the stream */
+#define KEXEC_BPF_CMD_DECOMPRESS	0x1
+#define KEXEC_BPF_CMD_COPY		0x2
+
+#define KEXEC_BPF_SUBCMD_KERNEL		0x1
+#define KEXEC_BPF_SUBCMD_INITRD		0x2
+#define KEXEC_BPF_SUBCMD_CMDLINE	0x3
+
+/*
+ * The ringbufs can have different capacity. But only four ringbuf are provided.
+ */
+#ifndef RINGBUF1_SIZE
+#define RINGBUF1_SIZE	4
+#endif
+#ifndef RINGBUF2_SIZE
+#define RINGBUF2_SIZE	4
+#endif
+#ifndef RINGBUF3_SIZE
+#define RINGBUF3_SIZE	4
+#endif
+#ifndef RINGBUF4_SIZE
+#define RINGBUF4_SIZE	4
+#endif
+
+/* ringbuf is safe since the user space has no write access to them */
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF1_SIZE);
+} ringbuf_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF2_SIZE);
+} ringbuf_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF3_SIZE);
+} ringbuf_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF4_SIZE);
+} ringbuf_4 SEC(".maps");
+
+char LICENSE[] SEC("license") = "GPL";
+
+/*
+ * This function ensures that the sections .rodata, .data, .rodata.str1.1 and .bss
+ * are created for a bpf prog.
+ */
+static const char dummy_rodata[16] __attribute__((used)) = "rodata";
+static char dummy_data[16] __attribute__((used)) = "data";
+static char *dummy_mergeable_str  __attribute__((used)) = ".rodata.str1.1";
+static char dummy_bss[16] __attribute__((used));
+
diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
new file mode 100644
index 0000000000000..54c4b762b3324
--- /dev/null
+++ b/tools/kexec/zboot_parser_bpf.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2025, 2026 Red Hat, Inc
+//
+#include "vmlinux.h"
+#include <bpf_helpers.h>
+#include <bpf_tracing.h>
+#include "image_size.h"
+
+/* ringbuf 2,3,4 are useless */
+#define MIN_BUF_SIZE 1
+#define MAX_RECORD_SIZE (IMAGE_SIZE + 40960)
+#define RINGBUF1_SIZE IMAGE_SIZE_POWER2_ALIGN
+#define RINGBUF2_SIZE MIN_BUF_SIZE
+#define RINGBUF3_SIZE MIN_BUF_SIZE
+#define RINGBUF4_SIZE MIN_BUF_SIZE
+
+
+#include "template.c"
+
+/* see drivers/firmware/efi/libstub/zboot-header.S */
+struct linux_pe_zboot_header {
+	unsigned int mz_magic;
+	char image_type[4];
+	unsigned int payload_offset;
+	unsigned int payload_size;
+	unsigned int reserved[2];
+	char comp_type[4];
+	unsigned int linux_pe_magic;
+	unsigned int pe_header_offset;
+} __attribute__((packed));
+
+
+SEC("fentry.s/kexec_image_parser_anchor")
+int BPF_PROG(parse_pe, struct kexec_context *context, unsigned long parser_id)
+{
+	struct linux_pe_zboot_header *zboot_header;
+	unsigned int image_sz;
+	char *buf;
+	int ret = 0;
+
+	image_sz = context->kernel_sz;
+	bpf_printk("begin parse PE\n");
+	/* BPF verifier should know each variable initial state */
+	if (!context->kernel || (image_sz > MAX_RECORD_SIZE)) {
+		bpf_printk("Err: image size is greater than 0x%lx\n", MAX_RECORD_SIZE);
+		return 0;
+	}
+
+	/* In order to access bytes not aligned on 2 order, copy into ringbuf.
+	 * And allocate the memory all at once, later overwriting.
+	 *
+	 * R2 is ARG_CONST_ALLOC_SIZE_OR_ZERO, should be decided at compling time
+	 */
+	buf = (char *)bpf_ringbuf_reserve(&ringbuf_1, MAX_RECORD_SIZE, 0);
+	if (!buf) {
+	    	bpf_printk("Err: fail to reserve ringbuf to parse zboot header\n");
+		return 0;
+	}
+	bpf_probe_read((void *)buf, sizeof(struct linux_pe_zboot_header), context->kernel);
+	zboot_header = (struct linux_pe_zboot_header *)buf;
+	if (!!__builtin_memcmp(&zboot_header->image_type, "zimg",
+			sizeof(zboot_header->image_type))) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("Err: image is not zboot image\n");
+		return 0;
+	}
+
+	unsigned int payload_offset = zboot_header->payload_offset;
+	unsigned int payload_size = zboot_header->payload_size;
+	bpf_printk("zboot image payload offset=0x%x, size=0x%x\n", payload_offset, payload_size);
+	/* sane check */
+	if (payload_size > image_sz) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("Invalid zboot image payload offset and size\n");
+		return 0;
+	}
+	unsigned int max_payload = MAX_RECORD_SIZE - sizeof(struct cmd_hdr);
+	if (payload_size >= max_payload) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("Err: payload_size > MAX_RECORD_SIZE\n");
+		return 0;
+	}
+	void *dst = (void *)buf + sizeof(struct cmd_hdr);
+	/* Overwrite buf */
+	struct cmd_hdr *cmd = (struct cmd_hdr *)buf;
+	cmd->cmd = KEXEC_BPF_CMD_DECOMPRESS;
+	cmd->subcmd = KEXEC_BPF_SUBCMD_KERNEL;
+	/* 4 bytes original size is appended after vmlinuz.bin */
+	cmd->payload_len = payload_size - 4;
+	bpf_probe_read(dst, payload_size, context->kernel + payload_offset);
+	if (payload_size < 4) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		return 0;
+	}
+	bpf_printk("Calling bpf_kexec_decompress()\n");
+	struct bpf_parser_context *bpf = bpf_get_parser_context(parser_id);
+	if (!bpf) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("No parser in kernel\n");
+		return 0;
+	}
+	ret = bpf_buffer_parser(buf, sizeof(struct cmd_hdr) + payload_size - 4, bpf);
+	if (ret < 0) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_put_parser_context(bpf);
+		bpf_printk("Decompression fails\n");
+		return 0;
+	}
+	bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+	bpf_put_parser_context(bpf);
+
+	return 0;
+}
-- 
2.49.0


