Return-Path: <bpf+bounces-59268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B244BAC7718
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D041C02159
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781D250C18;
	Thu, 29 May 2025 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx613NX9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200424E4B4
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492414; cv=none; b=jcqCN0bOHlMvkaULZNU6gZZStW3EorMFTb04W/IUZ06hqmHEvbopLUTVCXUb9q6CaeY0KJCkQBQesPTiUT9a3QGYJye1abTT5/ScQ65d4aAtKbxDgkcKiFvv8IV9VBRb7P5z+eYKXqOus7WD4q+PSZ2KeTRkrzXlfbafYdCDW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492414; c=relaxed/simple;
	bh=nDewNwU2tjg8+q4z82kItFxC8nF8lxmflNKwDSc+Rsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQzDj9oU33k0QwbQcGDMTjGQ2ejlRmbOw8ysl3SdQ/w13LE2vux6BDKVr9rTHvESu+gbNDPL/gQeFOweAzMw7HeQH/5jOJa5DqZSqfFc/p/f61tFr98eKaihe+3cs0TBsYcggl9htpX2h2ADKRB1vITbJtWce/9B6ykIxURh02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yx613NX9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o01mCaWwHM/y8xT3IMVLUrSVxAs8uhG2GK992cWJkus=;
	b=Yx613NX9hV+Ga2rIqW/dfVfsXO3u9vCCbHQFHHNppLDvjOj2h8V/cJtZXyFKGmQBZYgzlo
	+v+mj7g09YGFPUZGoudvrdwFNJQl41acBzVYTQYx6I+gMpmeTCyPs+3FBnP1MPK4uuhv8V
	vbDvwkGbUzP7NI0rExZtVhcxWJ4q9QQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-wxmbN7hHNIGACD9N3Ekr3A-1; Thu,
 29 May 2025 00:20:05 -0400
X-MC-Unique: wxmbN7hHNIGACD9N3Ekr3A-1
X-Mimecast-MFC-AGG-ID: wxmbN7hHNIGACD9N3Ekr3A_1748492403
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE474195608B;
	Thu, 29 May 2025 04:20:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5FBF18003FC;
	Thu, 29 May 2025 04:19:51 +0000 (UTC)
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
	bpf@vger.kernel.org
Subject: [PATCHv3 7/9] kexec: Introduce a bpf-prog lskel to parse PE file
Date: Thu, 29 May 2025 12:17:42 +0800
Message-ID: <20250529041744.16458-8-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Analague to kernel/bpf/preload/iterators/Makefile,
this Makefile is not invoked by the Kbuild system. It needs to be
invoked manually when kexec_pe_parser_bpf.c is changed so that
kexec_pe_parser_bpf.lskel.h can be re-generated by the command "bpftool
gen skeleton -L kexec_pe_parser_bpf.o".

kexec_pe_parser_bpf.lskel.h is used directly by the kernel kexec code in
later patch. For this patch, there are bpf bytecode contained in
opts_data[] and opts_insn[] in kexec_pe_parser_bpf.lskel.h, but in the
following patch, they will be removed and only the function API in
kexec_pe_parser_bpf.lskel.h left.

As exposed in kexec_pe_parser_bpf.lskel.h, the interface between
bpf-prog and the kernel are constituted by:

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

They are fixed and provided for all kinds of bpf-prog which interacts
with the kexec kernel component.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/kexec_bpf/Makefile                    |  57 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  65 +++
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 431 +++++++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 kernel/kexec_bpf/Makefile
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
 create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h

