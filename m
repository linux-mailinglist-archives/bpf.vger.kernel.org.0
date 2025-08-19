Return-Path: <bpf+bounces-65946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D5B2B5F6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DB9526EC5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3F1EB5DB;
	Tue, 19 Aug 2025 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a48ZHkV7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBF1E32C6
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566830; cv=none; b=LZM4SVvGJa4xlb0EYJX+A3rcAjMssyNA6WIX+IlN6DOF57ShcMsddEXG2b7GofIizGc4hPYV6uYBPmSJhNKeZHIjOaNnr9VlaB/M6696vrXrVcJYDuK45xhmVrzgNssKs+Yq2gvRAYqrmXcxfU7u78XPgRkzpap3Lp0hsv2v5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566830; c=relaxed/simple;
	bh=spq6+sD8afuPPqcYqJ5o/eS8ntNKfN5N1FYIsPqgZbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhZyqg8kC9tP4Fz1JQUnSnu2ouC7HXmJ5A7Irdy9EjL/Nlrb93T3Yu0rTP+VQBQYMs9LGNLONNaAcdmSWtRts9ES9vfrhiWEkGYifXTmYINflMeJlEvsfI2+9aghXh8wURgVdbAKbz3mF8wz6S5vk7U7hPszBvAf3UNjPP6G7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a48ZHkV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DGKv0kZu+QfjXM2CTTbx+MCo0AUwvmJ2uSC4P3uuPA=;
	b=a48ZHkV7NHwNsnoRC78GfQjfpGMN8+PdNYWJDaamp57e2pxTS7h5Dj9/d0GyJldzng8Dg1
	iC+UHwMHC9xGVWpkCzjoywRccOuBQZ2QaHx4YZ3pMKuZqlZqWuGTp8b8QkMyh/QVskz7di
	fL7aX4fAcu5G3uMrpKFWeIBlHxunNEU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-DoVYWt-CMaScRLIM6781Kg-1; Mon,
 18 Aug 2025 21:27:03 -0400
X-MC-Unique: DoVYWt-CMaScRLIM6781Kg-1
X-Mimecast-MFC-AGG-ID: DoVYWt-CMaScRLIM6781Kg_1755566820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3843E1956089;
	Tue, 19 Aug 2025 01:27:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4B9E180028D;
	Tue, 19 Aug 2025 01:26:48 +0000 (UTC)
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
Subject: [PATCHv5 09/12] kexec: Integrate bpf light skeleton to load zboot image
Date: Tue, 19 Aug 2025 09:24:25 +0800
Message-ID: <20250819012428.6217-10-piliu@redhat.com>
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

All kexec PE bpf prog should align with the interface exposed by the
light skeleton
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

With the above presumption, the integration consists of two parts:
  -1. Call API exposed by light skeleton from kexec
  -2. The opts_insn[] and opts_data[] are bpf-prog dependent and
      can be extracted and passed in from the user space. In the
      kexec_file_load design, a PE file has a .bpf section, which data
      content is a ELF, and the ELF contains opts_insn[] opts_data[].
      As a bonus, BPF bytecode can be placed under the protection of the
      entire PE signature.
      (Note, since opts_insn[] contains the information of the ringbuf
       size, the bpf-prog writer can change its proper size according to
       the kernel image size without modifying the kernel code)

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/Makefile                              |   1 +
 kernel/kexec_bpf/Makefile                    |   8 +
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 292 +------------------
 kernel/kexec_pe_image.c                      |  48 +++
 4 files changed, 61 insertions(+), 288 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index cb2121d65a289..04490182f653c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
+CFLAGS_kexec_pe_image.o += -I$(srctree)/tools/lib
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
 KASAN_SANITIZE_kstack_erase.o := n
 KCSAN_SANITIZE_kstack_erase.o := n
diff --git a/kernel/kexec_bpf/Makefile b/kernel/kexec_bpf/Makefile
index 0c9db6d94a604..20448bae233a0 100644
--- a/kernel/kexec_bpf/Makefile
+++ b/kernel/kexec_bpf/Makefile
@@ -39,6 +39,14 @@ clean:
 kexec_pe_parser_bpf.lskel.h: $(OUTPUT)/kexec_pe_parser_bpf.o | $(BPFTOOL)
 	$(call msg,GEN-SKEL,$@)
 	$(Q)$(BPFTOOL) gen skeleton -L $< > $@
