Return-Path: <bpf+bounces-56094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9400FA91206
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8DF7A6923
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 03:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C971C84AD;
	Thu, 17 Apr 2025 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU7OXL7p"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28168488
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860848; cv=none; b=IlWBOQQjCIbOHTqC5pdnoXenOUevSuZtoT6Bmzhn0rrGsBrZRHDQgqz41TVqFnS3nHSHxA1S9M1Mai4aKzm+sv4P9aeHJu2S2ik6K54ieYf4KxHCKXzhceztOSgGtEq3nFNicPoVyfLDeAgWykl9gMW0xvMKrHj/3O6wnBdXKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860848; c=relaxed/simple;
	bh=DFdSLMpCh4gvnU/aK1mJEqs689Bgogs45nFznqs8es8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZeYUXNez5/+GduhpoS5P/X5jMueGYfU/OeFDjkfkPSMU+UEBR/yeXjWI/XZXVKAeTzRBQ55ifuZi4+B3+Bif4siCObgAkW10eb+wNKNpUFSkiVEcimMe2Au4deIj36oRLO2bZzjR7D+v8+qVA5WzWLa7n+7909fwTpxPZC06ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU7OXL7p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744860843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtfbLEneJJP7vqMdHn3ViGbs5B0WWJKeuJWlOAnWYjA=;
	b=eU7OXL7pZD8YU31GvcEb6EfoXdCV9Ge6eP1MZ6Gz9K1dJGQHivt4ZDmdCn0/3WTttnl3Rl
	PcBMtTiZx2lLFWY/tC+vJjKEJdkpwTe8d15pStSBAz6WUjh4oWk+3S27NTfb8Qv8I1HxBt
	5zKNLFhOUiyJ8DrKJJH34NSWMU/wJys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-4H_AWsToNHyjkMtRn95_lA-1; Wed,
 16 Apr 2025 23:34:01 -0400
X-MC-Unique: 4H_AWsToNHyjkMtRn95_lA-1
X-Mimecast-MFC-AGG-ID: 4H_AWsToNHyjkMtRn95_lA_1744860839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 484CC18001CA;
	Thu, 17 Apr 2025 03:33:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E3F830001A1;
	Thu, 17 Apr 2025 03:33:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
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
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [RFCv1 5/7] kexec: Add bpf light skeleton to load zboot image
Date: Thu, 17 Apr 2025 11:31:29 +0800
Message-ID: <20250417033146.14240-6-piliu@redhat.com>
In-Reply-To: <20250417033146.14240-1-piliu@redhat.com>
References: <20250417033146.14240-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This light skeleton is generated by 'bpftool gen skeleton -L '.

The bpf-progrom C code is [1].
The interface between bpf-prog and the kernel are constituted by:
	four ringbuf
	an array
	SEC("fentry/bpf_handle_pefile")
	SEC("fentry/bpf_post_handle_pefile")

They are fixed and provided for all kinds of bpf-prog which interacts
with the kexec kernel component.

[1]:
// SPDX-License-Identifier: GPL-2.0

static long (* const bpf_kexec_decompress)(char *image_gz_payload, int image_gz_sz, unsigned int decompressed_sz, struct bpf_map *map, unsigned int *key) = (void *)212;
static long (* const bpf_kexec_carrier)(char *name, struct bpf_map *map, void *buf) = (void *)213;

/* 1GB =  1^28 * sizeof(__uint) */
/* 512MB is big enough to hold either kernel or initramfs */

/* ringbuf is safe since the user space has no write access to them */
struct {
	__uint(type, BPF_MAP_TYPE_RINGBUF);
	__uint(max_entries, MAX_BUF_SIZE);
} ringbuf_1 SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_RINGBUF);
	__uint(max_entries, MAX_BUF_SIZE);
} ringbuf_2 SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_RINGBUF);
	__uint(max_entries, MAX_BUF_SIZE);
} ringbuf_3 SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_RINGBUF);
	__uint(max_entries, MAX_BUF_SIZE);
} ringbuf_4 SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__uint(max_entries, 10);
	__type(key, unsigned int);
	__type(value, struct mem_range_result);
} mem_range_map SEC(".maps");

char LICENSE[] SEC("license") = "GPL";

/* see drivers/firmware/efi/libstub/zboot-header.S */
struct linux_pe_zboot_header {
	unsigned int mz_magic;
	char image_type[4];
	unsigned int payload_offset;
	unsigned int payload_size;
	unsigned int reserved[2];
	char comp_type[4];
	unsigned int linux_pe_magic;
	unsigned int pe_header_offset;
} __attribute__((packed));

SEC("fentry/bpf_handle_pefile")
int BPF_PROG(parse_pe, char *image_buf, unsigned int image_sz, char *unused_initrd,
		unsigned int unused_initrd_sz, char *unused_cmd)
{
	struct linux_pe_zboot_header *zboot_header;
	char *image_gz_payload;
	int image_gz_sz;
	unsigned int decompressed_sz;
	char *decompressed_buf;
	char *buf;
	unsigned int key = 0;

	bpf_printk("begin parse PE\n");
	if (!image_buf || (image_sz > MAX_RECORD_SIZE)) {
		bpf_printk("Err: image size is greater than 0x%lx\n", MAX_RECORD_SIZE);
		return 0;
	}

	/* In order to access bytes not aligned on 2 order, copy into ringbuf */
	buf = (char *)bpf_ringbuf_reserve(&ringbuf_1, sizeof(struct linux_pe_zboot_header), 0);
	if (!buf) {
	    	bpf_printk("Err: fail to reserve ringbuf to parse zboot header\n");
		return 0;
	}
	/* Ensure the second parameter for bpf_probe_read() is Positive */
	image_sz = image_sz & (MAX_RECORD_SIZE - 1);
	bpf_probe_read((void *)buf, sizeof(struct linux_pe_zboot_header), image_buf);
	zboot_header = (struct linux_pe_zboot_header *)buf;
	if (!!__builtin_memcmp(&zboot_header->image_type, "zimg",
			sizeof(zboot_header->image_type))) {
	    	bpf_printk("Err: image is not zboot image\n");
		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
		return 0;
	}

	unsigned int payload_offset = zboot_header->payload_offset;
	unsigned int payload_size = zboot_header->payload_size;
	bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
	image_gz_sz = payload_size - 4;
	if (image_gz_sz <= 0 || image_gz_sz + 4 > image_sz) {
		bpf_printk("Invalid offset for decompressed size\n");
		return 0;
	}
	/* Ensure the boundary to make verifier satisfied */
	unsigned int d_pos = (payload_offset + image_gz_sz) & (MAX_RECORD_SIZE - 1);
	/* appended le32 is the size */
	bpf_probe_read((void *)&decompressed_sz, sizeof(int), image_buf + d_pos);
	decompressed_sz = le32toh(decompressed_sz);
	bpf_printk("payload_offset:0x%lx, payload_size:0x%lx, decompressed size:0x%lx\n",
			payload_offset, payload_size, decompressed_sz);
	if (decompressed_sz == 0) {
	    	bpf_printk("decompressed size %d is wrong\n", decompressed_sz);
		return 0;
	}

	/* Strict check on pointer */
	if (payload_offset >= MAX_RECORD_SIZE ) {
		bpf_printk("Err: payload_offset > 0x%lx\n", MAX_RECORD_SIZE);
		return 0;
	}
	buf = (char *)bpf_ringbuf_reserve(&ringbuf_1, MAX_RECORD_SIZE, 0);
	if (!buf) {
		bpf_printk("Err: fail to reserve from ringbuf_1 for reading payload\n");
		return 0;
	}
	bpf_probe_read((void *)buf, payload_size, image_buf + payload_offset);
	struct bpf_map *map_ptr = (struct bpf_map *)&mem_range_map;
	bpf_printk("Calling bpf_kexec_decompress()\n");
	bpf_kexec_decompress(buf, payload_size - 4, decompressed_sz, map_ptr, &key);
	bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);

	struct mem_range_result *result;
	result = bpf_map_lookup_elem(&mem_range_map, &key);
	if (!!result) {
		bpf_printk("Calling bpf_kexec_carrier()\n");
		bpf_kexec_carrier(KEXEC_RES_KERNEL_NAME, &mem_range_map, result);
	}
	return 0;
}

