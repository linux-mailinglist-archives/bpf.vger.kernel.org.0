Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1433B1878
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFWLKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhFWLJ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wgUfE3YuyYqn3UXIkFwKI8I46axO+CjBlTP2HaYNQM=;
        b=haKbaYHAcK/TVv1BrruVYLKOU3QcMtLT4GX/HISDznKw3zgOFs9rF0DUE2w2kX6vAylEsK
        Sk9Qdl9ENBc+ThSeDrYeB0u+aRAij7RcUtgr/HbyH2VAD13ksi81bVeHJSD/qKXftMZ2cW
        OxeFX+XV2PRLi8BS0l3k+zUL7elbalE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-tW8ZibmTPkSnCWs8Rx2sdA-1; Wed, 23 Jun 2021 07:07:37 -0400
X-MC-Unique: tW8ZibmTPkSnCWs8Rx2sdA-1
Received: by mail-ed1-f72.google.com with SMTP id l9-20020a0564022549b0290394bafbfbcaso1114525edb.3
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wgUfE3YuyYqn3UXIkFwKI8I46axO+CjBlTP2HaYNQM=;
        b=rqLrg7qt542f5jxd9Vu+E6sfI6hffGrgVeLQu5hPl+xJAmuN0Uk4SlNf+by+/Zv0py
         GF5hx3hgA6RzTAWHFNFex/XGddl5fUV6mEUNcWBfUnb39Y7H/21wW9Hrmj4QaCKrE24b
         ZYn64p38oV+KoIK/F1Did6xPDNjFTPkKXU3mcBlXNj41dsWRjj4J68s8hnoWlo3U39T9
         xXYWGdB8svl2mjsCuuxddBoSJiOwMvnqm0yjjgO9lJrY8njDmRZ0Vem2MlB0qqe+oc6V
         8cUkFT38SDJX9rgWqIMVE77S0VWT/GXu9CFgMi0FMqP/rWBQN3q4829KDYODWfIALzJY
         i62g==
X-Gm-Message-State: AOAM530Ush+D1lH1oRh8As5E4CSU8+tmLlPrlMaltS16k2tg9yHobAdv
        r41V51x6nyOEWhLNT1evjaRzoFjzSfy12Drw/z9l/9EzaloCGbB3r6N4IuowG9a0RB6dm4dMEQC
        RNqAVXcLFvja/
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr9452854ejb.551.1624446455888;
        Wed, 23 Jun 2021 04:07:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJuPR44sF0OT9/VupxhagYWjU/hFE+FqxoBPV+oB/0joRp0VUukfBXi80r+7q0PrJGZP+Gvw==
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr9452834ejb.551.1624446455697;
        Wed, 23 Jun 2021 04:07:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n2sm13468522edi.32.2021.06.23.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:07:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2D0B9180738; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
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
Subject: [PATCH bpf-next v4 08/19] bnxt: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:16 +0200
Message-Id: <20210623110727.221922-9-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
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

