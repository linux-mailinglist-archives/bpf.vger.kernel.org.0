Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557423B1875
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFWLKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhFWLJz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8Kxje9mo0eA1OfdUdQS/iz/Q4P9zCSTZ9JCaTqfbwY=;
        b=LJ/LrixdY0DomJ1qdS+pxgzhaqOT9CEW3QPgifRTaeoZVKaIBnhZFij+ah/r7f/jxTFVA+
        kLUCK/5s/5QAAbBDh0y4J63alDqtBb9vHu880OIZNaygFRrv9yTnccS5c2vT3V2nz1pbAi
        cVfcT6P/Sikq/Q6I599bWqwd9W4zVIU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-04jS0yrxOUiTOFq0HlOBbg-1; Wed, 23 Jun 2021 07:07:36 -0400
X-MC-Unique: 04jS0yrxOUiTOFq0HlOBbg-1
Received: by mail-ed1-f70.google.com with SMTP id v8-20020a0564023488b0290393873961f6so1091162edc.17
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8Kxje9mo0eA1OfdUdQS/iz/Q4P9zCSTZ9JCaTqfbwY=;
        b=RCOM7Ksu3RgjVXrmElNFJb0FhqpeOtL5D8nx3qqztJ0r4SUvKVbuT96XVsczsjBRIY
         84JBDunMU/lz/PogO8bz4pN7PYg+VN3SQV5t0GklFdEjUDAQ/IJ4xvYUGl/QbsW7VUQ3
         mOu6GZw94SczpF3d1fNWI0ZGe0+MI2r2ONyTlehTlqbYQCbWsZBHdBwOwy/0gscrj1Yi
         TGdDZDCQBuUimtbQz3vsFed+qkbE7ETtMdQmd65EIeT/8cSayozFMJkDdIwUvcx8K2Za
         Es7q70uIonSVzMOGModchxB3o/u86gu0j/sUmTWNJcbb8lxGixJQQSemVlnbvp+D27Z0
         r4XQ==
X-Gm-Message-State: AOAM5330xDUZapjz54O5p1oAsYeAp+hzQN8WSpRd+EzRbScUYuPV5thd
        acYjPUXDNEgFB569xj+eHr6u2RbGOg9OkefZJi83MRgUHV5cSH6Y2m4iJD0nu07g2dcvp6GiSUJ
        t0TJKq7x1U+4g
X-Received: by 2002:a17:907:2622:: with SMTP id aq2mr9352238ejc.48.1624446455072;
        Wed, 23 Jun 2021 04:07:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9y32Eh+jTvhrwfrV+XjryvNhw+II0gK5l99fd1c7Gry3y4vk/TmSfoejTBO7gW/Bf7bP9qw==
X-Received: by 2002:a17:907:2622:: with SMTP id aq2mr9352206ejc.48.1624446454670;
        Wed, 23 Jun 2021 04:07:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c15sm10860553edu.19.2021.06.23.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:07:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 266CE180737; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Guy Tzalik <gtzalik@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>
Subject: [PATCH bpf-next v4 07/19] ena: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:15 +0200
Message-Id: <20210623110727.221922-8-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ena driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Guy Tzalik <gtzalik@amazon.com>
Cc: Saeed Bishara <saeedb@amazon.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 881f88754bf6..a4378b14af4c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -385,7 +385,6 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp)
 	u64 *xdp_stat;
 	int qid;
 
-	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_bpf_prog);
 
 	if (!xdp_prog)
@@ -443,8 +442,6 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp)
 
 	ena_increase_stat(xdp_stat, 1, &rx_ring->syncp);
 out:
-	rcu_read_unlock();
-
 	return verdict;
 }
 
-- 
2.32.0

