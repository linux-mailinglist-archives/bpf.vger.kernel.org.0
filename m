Return-Path: <bpf+bounces-41571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5B9987AE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169B11F24664
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F911CBE89;
	Thu, 10 Oct 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEqeB0UP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E21C9DE6
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566885; cv=none; b=KC8b7nU8iOkk02d1BOmaqOkQBoVTXEzP5vH/hXOXn12OlfTgXMkppmbO62hvYTqppaxzamciLY+2618FLYabZgopBGeYVPYJzACSzofTgmVLxCw3QcKUuoBVYhiB/+FZeYdWsoTpmUfxeJ7ndw7kH0c8RFKbdfOVYEAHPicJAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566885; c=relaxed/simple;
	bh=wFxPhISBn0FR+BysUNxXrED95b21s0IL5GZkJf5EAVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEsfIf3iiasAte/yyEDbUQkIbdzPgiZIzipOuFRDsqV7y1D11Am0ENjsIUdkUpEINgrm0MFI7qjBdRLB7j+Jcdh+D2lCl55vf4FYdfRxXToOD1EF/i+EsIbjNE6fXhoLrk3tQ/gp5jcr+UyUJlRs30Veju9vvCn/ErotyfFq5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEqeB0UP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728566882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNfEkhaEfnomZL+VVDTKqmTWRtfi6Sw1VjCoynxR+M4=;
	b=KEqeB0UPRZNAmM/ZGjmNljA58IbTvuV/cAqRxsqffTvmDE9+HXyAcdlbcODYL5d7p6C0B2
	IncSaY0YOso06j+x4qsHWQkrzmapurE3nSBAqOSOqsLBaiYLxiO9Ebqd6rN6mP2J60Dpdg
	rAAMaHS006izY+Gswt2EzDbZnvqjsAA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-sI9TUbBZNSW9jTJ27qIZMQ-1; Thu, 10 Oct 2024 09:28:01 -0400
X-MC-Unique: sI9TUbBZNSW9jTJ27qIZMQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9940593476so71456666b.3
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 06:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566880; x=1729171680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNfEkhaEfnomZL+VVDTKqmTWRtfi6Sw1VjCoynxR+M4=;
        b=Lrk8u0B5ebT3WTA81JCvXXOiJ6HxyJBKdp5GqyWrlDFY+ZMZ0k7l8l7vx8BBtwajgv
         vZJMoNSONnQZiA0yGhgZh5Ph6g/n5DktkGg3Mn/5XjcOYBwBVnaUJKtv7oiVt4qjSU+E
         THlrk1Saw7bArw2CSWEaaK9l8/YqSPz3Sxle/NIAvIw2kIBZLZw4e6YOQk++S/wuJDt7
         bPvFqEJB1hrp0S5bIWtNgH/jWYDJyGdWdbtqYlSawqhFTJvFQpWUX18dTbM8jCboTfRy
         Z9FfSk/r9ZzVhxUL0LVvofmkj8ntBf/plB5b82d1ItvEeCfHdRNyyHMEG/aq3uk+3GxW
         BBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWl5HKgQHKOYhVP+gDd9cT1g9QOCSvFA5QMseqJEJ2BEqsU9xRotIQpQhzYBN7rPe+MmLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYo2C4u1Yx76nnURTgKQvQv3scZDoxogJH/YueaCVW2JyGQWP0
	wwM2pxL3S3cJhhrsV9EI11dAVzIg573munVVDv4JT/RU6Tk8HsRCwbWPxU42FdDDoLY1OQ/FYU4
	BTWx8NQsjk8AboMt4IS4LgGKEB6HL7mWJU8K4v5HDjwkNzzqDdw==
