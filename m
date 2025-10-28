Return-Path: <bpf+bounces-72522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516BDC1468C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408581AA32BF
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E03081CE;
	Tue, 28 Oct 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAFHpO/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA112DFA31
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651609; cv=none; b=GhVxIFNZYEorT2aswfHKkHMHa/4zCu7VvpUWOMPjK1Mu7D/t7L/n80m+2MaC1JfS1qwewxLvaTP45R0jODRsBuQ3a/9hlpqclaJTwxBRPZJSDH5v9v/rvQE1y6ul3Ax7iKBlZAMGhkUe7xTazPqtiimJMLaQpMxer26SO+jJ5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651609; c=relaxed/simple;
	bh=S8+Ja3ralZ2WxCdLK1ixOt+mF2q4rBG1Bbc1fFOF20Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geHGJ0Rc7jP912FmkEmcJPl/DMTnJhK0JfdY4oV9/PUHF6qPb/G+yI+nd9lAaLlBQPmO67bcbQqBjPW9JuHND7DE0HWYaIzTlKzM9OM2y98eRJ69C/jr6hWJiptMq4l9N8LRvXTDFnt7VrtSyMaQBe9atSvj1+rE0lxKbUXZGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAFHpO/E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so7099453b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651607; x=1762256407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQGkMpWQvkIrFU/utWIdl52vdzB7gtbaDaCLqaVvZwY=;
        b=mAFHpO/ERlvBgzENIiDBUGgcqj2edkDJ5i9oq4kHVh+9p+z6ZI63uZz1aLXo1wC8pd
         ZPL1yImqUIAtp+tn6Qbn+M4Z5dUo7RfyfipXqi/I3exuGe2I0N6hO2HD6Q4jj5lg5+T7
         UalETiVjsShfaZeXFw4Ra+MRgQhQwf097kkyVw8vfu1bXloevb+Cn+q3rzxKhcsBJ5Cb
         ncNYm61tSwDapv6xoT+E7eCuEBCteb944Jv1J6iZKeOHaYTHhkUZsErmUux9XcVLw9Yf
         WcUBSS2cPHXxcCVlLMxXkUsUcdB9aN7zXS4U5B60nt4k12R8K/EOs7RnK9z9cm4HUBqv
         9jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651607; x=1762256407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQGkMpWQvkIrFU/utWIdl52vdzB7gtbaDaCLqaVvZwY=;
        b=sB0vXhC8NicWkhSyDqUhqbxTYFGTQSuMxjEAgbEi1EUUAmOZPLlkoI5ipUQadeOKhS
         MRiQvcJBGjZ33sYv1mmnpsiXLVNJDhMMfoviNXpfr9Yv2ZZMJhHuOvl9U6maN5ZhvDx7
         5TQ2YbtChWLmIQ7CT++CuKDbjei8Xfgh2g1LoJ/S1CXC1pzdLksnqYS4rABpn7OiIpnX
         VIuQCHTiv92v4d3JfluQTwmrHx9f9X8cqhqUu3pOKVE81XJ0QmdEgkewhp/bwfwJpw7H
         aflY3MDFq3UJaJMlNC+semFEkpStTLP+RjE7dG3B3fGmtkpa/FBGbEs/H2qZBITOFkmW
         MD2A==
X-Forwarded-Encrypted: i=1; AJvYcCWXF9DZHZQuxKtmDrjuCieGBLXIEnhFA+Lqdnxpf6ymfkVczcMEjS1fXfxP8bAQayrH80Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZlO3jCdY+13liuqQaWy7cGFJ6DS/hjIa0E/hdC+6YYdTh0WZ
	ywMxrQkI1kScdO+6k/Nt8UGZeeS+9GP7EevEeotMY4IrscqeRyC1pHe6