diff --git a/kernel/kexec_bpf/Makefile b/kernel/kexec_bpf/Makefile
new file mode 100644
index 0000000000000..b772e78464f48
--- /dev/null
+++ b/kernel/kexec_bpf/Makefile
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+OUTPUT := .output
+CLANG ?= clang
+LLC ?= llc
+LLVM_STRIP ?= llvm-strip
+DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+LIBBPF_SRC := $(abspath ../../tools/lib/bpf)
+BPFOBJ := $(OUTPUT)/libbpf.a
+BPF_INCLUDE := $(OUTPUT)
+INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../tools/lib)        \
+       -I$(abspath ../../tools/include/uapi)
+CFLAGS := -g -Wall
+
+abs_out := $(abspath $(OUTPUT))
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3))";
+MAKEFLAGS += --no-print-directory
+submake_extras := feature_display=0
+endif
+
+.DELETE_ON_ERROR:
+
+.PHONY: all clean
+
+all: kexec_pe_parser_bpf.lskel.h
+
+clean:
+	$(call msg,CLEAN)
+	$(Q)rm -rf $(OUTPUT) kexec_pe_parser_bpf.lskel.h
+
+kexec_pe_parser_bpf.lskel.h: $(OUTPUT)/kexec_pe_parser_bpf.o | $(BPFTOOL)
+	$(call msg,GEN-SKEL,$@)
+	$(Q)$(BPFTOOL) gen skeleton -L $< > $@
+
+
+$(OUTPUT)/kexec_pe_parser_bpf.o: kexec_pe_parser_bpf.c $(BPFOBJ) | $(OUTPUT)
+	$(call msg,BPF,$@)
+	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
+		 -c $(filter %.c,$^) -o $@ &&				      \
+	$(LLVM_STRIP) -g $@
+
+$(OUTPUT):
+	$(call msg,MKDIR,$@)
+	$(Q)mkdir -p $(OUTPUT)
+
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
+		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
+
+$(DEFAULT_BPFTOOL):
+	$(Q)$(MAKE) $(submake_extras) -C ../../tools/bpf/bpftool			      \
+		    prefix= OUTPUT=$(abs_out)/ DESTDIR=$(abs_out) install
diff --git a/kernel/kexec_bpf/kexec_pe_parser_bpf.c b/kernel/kexec_bpf/kexec_pe_parser_bpf.c
new file mode 100644
index 0000000000000..ef2608c932aa5
--- /dev/null
+++ b/kernel/kexec_bpf/kexec_pe_parser_bpf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+
+/* 1GB =  1^28 * sizeof(__uint) */
+#define MAX_BUF_SIZE	(1 << 30)
+/* 512MB is big enough to hold either kernel or initramfs */
+#define MAX_RECORD_SIZE	(1 << 28)
+
+#define KEXEC_RES_KERNEL_NAME "kernel"
+#define KEXEC_RES_INITRD_NAME "initrd"
+#define KEXEC_RES_CMDLINE_NAME "cmdline"
+
+/* ringbuf is safe since the user space has no write access to them */
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MAX_BUF_SIZE >> 2);
+} ringbuf_1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MAX_BUF_SIZE >> 2);
+} ringbuf_2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MAX_BUF_SIZE >> 2);
+} ringbuf_3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, MAX_BUF_SIZE >> 2);
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
+SEC("fentry.s/bpf_handle_pefile")
+__attribute__((used)) int BPF_PROG(parse_pe, struct kexec_context *context)
+{
+	return 0;
+}
+
+SEC("fentry.s/bpf_post_handle_pefile")
+__attribute__((used)) int BPF_PROG(post_parse_pe, struct kexec_context *context)
+{
+	return 0;
+}
diff --git a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
new file mode 100644
index 0000000000000..5fc3609d3ad50
--- /dev/null
+++ b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
@@ -0,0 +1,431 @@
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
+		struct bpf_map_desc rodata;
+		struct bpf_map_desc data;
+		struct bpf_map_desc bss;
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
+	skel_closenz(skel->maps.rodata.map_fd);
+	skel_closenz(skel->maps.data.map_fd);
+	skel_closenz(skel->maps.bss.map_fd);
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
+\x18\0\0\0\0\0\0\0\x04\x03\0\0\x04\x03\0\0\x95\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
+\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
+\0\0\x04\0\0\0\x1b\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
+\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\0\0\x10\0\0\0\0\
+\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\
+\0\x2a\0\0\0\0\0\0\x0e\x07\0\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\
+\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x34\0\0\0\0\0\0\x0e\x09\0\
+\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\
+\0\0\x05\0\0\0\x40\0\0\0\x3e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\x02\0\
+\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x48\
+\0\0\0\0\0\0\x0e\x0d\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x0d\x02\0\0\0\x52\0\0\0\0\0\
+\0\x0c\x0f\0\0\0\0\0\0\0\0\0\0\x02\x12\0\0\0\x2d\x01\0\0\0\0\0\x01\x08\0\0\0\
+\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x40\x01\0\0\x11\0\0\0\x44\x01\0\0\x01\
+\0\0\x0c\x13\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x40\x01\0\0\x11\0\0\0\xb4\x01\
+\0\0\x01\0\0\x0c\x15\0\0\0\x33\x02\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\0\0\0\
+\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\x38\x02\0\0\0\0\0\x0e\x18\0\0\
+\0\x01\0\0\0\0\0\0\0\0\0\0\x0a\x17\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x1a\0\0\0\
+\x04\0\0\0\x10\0\0\0\x40\x02\0\0\0\0\0\x0e\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\
+\0\0\0\0\x17\0\0\0\x04\0\0\0\x10\0\0\0\x51\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\
+\x62\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\
+\x04\0\0\0\x07\0\0\0\x74\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1f\0\0\0\0\0\0\0\x10\0\
+\0\0\x79\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1e\0\0\0\0\0\0\0\x10\0\0\0\x7f\x02\0\0\
+\x04\0\0\x0f\x40\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\x0a\0\0\0\x10\0\0\0\x10\0\0\
+\0\x0c\0\0\0\x20\0\0\0\x10\0\0\0\x0e\0\0\0\x30\0\0\0\x10\0\0\0\x85\x02\0\0\x01\
+\0\0\x0f\x10\0\0\0\x1c\0\0\0\0\0\0\0\x10\0\0\0\x8d\x02\0\0\x01\0\0\x0f\x04\0\0\
+\0\x19\0\0\0\0\0\0\0\x04\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\
+\x53\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\
+\x5f\x65\x6e\x74\x72\x69\x65\x73\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\x72\
+\x69\x6e\x67\x62\x75\x66\x5f\x32\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\x72\
+\x69\x6e\x67\x62\x75\x66\x5f\x34\0\x64\x75\x6d\x6d\x79\0\x2e\x74\x65\x78\x74\0\
+\x2f\x68\x6f\x6d\x65\x2f\x6c\x69\x6e\x75\x78\x2f\x6b\x65\x72\x6e\x65\x6c\x2f\
+\x6b\x65\x78\x65\x63\x5f\x62\x70\x66\x2f\x6b\x65\x78\x65\x63\x5f\x70\x65\x5f\
+\x70\x61\x72\x73\x65\x72\x5f\x62\x70\x66\x2e\x63\0\x5f\x5f\x61\x74\x74\x72\x69\
+\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\x20\x73\x74\x61\x74\
+\x69\x63\x20\x69\x6e\x74\x20\x64\x75\x6d\x6d\x79\x28\x76\x6f\x69\x64\x29\0\x09\
+\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\x6d\x63\x70\x79\x28\x6c\x6f\
+\x63\x61\x6c\x5f\x6e\x61\x6d\x65\x2c\x20\x4b\x45\x58\x45\x43\x5f\x52\x45\x53\
+\x5f\x49\x4e\x49\x54\x52\x44\x5f\x4e\x41\x4d\x45\x2c\x20\x31\x36\x29\x3b\0\x09\
+\x72\x65\x74\x75\x72\x6e\x20\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\
+\x6d\x63\x6d\x70\x28\x6c\x6f\x63\x61\x6c\x5f\x6e\x61\x6d\x65\x2c\x20\x72\x65\
+\x73\x5f\x6b\x65\x72\x6e\x65\x6c\x2c\x20\x34\x29\x3b\0\x75\x6e\x73\x69\x67\x6e\
+\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\0\x63\x74\x78\0\x70\x61\x72\
+\x73\x65\x5f\x70\x65\0\x66\x65\x6e\x74\x72\x79\x2e\x73\x2f\x62\x70\x66\x5f\x68\
+\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x5f\x5f\x61\x74\x74\x72\x69\
+\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\x20\x69\x6e\x74\x20\
+\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\x20\
+\x73\x74\x72\x75\x63\x74\x20\x6b\x65\x78\x65\x63\x5f\x63\x6f\x6e\x74\x65\x78\
+\x74\x20\x2a\x63\x6f\x6e\x74\x65\x78\x74\x29\0\x70\x6f\x73\x74\x5f\x70\x61\x72\
+\x73\x65\x5f\x70\x65\0\x66\x65\x6e\x74\x72\x79\x2e\x73\x2f\x62\x70\x66\x5f\x70\
+\x6f\x73\x74\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x5f\x5f\
+\x61\x74\x74\x72\x69\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\
+\x20\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x6f\x73\x74\x5f\
+\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x6b\x65\
+\x78\x65\x63\x5f\x63\x6f\x6e\x74\x65\x78\x74\x20\x2a\x63\x6f\x6e\x74\x65\x78\
+\x74\x29\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x64\x75\x6d\x6d\x79\
+\x2e\x72\x65\x73\x5f\x6b\x65\x72\x6e\x65\x6c\0\x64\x75\x6d\x6d\x79\x2e\x6c\x6f\
+\x63\x61\x6c\x5f\x6e\x61\x6d\x65\0\x64\x75\x6d\x6d\x79\x2e\x72\x65\x73\x5f\x63\
+\x6d\x64\x6c\x69\x6e\x65\0\x2e\x62\x73\x73\0\x2e\x64\x61\x74\x61\0\x2e\x6d\x61\
+\x70\x73\0\x2e\x72\x6f\x64\x61\x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb1\x05\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\
+\x75\x66\x5f\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\
+\x6e\x67\x62\x75\x66\x5f\x32\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\
+\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\
+\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x34\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\
+\0\x80\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x72\x6f\x64\
+\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\x24\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\
+\x65\x72\x6e\x65\x6c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\
+\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\
+\x2e\x64\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x22\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\x63\x6d\x64\x6c\x69\x6e\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\
+\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\
+\x62\x73\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x21\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x07\0\0\0\x01\0\0\0\x80\
+\0\0\0\0\0\0\0\0\0\0\0\x2e\x72\x6f\x64\x61\x74\x61\x2e\x73\x74\x72\x31\x2e\x31\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x69\x6e\x69\x74\
+\x72\x64\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\xb4\0\0\0\0\0\0\0\x95\0\0\
+\0\0\0\0\0\0\0\0\0\x14\0\0\0\0\0\0\0\x5e\0\0\0\x68\x01\0\0\x1b\xe0\0\0\x1a\0\0\
+\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\x10\0\0\0\x70\x61\x72\x73\x65\x5f\x70\x65\0\0\0\0\0\0\0\0\0\0\0\0\x18\0\
+\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\
+\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\
+\0\0\x62\x70\x66\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\0\0\
+\0\0\0\0\x47\x50\x4c\0\0\0\0\0\xb4\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x16\
+\0\0\0\0\0\0\0\x5e\0\0\0\xe2\x01\0\0\x1b\xf8\0\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x70\
+\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\
+\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x01\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x62\
+\x70\x66\x5f\x70\x6f\x73\x74\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\
+\x6c\x65\0\0";
+	static const char opts_insn[] __attribute__((__aligned__(8))) = "\
+\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
+\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x41\0\0\0\0\0\x61\
+\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
+\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
+\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x84\xff\0\0\0\0\xd5\x01\x01\0\0\
+\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x88\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\
+\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\
+\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\
+\0\0\x04\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\
+\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x01\0\0\0\0\0\0\
+\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\
+\0\0\0\0\0\0\x0c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\
+\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x01\0\0\0\
+\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\
+\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\
+\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x01\
+\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\
+\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\
+\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0a\0\0\x63\x01\0\0\0\0\
+\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xcc\x0a\0\0\x63\x01\0\0\
+\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc0\x0a\0\0\x7b\x01\
+\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\xb8\x0a\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\
+\0\0\xb8\x0a\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
+\xc5\x07\xa7\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\
+\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe4\x0a\0\0\x63\x01\0\0\0\0\0\0\xb7\
+\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xd8\x0a\0\0\xb7\x03\0\0\x48\0\0\0\
+\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x9a\xff\0\0\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x2c\0\0\0\0\0\x15\0\x03\0\0\
+\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x2c\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
+\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x20\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\
+\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x8b\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
+\0\0\0\x04\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x3c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x74\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
+\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x68\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
+\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x7c\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x08\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x4c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\xbc\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\
+\x18\x62\0\0\0\0\0\0\0\0\0\0\xb0\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\
+\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x6d\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x0c\0\0\0\x63\x71\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
+\0\0\x28\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x5c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
+\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xf8\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
+\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x5a\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x10\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x60\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\
+\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\
+\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\x58\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x50\
+\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
+\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x68\x0c\0\0\x7b\x01\
+\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x58\x0c\0\0\xb7\
+\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x36\xff\0\0\
+\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\
+\0\0\0\0\0\0\x78\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\
+\0\0\0\0\0\0\0\0\x78\x0c\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
+\0\0\0\0\0\0\xc5\x07\x29\xff\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\xb0\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x6c\0\0\0\0\0\x15\0\x03\0\0\
+\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x8c\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
+\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x0c\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\
+\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x19\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
+\0\0\0\x14\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x70\0\0\0\0\0\x15\x03\x08\0\0\0\0\
+\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\
+\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\
+\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\
+\0\0\0\0\0\0\0\0\0\0\xe0\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\
+\0\xd8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe8\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf0\x0c\0\0\
+\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xe0\x0c\
+\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xf5\
+\xfe\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0d\0\0\
+\x63\x01\0\0\0\0\0\0\x61\x60\x7c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\
+\0\0\0\0\0\0\x0c\x0d\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\
+\0\0\0\0\0\0\0\0\x0d\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\
+\0\0\0\0\xc5\x07\xe5\xfe\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x63\x71\
+\0\0\0\0\0\0\x79\x63\x80\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
+\0\0\0\x48\x0d\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\
+\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\
+\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\
+\x0d\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x58\x0d\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x68\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
+\x48\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0d\0\0\x7b\x01\0\0\0\0\0\0\xb7\
+\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x60\x0d\0\0\xb7\x03\0\0\x20\0\0\
+\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xc1\xfe\0\0\0\0\x61\x60\x8c\
+\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x8c\x0d\0\0\x63\x01\
+\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x0d\0\0\xb7\
+\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xb5\xfe\0\0\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x90\0\0\
+\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0d\0\0\xb7\x02\0\
+\0\x07\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\
+\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\
+\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd8\x0d\0\0\x63\x01\0\0\0\0\0\
+\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0d\
+\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xc8\x0d\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\xe8\x0d\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\
+\0\0\0\0\0\0\0\0\0\xd8\x0d\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\
+\x07\0\0\0\0\0\0\xc5\x07\x91\xfe\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\
+\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\x0d\0\0\x63\x01\0\0\0\0\0\
+\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xf8\x0d\0\0\xb7\x03\0\0\
+\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x84\xfe\0\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x40\x0e\0\0\x7b\
+\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\x0e\0\0\x18\x61\0\0\0\0\0\0\0\
+\0\0\0\x38\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\x0e\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\
+\0\0\0\0\0\x20\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x0e\0\0\x7b\x01\0\0\0\0\
+\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb0\
+\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\xa8\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x48\x0e\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x4c\x0e\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\
+\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x0e\0\0\x63\x01\0\0\0\0\0\0\x18\x61\0\0\
+\0\0\0\0\0\0\0\0\xc0\x0e\0\0\xb7\x02\0\0\x12\0\0\0\xb7\x03\0\0\x0c\0\0\0\xb7\
+\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x4e\xfe\0\0\0\
+\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\0\0\
+\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\0\0\
+\0\0\x30\x0e\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
+\x18\x60\0\0\0\0\0\0\0\0\0\0\xa0\x0e\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\
+\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x3c\xfe\0\0\0\0\x63\x7a\
+\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x0e\0\0\x18\x61\0\0\0\0\0\0\0\
+\0\0\0\x18\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe0\x0e\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\
+\0\0\0\0\0\xf0\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x58\x0f\0\0\x7b\x01\0\0\0\0\
+\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf8\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x68\
+\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x88\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0f\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\
+\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x0f\0\0\x63\x01\0\0\0\0\0\0\x61\
+\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x24\x0f\0\0\x63\x01\0\0\0\0\0\0\
+\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\x7b\x01\0\0\0\0\
+\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\x0f\0\0\x63\x01\0\
+\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0f\0\0\xb7\x02\0\0\x17\0\0\0\xb7\
+\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\
+\xc5\x07\x05\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x63\x70\x6c\0\
+\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\
+\x62\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\
+\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x78\x0f\0\0\x61\x01\0\0\0\0\0\
+\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\xf3\
+\xfd\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\
+\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\
+\x98\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x9c\0\0\0\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\x04\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x28\0\0\0\0\0\x18\x61\0\0\0\0\
+\0\0\0\0\0\0\x08\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x38\0\0\0\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\x0c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x48\0\0\0\0\0\x18\x61\0\0\
+\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x58\0\0\0\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x68\0\0\0\0\0\x18\x61\
+\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x78\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x88\0\0\0\0\0\
+\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
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
2.49.0


