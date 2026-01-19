Return-Path: <bpf+bounces-79412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2784D39CDC
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84076300C0C0
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2D2737FC;
	Mon, 19 Jan 2026 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvmOtfQF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49B275844
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793245; cv=none; b=ojhk0+CRkYUZx+J8KV7LuraBdVgnaog+2Nf8nIloOYWZD02d0ypzUNVQ3nBAfyrfksC3DUI9VC+WyRc9w38fxrmmdW4lfD0mCa2AcDBG1rlQb0/6FNMJ8oTKwZYmpsYR7HEAPzC7sYIa12ecN3X7mKoHRrCEFqwqKWXlUxlt3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793245; c=relaxed/simple;
	bh=t94TOy4M2d+HXboWxxlVyeu8E/Q3F75Xq/jctCSEkJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpCZiMOKWgfR5HUz+XbrVCvajLsEMQM9Uenzt+p/PiJqFBwzxyaRcFPv05Fao4ziAmqOgdcDFyUOfrLbxWeSL7d8B/p6n6MY/ytrS1WUQ78YQOOCkkHcGvZ6/MMzPsEZ/URdTvwbM+hCZmgay+xBOTqz2nbuiQyZo6+4Iv07bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvmOtfQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVIO4pSwV1cOF3+JyTmxSKBMwoxbZ/66btH1QHe2vHM=;
	b=RvmOtfQFCb04fPhHl+9yg6ptHQNnOzDvs549cPo+9eJ8agxD2gZzQECHNUIUcAkrXESseH
	Ww8rempcKEh/1pfIz2qk/3diXGcjdlUirj0JTAQqIGIQmS7s0WkOPSO8KvMp8cl/dGY0yI
	diEK5N5Dv8Dbe7bI+TYuIS+1tuP6LFw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-aEQIrnxOMUCU1GNYEi39OA-1; Sun,
 18 Jan 2026 22:27:15 -0500
X-MC-Unique: aEQIrnxOMUCU1GNYEi39OA-1
X-Mimecast-MFC-AGG-ID: aEQIrnxOMUCU1GNYEi39OA_1768793233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00F4819560B2;
	Mon, 19 Jan 2026 03:27:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F7E71955F22;
	Mon, 19 Jan 2026 03:27:01 +0000 (UTC)
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
Subject: [PATCHv6 10/13] kexec_file: Integrate bpf light skeleton to load image with bpf-prog
Date: Mon, 19 Jan 2026 11:24:21 +0800
Message-ID: <20260119032424.10781-11-piliu@redhat.com>
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
                    struct bpf_map_desc rodata_str1_1;
                    struct bpf_map_desc bss;
    one prog:
            SEC("fentry.s/kexec_image_parser_anchor")

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
 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 254 +------------------
 kernel/kexec_bpf_loader.c                    |  48 ++++
 4 files changed, 63 insertions(+), 248 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 05177a867690d..a1c5f5fb02770 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
+CFLAGS_kexec_bpf_loader.o += -I$(srctree)/tools/lib
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
 KASAN_SANITIZE_kstack_erase.o := n
 KCSAN_SANITIZE_kstack_erase.o := n
diff --git a/kernel/kexec_bpf/Makefile b/kernel/kexec_bpf/Makefile
index 45d45cc0855a3..88e92eb910f64 100644
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
 
 $(OUTPUT)/vmlinux.h: $(VMLINUX) $(DEFAULT_BPFTOOL) $(BPFOBJ) | $(OUTPUT)
 	@$(BPFTOOL) btf dump file $(VMLINUX) format c > $(OUTPUT)/vmlinux.h
diff --git a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
index d1e863fd0ff4f..db71b2150789d 100644
--- a/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
+++ b/kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
@@ -4,6 +4,8 @@
 #define __KEXEC_PE_PARSER_BPF_SKEL_H__
 
 #include <bpf/skel_internal.h>
