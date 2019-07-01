Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0851E5C482
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGAUso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 16:48:44 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56024 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfGAUsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:43 -0400
Received: by mail-vk1-f201.google.com with SMTP id b85so3906612vke.22
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ABU5Wq16YVDAqCRXg4jt4WKykxR9zBYv9w101IaTts=;
        b=v10Ei6UqcrjLTMsoWFDNFg26AcFYtolnV+CW682Ie1oImF1RMx6dduFpw1UfgoZu0J
         oq0CEQzSosmt88hROqK8dkYmZLHtwntmO7k9eAilHkZySToZccbTfY+yfoSLg4xl9vbB
         V0p05ILfZT1XwnhI7niCTCWmAU+no0y+v/3CW+0QlA4o4AQCCNd217K+BGD6wNQlo+2X
         08TB+aXVxJ+JOcwYRYSBQZtfR9qZt7HAFpaDgawGj36upQuWz/FRfgc49R0ccb4LOBM9
         OteOXv7LqFc+o4aWVWbtRCMclTN+pEU2M8kKaJ3RwKJf6UpiseFhKfSrHDAOLB5i36IV
         awSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ABU5Wq16YVDAqCRXg4jt4WKykxR9zBYv9w101IaTts=;
        b=Pjzbm5xPKV+0399fT68uMdMrlZSPgLStwUKxFn320QhScsMEcdEcWTXrmVTmo6yXMk
         LRqsOU/n4kRuXQQokBtroCFd9o1F943K/UEVApcot6WB1iBiHDL2xY2EmvLTa9Pr3HDG
         0yI1xfWRDRfy5MJt0D/4bPYdzn3w/ysS+T7Vzm0hI/GkIsJDGbpYWjqb/53NU0OirgMU
         mSgEh0X8AFH/s+4s881uUo/CpxXg7G+++XhUAFshiw2D+RXPULc+DQXZLZB3H6EFt+O7
         /H7zCrY0BTWbDH59gSPLPA2Vr9rqic+huLGlh7oeVuhh4CxMddXwyvMiBw8BVzR2s96p
         E4pw==
X-Gm-Message-State: APjAAAWtJ8UDcff/K7ss4nz6cPiuXUiORTGJxGJ20cUWpS0WAE4Yq+HT
        VZ6GW0PJvHcpn81XHTY2t7FZkeg=
X-Google-Smtp-Source: APXvYqwR4r9Fv5U9fAHYTlT2WwxAAO1SQXO5g9P12hybl4Q5yjlsuro9EG+43Qj5gGeHQHFPlVEZhc8=
X-Received: by 2002:a67:c410:: with SMTP id c16mr15234498vsk.227.1562014122062;
 Mon, 01 Jul 2019 13:48:42 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:48:20 -0700
In-Reply-To: <20190701204821.44230-1-sdf@google.com>
Message-Id: <20190701204821.44230-8-sdf@google.com>
Mime-Version: 1.0
References: <20190701204821.44230-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 7/8] samples/bpf: add sample program that
 periodically dumps TCP stats
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Uses new RTT callback to dump stats every second.

$ mkdir -p /tmp/cgroupv2
$ mount -t cgroup2 none /tmp/cgroupv2
$ mkdir -p /tmp/cgroupv2/foo
$ echo $$ >> /tmp/cgroupv2/foo/cgroup.procs
$ bpftool prog load ./tcp_dumpstats_kern.o /sys/fs/bpf/tcp_prog
$ bpftool cgroup attach /tmp/cgroupv2/foo sock_ops pinned /sys/fs/bpf/tcp_prog
$ bpftool prog tracelog
$ # run neper/netperf/etc

Used neper to compare performance with and without this program attached
and didn't see any noticeable performance impact.

Sample output:
  <idle>-0     [015] ..s.  2074.128800: 0: dsack_dups=0 delivered=242526
  <idle>-0     [015] ..s.  2074.128808: 0: delivered_ce=0 icsk_retransmits=0
  <idle>-0     [015] ..s.  2075.130133: 0: dsack_dups=0 delivered=323599
  <idle>-0     [015] ..s.  2075.130138: 0: delivered_ce=0 icsk_retransmits=0
  <idle>-0     [005] .Ns.  2076.131440: 0: dsack_dups=0 delivered=404648
  <idle>-0     [005] .Ns.  2076.131447: 0: delivered_ce=0 icsk_retransmits=0

Cc: Eric Dumazet <edumazet@google.com>
Cc: Priyaranjan Jha <priyarjha@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 samples/bpf/Makefile             |  1 +
 samples/bpf/tcp_dumpstats_kern.c | 65 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 samples/bpf/tcp_dumpstats_kern.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 0917f8cf4fab..eaebbeead42f 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -154,6 +154,7 @@ always += tcp_iw_kern.o
 always += tcp_clamp_kern.o
 always += tcp_basertt_kern.o
 always += tcp_tos_reflect_kern.o
+always += tcp_dumpstats_kern.o
 always += xdp_redirect_kern.o
 always += xdp_redirect_map_kern.o
 always += xdp_redirect_cpu_kern.o
diff --git a/samples/bpf/tcp_dumpstats_kern.c b/samples/bpf/tcp_dumpstats_kern.c
new file mode 100644
index 000000000000..5d22bf61db65
--- /dev/null
+++ b/samples/bpf/tcp_dumpstats_kern.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+
+#include "bpf_helpers.h"
+#include "bpf_endian.h"
+
+#define INTERVAL			1000000000ULL
+
+int _version SEC("version") = 1;
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__u32 type;
+	__u32 map_flags;
+	int *key;
+	__u64 *value;
+} bpf_next_dump SEC(".maps") = {
+	.type = BPF_MAP_TYPE_SK_STORAGE,
+	.map_flags = BPF_F_NO_PREALLOC,
+};
+
+SEC("sockops")
+int _sockops(struct bpf_sock_ops *ctx)
+{
+	struct bpf_tcp_sock *tcp_sk;
+	struct bpf_sock *sk;
+	__u64 *next_dump;
+	__u64 now;
+
+	switch (ctx->op) {
+	case BPF_SOCK_OPS_TCP_CONNECT_CB:
+		bpf_sock_ops_cb_flags_set(ctx, BPF_SOCK_OPS_RTT_CB_FLAG);
+		return 1;
+	case BPF_SOCK_OPS_RTT_CB:
+		break;
+	default:
+		return 1;
+	}
+
+	sk = ctx->sk;
+	if (!sk)
+		return 1;
+
+	next_dump = bpf_sk_storage_get(&bpf_next_dump, sk, 0,
+				       BPF_SK_STORAGE_GET_F_CREATE);
+	if (!next_dump)
+		return 1;
+
+	now = bpf_ktime_get_ns();
+	if (now < *next_dump)
+		return 1;
+
+	tcp_sk = bpf_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
+	*next_dump = now + INTERVAL;
+
+	bpf_printk("dsack_dups=%u delivered=%u\n",
+		   tcp_sk->dsack_dups, tcp_sk->delivered);
+	bpf_printk("delivered_ce=%u icsk_retransmits=%u\n",
+		   tcp_sk->delivered_ce, tcp_sk->icsk_retransmits);
+
+	return 1;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

