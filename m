Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06BF3B33A4
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFXQQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFXQQP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OGKlT+K3Cpr2CAOizG3FJ/dNahuGZz8NpheYYFR6ws=;
        b=c07ChdGBVDKtrrTD/ENTbPYUj4p9O/vKcc1f8b6j4+2kDGOI13hwGFT2tUgURW3djz5zj5
        ypUOs+Q9X4WIc3ISumO1eOLZOmAjdRlAk/RPgH99JTHpgUMQ7HqmhdEaRqSzpqTAliWlkj
        FPC7PTc7ApqGglRgcrg6SvwT8rmaXf8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-YzHZQrH5Ofiek63ZOk_sMQ-1; Thu, 24 Jun 2021 12:13:54 -0400
X-MC-Unique: YzHZQrH5Ofiek63ZOk_sMQ-1
Received: by mail-ed1-f71.google.com with SMTP id dy23-20020a05640231f7b0290394996f1452so3626917edb.18
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OGKlT+K3Cpr2CAOizG3FJ/dNahuGZz8NpheYYFR6ws=;
        b=VHiVfIsB6koVcmi7fsH1IT7ISys//kpAB91iSpcUYQtw8MLZa+aSWiJQnKo8+38/y6
         lcIgkdaXF7YfLglUhDuO7OouNN8Vu6VG1LkdM/7OCoILS4wo2QWGooRP4uqQ1F3cFZVH
         3PaMejsL66ZynmBOwjObR/wJ3GqnkIYavIPg5B8TvTYbE5Lozw6Fs66IL9jH6PxTcbuR
         99DZszUBHDMGD5IzawDjzDqR1UaKk+FGB/eVbDejZhJe8AKeeUyMVBiIraH7N9ngqyR4
         FpNAZCBP1JgdwWJ8AH+rXV2FVJ+bYaj9C7ciVkfRyQBZ0OFxL47s9jtIB2nkdAsC95AZ
         lEPg==
X-Gm-Message-State: AOAM530fj0tVWTgW99cXJvpOP2/VwilA3bA9AaCx8230pl9kKFeDnXdP
        VCdji1tQaC/VQyDrksQO7bK5F2Bwp0G3Qg8TBa+n5avjq7y8n6FOWL6C+HQYRSz8T4JRLGpPpu1
        eBZrSVnaHi4Na
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr6021309eje.425.1624551233597;
        Thu, 24 Jun 2021 09:13:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkMmuHvtFL+2+qbxdEqWtnQFiQm8TsBCugpF27GOyLxyYhdPSN4NVwA3+KZgpg2/w7k0IVOQ==
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr6021291eje.425.1624551233393;
        Thu, 24 Jun 2021 09:13:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gx4sm1472384ejc.34.2021.06.24.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97A1018073F; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
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
Subject: [PATCH bpf-next v5 14/19] nfp: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:04 +0200
Message-Id: <20210624160609.292325-15-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
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
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index eeb30680b4dc..5dfa4799c34f 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1819,7 +1819,6 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 	struct xdp_buff xdp;
 	int idx;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(dp->xdp_prog);
 	true_bufsz = xdp_prog ? PAGE_SIZE : dp->fl_bufsz;
 	xdp_init_buff(&xdp, PAGE_SIZE - NFP_NET_RX_BUF_HEADROOM,
@@ -2036,7 +2035,6 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
 			if (!nfp_net_xdp_complete(tx_ring))
 				pkts_polled = budget;
 	}
-	rcu_read_unlock();
 
 	return pkts_polled;
 }
-- 
2.32.0