X-Received: by 2002:a17:907:d14:b0:a99:4278:8df8 with SMTP id a640c23a62f3a-a998d218eedmr478419766b.34.1728566879613;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLsIM+zWS3wCu58d2XA43gODSIjv5f1PFCiGxE5AQ3RR/LJDPMorLaMUl2+g+WzFHhZozN9w==
X-Received: by 2002:a17:907:d14:b0:a99:4278:8df8 with SMTP id a640c23a62f3a-a998d218eedmr478417466b.34.1728566879149;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efb5bsm88330266b.192.2024.10.10.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4418815F3EA5; Thu, 10 Oct 2024 15:27:57 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 10 Oct 2024 15:27:09 +0200
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add test for kfunc module order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-fix-kfunc-btf-caching-for-modules-v2-3-745af6c1af98@redhat.com>
References: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
In-Reply-To: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

From: Simon Sundberg <simon.sundberg@kau.se>

Add a test case for kfuncs from multiple external modules, checking
that the correct kfuncs are called regardless of which order they're
called in. Specifically, check that calling the kfuncs in an order
different from the one the modules' BTF are loaded in works.

Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/Makefile               | 20 +++++++-
 .../selftests/bpf/bpf_test_modorder_x/Makefile     | 19 ++++++++
 .../bpf/bpf_test_modorder_x/bpf_test_modorder_x.c  | 39 +++++++++++++++
 .../selftests/bpf/bpf_test_modorder_y/Makefile     | 19 ++++++++
 .../bpf/bpf_test_modorder_y/bpf_test_modorder_y.c  | 39 +++++++++++++++
 .../selftests/bpf/prog_tests/kfunc_module_order.c  | 55 ++++++++++++++++++++++
 .../selftests/bpf/progs/kfunc_module_order.c       | 30 ++++++++++++
 7 files changed, 220 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f04af11df8eb5a1cecd75a4864d45c669433df61..6f9838a5dcc9a0a0e7cc249a4f93c87befafb699 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -157,7 +157,8 @@ TEST_GEN_PROGS_EXTENDED = \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -303,6 +304,19 @@ $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_te
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
 	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
 
