Return-Path: <bpf+bounces-56896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC75AA0152
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8812C7A96DC
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D49270EB8;
	Tue, 29 Apr 2025 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx9aO/Qz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD69270579
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745900054; cv=none; b=eVmoUMhC7Oc0KER8NP1DeCxcK8SK8SFDIr3GMhkiETgVmIYr8eCbHO17bBG0+VTylGIgno/TlfJN0/O4BFcC5xU0vw1zE/JbWKIVdMjqBjOag5iy/pdrfzrWN7/Z+JzmuTBSIrJvId/IsGBT0ftpvW/6mozRXbwTZrxCN7e7qaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745900054; c=relaxed/simple;
	bh=n9gij5MMG4+h0hMhzlw0Hev6Q6ZcI0ugd/dyVr4ZVG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqOwzj9Ppe3NT5sxVr4R8nyn/GRxlBf/eZwqW44JkCMwxiZR9Nseoo9ii1XhpTzfnniOs6J87pbptHa1s6vYK0uG8JM3Bc3EZJCuqkr/YVtt/bKH/T3/36BK5p2ex58bVUEyYtJ0lDBRNei2pzcWyfVky1FCLcvE000tmudo6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vx9aO/Qz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745900047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb/FusGG5NNtIFDtlHyD4eCxcyvq2vFAQrJi4YAbolY=;
	b=Vx9aO/Qz87Tcppi+Ijz6Ewl75ZvZitIO8yyQnU83SHgGRweFPZYRCVLgG1DYHr3f4wjJce
	/SYevtSd6bV8zcYqRvV48Fmhb14njdzMLa121woRNQFvyHoUxooEPf4mMQTvoEaqPi9tlW
	4/Jt3ZdO68mE+5rmXW5lS9jRz/4pMBk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-UizpoMweMk-AxZBvGOsd0w-1; Tue,
 29 Apr 2025 00:14:03 -0400
X-MC-Unique: UizpoMweMk-AxZBvGOsd0w-1
X-Mimecast-MFC-AGG-ID: UizpoMweMk-AxZBvGOsd0w_1745900038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608EF1800374;
	Tue, 29 Apr 2025 04:13:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 595AA180045B;
	Tue, 29 Apr 2025 04:13:46 +0000 (UTC)
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
Subject: [RFCv2 6/7] kexec: Integrate bpf light skeleton to load zboot image
Date: Tue, 29 Apr 2025 12:12:13 +0800
Message-ID: <20250429041214.13291-7-piliu@redhat.com>
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
            SEC("fentry/bpf_handle_pefile")
            SEC("fentry/bpf_post_handle_pefile")

With the above presumption, the integration consists of two parts:
  -1. Call API exposed by light skeleton from kexec
  -2. The opts_insn[] and opts_data[] are bpf-prog dependent and
      can be extracted and passed in from the user space. In the
      kexec_file_load design, a PE file has a .bpf section, which data
      content is a ELF, and the ELF contains opts_insn[] opts_data[].
      As a bonus, BPF bytecode can be placed under the protection of the
      entire PE signature

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: bpf@vger.kernel.org
To: kexec@lists.infradead.org
---
 kernel/Makefile                              |   1 +
 kernel/kexec_bpf/Makefile                    |   8 +
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 290 +------------------
 kernel/kexec_pe_image.c                      |  71 +++++
 4 files changed, 84 insertions(+), 286 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index ab82d73d8ce81..7c384bf62535a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_kexec_pe_image.o += -I$(srctree)/tools/lib
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCSAN_SANITIZE_stackleak.o := n
diff --git a/kernel/kexec_bpf/Makefile b/kernel/kexec_bpf/Makefile
index b772e78464f48..91d3fb8b4caf7 100644
--- a/kernel/kexec_bpf/Makefile
+++ b/kernel/kexec_bpf/Makefile
@@ -36,6 +36,14 @@ clean:
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
 
 
 $(OUTPUT)/kexec_pe_parser_bpf.o: kexec_pe_parser_bpf.c $(BPFOBJ) | $(OUTPUT)
