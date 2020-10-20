Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBADA293962
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393337AbgJTKvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 06:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390242AbgJTKvL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603191069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHuaX/N0u2zUKlxZw67FyAdEirtwxjRNTIN1rjGKMKI=;
        b=c7Kqv0hP3ZZGFsYUchEkzTY+xHLGaZ5YMK2DbFRou7bybCuTYSRn6rKKp0izebD5w5mHpg
        7661aXBWzD55lHQ2TaIYwYWesQ/74lNnA2A9D0M2gT+M4Eu8INUvPY+2KXP21djQjEP/o6
        evVwqLA/p77Io+1sb64NERU6pTc1CQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-oOpYwacIPo6DtFyWECRvWQ-1; Tue, 20 Oct 2020 06:51:07 -0400
X-MC-Unique: oOpYwacIPo6DtFyWECRvWQ-1
Received: by mail-wm1-f69.google.com with SMTP id r19so311306wmh.9
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 03:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LHuaX/N0u2zUKlxZw67FyAdEirtwxjRNTIN1rjGKMKI=;
        b=UEtAGfmPzjDTxkDI6ukJki3dS9iAW2kbAVjkTJtNrLwd3UzjxcxbU7x5bbD2YKvcfI
         hQj8GZQVx9XNr05M8rN4vUT88BA2UPvG9h6AN5rCtr7g1wudGr3Nd1sDRR+sk3/sh+mx
         JCvtrezkp9o05yBYggRwOTWb1LTm9O9QG545v4W5IaH6ydpC1suqugFg89IHdMXFHzyJ
         kInKgGq6cJ3mZ6riMSzWPwxL/AByquOwc8BYhy8vyyKdCASqzNXgjZCyJbD6ZWCMCNXu
         4MbBrphL5z6Hfxj4CHUv8/6EuWsyk8JzK44mzQMDDmY38u3skmunXdQCuWls+uh5WzEw
         Ffkw==
X-Gm-Message-State: AOAM532MR9C1zI6w6baQaWCzIwN1lw+IDpbxlUvd5ZHqmflETa9x34T9
        rF2HWmBDy3tsDLECErUsd3YB99hilVmqVWOpF3CG/W6tVB+xDegoQb9/uW/pPFR2Ik/UrRlIQT6
        3+Ks3rsc+0AVr
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr2907555wrx.10.1603191065959;
        Tue, 20 Oct 2020 03:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxObTEdvq6XhspC0dW+u+JgTyvedQafrFhf3dBQ2IwQTA9bIJzH6RGvvlz8H10h2QcGfJLN6g==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr2907519wrx.10.1603191065546;
        Tue, 20 Oct 2020 03:51:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j7sm2369191wrn.81.2020.10.20.03.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 03:51:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 79F231838FA; Tue, 20 Oct 2020 12:51:04 +0200 (CEST)
Subject: [PATCH bpf v2 3/3] selftests: Update test_tc_redirect.sh to use the
 modified bpf_redirect_neigh()
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 20 Oct 2020 12:51:04 +0200
Message-ID: <160319106440.15822.14581567089579452818.stgit@toke.dk>
In-Reply-To: <160319106111.15822.18417665895694986295.stgit@toke.dk>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This updates the test_tc_neigh prog in selftests to use the new syntax of
bpf_redirect_neigh(). To exercise the helper both with and without the
optional parameter, add an additional test_tc_neigh_fib test program, which
does a bpf_fib_lookup() followed by a call to bpf_redirect_neigh() instead
of looking up the ifindex in a map. This second test uses the
BPF_FIB_LOOKUP_SKIP_NEIGH flag in one forwarding direction, but not in the
other, to test both ways of combining the two helpers.

Update the test_tc_redirect.sh script to run both versions of the test, and
while we're add it, fix it to work on systems that have a consolidated
dual-stack 'ping' binary instead of separate ping/ping6 versions.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/progs/test_tc_neigh.c  |    5 -
 .../selftests/bpf/progs/test_tc_neigh_fib.c        |  153 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_tc_redirect.sh    |   18 ++
 3 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c

diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index fe182616b112..b985ac4e7a81 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
 #include <stdint.h>
 #include <stdbool.h>
 
@@ -118,7 +119,7 @@ SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
 	if (bpf_skb_store_bytes(skb, 0, &zero, sizeof(zero), 0) < 0)
 		return TC_ACT_SHOT;
 
