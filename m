Return-Path: <bpf+bounces-65942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B321B2B5EC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B3B171B1F
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0611DF246;
	Tue, 19 Aug 2025 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TY9fkZQb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F691DF258
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566783; cv=none; b=Ah8VAHBv+611wJW8QC/Y5CczajPGrcDUBUKTIkAq5zreG4Kh6ZF+zSMSpQBT6Zz51F2pt81JZavUlrmTnJq47ixD9FWnrbMdgCXiElVWp/Te0JgRx8As6DYyShZjWDkQlXqMTHK5ujQe1ogFYH1zZa7pRu/Rj48nLD9UZrHrwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566783; c=relaxed/simple;
	bh=V5qaYdZAtg46eixWZCAmFtEInEj+Ah1iNrOMuBMBD1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJOAQNrMyftiUUjPwVl/4rrNe3/RHG8JqJRINuLxmB1Pyj4i2shMT4tFc9HNwgU4Wn0LbOw/Y79DNaDgUm9W6rWMPPANGjgYH8Lg3n9KaA0Q1mBnz3Lh7m5ZbYbjX2b9mYOPLkP6d2Zu/HvuoNndxctg4toAVlpkuLYVoP/3GSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TY9fkZQb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0mOweFi8gmLinsVzag5ZgtjsXqxff4FjkxK4lazklo=;
	b=TY9fkZQb0K4FCy1jVS8CopZj+Cr/fBb10TnVdxqPXwK0NaLNZh+vMiOLOiTH9W/GfOVUUW
	TyHs14M9MAz3rngPCS6jCEXH5vw+ezaPD0KJb8XABtR7XU9TIHkndQq5Qt9LJdD3jmqveo
	TXtCLjJT01tDL2uQjho0vw2lXViIgZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-5ru45UBFNIG2WCaY5Nj0gA-1; Mon,
 18 Aug 2025 21:26:12 -0400
X-MC-Unique: 5ru45UBFNIG2WCaY5Nj0gA-1
X-Mimecast-MFC-AGG-ID: 5ru45UBFNIG2WCaY5Nj0gA_1755566770
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B46219775AD;
	Tue, 19 Aug 2025 01:26:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3312180028A;
	Tue, 19 Aug 2025 01:25:58 +0000 (UTC)
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
Subject: [PATCHv5 05/12] kexec: Introduce kexec_pe_image to parse and load PE file
Date: Tue, 19 Aug 2025 09:24:21 +0800
Message-ID: <20250819012428.6217-6-piliu@redhat.com>
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

As UEFI becomes popular, a few architectures support to boot a PE format
kernel image directly. But the internal of PE format varies, which means
each parser for each format.

This patch (with the rest in this series) introduces a common skeleton
to all parsers, and leave the format parsing in
bpf-prog, so the kernel code can keep relative stable.

A new kexec_file_ops is implementation, named pe_image_ops.

There are some place holder function in this patch. (They will take
effect after the introduction of kexec bpf light skeleton and bpf
helpers). Overall the parsing progress is a pipeline, the current
bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
end of the current stage 'disarm_bpf_prog()' the current parsed result
by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
, and deliver to the next stage.  For each stage, the bpf bytecode is
extracted from the '.bpf' section in the PE file.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h   |   1 +
 kernel/Kconfig.kexec    |   9 ++
 kernel/Makefile         |   1 +
 kernel/kexec_pe_image.c | 348 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+)
 create mode 100644 kernel/kexec_pe_image.c

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7bd7f8a25dd59..8f7322c932fb5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -444,6 +444,7 @@ static inline int machine_kexec_post_load(struct kimage *image) { return 0; }
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern const struct kexec_file_ops pe_image_ops;
 
 bool kexec_load_permitted(int kexec_image_type);
 
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 2ee603a98813e..ee87241c944e0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -46,6 +46,15 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by kexec system call.
 