X-Gm-Gg: ASbGncs3bl6GVElIpqENoXvxcEZOPJfkUFcgLDClmF9LPArqi/DZ32ivhrGx6hqTAZR
	8uAGwMSKcLHhyas3WgSzGg3jc7y3WlXb8+hu+oQMANUA+l3U2e8XQo2JDd5peBFYvdcZ88ykctI
	n3wEYeD4CP6EIEnwcVY7HIKQpJFvK6EWmbc5jSiZtL1HIqLx2fZXMQ0btHhmHEcbPoCG833PiXe
	5ub5HOV7GcFm90+rEUabhmaCc6GhwrW8evNocYu+pRkEOw0d7J3MD1Ii4fXdaZtXMg/dEoYNDqe
	6dTQwMAb+Cyja6sbZxS3uSCG8C3oT+K5omMX1tIaKn6kKa8By+1OIguzZk3YcwVz36aKxxcc1Bo
	Vofh83FiIjwOnwaRLkDgL7/4jMwH2RqKfGvH1Jk5LDtwJArOoWH3VQrsC2hxFLf7v+69l0DFZRE
	Lp
X-Google-Smtp-Source: AGHT+IELfm1V2/9P9RcJo7ple69Pu8CkbUuJnvOHx1MhFw0DK3gnvsbENWcBcTkx8E417BUE9yB8ag==
X-Received: by 2002:a05:6a20:3ca7:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-344d3a4fdbamr4255473637.45.1761651607102;
        Tue, 28 Oct 2025 04:40:07 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm10351782a12.6.2025.10.28.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:40:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 931944209E50; Tue, 28 Oct 2025 18:40:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] net: Reorganize networking documentation toctree
Date: Tue, 28 Oct 2025 18:39:24 +0700
Message-ID: <20251028113923.41932-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4925; i=bagasdotme@gmail.com; h=from:subject; bh=S8+Ja3ralZ2WxCdLK1ixOt+mF2q4rBG1Bbc1fFOF20Q=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkMq17fbp63pyIq0/jpJI47M/d/5uKyXvj/X43GNtfj+ /9Yf02L6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEipwZGXZ5L11wZYK8MaPh Kf+v2rG88zJv9U6uKZ/RHm79yuRxkSwjw1WBxJ36EQf4Z4mJJP2yUTi45cp5aZbry750OqZLM8a nsQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Current netdev docs has one large, unorganized toctree that makes
finding relevant docs harder like a needle in a haystack. Split the
toctree into four categories: networking core; protocols; devices; and
assorted miscellaneous.

