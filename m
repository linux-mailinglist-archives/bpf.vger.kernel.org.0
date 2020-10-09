Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A424728869E
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgJIKOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 06:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387522AbgJIKOP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Oct 2020 06:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602238453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GKsQVKXFWAoRx2mBzSwxbm8fDt6u1Gvkfg1/QN3aPdk=;
        b=HBy2jU3ZTtaSbWU9NZymhWa/2fYBP0GylNZqMly+6/7kJSbbbJqaZM20jQ07KCucKKyt9g
        iSnISZvjhpF4lEvI4gGjEpPD6y0ZJBKE8gFmWOboBbNJntTpdVa8k/sjRgjdNyp6Rf4tJf
        pNiyTmcwIS2OYq47+g6yay4bfpj0QRI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-pOVuULmeNpG_ZXjQ0yMHmQ-1; Fri, 09 Oct 2020 06:14:09 -0400
X-MC-Unique: pOVuULmeNpG_ZXjQ0yMHmQ-1
Received: by mail-wm1-f72.google.com with SMTP id w23so3952068wmi.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 03:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKsQVKXFWAoRx2mBzSwxbm8fDt6u1Gvkfg1/QN3aPdk=;
        b=tnRdPEI42VXSRrvFPhizbnW9uFdClveYu5KTC2y100/YdGA29/WDv9p+jpwX5Ki3RA
         VQmJ+JeYRl0/T3beODQ5ka2oH4MF9AfBbc56cdOuSPPlfBxrgv/W20hpFCct6A6d6vAm
         k/BJiXMmD4TaAOWVx6zmvPTfWVzPwHazPcLFhBaMsm3+xhchrZ8y4+vaG0hfAcAgUAu+
         Ol7fRApkLnjCp1BjE8pMsvLhB/jTk0jSXPpjfiy3WMnXjq7gOzk+VyVWz3+WQjNe3tO0
         vIZHoWvlut9HpGgNzvXbwNfWh68AfX7KhKT958LTY3pIo0M4N4dNzN7xNKUjuL8RtTbs
         Bbng==
X-Gm-Message-State: AOAM531a8dqzlUj0JM8H8VeoA3X7n1wNySjWoyZoPQo0FWrjOw0Xtbcs
        6KijQfqpCxc2NfTfP51Mtuf/7r/kfsq5hqEIF1BthU9U6hZ/B5BqahVQSHTEa2Yi8xkKG3L6l6Q
        3HWrGtj0MgEZH
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr13362785wrs.232.1602238448035;
        Fri, 09 Oct 2020 03:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsHYiC81Wm90jnrYtCKd/+B9jIwbZtZbICDa1mysEwxZ8zBGzSkYhIfd05jMNwC2f4dJ/ypA==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr13362768wrs.232.1602238447788;
        Fri, 09 Oct 2020 03:14:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 24sm10916050wmg.8.2020.10.09.03.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 03:14:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A72731837DC; Fri,  9 Oct 2020 12:14:06 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH bpf-next v2] bpf_fib_lookup: optionally skip neighbour lookup
Date:   Fri,  9 Oct 2020 12:13:56 +0200
Message-Id: <20201009101356.129228-1-toke@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_fib_lookup() helper performs a neighbour lookup for the destination
IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectation
that the BPF program will pass the packet up the stack in this case.
However, with the addition of bpf_redirect_neigh() that can be used instead
to perform the neighbour lookup, at the cost of a bit of duplicated work.

For that we still need the target ifindex, and since bpf_fib_lookup()
already has that at the time it performs the neighbour lookup, there is
really no reason why it can't just return it in any case. So let's just
always return the ifindex, and also add a flag that lets the caller turn
off the neighbour lookup entirely in bpf_fib_lookup().

v2:
- Add flag (Daniel)
- Remove misleading code example from commit message (David)

Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/bpf.h       | 10 ++++++----
 net/core/filter.c              | 15 ++++++++++++---
 tools/include/uapi/linux/bpf.h | 10 ++++++----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d83561e8cd2c..9c7c10ce7ace 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4813,12 +4813,14 @@ struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
 
-/* DIRECT:  Skip the FIB rules and go to FIB table associated with device
- * OUTPUT:  Do lookup from egress perspective; default is ingress
+/* DIRECT:      Skip the FIB rules and go to FIB table associated with device
+ * OUTPUT:      Do lookup from egress perspective; default is ingress
+ * SKIP_NEIGH:  Skip neighbour lookup and return BPF_FIB_LKUP_RET_NO_NEIGH on success
  */
 enum {
-	BPF_FIB_LOOKUP_DIRECT  = (1U << 0),
-	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
+	BPF_FIB_LOOKUP_DIRECT      = (1U << 0),
+	BPF_FIB_LOOKUP_OUTPUT      = (1U << 1),
+	BPF_FIB_LOOKUP_SKIP_NEIGH  = (1U << 2),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 05df73780dd3..1038337bc06c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5192,7 +5192,6 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
-	params->ifindex = dev->ifindex;
 
 	return 0;
 }
@@ -5289,6 +5288,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	dev = nhc->nhc_dev;
 
 	params->rt_metric = res.fi->fib_priority;
+	params->ifindex = dev->ifindex;
+
+	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
+		return BPF_FIB_LKUP_RET_NO_NEIGH;
 
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
@@ -5414,6 +5417,10 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	dev = res.nh->fib_nh_dev;
 	params->rt_metric = res.f6i->fib6_metric;
+	params->ifindex = dev->ifindex;
+
+	if (flags & BPF_FIB_LOOKUP_SKIP_NEIGH)
+		return BPF_FIB_LKUP_RET_NO_NEIGH;
 
 	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
 	 * not needed here.
@@ -5432,7 +5439,8 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
+	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT |
+		      BPF_FIB_LOOKUP_SKIP_NEIGH))
 		return -EINVAL;
 
 	switch (params->family) {
@@ -5469,7 +5477,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT))
+	if (flags & ~(BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT |
+		      BPF_FIB_LOOKUP_SKIP_NEIGH))
 		return -EINVAL;
 
 	switch (params->family) {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d83561e8cd2c..9c7c10ce7ace 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4813,12 +4813,14 @@ struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
 
-/* DIRECT:  Skip the FIB rules and go to FIB table associated with device
- * OUTPUT:  Do lookup from egress perspective; default is ingress
+/* DIRECT:      Skip the FIB rules and go to FIB table associated with device
+ * OUTPUT:      Do lookup from egress perspective; default is ingress
+ * SKIP_NEIGH:  Skip neighbour lookup and return BPF_FIB_LKUP_RET_NO_NEIGH on success
  */
 enum {
-	BPF_FIB_LOOKUP_DIRECT  = (1U << 0),
-	BPF_FIB_LOOKUP_OUTPUT  = (1U << 1),
+	BPF_FIB_LOOKUP_DIRECT      = (1U << 0),
+	BPF_FIB_LOOKUP_OUTPUT      = (1U << 1),
+	BPF_FIB_LOOKUP_SKIP_NEIGH  = (1U << 2),
 };
 
 enum {
-- 
2.28.0

