Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF3B3377
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhFXQIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhFXQIj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wgUfE3YuyYqn3UXIkFwKI8I46axO+CjBlTP2HaYNQM=;
        b=H+CQFTNYFlqZ91AajQI6h6a777VAXYunpekDTPsc9LMWkdjF/ryNIZJYiPskxakOvlxBer
        Vh+SG7hIQJjcKnEVfRWfmVhOkSG/+X7ZY7k52PPARMLsQKPmvG+kMW0jF5ALlNEnDzy0wH
        A5dzy7MP5ozpLxPciXBEl+kTjpZGzcg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-fORYSm2mNHKoIKoKPlzUHA-1; Thu, 24 Jun 2021 12:06:17 -0400
X-MC-Unique: fORYSm2mNHKoIKoKPlzUHA-1
Received: by mail-ed1-f70.google.com with SMTP id o16-20020aa7c7d00000b02903951279f8f3so793930eds.11
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wgUfE3YuyYqn3UXIkFwKI8I46axO+CjBlTP2HaYNQM=;
        b=DbrAQuWT/BtEIrNdcV91uHWoIcXEswD5QTcsZNsisLVYk037G6CTSh5fWMAVpPy49r
         e+/Og2yRLCg/qg99L1aKMll4t633okkA3/yKkgEgaHcJasgWzIHavAxjy+RQAUQ5sSNu
         hVv/DjZO/2phdIo9DQJQC5dpfSCZxckXHeuw/dVX/h159qHPVMHe5NBNZTRKRmHQz0gf
         v+CEy+1xddUB3wPO+PKfZ2o4e40kqCt8OEyAibzkMOxcvIJvw3IX1p0l4/jV08YSgWuk
         YLEg0TNtmE0NESeaBKZ6IntZ1szEsLEsvjhnHDWQj97hh7RukYCevPztBBS1k4GDAlsB
         Aq1g==
X-Gm-Message-State: AOAM533aYj4WKM0Xeye8nnU+/kVUrIUz3XuQNgdCHa+4oEyqrTZm6F36
        C60PpzYH1UeHKEmox6UmVAirDWIOIcKGun5/vZEbYsSG8ajppgyjhu4cnSwVkXl3pkCdEkxij6p
        UtTr77392CfJi
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr8215065edu.26.1624550776303;
        Thu, 24 Jun 2021 09:06:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxno4q/K3m9BqPMkDP1H6oi4QyML09kHW15PWie27ZLhrpfBPKHQyKrcZaDXyviYFPp667eYw==
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr8215048edu.26.1624550776175;
        Thu, 24 Jun 2021 09:06:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cf3sm641548edb.39.2021.06.24.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5F5CC180739; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH bpf-next v5 08/19] bnxt: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:05:58 +0200
Message-Id: <20210624160609.292325-9-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
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
2.32.0

