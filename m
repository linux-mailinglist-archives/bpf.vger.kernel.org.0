Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563873B7818
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhF2S7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhF2S67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:58:59 -0400
Received: from mail-oi1-x261.google.com (mail-oi1-x261.google.com [IPv6:2607:f8b0:4864:20::261])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA23C061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:29 -0700 (PDT)
Received: by mail-oi1-x261.google.com with SMTP id u11so27461028oiv.1
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xAoJ+gxbgdnjL87J4ESxXPhmq2ingAzK0OCAON86gBg=;
        b=IlUoBoZCXW3TBd/fVlp7gITMl8yxrX2nuURGdMKKuk61S58s0fBKhPk8uuvuClzCeV
         MdUQdTT8aGOr1xbfSOBumVRBQw4jCICCk0AKnDenBS5/kaBMv9VQgdQaF/KrI1V0io7m
         7njTkOfjK/CWUNFgZ/4RmAsIRExaiEqunrknJI4U/A3H5AotmWiE5QlLiMJQWF7vV5JM
         TDCHAnwbinu/C/ERudX9uUQsv9pfCFCiDhMAM6DxYc2O3VrLlbECguiAJZxEDuUuZlN6
         I6z1/WqaA0HsVG4+teP1GmH11UqzsTBgrRvpMw92ds9GUAKyk/JrUKjp3hcwOGhtwvEe
         i1HQ==
X-Gm-Message-State: AOAM5311R4dhBRhtcLNCFS8POKz6ddtGs9p6NQlEaryA97CILcYt78YN
        rEQXAMrySaeGUdeOB6VGe2B6eaJIIJnAX3hke5iep+T7m39MdA==
X-Google-Smtp-Source: ABdhPJzpEvwwZ0cwtURj3xLlN2U/INPhXlxnSVj5ddWckjftpsY9ohGREGsWwvYpB3jZcW/WocuITCPucxHx
X-Received: by 2002:aca:c487:: with SMTP id u129mr224491oif.63.1624992989347;
        Tue, 29 Jun 2021 11:56:29 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.60])
        by smtp-relay.gmail.com with ESMTPS id e22sm6927256oop.4.2021.06.29.11.56.28
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:29 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    by restore.menlosecurity.com (13.56.32.60)
    with SMTP id b6283c90-d90b-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 18:56:29 GMT
Received: from mail-pj1-f70.google.com (209.85.216.70)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    with SMTP id b6283c90-d90b-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 18:56:29 GMT
Received: by mail-pj1-f70.google.com with SMTP id br8-20020a17090b0f08b02901706e80711dso123931pjb.5
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAoJ+gxbgdnjL87J4ESxXPhmq2ingAzK0OCAON86gBg=;
        b=YtHDb1EIFe1smdqsaJozaNHhEfakaSeBeXTPDKj87vMZRHyTPNNOIacpYRv9zHQM7T
         SI72T9rsOaSDnvXUvGhyVhB3gp6ynB/31SPq/naO1hFn8fPFBNXjxYeUn5TAqZdbRA0I
         kYepl/dweuw3HcLfCCBnIc3LiqewNtlDGfUn8=
X-Received: by 2002:a65:6441:: with SMTP id s1mr7148063pgv.214.1624992987965;
        Tue, 29 Jun 2021 11:56:27 -0700 (PDT)
X-Received: by 2002:a65:6441:: with SMTP id s1mr7148045pgv.214.1624992987679;
        Tue, 29 Jun 2021 11:56:27 -0700 (PDT)
Received: from localhost.localdomain ([12.219.129.130])
        by smtp.googlemail.com with ESMTPSA id t14sm19641260pfe.45.2021.06.29.11.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:27 -0700 (PDT)
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
To:     bpf@vger.kernel.org
Cc:     dsahern@gmail.com,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Subject: [PATCH 3/3] selftests: Add selftests for fwmark support in bpf_fib_lookup
Date:   Tue, 29 Jun 2021 11:55:37 -0700
Message-Id: <20210629185537.78008-4-rumen.telbizov@menlosecurity.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
References: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests for ensuring:
     * IPv4 route match according to ip rule fwmark
     * IPv6 route match according to ip rule fwmark