+config KEXEC_PE_IMAGE
+	bool "Enable parsing UEFI PE file through kexec file based system call"
+	select KEEP_DECOMPRESSOR
+	depends on KEXEC_FILE
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	help
+	  This option makes the kexec_file_load() syscall cooperates with bpf-prog
+	  to parse PE format file
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on ARCH_SUPPORTS_KEXEC_SIG
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235f..cb2121d65a289 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
+obj-$(CONFIG_KEXEC_PE_IMAGE) += kexec_pe_image.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
new file mode 100644
index 0000000000000..b0cf9942e68d2
--- /dev/null
+++ b/kernel/kexec_pe_image.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kexec PE image loader
+
+ * Copyright (C) 2025 Red Hat, Inc
+ */
+
+#define pr_fmt(fmt)	"kexec_file(Image): " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/pe.h>
+#include <linux/string.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <asm/byteorder.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+
+
+#define KEXEC_RES_KERNEL_NAME "kexec:kernel"
+#define KEXEC_RES_INITRD_NAME "kexec:initrd"
+#define KEXEC_RES_CMDLINE_NAME "kexec:cmdline"
+
+struct kexec_res {
+	char *name;
+	/* The free of buffer is deferred to kimage_file_post_load_cleanup */
+	struct mem_range_result *r;
+};
+
+static struct kexec_res parsed_resource[3] = {
+	{ KEXEC_RES_KERNEL_NAME, },
+	{ KEXEC_RES_INITRD_NAME, },
+	{ KEXEC_RES_CMDLINE_NAME, },
+};
+
+static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
+
+static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
+{
+	struct mz_hdr *mz;
+	struct pe_hdr *pe;
+
+	if (!kernel_buf)
+		return false;
+	mz = (struct mz_hdr *)kernel_buf;
+	if (mz->magic != IMAGE_DOS_SIGNATURE)
+		return false;
+	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
+	if (pe->magic != IMAGE_NT_SIGNATURE)
+		return false;
+	if (pe->opt_hdr_size == 0) {
+		pr_err("optional header is missing\n");
+		return false;
+	}
+
+	return pe_has_bpf_section(kernel_buf, kernel_len);
+}
+
+static bool is_valid_format(const char *kernel_buf, unsigned long kernel_len)
+{
+	return is_valid_pe(kernel_buf, kernel_len);
+}
+
+/*
+ * The UEFI Terse Executable (TE) image has MZ header.
+ */
+static int pe_image_probe(const char *kernel_buf, unsigned long kernel_len)
+{
+	return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;
+}
+
+static int pe_get_section(const char *file_buf, const char *sect_name,
+		char **sect_start, unsigned long *sect_sz)
+{
+	struct pe_hdr *pe_hdr;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct section_header *sect_hdr;
+	int section_nr, i;
+	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
+
+	*sect_start = NULL;
+	*sect_sz = 0;
+	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
+	section_nr = pe_hdr->sections;
+	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
+
+	for (i = 0; i < section_nr; i++) {
+		if (strcmp(sect_hdr->name, sect_name) == 0) {
+			*sect_start = (char *)file_buf + sect_hdr->data_addr;
+			*sect_sz = sect_hdr->raw_data_size;
+			return 0;
+		}
+		sect_hdr++;
+	}
+
+	return -1;
+}
+
+static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
+{
+	char *sect_start = NULL;
+	unsigned long sect_sz = 0;
+	int ret;
+
+	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
+	if (ret < 0)
+		return false;
+	return true;
+}
+
+/* Load a ELF */
+static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
+{
+	return 0;
+}
+
+static void disarm_bpf_prog(void)
+{
+}
+
+struct kexec_context {
+	bool kdump;
+	char *image;
+	int image_sz;
+	char *initrd;
+	int initrd_sz;
+	char *cmdline;
+	int cmdline_sz;
+};
+
+void bpf_handle_pefile(struct kexec_context *context);
+void bpf_post_handle_pefile(struct kexec_context *context);
+
+
+/*
+ * optimize("O0") prevents inline, compiler constant propagation
+ */
+__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struct kexec_context *context)
+{
+	/*
+	 * To prevent linker from Identical Code Folding (ICF) with bpf_handle_pefile,
+	 * making them have different code.
+	 */
+	volatile int dummy = 0;
+
+	dummy += 1;
+}
+
+__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_context *context)
+{
+	volatile int dummy = 0;
+
+	dummy += 2;
+}
+
+/*
+ * PE file may be nested and should be unfold one by one.
+ * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
+ * next phase.
+ */
+static int prepare_nested_pe(char **kernel, unsigned long *kernel_len, char **initrd,
+		unsigned long *initrd_len, char **cmdline)
+{
+	struct kexec_res *res;
+	int ret = -1;
+
+	*kernel = NULL;
+	*kernel_len = 0;
+
+	res = &parsed_resource[0];
+	if (!!res->r) {
+		*kernel = res->r->buf;
+		*kernel_len = res->r->data_sz;
+		ret = 0;
+	}
+
+	res = &parsed_resource[1];
+	if (!!res->r) {
+		*initrd = res->r->buf;
+		*initrd_len = res->r->data_sz;
+	}
+
+	res = &parsed_resource[2];
+	if (!!res->r) {
+		*cmdline = res->r->buf;
+	}
+
+	return ret;
+}
+
+static void *pe_image_load(struct kimage *image,
+				char *kernel, unsigned long kernel_len,
+				char *initrd, unsigned long initrd_len,
+				char *cmdline, unsigned long cmdline_len)
+{
+	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
+	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
+	struct kexec_res *res;
+	struct mem_range_result *r;
+	void *ldata;
+	int ret;
+
+	linux_start = kernel;
+	linux_sz = kernel_len;
+	initrd_start = initrd;
+	initrd_sz = initrd_len;
+	cmdline_start = cmdline;
+	cmdline_sz = cmdline_len;
+
+	while (is_valid_format(linux_start, linux_sz) &&
+	       pe_has_bpf_section(linux_start, linux_sz)) {
+		struct kexec_context context;
+
+		pe_get_section((const char *)linux_start, ".bpf", &bpf_start, &bpf_sz);
+		if (!!bpf_sz) {
+			/* load and attach bpf-prog */
+			ret = arm_bpf_prog(bpf_start, bpf_sz);
+			if (ret) {
+				pr_err("Fail to load .bpf section\n");
+				ldata = ERR_PTR(ret);
+				goto err;
+			}
+		}
+		if (image->type != KEXEC_TYPE_CRASH)
+			context.kdump = false;
+		else
+			context.kdump = true;
+		context.image = linux_start;
+		context.image_sz = linux_sz;
+		context.initrd = initrd_start;
+		context.initrd_sz = initrd_sz;
+		context.cmdline = cmdline_start;
+		context.cmdline_sz = strlen(cmdline_start);
+		/* bpf-prog fentry, which handle above buffers. */
+		bpf_handle_pefile(&context);
+
+		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
+					&initrd_sz, &cmdline_start);
+		/* bpf-prog fentry */
+		bpf_post_handle_pefile(&context);
+		/*
+		 * detach the current bpf-prog from their attachment points.
+		 */
+		disarm_bpf_prog();
+	}
+
+	/*
+	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
+	 * be updated to the new content.
+	 */
+
+	res = &parsed_resource[0];
+	/* Kernel part should always be parsed */
+	if (!res->r) {
+		pr_err("Can not parse kernel\n");
+		ldata = ERR_PTR(-EINVAL);
+		goto err;
+	}
+	kernel = res->r->buf;
+	kernel_len = res->r->data_sz;
+	vfree(image->kernel_buf);
+	image->kernel_buf = kernel;
+	image->kernel_buf_len = kernel_len;
+
+	res = &parsed_resource[1];
+	if (!!res->r) {
+		initrd = res->r->buf;
+		initrd_len = res->r->data_sz;
+		vfree(image->initrd_buf);
+		image->initrd_buf = initrd;
+		image->initrd_buf_len = initrd_len;
+	}
+	res = &parsed_resource[2];
+	if (!!res->r) {
+		cmdline = res->r->buf;
+		cmdline_len = res->r->data_sz;
+		kfree(image->cmdline_buf);
+		image->cmdline_buf = cmdline;
+		image->cmdline_buf_len = cmdline_len;
+	}
+
+	if (kernel == NULL || initrd == NULL || cmdline == NULL) {
+		char *c, buf[64];
+
+		c = buf;
+		if (kernel == NULL) {
+			strcpy(c, "kernel ");
+			c += strlen("kernel ");
+		}
+		if (initrd == NULL) {
+			strcpy(c, "initrd ");
+			c += strlen("initrd ");
+		}
+		if (cmdline == NULL) {
+			strcpy(c, "cmdline ");
+			c += strlen("cmdline ");
+		}
+		c = '\0';
+		pr_err("Can not extract data for %s", buf);
+		ldata = ERR_PTR(-EINVAL);
+		goto err;
+	}
+
+	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
+					    image->kernel_buf_len);
+	if (ret) {
+		pr_err("Fail to find suitable image loader\n");
+		ldata = ERR_PTR(ret);
+		goto err;
+	}
+	ldata = kexec_image_load_default(image);
+	if (IS_ERR(ldata)) {
+		pr_err("architecture code fails to load image\n");
+		goto err;
+	}
+	image->image_loader_data = ldata;
+
+err:
+	for (int i = 0; i < 3; i++) {
+		r = parsed_resource[i].r;
+		if (!r)
+			continue;
+		parsed_resource[i].r = NULL;
+		/*
+		 * The release of buffer defers to
+		 * kimage_file_post_load_cleanup()
+		 */
+		r->buf = NULL;
+		r->buf_sz = 0;
+		mem_range_result_put(r);
+	}
+
+	return ldata;
+}
+
+const struct kexec_file_ops kexec_pe_image_ops = {
+	.probe = pe_image_probe,
+	.load = pe_image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = kexec_kernel_verify_pe_sig,
+#endif
+};
-- 
2.49.0