+	@# The following sed commands make opts_data[] and opts_insn[] visible in a file instead of only in a function.
+	@# And it removes the bytecode
+	$(Q) sed -i '/static const char opts_data\[\].*=/,/";$$/d' $@
+	$(Q) sed -i '/static const char opts_insn\[\].*=/,/";$$/d' $@
+	$(Q) sed -i \
+		-e 's/opts\.data_sz = sizeof(opts_data) - 1;/opts.data_sz = opts_data_sz;/' \
+		-e 's/opts\.insns_sz = sizeof(opts_insn) - 1;/opts.insns_sz = opts_insn_sz;/' $@
+	$(Q) sed -i '7i static char *opts_data, *opts_insn;\nstatic unsigned int opts_data_sz, opts_insn_sz;' $@
 
 $(OUTPUT)/vmlinux.h: $(VMLINUX) $(BPFOBJ) | $(OUTPUT)
 	@$(BPFTOOL) btf dump file $(VMLINUX) format c > $(OUTPUT)/vmlinux.h
diff --git a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
index 34c7aabde66f0..88a3aa90d5e04 100644
--- a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
+++ b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
@@ -4,6 +4,8 @@
 #define __KEXEC_PE_PARSER_BPF_SKEL_H__
 
 #include <bpf/skel_internal.h>
