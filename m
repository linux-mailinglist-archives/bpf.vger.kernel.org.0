Return-Path: <bpf+bounces-22181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BE858637
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F061283A21
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D997137C4B;
	Fri, 16 Feb 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtETtP+3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9092135A62
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112086; cv=none; b=cjfGuh4ugJiFdg1IDb7+g+rpz2qmpYofcJwBRmwCsuF61CItEhym8DSXgBP9BLQv9knKXS5s9ktQKs1h3F+PU2AoFGbVfXzzp1G7NlQrm8NyWUZLdBSvUj4+pnzxEKgcA40I3vkVYthocP3754NNT/C9stSIPWhf8UQcTsJRxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112086; c=relaxed/simple;
	bh=KfP48j3g6Qs/KUDr0Uoaz5zol0Q8FdNBQEFhh+jY9GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eE6+dto2c/gnlFW+p4FOUcAh5uQhtnP+tW5ycUlDnm3HMvfMBKaMY6QGQJUclufEbFGMPAoY+NOy0nhrnG7PsVyyn+uHiuGnSVj3aOytIvyTfbr0hmYZAu8v89R9s3fFi3UOVcIIMKge/NzR9wAyImN4KMUkSOo1G+1L9ti/mzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtETtP+3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607e54b6cf5so13106577b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112083; x=1708716883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KImNjzyvTPHSKz361KqvhWjF9V6nBD+MTFCShFr62oA=;
        b=JtETtP+3MERyOGg834lg6UipznMUc2yfQKLnXhvtfw0UweiFXRfgGvTPIQK6/MpFDX
         VNvgBmxYF3eyU7LWEEevG4xZNePE9aLZMI0Kx0SaGCq00NnhUhj3darwZiAyeVyZLg//
         NDfijCodtopkqVtIUfZjcfuLDwwdm6oeC5SasuxnhJDtabS3W8w3z2vUcXvWEAuIfzwc
         qUiQfW0jOinrjRjNLpPkwQ+plFufFmIai1RQNZlZCETs8FBUxI+6ZPAbIHBdD0IGmYn9
         +rSoS3c/d2V90bAvDoqYr6vcNCh2Ca7TowvxYl1EkH23N5iYyhnGyFzAK4I4LhQWc134
         pAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112083; x=1708716883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KImNjzyvTPHSKz361KqvhWjF9V6nBD+MTFCShFr62oA=;
        b=M3fgq4ES+ya1bc3Xaql9GxLHjbQ2mAKqmSsdtrHbTr4SqTUAIFn8HXK5o3mkgogLca
         Hucls18oQZnaQRW+BJwBjjd6V29zQBu9JWBA//UnE8Iefqp1VqsFHJyd9X2HYTlnv4Td
         MbHXzWwt55ihMNBZwAtlllc1bIloq9pZRWpgWVtVWQ5Z86xfrgqBrI47ZzTQm65eYsvx
         +0dIkOvIfbyuLVcYXXzfxalXYbTfFzUuempsP7eI9iqRwtAxzF+Fv/iCehtEHt3dVSzl
         eFAPLwV8xa74WF9G4V1c7mmtmqIQqxLrF+wKchuxYRRe99+QtqCazROXOnbeU7HgqkD5
         w/uw==
X-Gm-Message-State: AOJu0YzDAaXxc5iERHHeuI6mfvuFpRFUrT2TpFHgS1gCXxgHCQSjCrgd
	r76CsL4VvCvCxJskOgGGACptuMoAN1Q7Ed4suon6YoeaHIVN5F4+3icglpW1
X-Google-Smtp-Source: AGHT+IFrzzH80Td+bO0gfCTPWItEZWRNPu2EdaAiWB+S60osAXfBGXVZIKmttgwsCeGW8duz6zXNtQ==
X-Received: by 2002:a0d:e60b:0:b0:607:e6d5:612d with SMTP id p11-20020a0de60b000000b00607e6d5612dmr3818276ywe.1.1708112083476;
        Fri, 16 Feb 2024 11:34:43 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b00607c2ab443dsm470785ywf.130.2024.02.16.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:34:43 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test case for lacking CFI stub functions.
Date: Fri, 16 Feb 2024 11:34:34 -0800
Message-Id: <20240216193434.735874-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216193434.735874-1-thinker.li@gmail.com>
References: <20240216193434.735874-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Ensure struct_ops rejects the registration of struct_ops types without
proper CFI stub functions.

bpf_test_no_cfi.ko is a module that attempts to register a struct_ops type
called "bpf_test_no_cfi_ops" with varying levels of cfi_stubs. It starts
with a NULL cfi_stub and ends with a fully complete cfi_stub. Only the
fully complete cfi_stub should be accepted by struct_ops. The module can
only be loaded successfully if these registrations yield the expected
results.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          | 10 +-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 6 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dbb8c5f94f34..c219da5e60e6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features
+	xdp_features bpf_test_no_cfi.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -254,6 +254,12 @@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_testmo
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_testmod
 	$(Q)cp bpf_testmod/bpf_testmod.ko $@
 
