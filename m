Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0A45B426
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhKXGGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhKXGGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:06:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0EC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so973426plf.4
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5a+BSF/Qdw3ABLMN8dlOvCszZIxCKr2sqwCpOsQ5P0=;
        b=IU9ryKLSV5Lhiq+OheuvB4Yqzu/zdLlmBOjLlPYXoR78ktBdxze9Yj6Fs5IlSuxXy2
         aP6vz/CB6kJ+wFpRqyC7JdpfMniXDttQxci+jeIfRaO+KG5Wk2TaiaJeW769LG9L9Nps
         4aMmXeqSTORvr9plPKyCcEQdSqsUrRWYtawwI1zXDY4FDxgoU0ROhFmoEOeMWae7nGtt
         NpE+XpIYkP2X63V7h0gK9ejpw00xYlyf9qGy25RR+o1ljFngenO1Hk5VnHbj1GDtb22v
         IW68HrZcqEPaQOIhjJuzbbZuZuG06iIY2jJYAcm1NOAd4o4LUgZAKzgqO2Rp9uTroEky
         tJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5a+BSF/Qdw3ABLMN8dlOvCszZIxCKr2sqwCpOsQ5P0=;
        b=8C6MGlosOlKU6420kZZJAGipn89BK5GB1haGK6JIJk3NyrroLyTTemy1XuxgJsTx+l
         l7aIrBt0C0rOsApSpedmQ2baKYoTU8IZ1kYc9SHBOYErA9vQmzf4+ZhyMVb4i2ojCc58
         OU0Xkw2IdnW5pE1CYbyRx3a1ZIAp3EtMjHNMgc+peNCQ+6c+4xSBwtWSlYZmuhYYVsyW
         czZwhMM0zb5T8SETyqxbrGwfFOyJKK/pJ7tJZgHUOJ8BzQdLnC6urmqZQ6tc5GK4OehN
         FDZfqZe6KhVKX1Q5KMyXBvURX5MbfSBkef9V1wB5p3b4CpX8qp9G/w7nw33QeXqclQnm
         2x5w==
X-Gm-Message-State: AOAM5311o0nbgMn/M527LRz2zqXha0BX4hJPoMZVlAaL5ItKRKUPnlH6
        wON5xgL2y2qg2CSDhkZIXHQ=
X-Google-Smtp-Source: ABdhPJzS30QBDv3K+5CCsGJw72XsVo3J9Dw99joOM/B4uBvALimy7YCxyvqusJv/vfpUtJ4ayYWt3w==
X-Received: by 2002:a17:902:e851:b0:142:19fe:982a with SMTP id t17-20020a170902e85100b0014219fe982amr14818306plg.13.1637733770970;
        Tue, 23 Nov 2021 22:02:50 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id me7sm3740238pjb.9.2021.11.23.22.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:50 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 14/16] selftests/bpf: Additional test for CO-RE in the kernel.
Date:   Tue, 23 Nov 2021 22:02:07 -0800
Message-Id: <20211124060209.493-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
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
 .../selftests/bpf/prog_tests/core_kern.c      | 14 +++
 tools/testing/selftests/bpf/progs/core_kern.c | 87 +++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
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
index 000000000000..2a40eec581b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define ATTR __always_inline
+#include "test_jhash.h"
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
+static __noinline int randmap(int v, const struct net_device *dev)
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
+		*val = bpf_get_prandom_u32() + v + dev->mtu;
+
+	return 0;
+}
+
+SEC("tp_btf/xdp_devmap_xmit")
+int BPF_PROG(tp_xdp_devmap_xmit_multi, const struct net_device
+	     *from_dev, const struct net_device *to_dev, int sent, int drops,
+	     int err)
+{
+	return randmap(from_dev->ifindex, from_dev);
+}
+
+SEC("fentry/eth_type_trans")
+int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
+	     struct net_device *dev, unsigned short protocol)
+{
+	return randmap(dev->ifindex + skb->len, dev);
+}
+
+SEC("fexit/eth_type_trans")
+int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
+	     struct net_device *dev, unsigned short protocol)
+{
+	return randmap(dev->ifindex + skb->len, dev);
+}
+
+SEC("tc")
+int balancer_ingress(struct __sk_buff *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	void *ptr;
+	int ret = 0, nh_off, i = 0;
+
+	nh_off = 14;
+
+	/* pragma unroll doesn't work on large loops */
+
+#define C do { \
+	ptr = data + i; \
+	if (ptr + nh_off > data_end) \
+		break; \
+	ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+	} while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+	C30;C30;C30; /* 90 calls */
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.30.2

