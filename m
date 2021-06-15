Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97E3A838E
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFOPGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 11:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhFOPGc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 11:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623769468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tvsP/yH9Ey7XMq3RE8CaFyAMq7vmXoKEd6exr5zYNI=;
        b=eCORax4uO5k2CM7Vp2+MXWizqgWJsol/U6u35NtFtxkiJcjKZ0dvjPDXHztXNKJ4YWDbFs
        KzprcpuOQaNk96QSNCXokRgxm85XBDhgwsvxIwtXKBI/TbmhjjqCDuja3FqBWSL43HFvcA
        etNheASrGPdAK/pAyehDKLrhQi3BTP8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-PcR7eYlROxWriN2monNDCQ-1; Tue, 15 Jun 2021 11:04:26 -0400
X-MC-Unique: PcR7eYlROxWriN2monNDCQ-1
Received: by mail-ed1-f72.google.com with SMTP id v8-20020a0564023488b0290393873961f6so15048366edc.17
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tvsP/yH9Ey7XMq3RE8CaFyAMq7vmXoKEd6exr5zYNI=;
        b=s8STSESAvDyW3w21AjIY5D3IjBXEX52nKwpQFN/gOSstVQLfuaZptahr741H2nN1la
         FkVmvZMOYPZI8D0njKIn1uI12TBLHdjuBwscN6F2ldxzo/4qAVVnFVReVeyvDrc94mnT
         LnQJOvhYjy3IxHH37JvhXhLU7w7I+RQuEKwCtU5FQ5BBCzCzYH6RYJpiYjS4YwRvXo5f
         Xy9M0Ww8j2C4cHcme8RJMDX8ZqzWg6p0w3UaiuqlVkq3GN3tgzYaIxCiF94GYK+Fjyd7
         IPTT1BNHE2JVS+cWJ7NnUUwWT6RTamqwWk3vERgVUYmazgBaQCKRlCWXKQFuF9NQl6DN
         DyrQ==
X-Gm-Message-State: AOAM530S73Z42iRKDrwqB2+AYLsfmwU96X/m5jpWVA/lgzK4m2oa3lDW
        c6BvIwyZz59toHD6J+jFWxR2IZRvQ4AR3faS9Rxy3zR3q0OCDZudO0wvaMzvsLgW2anYnGhVIsc
        cjRrRWZyR499+
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr23778746edv.2.1623769464225;
        Tue, 15 Jun 2021 08:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlhK4Hyjzlmys+ZL4H0SJamx7Lw/4wa7JVAWKdG+DZ3iR+0/DA89DGjdClsHUXjjgeYnQqlQ==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr23778723edv.2.1623769464026;
        Tue, 15 Jun 2021 08:04:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e22sm12535481edv.57.2021.06.15.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:04:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F0FBD180734; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Simon Horman <simon.horman@netronome.com>,
        oss-drivers@netronome.com
Subject: [PATCH bpf-next v2 11/16] nfp: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:50 +0200
Message-Id: <20210615145455.564037-12-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The nfp driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
program invocations. However, the actual lifetime of the objects referred
by the XDP program invocation is longer, all the way through to the call to
xdp_do_flush(), making the scope of the rcu_read_lock() too small.

While this is not actually an issue for the nfp driver because it doesn't
support XDP_REDIRECT (and thus doesn't call xdp_do_flush()), the
rcu_read_lock() is still unneeded. And With the addition of RCU annotations
to the XDP_REDIRECT map types that take bh execution into account, lockdep
even understands this to be safe, so there's really no reason to keep it
around.

Cc: Simon Horman <simon.horman@netronome.com>
Cc: oss-drivers@netronome.com
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index eeb30680b4dc..a3d59abed6ae 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1819,7 +1819,6 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 	struct xdp_buff xdp;
 	int idx;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(dp->xdp_prog);
 	true_bufsz = xdp_prog ? PAGE_SIZE : dp->fl_bufsz;
 	xdp_init_buff(&xdp, PAGE_SIZE - NFP_NET_RX_BUF_HEADROOM,
@@ -1919,6 +1918,10 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 					 pkt_off - NFP_NET_RX_BUF_HEADROOM,
 					 pkt_len, true);
 
+			/* This code is invoked within a single NAPI poll cycle
+			 * and thus under local_bh_disable(), which provides the
+			 * needed RCU protection.
+			 */
 			act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
 			pkt_len = xdp.data_end - xdp.data;
@@ -2036,7 +2039,6 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 			if (!nfp_net_xdp_complete(tx_ring))
 				pkts_polled = budget;
 	}
-	rcu_read_unlock();
 
 	return pkts_polled;
 }
-- 
2.31.1

