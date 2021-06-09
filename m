Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA63F3A1154
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhFIKkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 06:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238982AbhFIKkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 06:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbz4hNWvQ8PWHu2W2MZOy7/gDDHCdFCTVBAhydE+f+U=;
        b=Uk6MP8ZY5BDZ1yGBZiJeNVXT0o4xwHYpcT/j2Kdow9T8w1/kBPw3tyk2NvXFI++8JhZLmH
        2BCoV/AcXm/CC6kv2pFXXt5lYAkmHGzAVeDR0byF9kCI1TxJKWfr3lVGBt17Vk2lce+aU5
        v9h8MwHWb00TnwNPDA9VNRCJZ3pfe6A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-nNnSk7I5PH2MXGya4D08Jw-1; Wed, 09 Jun 2021 06:38:45 -0400
X-MC-Unique: nNnSk7I5PH2MXGya4D08Jw-1
Received: by mail-ed1-f70.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so4436938edb.16
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbz4hNWvQ8PWHu2W2MZOy7/gDDHCdFCTVBAhydE+f+U=;
        b=egj1pAADqSh00WdR+XBc2Gi6FF1N/M8SVNZKEIsUeBj222s9a0/n7BTa2+kV2I6tNB
         18XhfiPyOl/QoIWlcieMZtSNtcqEa1Pcau6aQUDg2Ui6y9pdK8m+xko04Xrbqcp5h+ml
         97b0sPwg8Y4opxeI8YfdCeaOE4qOtbIUQlisSbVR+Z4spK525AenXzFCATEn5moDkOB8
         qYSEzirI23KigoOu6ZxLv00mbIxqVEuv3FPrLujbRSqQOz/M9xY8fcVd208DBEa1yb8R
         umb0Deu7ES6TPg0hEAMXrIJmc8zvUNjD4CWcGSIBtQRQ1K/NWalAhjnZ8H+HXWd5/E+Q
         7wuw==
X-Gm-Message-State: AOAM531s3GhOUf8WvqGAUtxhFc9Bok/giDsWz7NQebxSihy2uQGP8jGN
        x0HZ1pumBwgXqgEUbur8tncWYenmAlx0SgKMCY8gJeZ34I9OQt3og29qWyg055XNfCrAc/poOjq
        GcREJyfdsd/Iq
X-Received: by 2002:a17:906:869a:: with SMTP id g26mr27319302ejx.94.1623235124591;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm+3mBcadPMLcwFavHgtOiY5Hjn0DBjRErakIm0gzowEegpnSOcGNewwLjLGNQf5IFEnMNOw==
X-Received: by 2002:a17:906:869a:: with SMTP id g26mr27319296ejx.94.1623235124461;
        Wed, 09 Jun 2021 03:38:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id dh18sm966979edb.92.2021.06.09.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:38:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D4A32180731; Wed,  9 Jun 2021 12:33:30 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com
Subject: [PATCH bpf-next 13/17] qede: remove rcu_read_lock() around XDP program invocation
Date:   Wed,  9 Jun 2021 12:33:22 +0200
Message-Id: <20210609103326.278782-14-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609103326.278782-1-toke@redhat.com>
References: <20210609103326.278782-1-toke@redhat.com>
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
2.31.1

