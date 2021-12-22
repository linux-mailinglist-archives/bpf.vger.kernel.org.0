Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAFC47D424
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbhLVPMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 10:12:23 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34299 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234907AbhLVPMV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 10:12:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CE5F832007F9;
        Wed, 22 Dec 2021 10:12:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Dec 2021 10:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ybZeck39JoHn3TSl1
        qj7esBSnVRfrtN4dVO1/BIJtp8=; b=b6ICXfD4IxMZrRb2mXhQuxoZVcmBNw2Cj
        Z9Nd45tgbsfx3zoy0c06AD8eullc5t3LHw74vXnx2EzT2QHtZ5ZYEyYgnlVMXiZv
        qr2pgvCCXKN8NRwOpccKT+vDVOsINdTlsFXWV14AZFtG733BFuJQdci2LYNjhzsn
        2CcHAAnj/ZVjN1tr3sBpVGR8rYd/gdoSxAor7fqMHlxJ6v6/H7xiFfvA26GZ1MgP
        1EQd7uIaQWcIkd2/L0924UBX9y9CiJ7JBiO+LEKCuNq8lA0glOuosrQ9wrg6bBHg
        /qaFiMCVxDFkAL+3kYF0BwGcX+VjUxSGtSoyXgoidqyX2etxwxM2A==
X-ME-Sender: <xms:UUDDYcO7brfT1J6UEhkqSO9_FKJ4SGHpLOerAHk0LMW1TiUfm0s7ew>
    <xme:UUDDYS9AkRDM92ZaA_EmszXr3afFeKNvEWiYHAbjElvBM6QbPU4cvagkSHarHV22H
    06DLxv-B-AvxfEpcMU>
X-ME-Received: <xmr:UUDDYTTmNnIEzuwLkwe9GdsHK1KzZnj0A8y_HZz_ryd2SmpNBkKY3aIw9SnjVEhFnhg3FW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghmsggu
    rgdrlhhtqeenucggtffrrghtthgvrhhnpeeuhfefvdehleeiudehvdeviefftdelheeiud
    euheejjedtkeduvddtffehueeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:UUDDYUsoBomfKL1Dcf81cmP7LlC0n8u9IlzqKAONeEaldkeI39H2wA>
    <xmx:UUDDYUdOOkvJgHK_l-u0HtXjgVm7BQk2A_rNXdqveimxyF99yvOoYA>
    <xmx:UUDDYY26gaYkgt-cIBrbE0I0InjfBCwRxLk6nF8osEpkXG07hR58aw>
    <xmx:UkDDYc4EoHgAHDT-6LXmlN-IgZ7gz1cwdL40lo3I9OTm_odw9lALxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Dec 2021 10:12:15 -0500 (EST)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt, dsahern@gmail.com
Subject: [PATCH bpf] bpf: Fix fib lookup when ifindex is not set
Date:   Wed, 22 Dec 2021 16:15:48 +0100
Message-Id: <20211222151548.100494-1-m@lambda.lt>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, bpf_ipv{4,6}_fib_lookup() with !BPF_FIB_LOOKUP_DIRECT
required a netdev identified by bpf_fib_lookup->ifindex to exist even if
the netdev's FIB table was not used for the lookup.

This commit makes the ifindex mandatory only if BPF_FIB_LOOKUP_DIRECT is
set.

Fixes: 87f5fc7e48d ("bpf: Provide helper to do forwarding lookups in kernel FIB table")
Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 net/core/filter.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6102f093d59a..7c8f34d9e042 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5389,14 +5389,16 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	u32 mtu = 0;
 	int err;
 
-	dev = dev_get_by_index_rcu(net, params->ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (flags & BPF_FIB_LOOKUP_DIRECT) {
+		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (unlikely(!dev))
+			return -ENODEV;
 
-	/* verify forwarding is enabled on this interface */
-	in_dev = __in_dev_get_rcu(dev);
-	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
-		return BPF_FIB_LKUP_RET_FWD_DISABLED;
+		/* verify forwarding is enabled on this interface */
+		in_dev = __in_dev_get_rcu(dev);
+		if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
+			return BPF_FIB_LKUP_RET_FWD_DISABLED;
+	}
 
 	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
 		fl4.flowi4_iif = 1;
@@ -5514,13 +5516,15 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (rt6_need_strict(dst) || rt6_need_strict(src))
 		return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-	dev = dev_get_by_index_rcu(net, params->ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (flags & BPF_FIB_LOOKUP_DIRECT) {
+		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (unlikely(!dev))
+			return -ENODEV;
 
-	idev = __in6_dev_get_safely(dev);
-	if (unlikely(!idev || !idev->cnf.forwarding))
-		return BPF_FIB_LKUP_RET_FWD_DISABLED;
+		idev = __in6_dev_get_safely(dev);
+		if (unlikely(!idev || !idev->cnf.forwarding))
+			return BPF_FIB_LKUP_RET_FWD_DISABLED;
+	}
 
 	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
 		fl6.flowi6_iif = 1;
-- 
2.34.1

