Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E035C3A112D
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhFIKfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238903AbhFIKff (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6/ywr8A84xw5GpjlyvV4hRNlzB/uVzXQRS5Ys9UtLc=;
        b=LYvg19KeOaNn1RUYY9IhTFgzuk1eW/+SXH/70Fd7ZcvvSs+foxl/Ijq33XrUDdMAFwADG2
        iZR4MDQpNVVkzwIJP6B5k8CI3FPmt4eeRRIgGxF8jMPZZUpphXMMhDCZ7Eu8NR0TphqM4+
        ZX1VnqQEmSS+RSfKxOMv2xMvfUmjEUU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Ms80x6hjPcS96zBoqFB1gA-1; Wed, 09 Jun 2021 06:33:39 -0400
X-MC-Unique: Ms80x6hjPcS96zBoqFB1gA-1
Received: by mail-ed1-f72.google.com with SMTP id dd28-20020a056402313cb029038fc9850034so12229698edb.7
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6/ywr8A84xw5GpjlyvV4hRNlzB/uVzXQRS5Ys9UtLc=;
        b=Yv7M9ECVbT3tvku0mmBz2yQCpoc3syrzxuXg+NsVsz1V9ROEJly3FFDiniZ70OqdCP
         F6xkpCvLO+BdWC9+1r48FoMxrtzs6Goy9WJt3lwv4emDHgtxN7rkq4EgAPfk43ddHj62
         6vyd6Wicmm801UClN5pKp11zHU4Hlm+eQQq9gq3vRZyMyD4s8JeQLXYbe5mzjPp9K8fc
         ybj8kTdNPYJHOP8uRdPn5N0BxhPsfvaW8A4jFiXUIxhl8A25oTGR5NLtLWdNN6dc/Ygs
         PpkvDEX4LpIl1T8+uRFv6Lx/uMQp9NnsV+vsyhB2aNLEwd0Fcy7USeEEETTUxnue5T+4
         LVVQ==
X-Gm-Message-State: AOAM530HCZo1PMzNdmlpn5iM6IFBdYPu8sc3OobE3zbBTJfJYlr/aNTE
        ydtBg8nwZJHV5Ut3nDvJUOrW4A/DtAiRXoRLkPGe1Qzh3inoCHAgz5rSF42VKWGidEoj+nrVUNb
        vmBRGeMSZvY27
X-Received: by 2002:a05:6402:511:: with SMTP id m17mr29902728edv.1.1623234818393;
        Wed, 09 Jun 2021 03:33:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy8dEQdT/+2mrdhhPDQI/OtNZSHMX52Tnhpuds9eoPNSLQsCBSfjSo0BHivEiX/iSeqUt4zA==
X-Received: by 2002:a05:6402:511:: with SMTP id m17mr29902711edv.1.1623234818248;
        Wed, 09 Jun 2021 03:33:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l8sm933170ejp.40.2021.06.09.03.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F2934180734; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH bpf-next 16/17] stmmac: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:25 +0200
Message-Id: <20210609103326.278782-17-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
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
index bf9fe25fed69..08c4b999e1ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4654,7 +4654,6 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	return res;
 }
 
-/* This function assumes rcu_read_lock() is held by the caller. */
 static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 				 struct bpf_prog *prog,
 				 struct xdp_buff *xdp)
@@ -4696,17 +4695,14 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
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
 
@@ -4976,10 +4972,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		buf->xdp->data_end = buf->xdp->data + buf1_len;
 		xsk_buff_dma_sync_for_cpu(buf->xdp, rx_q->xsk_pool);
 
-		rcu_read_lock();
 		prog = READ_ONCE(priv->xdp_prog);
 		res = __stmmac_xdp_run_prog(priv, prog, buf->xdp);
-		rcu_read_unlock();
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-- 
2.31.1

