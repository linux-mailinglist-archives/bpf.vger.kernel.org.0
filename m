Return-Path: <bpf+bounces-60293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0CAD48DC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0174D3A5AFB
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303B17B506;
	Wed, 11 Jun 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnDySvES"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD017A2EE
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608835; cv=none; b=QyUPU+L1KkoVkCVf7w7AwJZVW75C47D5LK1NfbEUD5OFrAwDjli5LBi2Lil8vDH15kwzTQZiCa1wvzBSOSs4Ic7cPtCXuQKQniY321dHMXCY7qABgMk56cVe3bL1ieVrGTrjdtvVHOh/wG2gN2rkA2x041jf3CSNCmH21PSfBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608835; c=relaxed/simple;
	bh=r34Yah3NaoeNFQ/gLKTt1hPcWmcn0rEPTnVMtNSZq5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgKkjeqDPeWvJlFWU5ikcyvew63cLRoXIb4o/vFF32Ba6C3DvssGcmC7GwJ4Fi+0ifqcGJd/dh7XFbDTGWr5h5Z9cTzbfG1Ov3qg92xay0O0/zDzd7oJzQfbZ66ziF2Ywq2dwYgbk07lVsPHPjrjfFOK976KIMkmlmuuj39OBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnDySvES; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749608832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lA7rl9vb+8smbYnWarfN1itTUyQW8fehxgrueFmJGWU=;
	b=RnDySvESwLI3xAhP+k8cRc59QyuiKo8SNwSVii+V5hzjXWj/ovJEWkCVfCNc8qSw4AsJ2o
	UqtKZnG6fmOEAfF6MJZp2s6PfztaHgIGkMa2qu0PN8Dixg2gY+eaxbs72VpP7EB4ZnDuCp
	Mzd/gO6J0bt0Jg0x0Hz8o5Hzp4Z6hGk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-uxrW85beNAib7Abk_5WXYw-1; Tue,
 10 Jun 2025 22:27:11 -0400
X-MC-Unique: uxrW85beNAib7Abk_5WXYw-1
X-Mimecast-MFC-AGG-ID: uxrW85beNAib7Abk_5WXYw_1749608830
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC8831956089;
	Wed, 11 Jun 2025 02:27:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3013C19560A3;
	Wed, 11 Jun 2025 02:27:04 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] tools/kexec: Introduce a bpf-prog to parse zboot image format
Date: Wed, 11 Jun 2025 10:26:45 +0800
Message-ID: <20250611022646.7970-2-piliu@redhat.com>
In-Reply-To: <20250611022646.7970-1-piliu@redhat.com>
References: <20250611022646.7970-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This BPF program aligns with the convention defined in the kernel file
kexec_pe_parser_bpf.lskel.h, where the interface between the BPF program
and the kernel is established, and is composed of:
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

    two progs:
            SEC("fentry.s/bpf_handle_pefile")
            SEC("fentry.s/bpf_post_handle_pefile")

This BPF program only uses ringbuf_1, so it minimizes the size of the
other three ringbufs to one byte.  The size of ringbuf_1 is deduced from
the size of the uncompressed file 'vmlinux.bin', which is usually less
than 64MB. With the help of a group of bpf kfuncs: bpf_decompress(),
bpf_copy_to_kernel(), bpf_mem_range_result_put(), this bpf-prog stores
the uncompressed kernel image inside the kernel space.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile           |  81 +++++++++++++++
 tools/kexec/pe.h               | 177 +++++++++++++++++++++++++++++++++
 tools/kexec/zboot_parser_bpf.c | 157 +++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_parser_bpf.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