diff --git a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
index d8a181609c32e..88a3aa90d5e04 100644
--- a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
+++ b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
@@ -4,6 +4,8 @@
 #define __KEXEC_PE_PARSER_BPF_SKEL_H__
 
 #include <bpf/skel_internal.h>
+static char *opts_data, *opts_insn;
+static unsigned int opts_data_sz, opts_insn_sz;
 
 struct kexec_pe_parser_bpf {
 	struct bpf_loader_ctx ctx;
@@ -103,295 +105,11 @@ kexec_pe_parser_bpf__load(struct kexec_pe_parser_bpf *skel)
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
-\x18\0\0\0\0\0\0\0\x04\x03\0\0\x04\x03\0\0\x79\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
-\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
-\0\0\x04\0\0\0\x1b\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
-\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\0\0\x10\0\0\0\0\
-\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\
-\0\x2a\0\0\0\0\0\0\x0e\x07\0\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\
-\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x34\0\0\0\0\0\0\x0e\x09\0\
-\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\
-\0\0\x05\0\0\0\x40\0\0\0\x3e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\x02\0\
-\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x48\
-\0\0\0\0\0\0\x0e\x0d\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x0d\x02\0\0\0\x52\0\0\0\0\0\
-\0\x0c\x0f\0\0\0\0\0\0\0\0\0\0\x02\x12\0\0\0\0\x01\0\0\0\0\0\x01\x08\0\0\0\x40\
-\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x13\x01\0\0\x11\0\0\0\x17\x01\0\0\x01\0\0\
-\x0c\x13\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x13\x01\0\0\x11\0\0\0\x9c\x01\0\0\
-\x01\0\0\x0c\x15\0\0\0\x17\x02\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\0\0\0\0\0\
-\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\x1c\x02\0\0\0\0\0\x0e\x18\0\0\0\
-\x01\0\0\0\0\0\0\0\0\0\0\x0a\x17\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x1a\0\0\0\x04\
-\0\0\0\x10\0\0\0\x24\x02\0\0\0\0\0\x0e\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\
-\0\0\x17\0\0\0\x04\0\0\0\x10\0\0\0\x35\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\x46\
-\x02\0\0\0\0\0\x0e\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\
-\0\0\x07\0\0\0\x58\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1f\0\0\0\0\0\0\0\x10\0\0\0\
-\x5d\x02\0\0\x01\0\0\x0f\x10\0\0\0\x1e\0\0\0\0\0\0\0\x10\0\0\0\x63\x02\0\0\x04\
-\0\0\x0f\x40\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\x0a\0\0\0\x10\0\0\0\x10\0\0\0\
-\x0c\0\0\0\x20\0\0\0\x10\0\0\0\x0e\0\0\0\x30\0\0\0\x10\0\0\0\x69\x02\0\0\x01\0\
-\0\x0f\x10\0\0\0\x1c\0\0\0\0\0\0\0\x10\0\0\0\x71\x02\0\0\x01\0\0\x0f\x04\0\0\0\
-\x19\0\0\0\0\0\0\0\x04\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\
-\x53\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\
-\x5f\x65\x6e\x74\x72\x69\x65\x73\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\x72\
-\x69\x6e\x67\x62\x75\x66\x5f\x32\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\x72\
-\x69\x6e\x67\x62\x75\x66\x5f\x34\0\x64\x75\x6d\x6d\x79\0\x2e\x74\x65\x78\x74\0\
-\x2f\x68\x6f\x6d\x65\x2f\x6c\x69\x6e\x75\x78\x2f\x6b\x65\x72\x6e\x65\x6c\x2f\
-\x6b\x65\x78\x65\x63\x5f\x62\x70\x66\x2f\x6b\x65\x78\x65\x63\x5f\x70\x65\x5f\
-\x70\x61\x72\x73\x65\x72\x5f\x62\x70\x66\x2e\x63\0\x09\x5f\x5f\x62\x75\x69\x6c\
-\x74\x69\x6e\x5f\x6d\x65\x6d\x63\x70\x79\x28\x6c\x6f\x63\x61\x6c\x5f\x6e\x61\
-\x6d\x65\x2c\x20\x4b\x45\x58\x45\x43\x5f\x52\x45\x53\x5f\x49\x4e\x49\x54\x52\
-\x44\x5f\x4e\x41\x4d\x45\x2c\x20\x31\x36\x29\x3b\0\x09\x72\x65\x74\x75\x72\x6e\
-\x20\x5f\x5f\x62\x75\x69\x6c\x74\x69\x6e\x5f\x6d\x65\x6d\x63\x6d\x70\x28\x6c\
-\x6f\x63\x61\x6c\x5f\x6e\x61\x6d\x65\x2c\x20\x72\x65\x73\x5f\x6b\x65\x72\x6e\
-\x65\x6c\x2c\x20\x34\x29\x3b\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\
-\x67\x20\x6c\x6f\x6e\x67\0\x63\x74\x78\0\x70\x61\x72\x73\x65\x5f\x70\x65\0\x66\
-\x65\x6e\x74\x72\x79\x2f\x62\x70\x66\x5f\x68\x61\x6e\x64\x6c\x65\x5f\x70\x65\
-\x66\x69\x6c\x65\0\x5f\x5f\x61\x74\x74\x72\x69\x62\x75\x74\x65\x5f\x5f\x28\x28\
-\x75\x73\x65\x64\x29\x29\x20\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\
-\x28\x70\x61\x72\x73\x65\x5f\x70\x65\x2c\x20\x63\x68\x61\x72\x20\x2a\x69\x6d\
-\x61\x67\x65\x5f\x62\x75\x66\x2c\x20\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\
-\x6e\x74\x20\x69\x6d\x61\x67\x65\x5f\x73\x7a\x2c\x20\x63\x68\x61\x72\x20\x2a\
-\x69\x6e\x69\x74\x72\x64\x2c\0\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\
-\x65\0\x66\x65\x6e\x74\x72\x79\x2f\x62\x70\x66\x5f\x70\x6f\x73\x74\x5f\x68\x61\
-\x6e\x64\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\x5f\x5f\x61\x74\x74\x72\x69\x62\
-\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\x64\x29\x29\x20\x69\x6e\x74\x20\x42\
-\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\
-\x70\x65\x2c\x20\x63\x68\x61\x72\x20\x2a\x69\x6d\x61\x67\x65\x5f\x62\x75\x66\
-\x2c\x20\x69\x6e\x74\x20\x62\x75\x66\x5f\x73\x7a\x29\0\x63\x68\x61\x72\0\x4c\
-\x49\x43\x45\x4e\x53\x45\0\x64\x75\x6d\x6d\x79\x2e\x72\x65\x73\x5f\x6b\x65\x72\
-\x6e\x65\x6c\0\x64\x75\x6d\x6d\x79\x2e\x6c\x6f\x63\x61\x6c\x5f\x6e\x61\x6d\x65\
-\0\x64\x75\x6d\x6d\x79\x2e\x72\x65\x73\x5f\x63\x6d\x64\x6c\x69\x6e\x65\0\x2e\
-\x62\x73\x73\0\x2e\x64\x61\x74\x61\0\x2e\x6d\x61\x70\x73\0\x2e\x72\x6f\x64\x61\
-\x74\x61\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x95\x05\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\
-\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x32\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\
-\x5f\x34\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x78\
-\x65\x63\x5f\x70\x65\x2e\x72\x6f\x64\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\x24\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\x65\x72\x6e\x65\x6c\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x64\x61\x74\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\x22\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x6d\x64\x6c\x69\x6e\x65\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x6b\
-\x65\x78\x65\x63\x5f\x70\x65\x2e\x62\x73\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x21\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\
-\x04\0\0\0\x07\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x2e\x72\x6f\x64\x61\
-\x74\x61\x2e\x73\x74\x72\x31\x2e\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\x69\x6e\x69\x74\x72\x64\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\
-\0\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\0\0\0\0\x5e\0\0\
-\0\x39\x01\0\0\x1b\xe0\0\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x70\x61\x72\x73\x65\x5f\x70\
-\x65\0\0\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\
-\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x68\x61\x6e\x64\x6c\x65\
-\x5f\x70\x65\x66\x69\x6c\x65\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\xb7\0\0\0\0\0\
-\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x16\0\0\0\0\0\0\0\x5e\0\0\0\xc8\x01\0\0\x1b\xfc\
-\0\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\x70\x6f\x73\x74\x5f\x70\x61\x72\x73\x65\x5f\x70\x65\
-\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\
-\0\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\x10\0\0\0\0\0\0\0\x62\x70\x66\x5f\x70\x6f\x73\x74\x5f\x68\x61\x6e\x64\
-\x6c\x65\x5f\x70\x65\x66\x69\x6c\x65\0\0";
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
-\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb0\x0a\0\0\x63\x01\0\0\0\0\
-\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xac\x0a\0\0\x63\x01\0\0\
-\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0a\0\0\x7b\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x98\x0a\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\
-\0\0\x98\x0a\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
-\xc5\x07\xa7\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\
-\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc4\x0a\0\0\x63\x01\0\0\0\0\0\0\xb7\
-\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xb8\x0a\0\0\xb7\x03\0\0\x48\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x9a\xff\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x2c\0\0\0\0\0\x15\0\x03\0\0\
-\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x0c\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
-\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\
-\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x8b\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\x04\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x3c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x54\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
-\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x48\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
-\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x7c\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x08\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x4c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x9c\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\x90\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x6d\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x0c\0\0\0\x63\x71\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\x08\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x5c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\xe4\x0b\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\
-\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xd8\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\
-\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x5a\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x10\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x60\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x20\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\
-\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\
-\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\x38\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\
-\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x20\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x0c\0\0\x7b\x01\
-\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x38\x0c\0\0\xb7\
-\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x36\xff\0\0\
-\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x58\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x58\x0c\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\xc5\x07\x29\xff\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\x90\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x6c\0\0\0\0\0\x15\0\x03\0\0\
-\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x6c\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\
-\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x60\x0c\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\
-\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x19\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\
-\0\0\0\x14\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x70\0\0\0\0\0\x15\x03\x08\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa8\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\
-\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\
-\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\xc0\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\
-\0\xb8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\xa8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0c\0\0\
-\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xc0\x0c\
-\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xf5\
-\xfe\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0d\0\0\
-\x63\x01\0\0\0\0\0\0\x61\x60\x7c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\xec\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\
-\0\0\0\0\0\0\0\xe0\x0c\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\
-\0\0\0\0\0\xc5\x07\xe5\xfe\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x63\
-\x71\0\0\0\0\0\0\x79\x63\x80\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\x28\x0d\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\
-\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\
-\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x40\x0d\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x38\x0d\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x48\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
-\0\0\0\x28\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\x0d\0\0\x7b\x01\0\0\0\0\0\0\
-\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x40\x0d\0\0\xb7\x03\0\0\x20\
-\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xc1\xfe\0\0\0\0\x61\x60\
-\x8c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x6c\x0d\0\0\x63\
-\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x60\x0d\0\0\
-\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xb5\xfe\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x90\
-\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa8\x0d\0\0\xb7\
-\x02\0\0\x07\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\
-\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\
-\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x0d\0\0\x63\x01\0\0\0\
-\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xb0\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc0\
-\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xa8\x0d\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\xc8\x0d\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\
-\x62\0\0\0\0\0\0\0\0\0\0\xb8\x0d\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\
-\xbf\x07\0\0\0\0\0\0\xc5\x07\x91\xfe\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\
-\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd8\x0d\0\0\x63\x01\0\0\0\
-\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xd8\x0d\0\0\xb7\x03\0\
-\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x84\xfe\0\0\0\0\
-\x18\x60\0\0\0\0\0\0\0\0\0\0\xe0\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x0e\0\
-\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x0d\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x18\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf8\
-\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\0\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0e\0\0\x7b\x01\0\
-\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x90\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x88\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x28\x0e\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x2c\x0e\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\
-\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x58\x0e\0\0\x63\x01\0\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0e\0\0\xb7\x02\0\0\x12\0\0\0\xb7\x03\0\0\x0c\0\0\
-\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x4e\xfe\
-\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0e\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\
-\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\
-\0\0\0\0\x10\x0e\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\
-\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x3c\xfe\0\0\0\0\x63\
-\x7a\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xb8\x0e\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xf8\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xc0\x0e\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf0\x0e\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
-\0\0\0\0\0\0\0\xd0\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x38\x0f\0\0\x7b\x01\0\0\
-\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x0e\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x48\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x0e\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x68\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x60\x0f\0\0\x7b\x01\0\0\0\0\0\0\x61\
-\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x63\x01\0\0\0\0\0\0\
-\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\x0f\0\0\x63\x01\0\0\0\0\
-\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x7b\x01\0\0\
-\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0f\0\0\x63\
-\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x0f\0\0\xb7\x02\0\0\x17\0\0\0\
-\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\
-\0\0\xc5\x07\x05\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x0e\0\0\x63\x70\
-\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\
-\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xe8\x0e\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\
-\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x58\x0f\0\0\x61\x01\0\0\
-\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\
-\xf3\xfd\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\
-\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\
-\x06\x98\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x9c\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\x04\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x28\0\0\0\0\0\x18\x61\0\0\
-\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x38\0\0\0\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x48\0\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x58\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x68\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x78\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x88\0\0\0\
-\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
 
 	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = sizeof(opts_data) - 1;
+	opts.data_sz = opts_data_sz;
 	opts.data = (void *)opts_data;
-	opts.insns_sz = sizeof(opts_insn) - 1;
+	opts.insns_sz = opts_insn_sz;
 	opts.insns = (void *)opts_insn;
 
 	err = bpf_load_and_run(&opts);
diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
index 610bb134f5e34..a6e299c657475 100644
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
@@ -23,6 +24,7 @@
 #include <asm/image.h>
 #include <asm/memory.h>
 
+#include "kexec_bpf/kexec_pe_parser_bpf.lskel.h"
 
 static LIST_HEAD(phase_head);
 
@@ -309,14 +311,83 @@ static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
 	return true;
 }
 