Signed-off-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_bpf_fib_lookup.c | 135 ++++++++++++++
 .../selftests/bpf/test_bpf_fib_lookup.sh      | 166 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
 create mode 100755 tools/testing/selftests/bpf/test_bpf_fib_lookup.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 511259c2c6c5..afbac539e20d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -73,6 +73,7 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
+	test_bpf_fib_lookup.sh \
 	test_doc_build.sh \
 	test_xsk.sh
 
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c b/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
new file mode 100644
index 000000000000..e4bbfb01ab86
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * @author:  Rumen Telbizov <telbizov@gmail.com> <rumen.telbizov@menlosecurity.com>
+ * @created: Wed Jun 23 17:33:19 UTC 2021
+ *
+ * @description:
+ * Perform tests against bpf_fib_lookup()
+ * Communicates the results back via the trace buffer for the calling script
+ * to parse - /sys/kernel/debug/tracing/trace
+ *
+ */
+
+#include <arpa/inet.h>
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/if_ether.h>
+#include <bpf/bpf_helpers.h>
+
+#define BPF_TRACE(fmt, ...) \
+({ \
+	static const char ____fmt[] = fmt; \
+	bpf_trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__); \
+})
+
+SEC("test_egress_ipv4_fwmark")
+int __test_egress_ipv4_fwmark(struct __sk_buff *skb)
+{
+	void *data      = (void *)(long)skb->data;
+	void *data_end  = (void *)(long)skb->data_end;
+	struct bpf_fib_lookup fib;
+	struct ethhdr *eth = data;
+	struct iphdr *ip = data + sizeof(*eth);
+
+	if (data + sizeof(*eth) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != htons(ETH_P_IP))
+		return TC_ACT_OK;
+
+	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
+		return TC_ACT_OK;
+
+	if (ip->protocol != IPPROTO_ICMP)
+		return TC_ACT_OK;
+
+	if (htonl(ip->daddr) != 0x01020304)
+		return TC_ACT_OK;
+
+	__builtin_memset(&fib, 0x0, sizeof(fib));
+
+	fib.family      = AF_INET;
+	fib.l4_protocol = ip->protocol;
+	fib.tot_len     = htons(ip->tot_len);
+	fib.ifindex     = skb->ifindex;
+	fib.tos         = ip->tos;
+	fib.ipv4_src    = ip->saddr;
+	fib.ipv4_dst    = ip->daddr;
+	fib.mark        = skb->mark;
+
+	if (bpf_fib_lookup(skb, &fib, sizeof(fib), 0) < 0)
+		return TC_ACT_OK;
+
+	BPF_TRACE("<test_bpf_fib_lookup: test_egress_ipv4_fwmark> fib.ipv4_dst: <%x> mark: <%d>",
+		  htonl(fib.ipv4_dst), skb->mark);
+	return TC_ACT_OK;
+}
+
+SEC("test_egress_ipv6_fwmark")
+int __test_egress_ipv6_fwmark(struct __sk_buff *skb)
+{
+	void *data      = (void *)(long)skb->data;
+	void *data_end  = (void *)(long)skb->data_end;
+	struct in6_addr *src, *dst;
+	struct bpf_fib_lookup fib;
+	struct ethhdr *eth = data;
+	struct ipv6hdr *ip = data + sizeof(*eth);
+
+	if (data + sizeof(*eth) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	if (data + sizeof(*eth) + sizeof(*ip) > data_end)
+		return TC_ACT_OK;
+
+	if (ip->nexthdr != IPPROTO_ICMPV6)
+		return TC_ACT_OK;
+
+	/* 2000::2000 */
+	if (!(ntohs(ip->daddr.s6_addr16[0]) == 0x2000 &&
+	      ntohs(ip->daddr.s6_addr16[1]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[2]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[3]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[4]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[5]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[6]) == 0x0000 &&
+	      ntohs(ip->daddr.s6_addr16[7]) == 0x2000))
+		return TC_ACT_OK;
+
+	__builtin_memset(&fib, 0x0, sizeof(fib));
+
+	fib.family      = AF_INET6;
+	fib.flowinfo    = 0;
+	fib.l4_protocol = ip->nexthdr;
+	fib.tot_len     = ntohs(ip->payload_len);
+	fib.ifindex     = skb->ifindex;
+	fib.mark        = skb->mark;
+
+	src = (struct in6_addr *)fib.ipv6_src;
+	dst = (struct in6_addr *)fib.ipv6_dst;
+	*src = ip->saddr;
+	*dst = ip->daddr;
+
+	if (bpf_fib_lookup(skb, &fib, sizeof(fib), 0) < 0)
+		return TC_ACT_OK;
+
+	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<0-2>: <%04x:%04x:%04x>",
+		  ntohs(dst->s6_addr16[0]), ntohs(dst->s6_addr16[1]),
+		  ntohs(dst->s6_addr16[2])
+	);
+	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<3-5>: <%04x:%04x:%04x>",
+		  ntohs(dst->s6_addr16[3]), ntohs(dst->s6_addr16[4]),
+		  ntohs(dst->s6_addr16[5])
+	);
+	BPF_TRACE("<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<6-7>: <%04x:%04x> mark: <%d>",
+		  ntohs(dst->s6_addr16[6]), ntohs(dst->s6_addr16[7]), skb->mark
+	);
+
+	return TC_ACT_OK;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh b/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh
new file mode 100755
index 000000000000..4b8cc984b486
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpf_fib_lookup.sh
@@ -0,0 +1,166 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# @author:  Rumen Telbizov <telbizov@gmail.com> <rumen.telbizov@menlosecurity.com>
+# @created: Wed Jun 23 17:33:19 UTC 2021
+# @description:
+# Test coverage for bpf_fib_lookup():
+#  * IPv4 route match according to ip rule fwmark
+#  * IPv6 route match according to ip rule fwmark
+#
+
+#
+# Global Variables
+#
+PASS=0
+FAIL=0
+
+CYAN='\033[0;36m'
+GREEN='\033[0;92m'
+RED='\033[0;31m'
+NC='\033[0m'
+
+#
+# Functions
+#
+setup() {
+    ip netns add ns1
+    ip netns add ns2
+
+    ip link add veth1 index 100 type veth peer name veth2 index 200
+    ip link set veth1 netns ns1 up
+    ip link set veth2 netns ns2 up
+
+    ip netns exec ns1 sysctl net.ipv4.ip_forward=1 >/dev/null
+    ip netns exec ns1 sysctl net.ipv6.conf.all.forwarding=1 >/dev/null
+
+    ip netns exec ns1 ip addr  add dev veth1 192.168.0.100/24
+    ip netns exec ns2 ip addr  add dev veth2 192.168.0.1/24
+    ip netns exec ns2 ip addr  add dev veth2 192.168.0.2/24
+
+    ip netns exec ns1 ip route add default via 192.168.0.1
+    ip netns exec ns1 ip route add default via 192.168.0.2 table 2
+
+
+    ip netns exec ns1 ip -6 addr add dev veth1 fd00::100/64 nodad
+    ip netns exec ns2 ip -6 addr add dev veth2 fd00::1/64   nodad
+    ip netns exec ns2 ip -6 addr add dev veth2 fd00::2/64   nodad
+
+    ip netns exec ns1 ip -6 route add default via fd00::1
+    ip netns exec ns1 ip -6 route add default via fd00::2 table 2
+
+    ip netns exec ns1 ip    rule add prio 2 fwmark 2 lookup 2
+    ip netns exec ns1 ip -6 rule add prio 2 fwmark 2 lookup 2
+
+    ip netns exec ns1 tc qdisc  add dev veth1 clsact
+}
+
+
+cleanup() {
+    echo > /sys/kernel/debug/tracing/trace
+    ip netns del ns1 2>/dev/null
+    ip netns del ns2 2>/dev/null
+}
+
+
+test_egress_ipv4_fwmark() {
+    echo -e "- Running ${CYAN}${FUNCNAME[0]}${NC}"
+    ip netns exec ns1 tc filter del dev veth1 egress
+    ip netns exec ns1 tc filter add dev veth1 egress \
+	bpf da obj test_bpf_fib_lookup.o sec test_egress_ipv4_fwmark
+
+    echo -n "  * mark 0: "
+    echo > /sys/kernel/debug/tracing/trace
+    ip netns exec ns1 ping -W 0.1 -c 1 1.2.3.4 >/dev/null
+    grep -q '<test_bpf_fib_lookup: test_egress_ipv4_fwmark> fib.ipv4_dst: <c0a80001> mark: <0>' \
+        /sys/kernel/debug/tracing/trace
+    if [ $? -eq 0 ]; then
+        PASS=$(($PASS+1))
+        echo -e ${GREEN}"PASS"${NC}
+    else
+        FAIL=$(($FAIL+1))
+        echo -e ${RED}"FAIL"${NC}
+    fi
+
+    echo -n "  * mark 2: "
+    echo > /sys/kernel/debug/tracing/trace
+    ip netns exec ns1 ping -W 0.1 -c 1 1.2.3.4 -m 2 >/dev/null
+    grep -q '<test_bpf_fib_lookup: test_egress_ipv4_fwmark> fib.ipv4_dst: <c0a80002> mark: <2>' \
+        /sys/kernel/debug/tracing/trace
+    if [ $? -eq 0 ]; then
+        PASS=$(($PASS+1))
+        echo -e ${GREEN}"PASS"${NC}
+    else
+        FAIL=$(($FAIL+1))
+        echo -e ${RED}"FAIL"${NC}
+    fi
+}
+
+
+test_egress_ipv6_fwmark() {
+    echo -e "- Running ${CYAN}${FUNCNAME[0]}${NC}"
+    ip netns exec ns1 tc filter del dev veth1 egress
+    ip netns exec ns1 tc filter add dev veth1 egress \
+	bpf da obj test_bpf_fib_lookup.o sec test_egress_ipv6_fwmark
+
+    echo -n "  * mark 0: "
+    echo > /sys/kernel/debug/tracing/trace
+    ip netns exec ns1 ping -6 -W 0.1 -c 1 2000::2000 >/dev/null
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<0-2>: <fd00:0000:0000>' \
+        /sys/kernel/debug/tracing/trace
+    rc1=$?
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<3-5>: <0000:0000:0000>' \
+        /sys/kernel/debug/tracing/trace
+    rc2=$?
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<6-7>: <0000:0001> mark: <0>' \
+        /sys/kernel/debug/tracing/trace
+    rc3=$?
+    if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ] && [ $rc3 -eq 0 ]; then
+        PASS=$(($PASS+1))
+        echo -e ${GREEN}"PASS"${NC}
+    else
+        FAIL=$(($FAIL+1))
+        echo -e ${RED}"FAIL"${NC}
+    fi
+
+    echo -n "  * mark 2: "
+    echo > /sys/kernel/debug/tracing/trace
+    ip netns exec ns1 ping -6 -W 0.1 -c 1 2000::2000 -m 2 >/dev/null
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<0-2>: <fd00:0000:0000>' \
+        /sys/kernel/debug/tracing/trace
+    rc1=$?
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<3-5>: <0000:0000:0000>' \
+        /sys/kernel/debug/tracing/trace
+    rc2=$?
+    grep -q '<test_bpf_fib_lookup - egress_IPv6> fib.ipv6_dst<6-7>: <0000:0002> mark: <2>' \
+        /sys/kernel/debug/tracing/trace
+    rc3=$?
+    if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ] && [ $rc3 -eq 0 ]; then
+        PASS=$(($PASS+1))
+        echo -e ${GREEN}"PASS"${NC}
+    else
+        FAIL=$(($FAIL+1))
+        echo -e ${RED}"FAIL"${NC}
+    fi
+}
+
+#
+# MAIN
+#
+
+trap cleanup 0 3 6 2 9
+echo "[$(basename $0)] START"
+
+cleanup
+setup
+
+test_egress_ipv4_fwmark
+test_egress_ipv6_fwmark
+
+cleanup
+
+echo "[$(basename $0)] PASS: $PASS -- FAIL: $FAIL"
+if [ $FAIL -gt 0 ]; then
+    exit 1
+fi
+exit 0
-- 
2.30.1 (Apple Git-130)

