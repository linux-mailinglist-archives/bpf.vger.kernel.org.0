Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65363ABE3E
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFQVjh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFQVjf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+K4Rzii9x9DcPIEElTMZYJsTVD8g+UmhuIcex1BLcU=;
        b=iy0RQ42oSxyAWuNLaDe3zANnlZ1ty8ssmtHdf/4yPwKpfDqIeZpgtrri2V8A+GL93FKRN7
        yCYhK3a3914EGO1eT/4X3M0ipNyrKnifNd0kBd7r2u2d6wYOP3HzMX/ahxRay7uOROEU/3
        VSTCaf+HRTIY1FoxY6ZDrmKao22g714=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-IvEl53gRPZS9U5eLGI9WXw-1; Thu, 17 Jun 2021 17:37:25 -0400
X-MC-Unique: IvEl53gRPZS9U5eLGI9WXw-1
Received: by mail-ed1-f70.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so2390511edt.23
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+K4Rzii9x9DcPIEElTMZYJsTVD8g+UmhuIcex1BLcU=;
        b=oH7VLFEqh6t7AzQFAn0jQB/lFAUhbeG+qqcMnTwTGDl7nZ+qg4T+3kug9H6qEWYpZO
         NJQqjjZCAsicZlJbE1DJ/fTtpDRggp/FWkUuHfCA2uMeP9zaK7W3tT3wOBPUoQ6MOaZ7
         JzrzQ1niyez3TwSU7hpR0atg4OQ1KiiD/KB/QIFowt8M4Yql1zKMbUwGr4lPAGxla2TB
         5REUX7biSFcUnvhkzHvXLHrMcyQzFlJqDLOebydu0NYF1ix3WZxcDjNKInpXg/iBrD9I
         JJjcTmGDLoc+VNTxbQdZnah6vSyUxmN2kqH9SQtDjGnhPlSeqMVok95uF1ZUxd++xVZ9
         pyfw==
X-Gm-Message-State: AOAM5303p1yjro78zLU7TNcP6tb0MqNvqh+8paC5dQZcIZaIV6jUnDHi
        TM1KyI93APs6rBY6n6K6JrdUVZ0fuXSQU3jWQXnB1d8ie9XdNE+s/JjH+VKsTHUnGXTvgsU4mn0
        Y9Ed6vcVD+CH5
X-Received: by 2002:a17:907:7b9d:: with SMTP id ne29mr7692190ejc.167.1623965844476;
        Thu, 17 Jun 2021 14:37:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT3fEGEihEGarB3fpS2Al0EXij4hKluNygNZjVN8leQ1wAJxPYopgkOlxKigP3A1jBe4lPvA==
X-Received: by 2002:a17:907:7b9d:: with SMTP id ne29mr7692177ejc.167.1623965844289;
        Thu, 17 Jun 2021 14:37:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q9sm5018510edw.51.2021.06.17.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:37:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A79C18072F; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 06/16] thunderx: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:38 +0200
Message-Id: <20210617212748.32456-7-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
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
2.32.0

