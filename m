Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488273A834E
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFOO5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhFOO5H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmidfz0+CJmOWuJ1Ds56KwPBuWWIUyMrF1VbqTWEQjA=;
        b=YDOq+egnLxkhOlj0RrMALtgAK84MJMAMtS5kHLSBgKxdG/9ywVp2JHhJ82KQOHfCNZcDJD
        IjIa7iRvsxCgD5q51dQbKhGFn22gpJYfcKVJgN6dDSzgvMDCUEOSLUObGv046Ui1IQfI6a
        tolMMHOLz/+udZLC8KXAQsGv86YtVDQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Uqb0tZa7OiynuEPT1WLkaQ-1; Tue, 15 Jun 2021 10:55:01 -0400
X-MC-Unique: Uqb0tZa7OiynuEPT1WLkaQ-1
Received: by mail-ed1-f70.google.com with SMTP id p24-20020aa7c8980000b0290393c37fdcb8so11227769eds.6
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmidfz0+CJmOWuJ1Ds56KwPBuWWIUyMrF1VbqTWEQjA=;
        b=dfeaBjqA69QrlLyNGEwaN3/mnQolrGk8biIGTwygtvONlauTLgRHN37Mosq6+WZYSA
         cSTpxEmbkvK59tzEhvYG0vL4VrWkffJEWmWjDW5sku9b7massEJCpIi0sLgqxz9kcVmg
         FBnyEEGXhmXRQn2XQA5G1S9iYOdfXiJ8adFYYlhj/ZisHWqhcmT3bUa970rF6iQNgCAj
         J4pAytDYPOxVhAXIJTUrfKatfag6XarbZ/Xxl8JeT/owCF3u72IPs+AjE/YrY6jlc7GL
         gbDhPKt5K9iPRUKZqtR0giCxMvhDOX90j9pz4iGbnL432PPQX61SIKE0gwHLwVQblrtn
         JKFA==
X-Gm-Message-State: AOAM532/5HcMDIkEnnc37jMKRDRY9V+wBxIKtgt7EZWPd+2K8F8v8Vj4
        MzhrYJvW/JjCeWILWuCMODTpqS9AqowLksqqIF/I2Oh/GE0wFJoV4RntHSO5H/2c+/tyJ162guG
        /a5DS2xEtNJP5
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr23790302edx.189.1623768900337;
        Tue, 15 Jun 2021 07:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNRBKZlwf2ReOVkRIekxwBZ2n5A2DWRM9fshz8kMlqUDSUxWOoQYe/r7X+b9O8Xp4q8OQ9cQ==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr23790285edx.189.1623768900198;
        Tue, 15 Jun 2021 07:55:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id kf3sm9320945ejc.8.2021.06.15.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:54:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C4240180727; Tue, 15 Jun 2021 16:54:58 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 04/16] ena: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:43 +0200
Message-Id: <20210615145455.564037-5-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
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
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 881f88754bf6..cd5f03691b4c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -385,7 +385,9 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp)
 	u64 *xdp_stat;
 	int qid;
 
-	rcu_read_lock();
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	xdp_prog = READ_ONCE(rx_ring->xdp_bpf_prog);
 
 	if (!xdp_prog)
@@ -443,8 +445,6 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp)
 
 	ena_increase_stat(xdp_stat, 1, &rx_ring->syncp);
 out:
-	rcu_read_unlock();
-
 	return verdict;
 }
 
-- 
2.31.1