+static char *opts_data, *opts_insn;
+static unsigned int opts_data_sz, opts_insn_sz;
 
 struct kexec_pe_parser_bpf {
 	struct bpf_loader_ctx ctx;
@@ -103,297 +105,11 @@ kexec_pe_parser_bpf__load(struct kexec_pe_parser_bpf *skel)
 {
 	struct bpf_load_and_run_opts opts = {};
 	int err;
-	static const char opts_data[] __attribute__((__aligned__(8))) = "\
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
-\x18\0\0\0\0\0\0\0\x04\x03\0\0\x04\x03\0\0\x95\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
-\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
-\0\0\x04\0\0\0\x1b\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
-\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x04\0\0\0\0\0\0\0\
-\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\
-\0\x2a\0\0\0\0\0\0\x0e\x07\0\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\
-\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x34\0\0\0\0\0\0\x0e\x09\0\
-\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\
-\0\0\x05\0\0\0\x40\0\0\0\x3e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\x02\0\
-\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x48\
-\0\0\0\0\0\0\x0e\x0d\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x0d\x02\0\0\0\x52\0\0\0\0\0\
-\0\x0c\x0f\0\0\0\0\0\0\0\0\0\0\x02\x12\0\0\0\x2d\x01\0\0\0\0\0\x01\x08\0\0\0\
-\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x40\x01\0\0\x11\0\0\0\x44\x01\0\0\x01\
-\0\0\x0c\x13\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x40\x01\0\0\x11\0\0\0\xb4\x01\
-\0\0\x01\0\0\x0c\x15\0\0\0\x33\x02\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\0\0\0\
-\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\x38\x02\0\0\0\0\0\x0e\x18\0\0\
-\0\x01\0\0\0\0\0\0\0\0\0\0\x0a\x17\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x1a\0\0\0\
-\x04\0\0\0\x10\0\0\0\x40\x02\0\0\0\0\0\x0e\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\
-\0\0\0\0\x17\0\0\0\x04\0\0\0\x10\0\0\0\x51\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\
-\x62\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\
-\x04\0\0\0\x0d\0\0\0\x74\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1f\0\0\0\0\0\0\0\x10\0\
-\0\0\x79\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1e\0\0\0\0\0\0\0\x10\0\0\0\x7f\x02\0\0\
-\x04\0\0\x0f\x40\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\x0a\0\0\0\x10\0\0\0\x10\0\0\
-\0\x0c\0\0\0\x20\0\0\0\x10\0\0\0\x0e\0\0\0\x30\0\0\0\x10\0\0\0\x85\x02\0\0\x01\
-\0\0\x0f\x10\0\0\0\x1c\0\0\0\0\0\0\0\x10\0\0\0\x8d\x02\0\0\x01\0\0\x0f\x04\0\0\
-\0\x19\0\0\0\0\0\0\0\x04\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\
-\x53\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\
-\x5f\x65\x6e\x74\x72\x69\x65\x73\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\x72\
-\x69\x6e\x67\x62\x75\x66\x5f\x32\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\x72\
-\x69\x6e\x67\x62\x75\x66\x5f\x34\0\x64\x75\x6d\x6d\x79\0\x2e\x74\x65\x78\x74\0\
-\x2f\x68\x6f\x6d\x65\x2f\x6c\x69\x6e\x75\x78\x2f\x6b\x65\x72\x6e\x65\x6c\x2f\
-\x6b\x65\x78\x65\x63\x5f\x62\x70\x66\x2f\x6b\x65\x78\x65\x63\x5f\x70\x65\x5f\
-\x70\x61\x72\x73\x65\x72\x5f\x62\x70\x66\x2e\x63\0\x5f\x5f\x61\x74\x74\x72\x69\
-\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\x20\x73\x74\x61\x74\
-\x69\x63\x20\x69\x6e\x74\x20\x64\x75\x6d\x6d\x79\x28\x76\x6f\x69\x64\x29\0\x09\
-\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\x6d\x63\x70\x79\x28\x6c\x6f\
-\x63\x61\x6c\x5f\x6e\x61\x6d\x65\x2c\x20\x4b\x45\x58\x45\x43\x5f\x52\x45\x53\
-\x5f\x49\x4e\x49\x54\x52\x44\x5f\x4e\x41\x4d\x45\x2c\x20\x31\x36\x29\x3b\0\x09\
-\x72\x65\x74\x75\x72\x6e\x20\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\
-\x6d\x63\x6d\x70\x28\x6c\x6f\x63\x61\x6c\x5f\x6e\x61\x6d\x65\x2c\x20\x72\x65\
-\x73\x5f\x6b\x65\x72\x6e\x65\x6c\x2c\x20\x34\x29\x3b\0\x75\x6e\x73\x69\x67\x6e\
-\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\0\x63\x74\x78\0\x70\x61\x72\
-\x73\x65\x5f\x70\x65\0\x66\x65\x6e\x74\x72\x79\x2e\x73\x2f\x62\x70\x66\x5f\x68\
-\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x5f\x5f\x61\x74\x74\x72\x69\
-\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\x20\x69\x6e\x74\x20\
-\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\x20\
-\x73\x74\x72\x75\x63\x74\x20\x6b\x65\x78\x65\x63\x5f\x63\x6f\x6e\x74\x65\x78\
-\x74\x20\x2a\x63\x6f\x6e\x74\x65\x78\x74\x29\0\x70\x6f\x73\x74\x5f\x70\x61\x72\
-\x73\x65\x5f\x70\x65\0\x66\x65\x6e\x74\x72\x79\x2e\x73\x2f\x62\x70\x66\x5f\x70\
-\x6f\x73\x74\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x5f\x5f\
-\x61\x74\x74\x72\x69\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\
-\x20\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x6f\x73\x74\x5f\
-\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x6b\x65\
-\x78\x65\x63\x5f\x63\x6f\x6e\x74\x65\x78\x74\x20\x2a\x63\x6f\x6e\x74\x65\x78\
-\x74\x29\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x64\x75\x6d\x6d\x79\
-\x2e\x72\x65\x73\x5f\x6b\x65\x72\x6e\x65\x6c\0\x64\x75\x6d\x6d\x79\x2e\x6c\x6f\
-\x63\x61\x6c\x5f\x6e\x61\x6d\x65\0\x64\x75\x6d\x6d\x79\x2e\x72\x65\x73\x5f\x63\
-\x6d\x64\x6c\x69\x6e\x65\0\x2e\x62\x73\x73\0\x2e\x64\x61\x74\x61\0\x2e\x6d\x61\
-\x70\x73\0\x2e\x72\x6f\x64\x61\x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xb1\x05\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\
-\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\
-\x75\x66\x5f\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\
-\x6e\x67\x62\x75\x66\x5f\x32\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x34\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\
-\0\x80\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x72\x6f\x64\
-\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\x24\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\
-\x65\x78\x65\x63\x3a\x6b\x65\x72\x6e\x65\x6c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\
-\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\
-\x5f\x70\x65\x2e\x64\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x22\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x3a\x63\x6d\x64\x6c\x69\x6e\x65\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\
-\x65\x63\x5f\x70\x65\x2e\x62\x73\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x21\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\
-\x0d\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x2e\x72\x6f\x64\x61\x74\x61\x2e\
-\x73\x74\x72\x31\x2e\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\x6b\x65\x78\x65\x63\x3a\x69\x6e\x69\x74\x72\x64\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\x47\x50\x4c\0\0\0\0\0\xb4\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\
-\0\0\0\0\x5e\0\0\0\x68\x01\0\0\x1b\xe8\0\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x70\x61\x72\
-\x73\x65\x5f\x70\x65\0\0\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\
-\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x68\x61\
-\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\
-\0\xb4\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x16\0\0\0\0\0\0\0\x5e\0\0\0\xe2\
-\x01\0\0\x1b\0\x01\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x70\x6f\x73\x74\x5f\x70\x61\x72\
-\x73\x65\x5f\x70\x65\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\
-\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x70\x6f\x73\x74\
-\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\0";
-	static const char opts_insn[] __attribute__((__aligned__(8))) = "\
-\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
-\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x41\0\0\0\0\0\x61\
-\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
-\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
-\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x84\xff\0\0\0\0\xd5\x01\x01\0\0\
-\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x88\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\
-\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\
-\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\
-\0\0\x04\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\
-\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x01\0\0\0\0\0\0\
-\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\
-\0\0\0\0\0\0\x0c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\
-\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x01\0\0\0\
-\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\
-\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x01\
-\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\
-\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\
-\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0a\0\0\x63\x01\0\0\0\0\
-\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xcc\x0a\0\0\x63\x01\0\0\
-\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc0\x0a\0\0\x7b\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\xb8\x0a\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\
-\0\0\xb8\x0a\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
-\xc5\x07\xa7\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\
-\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe4\x0a\0\0\x63\x01\0\0\0\0\0\0\xb7\
-\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xd8\x0a\0\0\xb7\x03\0\0\x48\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x9a\xff\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x2c\0\0\0\0\0\x15\0\x03\0\0\
-\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x2c\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
-\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x20\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\
-\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x8b\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x04\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x3c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x74\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
-\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x68\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
-\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x7c\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x08\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x4c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\xbc\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\xb0\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x6d\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x0c\0\0\0\x63\x71\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\x28\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x5c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
-\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xf8\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
-\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x5a\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x10\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x60\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\
-\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\
-\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\x58\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x50\
-\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x68\x0c\0\0\x7b\x01\
-\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x58\x0c\0\0\xb7\
-\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x36\xff\0\0\
-\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x78\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x78\x0c\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\xc5\x07\x29\xff\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xb0\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x6c\0\0\0\0\0\x15\0\x03\0\0\
-\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x8c\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
-\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x0c\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\
-\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x19\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x14\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x70\0\0\0\0\0\x15\x03\x08\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\
-\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\
-\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\xe0\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\
-\0\xd8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe8\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf0\x0c\0\0\
-\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xe0\x0c\
-\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xf5\
-\xfe\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0d\0\0\
-\x63\x01\0\0\0\0\0\0\x61\x60\x7c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x0c\x0d\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\
-\0\0\0\0\0\0\0\0\x0d\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\
-\0\0\0\0\xc5\x07\xe5\xfe\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x63\x71\
-\0\0\0\0\0\0\x79\x63\x80\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x48\x0d\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\
-\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\
-\x0d\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x58\x0d\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x68\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\x48\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0d\0\0\x7b\x01\0\0\0\0\0\0\xb7\
-\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x60\x0d\0\0\xb7\x03\0\0\x20\0\0\
-\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xc1\xfe\0\0\0\0\x61\x60\x8c\
-\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x8c\x0d\0\0\x63\x01\
-\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x0d\0\0\xb7\
-\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xb5\xfe\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x90\0\0\
-\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0d\0\0\xb7\x02\0\
-\0\x0d\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\
-\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\
-\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0d\0\0\x63\x01\0\0\0\0\0\
-\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe8\x0d\
-\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xc8\x0d\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\xf0\x0d\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\
-\0\0\0\0\0\0\0\0\0\xe0\x0d\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\
-\x07\0\0\0\0\0\0\xc5\x07\x91\xfe\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\
-\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\x63\x01\0\0\0\0\0\0\
-\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\xb7\x03\0\0\x04\0\
-\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x84\xfe\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x08\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x0e\0\0\x7b\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\
-\0\x40\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x20\x0e\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x88\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
-\0\0\0\x28\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0e\0\0\x7b\x01\0\0\0\0\0\0\
-\x18\x60\0\0\0\0\0\0\0\0\0\0\x38\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x0e\0\
-\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\
-\0\0\0\0\xb0\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x50\x0e\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\
-\0\0\0\0\0\0\0\0\x54\x0e\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\x58\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x63\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xc8\x0e\0\0\xb7\x02\0\0\x12\0\0\0\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\
-\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x4e\xfe\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\x38\x0e\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\
-\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x38\
-\x0e\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\
-\0\0\0\0\0\0\0\0\0\0\xa8\x0e\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\
-\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x3c\xfe\0\0\0\0\x63\x7a\x80\xff\0\
-\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe0\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\
-\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x0e\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x18\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\xf8\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0f\0\0\x7b\
-\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0f\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x90\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x88\x0f\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x2c\x0f\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0f\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\
-\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x58\x0f\0\0\x63\x01\0\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0f\0\0\xb7\x02\0\0\x17\0\0\0\xb7\x03\0\0\x0c\
-\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x05\
-\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0f\0\0\x63\x70\x6c\0\0\0\0\0\x77\
-\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\
-\0\0\0\0\0\0\x10\x0f\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\
-\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x80\x0f\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\
-\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\xf3\xfd\0\0\0\0\
-\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\
-\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\x98\0\0\0\0\0\
-\x61\xa0\x84\xff\0\0\0\0\x63\x06\x9c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\
-\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x28\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x08\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x38\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\
-\0\x0c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x48\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\x10\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x58\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x14\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x68\0\0\0\0\0\x18\x61\0\0\0\0\0\0\
-\0\0\0\0\x18\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x78\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\x1c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x88\0\0\0\0\0\xb7\0\0\0\0\0\0\
-\0\x95\0\0\0\0\0\0\0";
 
 	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = sizeof(opts_data) - 1;
+	opts.data_sz = opts_data_sz;
 	opts.data = (void *)opts_data;
-	opts.insns_sz = sizeof(opts_insn) - 1;
+	opts.insns_sz = opts_insn_sz;
 	opts.insns = (void *)opts_insn;
 
 	err = bpf_load_and_run(&opts);
diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index f8debcde6b516..0e9cd09782463 100644
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
@@ -21,6 +22,7 @@
 #include <asm/image.h>
 #include <asm/memory.h>
 
+#include "kexec_bpf/kexec_pe_parser_bpf.lskel.h"
 
 #define KEXEC_RES_KERNEL_NAME "kexec:kernel"
 #define KEXEC_RES_INITRD_NAME "kexec:initrd"
@@ -159,14 +161,60 @@ static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
 	return true;
 }
 
+static struct kexec_pe_parser_bpf *pe_parser;
+
+static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
+		const char *symbol_name, unsigned int *symbol_size)
+{
+	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
+	Elf_Shdr *shdr, *dst_shdr;
+	const Elf_Sym *sym;
+	void *symbol_data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		pr_err("Not a valid ELF file\n");
+		return NULL;
+	}
+
+	sym = elf_find_symbol(ehdr, symbol_name);
+	if (!sym)
+		return NULL;
+	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
+	dst_shdr = &shdr[sym->st_shndx];
+	symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
+	*symbol_size = sym->st_size;
+
+	return symbol_data;
+}
+
 /* Load a ELF */
 static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
 {
+	opts_data = get_symbol_from_elf(bpf_elf, sz, "opts_data", &opts_data_sz);
+	opts_insn = get_symbol_from_elf(bpf_elf, sz, "opts_insn", &opts_insn_sz);
+	if (!opts_data || !opts_insn)
+		return -1;
+	/*
+	 * When light skeleton generates opts_data[] and opts_insn[], it appends a
+	 * NULL terminator at the end of string
+	 */
+	opts_data_sz = opts_data_sz - 1;
+	opts_insn_sz = opts_insn_sz - 1;
+
+	pe_parser = kexec_pe_parser_bpf__open_and_load();
+	if (!pe_parser)
+		return -1;
+	kexec_pe_parser_bpf__attach(pe_parser);
+
 	return 0;
 }
 
 static void disarm_bpf_prog(void)
 {
+	kexec_pe_parser_bpf__destroy(pe_parser);
+	pe_parser = NULL;
+	opts_data = NULL;
+	opts_insn = NULL;
 }
 
 struct kexec_context {
-- 
2.49.0


