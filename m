Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3057262908C
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKODKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 22:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiKODKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 22:10:36 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC6CCA
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:10:35 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p1-20020a17090a2c4100b00212733d7aaaso6790349pjm.4
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jO83fAkgz8rUAsfS/dvhp2L3T5zhQC+S2sXZEZfZE3Q=;
        b=qKMn69zADIDXZMEoWjNsPhXib8WrK7MLkeldMmG9bY2Edf1X9ZP31rO4qItzHp8byT
         mPHmr/KVAWdZwKv1mPyO2rohxwVcPaOYFnXM7ZOdM6rNCAC880kOgrF28tzWJSWdK3G1
         /Z10O/zUXOf3D9cVxOTmL718+ZlnIkQXblbFJffQlBAsE/mbgVxzcjvtU5cKBPgsKcCg
         IHU8E9akVk7ih0Vl6PKyajQtyxldyG3MV+YnSY6X/i443aAqyCT7U4zX8qNklaDP4F3V
         vmP0HzYGSPNDeEt6uDqqohsN/h5+XqPGNUETFLxIQT3Zjpw8/aYxmP8vvDiHhjYzomuh
         L78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO83fAkgz8rUAsfS/dvhp2L3T5zhQC+S2sXZEZfZE3Q=;
        b=wpKzRsws/hnAk28mur+o8FltcnEzEETjiTwiZcxdWN+5Q1rle38hSVFxxvN2dzp3ZU
         JiZpLKOFeBpM6luet5SaUre95p+WqrbvN75K6L+FskcmFXKRCdDp3Ni+UeyxWAoq/Jwi
         va8DL6NMBdM5YoJpvwXhy+yaYHmG4UmoL+RGHrfkt5AdVt1VcSYM/wCfc4BPan2SsSi7
         vxyeJnEU4OJI8pdUj1yBKtTPHYCfuPu4wADCrFUwjE1BO+JGdgz4Xvo4grcQsdxWTUTE
         C62YtKTTcGlwhFpFFExWTEeBpRuwJrElxXWZkfQHmEv7dxahrBmjv82TXY5BlCipl3zv
         ilug==
X-Gm-Message-State: ANoB5plHMqmLEzpfFz+a8ZgQnZkvVppmkgYuBYOhCZQtqUNUKzMCWpl4
        v8AVW/ATHE+vsFr02RLkrLnLg+ID4VK5B8z8gb4iqp8zoshp2skqQ+lBwv8YzPXVzvBlF/8Elw1
        S4WSfdEAAtmptzb2V7rT/8yvNNEKkLZRFKs9OPlQOGO5bo1EFyg==
X-Google-Smtp-Source: AA0mqf5Lj2+xvEeOWxAgEl+NsBBahHdx9JZhUAEzJi38S7Zj/Y6F7H5HNoHWHRJ5kn3K+ggvO6Otk10=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1b05:0:b0:461:8ba8:e056 with SMTP id
 b5-20020a631b05000000b004618ba8e056mr14079677pgb.517.1668481834949; Mon, 14
 Nov 2022 19:10:34 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:10:31 -0800
In-Reply-To: <20221115031031.3281094-1-sdf@google.com>
Mime-Version: 1.0
References: <20221115031031.3281094-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115031031.3281094-2-sdf@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Make sure zero-len skbs aren't redirectable
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LWT_XMIT to test L3 case, TC to test L2 case.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/empty_skb.c      | 140 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
 2 files changed, 177 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