-	return bpf_redirect_neigh(get_dev_ifindex(dev_src), 0);
+	return bpf_redirect_neigh(get_dev_ifindex(dev_src), NULL, 0, 0);
 }
 
 SEC("src_ingress") int tc_src(struct __sk_buff *skb)
@@ -142,7 +143,7 @@ SEC("src_ingress") int tc_src(struct __sk_buff *skb)
 	if (bpf_skb_store_bytes(skb, 0, &zero, sizeof(zero), 0) < 0)
 		return TC_ACT_SHOT;
 
-	return bpf_redirect_neigh(get_dev_ifindex(dev_dst), 0);
+	return bpf_redirect_neigh(get_dev_ifindex(dev_dst), NULL, 0, 0);
 }
 
 char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
new file mode 100644
index 000000000000..14792ce3a85c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#ifndef ctx_ptr
+# define ctx_ptr(field)		(void *)(long)(field)
+#endif
+
+#define AF_INET 2
+#define AF_INET6 10
+
+static __always_inline int fill_fib_params_v4(struct __sk_buff *skb,
+					      struct bpf_fib_lookup *fib_params)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct iphdr *ip4h;
+
+	if (data + sizeof(struct ethhdr) > data_end)
+		return -1;
+
+	ip4h = (struct iphdr *)(data + sizeof(struct ethhdr));
+	if ((void *)(ip4h + 1) > data_end)
+		return -1;
+
+	fib_params->family = AF_INET;
+	fib_params->tos = ip4h->tos;
+	fib_params->l4_protocol = ip4h->protocol;
+	fib_params->sport = 0;
+	fib_params->dport = 0;
+	fib_params->tot_len = bpf_ntohs(ip4h->tot_len);
+	fib_params->ipv4_src = ip4h->saddr;
+	fib_params->ipv4_dst = ip4h->daddr;
+
+	return 0;
+}
+
+static __always_inline int fill_fib_params_v6(struct __sk_buff *skb,
+					      struct bpf_fib_lookup *fib_params)
+{
+	struct in6_addr *src = (struct in6_addr *)fib_params->ipv6_src;
+	struct in6_addr *dst = (struct in6_addr *)fib_params->ipv6_dst;
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ipv6hdr *ip6h;
+
+	if (data + sizeof(struct ethhdr) > data_end)
+		return -1;
+
+	ip6h = (struct ipv6hdr *)(data + sizeof(struct ethhdr));
+	if ((void *)(ip6h + 1) > data_end)
+		return -1;
+
+	fib_params->family = AF_INET6;
+	fib_params->flowinfo = 0;
+	fib_params->l4_protocol = ip6h->nexthdr;
+	fib_params->sport = 0;
+	fib_params->dport = 0;
+	fib_params->tot_len = bpf_ntohs(ip6h->payload_len);
+	*src = ip6h->saddr;
+	*dst = ip6h->daddr;
+
+	return 0;
+}
+
+SEC("chk_egress") int tc_chk(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	__u32 *raw = data;
+
+	if (data + sizeof(struct ethhdr) > data_end)
+		return TC_ACT_SHOT;
+
+	return !raw[0] && !raw[1] && !raw[2] ? TC_ACT_SHOT : TC_ACT_OK;
+}
+
+static __always_inline int tc_redir(struct __sk_buff *skb, int fib_lookup_flags)
+{
+	struct bpf_fib_lookup fib_params = { .ifindex = skb->ingress_ifindex };
+	__u8 zero[ETH_ALEN * 2];
+	int ret = -1;
+
+	switch (skb->protocol) {
+	case __bpf_constant_htons(ETH_P_IP):
+		ret = fill_fib_params_v4(skb, &fib_params);
+		break;
+	case __bpf_constant_htons(ETH_P_IPV6):
+		ret = fill_fib_params_v6(skb, &fib_params);
+		break;
+	}
+
+	if (ret)
+		return TC_ACT_OK;
+
+	ret = bpf_fib_lookup(skb, &fib_params, sizeof(fib_params),
+			     fib_lookup_flags);
+	if (ret == BPF_FIB_LKUP_RET_NOT_FWDED || ret < 0)
+		return TC_ACT_OK;
+
+	__builtin_memset(&zero, 0, sizeof(zero));
+	if (bpf_skb_store_bytes(skb, 0, &zero, sizeof(zero), 0) < 0)
+		return TC_ACT_SHOT;
+
+	if (ret == BPF_FIB_LKUP_RET_NO_NEIGH) {
+		struct bpf_redir_neigh nh_params = {};
+
+		nh_params.nh_family = fib_params.family;
+		__builtin_memcpy(&nh_params.ipv6_nh, &fib_params.ipv6_dst,
+				 sizeof(nh_params.ipv6_nh));
+
+		return bpf_redirect_neigh(fib_params.ifindex, &nh_params,
+					  sizeof(nh_params), 0);
+
+	} else if (!fib_lookup_flags && ret == BPF_FIB_LKUP_RET_SUCCESS) {
+		void *data_end = ctx_ptr(skb->data_end);
+		struct ethhdr *eth = ctx_ptr(skb->data);
+
+		if (eth + 1 > data_end)
+			return TC_ACT_SHOT;
+
+		__builtin_memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
+		__builtin_memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
+
+		return bpf_redirect(fib_params.ifindex, 0);
+	}
+
+	return TC_ACT_SHOT;
+}
+
+SEC("dst_ingress") int tc_dst(struct __sk_buff *skb)
+{
+	return tc_redir(skb, 0);
+}
+
+SEC("src_ingress") int tc_src(struct __sk_buff *skb)
+{
+	return tc_redir(skb, BPF_FIB_LOOKUP_SKIP_NEIGH);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tc_redirect.sh b/tools/testing/selftests/bpf/test_tc_redirect.sh
index 6d7482562140..8868aa1ca902 100755
--- a/tools/testing/selftests/bpf/test_tc_redirect.sh
+++ b/tools/testing/selftests/bpf/test_tc_redirect.sh
@@ -24,8 +24,7 @@ command -v timeout >/dev/null 2>&1 || \
 	{ echo >&2 "timeout is not available"; exit 1; }
 command -v ping >/dev/null 2>&1 || \
 	{ echo >&2 "ping is not available"; exit 1; }
-command -v ping6 >/dev/null 2>&1 || \
-	{ echo >&2 "ping6 is not available"; exit 1; }
+if command -v ping6 >/dev/null 2>&1; then PING6=ping6; else PING6=ping; fi
 command -v perl >/dev/null 2>&1 || \
 	{ echo >&2 "perl is not available"; exit 1; }
 command -v jq >/dev/null 2>&1 || \
@@ -152,7 +151,7 @@ netns_test_connectivity()
 	echo -e "${TEST}: ${GREEN}PASS${NC}"
 
 	TEST="ICMPv6 connectivity test"
-	ip netns exec ${NS_SRC} ping6 $PING_ARG ${IP6_DST}
+	ip netns exec ${NS_SRC} $PING6 $PING_ARG ${IP6_DST}
 	if [ $? -ne 0 ]; then
 		echo -e "${TEST}: ${RED}FAIL${NC}"
 		exit 1
@@ -170,6 +169,7 @@ hex_mem_str()
 netns_setup_bpf()
 {
 	local obj=$1
+	local use_forwarding=${2:-0}
 
 	ip netns exec ${NS_FWD} tc qdisc add dev veth_src_fwd clsact
 	ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd ingress bpf da obj $obj sec src_ingress
@@ -179,6 +179,14 @@ netns_setup_bpf()
 	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd ingress bpf da obj $obj sec dst_ingress
 	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd egress  bpf da obj $obj sec chk_egress
 
+	if [ "$use_forwarding" -eq "1" ]; then
+		# bpf_fib_lookup() checks if forwarding is enabled
+		ip netns exec ${NS_FWD} sysctl -w net.ipv4.ip_forward=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_dst_fwd.forwarding=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_src_fwd.forwarding=1
+		return 0
+	fi
+
 	veth_src=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_src_fwd/ifindex)
 	veth_dst=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_dst_fwd/ifindex)
 
@@ -200,5 +208,9 @@ netns_setup_bpf test_tc_neigh.o
 netns_test_connectivity
 netns_cleanup
 netns_setup
+netns_setup_bpf test_tc_neigh_fib.o 1
+netns_test_connectivity
+netns_cleanup
+netns_setup
 netns_setup_bpf test_tc_peer.o
 netns_test_connectivity

