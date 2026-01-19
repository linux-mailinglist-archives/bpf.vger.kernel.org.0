Return-Path: <bpf+bounces-79405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5511D39CCC
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33606300B82C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7124A044;
	Mon, 19 Jan 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sr/WbDdh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8320A5C4
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793159; cv=none; b=eDjU98q6HNAEucl9M2A5AgAHeAuZYg9W5ztM3cHvjaj2hreH6D3aqNnF9F+DEWlYattlGW4E9EEh8l3ANbTIv/Xjz1sJNcieekfZqiqyYfdnSDnm65hLYtDDHFwAcyaClakhWGH/yhvaWA37S+kf1/mCIQmYG/1Th5N4OGNm3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793159; c=relaxed/simple;
	bh=+ecQ5gK8JeAjJGmk6QHcpXOGTwCDwRZN/RM0zrGbals=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFXfBh79cVIRq7UU5MQBJds8q577JRyEtLVLhLe4QN0/AMS19DSINkCxxIDnRnjCvoDF0XtX7+zQ+WxO5sd8xqIKqrRxsO4tyL/v4Ns67arj9XW+5gMCyfv065XjRv5KE3scR2bq0YWYMTSEiaXY7j5VYoogAJMzKpQHSLbqtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sr/WbDdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PWLya1dhQNEc2PDrSyTdG72OD3leiyaAynZDfpPJDd8=;
	b=Sr/WbDdh2I1uXlSQU3IFGZv1TUjRho8lhPqy53DJv8aodXfiKoNR8Qmz6HPF9y3OxDWgT4
	vQWWCaEw/lszjUBOCgOARqj/P143HdNihdfPmsBLHFYlJN9zdBT0Lu+pzJbeSJVcMCDr3Y
	S5yF7fr+omOI4mCzZK7kTKQrtCZQROI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-utvPLdATNoeFcSBB5BRvfw-1; Sun,
 18 Jan 2026 22:25:54 -0500
X-MC-Unique: utvPLdATNoeFcSBB5BRvfw-1
X-Mimecast-MFC-AGG-ID: utvPLdATNoeFcSBB5BRvfw_1768793151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC471956096;
	Mon, 19 Jan 2026 03:25:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 906531955F22;
	Mon, 19 Jan 2026 03:25:39 +0000 (UTC)
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
Subject: [PATCHv6 03/13] kexec_file: Introduce routines to parse PE file
Date: Mon, 19 Jan 2026 11:24:14 +0800
Message-ID: <20260119032424.10781-4-piliu@redhat.com>
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

The incoming patches need to handle UEFI format image, which is in PE
format. Hence introducing some routines here.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Makefile         |  1 +
 kernel/kexec_internal.h |  3 ++
 kernel/kexec_uefi_app.c | 81 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 kernel/kexec_uefi_app.c

diff --git a/kernel/Makefile b/kernel/Makefile
index e83669841b8cc..f9e85c4a0622b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_BPF) += kexec_uefi_app.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 228bb88c018bc..8e5e5c1237732 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -36,6 +36,9 @@ static inline void kexec_unlock(void)
 void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
+extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
+extern int pe_get_section(const char *file_buf, const char *sect_name,
+		char **sect_start, unsigned long *sect_sz);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/kernel/kexec_uefi_app.c b/kernel/kexec_uefi_app.c
new file mode 100644
index 0000000000000..dbe6d76d47ffa
--- /dev/null
+++ b/kernel/kexec_uefi_app.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UEFI appilication file helpers
+ *
+ * Copyright (C) 2025, 2026 Red Hat, Inc
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/pe.h>
+#include <linux/string.h>
+#include "kexec_internal.h"
+
+/*
+ * The UEFI Terse Executable (TE) image has MZ header.
+ */
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
+	return true;
+}
+
+bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
+{
+	char *sect_start = NULL;
+	unsigned long sect_sz = 0;
+	int ret;
+
+	if (!is_valid_pe(file_buf, pe_sz))
+		return false;
+	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
+	if (ret < 0)
+		return false;
+	return true;
+}
+
+int pe_get_section(const char *file_buf, const char *sect_name,
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
+	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr +
+				sizeof(struct pe_hdr));
+	sect_hdr = (struct section_header *)((char *)opt_hdr +
+				pe_hdr->opt_hdr_size);
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
-- 
2.49.0


