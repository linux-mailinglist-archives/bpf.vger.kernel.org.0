Return-Path: <bpf+bounces-65948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70516B2B5F8
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DED526B77
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C961E47BA;
	Tue, 19 Aug 2025 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZRtMzov"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E001DF246
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566866; cv=none; b=YP0M4xd0R0RBRfcy0rTn81KbVGFZUd4vU/adOzhrJJ1rry/xhHWHPIqQ6D8+RnXA2910GjOCHbQX5eV7d3GbNt1XgXTwpGhwsdQtpxu4KXw5nLBzW+XIZe8qYzOeW8OWNpgUStEMQvP6cQ0Wx1K/yxuBqTvHORvzZCcRx+yh0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566866; c=relaxed/simple;
	bh=ustRfLcqBhmvkLwzDJkhFm/kJm4pT6WZ75Dbpug9V4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeizotEeO8hD9qenHEbSKZYsIhU+vI/GWDXaBYj6DOROKv13f5VkkJ6c+PbxFy4PqerNOn++4Ho3FSDZqQ71KPhb5vEacjCbvDEEishpCW0JJrn+3Sg4ytmHo9QTsY9l++vAgY08jwBslAB7lUtZ+vFlc/QvabEAyx251hBCtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZRtMzov; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DV5JIkmOQUI57qY+6aBnAZ4uczd6qiBNBofZkF1kf00=;
	b=YZRtMzovYQBK5H5Sm5fQiyoOeydEkaowg4/xNa9CoTgygMVlz9x0bdJ1n3DmF8SzRqQwIq
	SL7T4WWLzagqcZZENdLi8eSSJer89SWTEy/rq+7BrSGARxFNUyijJYbbwC9UzwPeWFzHKh
	s/dFvmwYk9nAkLH4rkD+SebLUtLIjM8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-cUsdhO-3OAuwmJ3UiSmGdg-1; Mon,
 18 Aug 2025 21:27:39 -0400
X-MC-Unique: cUsdhO-3OAuwmJ3UiSmGdg-1
X-Mimecast-MFC-AGG-ID: cUsdhO-3OAuwmJ3UiSmGdg_1755566857
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2557D1800280;
	Tue, 19 Aug 2025 01:27:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7250F180028A;
	Tue, 19 Aug 2025 01:27:25 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
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
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 12/12] tools/kexec: Add a zboot image building tool
Date: Tue, 19 Aug 2025 09:24:28 +0800
Message-ID: <20250819012428.6217-13-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The objcopy binary can append an section into PE file, but it disregards
the DOS header. While the zboot format carries important information:
payload offset and size in the DOS header.

In order to keep track and update such information, here introducing a
dedicated binary tool to build zboot image. The payload offset is
determined by the fact that its offset inside the .data section is
unchanged. Hence the offset of .data section in the new PE file plus the
payload offset within section renders the offset within the new PE file.

The objcopy binary can append a section to a PE file, but it disregards
the DOS header. However, the zboot format carries important information
in the DOS header: payload offset and size.

To track this information and append a new PE section, here a dedicated
binary tool is introduced to build zboot images. The payload's relative
offset within the .data section remains unchanged.  Therefore, the .data
section offset in the new PE file, plus the payload offset within that
section, yields the payload offset within the new PE file.

Finally, the new PE file 'zboot.efi' can be got by the command:
  make -C tools/kexec zboot

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 tools/kexec/Makefile              |  10 +-
 tools/kexec/pe.h                  | 177 +++++++++++++++++++
 tools/kexec/zboot_image_builder.c | 280 ++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 tools/kexec/pe.h
 create mode 100644 tools/kexec/zboot_image_builder.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
index c9e7ce9ff4c19..5cc4b6088b3f8 100644
--- a/tools/kexec/Makefile
+++ b/tools/kexec/Makefile
@@ -27,7 +27,7 @@ BPFTOOL = bpftool
 
 # List of generated target files
 HEADERS = vmlinux.h bpf_helper_defs.h image_size.h
-ZBOOT_TARGETS = bytecode.c zboot_parser_bpf.o bytecode.o
+ZBOOT_TARGETS = bytecode.c zboot_parser_bpf.o bytecode.o zboot_image_builder zboot.efi
 
 
 # Targets
