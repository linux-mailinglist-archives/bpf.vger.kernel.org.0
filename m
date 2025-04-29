Return-Path: <bpf+bounces-56892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D022AAA014D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0E16CB92
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138027057D;
	Tue, 29 Apr 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpMC+0SV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97D253F3F
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899996; cv=none; b=dhFXhXtaWzMgQQoFpxtl/ANKy8AETqRs0pdFjIlq2zeT6d+kxnrWtOi/g6jjibfroKOGyPdctIhfJZy378DEWU+9mKbXNElm0LVTdmoS4zWtIxi83yVRkrYEn2W87mBElnIOA2CaMi7RxEmgXD9Spib6Vxl2IPRU6Jhmb2yROhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899996; c=relaxed/simple;
	bh=T0XBjp0W23sf/GfWoou/QjtfpTXs49OU8nnwawEbWLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6yZ3s/HPWxGViC0dmt36QhV+8m7cU1jD63nkpqqGRurkzrmq5OTajselBSmJEXlD80z/CwPyHWcs/OJ5Fzkdv4PpJ1u5t+J/Sktf0E6m/gXO66PJ+1flBNmDTGWjGYBPSsSu6sLBgZif0Ywja36ERzbqMPUkVCo7MfUP8p25Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpMC+0SV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745899993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YifFRMqBQ6DjHTpDdZ79PYDFDUEho0+XQI5OcjTTSLs=;
	b=DpMC+0SVXkzK+z2fJf1ksJ8sWP5Zg8vtG8a7oy0GbhlVppbJiEdW0IOIL7v2J4Iryhp1Fi
	35tXJ/5t8+VqsiDuc75KObWIxj64wxHMraAcwxl2vPQhQxX9BUJ4Xn5oUO6xdTV6Hh05NH
	815VxV4tTDRiAYiHVecgqoVR7FwCVg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-avPBMDD3OZO-6d2CZLyQeQ-1; Tue,
 29 Apr 2025 00:13:08 -0400
X-MC-Unique: avPBMDD3OZO-6d2CZLyQeQ-1
X-Mimecast-MFC-AGG-ID: avPBMDD3OZO-6d2CZLyQeQ_1745899986
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 629281956095;
	Tue, 29 Apr 2025 04:13:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 490201800352;
	Tue, 29 Apr 2025 04:12:52 +0000 (UTC)
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
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org
Subject: [RFCv2 2/7] kexec: Introduce kexec_pe_image to parse and load PE file
Date: Tue, 29 Apr 2025 12:12:09 +0800
Message-ID: <20250429041214.13291-3-piliu@redhat.com>
In-Reply-To: <20250429041214.13291-1-piliu@redhat.com>
References: <20250429041214.13291-1-piliu@redhat.com>
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
to parse all these kinds of file, and leave the format parsing in
bpf-prog, so the kernel code can keep relative stable.

A new kexec_file_ops is implementation, named pe_image_ops.
It takes care of the file data handling process, which allows to unfold the PE
file, e.g. a vmlinuz.efi embeded in UKI's .linux section.

There are some place holder function in this patch. (They will take
effect after the introduction of kexec bpf light skeleton and bpf
helpers). Overall the parsing progress is a pipeline, the current
bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
end of the current stage 'disarm_bpf_prog()' the current parsed result
by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
, and deliver to the next stage.  For each stage, the bpf bytecode is
stored in the '.bpf' section of the PE file.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: kexec@lists.infradead.org
---
 include/linux/kexec.h   |   1 +
 kernel/Kconfig.kexec    |   8 +
 kernel/Makefile         |   1 +
 kernel/kexec_pe_image.c | 338 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 kernel/kexec_pe_image.c

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 26398b269ac29..bca8136dcf1fd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -392,6 +392,7 @@ static inline int machine_kexec_post_load(struct kimage *image) { return 0; }
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern const struct kexec_file_ops pe_image_ops;
 
 bool kexec_load_permitted(int kexec_image_type);
 
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f8719516..686eb7cb96142 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -47,6 +47,14 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by kexec system call.
 