+static char *opts_data, *opts_insn;
+static unsigned int opts_data_sz, opts_insn_sz;
 
 struct kexec_pe_parser_bpf {
 	struct bpf_loader_ctx ctx;
@@ -14,8 +16,8 @@ struct kexec_pe_parser_bpf {
 		struct bpf_map_desc ringbuf_4;
 		struct bpf_map_desc rodata;
 		struct bpf_map_desc data;
-		struct bpf_map_desc bss;
 		struct bpf_map_desc rodata_str1_1;
+		struct bpf_map_desc bss;
 	} maps;
 	struct {
 		struct bpf_prog_desc parse_pe;
@@ -63,8 +65,8 @@ kexec_pe_parser_bpf__destroy(struct kexec_pe_parser_bpf *skel)
 	skel_closenz(skel->maps.ringbuf_4.map_fd);
 	skel_closenz(skel->maps.rodata.map_fd);
 	skel_closenz(skel->maps.data.map_fd);
-	skel_closenz(skel->maps.bss.map_fd);
 	skel_closenz(skel->maps.rodata_str1_1.map_fd);
+	skel_closenz(skel->maps.bss.map_fd);
 	skel_free(skel);
 }
 static inline struct kexec_pe_parser_bpf *
@@ -87,254 +89,10 @@ kexec_pe_parser_bpf__load(struct kexec_pe_parser_bpf *skel)
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
-\x18\0\0\0\0\0\0\0\xdc\x02\0\0\xdc\x02\0\0\x85\x01\0\0\0\0\0\0\0\0\0\x02\x03\0\
-\0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
-\0\0\x04\0\0\0\x1b\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
-\x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\x04\0\0\0\0\0\0\0\
-\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\
-\0\x2a\0\0\0\0\0\0\x0e\x07\0\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\
-\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x34\0\0\0\0\0\0\x0e\x09\0\
-\0\0\x01\0\0\0\0\0\0\0\x02\0\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\
-\0\0\x05\0\0\0\x40\0\0\0\x3e\0\0\0\0\0\0\x0e\x0b\0\0\0\x01\0\0\0\0\0\0\0\x02\0\
-\0\x04\x10\0\0\0\x19\0\0\0\x01\0\0\0\0\0\0\0\x1e\0\0\0\x05\0\0\0\x40\0\0\0\x48\
-\0\0\0\0\0\0\x0e\x0d\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x02\x10\0\0\0\x52\0\0\0\0\0\
-\0\x01\x08\0\0\0\x40\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x65\0\0\0\x0f\0\0\0\
-\x69\0\0\0\x01\0\0\x0c\x11\0\0\0\x14\x01\0\0\0\0\0\x01\x01\0\0\0\x08\0\0\x01\0\
-\0\0\0\0\0\0\x03\0\0\0\0\x13\0\0\0\x04\0\0\0\x04\0\0\0\x19\x01\0\0\0\0\0\x0e\
-\x14\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\x0a\x13\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x16\
-\0\0\0\x04\0\0\0\x10\0\0\0\x21\x01\0\0\0\0\0\x0e\x17\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\x03\0\0\0\0\x13\0\0\0\x04\0\0\0\x10\0\0\0\x2e\x01\0\0\0\0\0\x0e\x19\0\0\0\0\
-\0\0\0\x39\x01\0\0\0\0\0\x0e\x19\0\0\0\0\0\0\0\x43\x01\0\0\0\0\0\x0e\x19\0\0\0\
-\0\0\0\0\x55\x01\0\0\x01\0\0\x0f\x10\0\0\0\x1b\0\0\0\0\0\0\0\x10\0\0\0\x5a\x01\
-\0\0\x01\0\0\x0f\x10\0\0\0\x1a\0\0\0\0\0\0\0\x10\0\0\0\x60\x01\0\0\x04\0\0\x0f\
-\x40\0\0\0\x08\0\0\0\0\0\0\0\x10\0\0\0\x0a\0\0\0\x10\0\0\0\x10\0\0\0\x0c\0\0\0\
-\x20\0\0\0\x10\0\0\0\x0e\0\0\0\x30\0\0\0\x10\0\0\0\x66\x01\0\0\x01\0\0\x0f\x10\
-\0\0\0\x18\0\0\0\0\0\0\0\x10\0\0\0\x6e\x01\0\0\x01\0\0\x0f\x10\0\0\0\x1c\0\0\0\
-\0\0\0\0\x10\0\0\0\x7d\x01\0\0\x01\0\0\x0f\x04\0\0\0\x15\0\0\0\0\0\0\0\x04\0\0\
-\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\x49\x5a\x45\x5f\x54\x59\
-\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\
-\x73\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\x72\x69\x6e\x67\x62\x75\x66\x5f\
-\x32\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x33\0\x72\x69\x6e\x67\x62\x75\x66\x5f\
-\x34\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\
-\0\x63\x74\x78\0\x70\x61\x72\x73\x65\x5f\x70\x65\0\x66\x65\x6e\x74\x72\x79\x2e\
-\x73\x2f\x6b\x65\x78\x65\x63\x5f\x69\x6d\x61\x67\x65\x5f\x70\x61\x72\x73\x65\
-\x72\x5f\x61\x6e\x63\x68\x6f\x72\0\x2f\x68\x6f\x6d\x65\x2f\x6c\x69\x6e\x75\x78\
-\x2f\x6b\x65\x72\x6e\x65\x6c\x2f\x6b\x65\x78\x65\x63\x5f\x62\x70\x66\x2f\x6b\
-\x65\x78\x65\x63\x5f\x70\x65\x5f\x70\x61\x72\x73\x65\x72\x5f\x62\x70\x66\x2e\
-\x63\0\x5f\x5f\x61\x74\x74\x72\x69\x62\x75\x74\x65\x5f\x5f\x28\x28\x75\x73\x65\
-\x64\x29\x29\x20\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x70\x61\
-\x72\x73\x65\x5f\x70\x65\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x6b\x65\x78\x65\
-\x63\x5f\x63\x6f\x6e\x74\x65\x78\x74\x20\x2a\x63\x6f\x6e\x74\x65\x78\x74\x2c\0\
-\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x64\x75\x6d\x6d\x79\x5f\x72\
-\x6f\x64\x61\x74\x61\0\x64\x75\x6d\x6d\x79\x5f\x64\x61\x74\x61\0\x64\x75\x6d\
-\x6d\x79\x5f\x62\x73\x73\0\x64\x75\x6d\x6d\x79\x5f\x72\x6f\x64\x61\x74\x61\x5f\
-\x73\x74\x72\x31\0\x2e\x62\x73\x73\0\x2e\x64\x61\x74\x61\0\x2e\x6d\x61\x70\x73\
-\0\x2e\x72\x6f\x64\x61\x74\x61\0\x2e\x72\x6f\x64\x61\x74\x61\x2e\x73\x74\x72\
-\x31\x2e\x31\0\x6c\x69\x63\x65\x6e\x73\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\x79\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\
-\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x31\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\0\0\0\0\0\
-\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\x66\x5f\x32\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1b\0\0\
-\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\x67\x62\x75\
-\x66\x5f\x33\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\x1b\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x69\x6e\
-\x67\x62\x75\x66\x5f\x34\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\
-\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x72\x6f\x64\x61\x74\x61\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x72\x6f\x64\x61\x74\x61\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x64\x61\x74\x61\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x1e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x64\x61\x74\x61\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\x02\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\x6b\x65\x78\x65\x63\x5f\x70\x65\x2e\x62\x73\x73\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\x1d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\
-\0\0\0\x04\0\0\0\x10\0\0\0\x01\0\0\0\x80\0\0\0\0\0\0\0\0\0\0\0\x2e\x72\x6f\x64\
-\x61\x74\x61\x2e\x73\x74\x72\x31\x2e\x31\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x21\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x47\
-\x50\x4c\0\0\0\0\0\xb4\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x12\0\0\0\0\0\0\
-\0\x95\0\0\0\xc8\0\0\0\x1b\xf4\0\0\x1a\0\0\0\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x70\x61\x72\x73\x65\
-\x5f\x70\x65\0\0\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\
-\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x6b\x65\x78\x65\x63\x5f\x69\x6d\
-\x61\x67\x65\x5f\x70\x61\x72\x73\x65\x72\x5f\x61\x6e\x63\x68\x6f\x72\0\0\0\0\0\
-\0\0";
-	static const char opts_insn[] __attribute__((__aligned__(8))) = "\
-\xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
-\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x3b\0\0\0\0\0\x61\
-\xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
-\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
-\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\
-\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\
-\x18\x60\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\
-\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\0\0\
-\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\
-\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\
-\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\x10\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\
-\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x61\x01\0\0\0\0\0\0\xd5\
-\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\
-\0\0\0\0\x18\0\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\
-\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x01\0\0\0\0\0\
-\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xbf\x70\0\0\0\
-\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
-\x09\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x94\x09\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\x88\x09\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x05\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x80\x09\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x12\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\x80\x09\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xad\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\x61\
-\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xac\x09\0\0\
-\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xa0\x09\0\
-\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xa0\
-\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\
-\x2c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf4\x09\0\0\x63\
-\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xe8\x09\0\0\
-\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x91\xff\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x3c\
-\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x3c\x0a\0\0\x63\x01\
-\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x30\x0a\0\0\xb7\
-\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x82\xff\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x63\x71\0\0\0\0\0\0\x61\x60\x4c\0\0\
-\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x84\x0a\0\0\x63\x01\0\0\
-\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x78\x0a\0\0\xb7\x03\0\
-\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x73\xff\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x63\x71\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf0\x0a\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x5c\0\
-\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xcc\x0a\0\0\x63\x01\0\
-\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xc0\x0a\0\0\xb7\x03\
-\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x60\xff\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x60\0\0\0\0\
-\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0b\0\0\xb7\x02\0\0\
-\x10\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\
-\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\
-\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x0b\0\0\x63\x01\0\0\0\0\0\0\
-\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\x0b\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0b\0\
-\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x08\x0b\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x30\x0b\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x20\x0b\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\xc5\x07\x3c\xff\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x61\
-\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x40\x0b\0\0\x63\x01\0\0\0\0\0\0\
-\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x40\x0b\0\0\xb7\x03\0\0\x04\
-\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x2f\xff\0\0\0\0\x61\xa0\
-\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x0b\0\0\x63\x01\0\0\0\0\0\0\
-\x61\x60\x6c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x54\x0b\
-\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x48\
-\x0b\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
-\x1f\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x14\0\0\0\x63\x71\0\0\0\0\0\0\x79\
-\x63\x70\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x0b\0\
-\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\
-\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
-\x14\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa8\x0b\0\0\x63\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xa0\x0b\0\0\x18\x61\0\0\0\0\0\0\0\0\0\
-\0\xb0\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x90\x0b\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\xb8\x0b\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\xa8\x0b\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xfb\xfe\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\xf8\x0b\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x7c\0\0\0\0\0\
-\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd4\x0b\0\0\x63\x01\0\0\0\0\0\
-\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xc8\x0b\0\0\xb7\x03\0\0\x48\
-\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xeb\xfe\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x80\0\0\0\0\0\x15\
-\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0c\0\0\xb7\x02\0\0\x10\0\0\
-\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\
-\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\x61\x20\0\0\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x20\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0c\0\0\x7b\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\
-\0\x38\x0c\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\
-\0\0\0\x28\x0c\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\
-\0\xc5\x07\xc7\xfe\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x78\x0c\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x8c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x54\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\x48\x0c\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xb7\xfe\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x1c\0\0\0\x63\x71\0\0\0\0\0\0\x79\x63\x90\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x90\x0c\0\0\xb7\x02\0\0\x10\0\0\0\x61\x60\x04\0\0\0\0\
-\0\x45\0\x02\0\x01\0\0\0\x85\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\
-\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\xa8\x0c\0\0\x63\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xa0\
-\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb0\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x90\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x0c\0\0\x7b\x01\
-\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\xa8\x0c\0\0\xb7\
-\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x93\xfe\0\0\
-\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x1c\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\xc8\x0c\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\xc8\x0c\0\0\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\xc5\x07\x86\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x0c\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\
-\0\0\0\0\0\xd8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0d\0\0\x7b\x01\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\
-\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf0\x0c\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x60\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\0\x0d\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0d\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x0d\0\0\x7b\x01\0\
-\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x0d\0\0\x63\
-\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\x0d\0\0\
-\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x0d\
-\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x48\x0d\0\0\x63\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x0d\0\0\xb7\
-\x02\0\0\x1a\0\0\0\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\
-\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x50\xfe\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\
-\x0d\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\
-\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x0d\0\0\xb7\x03\0\0\x8c\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x0d\0\
-\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\
-\0\0\0\xc5\x07\x3e\xfe\0\0\0\0\x63\x7a\x80\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\
-\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\
-\0\0\0\0\x63\x06\x98\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\
-\0\0\0\0\x63\x06\x18\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x04\0\0\0\x61\x10\0\
-\0\0\0\0\0\x63\x06\x28\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\0\0\0\x61\x10\
-\0\0\0\0\0\0\x63\x06\x38\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x0c\0\0\0\x61\
-\x10\0\0\0\0\0\0\x63\x06\x48\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\
-\x61\x10\0\0\0\0\0\0\x63\x06\x58\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x14\0\0\
-\0\x61\x10\0\0\0\0\0\0\x63\x06\x68\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\0\
-\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x78\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\
-\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x88\0\0\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\
-\0\0\0";
 	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = sizeof(opts_data) - 1;
+	opts.data_sz = opts_data_sz;
 	opts.data = (void *)opts_data;
-	opts.insns_sz = sizeof(opts_insn) - 1;
+	opts.insns_sz = opts_insn_sz;
 	opts.insns = (void *)opts_insn;
 
 	err = bpf_load_and_run(&opts);
diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index 5ad67672dead1..9f1c5aede42ef 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -23,14 +23,62 @@
 #include <linux/decompress/generic.h>
 #include "kexec_internal.h"
 
+#include "kexec_bpf/kexec_pe_parser_bpf.lskel.h"
+
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