@@ -75,6 +75,14 @@ bytecode.c: zboot_parser_bpf.o
 bytecode.o: bytecode.c
 	@$(CC) -c $< -o $@
 
+# Rule to build zboot_image_builder executable
+zboot_image_builder: zboot_image_builder.c
+	@$(CC) $(CFLAGS) $< -o $@
+
+zboot.efi: zboot_image_builder bytecode.o
+	@chmod +x zboot_image_builder
+	@./zboot_image_builder $(EFI_IMAGE) bytecode.o $@
+
 # Clean up generated files
 clean:
 	@rm -f $(HEADERS) $(ZBOOT_TARGETS)
diff --git a/tools/kexec/pe.h b/tools/kexec/pe.h
new file mode 100644
index 0000000000000..c2273d3fc3bb3
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
+#define IMAGE_DOS_SIGNATURE	0x5a4d	/* "MZ" */
+#define IMAGE_NT_SIGNATURE	0x00004550	/* "PE\0\0" */
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
diff --git a/tools/kexec/zboot_image_builder.c b/tools/kexec/zboot_image_builder.c
new file mode 100644
index 0000000000000..2508cafd7c200
--- /dev/null
+++ b/tools/kexec/zboot_image_builder.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Red Hat, Inc.
+ * The zboot format carries the compressed kernel image offset and size
+ * information in the DOS header. The program appends a bpf section to PE file,
+ * meanwhile maintains the offset and size information, which is lost when using
+ * objcopy to handle zboot image.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "pe.h"
+
+#ifdef DEBUG_DETAIL
+	#define dprintf(...) printf(__VA_ARGS__)
+#else
+	#define dprintf(...) ((void)0)
+#endif
+
+typedef struct {
+	union {
+		struct {
+			unsigned int mz_magic;
+			char image_type[4];
+			/* offset to the whole file start */
+			unsigned int payload_offset;
+			unsigned int payload_size;
+			unsigned int reserved[2];
+			char comp_type[4];
+		};
+		char raw_bytes[56];
+	};
+	unsigned int linux_pe_magic;
+	/* offset at: 0x3c or 60 */
+	unsigned int pe_header_offset;
+} __attribute__((packed)) pe_zboot_header;
+
+typedef unsigned long	uintptr_t;
+#define ALIGN_UP(p, size) (__typeof__(p))(((uintptr_t)(p) + ((size) - 1)) & ~((size) - 1))
+
+int main(int argc, char **argv)
+{
+	uint32_t payload_new_offset, payload_sect_off;
+	uint32_t payload_size;
+	uint32_t payload_sect_idx;
+	pe_zboot_header *zheader;
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	int base_fd, bpf_fd, out_fd;
+	char *base_start_addr, *base_cur;
+	char *out_start_addr, *out_cur;
+	uint32_t out_sz, max_va_end = 0;
+	struct stat sb;
+	int i = 0, ret = 0;
+
+	if (argc != 4) {
+	    fprintf(stderr, "Usage: %s <original_pe> <binary_file> <new_pe>\n", argv[0]);
+	    return -1;
+	}
+
+	const char *original_pe = argv[1];
+	const char *binary_file = argv[2];
+	const char *new_pe = argv[3];
+	FILE *bin_fp = fopen(binary_file, "rb");
+	if (!bin_fp) {
+	    perror("Failed to open binary file");
+	    return -1;
+	}
+	fseek(bin_fp, 0, SEEK_END);
+	size_t bin_size = ftell(bin_fp);
+	fseek(bin_fp, 0, SEEK_SET);
+	base_fd = open(original_pe, O_RDWR);
+	out_fd = open(new_pe, O_RDWR | O_CREAT, 0644);
+	if (base_fd == -1 || out_fd == -1) {
+	    perror("Error opening file");
+	    exit(1);
+	}
+
+	if (fstat(base_fd, &sb) == -1) {
+	    perror("Error getting file size");
+	    exit(1);
+	}
+	base_start_addr = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, base_fd, 0);
+	if (base_start_addr == MAP_FAILED) {
+	    perror("Error mmapping the file");
+	    exit(1);
+	}
+	/* 64KB for section table extending */
+	out_sz = sb.st_size + bin_size + (1 << 16);
+	out_start_addr = mmap(NULL, out_sz, PROT_WRITE, MAP_SHARED, out_fd, 0);
+	if (ftruncate(out_fd, out_sz) == -1) {
+		perror("Failed to resize output file");
+		ret = -1;
+		goto err;
+	}
+	if (out_start_addr == MAP_FAILED) {
+	    perror("Error mmapping the file");
+	    exit(1);
+	}
+
+	zheader = (pe_zboot_header *)base_start_addr;
+	if (zheader->mz_magic != 0x5A4D) {  // 'MZ'
+	    fprintf(stderr, "Invalid DOS signature\n");
+	    return -1;
+	}
+	uint32_t pe_hdr_offset = get_pehdr_offset((const char *)base_start_addr);
+	base_cur = base_start_addr + pe_hdr_offset;
+	pe_hdr = (struct pe_hdr *)base_cur;
+	if (pe_hdr->magic!= 0x00004550) {  // 'PE\0\0'
+	    fprintf(stderr, "Invalid PE signature\n");
+	    return -1;
+	}
+	base_cur += sizeof(struct pe_hdr);
+	opt_hdr = (struct pe32plus_opt_hdr *)base_cur;
+	uint32_t file_align = opt_hdr->file_align;
+	uint32_t section_alignment = opt_hdr->section_align;
+
+	uint16_t num_sections = pe_hdr->sections;
+	struct section_header *base_sections, *sect;
+	uint32_t section_table_offset = pe_hdr_offset + sizeof(struct pe_hdr) + pe_hdr->opt_hdr_size;
+	base_sections = (struct section_header *)(base_start_addr + section_table_offset);
+
+	/* Decide the section idx and the payload offset within the section */
+	for (i = 0; i < num_sections; i++) {
+	    sect = &base_sections[i];
+	    if (zheader->payload_offset >= sect->data_addr &&
+		zheader->payload_offset < (sect->data_addr + sect->raw_data_size)) {
+		    payload_sect_idx = i;
+		    payload_sect_off = zheader->payload_offset - sect->data_addr;
+	    }
+	}
+
+	/* Calculate the end of the last section in virtual memory */
+	for (i = 0; i < num_sections; i++) {
+	    uint32_t section_end = base_sections[i].virtual_address + base_sections[i].virtual_size;
+	    if (section_end > max_va_end) {
+	        max_va_end = section_end;
+	    }
+	}
+
+	/* Calculate virtual address for the new .bpf section */
+	uint32_t bpf_virtual_address = ALIGN_UP(max_va_end, section_alignment);
+
+	pe_zboot_header *new_zhdr = malloc(sizeof(pe_zboot_header));
+	memcpy(new_zhdr, zheader, sizeof(pe_zboot_header));
+	struct pe_hdr *new_hdr = malloc(sizeof(struct pe_hdr));
+	memcpy(new_hdr, pe_hdr, sizeof(struct pe_hdr));
+	new_hdr->sections += 1;
+	struct pe32plus_opt_hdr *new_opt_hdr = malloc(pe_hdr->opt_hdr_size);
+	memcpy(new_opt_hdr, opt_hdr, pe_hdr->opt_hdr_size);
+	/* Create new section headers array (original + new section) */
+	struct section_header *new_sections = calloc(1, new_hdr->sections * sizeof(struct section_header));
+	if (!new_sections) {
+	    perror("Failed to allocate memory for new section headers");
+	    return -1;
+	}
+	memcpy(new_sections, base_sections, pe_hdr->sections * sizeof(struct section_header));
+
+	/* Configure the new .bpf section */
+	struct section_header *bpf_section = &new_sections[new_hdr->sections - 1];
+	memset(bpf_section, 0, sizeof(struct section_header));
+	strncpy((char *)bpf_section->name, ".bpf", 8);
+	bpf_section->virtual_size = bin_size;
+	bpf_section->virtual_address = bpf_virtual_address;
+	bpf_section->raw_data_size = bin_size;
+	bpf_section->flags = 0x40000000; //Readable
+
+	/* Update headers */
+	uint32_t new_size_of_image = bpf_section->virtual_address + bpf_section->virtual_size;
+	new_size_of_image = ALIGN_UP(new_size_of_image, section_alignment);
+	new_opt_hdr->image_size = new_size_of_image;
+
+	size_t section_table_size = new_hdr->sections * (sizeof(struct section_header));
+	size_t headers_size = section_table_offset + section_table_size;
+	size_t aligned_headers_size = ALIGN_UP(headers_size, file_align);
+	new_opt_hdr->header_size = aligned_headers_size;
+
+
+	uint32_t current_offset = aligned_headers_size;
+	/*
+	 * If the original PE data_addr is covered by enlarged header_size
+	 * re-assign new data_addr for all sections
+	 */
+	if (base_sections[0].data_addr < aligned_headers_size) {
+		for (i = 0; i < new_hdr->sections; i++) {
+		    new_sections[i].data_addr = current_offset;
+		    current_offset += ALIGN_UP(new_sections[i].raw_data_size, file_align);
+		}
+	/* Keep unchanged, just allocating file pointer for bpf section */
+	} else {
+		uint32_t t;
+		i = new_hdr->sections - 2;
+		t = new_sections[i].data_addr + new_sections[i].raw_data_size;
+		i++;
+		new_sections[i].data_addr = ALIGN_UP(t, file_align);
+	}
+
+	payload_new_offset = new_sections[payload_sect_idx].data_addr + payload_sect_off;
+	/* Update */
+	new_zhdr->payload_offset = payload_new_offset;
+	new_zhdr->payload_size = zheader->payload_size;
+	dprintf("zboot payload_offset updated from 0x%x to 0x%x, size:0x%x\n",
+		zheader->payload_offset, payload_new_offset, new_zhdr->payload_size);
+
+
+	/* compose the new PE file */
+
+	/* Write Dos header */
+	memcpy(out_start_addr, new_zhdr, sizeof(pe_zboot_header));
+	out_cur = out_start_addr + pe_hdr_offset;
+
+	/* Write PE header */
+	memcpy(out_cur, new_hdr, sizeof(struct pe_hdr));
+	out_cur += sizeof(struct pe_hdr);
+
+	/* Write PE optional header */
+	memcpy(out_cur, new_opt_hdr, new_hdr->opt_hdr_size);
+	out_cur += new_hdr->opt_hdr_size;
+
+	/* Write all section headers */
+	memcpy(out_cur, new_sections, new_hdr->sections * sizeof(struct section_header));
+
+	/* Skip padding and copy the section data */
+	for (i = 0; i < pe_hdr->sections; i++) {
+		base_cur = base_start_addr + base_sections[i].data_addr;
+		out_cur = out_start_addr + new_sections[i].data_addr;
+		memcpy(out_cur, base_cur, base_sections[i].raw_data_size);
+	}
+	msync(out_start_addr, new_sections[i].data_addr + new_sections[i].raw_data_size, MS_ASYNC);
+	/* For the bpf section */
+	out_cur = out_start_addr + new_sections[i].data_addr;
+
+	/* Write .bpf section data */
+	char *bin_data = calloc(1, bin_size);
+	if (!bin_data) {
+		perror("Failed to allocate memory for binary data");
+		free(base_sections);
+		free(new_sections);
+		ret = -1;
+		goto err;
+	}
+	if (fread(bin_data, bin_size, 1, bin_fp) != 1) {
+		perror("Failed to read binary data");
+		free(bin_data);
+		free(base_sections);
+		free(new_sections);
+		ret = -1;
+		goto err;
+	}
+
+	if (out_cur + bin_size > out_start_addr + out_sz) {
+	    perror("out of out_fd mmap\n");
+	    ret = -1;
+	    goto err;
+	}
+	memcpy(out_cur, bin_data, bin_size);
+	/* calculate the real size */
+	out_sz = out_cur + bin_size - out_start_addr;
+	msync(out_start_addr, out_sz, MS_ASYNC);
+	/* truncate to the real size */
+	if (ftruncate(out_fd, out_sz) == -1) {
+		perror("Failed to resize output file");
+		ret = -1;
+		goto err;
+	}
+	printf("Create a new PE file with bpf section: %s\n", new_pe);
+err:
+	munmap(out_start_addr, out_sz);
+	munmap(base_start_addr, sb.st_size);
+	close(base_fd);
+	close(out_fd);
+	close(bpf_fd);
+
+	return ret;
+}
-- 
2.49.0


