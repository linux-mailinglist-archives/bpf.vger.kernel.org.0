Return-Path: <bpf+bounces-65947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183DB2B5F7
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA153ABF86
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFC1E1DF0;
	Tue, 19 Aug 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REiRW4oI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD41D514E
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566854; cv=none; b=lzuhua9pff+behhjX3gHgrQwizKNvzbtV6B4heAdoeK4xAiJjJ9u+IL+pemrBt3QpN1PrL/3o7rnclHRkxbA3NYqB1B7F4kDQYOoRMzjbHaIPEi5p+guP3c3r9ZoDE55tN+ACLVoCrmtnNdEBspkKw2Qg13e9IpGSnXobBx89a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566854; c=relaxed/simple;
	bh=SePdD2s+ILWRk3SetiOCrtuWcs+UDrCdCyaOtMW1GoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iznP8nFaqqrLhZN7Kv2O0UQyW9bITCvCBwKt3/WsjszcLomvp2LmeEZe5uBU7+VRmgtJSbvWtQhWHpp2k2mVI3LFkmKXGJrIzNNbczR2KbSRceV0b4pcAWpTw9XBxFE6tjAS3jr9wrJwAYvxFBfyYQKI4TUconvaPOoQcpYWWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REiRW4oI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vHacGbWnhvBwUA0iicqaKhgkqKTgi2HHeqZ7RGnODY=;
	b=REiRW4oIDJEilrZQ3D5K4Bw6V7CvCb5JP7qtxEmisxgWDOVx96jWSKWHlbIlS/wmDNUvB0
	XJD+w/9QiCXSRmV6nW+pSgxKqAH8SwtflvHabrXy+Ylk0gPAQrvoh4/yg5wRy5cAlkjkei
	jotbvyTokbUM+eE3XHF4H5GYFKXuNvs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-3ylf2dXANtygZu7_0b7ciA-1; Mon,
 18 Aug 2025 21:27:27 -0400
X-MC-Unique: 3ylf2dXANtygZu7_0b7ciA-1
X-Mimecast-MFC-AGG-ID: 3ylf2dXANtygZu7_0b7ciA_1755566844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA881180044F;
	Tue, 19 Aug 2025 01:27:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 973361800293;
	Tue, 19 Aug 2025 01:27:13 +0000 (UTC)
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
Subject: [PATCHv5 11/12] tools/kexec: Introduce a bpf-prog to parse zboot image format
Date: Tue, 19 Aug 2025 09:24:27 +0800
Message-ID: <20250819012428.6217-12-piliu@redhat.com>
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
 tools/kexec/Makefile           |  82 +++++++++++++++++
 tools/kexec/zboot_parser_bpf.c | 158 +++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 tools/kexec/Makefile
 create mode 100644 tools/kexec/zboot_parser_bpf.c

diff --git a/tools/kexec/Makefile b/tools/kexec/Makefile
new file mode 100644
index 0000000000000..c9e7ce9ff4c19
--- /dev/null
+++ b/tools/kexec/Makefile
@@ -0,0 +1,82 @@
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
diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
new file mode 100644
index 0000000000000..e60621780a1a9
--- /dev/null
+++ b/tools/kexec/zboot_parser_bpf.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+#include "vmlinux.h"
+#include <bpf_helpers.h>
+#include <bpf_tracing.h>
+#include "image_size.h"
+
+/* uncompressed vmlinux.bin plus 4KB */
+#define MAX_RECORD_SIZE	(IMAGE_SIZE + 4096)
+/* ringbuf 2,3,4 are useless */
+#define MIN_BUF_SIZE 1
+
+#define KEXEC_RES_KERNEL_NAME "kexec:kernel"
+#define KEXEC_RES_INITRD_NAME "kexec:initrd"
+#define KEXEC_RES_CMDLINE_NAME "kexec:cmdline"
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


