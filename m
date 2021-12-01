Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092A04654DD
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbhLASQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbhLASPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:15:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB9C0613ED
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l190so24457955pge.7
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZHlD5uYCukmsHmcRXskFAYwlmPDcwjYiIc1Z8vpdAw=;
        b=iRh83WiIZJxo9b9VvM61L1j9T9GcdHiDWQ7kIQdbpkRUijJpghAdmecUO95KRP1drV
         W5rvAKiTLWh//YFOlTWk3yB5zPPelEwTENIlkCCkA1r3mD10QoFlvaCaxKojBzmIb2G1
         hp4U+CQzPzhx0+56cVWpx6u2MIEaadFdvQ3MCN6Ne7RMz3Nr/rT5CPFSjw+McJnMip9m
         9+3yy1RnmhLdAdL8jw7Iuf05nixo+iXlDrCF2jDqS2/oRTFEUX78PjUsEs1PgGFMyElQ
         lEvq+xa82g3BCcq7ISlKG/w2vG35mOW3S2rQapMTDPscu54QTK9NLPh6CwfgfD7pAMAA
         FoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZHlD5uYCukmsHmcRXskFAYwlmPDcwjYiIc1Z8vpdAw=;
        b=2SVEAm1nPIy19zB3zr2KpNth1grdIHJUSTvqnrGTCcGoqfYaS9hpDMIGpsOubAvPS/
         SmX1i01ob8F2UZvS2LJfjHpDGTcDiAvoFwEjQuK9fN1Hn20EKh9pk4lR0FEspz93nsUS
         s2FeaR6Yq2m9dHabaxNwuNAfCGN0W9SYiKiljT0XKfTourY28xqfemKpdBOcgEGDYaro
         TwgdqX84yh5THtwLpOPlZWvMdows0B2u4zQZTpHHqcEEZfpB5x2gWKeHKCx7cBt4jsMe
         pmlC57g95Su7H0sntU9usttJcvad0xyzQZ13izFv9VxNKHM43LRGU6fS0r9BwIWjVrU1
         Z9SA==
X-Gm-Message-State: AOAM532e4uSPWN/wY+4vK26OMuvuQktUWYfXYn5y0ojlDR/DkLkAKJss
        hSIKBPKwkP942alap9ZbKAaol6spaRk=
X-Google-Smtp-Source: ABdhPJxoeE0XvhB4myBJmUzwZLaAVMfR/WMJ5idQq8zKPA6n7V2ULQ0Ko4Ts/BvYPSmJPSmFKPSzBg==
X-Received: by 2002:a05:6a00:1822:b0:49f:c55b:6235 with SMTP id y34-20020a056a00182200b0049fc55b6235mr7502484pfa.66.1638382285206;
        Wed, 01 Dec 2021 10:11:25 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id c81sm465667pfb.166.2021.12.01.10.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:24 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 15/17] selftests/bpf: Additional test for CO-RE in the kernel.
Date:   Wed,  1 Dec 2021 10:10:38 -0800
Message-Id: <20211201181040.23337-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a test where randmap() function is appended to three different bpf
programs. That action checks struct bpf_core_relo replication logic
and offset adjustment in gen loader part of libbpf.

Fourth bpf program has 360 CO-RE relocations from vmlinux, bpf_testmod,
and non-existing type. It tests candidate cache logic.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/core_kern.c      |  14 +++
 tools/testing/selftests/bpf/progs/core_kern.c | 104 ++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 200ebcc73651..8981369b071b 100644
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
index 000000000000..13499cc15c7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -0,0 +1,104 @@
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
+volatile const int never;
+
+struct __sk_bUfF /* it will not exist in vmlinux */ {
+	int len;
+} __attribute__((preserve_access_index));
+
+struct bpf_testmod_test_read_ctx /* it exists in bpf_testmod */ {
+	size_t len;
+} __attribute__((preserve_access_index));
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
+#define C do { \
+	ptr = data + i; \
+	if (ptr + nh_off > data_end) \
+		break; \
+	ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++); \
+	if (never) { \
+		/* below is a dead code with unresolvable CO-RE relo */ \
+		i += ((struct __sk_bUfF *)ctx)->len; \
+		/* this CO-RE relo may or may not resolve
+		 * depending on whether bpf_testmod is loaded.
+		 */ \
+		i += ((struct bpf_testmod_test_read_ctx *)ctx)->len; \
+	} \
+	} while (0);
+#define C30 C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;C;
+	C30;C30;C30; /* 90 calls */
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.30.2

