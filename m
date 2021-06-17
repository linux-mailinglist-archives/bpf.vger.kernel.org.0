Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B943ABE3F
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFQVjh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhFQVjg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJz59YB8g7oLdL+mJzpIs/zDJlYd7kwgcbU7x/ViItE=;
        b=OLrvLcJPRWOqKsrReXwUvbhvPVmJY+iNlWFuzI7TTPyvIQhfaA+ZF1YO6EzX+H9bbAKLhl
        1yK/DyhW89yKI2rF3Wk4B42PzReCX3N+TqM50kOq+Z03IZftjVB4BHRqb3aIJaxm8QHNtZ
        lIjr2YfHRf9J0tqoS/SGVT28h+cchEs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-pLLRDiEeNVqkD-_KZdAvbg-1; Thu, 17 Jun 2021 17:37:27 -0400
X-MC-Unique: pLLRDiEeNVqkD-_KZdAvbg-1
Received: by mail-ed1-f70.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso2417008edd.5
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJz59YB8g7oLdL+mJzpIs/zDJlYd7kwgcbU7x/ViItE=;
        b=cXaP4S7jenz7mqWOJaJyhxkaROrtrYsv1HpoYyGKn0d3qe3/UvkKSeRDlOdPnIRhmW
         q3UGJXrSa+6eqLlRh8twkiqu4GoxhYpyHm7gQLQOzy8087co1qyxHNdRbi9GbqimnrdL
         mq9cZdlj0xzWBfEOY7KnIifbj+a9SYHcOBDTqHV/hA4NVkCMZ/3EQ4DBLJV1amUdt8py
         MU075Ap73zsShAoZV6r6dMSiqwRgXOoKHSRuXcclugOQswlHtuFTVH65cExa06KlKs6W
         i2yZbkEJ8Pla/uAj1FVkteljZ4YcUPQFqCtxyes+JzyHpLxBE9/lJ/yx3Bt2zxthdlXK
         bZjg==
X-Gm-Message-State: AOAM532eSn5sC7yVbHyHvNG4BNVfI9hlpfgvBrkQQP5Pnv60TUnexpoM
        B6CGgmK28JM+PbMjayBtQg3pcnB3g01oxxOuP8l9UnYpjBNLu0/vmYezoG5Op9sj28olHkQ80bB
        hGS/4kAtu1hM/
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr7529617ejs.501.1623965845819;
        Thu, 17 Jun 2021 14:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7MiYndSZPPnikrer9lLYqdDjZqLkcm6ZdagJQugiaU6quK0vkJPkwzDn0Y2udQcNQ/YaluA==
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr7529608ejs.501.1623965845672;
        Thu, 17 Jun 2021 14:37:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f4sm125915ejj.49.2021.06.17.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:37:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A1B4A180730; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH bpf-next v3 07/16] freescale: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:39 +0200
Message-Id: <20210617212748.32456-8-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dpaa and dpaa2 drivers have rcu_read_lock()/rcu_read_unlock() pairs
around XDP program invocations. However, the actual lifetime of the objects
referred by the XDP program invocation is longer, all the way through to
the call to xdp_do_flush(), making the scope of the rcu_read_lock() too
small. This turns out to be harmless because it all happens in a single
NAPI poll cycle (and thus under local_bh_disable()), but it makes the
rcu_read_lock() misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 11 ++++-------
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  6 +++---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 177c020bf34a..98fdcbde687a 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2558,13 +2558,9 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 	u32 xdp_act;
 	int err;
 
-	rcu_read_lock();
-
 	xdp_prog = READ_ONCE(priv->xdp_prog);
-	if (!xdp_prog) {
-		rcu_read_unlock();
+	if (!xdp_prog)
 		return XDP_PASS;
-	}
 
 	xdp_init_buff(&xdp, DPAA_BP_RAW_SIZE - DPAA_TX_PRIV_DATA_SIZE,
 		      &dpaa_fq->xdp_rxq);
@@ -2585,6 +2581,9 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 	}
 #endif
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
 	/* Update the length and the offset of the FD */
@@ -2638,8 +2637,6 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 		break;
 	}
 
-	rcu_read_unlock();
-
 	return xdp_act;
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 8433aa730c42..964d85c9e37d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -352,8 +352,6 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 	u32 xdp_act = XDP_PASS;
 	int err, offset;
 
-	rcu_read_lock();
-
 	xdp_prog = READ_ONCE(ch->xdp.prog);
 	if (!xdp_prog)
 		goto out;
@@ -363,6 +361,9 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 	xdp_prepare_buff(&xdp, vaddr + offset, XDP_PACKET_HEADROOM,
 			 dpaa2_fd_get_len(fd), false);
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
 	/* xdp.data pointer may have changed */
@@ -414,7 +415,6 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 
 	ch->xdp.res |= xdp_act;
 out:
-	rcu_read_unlock();
 	return xdp_act;
 }
 
-- 
2.32.0

