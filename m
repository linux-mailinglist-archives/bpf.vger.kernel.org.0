Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECA362467
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhDPPs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 11:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231666AbhDPPsZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 11:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618588080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zvVjV/IydFc5/9AH6onJ9pE4Sf0z3vtcl7WT6XR87y8=;
        b=BOB8dDyYKet2ee8WJddGu7o8Hrd/ImSg8AqWyKIemT8BnNVhkpp7irPxRPekJiVCfWuZ2c
        1x68ftsCXj9K1u2HSRfmoIpM7oF32i891S7Qqk5cftVO6vtHci2yyvTGKaagMh8H2KoPiz
        +1pf5o8XpG+958VczBRsA8GAz8dr1hU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-OhiAaZfKNeGSKMvQIlTRVg-1; Fri, 16 Apr 2021 11:47:58 -0400
X-MC-Unique: OhiAaZfKNeGSKMvQIlTRVg-1
Received: by mail-ed1-f72.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso7202287edb.4
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 08:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvVjV/IydFc5/9AH6onJ9pE4Sf0z3vtcl7WT6XR87y8=;
        b=kLiVTDo4j8ff2qdvglhXTs/jsZ4RSnNuxAbloZqexUu6Q6833khk2WRqGbIWuDsNJU
         hYP01DBqyugHJVGUlIz5s0DSQTnz6erVeGMVg1JfpK3G4MPzC7Y1o+E6mJkefvGi3L7G
         XVWV8pJmTkTZJNbR8fA+5+w4i2BPw65RWWkqpwHbuRwvZTnQ6dZEJM112uk1PNjzoqQ8
         XyE+4wbHqfTV0SQ5xd8Skn7WfeoYCIbHZCjKhg3RBM66ZZZuHYYfIdawZJhqwXDnWdzK
         wC+mkRAJC14ZqckQWAfrlxsWDbAddhfdyO+uuDzs3FH7k9lD+mvqYzgE2NeKehr/cN5T
         l6IQ==
X-Gm-Message-State: AOAM530sARlQc2owanTBZVoqXb6rMexfE5O2gSCNXLgfxW7ngXsoGLEK
        m+KEKHpAeJneVtIhvSTVmTryScFK4y2j0toEbs4vTnBuGkglF/bHvIa7Uy+3vXT1sk1TyN+8DWC
        EgZ7VueGCH/+W
X-Received: by 2002:a17:906:6683:: with SMTP id z3mr9147781ejo.390.1618588077400;
        Fri, 16 Apr 2021 08:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCLijFFfzQnAHzTyMpq2zNdKfCoz+cdzAGjKTInUbRNg1x+UNmnTTCh6RkPC3dxQMBYTyBwg==
X-Received: by 2002:a17:906:6683:: with SMTP id z3mr9147763ejo.390.1618588077254;
        Fri, 16 Apr 2021 08:47:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s5sm4543974ejq.52.2021.04.16.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:47:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 317991806B2; Fri, 16 Apr 2021 17:47:56 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH net-next] veth: check for NAPI instead of xdp_prog before xmit of XDP frame
Date:   Fri, 16 Apr 2021 17:47:45 +0200
Message-Id: <20210416154745.238804-1-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The recent patch that tied enabling of veth NAPI to the GRO flag also has
the nice side effect that a veth device can be the target of an
XDP_REDIRECT without an XDP program needing to be loaded on the peer
device. However, the patch adding this extra NAPI mode didn't actually
change the check in veth_xdp_xmit() to also look at the new NAPI pointer,
so let's fix that.

Fixes: 6788fa154546 ("veth: allow enabling NAPI even without XDP")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/veth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 15b2e3923c47..bdb7ce3cb054 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -486,11 +486,10 @@ static int veth_xdp_xmit(struct net_device *dev, int n,
 
 	rcv_priv = netdev_priv(rcv);
 	rq = &rcv_priv->rq[veth_select_rxq(rcv)];
-	/* Non-NULL xdp_prog ensures that xdp_ring is initialized on receive
-	 * side. This means an XDP program is loaded on the peer and the peer
-	 * device is up.
+	/* The napi pointer is set if NAPI is enabled, which ensures that
+	 * xdp_ring is initialized on receive side and the peer device is up.
 	 */
-	if (!rcu_access_pointer(rq->xdp_prog))
+	if (!rcu_access_pointer(rq->napi))
 		goto out;
 
 	max_len = rcv->mtu + rcv->hard_header_len + VLAN_HLEN;
-- 
2.31.1

