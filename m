Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8043A111E
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhFIKfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238834AbhFIKfa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLm94AjK7kFd76KBYEVaqEhzQehsWkzr0FHrLWea2VI=;
        b=i6ZYOnWdXrZdxa3duUjJDjOHj6Buns74bNbMYSWdqXdsShlGXWwqQT8k4+2V4c5VRPxRi0
        ByJYYXcePjFft+VaJZ8QP+R774RC1ep5StSDsZuvNla90wHtTrAStuMzBqo5G0mZfYR/K7
        J2elTHDnyrpFBkYyK5dnwvOSJmqi9BA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-5YA3Ckl2NXm2eD5_4W9D9Q-1; Wed, 09 Jun 2021 06:33:34 -0400
X-MC-Unique: 5YA3Ckl2NXm2eD5_4W9D9Q-1
Received: by mail-ej1-f72.google.com with SMTP id p18-20020a1709067852b02903dab2a3e1easo7854691ejm.17
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLm94AjK7kFd76KBYEVaqEhzQehsWkzr0FHrLWea2VI=;
        b=mO/sDC+k6eGDaOhd4Y4RbuFuMklS35TJpkt8ncnAfEsLoCwmZ7j1gSpBcv4cw/VrBq
         AM4bLSVLd86l34fWqqK2s/B+FNTFWtSaH9ddeeJuSwnXQlF2vW+i2M2t/GHWTcjSrAjz
         Xn+l5nzRU0ozQ9hdrI72SMqNjmLI2crAs1kvI351heomEDXFXW1o50O5j4DMsWtn8gqY
         8CRnHnf4vt9ndZlxET6zNxQkFccJwk+s9xxz3TsM9IPyhPMWQEJikFBeAY5c64lg5Kk3
         czyds4RntdtTy3T8GoOlvvASI1zIlMSRPNVfCgI4du7/ilz5Bu5e8/6rEi+mo8rXFrpA
         BsYw==
X-Gm-Message-State: AOAM531eU7nCTRsOpd8IObVLfEiSs3iY4weuMzCN4nNrlgtzYXeYqG6f
        4w0ZzVuwqtibZvFvfbggIwglK9u0KPiREKECQTB9Nw8zPp5oFqAmhF5ERGIFEHf/u1nuYAmfSdE
        ktsKHHwj7e/Br
X-Received: by 2002:aa7:d5d6:: with SMTP id d22mr29821026eds.302.1623234813634;
        Wed, 09 Jun 2021 03:33:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWc5YApHB9hF9X+ZdssWz2+d9p4i4aY5gUchXQSx4FgGgw0Nu4lE3bZz5FFK+6vN62FRE6Lg==
X-Received: by 2002:aa7:d5d6:: with SMTP id d22mr29821013eds.302.1623234813449;
        Wed, 09 Jun 2021 03:33:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x4sm953169edq.23.2021.06.09.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8A97418072A; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH bpf-next 06/17] bnxt: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:15 +0200
Message-Id: <20210609103326.278782-7-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index ec9564e584e0..bee6e091a997 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -138,9 +138,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	xdp_prepare_buff(&xdp, *data_ptr - offset, offset, *len, false);
 	orig_data = xdp.data;
 
-	rcu_read_lock();
 	act = bpf_prog_run_xdp(xdp_prog, &xdp);
-	rcu_read_unlock();
 
 	tx_avail = bnxt_tx_avail(bp, txr);
 	/* If the tx ring is not full, we must not update the rx producer yet
-- 
2.31.1

