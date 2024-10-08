Return-Path: <bpf+bounces-41242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E8A994589
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F1E1C20FD7
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC11C75F8;
	Tue,  8 Oct 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3osnfb8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB6192B91
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383743; cv=none; b=B8BMKFwFiSeuWBN0I6Slhbp6QiXoGT+ExZw95F53gSjGGiw+jK7BVE2DOkgS1t1xtatAQmWmgpJGUY/11m/BvscVvY+bgYu2Fp5BP+pNwg/U81WqWCBL6LAPv49uNFHrgUDEIr/8O5ebCM08ISOUZGAJ4+aYpqKbBwYZ614O2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383743; c=relaxed/simple;
	bh=hdvio31jekZrWc88PWna/SZnf2ogh/eHg9WrPMxt+F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uq9GeSut6/vSe7PPrpjWQkaefepryp5QFTG3FAr51v+DeeD5zgA2WXMPDGNfa0L8yEsgEEAS8JRxqtfKdSVhf9fcAsFKZwMv1LXRR0jdpmcq24J670EuVlD3hm0WGTBfhiEAQFUhxul+/0ni+696U8PdRaz1B1xyZVZi90ZY94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3osnfb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728383739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ictraSdjPOL9YxFw42aYTBzlTsPkKC6d66I8jAe4Ebo=;
	b=Z3osnfb8dmM/xwuhDgQXwzHNbQjUDVSiF+KSzFZilZNpimhbs/4+a5eHzvT4+npbs5MpY5
	o6eMKytgHHT7ZRdSEhjjfdFP1vAcyYUotyv1qvwR309OSBZyh/vSr2xKlu9KxHpH4PzblR
	1DZIPgQcmEF4Po2cMOht9Ar3vmJX8fw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-oK0S3zk3NAaUGTiVGnLA2w-1; Tue, 08 Oct 2024 06:35:38 -0400
X-MC-Unique: oK0S3zk3NAaUGTiVGnLA2w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cd18bd0d6so2640461f8f.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 03:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383737; x=1728988537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ictraSdjPOL9YxFw42aYTBzlTsPkKC6d66I8jAe4Ebo=;
        b=YWA3ZeMce8BueWm4/eiUtz4WgxirCTEExSsJj5Ak5h5CzOrJMvJNtAvMOBYSOguP6T
         Qvft8HgblYczeobICJo3ZfAyf9nhzq3Hi3CcC0qcXvQcRZX5EqndbhCemlUlt7Fya86Y
         ZfuyoB0baAPuqNwWTMwkvrsgYk2Jb3Hl4HTRbxiLPx7r4q30HoIa3ExPOJkuB6UTvFbq
         Kt2mT0kdAP8yvh57cpQWb2f/Y32Xckz8KsW3wEVJR1CBIKGSgzMMgMvmQJABpVkw9Z6x
         x7VqIm2+F5nzuC3RfFTah8BPTQt++c8EyzUoUS2byan24iTkVY4FSr6oKGDNiImXd5sl
         sKAw==
X-Forwarded-Encrypted: i=1; AJvYcCW1zztqbwtumxQ+QK3BMj22IlWqFLvmQJq/9LXUfmtBm1dFUiIchAm2EbOMuK5eQTSjT8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZEzy+KI+2YxpCCrmASbtgqsXLgo5gFw2mgyorWo4GlCYBRNj
	wp55gkf0lDMwpeGvsYomhYKvtiJ0FljsQqthos51GK1/skgExCiuFcxGVrOQKDaOID4xGkCxfSe
	dETxqxK87fGFgoocdnJ8Dsvv8GsJRKCyaLWPOq6RzGgT5N7rXmg==
X-Received: by 2002:a5d:65c9:0:b0:374:c407:4e07 with SMTP id ffacd0b85a97d-37d0e7d43abmr7983899f8f.46.1728383736919;
        Tue, 08 Oct 2024 03:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Ee/83HPJF7kEkGgSeJ8xH2/r8G/imdIwHv7WhzMacUp8aa24FEa+cet9tbARHTx+ed7Nnw==
X-Received: by 2002:a5d:65c9:0:b0:374:c407:4e07 with SMTP id ffacd0b85a97d-37d0e7d43abmr7983886f8f.46.1728383736442;
        Tue, 08 Oct 2024 03:35:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b505sm7786105f8f.43.2024.10.08.03.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:35:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F1D4515F3ADD; Tue, 08 Oct 2024 12:35:32 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 08 Oct 2024 12:35:19 +0200
Subject: [PATCH bpf 4/4] selftests/bpf: Add test for kfunc module order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
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
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/Makefile               |  3 +-
 .../selftests/bpf/prog_tests/kfunc_module_order.c  | 55 ++++++++++++++++++++++
 .../selftests/bpf/progs/kfunc_module_order.c       | 30 ++++++++++++
 tools/testing/selftests/bpf/test_kmods/Makefile    |  3 +-
 .../selftests/bpf/test_kmods/bpf_test_modorder_x.c | 39 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_test_modorder_y.c | 39 +++++++++++++++
 6 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4bde8d57a4e940f4672c6723d05da0c9fd8b62e6..1e3e05d1ab804b585c3083e97c0f3d2c2a6655b8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -152,7 +152,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
-TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko
+TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c b/tools/testing/selftests/bpf/prog_tests/kfunc_module_order.c
new file mode 100644
index 0000000000000000000000000000000000000000..45872bac024246a3f77c636bd840543d50f6adc4
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
+			 struct bpf_test_run_opts *opts, int expect_val)
+{
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		return err;
+
+	if (!ASSERT_EQ((int)opts->retval, expect_val, bpf_program__name(prog)))
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
+	test_run_prog(skel->progs.call_kfunc_xy, &test_opts, 0);
+	test_run_prog(skel->progs.call_kfunc_yx, &test_opts, 0);
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
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 393f407f35baf7e2b657b5d7910a6ffdecb35910..5057c6aacc58be8182be8884854eba846789a2a8 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -7,7 +7,8 @@ else
 Q = @
 endif
 
-MODULES = bpf_testmod.ko bpf_test_no_cfi.ko
+MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
+	bpf_test_modorder_y.ko
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.c
new file mode 100644
index 0000000000000000000000000000000000000000..0cc747fa912fcd5b6738af15dc1b8dfb88c33f6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_x.c
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
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.c
new file mode 100644
index 0000000000000000000000000000000000000000..c627ee085d1305af98c5d7f66d99dcfbf98dc4e1
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_modorder_y.c
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

-- 
2.47.0


