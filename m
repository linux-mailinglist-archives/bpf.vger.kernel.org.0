Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC963A112A
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhFIKfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238912AbhFIKfe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOVdIjFGkWIiDQLhZ4O8JX1OgtVYddfMXm2FFCs+0ZU=;
        b=Ca+CgXLqL1676s5pbIP9mnV67820stEjcwqqQVbWs0VHPDGkoghUQSLqjy9bwd5hL5R0pp
        +Za0wsNL7tWjq3Qko2ZekeoDDAHRF5srMZeFezlApP0zLiHYf9GMfUu9MOo8yFk3rXzscU
        6t68vOwbRbbycIUOeGS7gHS+PXQldZ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-CDuaDmSnNYeJDLIrm6AZzw-1; Wed, 09 Jun 2021 06:33:38 -0400
X-MC-Unique: CDuaDmSnNYeJDLIrm6AZzw-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so7842585ejz.5
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOVdIjFGkWIiDQLhZ4O8JX1OgtVYddfMXm2FFCs+0ZU=;
        b=N9IRV1sfzVSar8VNBDHmoFleygGEUbLcRbx2zlakFQQIvxduqJAJeO5lwcyvRShMOZ
         +qjacmzcPx8/CyQcT37txnD34/dXF37pSHGazMGf9mhLMbYvsh2R1H8QVXpXPQcvfTn5
         EjRmxMeee7CPeLa6L2b9N1z4cNkjgcuscTRbdqrVw++nVWgYhcnYdNt9rBMEtH5KhItO
         cQ3YD3dPPQ9NGynYTuqln7cDQtsXTa0jUWj1MW4N3l+aHvCMSAozGoWgo0FrrZhSvIgR
         A97IPdPrIAz8P6m7QxZ368UAnEM1oNITToCuocuBJSHUTNtUNDSB6g2cxhMXZrEmDAE4
         1ZrQ==
X-Gm-Message-State: AOAM532/UDIhdM3Qk/1WUA79MA5Nskv3a5xFc4SCdNMOq1whDkfCTtYq
        oI74tk3S9o6ODSUpVWfANSKWZJz48KdLzAdsYWAvX7qt9srKfwvTHfOKladNYp7+UctdyOupM+F
        CaFKtXBu4ZvTn
X-Received: by 2002:aa7:c547:: with SMTP id s7mr29599535edr.239.1623234816147;
        Wed, 09 Jun 2021 03:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJsMQfvKo7/nhkmRlLMchZWxJh31qEpOl87eLrNsvu1Nhy2NQKMbTQafLxov+eQh4WGHJZIQ==
X-Received: by 2002:aa7:c547:: with SMTP id s7mr29599525edr.239.1623234816007;
        Wed, 09 Jun 2021 03:33:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c6sm916307eje.9.2021.06.09.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 95EA618072B; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 07/17] thunderx: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:16 +0200
Message-Id: <20210609103326.278782-8-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The thunderx driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c33b4e837515..e2b290135fd9 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -555,9 +555,7 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
 	orig_data = xdp.data;
 
-	rcu_read_lock();
 	action = bpf_prog_run_xdp(prog, &xdp);
-	rcu_read_unlock();
 
 	len = xdp.data_end - xdp.data;
 	/* Check if XDP program has changed headers */
-- 
2.31.1