new file mode 100644
index 0000000000000..49de2ab309a43
--- /dev/null
+++ b/tools/kexec/Makefile
@@ -0,0 +1,81 @@
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
+ZBOOT_TARGETS = bytecode.c zboot_parser_bpf.o bytecode.o
+
+
+# Targets
+zboot: $(HEADERS) $(ZBOOT_TARGETS)
+
+# Rule to generate vmlinux.h from vmlinux
+vmlinux.h: $(VMLINUX)
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
+		echo "#define RINGBUF1_SIZE $$RINGBUF_SIZE" > $@; \
+		echo "#define IMAGE_SIZE $$FILE_SIZE" >> $@; \
+	}
+
+
+# Rule to generate zboot_parser_bpf.o, depends on vmlinux.h
+zboot_parser_bpf.o: zboot_parser_bpf.c vmlinux.h bpf_helper_defs.h
+	@$(CC) $(BPF_PROG_CFLAGS) -c zboot_parser_bpf.c -o zboot_parser_bpf.o
+
+# Generate zboot_parser_bpf.lskel.h using bpftool
+# Then, extract the opts_data[] and opts_insn[] arrays and remove 'static'
+# keywords to avoid being optimized away.
+bytecode.c: zboot_parser_bpf.o
+	@$(BPFTOOL) gen skeleton -L zboot_parser_bpf.o > zboot_parser_bpf.lskel.h
+	@sed -n '/static const char opts_data\[\]/,/;/p' zboot_parser_bpf.lskel.h | sed 's/static const/const/' > $@
+	@sed -n '/static const char opts_insn\[\]/,/;/p' zboot_parser_bpf.lskel.h | sed 's/static const/const/' >> $@
+	@rm -f zboot_parser_bpf.lskel.h
+
+bytecode.o: bytecode.c
+	@$(CC) -c $< -o $@
+
+# Clean up generated files
+clean:
+	@rm -f $(HEADERS) $(ZBOOT_TARGETS)
+
+.PHONY: all clean
diff --git a/tools/kexec/pe.h b/tools/kexec/pe.h
new file mode 100644
index 0000000000000..9f1d086d6cf1a
--- /dev/null
+++ b/tools/kexec/pe.h
@@ -0,0 +1,177 @@
+/*
+ * Extract from linux kernel include/linux/pe.h
+ */
+
+#ifndef __PE_H__
+#define __PE_H__
+
+#define MZ_MAGIC	0x5a4d	/* "MZ" */
+#define PE_MAGIC		0x00004550	/* "PE\0\0" */
+
+struct mz_hdr {
+	uint16_t magic;		/* MZ_MAGIC */
+	uint16_t lbsize;	/* size of last used block */
+	uint16_t blocks;	/* pages in file, 0x3 */
+	uint16_t relocs;	/* relocations */
+	uint16_t hdrsize;	/* header size in "paragraphs" */
+	uint16_t min_extra_pps;	/* .bss */
+	uint16_t max_extra_pps;	/* runtime limit for the arena size */
+	uint16_t ss;		/* relative stack segment */
+	uint16_t sp;		/* initial %sp register */
+	uint16_t checksum;	/* word checksum */
+	uint16_t ip;		/* initial %ip register */
+	uint16_t cs;		/* initial %cs relative to load segment */
+	uint16_t reloc_table_offset;	/* offset of the first relocation */
+	uint16_t overlay_num;	/* overlay number.  set to 0. */
+	uint16_t reserved0[4];	/* reserved */
+	uint16_t oem_id;	/* oem identifier */
+	uint16_t oem_info;	/* oem specific */
+	uint16_t reserved1[10];	/* reserved */
+	uint32_t peaddr;	/* address of pe header */
+	char     message[];	/* message to print */
+};
+
+struct pe_hdr {
+	uint32_t magic;		/* PE magic */
+	uint16_t machine;	/* machine type */
+	uint16_t sections;	/* number of sections */
+	uint32_t timestamp;	/* time_t */
+	uint32_t symbol_table;	/* symbol table offset */
+	uint32_t symbols;	/* number of symbols */
+	uint16_t opt_hdr_size;	/* size of optional header */
+	uint16_t flags;		/* flags */
+};
+
+/* the fact that pe32 isn't padded where pe32+ is 64-bit means union won't
+ * work right.  vomit. */
+struct pe32_opt_hdr {
+	/* "standard" header */
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	uint32_t data_base;	/* relative data addr in ram */
+	/* "windows" header */
+	uint32_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint32_t stack_size_req;/* amt of stack requested */
+	uint32_t stack_size;	/* amt of stack required */
+	uint32_t heap_size_req;	/* amt of heap requested */
+	uint32_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct pe32plus_opt_hdr {
+	uint16_t magic;		/* file type */
+	uint8_t  ld_major;	/* linker major version */
+	uint8_t  ld_minor;	/* linker minor version */
+	uint32_t text_size;	/* size of text section(s) */
+	uint32_t data_size;	/* size of data section(s) */
+	uint32_t bss_size;	/* size of bss section(s) */
+	uint32_t entry_point;	/* file offset of entry point */
+	uint32_t code_base;	/* relative code addr in ram */
+	/* "windows" header */
+	uint64_t image_base;	/* preferred load address */
+	uint32_t section_align;	/* alignment in bytes */
+	uint32_t file_align;	/* file alignment in bytes */
+	uint16_t os_major;	/* major OS version */
+	uint16_t os_minor;	/* minor OS version */
+	uint16_t image_major;	/* major image version */
+	uint16_t image_minor;	/* minor image version */
+	uint16_t subsys_major;	/* major subsystem version */
+	uint16_t subsys_minor;	/* minor subsystem version */
+	uint32_t win32_version;	/* reserved, must be 0 */
+	uint32_t image_size;	/* image size */
+	uint32_t header_size;	/* header size rounded up to
+				   file_align */
+	uint32_t csum;		/* checksum */
+	uint16_t subsys;	/* subsystem */
+	uint16_t dll_flags;	/* more flags! */
+	uint64_t stack_size_req;/* amt of stack requested */
+	uint64_t stack_size;	/* amt of stack required */
+	uint64_t heap_size_req;	/* amt of heap requested */
+	uint64_t heap_size;	/* amt of heap required */
+	uint32_t loader_flags;	/* reserved, must be 0 */
+	uint32_t data_dirs;	/* number of data dir entries */
+};
+
+struct data_dirent {
+	uint32_t virtual_address;	/* relative to load address */
+	uint32_t size;
+};
+
+struct data_directory {
+	struct data_dirent exports;		/* .edata */
+	struct data_dirent imports;		/* .idata */
+	struct data_dirent resources;		/* .rsrc */
+	struct data_dirent exceptions;		/* .pdata */
+	struct data_dirent certs;		/* certs */
+	struct data_dirent base_relocations;	/* .reloc */
+	struct data_dirent debug;		/* .debug */
+	struct data_dirent arch;		/* reservered */
+	struct data_dirent global_ptr;		/* global pointer reg. Size=0 */
+	struct data_dirent tls;			/* .tls */
+	struct data_dirent load_config;		/* load configuration structure */
+	struct data_dirent bound_imports;	/* no idea */
+	struct data_dirent import_addrs;	/* import address table */
+	struct data_dirent delay_imports;	/* delay-load import table */
+	struct data_dirent clr_runtime_hdr;	/* .cor (object only) */
+	struct data_dirent reserved;
+};
+
+struct section_header {
+	char name[8];			/* name or "/12\0" string tbl offset */
+	uint32_t virtual_size;		/* size of loaded section in ram */
+	uint32_t virtual_address;	/* relative virtual address */
+	uint32_t raw_data_size;		/* size of the section */
+	uint32_t data_addr;		/* file pointer to first page of sec */
+	uint32_t relocs;		/* file pointer to relocation entries */
+	uint32_t line_numbers;		/* line numbers! */
+	uint16_t num_relocs;		/* number of relocations */
+	uint16_t num_lin_numbers;	/* srsly. */
+	uint32_t flags;
+};
+
+struct win_certificate {
+	uint32_t length;
+	uint16_t revision;
+	uint16_t cert_type;
+};
+
+/*
+ * Return -1 if not PE, else offset of the PE header
+ */
+static int get_pehdr_offset(const char *buf)
+{
+	int pe_hdr_offset;
+
+	pe_hdr_offset = *((int *)(buf + 0x3c));
+	buf += pe_hdr_offset;
+	if (!!memcmp(buf, "PE\0\0", 4)) {
+		printf("Not a PE file\n");
+		return -1;
+	}
+
+	return pe_hdr_offset;
+}
+
+#endif
diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
new file mode 100644
index 0000000000000..3f038b34c641a
--- /dev/null
+++ b/tools/kexec/zboot_parser_bpf.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+#include "vmlinux.h"
+#include <bpf_helpers.h>
+#include <bpf_tracing.h>
+#include "image_size.h"
+
+/* 128 MB is big enough to hold either kernel or initramfs */
+#define MAX_RECORD_SIZE	(IMAGE_SIZE + 4096)
+#define MIN_BUF_SIZE 1
+
+#define KEXEC_RES_KERNEL_NAME "kernel"
+#define KEXEC_RES_INITRD_NAME "initrd"
+#define KEXEC_RES_CMDLINE_NAME "cmdline"
+
+/* ringbuf is safe since the user space has no write access to them */
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, RINGBUF1_SIZE);
+} ringbuf_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MIN_BUF_SIZE);
+} ringbuf_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MIN_BUF_SIZE);
+} ringbuf_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MIN_BUF_SIZE);
+} ringbuf_4 SEC(".maps");
+
+char LICENSE[] SEC("license") = "GPL";
+
+/*
+ * This function ensures that the sections .rodata, .data .bss and .rodata.str1.1
+ * are created for a bpf prog.
+ */
+__attribute__((used)) static int dummy(void)
+{
+	static const char res_kernel[16] __attribute__((used, section(".rodata"))) = KEXEC_RES_KERNEL_NAME;
+	static char local_name[16] __attribute__((used, section(".data"))) = KEXEC_RES_CMDLINE_NAME;
+	static char res_cmdline[16] __attribute__((used, section(".bss")));
+
+	__builtin_memcpy(local_name, KEXEC_RES_INITRD_NAME, 16);
+	return __builtin_memcmp(local_name, res_kernel, 4);
+}
+
+extern int bpf_copy_to_kernel(const char *name, char *buf, int size) __weak __ksym;
+extern struct mem_range_result *bpf_decompress(char *image_gz_payload, int image_gz_sz) __weak __ksym;
+extern int bpf_mem_range_result_put(struct mem_range_result *result) __weak __ksym;
+
+
+
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
+SEC("fentry.s/bpf_handle_pefile")
+int BPF_PROG(parse_pe, struct kexec_context *context)
+{
+	struct linux_pe_zboot_header *zboot_header;
+	unsigned int image_sz;
+	char *buf;
+	char local_name[32];
+
+	bpf_printk("begin parse PE\n");
+	/* BPF verifier should know each variable initial state */
+	if (!context->image || (context->image_sz > MAX_RECORD_SIZE)) {
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
+	image_sz = context->image_sz;
+	bpf_probe_read((void *)buf, sizeof(struct linux_pe_zboot_header), context->image);
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
+	if (payload_size >= MAX_RECORD_SIZE ) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("Err: payload_size > MAX_RECORD_SIZE\n");
+		return 0;
+	}
+	/* Overwrite buf */
+	bpf_probe_read((void *)buf, payload_size, context->image + payload_offset);
+	bpf_printk("Calling bpf_kexec_decompress()\n");
+	struct mem_range_result *r = bpf_decompress(buf, payload_size - 4);
+	if (!r) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_printk("Err: fail to decompress\n");
+		return 0;
+	}
+
+	image_sz = r->data_sz;
+	if (image_sz > MAX_RECORD_SIZE) {
+		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+		bpf_mem_range_result_put(r);
+		bpf_printk("Err: decompressed size too big\n");
+		return 0;
+	}
+	
+	/* Since the decompressed size is bigger than original, no need to clean */
+	bpf_probe_read((void *)buf, image_sz, r->buf);
+	bpf_printk("Calling bpf_copy_to_kernel(), image_sz=0x%x\n", image_sz);
+	/* Verifier is unhappy to expose .rodata.str1.1 'map' to kernel */
+	__builtin_memcpy(local_name, KEXEC_RES_KERNEL_NAME, 32);
+	const char *res_name = local_name;
+	bpf_copy_to_kernel(res_name, buf, image_sz);
+	bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
+	bpf_mem_range_result_put(r);
+
+	return 0;
+}
+
+SEC("fentry.s/bpf_post_handle_pefile")
+int BPF_PROG(post_parse_pe, struct kexec_context *context)
+{
+	return 0;
+}
-- 
2.49.0


