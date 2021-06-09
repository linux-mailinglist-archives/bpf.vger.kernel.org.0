Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7893A1150
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhFIKkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238070AbhFIKkl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8R6RyRHO67ifLZIR9gGLNOyftDsWB9ahrub2+xbd3e4=;
        b=Go0kKejyD40UyeGrcDtAraY9B+gGp2o+GoL9+10Acgg7M6yvG1Yh39a3OQ1KIQV8/iDLm+
        /4JQzW7TCYGo7YXxa7ZA0XwxuBkqPs8+hSV2WLjROBLJolVClzNBTsCWUhPw7a8u9L70Mb
        /2xGeV7NxWHWy+WpRkB94LsPaykKWDU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-7ZHSOhVBNFOAd31gkMhbfA-1; Wed, 09 Jun 2021 06:38:45 -0400
X-MC-Unique: 7ZHSOhVBNFOAd31gkMhbfA-1
Received: by mail-ed1-f69.google.com with SMTP id c12-20020aa7d60c0000b029038fccdf4390so12192447edr.9
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R6RyRHO67ifLZIR9gGLNOyftDsWB9ahrub2+xbd3e4=;
        b=ZiZ4OFaJGtZG5TYEWKH9jmkF6LIk28JsYbweRTvNbIHBoHr8HI+m2IvjarT1aVxD6t
         /9Zo9wQ/wWlO+mBrDKXLSZU2wqYOH77LeaEZpCdUvYJ7OiioRzX4alW/MoQ6/v85Emp7
         f4399WrgGATkhj7WmYphKU+DYoFrLKRjTDgTsFZtdWYFjFvxpibtI5jreudvfgUGE/yr
         NxWSeUiZXBewtgyStfDQ5RVWFJPS9TOecFnrF1/1catvw1YnB0mayqGOR92FWFyMlWK0
         xs/o37hK7aJPfDJAVBvhd9fmPM/kh3DmY5wrER5REbaFl98/o7viNr1jBzroNsbr/5rs
         9ZXA==
X-Gm-Message-State: AOAM531asffx1SEJuq9LwWQApm+wgGFiZl6on8PvWLvuw/7s20RYbdTV
        p6oBnsYLfTKj9enM5NuAIOr4gmI/NjRb+BCIwXSqYct+wjrmds0Ox+adxRf3Rvc0JnSwFd3lC96
        7/Iz0mnL56/Iv
X-Received: by 2002:a17:906:9715:: with SMTP id k21mr28048381ejx.553.1623235124785;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvLr0lbuBFvW5cCFJTjirrWeEr6r/YlVd/ZkLudMiEalQXD0poZgcUxpKwqjuuUBC3AxiU/Q==
X-Received: by 2002:a17:906:9715:: with SMTP id k21mr28048369ejx.553.1623235124649;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u19sm920226ejt.74.2021.06.09.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0ADBF180735; Wed,  9 Jun 2021 12:33:31 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH bpf-next 17/17] net: ti: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:26 +0200
Message-Id: <20210609103326.278782-18-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
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
2.31.1