+static struct kexec_pe_parser_bpf *pe_parser;
+
+static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
+		const char *symbol_name, unsigned int *symbol_size)
+{
+	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
+	Elf_Shdr *shdr, *symtab_shdr, *strtab_shdr, *dst_shdr;
+	Elf64_Sym *sym, *symtab = NULL;
+	char *strtab = NULL;
+	void *symbol_data = NULL;
+	int i;
+
+	symtab_shdr = strtab_shdr = NULL;
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		pr_err("Not a valid ELF file\n");
+		goto out;
+	}
+
+	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (shdr[i].sh_type == SHT_SYMTAB) {
+			symtab_shdr = &shdr[i];
+		} else if (shdr[i].sh_type == SHT_STRTAB && i != ehdr->e_shstrndx) {
+			strtab_shdr = &shdr[i];
+		}
+	}
+
+	if (!symtab_shdr || !strtab_shdr) {
+		pr_err("Symbol table or string table not found\n");
+		goto out;
+	}
+	symtab = (Elf64_Sym *)(elf_data + symtab_shdr->sh_offset);
+	strtab = (char *)(elf_data + strtab_shdr->sh_offset);
+	for (i = 0; i < symtab_shdr->sh_size / sizeof(Elf64_Sym); i++) {
+		sym = &symtab[i];
+		if (strcmp(&strtab[sym->st_name], symbol_name) == 0) {
+			if (sym->st_shndx >= SHN_LORESERVE)
+			    return NULL; // No section data for these
+			dst_shdr = &shdr[sym->st_shndx];
+			symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
+			*symbol_size = symtab[i].st_size;
+			break;
+		}
+	}
+
+out:
+    return symbol_data;
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
 
 /*
-- 
2.49.0


