Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3A3ABE3A
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFQVjf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhFQVje (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxe/jYWJoRuqS9AZsVd+t2yebUIqnn8PaQiPBsd+Vzc=;
        b=EoHiXRDHQl9YnGk6PXC5c2atASgs+Aw6ymEbYxGTc8ao74k05KYxutK91pT+SpwDVFM7F4
        te7YufXbFcKPS9v1ogBtA416gIottaEq78m29LaODXftwGzqqZ4/E0ySWJCCDDJSr3wHNH
        jmjikqM5HqFqrUSZXCmX9OOoD9v3ITY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-e3BDpmbBOSmFuT6oNp-HLA-1; Thu, 17 Jun 2021 17:37:25 -0400
X-MC-Unique: e3BDpmbBOSmFuT6oNp-HLA-1
Received: by mail-ed1-f69.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so2377039edb.16
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxe/jYWJoRuqS9AZsVd+t2yebUIqnn8PaQiPBsd+Vzc=;
        b=DZgUyHCLjAQUXnsZIouG15d2KLzc7F7kSLRJ3BjYbew9nUMdGqqHO3RDbV9oydPROQ
         S5pbvQjnuSY7ru2zt3tuT/dQccaZOqmGfNFduz/wfh5zDIZJ6WgjUVGglSLiHAURVCtX
         C+xAsStE15yGdynixz6t5BS4WWTIpgRSBfFbqKE/kFjtaNUcouoI5fQ6HyR//jLI0V21
         6eAuMzpEosec7vQ5xE3DBhJU/I8bLrRtIU1cA2Ze738fO4ylqXVIfH9PRt8PFXv4gX4K
         0+JOSp1AJMyNog63KBZTZEokOL0wzkNQmkx0zaJJZJwDiNfM02sCJn4EfCap9eQa3XSU
         iltg==
X-Gm-Message-State: AOAM532kaYXBoPdmkRoYKf2cYEm3pA8961uO580clqfiFkufNnolSey6
        t6UhaB8BewXD69YPDZ8LUrleV6EVsHkUa/vhGoxvgosQnoH6KXWt4gzgnF5FEX5GqllynZVGeYg
        dtGHnA9NX0v0B
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr7410958eje.22.1623965843971;
        Thu, 17 Jun 2021 14:37:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyKGuzt6VkoFoUlAWaJe8evaIA1QIU3+GOM1Ofc6+tjgndrMmCGSDwsqBN+7ahsRYZN7fO0Q==
X-Received: by 2002:a17:906:180a:: with SMTP id v10mr7410928eje.22.1623965843601;
        Thu, 17 Jun 2021 14:37:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y20sm122399ejm.44.2021.06.17.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:37:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 938D118072C; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH bpf-next v3 05/16] bnxt: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:37 +0200
Message-Id: <20210617212748.32456-6-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bnxt driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
program invocations. However, the actual lifetime of the objects referred
by the XDP program invocation is longer, all the way through to the call to
xdp_do_flush(), making the scope of the rcu_read_lock() too small. This
turns out to be harmless because it all happens in a single NAPI poll
cycle (and thus under local_bh_disable()), but it makes the rcu_read_lock()
misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index ec9564e584e0..f38e6ce9b40e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -138,9 +138,10 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	xdp_prepare_buff(&xdp, *data_ptr - offset, offset, *len, false);
 	orig_data = xdp.data;
 
-	rcu_read_lock();
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(xdp_prog, &xdp);
-	rcu_read_unlock();
 
 	tx_avail = bnxt_tx_avail(bp, txr);
 	/* If the tx ring is not full, we must not update the rx producer yet
-- 
2.32.0

