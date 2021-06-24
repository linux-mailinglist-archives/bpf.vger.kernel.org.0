Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603C03B33A8
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFXQQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhFXQQS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=436OaxB7FEvDC8Cj4cGRRV7bgo1JzvFAvSGPF+E5hVA=;
        b=Jan/KNbZsQ6l5N33RAmp+3SZgMwQBRR1zqGFBWdyQD3TNpYBQNVzcSckFJNxBoatZwxsDm
        KTAuO5rBRZfv9t9ze7IW6dAPSx1drcxXshCNuNcwy4vkEEvUlqaoRkRkcldNoAEvHjOvYX
        MKqI0YBCwcZvdwiARA60frbepynq5BQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-768-Pu25Pmi8hIm2eMO4mQ-1; Thu, 24 Jun 2021 12:13:57 -0400
X-MC-Unique: 768-Pu25Pmi8hIm2eMO4mQ-1
Received: by mail-ed1-f69.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so3602299edt.13
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=436OaxB7FEvDC8Cj4cGRRV7bgo1JzvFAvSGPF+E5hVA=;
        b=p567rtUiO/nVZOTnljHxQ90abx/ct31mCxpUbGdkGQYF8/16x6axgDh0LkqwT0zkjS
         GvT3gJyCqHTMOus5JW0hPmnpz1UvrlMokEaJc2c8e1aPx1NepDmc0qJG93/giTpybwH2
         PzpWRQvM6UPK0jFIKG4V0zBih46CmilRf124XSnJy3GXkZCLLJ1vrp9LyBu9vO5zWPcG
         KwxR/ZuO9yTIqjNr1dMu5IKMYFJRsbzmkX5b679t1ilu5PRsfvOAkvsxnDjkHKL2cArd
         sgrVCY0g60YkC76Wu6jgasPjXCbJQbX913Ak1Zi4wPzymMk3M6QO7FvPhYvIYxZ5uIJQ
         VnRg==
X-Gm-Message-State: AOAM533XtDOzg/ocyxqjrKAGFPLo4OqYbZkiNqsQOjM98orUAvjcebxq
        dZhlNK8zGLSDZBJgqQu/3ihoTHWrgcbJOTv3SpKfcxyQl2jai4tP97pLGzhmyRZhr7K2gBcQE4S
        LeFD8B/NCNheK
X-Received: by 2002:a17:906:6c92:: with SMTP id s18mr6001742ejr.246.1624551235823;
        Thu, 24 Jun 2021 09:13:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTqg1XkldV4Ka01Fa9wZUX9Na6VfS2RopbGr4a7OYV7FQUPzbFORmoCWAMgTSsKp/g8aWzXw==
X-Received: by 2002:a17:906:6c92:: with SMTP id s18mr6001702ejr.246.1624551235374;
        Thu, 24 Jun 2021 09:13:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id yh11sm1408621ejb.16.2021.06.24.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:13:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C0535180744; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH bpf-next v5 19/19] net: ti: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:09 +0200
Message-Id: <20210624160609.292325-20-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cpsw driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/ti/cpsw_priv.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 5862f0a4a975..ecc2a6b7e28f 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -1328,13 +1328,9 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 	struct bpf_prog *prog;
 	u32 act;
 
-	rcu_read_lock();
-
 	prog = READ_ONCE(priv->xdp_prog);
-	if (!prog) {
-		ret = CPSW_XDP_PASS;
-		goto out;
-	}
+	if (!prog)
+		return CPSW_XDP_PASS;
 
 	act = bpf_prog_run_xdp(prog, xdp);
 	/* XDP prog might have changed packet data and boundaries */
@@ -1378,10 +1374,8 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
 	ndev->stats.rx_bytes += *len;
 	ndev->stats.rx_packets++;
 out:
-	rcu_read_unlock();
 	return ret;
 drop:
-	rcu_read_unlock();
 	page_pool_recycle_direct(cpsw->page_pool[ch], page);
 	return ret;
 }
-- 
2.32.0

