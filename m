Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25F3B1899
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFWLQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhFWLQC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOyh19f+n3Klc9n0Uf50USUZ/OAvnTAcZiRzl4mD+JA=;
        b=W9SyoSi8B1sOzdyy3LCQRfLDEX/RUOxpDwaPziCFQFg5J9jh0XnbA84m8kGMdedx7E3yMI
        CvTX8PRZGceRt6Pe7LxiaVmPPBz1FXSByJboZJuGm9H7xihcUSGnwloHlucWzaPcMEKkv9
        DK+mpScFTtx9PlA6Tqx2SLoKBD8jnCE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-W0TcVJuyOAuxxoJRnO9oYA-1; Wed, 23 Jun 2021 07:13:43 -0400
X-MC-Unique: W0TcVJuyOAuxxoJRnO9oYA-1
Received: by mail-ej1-f69.google.com with SMTP id o12-20020a17090611ccb02904876d1b5532so851044eja.11
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOyh19f+n3Klc9n0Uf50USUZ/OAvnTAcZiRzl4mD+JA=;
        b=XFgnVuuCGNTAIlmGoPOfvvhgIsgPvNci8SnmfVfLqNxpeD5UVxgaoI84S/W/CYycUH
         VnG1qEj7SjfKula+MY1Nen7v9HA8umpXKVQAF8TPZTjCKa5SeoSiYzu5kSnUpEZ6s768
         /DNiIlrxUEZx4UVsuykQD1lNKsyAgCTmk8gpvVhFGAl213qaVmqybJLzpCQssb1QEin/
         qNwedIa9iKbPQOEy7m9clYfclAImVhD78BnsRpBF0phQeGqr7pwznQNg1VlGcTSraPtm
         dYlDXNluOGm144Tw9Mxsi8QLQwYkxKNTciXCaO7e7EM7R0RLn2ROXwTNDbGEG9T46JqC
         X6kw==
X-Gm-Message-State: AOAM533VWWRGLpHvpjO4td82VloqYOxkiilr7rGCTWAgpgHvJQPFnGxm
        CvDcTKKDgVw/4dh9I/5MVv1UepAz+Lz34VBsng+mu8ePxPYwaalzJFCTfBvANQq41WzvlvN9hh1
        g1ADEE0aWyWV0
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr9602766ejc.74.1624446821903;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFC4J4yF4C76IBXxeFdHx2yW30lP8pvvXj7t+qqzCoChKhiwz3GKGGMBaMUXSqFPorcLDoxw==
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr9602748ejc.74.1624446821693;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id bq1sm7200517ejb.66.2021.06.23.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:13:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 74594180740; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>
Subject: [PATCH bpf-next v4 16/19] sfc: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:24 +0200
Message-Id: <20210623110727.221922-17-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sfc driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/sfc/rx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 17b8119c48e5..606750938b89 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -260,18 +260,14 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	s16 offset;
 	int err;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(efx->xdp_prog);
-	if (!xdp_prog) {
-		rcu_read_unlock();
+	xdp_prog = rcu_dereference_bh(efx->xdp_prog);
+	if (!xdp_prog)
 		return true;
-	}
 
 	rx_queue = efx_channel_get_rx_queue(channel);
 
 	if (unlikely(channel->rx_pkt_n_frags > 1)) {
 		/* We can't do XDP on fragmented packets - drop. */
-		rcu_read_unlock();
 		efx_free_rx_buffers(rx_queue, rx_buf,
 				    channel->rx_pkt_n_frags);
 		if (net_ratelimit())
@@ -296,7 +292,6 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 			 rx_buf->len, false);
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
-	rcu_read_unlock();
 
 	offset = (u8 *)xdp.data - *ehp;
 
-- 
2.32.0

