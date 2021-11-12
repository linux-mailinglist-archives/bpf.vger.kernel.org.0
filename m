Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1444E144
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhKLFF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BBFC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:03:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so6356379pjl.2
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDgKWUnYPrYdnc8sXNCzoywOYMeBnpEezc4bUV7YcUM=;
        b=m7vEZ4Qr5fDB83DM0tWP5dNJ2m4XKbSBb9uIwXWmyKnGEu9GSOM40mjtJaBxa2S52V
         QP0XKhhqD8xiViqqe/ZfHROWrSrD10nHOkAbOA97RKVz9WQk+jRhpGDboS5ivB/Fz+Mr
         z6hBOhJ1+k5aOcKQm5oaKCT3KP1oAGqQBMpei/sqOd+22fDgPnBn7GT1t5KaGELuT2Em
         7o10X7mRcA2L7HD8SoNY9Xc6/uit+d7CFqNGoZ4DLkomE/3FlbMEowJqzSFNC1raam4i
         reLYTeuEcnaVl2fWmMvCErijOeSfKBOkUJ9dGQhaiR3ntENHVfWjZCTH3DMDRxyMbJco
         vmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDgKWUnYPrYdnc8sXNCzoywOYMeBnpEezc4bUV7YcUM=;
        b=hmDyYyrDeZ0izpwcgekIhk0f2g61LjA6LSnrSEIgYrlTnuUAO1OW2XFTrjchu5XMs5
         B6GiLbtPQMwfZ3ol9zjMGRLRpkkVCRfzk18A1Ww1xZHJRyGkW116BuSa1fBDKJH4LLrw
         eM5orey5BYBwjbN9fS4KgGTrDWqNnWyXxFCfBkGtXQRdu/kXFVaca4JQ8IZr0OEQ5/E7
         Ig3oXh+cat2XipSBdwDiLUt1e7+s1HIeP9ZB30oGYUqHbwp8JsmdsRxIikW5OYGZAoJZ
         y7la/yuu7qG/cSsJsKnyHNFS65XSLiPKWcLDMlkXOu/yEZmsKUUTdHE6/L4v8qlG/fJ4
         E/yg==
X-Gm-Message-State: AOAM533Bb5axI/GWXK33qUCwKkRvCT4piAaNc5qsHqyfvZ5f1iCNJKN0
        UzSz13ZZ/7DSQNRvp5GdeEM=
X-Google-Smtp-Source: ABdhPJzuU2UsoY/0K7Y9VWFCplqcs71Y4KE/b9HObngv59F2/Qy9oVytMoN/XPH9xvqCMva0emSFsw==
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr14258262pjb.15.1636693384837;
        Thu, 11 Nov 2021 21:03:04 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id y9sm9959997pjt.27.2021.11.11.21.03.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:03:04 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 12/12] selftests/bpf: Additional test for CO-RE in the kernel.
Date:   Thu, 11 Nov 2021 21:02:30 -0800
Message-Id: <20211112050230.85640-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
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
 .../selftests/bpf/prog_tests/core_kern.c      | 21 +++++++
 tools/testing/selftests/bpf/progs/core_kern.c | 60 +++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 539a70b3b770..df6a9865b3b5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -326,7 +326,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	kfunc_call_test_subprog.c map_ptr_kern.c
+	kfunc_call_test_subprog.c map_ptr_kern.c core_kern.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern.c b/tools/testing/selftests/bpf/prog_tests/core_kern.c
new file mode 100644
index 000000000000..f64843c5728c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_kern.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "test_progs.h"
+#include "core_kern.lskel.h"
+
+void test_core_kern_lskel(void)
+{
+	struct core_kern_lskel *skel;
+	int err;
+
+	skel = core_kern_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	err = core_kern_lskel__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+cleanup:
+	core_kern_lskel__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
new file mode 100644
index 000000000000..5ec308aac9b5
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
+        return randmap(from_dev->ifindex);
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

