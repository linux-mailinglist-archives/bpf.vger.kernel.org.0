Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCD3B33A6
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFXQQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhFXQQR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOyh19f+n3Klc9n0Uf50USUZ/OAvnTAcZiRzl4mD+JA=;
        b=bvZ5Rdx5mkM9FtutcKafhMMIGgD5MPRuICcDIc3ChUORK4Qt73BsbuNJ6Jxj0uKbDp8O0U
        odXUhXshnwlcimCYTEu0lXH9Rn5iq7+Of1C//Yqc73hFFkLZMIjHh8cwQi9OVwCl6xLJh9
        oHNc+6N7EAt5c4szuLT/4Z+M1UkUdqE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-VcAfpJqsO26wt8MgsvDRzQ-1; Thu, 24 Jun 2021 12:13:55 -0400
X-MC-Unique: VcAfpJqsO26wt8MgsvDRzQ-1
Received: by mail-ed1-f71.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so3610529edb.9
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOyh19f+n3Klc9n0Uf50USUZ/OAvnTAcZiRzl4mD+JA=;
        b=Hu/RSsqWtabQhukg8OaZJ+gg4QmnwQw4H8/oIBSj98j0QRDa3DYo/eGYR6aJ3BXJK4
         Z50GPfHLjrH0/ttvr9qyeREnAjrJce6ml189VwnY+rpwm5jF0cPUl12J5akoPz9t6DDS
         59NkJH6Thkc2NWGYpmkobnnEqPoxz0KNeIdGNWGgh1sSzYtNorTkq5nyVAHKx/axLcV+
         BRC5ZqqQAVKGmRJXOY8vOiTbii+PLPjyfCTYj0CCe7Js8ejii+Ei+nmmTS1+pkosw5NA
         gqwxLMIOE/7NVrqIDyyqqG6n3qLjKDOQkD/szSdI4YnVvnfTuOAaSgHX1RCGQaG/quHL
         u/RA==
X-Gm-Message-State: AOAM5306+DARt5Jx+JKQnjb0+kyOXk6xXraeZqwq6UFp7BjfbOe5gMb1
        4G8/m4PJR86tvqgJcTT89q5+KSE8A1nIwV2mE7bUvi1qfCy521Il9MNJht7r+e5gYapvGBeD+a7
        sz3qY6Fv9ocrG
X-Received: by 2002:aa7:dc0d:: with SMTP id b13mr8086190edu.288.1624551234002;
        Thu, 24 Jun 2021 09:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO83p9KKeIz6WYXSUxDTv54YrbHmZN8vEVgN4NSgGIUd/3XQocFyAZ4VFu9V7EzZ2au7ZN8g==
X-Received: by 2002:aa7:dc0d:: with SMTP id b13mr8086172edu.288.1624551233868;
        Thu, 24 Jun 2021 09:13:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d2sm1433158ejo.13.2021.06.24.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC1B8180741; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
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
Subject: [PATCH bpf-next v5 16/19] sfc: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:06 +0200
Message-Id: <20210624160609.292325-17-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
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

