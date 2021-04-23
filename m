Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5B3690D3
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 13:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbhDWLGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 07:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhDWLGD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619175927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6CycjK+7AbIhUKRxq6jvnqcUM32iF9Q4aWXrDqLBZk=;
        b=CB3GtEK+girdnZ7+8RMIrp8P49JNsbZ1vRgWBPH7pMajFxRBs6bpY9P/Ys7//qNgiHUDGM
        OEz2d94HRxgWR5yuMGnCiC3UCS0LbhmuUa4jCv/fpK7WtVryYuMLNG6Z7qcfQojtsSkTxX
        75wChsMXtDHrjYav1LNfB32R4+I5iNo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-9Z9XXFfUNU-sXLkZoF3VSA-1; Fri, 23 Apr 2021 07:05:23 -0400
X-MC-Unique: 9Z9XXFfUNU-sXLkZoF3VSA-1
Received: by mail-ed1-f69.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so10906776edu.18
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 04:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y6CycjK+7AbIhUKRxq6jvnqcUM32iF9Q4aWXrDqLBZk=;
        b=KEnkWBla7U7PCT14Ru6HlcB0f64hx5hps90r754tytTWD3zEZtRFtQIjPZugoAGmk6
         egiT9inIvGtk7kEhWg1DzSRZ04d2hyrblJSF1uy9RE25W7qlgX+Yo6m1q44AXa3Kw2G6
         9LoHkMegb+Zlf7grk7wog+4OjEzO5x3vADQMDdIBoMpYfghg849BwD8McFEbuYQB4iTE
         1xa9NI3UX0vE7omOyc3T1GzxJTnyIDSSEJoOM3XkoM9Yqro1RcAhzRJa50HlZ+J3PUri
         IilJceB0Oi08SfIrWXarlqytWv1tGsrTIHepDl1EK36zvzA/mWSJl8L7GILpp40TvxbJ
         s60A==
X-Gm-Message-State: AOAM532EWfX6AS5Hp8hQy0f3c0JUdzhJyHyd4lTouzbdZc0a+MnVJOAf
        DbDb2J2QQ9XJcARiq7Q4GW3GoBU9q1e+WXnZpBIO3mPtH7hGmHDhRjaXdefFhzsXVwI+m43/RMW
        S6Sg8EvO+1Qh0
X-Received: by 2002:a05:6402:204e:: with SMTP id bc14mr3844050edb.312.1619175921929;
        Fri, 23 Apr 2021 04:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVN6CsFlSwZ75LwdpuXibVMgjzYRAUr4kCAins33TvWRaF0+GxO5jSw81lxKZ0okryL/u+pg==
X-Received: by 2002:a05:6402:204e:: with SMTP id bc14mr3844007edb.312.1619175921535;
        Fri, 23 Apr 2021 04:05:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q13sm131479edr.38.2021.04.23.04.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:05:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 13205180675; Fri, 23 Apr 2021 13:05:20 +0200 (CEST)
Subject: [PATCH RFC bpf-next 4/4] i40e: remove rcu_read_lock() around XDP
 program invocation
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Fri, 23 Apr 2021 13:05:20 +0200
Message-ID: <161917591996.102337.9559803697014955421.stgit@toke.dk>
In-Reply-To: <161917591559.102337.3558507780042453425.stgit@toke.dk>
References: <161917591559.102337.3558507780042453425.stgit@toke.dk>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The i40e driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |    2 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |    6 +-----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index fc20afc23bfa..3f4c947a5185 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2303,7 +2303,6 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
@@ -2334,7 +2333,6 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
 		break;
 	}
 xdp_out:
-	rcu_read_unlock();
 	return ERR_PTR(-result);
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index d89c22347d9d..93b349f11d3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -153,7 +153,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	struct bpf_prog *xdp_prog;
 	u32 act;
 
-	rcu_read_lock();
 	/* NB! xdp_prog will always be !NULL, due to the fact that
 	 * this path is enabled by setting an XDP program.
 	 */
@@ -162,9 +161,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 
 	if (likely(act == XDP_REDIRECT)) {
 		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
-		result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
-		rcu_read_unlock();
-		return result;
+		return !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
 	}
 
 	switch (act) {
@@ -184,7 +181,6 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 		result = I40E_XDP_CONSUMED;
 		break;
 	}
-	rcu_read_unlock();
 	return result;
 }
 

