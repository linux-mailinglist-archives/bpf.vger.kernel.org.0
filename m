Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38C03B33A1
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXQQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhFXQQP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2TFlJi9GKn8kHSzVGGvW65aiKXAw7C9LqqB3xQR0H8=;
        b=On/IZPNM4EFUMoScWbbOD1gzWKp8v1zBEecp3/5QMMZEX0f7VgLcbS3XbqLxVWImZyxdHl
        Wd3W5nTaM3BnEzOZNGQg3hA17uVoVeCR1/fyMydIyKjiPM62B4zQ6B7p7uhQWTyAWW0G+Q
        IPAlIlNCNjZSecIzQiC80ds9HeJ64ek=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-qaHoTQblO923ROyAhjrnQA-1; Thu, 24 Jun 2021 12:13:54 -0400
X-MC-Unique: qaHoTQblO923ROyAhjrnQA-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a0564023591b02903951740fab5so219931edc.23
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2TFlJi9GKn8kHSzVGGvW65aiKXAw7C9LqqB3xQR0H8=;
        b=fOqkUIFrTygF4XgdKGpTkrzOzI+bGKs+c8lq0nz79FJsBnkrjsYcBnp2h5i0ewkAvO
         LkXT14kAOGpTyOt77CnkTmjHNLMc5s35nWLWG3NQfU+mBHStByPN9SuPjkVGHxi4zkEh
         DTkawWMgkvpPxCqncWUkS+H96Vqelg+0jMUdIMFMTARQSUZV7+V9UEjxdr2fa62KJ9Vw
         iqeKsk/imiUXvCDzeBA0umLoZ02BsNMFLwtByYzOKECrmEF800uldn0bPBqFjg1lTIqt
         MDL6lK5SVxjRJ09UlReAbgAwFr81+BH4iKwnac2bwK0tURm3G1KWiirp2Ot6dVJwOIsP
         545A==
X-Gm-Message-State: AOAM530vgKzE00HXU0n37nl0dIlRTncbMmELpASUC6/0Z/Vl7q5QmhOu
        Cx0ajZsCpg0jW3qb11oZaLJ49All7bvyS+g4NSnnYSPROAp4P5MisIAwsj1NKwyLOhLV3V6EKIR
        End+qtABDUkTR
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr8227418edv.34.1624551232804;
        Thu, 24 Jun 2021 09:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBzTBV14wD4eImYSJr0NCBJUPZ6x2+8VMbO/vpHKDq2WgvbGSgIyf02FNDKLvGPedudfKloA==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr8227364edv.34.1624551232385;
        Thu, 24 Jun 2021 09:13:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b24sm1421071ejl.61.2021.06.24.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B9907180743; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH bpf-next v5 18/19] stmmac: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:08 +0200
Message-Id: <20210624160609.292325-19-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The stmmac driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 16820873b01d..219535ab2c0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4651,7 +4651,6 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	return res;
 }
 
-/* This function assumes rcu_read_lock() is held by the caller. */
 static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 				 struct bpf_prog *prog,
 				 struct xdp_buff *xdp)
@@ -4693,17 +4692,14 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	struct bpf_prog *prog;
 	int res;
 
-	rcu_read_lock();
-
 	prog = READ_ONCE(priv->xdp_prog);
 	if (!prog) {
 		res = STMMAC_XDP_PASS;
-		goto unlock;
+		goto out;
 	}
 
 	res = __stmmac_xdp_run_prog(priv, prog, xdp);
-unlock:
-	rcu_read_unlock();
+out:
 	return ERR_PTR(-res);
 }
 
@@ -4973,10 +4969,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		buf->xdp->data_end = buf->xdp->data + buf1_len;
 		xsk_buff_dma_sync_for_cpu(buf->xdp, rx_q->xsk_pool);
 
-		rcu_read_lock();
 		prog = READ_ONCE(priv->xdp_prog);
 		res = __stmmac_xdp_run_prog(priv, prog, buf->xdp);
-		rcu_read_unlock();
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-- 
2.32.0