SEC("fentry/bpf_post_handle_pefile")
int BPF_PROG(post_parse_pe, char *image_buf, int buf_sz)
{
	return 0;
}

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/Makefile                |   1 +
 kernel/kexec_pe_image.c        |  12 +-
 kernel/kexec_pe_parser_lskel.h | 620 +++++++++++++++++++++++++++++++++
 3 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 kernel/kexec_pe_parser_lskel.h

diff --git a/kernel/Makefile b/kernel/Makefile
index 85abe8fa27eb9..34b3f20320a7c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_kexec_pe_image.o += -I$(srctree)/tools/lib
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCSAN_SANITIZE_stackleak.o := n
diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index 67b73fe7f59be..c4949d0daecda 100644
--- a/kernel/kexec_pe_image.c
+++ b/kernel/kexec_pe_image.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/elf.h>
 #include <linux/pe.h>
 #include <linux/string.h>
 #include <linux/bpf.h>
@@ -22,7 +23,7 @@
 #include <asm/cpufeature.h>
 #include <asm/image.h>
 #include <asm/memory.h>
-
+#include "kexec_pe_parser_lskel.h"
 
 static LIST_HEAD(phase_head);
 
@@ -288,15 +289,24 @@ static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
 	return true;
 }
 
+static struct kexec_pe_parser_bpf *pe_parser;
+
 /* Load a ELF */
 static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
 {
+	pe_parser = kexec_pe_parser_bpf__open_and_load();
+	if (!pe_parser)
+		return -1;
+	kexec_pe_parser_bpf__attach(pe_parser);
+
 	return 0;
 }
 
 //todo, release memory resource used by bpf_kexec_decompress()
 static void disarm_bpf_prog(void)
 {
+	kexec_pe_parser_bpf__destroy(pe_parser);
+	pe_parser = NULL;
 }
 
 /*
diff --git a/kernel/kexec_pe_parser_lskel.h b/kernel/kexec_pe_parser_lskel.h
new file mode 100644
index 0000000000000..d8c6c21c64cc3
--- /dev/null
+++ b/kernel/kexec_pe_parser_lskel.h
@@ -0,0 +1,620 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* THIS FILE IS AUTOGENERATED BY BPFTOOL! */
+#ifndef __KEXEC_PE_PARSER_BPF_SKEL_H__
+#define __KEXEC_PE_PARSER_BPF_SKEL_H__
+
+#include <bpf/skel_internal.h>
+
+struct kexec_pe_parser_bpf {
+	struct bpf_loader_ctx ctx;
+	struct {
+		struct bpf_map_desc ringbuf_1;
+		struct bpf_map_desc ringbuf_2;
+		struct bpf_map_desc ringbuf_3;
+		struct bpf_map_desc ringbuf_4;
+		struct bpf_map_desc mem_range_map;
+		struct bpf_map_desc rodata;
+		struct bpf_map_desc rodata_str1_1;
+	} maps;
+	struct {
+		struct bpf_prog_desc parse_pe;
+		struct bpf_prog_desc post_parse_pe;
+	} progs;
+	struct {
+		int parse_pe_fd;
+		int post_parse_pe_fd;
+	} links;
+};
+
+static inline int
+kexec_pe_parser_bpf__parse_pe__attach(struct kexec_pe_parser_bpf *skel)
+{
+	int prog_fd = skel->progs.parse_pe.prog_fd;
+	int fd = skel_raw_tracepoint_open(NULL, prog_fd);
+
+	if (fd > 0)
+		skel->links.parse_pe_fd = fd;
+	return fd;
+}
+
+static inline int
+kexec_pe_parser_bpf__post_parse_pe__attach(struct kexec_pe_parser_bpf *skel)
+{
+	int prog_fd = skel->progs.post_parse_pe.prog_fd;
+	int fd = skel_raw_tracepoint_open(NULL, prog_fd);
+
+	if (fd > 0)
+		skel->links.post_parse_pe_fd = fd;
+	return fd;
+}
+
+static inline int
+kexec_pe_parser_bpf__attach(struct kexec_pe_parser_bpf *skel)
+{
+	int ret = 0;
+
+	ret = ret < 0 ? ret : kexec_pe_parser_bpf__parse_pe__attach(skel);
+	ret = ret < 0 ? ret : kexec_pe_parser_bpf__post_parse_pe__attach(skel);
+	return ret < 0 ? ret : 0;
+}
+
+static inline void
+kexec_pe_parser_bpf__detach(struct kexec_pe_parser_bpf *skel)
+{
+	skel_closenz(skel->links.parse_pe_fd);
+	skel_closenz(skel->links.post_parse_pe_fd);
+}
+static void
+kexec_pe_parser_bpf__destroy(struct kexec_pe_parser_bpf *skel)
+{
+	if (!skel)
+		return;
+	kexec_pe_parser_bpf__detach(skel);
+	skel_closenz(skel->progs.parse_pe.prog_fd);
+	skel_closenz(skel->progs.post_parse_pe.prog_fd);
+	skel_closenz(skel->maps.ringbuf_1.map_fd);
+	skel_closenz(skel->maps.ringbuf_2.map_fd);
+	skel_closenz(skel->maps.ringbuf_3.map_fd);
+	skel_closenz(skel->maps.ringbuf_4.map_fd);
+	skel_closenz(skel->maps.mem_range_map.map_fd);
+	skel_closenz(skel->maps.rodata.map_fd);
+	skel_closenz(skel->maps.rodata_str1_1.map_fd);
+	skel_free(skel);
+}
+static inline struct kexec_pe_parser_bpf *
+kexec_pe_parser_bpf__open(void)
+{
+	struct kexec_pe_parser_bpf *skel;
+
+	skel = skel_alloc(sizeof(*skel));
+	if (!skel)
+		goto cleanup;
+	skel->ctx.sz = (void *)&skel->links - (void *)skel;
+	return skel;
+cleanup:
+	kexec_pe_parser_bpf__destroy(skel);
+	return NULL;
+}
+
+static inline int
+kexec_pe_parser_bpf__load(struct kexec_pe_parser_bpf *skel)
+{
+	struct bpf_load_and_run_opts opts = {};
+	int err;
+	static const char opts_data[] __attribute__((__aligned__(8))) = "\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9f\xeb\x01\0\
+\x18\0\0\0\0\0\0\0\x9c\x05\0\0\x9c\x05\0\0\x49\x0a\0\0\0\0\0\0\0\0\0\x02\x03\0\
+\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
+\0\0\x04\0\0\0\x1b\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
+\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\0\0\x10\0\0\0\0\
+\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\
+\0\x2a\0\0\0\0\0\0\x0e\x07\0\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\
+\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x34\0\0\0\0\0\0\x0e\x09\0\
+\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\
+\0\0\x05\0\0\0\x40\0\0\0\x3e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\x02\0\
+\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x48\
+\0\0\0\0\0\0\x0e\x0d\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x10\0\0\0\0\0\0\0\0\0\0\
+\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\x02\x12\0\0\0\0\0\0\0\
+\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x0a\0\0\0\0\0\0\0\0\0\0\x02\x14\0\0\0\
+\x52\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\x02\x16\0\0\0\x5f\0\0\0\
+\x03\0\0\x04\x10\0\0\0\x70\0\0\0\x17\0\0\0\0\0\0\0\x74\0\0\0\x18\0\0\0\x40\0\0\
+\0\x79\0\0\0\x02\0\0\0\x60\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\x80\0\0\0\0\0\0\x08\
+\x19\0\0\0\x89\0\0\0\0\0\0\x08\x1a\0\0\0\x8d\0\0\0\0\0\0\x08\x14\0\0\0\0\0\0\0\
+\x04\0\0\x04\x20\0\0\0\x19\0\0\0\x0f\0\0\0\0\0\0\0\x1e\0\0\0\x11\0\0\0\x40\0\0\
+\0\x93\0\0\0\x13\0\0\0\x80\0\0\0\x97\0\0\0\x15\0\0\0\xc0\0\0\0\x9d\0\0\0\0\0\0\
+\x0e\x1b\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x1e\0\0\0\xab\0\0\0\0\0\0\x01\x08\0\
+\0\0\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\xbe\0\0\0\x1d\0\0\0\xc2\0\0\0\x01\
+\0\0\x0c\x1f\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\xbe\0\0\0\x1d\0\0\0\xc5\x08\0\
+\0\x01\0\0\x0c\x21\0\0\0\x2a\x09\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\0\0\0\0\
+\0\0\x03\0\0\0\0\x23\0\0\0\x04\0\0\0\x04\0\0\0\x2f\x09\0\0\0\0\0\x0e\x24\0\0\0\
+\x01\0\0\0\0\0\0\0\0\0\0\x0a\x23\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\
+\0\0\0\x10\0\0\0\x37\x09\0\0\0\0\0\x0e\x27\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\
+\0\0\x26\0\0\0\x04\0\0\0\x27\0\0\0\x4c\x09\0\0\0\0\0\x0e\x29\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x34\0\0\0\x63\x09\0\0\0\0\0\x0e\x2b\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x23\0\0\0\x04\0\0\0\x05\0\0\0\0\0\0\0\
+\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x1f\0\0\0\x7a\x09\0\0\0\0\0\x0e\x2e\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x26\0\0\0\x91\x09\0\0\
+\0\0\0\x0e\x30\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x43\
+\0\0\0\xa8\x09\0\0\0\0\0\x0e\x32\0\0\0\0\0\0\0\xbf\x09\0\0\0\0\0\x0e\x2e\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x1d\0\0\0\xd6\x09\0\0\0\
+\0\0\x0e\x35\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\0\x04\0\0\0\x39\0\
+\0\0\xed\x09\0\0\0\0\0\x0e\x37\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x26\0\0\
+\0\x04\0\0\0\x20\0\0\0\x04\x0a\0\0\0\0\0\x0e\x39\0\0\0\0\0\0\0\x1b\x0a\0\0\0\0\
+\0\x0e\x35\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x23\0\0\0\x04\0\0\0\x07\0\0\
+\0\x33\x0a\0\0\x05\0\0\x0f\x60\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\x0a\0\0\0\x10\
+\0\0\0\x10\0\0\0\x0c\0\0\0\x20\0\0\0\x10\0\0\0\x0e\0\0\0\x30\0\0\0\x10\0\0\0\
+\x1c\0\0\0\x40\0\0\0\x20\0\0\0\x39\x0a\0\0\x0b\0\0\x0f\xa5\x01\0\0\x28\0\0\0\0\
+\0\0\0\x10\0\0\0\x2a\0\0\0\x10\0\0\0\x27\0\0\0\x2c\0\0\0\x37\0\0\0\x34\0\0\0\
+\x2f\0\0\0\x6b\0\0\0\x1f\0\0\0\x31\0\0\0\x8a\0\0\0\x26\0\0\0\x33\0\0\0\xb0\0\0\
+\0\x43\0\0\0\x34\0\0\0\xf3\0\0\0\x1f\0\0\0\x36\0\0\0\x12\x01\0\0\x1d\0\0\0\x38\
+\0\0\0\x2f\x01\0\0\x39\0\0\0\x3a\0\0\0\x68\x01\0\0\x20\0\0\0\x3b\0\0\0\x88\x01\
+\0\0\x1d\0\0\0\x41\x0a\0\0\x01\0\0\x0f\x04\0\0\0\x25\0\0\0\0\0\0\0\x04\0\0\0\0\
+\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\x49\x5a\x45\x5f\x54\x59\x50\
+\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\0\
+\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x32\0\
+\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x34\0\
+\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\0\x6d\x65\x6d\x5f\x72\x61\x6e\
+\x67\x65\x5f\x72\x65\x73\x75\x6c\x74\0\x62\x75\x66\0\x73\x69\x7a\x65\0\x73\x74\
+\x61\x74\x75\x73\0\x75\x69\x6e\x74\x33\x32\x5f\x74\0\x75\x33\x32\0\x5f\x5f\x75\
+\x33\x32\0\x6b\x65\x79\0\x76\x61\x6c\x75\x65\0\x6d\x65\x6d\x5f\x72\x61\x6e\x67\
+\x65\x5f\x6d\x61\x70\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\
+\x6c\x6f\x6e\x67\0\x63\x74\x78\0\x70\x61\x72\x73\x65\x5f\x70\x65\0\x66\x65\x6e\
+\x74\x72\x79\x2f\x62\x70\x66\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\
+\x6c\x65\0\x2f\x68\x6f\x6d\x65\x2f\x7a\x62\x6f\x6f\x74\x5f\x62\x70\x66\x2f\x6b\
+\x65\x78\x65\x63\x5f\x70\x65\x5f\x70\x61\x72\x73\x65\x72\x5f\x62\x70\x66\x2e\
+\x63\0\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x61\x72\x73\x65\
+\x5f\x70\x65\x2c\x20\x63\x68\x61\x72\x20\x2a\x69\x6d\x61\x67\x65\x5f\x62\x75\
+\x66\x2c\x20\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\x20\x69\x6d\x61\
+\x67\x65\x5f\x73\x7a\x2c\x20\x63\x68\x61\x72\x20\x2a\x75\x6e\x75\x73\x65\x64\
+\x5f\x69\x6e\x69\x74\x72\x64\x2c\0\x09\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\
+\x6e\x74\x20\x6b\x65\x79\x20\x3d\x20\x30\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x69\
+\x6e\x74\x6b\x28\x22\x62\x65\x67\x69\x6e\x20\x70\x61\x72\x73\x65\x20\x50\x45\
+\x5c\x6e\x22\x29\x3b\0\x09\x69\x66\x20\x28\x21\x69\x6d\x61\x67\x65\x5f\x62\x75\
+\x66\x20\x7c\x7c\x20\x28\x69\x6d\x61\x67\x65\x5f\x73\x7a\x20\x3e\x20\x4d\x41\
+\x58\x5f\x52\x45\x43\x4f\x52\x44\x5f\x53\x49\x5a\x45\x29\x29\x20\x7b\0\x09\x09\
+\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x45\x72\x72\x3a\x20\x69\x6d\
+\x61\x67\x65\x20\x73\x69\x7a\x65\x20\x69\x73\x20\x67\x72\x65\x61\x74\x65\x72\
+\x20\x74\x68\x61\x6e\x20\x30\x78\x25\x6c\x78\x5c\x6e\x22\x2c\x20\x4d\x41\x58\
+\x5f\x52\x45\x43\x4f\x52\x44\x5f\x53\x49\x5a\x45\x29\x3b\0\x09\x09\x72\x65\x74\
+\x75\x72\x6e\x20\x30\x3b\0\x09\x62\x75\x66\x20\x3d\x20\x28\x63\x68\x61\x72\x20\
+\x2a\x29\x62\x70\x66\x5f\x72\x69\x6e\x67\x62\x75\x66\x5f\x72\x65\x73\x65\x72\
+\x76\x65\x28\x26\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\x2c\x20\x73\x69\x7a\x65\
+\x6f\x66\x28\x73\x74\x72\x75\x63\x74\x20\x6c\x69\x6e\x75\x78\x5f\x70\x65\x5f\
+\x7a\x62\x6f\x6f\x74\x5f\x68\x65\x61\x64\x65\x72\x29\x2c\x20\x30\x29\x3b\0\x09\
+\x69\x66\x20\x28\x21\x62\x75\x66\x29\x20\x7b\0\x09\x20\x20\x20\x20\x09\x62\x70\
+\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x45\x72\x72\x3a\x20\x66\x61\x69\x6c\
+\x20\x74\x6f\x20\x72\x65\x73\x65\x72\x76\x65\x20\x72\x69\x6e\x67\x62\x75\x66\
+\x20\x74\x6f\x20\x70\x61\x72\x73\x65\x20\x7a\x62\x6f\x6f\x74\x20\x68\x65\x61\
+\x64\x65\x72\x5c\x6e\x22\x29\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x6f\x62\x65\x5f\
+\x72\x65\x61\x64\x28\x28\x76\x6f\x69\x64\x20\x2a\x29\x62\x75\x66\x2c\x20\x73\
+\x69\x7a\x65\x6f\x66\x28\x73\x74\x72\x75\x63\x74\x20\x6c\x69\x6e\x75\x78\x5f\
+\x70\x65\x5f\x7a\x62\x6f\x6f\x74\x5f\x68\x65\x61\x64\x65\x72\x29\x2c\x20\x69\
+\x6d\x61\x67\x65\x5f\x62\x75\x66\x29\x3b\0\x09\x69\x66\x20\x28\x21\x21\x5f\x5f\
+\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\x6d\x63\x6d\x70\x28\x26\x7a\x62\x6f\
+\x6f\x74\x5f\x68\x65\x61\x64\x65\x72\x2d\x3e\x69\x6d\x61\x67\x65\x5f\x74\x79\
+\x70\x65\x2c\x20\x22\x7a\x69\x6d\x67\x22\x2c\0\x09\x20\x20\x20\x20\x09\x62\x70\
+\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x45\x72\x72\x3a\x20\x69\x6d\x61\x67\
+\x65\x20\x69\x73\x20\x6e\x6f\x74\x20\x7a\x62\x6f\x6f\x74\x20\x69\x6d\x61\x67\
+\x65\x5c\x6e\x22\x29\x3b\0\x09\x09\x62\x70\x66\x5f\x72\x69\x6e\x67\x62\x75\x66\
+\x5f\x64\x69\x73\x63\x61\x72\x64\x28\x62\x75\x66\x2c\x20\x42\x50\x46\x5f\x52\
+\x42\x5f\x4e\x4f\x5f\x57\x41\x4b\x45\x55\x50\x29\x3b\0\x09\x75\x6e\x73\x69\x67\
+\x6e\x65\x64\x20\x69\x6e\x74\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\
+\x65\x20\x3d\x20\x7a\x62\x6f\x6f\x74\x5f\x68\x65\x61\x64\x65\x72\x2d\x3e\x70\
+\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\x65\x3b\0\x09\x75\x6e\x73\x69\x67\x6e\
+\x65\x64\x20\x69\x6e\x74\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\x66\x66\x73\
+\x65\x74\x20\x3d\x20\x7a\x62\x6f\x6f\x74\x5f\x68\x65\x61\x64\x65\x72\x2d\x3e\
+\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\x66\x66\x73\x65\x74\x3b\0\x09\x62\x70\x66\
+\x5f\x72\x69\x6e\x67\x62\x75\x66\x5f\x64\x69\x73\x63\x61\x72\x64\x28\x62\x75\
+\x66\x2c\x20\x42\x50\x46\x5f\x52\x42\x5f\x4e\x4f\x5f\x57\x41\x4b\x45\x55\x50\
+\x29\x3b\0\x09\x69\x6d\x61\x67\x65\x5f\x73\x7a\x20\x3d\x20\x69\x6d\x61\x67\x65\
+\x5f\x73\x7a\x20\x26\x20\x28\x4d\x41\x58\x5f\x52\x45\x43\x4f\x52\x44\x5f\x53\
+\x49\x5a\x45\x20\x2d\x20\x31\x29\x3b\0\x09\x69\x66\x20\x28\x69\x6d\x61\x67\x65\
+\x5f\x67\x7a\x5f\x73\x7a\x20\x3c\x3d\x20\x30\x20\x7c\x7c\x20\x69\x6d\x61\x67\
+\x65\x5f\x67\x7a\x5f\x73\x7a\x20\x2b\x20\x34\x20\x3e\x20\x69\x6d\x61\x67\x65\
+\x5f\x73\x7a\x29\x20\x7b\0\x09\x09\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\
+\x22\x49\x6e\x76\x61\x6c\x69\x64\x20\x6f\x66\x66\x73\x65\x74\x20\x66\x6f\x72\
+\x20\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\x64\x20\x73\x69\x7a\x65\x5c\
+\x6e\x22\x29\x3b\0\x09\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\x74\x20\x64\
+\x5f\x70\x6f\x73\x20\x3d\x20\x28\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\x66\x66\
+\x73\x65\x74\x20\x2b\x20\x69\x6d\x61\x67\x65\x5f\x67\x7a\x5f\x73\x7a\x29\x20\
+\x26\x20\x28\x4d\x41\x58\x5f\x52\x45\x43\x4f\x52\x44\x5f\x53\x49\x5a\x45\x20\
+\x2d\x20\x31\x29\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x6f\x62\x65\x5f\x72\x65\x61\
+\x64\x28\x28\x76\x6f\x69\x64\x20\x2a\x29\x26\x64\x65\x63\x6f\x6d\x70\x72\x65\
+\x73\x73\x65\x64\x5f\x73\x7a\x2c\x20\x73\x69\x7a\x65\x6f\x66\x28\x69\x6e\x74\
+\x29\x2c\x20\x69\x6d\x61\x67\x65\x5f\x62\x75\x66\x20\x2b\x20\x64\x5f\x70\x6f\
+\x73\x29\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x70\x61\x79\
+\x6c\x6f\x61\x64\x5f\x6f\x66\x66\x73\x65\x74\x3a\x30\x78\x25\x6c\x78\x2c\x20\
+\x70\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\x65\x3a\x30\x78\x25\x6c\x78\x2c\
+\x20\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\x64\x20\x73\x69\x7a\x65\x3a\
+\x30\x78\x25\x6c\x78\x5c\x6e\x22\x2c\0\x09\x69\x66\x20\x28\x64\x65\x63\x6f\x6d\
+\x70\x72\x65\x73\x73\x65\x64\x5f\x73\x7a\x20\x3d\x3d\x20\x30\x29\x20\x7b\0\x09\
+\x20\x20\x20\x20\x09\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x64\x65\
+\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\x64\x20\x73\x69\x7a\x65\x20\x25\x64\x20\
+\x69\x73\x20\x77\x72\x6f\x6e\x67\x5c\x6e\x22\x2c\x20\x64\x65\x63\x6f\x6d\x70\
+\x72\x65\x73\x73\x65\x64\x5f\x73\x7a\x29\x3b\0\x09\x69\x66\x20\x28\x70\x61\x79\
+\x6c\x6f\x61\x64\x5f\x6f\x66\x66\x73\x65\x74\x20\x3e\x3d\x20\x4d\x41\x58\x5f\
+\x52\x45\x43\x4f\x52\x44\x5f\x53\x49\x5a\x45\x20\x29\x20\x7b\0\x09\x09\x62\x70\
+\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x45\x72\x72\x3a\x20\x70\x61\x79\x6c\
+\x6f\x61\x64\x5f\x6f\x66\x66\x73\x65\x74\x20\x3e\x20\x30\x78\x25\x6c\x78\x5c\
+\x6e\x22\x2c\x20\x4d\x41\x58\x5f\x52\x45\x43\x4f\x52\x44\x5f\x53\x49\x5a\x45\
+\x29\x3b\0\x09\x62\x75\x66\x20\x3d\x20\x28\x63\x68\x61\x72\x20\x2a\x29\x62\x70\
+\x66\x5f\x72\x69\x6e\x67\x62\x75\x66\x5f\x72\x65\x73\x65\x72\x76\x65\x28\x26\
+\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\x2c\x20\x4d\x41\x58\x5f\x52\x45\x43\x4f\
+\x52\x44\x5f\x53\x49\x5a\x45\x2c\x20\x30\x29\x3b\0\x09\x09\x62\x70\x66\x5f\x70\
+\x72\x69\x6e\x74\x6b\x28\x22\x45\x72\x72\x3a\x20\x66\x61\x69\x6c\x20\x74\x6f\
+\x20\x72\x65\x73\x65\x72\x76\x65\x20\x66\x72\x6f\x6d\x20\x72\x69\x6e\x67\x62\
+\x75\x66\x5f\x31\x20\x66\x6f\x72\x20\x72\x65\x61\x64\x69\x6e\x67\x20\x70\x61\
+\x79\x6c\x6f\x61\x64\x5c\x6e\x22\x29\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x6f\x62\
+\x65\x5f\x72\x65\x61\x64\x28\x28\x76\x6f\x69\x64\x20\x2a\x29\x62\x75\x66\x2c\
+\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\x65\x2c\x20\x69\x6d\x61\x67\
+\x65\x5f\x62\x75\x66\x20\x2b\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\x66\x66\
+\x73\x65\x74\x29\x3b\0\x09\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\x6b\x28\x22\x43\
+\x61\x6c\x6c\x69\x6e\x67\x20\x62\x70\x66\x5f\x6b\x65\x78\x65\x63\x5f\x64\x65\
+\x63\x6f\x6d\x70\x72\x65\x73\x73\x28\x29\x5c\x6e\x22\x29\x3b\0\x09\x62\x70\x66\
+\x5f\x6b\x65\x78\x65\x63\x5f\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x28\x62\
+\x75\x66\x2c\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\x65\x20\x2d\x20\
+\x34\x2c\x20\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\x64\x5f\x73\x7a\x2c\
+\x20\x6d\x61\x70\x5f\x70\x74\x72\x2c\x20\x26\x6b\x65\x79\x29\x3b\0\x09\x72\x65\
+\x73\x75\x6c\x74\x20\x3d\x20\x62\x70\x66\x5f\x6d\x61\x70\x5f\x6c\x6f\x6f\x6b\
+\x75\x70\x5f\x65\x6c\x65\x6d\x28\x26\x6d\x65\x6d\x5f\x72\x61\x6e\x67\x65\x5f\
+\x6d\x61\x70\x2c\x20\x26\x6b\x65\x79\x29\x3b\0\x09\x69\x66\x20\x28\x21\x21\x72\
+\x65\x73\x75\x6c\x74\x29\x20\x7b\0\x09\x09\x62\x70\x66\x5f\x70\x72\x69\x6e\x74\
+\x6b\x28\x22\x43\x61\x6c\x6c\x69\x6e\x67\x20\x62\x70\x66\x5f\x6b\x65\x78\x65\
+\x63\x5f\x63\x61\x72\x72\x69\x65\x72\x28\x29\x5c\x6e\x22\x29\x3b\0\x09\x09\x62\
+\x70\x66\x5f\x6b\x65\x78\x65\x63\x5f\x63\x61\x72\x72\x69\x65\x72\x28\x4b\x45\
+\x58\x45\x43\x5f\x52\x45\x53\x5f\x4b\x45\x52\x4e\x45\x4c\x5f\x4e\x41\x4d\x45\
+\x2c\x20\x26\x6d\x65\x6d\x5f\x72\x61\x6e\x67\x65\x5f\x6d\x61\x70\x2c\x20\x72\
+\x65\x73\x75\x6c\x74\x29\x3b\0\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\
+\x65\0\x66\x65\x6e\x74\x72\x79\x2f\x62\x70\x66\x5f\x70\x6f\x73\x74\x5f\x68\x61\
+\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x69\x6e\x74\x20\x42\x50\x46\x5f\
+\x50\x52\x4f\x47\x28\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\
+\x20\x63\x68\x61\x72\x20\x2a\x69\x6d\x61\x67\x65\x5f\x62\x75\x66\x2c\x20\x69\
+\x6e\x74\x20\x62\x75\x66\x5f\x73\x7a\x29\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\
+\x4e\x53\x45\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\
+\x5f\x66\x6d\x74\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\
+\x5f\x5f\x66\x6d\x74\x2e\x31\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\
+\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x32\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\
+\x5f\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x33\0\x5f\x5f\x5f\x5f\x70\x61\
+\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x34\0\x5f\x5f\x5f\
+\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x35\0\
+\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\
+\x74\x2e\x36\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\
+\x5f\x66\x6d\x74\x2e\x37\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\x2e\
+\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x38\0\x5f\x5f\x5f\x5f\x70\x61\x72\x73\x65\x5f\
+\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x39\0\x5f\x5f\x5f\x5f\x70\x61\x72\
+\x73\x65\x5f\x70\x65\x2e\x5f\x5f\x5f\x5f\x66\x6d\x74\x2e\x31\x30\0\x2e\x6d\x61\
+\x70\x73\0\x2e\x72\x6f\x64\x61\x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xfd\x0f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\
+\x5f\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\
+\x62\x75\x66\x5f\x32\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\
+\x69\x6e\x67\x62\x75\x66\x5f\x33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\
+\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x34\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x0a\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\x6d\x65\x6d\x5f\x72\x61\x6e\x67\x65\x5f\x6d\x61\x70\0\0\0\
+\0\0\0\0\0\0\0\0\x14\0\0\0\x16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\
+\0\xa5\x01\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\
+\x65\x2e\x72\x6f\x64\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\x3e\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x62\x65\x67\x69\x6e\x20\x70\x61\x72\x73\x65\x20\x50\x45\x0a\0\
+\x45\x72\x72\x3a\x20\x69\x6d\x61\x67\x65\x20\x73\x69\x7a\x65\x20\x69\x73\x20\
+\x67\x72\x65\x61\x74\x65\x72\x20\x74\x68\x61\x6e\x20\x30\x78\x25\x6c\x78\x0a\0\
+\x45\x72\x72\x3a\x20\x66\x61\x69\x6c\x20\x74\x6f\x20\x72\x65\x73\x65\x72\x76\
+\x65\x20\x72\x69\x6e\x67\x62\x75\x66\x20\x74\x6f\x20\x70\x61\x72\x73\x65\x20\
+\x7a\x62\x6f\x6f\x74\x20\x68\x65\x61\x64\x65\x72\x0a\0\x45\x72\x72\x3a\x20\x69\
+\x6d\x61\x67\x65\x20\x69\x73\x20\x6e\x6f\x74\x20\x7a\x62\x6f\x6f\x74\x20\x69\
+\x6d\x61\x67\x65\x0a\0\x49\x6e\x76\x61\x6c\x69\x64\x20\x6f\x66\x66\x73\x65\x74\
+\x20\x66\x6f\x72\x20\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\x64\x20\x73\
+\x69\x7a\x65\x0a\0\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\x66\x66\x73\x65\x74\x3a\
+\x30\x78\x25\x6c\x78\x2c\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x73\x69\x7a\x65\
+\x3a\x30\x78\x25\x6c\x78\x2c\x20\x64\x65\x63\x6f\x6d\x70\x72\x65\x73\x73\x65\
+\x64\x20\x73\x69\x7a\x65\x3a\x30\x78\x25\x6c\x78\x0a\0\x64\x65\x63\x6f\x6d\x70\
+\x72\x65\x73\x73\x65\x64\x20\x73\x69\x7a\x65\x20\x25\x64\x20\x69\x73\x20\x77\
+\x72\x6f\x6e\x67\x0a\0\x45\x72\x72\x3a\x20\x70\x61\x79\x6c\x6f\x61\x64\x5f\x6f\
+\x66\x66\x73\x65\x74\x20\x3e\x20\x30\x78\x25\x6c\x78\x0a\0\x45\x72\x72\x3a\x20\
+\x66\x61\x69\x6c\x20\x74\x6f\x20\x72\x65\x73\x65\x72\x76\x65\x20\x66\x72\x6f\
+\x6d\x20\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\x20\x66\x6f\x72\x20\x72\x65\x61\
+\x64\x69\x6e\x67\x20\x70\x61\x79\x6c\x6f\x61\x64\x0a\0\x43\x61\x6c\x6c\x69\x6e\
+\x67\x20\x62\x70\x66\x5f\x6b\x65\x78\x65\x63\x5f\x64\x65\x63\x6f\x6d\x70\x72\
+\x65\x73\x73\x28\x29\x0a\0\x43\x61\x6c\x6c\x69\x6e\x67\x20\x62\x70\x66\x5f\x6b\
+\x65\x78\x65\x63\x5f\x63\x61\x72\x72\x69\x65\x72\x28\x29\x0a\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\x02\0\0\0\x04\0\0\0\x0c\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x2e\
+\x72\x6f\x64\x61\x74\x61\x2e\x73\x74\x72\x31\x2e\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x7a\x69\x6d\x67\0\x6b\x65\x72\x6e\x65\x6c\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x18\x08\0\0\0\0\0\x79\x16\
+\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x63\x1a\xf8\xff\0\0\0\0\x18\x61\0\0\x05\0\0\0\
+\0\0\0\0\0\0\0\0\xb7\x02\0\0\x10\0\0\0\x85\0\0\0\x06\0\0\0\x15\x06\x05\0\0\0\0\
+\0\xbf\x81\0\0\0\0\0\0\x67\x01\0\0\x20\0\0\0\x77\x01\0\0\x20\0\0\0\xb7\x02\0\0\
+\x01\0\0\x08\x2d\x12\x06\0\0\0\0\0\x18\x61\0\0\x05\0\0\0\0\0\0\0\x10\0\0\0\xb7\
+\x02\0\0\x27\0\0\0\xb7\x03\0\0\0\0\0\x08\x85\0\0\0\x06\0\0\0\x05\0\xa5\0\0\0\0\
+\0\x18\x51\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb7\x02\0\0\x24\0\0\0\xb7\x03\0\0\0\0\0\
+\0\x85\0\0\0\x83\0\0\0\xbf\x09\0\0\0\0\0\0\x55\x09\x05\0\0\0\0\0\x18\x61\0\0\
+\x05\0\0\0\0\0\0\0\x37\0\0\0\xb7\x02\0\0\x34\0\0\0\x85\0\0\0\x06\0\0\0\x05\0\
+\x99\0\0\0\0\0\xbf\x91\0\0\0\0\0\0\xb7\x02\0\0\x24\0\0\0\xbf\x63\0\0\0\0\0\0\
+\x85\0\0\0\x04\0\0\0\x71\x91\x05\0\0\0\0\0\x67\x01\0\0\x08\0\0\0\x71\x92\x04\0\
+\0\0\0\0\x4f\x21\0\0\0\0\0\0\x71\x92\x06\0\0\0\0\0\x67\x02\0\0\x10\0\0\0\x71\
+\x93\x07\0\0\0\0\0\x67\x03\0\0\x18\0\0\0\x4f\x23\0\0\0\0\0\0\x4f\x13\0\0\0\0\0\
+\0\x15\x03\x08\0\x7a\x69\x6d\x67\x18\x61\0\0\x05\0\0\0\0\0\0\0\x6b\0\0\0\xb7\
+\x02\0\0\x1f\0\0\0\x85\0\0\0\x06\0\0\0\xbf\x91\0\0\0\0\0\0\xb7\x02\0\0\x01\0\0\
+\0\x85\0\0\0\x85\0\0\0\x05\0\x82\0\0\0\0\0\x7b\x6a\xe0\xff\0\0\0\0\x71\x97\x0f\
+\0\0\0\0\0\x71\x91\x0e\0\0\0\0\0\x7b\x1a\xf0\xff\0\0\0\0\x71\x91\x0c\0\0\0\0\0\
+\x7b\x1a\xe8\xff\0\0\0\0\x71\x96\x0d\0\0\0\0\0\x71\x91\x0b\0\0\0\0\0\x7b\x1a\
+\xd8\xff\0\0\0\0\x71\x91\x0a\0\0\0\0\0\x7b\x1a\xc8\xff\0\0\0\0\x71\x91\x08\0\0\
+\0\0\0\x7b\x1a\xc0\xff\0\0\0\0\x71\x91\x09\0\0\0\0\0\x7b\x1a\xd0\xff\0\0\0\0\
+\xbf\x91\0\0\0\0\0\0\xb7\x02\0\0\x01\0\0\0\x85\0\0\0\x85\0\0\0\x67\x06\0\0\x08\
+\0\0\0\x79\xa1\xe8\xff\0\0\0\0\x4f\x16\0\0\0\0\0\0\x79\xa1\xf0\xff\0\0\0\0\x67\
+\x01\0\0\x10\0\0\0\x67\x07\0\0\x18\0\0\0\x4f\x17\0\0\0\0\0\0\x4f\x67\0\0\0\0\0\
+\0\x57\x08\0\0\xff\xff\xff\x07\x2d\x87\x07\0\0\0\0\0\xbf\x79\0\0\0\0\0\0\x67\
+\x09\0\0\x20\0\0\0\x18\x01\0\0\0\0\0\0\0\0\0\0\xfc\xff\xff\xff\x0f\x19\0\0\0\0\
+\0\0\xc7\x09\0\0\x20\0\0\0\x65\x09\x05\0\0\0\0\0\x18\x61\0\0\x05\0\0\0\0\0\0\0\
+\x8a\0\0\0\xb7\x02\0\0\x26\0\0\0\x85\0\0\0\x06\0\0\0\x05\0\x5a\0\0\0\0\0\x79\
+\xa1\xd0\xff\0\0\0\0\x67\x01\0\0\x08\0\0\0\x79\xa2\xc0\xff\0\0\0\0\x4f\x21\0\0\
+\0\0\0\0\x79\xa2\xc8\xff\0\0\0\0\x67\x02\0\0\x10\0\0\0\x79\xa8\xd8\xff\0\0\0\0\
+\x67\x08\0\0\x18\0\0\0\x4f\x28\0\0\0\0\0\0\x4f\x18\0\0\0\0\0\0\xbf\x91\0\0\0\0\
+\0\0\x0f\x81\0\0\0\0\0\0\x57\x01\0\0\xff\xff\xff\x07\x79\xa6\xe0\xff\0\0\0\0\
+\xbf\x63\0\0\0\0\0\0\x0f\x13\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\xfc\
+\xff\xff\xff\xb7\x02\0\0\x04\0\0\0\x85\0\0\0\x04\0\0\0\x61\xa5\xfc\xff\0\0\0\0\
+\x18\x61\0\0\x05\0\0\0\0\0\0\0\xb0\0\0\0\xb7\x02\0\0\x43\0\0\0\xbf\x83\0\0\0\0\
+\0\0\xbf\x74\0\0\0\0\0\0\x85\0\0\0\x06\0\0\0\x61\xa1\xfc\xff\0\0\0\0\x55\x01\
+\x06\0\0\0\0\0\x18\x61\0\0\x05\0\0\0\0\0\0\0\xf3\0\0\0\xb7\x02\0\0\x1f\0\0\0\
+\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x06\0\0\0\x05\0\x37\0\0\0\0\0\xb7\x01\0\0\0\0\0\
+\x08\x2d\x81\x04\0\0\0\0\0\x18\x61\0\0\x05\0\0\0\0\0\0\0\x12\x01\0\0\xb7\x02\0\
+\0\x1d\0\0\0\x05\0\x89\xff\0\0\0\0\x18\x51\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb7\x02\
+\0\0\0\0\0\x08\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x83\0\0\0\x55\0\x05\0\0\0\0\0\x18\
+\x61\0\0\x05\0\0\0\0\0\0\0\x2f\x01\0\0\xb7\x02\0\0\x39\0\0\0\x85\0\0\0\x06\0\0\
+\0\x05\0\x26\0\0\0\0\0\x0f\x86\0\0\0\0\0\0\xbf\x08\0\0\0\0\0\0\xbf\x81\0\0\0\0\
+\0\0\xbf\x72\0\0\0\0\0\0\xbf\x63\0\0\0\0\0\0\x85\0\0\0\x04\0\0\0\x18\x61\0\0\
+\x05\0\0\0\0\0\0\0\x68\x01\0\0\xb7\x02\0\0\x20\0\0\0\x85\0\0\0\x06\0\0\0\x61\
+\xa3\xfc\xff\0\0\0\0\xbf\xa6\0\0\0\0\0\0\x07\x06\0\0\xf8\xff\xff\xff\xbf\x81\0\
+\0\0\0\0\0\xbf\x92\0\0\0\0\0\0\x18\x54\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\xbf\x65\0\
+\0\0\0\0\0\x85\0\0\0\xd4\0\0\0\xbf\x81\0\0\0\0\0\0\xb7\x02\0\0\x01\0\0\0\x85\0\
+\0\0\x85\0\0\0\x18\x51\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\xbf\x62\0\0\0\0\0\0\x85\0\
+\0\0\x01\0\0\0\xbf\x06\0\0\0\0\0\0\x15\x06\x0a\0\0\0\0\0\x18\x61\0\0\x05\0\0\0\
+\0\0\0\0\x88\x01\0\0\xb7\x02\0\0\x1d\0\0\0\x85\0\0\0\x06\0\0\0\x18\x61\0\0\x06\
+\0\0\0\0\0\0\0\x05\0\0\0\x18\x52\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\xbf\x63\0\0\0\0\
+\0\0\x85\0\0\0\xd5\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x20\0\0\0\
+\0\0\0\0\xe4\0\0\0\x0a\x01\0\0\x05\x50\x01\0\x03\0\0\0\xe4\0\0\0\x5e\x01\0\0\
+\x0f\x74\x01\0\x04\0\0\0\xe4\0\0\0\x75\x01\0\0\x02\x7c\x01\0\x08\0\0\0\xe4\0\0\
+\0\x96\x01\0\0\x11\x84\x01\0\x0e\0\0\0\xe4\0\0\0\xc9\x01\0\0\x03\x88\x01\0\x13\
+\0\0\0\xe4\0\0\0\x13\x02\0\0\x03\x20\x02\0\x14\0\0\0\xe4\0\0\0\x1f\x02\0\0\x10\
+\x9c\x01\0\x1a\0\0\0\xe4\0\0\0\x78\x02\0\0\x06\xa0\x01\0\x1b\0\0\0\xe4\0\0\0\
+\x85\x02\0\0\x07\xa4\x01\0\x1f\0\0\0\xe4\0\0\0\x13\x02\0\0\x03\x4c\x02\0\x20\0\
+\0\0\xe4\0\0\0\xcf\x02\0\0\x02\xb8\x01\0\x24\0\0\0\xe4\0\0\0\x1e\x03\0\0\x08\
+\xc0\x01\0\x2e\0\0\0\xe4\0\0\0\x1e\x03\0\0\x06\xc0\x01\0\x2f\0\0\0\xe4\0\0\0\
+\x59\x03\0\0\x07\xc8\x01\0\x33\0\0\0\xe4\0\0\0\x8e\x03\0\0\x03\xcc\x01\0\x36\0\
+\0\0\xe4\0\0\0\x13\x02\0\0\x03\xd0\x01\0\x38\0\0\0\xe4\0\0\0\xbc\x03\0\0\x2c\
+\xe0\x01\0\x3e\0\0\0\xe4\0\0\0\xf5\x03\0\0\x2e\xdc\x01\0\x45\0\0\0\xe4\0\0\0\
+\x32\x04\0\0\x02\xe4\x01\0\x49\0\0\0\xe4\0\0\0\xbc\x03\0\0\x2c\xe0\x01\0\x51\0\
+\0\0\xe4\0\0\0\x5f\x04\0\0\x16\xb4\x01\0\x52\0\0\0\xe4\0\0\0\x8d\x04\0\0\x17\
+\xec\x01\0\x5a\0\0\0\xe4\0\0\0\xc4\x04\0\0\x03\xf0\x01\0\x5e\0\0\0\xe4\0\0\0\
+\x13\x02\0\0\x03\x4c\x02\0\x69\0\0\0\xe4\0\0\0\xfc\x04\0\0\x27\0\x02\0\x6b\0\0\
+\0\xe4\0\0\0\xfc\x04\0\0\x36\0\x02\0\x6d\0\0\0\xe4\0\0\0\x4a\x05\0\0\x42\x08\
+\x02\0\x71\0\0\0\xe4\0\0\0\x4a\x05\0\0\x02\x08\x02\0\x73\0\0\0\xe4\0\0\0\x95\
+\x05\0\0\x02\x10\x02\0\x7a\0\0\0\xe4\0\0\0\xe8\x05\0\0\x06\x18\x02\0\x7b\0\0\0\
+\xe4\0\0\0\xe8\x05\0\0\x06\x18\x02\0\x7c\0\0\0\xe4\0\0\0\x05\x06\0\0\x07\x1c\
+\x02\0\x81\0\0\0\xe4\0\0\0\x13\x02\0\0\x03\x20\x02\0\x83\0\0\0\xe4\0\0\0\x4b\
+\x06\0\0\x06\x30\x02\0\x84\0\0\0\xe4\0\0\0\x76\x06\0\0\x03\x34\x02\0\x88\0\0\0\
+\xe4\0\0\0\xb6\x06\0\0\x10\x40\x02\0\x8d\0\0\0\xe4\0\0\0\x78\x02\0\0\x06\x44\
+\x02\0\x8e\0\0\0\xe4\0\0\0\xfa\x06\0\0\x03\x48\x02\0\x92\0\0\0\xe4\0\0\0\x13\
+\x02\0\0\x03\x4c\x02\0\x93\0\0\0\xe4\0\0\0\x45\x07\0\0\x36\x54\x02\0\x95\0\0\0\
+\xe4\0\0\0\x45\x07\0\0\x02\x54\x02\0\x99\0\0\0\xe4\0\0\0\x8d\x07\0\0\x02\x5c\
+\x02\0\x9d\0\0\0\xe4\0\0\0\xbe\x07\0\0\x02\x60\x02\0\xa6\0\0\0\xe4\0\0\0\x32\
+\x04\0\0\x02\x64\x02\0\xa9\0\0\0\xe4\0\0\0\x0c\x08\0\0\x0b\x70\x02\0\xae\0\0\0\
+\xe4\0\0\0\x41\x08\0\0\x06\x74\x02\0\xaf\0\0\0\xe4\0\0\0\x52\x08\0\0\x03\x78\
+\x02\0\xb3\0\0\0\xe4\0\0\0\x81\x08\0\0\x03\x7c\x02\0\xb9\0\0\0\xe4\0\0\0\x0a\
+\x01\0\0\x05\x50\x01\0\x1a\0\0\0\xbb\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x70\x61\x72\x73\x65\x5f\x70\x65\0\
+\0\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\
+\x10\0\0\0\0\0\0\0\0\0\0\0\x31\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x68\x61\x6e\x64\x6c\x65\x5f\
+\x70\x65\x66\x69\x6c\x65\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\xb7\0\0\0\0\0\0\0\
+\x95\0\0\0\0\0\0\0\0\0\0\0\x22\0\0\0\0\0\0\0\xe4\0\0\0\xf1\x08\0\0\x05\x94\x02\
+\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\0\
+\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\
+\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x70\x6f\x73\x74\x5f\x68\x61\x6e\x64\x6c\
+\x65\x5f\x70\x65\x66\x69\x6c\x65\0\0";
+	static const char opts_insn[] __attribute__((__aligned__(8))) = "\
+\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
+\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x38\0\0\0\0\0\x61\
+\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
+\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
+\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x84\xff\0\0\0\0\xd5\x01\x01\0\0\
+\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x01\0\0\0\0\
+\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\
+\0\0\0\0\0\0\0\0\x04\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\
+\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x01\0\
+\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\
+\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\
+\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\
+\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\
+\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\
+\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\
+\xa8\0\0\0\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\
+\0\0\0\0\0\0\0\0\0\0\x18\x15\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x14\x15\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x15\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\
+\0\0\0\0\0\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\x15\0\0\x7b\x01\0\0\0\0\0\0\
+\xb7\x01\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x15\0\0\xb7\x03\0\0\x1c\0\
+\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xb0\xff\0\0\0\0\x63\x7a\
+\x78\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\
+\0\0\0\0\x2c\x15\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\
+\0\0\0\0\0\x20\x15\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\
+\0\0\0\xc5\x07\xa3\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\
+\0\0\0\0\x61\x60\x2c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x74\x15\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\
+\0\x68\x15\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
+\xc5\x07\x94\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\x63\x71\0\0\0\0\
+\0\0\x61\x60\x3c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xbc\
+\x15\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
+\xb0\x15\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\
+\x07\x85\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x63\x71\0\0\0\0\0\0\
+\x61\x60\x4c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\x16\
+\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xf8\
+\x15\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
+\x76\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x63\x71\0\0\0\0\0\0\x61\
+\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x16\0\0\x63\x01\0\0\0\0\0\
+\0\x61\x60\x5c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x4c\
+\x16\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
+\x40\x16\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\
+\x07\x63\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x63\x71\0\0\0\0\0\0\
+\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x16\0\0\x63\x01\0\0\0\
+\0\0\0\x61\x60\x6c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x94\x16\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\
+\0\x88\x16\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
+\xc5\x07\x50\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x63\x71\0\0\0\0\
+\0\0\x79\x63\x70\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\xd0\x16\0\0\xb7\x02\0\0\xa5\x01\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\
+\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\
+\0\0\0\0\0\0\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x18\
+\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x78\x18\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\x88\x18\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\
+\x16\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x18\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\
+\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x18\0\0\xb7\x03\0\0\x20\0\0\0\x85\
+\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x2c\xff\0\0\0\0\x18\x62\0\0\0\0\0\
+\0\0\0\0\0\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x18\0\
+\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xa0\
+\x18\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
+\x1f\xff\0\0\0\0\x61\x60\x7c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\
+\0\0\0\0\xb4\x18\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\
+\0\0\0\0\0\xa8\x18\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\
+\0\0\0\xc5\x07\x13\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x63\x71\0\
+\0\0\0\0\0\x79\x63\x80\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
+\0\0\xf0\x18\0\0\xb7\x02\0\0\x0c\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\
+\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\
+\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\
+\x19\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x19\0\0\x18\x61\0\0\
+\0\0\0\0\0\0\0\0\x10\x19\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
+\xf0\x18\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x19\0\0\x7b\x01\0\0\0\0\0\0\xb7\
+\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x08\x19\0\0\xb7\x03\0\0\x20\0\0\
+\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xef\xfe\0\0\0\0\x18\x62\0\0\
+\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\
+\x19\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
+\x28\x19\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\
+\x07\xe2\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x19\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\x38\x22\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x38\x19\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x22\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
+\0\0\0\0\0\0\0\x10\x1f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x22\0\0\x7b\x01\0\0\
+\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\x1f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x88\x22\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x28\x22\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\xa8\x22\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x22\0\0\x7b\x01\0\0\0\0\0\0\x61\
+\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x40\x22\0\0\x63\x01\0\0\0\0\0\0\
+\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x44\x22\0\0\x63\x01\0\0\0\0\
+\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x22\0\0\x7b\x01\0\0\
+\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x22\0\0\x63\
+\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x22\0\0\xb7\x02\0\0\x12\0\0\0\
+\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\
+\0\0\xc5\x07\xac\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x28\x22\0\0\x63\x70\
+\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\
+\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x28\x22\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\
+\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x98\x22\0\0\x61\x01\0\0\
+\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\
+\x9a\xfe\0\0\0\0\x63\x7a\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x22\0\
+\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x23\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\
+\0\0\0\0\0\0\xd8\x22\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x23\0\0\x7b\x01\0\0\0\
+\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x22\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\
+\x23\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf0\x22\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x60\x23\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
+\0\x23\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x23\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x23\0\0\x7b\x01\0\
+\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x23\0\0\x63\
+\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\x23\0\0\
+\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x23\
+\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x48\x23\0\0\x63\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x23\0\0\xb7\
+\x02\0\0\x17\0\0\0\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\
+\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x63\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\
+\x23\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\
+\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x23\0\0\xb7\x03\0\0\x8c\0\0\0\
+\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x23\0\
+\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\
+\0\0\0\xc5\x07\x51\xfe\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\
+\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\
+\0\0\0\0\x63\x06\x88\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x8c\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x28\0\0\0\0\
+\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x38\0\0\0\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x48\0\0\
+\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x58\0\
+\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x68\
+\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\
+\x78\0\0\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
+
+	opts.ctx = (struct bpf_loader_ctx *)skel;
+	opts.data_sz = sizeof(opts_data) - 1;
+	opts.data = (void *)opts_data;
+	opts.insns_sz = sizeof(opts_insn) - 1;
+	opts.insns = (void *)opts_insn;
+
+	err = bpf_load_and_run(&opts);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static inline struct kexec_pe_parser_bpf *
+kexec_pe_parser_bpf__open_and_load(void)
+{
+	struct kexec_pe_parser_bpf *skel;
+
+	skel = kexec_pe_parser_bpf__open();
+	if (!skel)
+		return NULL;
+	if (kexec_pe_parser_bpf__load(skel)) {
+		kexec_pe_parser_bpf__destroy(skel);
+		return NULL;
+	}
+	return skel;
+}
+
+__attribute__((unused)) static void
+kexec_pe_parser_bpf__assert(struct kexec_pe_parser_bpf *s __attribute__((unused)))
+{
+#ifdef __cplusplus
+#define _Static_assert static_assert
+#endif
+#ifdef __cplusplus
+#undef _Static_assert
+#endif
+}
+
+#endif /* __KEXEC_PE_PARSER_BPF_SKEL_H__ */
-- 
2.47.0


