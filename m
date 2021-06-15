Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1EF3A835F
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFOO5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231513AbhFOO5R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2w+HImdAUwFSlY1hYWtFiNbCUvYk0lFrUyqVDU6cjY=;
        b=BbLUXcYtv+QJci6U+j8i34Uv1eFakGldxqkcKXdWdDhuLMjUMx2HLy+X3znm11LumbwsWR
        uv7RfzQOsIu0Y2YVlZwkJbe4k+E7cu8MuP59KgXIy5bq0ft6+MibRcG31VG9ElonJMsUo+
        V1c04ZJbA1sk/JuI4I7ngitWjhIbYdM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-XTgxMbJYOviYHSgPyV-Sbw-1; Tue, 15 Jun 2021 10:55:10 -0400
X-MC-Unique: XTgxMbJYOviYHSgPyV-Sbw-1
Received: by mail-ej1-f69.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso4631209ejt.20
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2w+HImdAUwFSlY1hYWtFiNbCUvYk0lFrUyqVDU6cjY=;
        b=tzzRQCtXhM1COHtnu7ca0tNTgWY9d+a50pWpI6YipPLe7b1rsroWeG6kSEyD7vVWEB
         8orIF7tQ4bYDfrKA2z+lLFNz3i/4tV7OLJc2UgHnNfSvubHuJJi8Rsf28Te2fEg6zTNF
         FpngxYeViBfKw78EnxmfEv12w+T6y6QCEXvqdKawtN/C6lUGKiUienw/iwr8WBcw5uEX
         t+ZZcd0Ep/eVdQ9/tn+4+8ijkvdi8ctfWNXA9J3tzQ2gT2TMlBe6xLDw0ftJly8HhuPy
         ofEFLPH7n2ws4icQV23CIlEyuBt4FeyVf54xX2oB84lOel/hr+CVpjS4mlHSTnHoDtSL
         SB/A==
X-Gm-Message-State: AOAM532iKbSe+LC5nmkouVL4v7Zs8QJ/vxO3Ni8kSuoq4Xro48N76hNl
        IZfqeIoVzaMDKg7bU5ACDEky/WjBtsUwGZ6RyfB4WA/GGnTVqQMNMzABVG30KvpHb2CceBWY/Id
        xfYae/+2sZF5a
X-Received: by 2002:a17:906:994d:: with SMTP id zm13mr20665193ejb.427.1623768908862;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrD5ykD8QuStI7yTpQynBYBmFa7phE5jHXSY1xZ0QyxDdvR2QIW94oCmW587hJOv+QJQ4J5Q==
X-Received: by 2002:a17:906:994d:: with SMTP id zm13mr20665154ejb.427.1623768908470;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t5sm10267312eje.29.2021.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB6F6180730; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
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
        Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: [PATCH bpf-next v2 07/16] freescale: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:46 +0200
Message-Id: <20210615145455.564037-8-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
2.31.1