+config KEXEC_PE_IMAGE
+	bool "Enable parsing UEFI PE file through kexec file based system call"
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
index 434929de17ef2..ab82d73d8ce81 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
+obj-$(CONFIG_KEXEC_PE_IMAGE) += kexec_pe_image.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
new file mode 100644
index 0000000000000..accf6b0f02e39
--- /dev/null
+++ b/kernel/kexec_pe_image.c
@@ -0,0 +1,338 @@
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
+#include <asm/byteorder.h>
+#include <asm/cpufeature.h>
+#include <asm/image.h>
+#include <asm/memory.h>
+
+
+static LIST_HEAD(phase_head);
+
+struct parsed_phase {
+	struct list_head head;
+	struct list_head res_head;
+};
+
+static struct parsed_phase *cur_phase;
+
+static char *kexec_res_names[3] = {"kernel", "initrd", "cmdline"};
+
+struct kexec_res {
+	struct list_head node;
+	char *name;
+	char *buf;
+	int size;
+	bool kmalloc;
+	bool deferred_free;
+};
+
+static struct parsed_phase *alloc_new_phase(void)
+{
+	struct parsed_phase *phase = kzalloc(sizeof(struct parsed_phase), GFP_KERNEL);
+
+	INIT_LIST_HEAD(&phase->head);
+	INIT_LIST_HEAD(&phase->res_head);
+	list_add_tail(&phase->head, &phase_head);
+
+	return phase;
+}
+
+static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
+{
+	struct mz_hdr *mz;
+	struct pe_hdr *pe;
+
+	if (!kernel_buf)
+		return false;
+	mz = (struct mz_hdr *)kernel_buf;
+	if (mz->magic != MZ_MAGIC)
+		return false;
+	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
+	if (pe->magic != PE_MAGIC)
+		return false;
+	if (pe->opt_hdr_size == 0) {
+		pr_err("optional header is missing\n");
+		return false;
+	}
+
+	return true;
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
+static int get_pe_section(char *file_buf, const char *sect_name,
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
+			*sect_start = file_buf + sect_hdr->data_addr;
+			*sect_sz = sect_hdr->raw_data_size;
+			return 0;
+		}
+		sect_hdr++;
+	}
+
+	return -1;
+}
+
+static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
+{
+	char *sect_start = NULL;
+	unsigned long sect_sz = 0;
+	int ret;
+
+	ret = get_pe_section(file_buf, ".bpf", &sect_start, &sect_sz);
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
+/*
+ * In eBPF, functions can only pass up to five arguments through R1 to R5.
+ * If five arguments are not enough, considering parse_zboot(struct pt_regs *regs)
+ *
+ * optimize("O0") prevents inline, compiler constant propagation
+ */
+__attribute__((used, optimize("O0"))) void bpf_handle_pefile(char *image, int image_sz,
+			char *initrd, int initrd_sz, char *cmdline)
+{
+}
+
+__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(void)
+{
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
+	list_for_each_entry(res, &cur_phase->res_head, node) {
+		if (res->name == kexec_res_names[0]) {
+			*kernel = res->buf;
+			*kernel_len = res->size;
+			ret = 0;
+		} else if (res->name == kexec_res_names[1]) {
+			*initrd = res->buf;
+			*initrd_len = res->size;
+		} else if (res->name == kexec_res_names[2]) {
+			*cmdline = res->buf;
+		}
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
+	char *parsed_kernel = NULL;
+	unsigned long parsed_len;
+	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
+	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
+	struct parsed_phase *phase, *phase_tmp;
+	struct kexec_res *res, *res_tmp;
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
+	while(is_valid_format(linux_start, linux_sz) &&
+	      pe_has_bpf_section(linux_start, linux_sz)) {
+
+		get_pe_section(linux_start, ".bpf", &bpf_start, &bpf_sz);
+		if (!!bpf_sz) {
+			/* load and attach bpf-prog */
+			ret = arm_bpf_prog(bpf_start, bpf_sz);
+			if (ret) {
+				pr_err("Fail to load .bpf section\n");
+				goto err;
+			}
+		}
+		cur_phase = alloc_new_phase();
+		/*
+		 * bpf-prog fentry, which handle above buffers, and
+		 * bpf_carrier_helper() fills each phase
+		 */
+		bpf_handle_pefile(linux_start, linux_sz, initrd_start, initrd_sz,
+					cmdline_start);
+
+		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
+					&initrd_sz, &cmdline_start);
+		/* bpf-prog fentry */
+		bpf_post_handle_pefile();
+		/*
+		 * detach the current bpf-prog from their attachment points.
+		 * It also a point to free any registered interim resource.
+		 * Any resource except attached to phase is interim.
+		 */
+		disarm_bpf_prog();
+	}
+
+	/* the rear of parsed phase contains the result */
+	list_for_each_entry_reverse(phase, &phase_head, head) {
+		if (initrd != NULL && cmdline != NULL && parsed_kernel != NULL)
+			break;
+		list_for_each_entry(res, &phase->res_head, node) {
+			if (!strcmp(res->name, "kernel") && !parsed_kernel) {
+				parsed_kernel = res->buf;
+				parsed_len = res->size;
+				res->deferred_free = true;
+			} else if (!strcmp(res->name, "initrd") && !initrd) {
+				initrd = res->buf;
+				initrd_len = res->size;
+				res->deferred_free = true;
+			} else if (!strcmp(res->name, "cmdline") && !cmdline) {
+				cmdline = res->buf;
+				cmdline_len = res->size;
+				res->deferred_free = true;
+			}
+		}
+
+	}
+
+	if (initrd == NULL || cmdline == NULL || parsed_kernel == NULL) {
+		char *c, buf[64];
+
+		c = buf;
+		if (parsed_kernel == NULL) {
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
+		ret = -EINVAL;
+		goto err;
+	}
+	/*
+	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
+	 * be updated to the new content.
+	 */
+	if (image->kernel_buf != parsed_kernel) {
+		vfree(image->kernel_buf);
+		image->kernel_buf = parsed_kernel;
+		image->kernel_buf_len = parsed_len;
+	}
+	if (image->initrd_buf != initrd) {
+		vfree(image->initrd_buf);
+		image->initrd_buf = initrd;
+		image->initrd_buf_len = initrd_len;
+	}
+	if (image->cmdline_buf != cmdline) {
+		kfree(image->cmdline_buf);
+		image->cmdline_buf = cmdline;
+		image->cmdline_buf_len = cmdline_len;
+	}
+	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
+					    image->kernel_buf_len);
+	if (ret) {
+		pr_err("Fail to find suitable image loader\n");
+		goto err;
+	}
+	ldata = kexec_image_load_default(image);
+	if (IS_ERR(ldata)) {
+		ret = PTR_ERR(ldata);
+		goto err;
+	}
+	image->image_loader_data = ldata;
+
+err:
+	list_for_each_entry_safe(phase, phase_tmp, &phase_head, head) {
+		list_for_each_entry_safe(res, res_tmp, &phase->res_head, node) {
+			list_del(&res->node);
+			/* defer to kimage_file_post_load_cleanup() */
+			if (!res->deferred_free) {
+				if (res->kmalloc)
+					kfree(res->buf);
+				else
+					vfree(res->buf);
+			}
+			kfree(res);
+		}
+		list_del(&phase->head);
+		kfree(phase);
+	}
+
+	return ERR_PTR(ret);
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


