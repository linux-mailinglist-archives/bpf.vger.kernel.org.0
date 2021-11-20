Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD886457AD5
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhKTDgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbhKTDge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD1C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so12344752pjb.5
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POLYLsyIp7Ocnfx6p+aQfnHjrvLUedogDLCl0paxYIs=;
        b=BERUup5kddq7cCzXho+ceQ06uhTD9RjwRZWLi4Ad/xpCEoJMPSxXsHPIx391qvxs2z
         ifF0tNDdbzGpIz8laFWJivf1HRVSZ4bcR0U625l81xiZVlSQC6rLknf546E7muYimRFJ
         zmwd6IdodUNVmEiVFyTkIvzyHC5dPQHSsht+SyElLCQSLl5ol6zvFsm6Z3eKzYIVxdFY
         ty2cpvIguDSOf3GNVwnqHlC4XMjzIW+8sucVzifmr/UcAW3FU7EwzAk2Jzk4lrn+wJap
         GlXYbgkvKn0DPp+/3VyQBtllYVYh7qYMthQmrmZEjZ33grKIlDVAbu5gWgXUHD6D17E6
         3SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POLYLsyIp7Ocnfx6p+aQfnHjrvLUedogDLCl0paxYIs=;
        b=oyYAssY7XV1O27+da6Vi7rmSlJiZ7QbXKCJ+fQtoKlQ0Yiisc7G8ZOCok/leTiJtMW
         CrhwoB8I1OeFLWdOiMJYWhsWXkEVXbei4VJlFjlI8Qd0HYcvIgRS/5E+oj7oDDZ7+ucd
         Bz6FuDlwCRWr5NUFRGqQC0ph7blfmIZHD0aGZZ8tzkdqGicT/oqJ6xkUFTb6cVoXHNPe
         Zfp5HBozx1mxRFqmly9SrGyml/w7FThZDmV3B962bxL4AnWlR7ZIfVpB3aES2A50Mg7O
         a8+MBHA4B3FRz3dTTdhzaIEN4k2Ybf+KxBXdMclIJJRO9t27q9bHX146hJaXsy5R5KPY
         Y+6w==
X-Gm-Message-State: AOAM5321FRK9DYwDwTei7rpF867UDtw1rB/FuqHFBsApZlofTWblSmrq
        5yLMU7/xUKzxi+9opQw0K4U=
X-Google-Smtp-Source: ABdhPJzntO2hvkDzjmecEzExE00ghE73reu0QKa0ZpjSZImxfI+C5VYCvcIHkcxyZoMaYQ9PlOaquQ==
X-Received: by 2002:a17:90a:6bc2:: with SMTP id w60mr6385409pjj.88.1637379211353;
        Fri, 19 Nov 2021 19:33:31 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id f21sm1038755pfc.85.2021.11.19.19.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:31 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 12/13] selftests/bpf: Additional test for CO-RE in the kernel.
Date:   Fri, 19 Nov 2021 19:32:54 -0800
Message-Id: <20211120033255.91214-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Additional test where randmap() function is appended to three different bpf
programs. That action checks struct bpf_core_relo replication logic and offset
adjustment.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/core_kern.c      | 14 +++++
 tools/testing/selftests/bpf/progs/core_kern.c | 60 +++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4fd040f5944b..139d7e5e0a5f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -326,7 +326,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	map_ptr_kern.c
+	map_ptr_kern.c core_kern.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern.c b/tools/testing/selftests/bpf/prog_tests/core_kern.c
new file mode 100644
index 000000000000..561c5185d886
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_kern.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "test_progs.h"
+#include "core_kern.lskel.h"
+
+void test_core_kern_lskel(void)
+{
+	struct core_kern_lskel *skel;
+
+	skel = core_kern_lskel__open_and_load();
+	ASSERT_OK_PTR(skel, "open_and_load");
+	core_kern_lskel__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
new file mode 100644
index 000000000000..3b4571d68369
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, u32);
+	__uint(max_entries, 256);
+} array1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, u32);
+	__uint(max_entries, 256);
+} array2 SEC(".maps");
+
+int randmap(int v)
+{
+	struct bpf_map *map = (struct bpf_map *)&array1;
+	int key = bpf_get_prandom_u32() & 0xff;
+	int *val;
+
+	if (bpf_get_prandom_u32() & 1)
+		map = (struct bpf_map *)&array2;
+
+	val = bpf_map_lookup_elem(map, &key);
+	if (val)
+		*val = bpf_get_prandom_u32() + v;
+
+	return 0;
+}
+
+SEC("tp_btf/xdp_devmap_xmit")
+int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device
+	     *from_dev, const struct net_device *to_dev, int sent, int drops,
+	     int err)
+{
+	return randmap(from_dev->ifindex);
+}
+
+SEC("fentry/eth_type_trans")
+int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
+	     struct net_device *dev, unsigned short protocol)
+{
+	return randmap(dev->ifindex + skb->len);
+}
+
+SEC("fexit/eth_type_trans")
+int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
+	     struct net_device *dev, unsigned short protocol)
+{
+	return randmap(dev->ifindex + skb->len);
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.30.2

