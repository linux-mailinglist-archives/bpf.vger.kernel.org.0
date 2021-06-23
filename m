Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66703B189A
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFWLQD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhFWLQC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRUA/Y9lIwzUgTw5uRoa39eJ4yIyIch6xpJH66I9Qdc=;
        b=cBV1dY+56IayfjMygaVM6XwcOpfakBGjMPq0+MyBVXYFJO1GFZqL4Y5tMv2uAyKa6N959V
        oyXd62GJ1aOLuBPoORa5NreVE9+Al8i59DZL89FFL5da7bvBgysE/dsr3hZFFN7I81HD4G
        hiRlxbVN8+xj6e6O48bWWc0Uh3gRtkk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-khex4e86NEGqwEePj9nchA-1; Wed, 23 Jun 2021 07:13:43 -0400
X-MC-Unique: khex4e86NEGqwEePj9nchA-1
Received: by mail-ed1-f70.google.com with SMTP id ee28-20020a056402291cb0290394a9a0bfaeso1112493edb.6
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRUA/Y9lIwzUgTw5uRoa39eJ4yIyIch6xpJH66I9Qdc=;
        b=V9wdVlMyxJXa20gbRIO3rQF4ciQhRq98Ecu4+Bn+cAsn3GBa24GaKy3opQdiaSXrAo
         HJFHV57xR5vSiFoSAzE5Y5dsRkbMH8FW9ZEA00qHxYYymAnl9NHqr8Y4X0DA8vHZaJCC
         mMM8l+dZuFMuabUQFqdx2/HlDabyWTIgC/xKiFMKXbaCtB59XcAv2gOad1QhnX/rJPWZ
         tx+P/IaPrpRY8AxXsJzEUk/PJGiG4RZoLBOjpn5LwkPTBoO/Vjl8oOieN5+XrZSWtGMb
         TBtHA1sf14UFoyjgTzavmhdiq6JLFEf5OhmV9jsA2RF5J4KrALbkmAHOlBOfAAtYNpaL
         m68w==
X-Gm-Message-State: AOAM532MjrGV8GjVpdaAwz6oPXJHEuNAkoQfhYjgR7aQc6dggYfsdY2N
        MmPJi9zUIIhrADwlqjxzAvx9r6xsn87JvNw68Am4LJEyOVW5/IzoNob0ovvZiiKVfyHGQWJjG04
        kYpJmiTOM5Q61
X-Received: by 2002:a17:906:34cf:: with SMTP id h15mr9261315ejb.526.1624446821843;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNBQa0CtVLyqSCtU7E+yLdrrdnxdFKoAi4uPGzq58jwGDY1F5UViDRBybswKmPs7D4pY6M7Q==
X-Received: by 2002:a17:906:34cf:: with SMTP id h15mr9261282ejb.526.1624446821485;
        Wed, 23 Jun 2021 04:13:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ml14sm3124574ejb.27.2021.06.23.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:13:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6C06218073F; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com
Subject: [PATCH bpf-next v4 15/19] qede: remove rcu_read_lock() around XDP program invocation
Date:   Wed, 23 Jun 2021 13:07:23 +0200
Message-Id: <20210623110727.221922-16-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The qede driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
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

Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 8e150dd4f899..065e9004598e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1089,13 +1089,7 @@ static bool qede_rx_xdp(struct qede_dev *edev,
 	xdp_prepare_buff(&xdp, page_address(bd->data), *data_offset,
 			 *len, false);
 
-	/* Queues always have a full reset currently, so for the time
-	 * being until there's atomic program replace just mark read
-	 * side for map helpers.
-	 */
-	rcu_read_lock();
 	act = bpf_prog_run_xdp(prog, &xdp);
-	rcu_read_unlock();
 
 	/* Recalculate, as XDP might have changed the headers */
 	*data_offset = xdp.data - xdp.data_hard_start;
-- 
2.32.0