+$(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_x
+	$(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
+
+$(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_y
+	$(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
+
+
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
@@ -722,6 +736,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/bpf_test_no_cfi.ko			\
+		       $(OUTPUT)/bpf_test_modorder_x.ko		\
+		       $(OUTPUT)/bpf_test_modorder_y.ko		\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -856,6 +872,8 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
 			       bpf_test_no_cfi.ko			\
+			       bpf_test_modorder_x.ko			\
+			       bpf_test_modorder_y.ko			\
 			       liburandom_read.so)			\
 	$(OUTPUT)/FEATURE-DUMP.selftests
 
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile b/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..40b25b98ad1b622c6a5c3c00d0625595349bb677
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_modorder_x/Makefile
@@ -0,0 +1,19 @@
+BPF_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(BPF_TESTMOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = bpf_test_modorder_x.ko
+
+obj-m += bpf_test_modorder_x.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
+
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c b/tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c
new file mode 100644
index 0000000000000000000000000000000000000000..0cc747fa912fcd5b6738af15dc1b8dfb88c33f6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_modorder_x/bpf_test_modorder_x.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_test_modorder_retx(void)
+{
+	return 'x';
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_test_modorder_kfunc_x_ids)
+BTF_ID_FLAGS(func, bpf_test_modorder_retx);
+BTF_KFUNCS_END(bpf_test_modorder_kfunc_x_ids)
+
+static const struct btf_kfunc_id_set bpf_test_modorder_x_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_test_modorder_kfunc_x_ids,
+};
+
+static int __init bpf_test_modorder_x_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					 &bpf_test_modorder_x_set);
+}
+
+static void __exit bpf_test_modorder_x_exit(void)
+{
+}
+
+module_init(bpf_test_modorder_x_init);
+module_exit(bpf_test_modorder_x_exit);
+
+MODULE_DESCRIPTION("BPF selftest ordertest module X");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile b/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..52c3ab9d84e29c794f57c1f75be03b46d80d4a06
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_modorder_y/Makefile
@@ -0,0 +1,19 @@
+BPF_TESTMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(BPF_TESTMOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = bpf_test_modorder_y.ko
+
+obj-m += bpf_test_modorder_y.o
+
+all:
+	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(BPF_TESTMOD_DIR) clean
+
diff --git a/tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c b/tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c
new file mode 100644
index 0000000000000000000000000000000000000000..c627ee085d1305af98c5d7f66d99dcfbf98dc4e1
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_test_modorder_y/bpf_test_modorder_y.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_test_modorder_rety(void)
+{
+	return 'y';
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_test_modorder_kfunc_y_ids)
+BTF_ID_FLAGS(func, bpf_test_modorder_rety);
+BTF_KFUNCS_END(bpf_test_modorder_kfunc_y_ids)
+
+static const struct btf_kfunc_id_set bpf_test_modorder_y_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_test_modorder_kfunc_y_ids,
+};
+
+static int __init bpf_test_modorder_y_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					 &bpf_test_modorder_y_set);
+}
+
+static void __exit bpf_test_modorder_y_exit(void)
+{
+}
+
+module_init(bpf_test_modorder_y_init);
+module_exit(bpf_test_modorder_y_exit);
+
+MODULE_DESCRIPTION("BPF selftest ordertest module Y");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c b/tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c
new file mode 100644
index 0000000000000000000000000000000000000000..48c0560d398e2a14d0682e309cdfc99def244720
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <testing_helpers.h>
+
+#include "kfunc_module_order.skel.h"
+
+static int test_run_prog(const struct bpf_program *prog,
+			 struct bpf_test_run_opts *opts)
+{
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		return err;
+
+	if (!ASSERT_EQ((int)opts->retval, 0, bpf_program__name(prog)))
+		return -EINVAL;
+
+	return 0;
+}
+
+void test_kfunc_module_order(void)
+{
+	struct kfunc_module_order *skel;
+	char pkt_data[64] = {};
+	int err = 0;
+
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, test_opts, .data_in = pkt_data,
+			    .data_size_in = sizeof(pkt_data));
+
+	err = load_module("bpf_test_modorder_x.ko",
+			  env_verbosity > VERBOSE_NONE);
+	if (!ASSERT_OK(err, "load bpf_test_modorder_x.ko"))
+		return;
+
+	err = load_module("bpf_test_modorder_y.ko",
+			  env_verbosity > VERBOSE_NONE);
+	if (!ASSERT_OK(err, "load bpf_test_modorder_y.ko"))
+		goto exit_modx;
+
+	skel = kfunc_module_order__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kfunc_module_order__open_and_load()")) {
+		err = -EINVAL;
+		goto exit_mods;
+	}
+
+	test_run_prog(skel->progs.call_kfunc_xy, &test_opts);
+	test_run_prog(skel->progs.call_kfunc_yx, &test_opts);
+
+	kfunc_module_order__destroy(skel);
+exit_mods:
+	unload_module("bpf_test_modorder_y", env_verbosity > VERBOSE_NONE);
+exit_modx:
+	unload_module("bpf_test_modorder_x", env_verbosity > VERBOSE_NONE);
+}
diff --git a/tools/testing/selftests/bpf/progs/kfunc_module_order.c b/tools/testing/selftests/bpf/progs/kfunc_module_order.c
new file mode 100644
index 0000000000000000000000000000000000000000..76003d04c95f4eaef4c9f3ec640a0da2a20253e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_module_order.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+extern int bpf_test_modorder_retx(void) __ksym;
+extern int bpf_test_modorder_rety(void) __ksym;
+
+SEC("classifier")
+int call_kfunc_xy(struct __sk_buff *skb)
+{
+	int ret1, ret2;
+
+	ret1 = bpf_test_modorder_retx();
+	ret2 = bpf_test_modorder_rety();
+
+	return ret1 == 'x' && ret2 == 'y' ? 0 : -1;
+}
+
+SEC("classifier")
+int call_kfunc_yx(struct __sk_buff *skb)
+{
+	int ret1, ret2;
+
+	ret1 = bpf_test_modorder_rety();
+	ret2 = bpf_test_modorder_retx();
+
+	return ret1 == 'y' && ret2 == 'x' ? 0 : -1;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.47.0


