Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109833A1122
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhFIKfe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238903AbhFIKfb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623234817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/SrqPGFLKHkMSppfFjGdsFHhz75MKKcU6rUhA3fuUE=;
        b=B0mbVZl/WIpapdiEQ3DlRw6F6/ADNABUPTca/tt0eBYVaITHe+9b8re4k5jgB4J9trOYEq
        fTgn+Z89Xi9A4zZdPhVkT5PZaNltgHbsBKzHzlHLsgndu8SToTJg1EiDKM3cjVVe67ubeW
        yuD5S8SV6bmArHxx4EKSEBIx/0k/dV8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-nZKnQVf3Mzuix2C7w8fJRw-1; Wed, 09 Jun 2021 06:33:33 -0400
X-MC-Unique: nZKnQVf3Mzuix2C7w8fJRw-1
Received: by mail-ej1-f69.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so7865976ejc.0
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/SrqPGFLKHkMSppfFjGdsFHhz75MKKcU6rUhA3fuUE=;
        b=DS6ns9gvJ/sMouuV5Ggb3DyahKxJEj7X1XUpXfU55GIybC0rXSPOX//sYSW37HIV+l
         C0ROtB0I+ZlVEI5mser8nBj06xN13Qo+DtnKyvb3+jRmvKpUK2BxMrtDRX3WBZnLzjEe
         NxzOM2W5F8qPXjL6AtenSKmpH03d0TtekSKG/CymnRNiXUcWVFZJnx/NE4UNavksK8xm
         I8w0yTbfUuPyUTPc5wExMLj9optDsDnh0pt+IKbPVzm+jBCfnI4qvlgbEzZYQ7Bd3P6t
         SBGuLWK1X2T2YV2oO5+QVzUG3xw0/3CcE0GkDDL5OGm0EFgOz+zekhdzkAzMPfe/ZQw5
         TSew==
X-Gm-Message-State: AOAM533EkF5RNG4IVWl1O8wK7ImfsFL67N0I+c4LCRtZfn+88JTig8Qq
        qYxTYomveZr51FFh5Znd+Lst+GC6eZGnT7ndIqCGS/3gIzSYOe4FaQvbTMxHBofRO6fZsUU6QOy
        LFJLXqm15a5Cl
X-Received: by 2002:a17:906:7052:: with SMTP id r18mr27442490ejj.449.1623234812601;
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4/qlqfnwcNgWwFsRkkZlUJhNrhFNB6oEw7PGNWLub37Dm+YNrF8XK6GjyP+L1HoY7Bz9mQQ==
X-Received: by 2002:a17:906:7052:: with SMTP id r18mr27442470ejj.449.1623234812401;
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n26sm930539ejc.27.2021.06.09.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:33:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6E3F3180727; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next 03/17] dev: add rcu_read_lock_bh_held() as a valid check when getting a RCU dev ref
Date:   Wed,  9 Jun 2021 12:33:12 +0200
Message-Id: <20210609103326.278782-4-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some of the XDP helpers (in particular, xdp_do_redirect()) will get a
struct net_device reference using dev_get_by_index_rcu(). These are called
from a NAPI poll context, which means the RCU reference liveness is ensured
by local_bh_disable(). Add rcu_read_lock_bh_held() as a condition to the
RCU list traversal in dev_get_by_index_rcu() so lockdep understands that
the dereferences are safe from *both* an rcu_read_lock() *and* with
local_bh_disable().

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index febb23708184..a499c5ffe4a5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1002,7 +1002,7 @@ struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex)
 	struct net_device *dev;
 	struct hlist_head *head = dev_index_hash(net, ifindex);
 
-	hlist_for_each_entry_rcu(dev, head, index_hlist)
+	hlist_for_each_entry_rcu(dev, head, index_hlist, rcu_read_lock_bh_held())
 		if (dev->ifindex == ifindex)
 			return dev;
 
-- 
2.31.1

