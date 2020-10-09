Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA24289153
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbgJISm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732990AbgJISm5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Oct 2020 14:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602268976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BuHz/agx/D/xUxMUmb9YQz8Olko0BMRD2G5Xk+NMsYA=;
        b=Nc5+jWFS+cYuG+O1Vo5YVdDjPCz9Xgo2s/LkM+nIolppFA7JMiUmJnqYadoLGlyv7TcA4G
        Q3/QTbHWYzLVVWNFXIUqHKNj3B/taEsND+vQR4RgVyQ58MsvZLb5YpTQ7qnc16INV/+rOl
        V+BxwZQ5O+6OHQF9/oEzOOvfiz25acY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-dEekxkH7PSihTfhbFCOdRg-1; Fri, 09 Oct 2020 14:42:55 -0400
X-MC-Unique: dEekxkH7PSihTfhbFCOdRg-1
Received: by mail-vs1-f70.google.com with SMTP id g5so1487674vsg.14
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BuHz/agx/D/xUxMUmb9YQz8Olko0BMRD2G5Xk+NMsYA=;
        b=Tm9mBGZL8aqcfkhEDj3JTBcWDrGzFAejMxncC3PAzazzX0Dt/92ysN+tA5O2uIeh/y
         slGBGnv6mTlse1b/Ytjh2F0qKehPtXeLd1apbOvHSxXAgENg9fxj2yUQswlWSLXYHKwH
         eDmD9SuoLlYP3PlVgySs7J2uv5+gJhj7q0NGP+sK1WV/Rmox1iZDELMr3ktBIr5YIBM6
         QkJnPI5Sp1tPcpYXNJnDGzNuHxse7AlcfLhFWVTLtiwLG/FeIBvDLJzeahAhqlXk53sJ
         Xk73RhDaNeRjb9adYzHU1QJOAViK0Akdb4PcYcKhAa1+7imsD6Kl9ZJemHCuCj4pyEJE
         zn6w==
X-Gm-Message-State: AOAM533x7YXvtHB4hw1l5n35vG4/UOTei1o3cUqCzolJ5gXJtqW7pVwl
        zBSojES+J8GcpwjSFGkzBmZ+wkkB5XNYO9AYgB4CMPxtqjTg+YrqB5pfr7HpxcRX2qtRqQYPPrb
        oFGKZMPbVCCOY
X-Received: by 2002:a67:ec89:: with SMTP id h9mr8758457vsp.55.1602268974248;
        Fri, 09 Oct 2020 11:42:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqui8W8z3EFvE8/xCYAoe4hqPY7vwTnzl3eqMhQ+bGhMjEANnr+OIPvldIDLL0JBJyyrRfMw==
X-Received: by 2002:a67:ec89:: with SMTP id h9mr8758444vsp.55.1602268973995;
        Fri, 09 Oct 2020 11:42:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s18sm1249332vkd.51.2020.10.09.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:42:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 499201837DC; Fri,  9 Oct 2020 20:42:51 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH bpf-next v3] bpf_fib_lookup: always return target ifindex
Date:   Fri,  9 Oct 2020 20:42:34 +0200
Message-Id: <20201009184234.134214-1-toke@redhat.com>
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
always return the ifindex if the FIB lookup itself succeeds.

Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v3:
- Get rid of the flag again, to be revisited later (David)

v2:
- Add flag (Daniel)
- Remove misleading code example from commit message (David)

net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5da44b11e1ec..a0c30f3ea7ca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5196,7 +5196,6 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
-	params->ifindex = dev->ifindex;
 
 	return 0;
 }
@@ -5293,6 +5292,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	dev = nhc->nhc_dev;
 
 	params->rt_metric = res.fi->fib_priority;
+	params->ifindex = dev->ifindex;
 
 	/* xdp and cls_bpf programs are run in RCU-bh so
 	 * rcu_read_lock_bh is not needed here
@@ -5418,6 +5418,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 
 	dev = res.nh->fib_nh_dev;
 	params->rt_metric = res.f6i->fib6_metric;
+	params->ifindex = dev->ifindex;
 
 	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
 	 * not needed here.
-- 
2.28.0

