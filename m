Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32A3A8355
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFOO5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231417AbhFOO5O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuVwKA1OMw5HxgYVzw3xNIdTf1mnrwsBt+MXeIcnXmI=;
        b=i2Vru2rc7NQrdQUfLAEzXPjuj8e5z6g0fiEkeA4zeAoWn76Z0Gl04E0eTf98OLLDTdAKkl
        1IzI2WJ67qo51KtE01mj6P6J13ZfejjS/GApxstdOMLVUpIr0OyWk6+ukotTuBYMImHx2+
        qM4wDltKrv3Tvs9lmIqUQqCgTHbmnmY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-x_ZcpvGBNAq5IF7IEDglYA-1; Tue, 15 Jun 2021 10:55:08 -0400
X-MC-Unique: x_ZcpvGBNAq5IF7IEDglYA-1
Received: by mail-ed1-f70.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so22520484edt.23
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuVwKA1OMw5HxgYVzw3xNIdTf1mnrwsBt+MXeIcnXmI=;
        b=Pvlbx/mow0MTmRrYquKLadfRMgi57uTMlfwRiGFwh4+VBFn+fkukFeNrHSb+xAR/BN
         mvwbzlcf6WgnZn2Iolmp5Ct4JJLGF0qVhc4au4TJVUALMrqGPXSnYezlfBkFwZ5Bi8tg
         dBdubqABkWt97+KyKyBCguuFiDP7kYRNwtmIbBJjN7LscDW2Ej+zSl8jxnG+Y4EchyK3
         D9rinGPoFsCujCOivQ3ow6G32jUdglBZRb5y/466Ob0CV7F1nGkwRl/bB2uixdhz1lm8
         QlEAYYY/ByGVOMVb74l+o4XrzEqMW8bDBDJeloq/azh6S+W4pnoOq7FugVfPAh+hldu5
         DZTA==
X-Gm-Message-State: AOAM532NnFQUJwnznKGbKHYzXoMKPClwxccFKLQjt3SGhVHkd3iRz2mo
        NDTyjYSXCopwKiWRZaS4ECJck+mJ/5Ct6Idb/9zLs+JWZJTOf4XR0LAPg+TpmVJK5s0LoxlDZAC
        O0TqzQf4/bAR4
X-Received: by 2002:a17:906:86d2:: with SMTP id j18mr20741204ejy.180.1623768906893;
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWpfiZnqpYkM92g7guVvXh6FJ1+oiuUPPVMTAPBLOqzvhVwFA4IyVKuSf3Gx69P5gjjEnkoA==
X-Received: by 2002:a17:906:86d2:: with SMTP id j18mr20741184ejy.180.1623768906755;
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u15sm12524316edy.29.2021.06.15.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:55:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D550418072F; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 06/16] thunderx: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:45 +0200
Message-Id: <20210615145455.564037-7-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c33b4e837515..1d752815c69a 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -555,9 +555,10 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
 	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
 	orig_data = xdp.data;
 
-	rcu_read_lock();
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	action = bpf_prog_run_xdp(prog, &xdp);
-	rcu_read_unlock();
 
 	len = xdp.data_end - xdp.data;
 	/* Check if XDP program has changed headers */
-- 
2.31.1

