Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EA3B187B
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFWLK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230236AbhFWLJ5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2arA4F9H8piXSu2BaYZfrwo91oZXpALZLKMt5odcOCY=;
        b=RM0QewaZCDtUVr6mp4IlKWBtXVEtWd4JRiw+i2sKlCa8zcyAL0tSbtZxz8Cuxk+ZU4jJBC
        IyxY8+Gsx3FxzsJO92AHCoFuhSjaJgwgSy3lLxYaif7JYVdwqcOyKqy6Vkd4g++KfXq0pH
        vvUNnCWe4x1eC9XzOIL0lbIBJg0SeFg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-BggyrzDGPGyuAr9EH4X8kQ-1; Wed, 23 Jun 2021 07:07:38 -0400
X-MC-Unique: BggyrzDGPGyuAr9EH4X8kQ-1
Received: by mail-ej1-f71.google.com with SMTP id g6-20020a1709064e46b02903f57f85ac45so835067ejw.15
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2arA4F9H8piXSu2BaYZfrwo91oZXpALZLKMt5odcOCY=;
        b=XZ6iQhR6twaRusMzAVyt53xbvFMhznvLjjYXriUZit0kLIYBag74SrvHoODi5Ex0gj
         u/6MBLnzRqukLzIXK7hO4DQiN7WKbOeZwhEFg5eM24v6lRw5arraFmFET5HgtGXMho3m
         F2oJt2X4MEWNQMwlLQI0e9vYkXZqPSM0KadZ/ab2QqXhNP4ETo2+R/kmLs2Qk91AElXT
         HEBu1nBEg5GsCLWJfl6gqWCsYTzStXfMm/WFOMTG29dLJWi35C5vNIEWTPVkshtHLb/z
         LBJytklWsRLNwWya6EKtrMG07ao71e0JoA8ONKOmG7CXxzQGV+eK2GaEGHeMfAbqFL4d
         G/JA==
X-Gm-Message-State: AOAM532bb30ca7ccaIEmOMdH575s1NYcz5juCISXQZ8SqWfj6nS2/edD
        q96oYbO1WqdA7jpPVMsLNDBWKKTxKXnZ3/VKgfrppCCtBFBymXNbVh/nnygEX8DXvfmK+5oNc8j
        3AD/L/EPOunZb
X-Received: by 2002:a17:906:190c:: with SMTP id a12mr9070040eje.491.1624446457193;
        Wed, 23 Jun 2021 04:07:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfYOxCXGNl6WwCkAT61NO9Jw5DYitkekz8LmF8VlrNsuA0TOsWQBt9kYvTmODjjA976dI+eg==
X-Received: by 2002:a17:906:190c:: with SMTP id a12mr9070029eje.491.1624446457054;
        Wed, 23 Jun 2021 04:07:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jl21sm5514474ejc.42.2021.06.23.04.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:07:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 32D22180739; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v4 09/19] thunderx: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:17 +0200
Message-Id: <20210623110727.221922-10-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
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
2.32.0