+$(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
+	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
+
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
@@ -628,6 +634,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
+		       $(OUTPUT)/bpf_test_no_cfi.ko			\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -756,6 +763,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	feature bpftool							\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
+			       bpf_test_no_cfi.ko			\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile b/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
new file mode 100644
index 000000000000..ed5143b79edf
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
@@ -0,0 +1,19 @@
+BPF_TEST_NO_CFI_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(BPF_TEST_NO_CFI_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = bpf_test_no_cfi.ko
+
+obj-m += bpf_test_no_cfi.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(BPF_TEST_NO_CFI_DIR) clean
+
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
new file mode 100644
index 000000000000..0fb63feecb31
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+struct bpf_test_no_cfi_ops {
+	void (*fn_1)(void);
+	void (*fn_2)(void);
+};
+
+static int dummy_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int dummy_init_member(const struct btf_type *t,
+			     const struct btf_member *member,
+			     void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int dummy_reg(void *kdata)
+{
+	return 0;
+}
+
+static void dummy_unreg(void *kdata)
+{
+}
+
+static const struct bpf_verifier_ops dummy_verifier_ops;
+
+static void bpf_test_no_cfi_ops__fn_1(void)
+{
+}
+
+static void bpf_test_no_cfi_ops__fn_2(void)
+{
+}
+
+static struct bpf_test_no_cfi_ops __bpf_test_no_cfi_ops;
+
+static struct bpf_struct_ops bpf_bpf_test_no_cif_ops = {
+	.verifier_ops = &dummy_verifier_ops,
+	.init = dummy_init,
+	.init_member = dummy_init_member,
+	.reg = dummy_reg,
+	.unreg = dummy_unreg,
+	.name = "bpf_test_no_cfi_ops",
+	.owner = THIS_MODULE,
+};
+
+static int bpf_test_no_cfi_init(void)
+{
+	int ret;
+
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	bpf_bpf_test_no_cif_ops.cfi_stubs = &__bpf_test_no_cfi_ops;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	__bpf_test_no_cfi_ops.fn_1 = bpf_test_no_cfi_ops__fn_1;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	if (!ret)
+		return -EINVAL;
+
+	__bpf_test_no_cfi_ops.fn_2 = bpf_test_no_cfi_ops__fn_2;
+	ret = register_bpf_struct_ops(&bpf_bpf_test_no_cif_ops,
+				      bpf_test_no_cfi_ops);
+	return ret;
+}
+
+static void bpf_test_no_cfi_exit(void)
+{
+}
+
+module_init(bpf_test_no_cfi_init);
+module_exit(bpf_test_no_cfi_exit);
+
+MODULE_AUTHOR("Kuifeng Lee");
+MODULE_DESCRIPTION("BPF no cfi_stubs test module");
+MODULE_LICENSE("Dual BSD/GPL");
+
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
new file mode 100644
index 000000000000..11fbd9ebf1f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <testing_helpers.h>
+
+void test_struct_ops_no_cfi(void)
+{
+	int fd;
+	int err;
+
+	fd = open("bpf_test_no_cfi.ko", O_RDONLY);
+	if (!ASSERT_GT(fd, 0, "open")) {
+		close(fd);
+		return;
+	}
+
+	/* The module will try to register a struct_ops type with
+	 * no cfi_stubs, incomplete cfi_stubs, and full cfi_stubs.
+	 *
+	 * Only full cfi_stubs should be allowed. The module will be loaded
+	 * successfully if the result of the registration is as expected,
+	 * or it fails.
+	 */
+	err = finit_module(fd, "", 0);
+	close(fd);
+	if (!ASSERT_OK(err, "finit_module"))
+		return;
+
+	err = delete_module("bpf_test_no_cfi", 0);
+	ASSERT_OK(err, "delete_module");
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index a59e56d804ee..28b6646662af 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -356,12 +356,12 @@ __u64 read_perf_max_sample_freq(void)
 	return sample_freq;
 }
 
-static int finit_module(int fd, const char *param_values, int flags)
+int finit_module(int fd, const char *param_values, int flags)
 {
 	return syscall(__NR_finit_module, fd, param_values, flags);
 }
 
-static int delete_module(const char *name, int flags)
+int delete_module(const char *name, int flags)
 {
 	return syscall(__NR_delete_module, name, flags);
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d14de81727e6..d55f6ab12433 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -36,6 +36,8 @@ __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
 int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
+int finit_module(int fd, const char *param_values, int flags);
+int delete_module(const char *name, int flags);
 
 static inline __u64 get_time_ns(void)
 {
-- 
2.34.1