While at it, also sort the toctree entries and reduce toctree depth.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst | 241 ++++++++++++++++-------------
 1 file changed, 136 insertions(+), 105 deletions(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c775cababc8c17..ca86e544c5c8e2 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -5,138 +5,169 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
 
 Contents:
 
+Networking core
+---------------
+
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    af_xdp
-   bareudp
-   batman-adv
-   can
-   can_ucan_protocol
-   device_drivers/index
-   diagnostic/index
-   dsa/index
-   devlink/index
-   caif/index
-   ethtool-netlink
-   ieee802154
-   iso15765-2
-   j1939
-   kapi
-   msg_zerocopy
-   failover
-   net_dim
-   net_failover
-   page_pool
-   phy
-   sfp-phylink
-   alias
-   bridge
-   snmp_counter
    checksum-offloads
-   segmentation-offloads
-   scaling
-   tls
-   tls-offload
-   tls-handshake
-   nfc
-   6lowpan
-   6pack
-   arcnet-hardware
-   arcnet
-   atm
-   ax25
-   bonding
-   cdc_mbim
-   dctcp
-   devmem
-   dns_resolver
+   diagnostic/index
    driver
-   eql
-   fib_trie
-   filter
-   generic-hdlc
-   generic_netlink
-   ../netlink/specs/index
-   gen_stats
-   gtp
-   ila
-   ioam6-sysctl
-   iou-zcrx
-   ip_dynaddr
-   ipsec
-   ip-sysctl
-   ipv6
-   ipvlan
-   ipvs-sysctl
-   kcm
-   l2tp
-   lapb-module
+   kapi
    mac80211-injection
-   mctp
-   mpls-sysctl
-   mptcp
-   mptcp-sysctl
-   multiqueue
-   multi-pf-netdev
+   msg_zerocopy
    napi
    net_cachelines/index
-   netconsole
    netdev-features
-   netdevices
-   netfilter-sysctl
    netif-msg
-   netmem
-   nexthop-group-resilient
-   nf_conntrack-sysctl
-   nf_flowtable
-   oa-tc6-framework
-   openvswitch
-   operstates
    packet_mmap
-   phonet
+   page_pool
+   phy
    phy-link-topology
-   pktgen
+   scaling
+   segmentation-offloads
+   skbuff
+   strparser
+   timestamping
+   xdp-rx-metadata
+   xsk-tx-metadata
+
+Protocols
+---------
+
+.. toctree::
+   :maxdepth: 1
+
+   6pack
+   arcnet
+   ax25
+   bareudp
+   caif/index
+   can
+   can_ucan_protocol
+   dctcp
+   gtp
+   ila
+   ipsec
+   ipv6
+   iso15765-2
+   j1939
+   l2tp
+   mctp
+   mptcp
+   oa-tc6-framework
+   phonet
+   psp
+   rxrpc
+   sctp
+   tcp-thin
+   tcp_ao
+   tipc
+   tls
+   tls-handshake
+   tls-offload
+   udplite
+   vxlan
+   x25
+
+Networking devices
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   6lowpan
+   arcnet-hardware
+   bonding
+   bridge
+   cdc_mbim
+   device_drivers/index
+   devlink/index
+   devmem
+   dsa/index
+   eql
+   ipvlan
+   multi-pf-netdev
+   multiqueue
+   netconsole
+   netdevices
+   netmem
+   operstates
    plip
    ppp_generic
+   representors
+   sriov
+   statistics
+   switchdev
+   team
+   tuntap
+   vrf
+   x25-iface
+
+Packet filtering
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   filter
+   netfilter-sysctl
+   nf_conntrack-sysctl
+   nf_flowtable
+   tc-actions-env-rules
+   tc-queue-filters
+   tproxy
+
+Miscellaneous
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
+   ../netlink/specs/index
+   alias
+   atm
+   batman-adv
+   dns_resolver
+   ethtool-netlink
+   failover
+   fib_trie
+   gen_stats
+   generic-hdlc
+   generic_netlink
+   ieee802154
+   ioam6-sysctl
+   iou-zcrx
+   ip-sysctl
+   ip_dynaddr
+   ipvs-sysctl
+   kcm
+   lapb-module
+   mpls-sysctl
+   mptcp-sysctl
+   net_dim
+   net_failover
+   nexthop-group-resilient
+   nfc
+   openvswitch
+   pktgen
    proc_net_tcp
    pse-pd/index
-   psp
    radiotap-headers
    rds
    regulatory
-   representors
-   rxrpc
-   sctp
    secid
    seg6-sysctl
-   skbuff
+   sfp-phylink
    smc-sysctl
-   sriov
-   statistics
-   strparser
-   switchdev
+   snmp_counter
    sysfs-tagging
-   tc-actions-env-rules
-   tc-queue-filters
-   tcp_ao
-   tcp-thin
-   team
-   timestamping
-   tipc
-   tproxy
-   tuntap
-   udplite
-   vrf
-   vxlan
-   x25
-   x25-iface
    xfrm_device
    xfrm_proc
    xfrm_sync
    xfrm_sysctl
-   xdp-rx-metadata
-   xsk-tx-metadata
 
 .. only::  subproject and html
 

base-commit: 5f30bc470672f7b38a60d6641d519f308723085c
-- 
An old man doll... just what I always wanted! - Clara