new file mode 100644
index 000000000000..6e35739babed
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <net/if.h>
+#include "empty_skb.skel.h"
+
+#define SYS(cmd) ({ \
+	if (!ASSERT_OK(system(cmd), (cmd))) \
+		goto out; \
+})
+
+void test_empty_skb(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
+	struct empty_skb *bpf_obj = NULL;
+	struct nstoken *tok = NULL;
+	struct bpf_program *prog;
+	char eth_hlen_pp[15];
+	char eth_hlen[14];
+	int veth_ifindex;
+	int ipip_ifindex;
+	int err;
+	int i;
+
+	struct {
+		const char *msg;
+		const void *data_in;
+		__u32 data_size_in;
+		int *ifindex;
+		int err;
+		int ret;
+		bool success_on_tc;
+	} tests[] = {
+		/* Empty packets are always rejected. */
+
+		{
+			.msg = "veth empty ingress packet",
+			.data_in = NULL,
+			.data_size_in = 0,
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+		{
+			.msg = "ipip empty ingress packet",
+			.data_in = NULL,
+			.data_size_in = 0,
+			.ifindex = &ipip_ifindex,
+			.err = -EINVAL,
+		},
+
+		/* ETH_HLEN-sized packets:
+		 * - can not be redirected at LWT_XMIT
+		 * - can be redirected at TC
+		 */
+
+		{
+			.msg = "veth ETH_HLEN packet ingress",
+			.data_in = eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &veth_ifindex,
+			.ret = -ERANGE,
+			.success_on_tc = true,
+		},
+		{
+			.msg = "ipip ETH_HLEN packet ingress",
+			.data_in = eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &veth_ifindex,
+			.ret = -ERANGE,
+			.success_on_tc = true,
+		},
+
+		/* ETH_HLEN+1-sized packet should be redirected. */
+
+		{
+			.msg = "veth ETH_HLEN+1 packet ingress",
+			.data_in = eth_hlen_pp,
+			.data_size_in = sizeof(eth_hlen_pp),
+			.ifindex = &veth_ifindex,
+		},
+		{
+			.msg = "ipip ETH_HLEN+1 packet ingress",
+			.data_in = eth_hlen_pp,
+			.data_size_in = sizeof(eth_hlen_pp),
+			.ifindex = &veth_ifindex,
+		},
+
+	};
+
+	SYS("ip netns add empty_skb");
+	tok = open_netns("empty_skb");
+	SYS("ip link add veth0 type veth peer veth1");
+	SYS("ip link set dev veth0 up");
+	SYS("ip link set dev veth1 up");
+	SYS("ip addr add 10.0.0.1/8 dev veth0");
+	SYS("ip addr add 10.0.0.2/8 dev veth1");
+	veth_ifindex = if_nametoindex("veth0");
+
+	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
+	SYS("ip link set ipip0 up");
+	SYS("ip addr add 192.168.1.1/16 dev ipip0");
+	ipip_ifindex = if_nametoindex("ipip0");
+
+	bpf_obj = empty_skb__open_and_load();
+	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		bpf_object__for_each_program(prog, bpf_obj->obj) {
+			char buf[128];
+			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
+
+			tattr.data_in = tests[i].data_in;
+			tattr.data_size_in = tests[i].data_size_in;
+
+			tattr.data_size_out = 0;
+			bpf_obj->bss->ifindex = *tests[i].ifindex;
+			bpf_obj->bss->ret = 0;
+			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
+			sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_program__name(prog));
+
+			if (at_tc && tests[i].success_on_tc)
+				ASSERT_GE(err, 0, buf);
+			else
+				ASSERT_EQ(err, tests[i].err, buf);
+			sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_program__name(prog));
+			if (at_tc && tests[i].success_on_tc)
+				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
+			else
+				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
+		}
+	}
+
+out:
+	if (bpf_obj)
+		empty_skb__destroy(bpf_obj);
+	if (tok)
+		close_netns(tok);
+	system("ip netns del empty_skb");
+}
diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c b/tools/testing/selftests/bpf/progs/empty_skb.c
new file mode 100644
index 000000000000..4b0cd6753251
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/empty_skb.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char _license[] SEC("license") = "GPL";
+
+int ifindex;
+int ret;
+
+SEC("lwt_xmit")
+int redirect_ingress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
+	return 0;
+}
+
+SEC("lwt_xmit")
+int redirect_egress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, 0);
+	return 0;
+}
+
+SEC("tc")
+int tc_redirect_ingress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
+	return 0;
+}
+
+SEC("tc")
+int tc_redirect_egress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, 0);
+	return 0;
+}
-- 
2.38.1.431.g37b22c650d-goog

