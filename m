Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8357F5D40C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBQOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jul 2019 12:14:25 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:41245 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfGBQOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jul 2019 12:14:25 -0400
Received: by mail-yw1-f73.google.com with SMTP id b75so2602621ywh.8
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2019 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GYVO1LO6UrJeYu2NeQIOegyiGtFk4bH08XtvTk8tXo8=;
        b=nkFtxHvM201xlH19C3fzvhFu6iqZllmbb5WJjJlredmYNC0kAcT8TsZU88wcP55yGw
         kKr2+WaZKU325BEs+9XIQGFspA/8SHV37kGatLmJ8YIODSW4cBehBTDLK22mEsh2bJ3i
         uFL7+0tiaPJ06giygLTauteokCZ0RVqJRnQvXSWLxiaDeUD2diuUGsROC/s/7M5qjdPN
         d8/5TpyIkPMv7n7Xj5rydAefAM0Mv0gvIfwDrEaZbYdvH7KwwknHvUtjnR5bTg8RoTJ5
         YBYe8orP0bKpDL8mkzoBBJ0Ec/so/bS9zZNxB77PMnND0WrxdcOtWtWI/ARtqNXrIXAf
         RhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GYVO1LO6UrJeYu2NeQIOegyiGtFk4bH08XtvTk8tXo8=;
        b=mp3gdmiviij1Jo6oho1UevC5muZiXwT8KyPJqajuHDe2Y6fkBibLrYzKXcY5M0JxGj
         o3YFUSysSB1Oxj4ZKDHdfkUZMk5sqNP8vRmgGphx8dXhFheGNbCyy2VQQhHnNebDbHwz
         CuZdfWkGKCopIqp8UUBVqmpO/XK3FJIgolyO2qSdoxGLSurtyViphh+zB8oUP0Js0hM0
         eXZ33bw3W1SWEp7T67VL7Y+1N52qmIlGmkAphhXQI6dUqONbvbtN4A0D1NnqWPaCgorA
         lel/zKE0LFdYGIQpAJ2zcf6yx8Yotf9FnggFIZ+9NrdXZhk3gmnPidNmibYnHjqI1SEp
         RU+A==
X-Gm-Message-State: APjAAAXayl+MXScPxyb251y3va8xvoYrKkM1XTPeFouNtB2Mqj1/dCfU
        OAojnKi47s4VYyjnGOtWKCecWyA=
X-Google-Smtp-Source: APXvYqzkky87tLfn8KYiouvVoyQsH4G6fXrLn5iTFeYcR/izCg5xvt31WgjGfyeuTgAPOGAs1OjGeOU=
X-Received: by 2002:a25:2005:: with SMTP id g5mr1474361ybg.410.1562084064502;
 Tue, 02 Jul 2019 09:14:24 -0700 (PDT)
Date:   Tue,  2 Jul 2019 09:14:02 -0700
In-Reply-To: <20190702161403.191066-1-sdf@google.com>
Message-Id: <20190702161403.191066-8-sdf@google.com>
Mime-Version: 1.0
References: <20190702161403.191066-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v2 7/8] samples/bpf: add sample program that
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
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 samples/bpf/Makefile             |  1 +
 samples/bpf/tcp_dumpstats_kern.c | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
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
index 000000000000..8557913106a0
--- /dev/null
+++ b/samples/bpf/tcp_dumpstats_kern.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Refer to samples/bpf/tcp_bpf.readme for the instructions on
+ * how to run this sample program.
+ */
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

