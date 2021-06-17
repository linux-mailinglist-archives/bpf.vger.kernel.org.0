Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE73ABE04
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhFQVaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232079AbhFQVaK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpw0jr2etcJQOtwBBETmSUpHlhu94Ou8Nardir8qwr8=;
        b=CMai4sOtFpXBo6gptTIoEADYAbeiSYp3t1qHoeeBXkmdt+U+mQxqupsM8MgAkqixY/+dMq
        dvuyCEXOz0LqhXagVWh/CqcVF/aoDXHuDtZKqsfRastsPD07nuBmW/+HWE0FXh6Z8QRwW9
        QQfcnvP1/LXr6GZjk/lm+oFEMdMfoCc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-LmTqsbu1M6adUUxb4VLfQA-1; Thu, 17 Jun 2021 17:28:00 -0400
X-MC-Unique: LmTqsbu1M6adUUxb4VLfQA-1
Received: by mail-ej1-f71.google.com with SMTP id br12-20020a170906d14cb02904311c0f32adso3026706ejb.9
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpw0jr2etcJQOtwBBETmSUpHlhu94Ou8Nardir8qwr8=;
        b=sv/9MyNywdNk4dnd6v4Dj1JEebKCD9rz3Cj49KauNNgWOqTJsxfbfKA3EWjyUX3n3z
         jF7c8vMxMsRZF/gRlGIjRmDkMYFAyh3GSEy/kC7WKXmlMA74OWA9/tf7pz5dzbaLh5O9
         98Y2jOlJ46vZDWo0JGI5NcH1zY+k+1rlnhprUpgZlXwMfQZiRtbvhqReAqTIPzUyTxdn
         2qfRQpQIQxsglS3HZBq56V/zGjOFlAJLfJIhVkt+LxDRyRk2yaYm8T2jyO3ReLbIiwMD
         MWJD9HbKIEoKcHyKZUuYdp2MoPuoA2dGokB3flsaJ4h2JzktZc4zvYIm80poVEWgUwLD
         zg8w==
X-Gm-Message-State: AOAM530iKfRgPmyX5ylbdl0Ed/iFsaPsOzuGh7sqLZEb6D85JWTtVZhi
        4RrfbDEdP5ENOH0/L1p2v2Hs4/vZk1ep8QDjeq/VHARoER6/xgFgbKkVzJen4GH/+x7rrVZoA/b
        42pn9ksh3DM+4
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr7355896eja.547.1623965279114;
        Thu, 17 Jun 2021 14:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ0vfR8rrkBi2MA3Q9968M4U2OVMwrReOPcnhagocHm36uIqqyWEHWUNmgXDLaWB74kPUh2Q==
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr7355863eja.547.1623965278752;
        Thu, 17 Jun 2021 14:27:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g16sm93259ejh.92.2021.06.17.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:27:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8C8D1180728; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 04/16] ena: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:36 +0200
Message-Id: <20210617212748.32456-5-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
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
2.32.0

