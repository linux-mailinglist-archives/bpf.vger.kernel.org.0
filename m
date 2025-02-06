Return-Path: <bpf+bounces-50678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D636CA2AFCB
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A221622AB
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5E19CC06;
	Thu,  6 Feb 2025 18:06:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1519ADA6;
	Thu,  6 Feb 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865163; cv=none; b=HgUD7SE1IQCXaOaIttz6DJp9Rf27YT7OFyW4ebLtFbVEsgxB6E2zvZzO/QD/dKxHzh4CsU9JqwV8JRK+p7kVETbvhH8DVX1QNg3OGHlrsRmyn6IvD1ORKw9hIYuP2qAVp2PEnO4bJPZBBQLPqd7NOqSkd9B+W4mmcD13ZffHTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865163; c=relaxed/simple;
	bh=LHy3KQvHOSA/FLDeUyisPXIf+GQRdTmNLdyf1gzSLKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWzdK+x1dyxbXj2H4MUBpY+QqCLnrgER+/PP2ULY6Jv1x2T8S52j7/qr/OdcWw+jpI8+bSTcMnYWZBxb4Ue40GVkoVbcgMxbc50QDLtVHCsgWv4cTvELMZn6eTm+06i5+TAhqmDjm91QFOx0oTi3sqKAisDmR6ijIav+yy2Z8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com; spf=none smtp.mailfrom=ecsmtp.an.intel.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.an.intel.com
X-CSE-ConnectionGUID: RdXu5gHnT4WBIeMvGVDpiA==
X-CSE-MsgGUID: zFPvwUBuQsyGlWbR+rySLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38716703"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="38716703"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:06:00 -0800
X-CSE-ConnectionGUID: 8W1MT2HiRrSfsjB1wauYTQ==
X-CSE-MsgGUID: PKMBFdaDS2an3xXyCYF4wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134527233"
Received: from anls2093.an.intel.com ([10.123.15.112])
  by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2025 10:05:59 -0800
Received: from aus-labsrv3.an.intel.com (aus-labsrv3.an.intel.com [10.123.116.23])
	by anls2093.an.intel.com (Postfix) with SMTP id BF8871007560;
	Thu,  6 Feb 2025 12:05:57 -0600 (CST)
Received: by aus-labsrv3.an.intel.com (sSMTP sendmail emulation); Thu, 06 Feb 2025 12:05:57 -0600
From: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>
To: edumazet@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	lorenzo@kernel.org,
	aleksander.lobakin@intel.com,
	chopps@labn.net,
	bigeasy@linutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: [RFC PATCH net 0/1] transport_header set incorrectly when using veth
Date: Thu,  6 Feb 2025 12:05:50 -0600
Message-Id: <20250206180551.1716413-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

When testing a use-case on veth by attaching XDP and tc ingress hooks, it was 
noticed that the transport_header is set incorrectly and causes the tc_ingress
hook that is using bpf_skb_change_tail() call to report a failure.

Here is the flow:
veth ingress:
veth_convert_skb_to_xdp_buff()- [Example: skb->trannsport_header=65535 skb->network_header=0]
..>skb_pp_cow_data()
....>skb_headers_offset_update() - adds offset without checking and this
		results in transport_header value roll over.
		[off: 192: results in  skb->transport_header = 191, skb->network_header=192]
tc_ingress hook: bpf_skb_change_tail()
  - Since transport_header < network_header, min_len is negative and it fails.

Two possbible solutions:
option 1: introducing the check in the skb_headers_offset_update() to skip adding offset 
	to transport_header when it is not set. (patch attached)
option 2: reset transport header in veth_xdp_rcv_skb()

Option 1 seems to be better as it will apply to any other interfaces that may
use skb_headers_offset_update and there seems to similar logic in the same function
to check if mac_header was set before adding offset.

Seeking your inputs on this.

NOTES:
1. If veth is used without XDP hook attached, this issue is not observed
as the logic uses __netif_rx() directly and the transport header is reset
in __netif_receive_skb_core() as it detects it is not set.

2. Tested on i40e driver and confirmed it does not have this issue as the
skb_headers_offset_update() is not in the processing path.


Instructions to reproduce the issue along with the XDP and tc ingress programs
is attached below.

-------------------------------8<-------------------------------
instructions:

#build XDP and tc programs
clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c xdp_prog.c -o xdp_prog.o
clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c tc_bpf_prog.c -o tc_bpf_prog.o

# create the veth pair
ip link add veth0 numtxqueues 1 numrxqueues 1 type veth peer name veth1 \
   numtxqueues 1 numrxqueues 1

ip addr add 10.0.1.0/24 dev veth0
ip addr add 10.0.1.1/24 dev veth1
ip link set veth0 address 02:00:00:00:00:00
ip link set veth1 address 02:00:00:00:00:01
ip link set veth0 up
ip link set veth1 up

if [ -f /proc/net/if_inet6 ]; then
    echo 1 > /proc/sys/net/ipv6/conf/veth0/disable_ipv6
    echo 1 > /proc/sys/net/ipv6/conf/veth1/disable_ipv6
fi

#attach xdp hook and tc ingress hooks to veth1
xdp-loader load veth1 xdp_prog.o

tc qdisc add dev veth1 clsact
tc filter add dev veth1 ingress bpf da obj tc_bpf_prog.o sec prog

# generate traffic from veth0 egress -> veth1 ingress
ping -c e 10.0.1.3 -I veth0

# observe the trace pipe (make sure tracing is on)
# The following prints will appear
# ping-5330    [072] ..s2. 18266.403464: bpf_trace_printk: Failure.. new len=52 ret=-22
cat /sys/kernel/debug/tracing/trace_pipe

-------------------------------8<-------------------------------
xdp_prog.c:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("xdp") int netd_xdp_prog(struct xdp_md *xdp)
{ 
        /* Squash compiler warning. */
        (void)xdp;

        return XDP_PASS;
}

char _license[] SEC("license") = "GPL";

-------------------------------8<-------------------------------
test_bpf_prog.c:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <linux/pkt_cls.h>

SEC("prog") int netd_tc_test_ingress(struct __sk_buff *skb)
{       
        long ret;

        /* extend skb length by 10 */
        ret = bpf_skb_change_tail(skb, skb->len + 10, 0);
        if (ret < 0) {
                bpf_printk("Failure.. new len=%d ret=%d\n", skb->len+10, ret);
                return TC_ACT_SHOT;
        }

        bpf_printk("Success new len:%d \n", skb->len+10);

        return TC_ACT_UNSPEC;
}

char _license[] SEC("license") = "GPL";

-------------------------------8<-------------------------------

Sreedevi Joshi (1):
  net: check transport_header before adding offset

 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1


