Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF73B33A3
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhFXQQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhFXQQP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624551235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRUA/Y9lIwzUgTw5uRoa39eJ4yIyIch6xpJH66I9Qdc=;
        b=cS7bO3y0smmzslcOcbQjqNTn7G/V0yhkbIgWUNSzlql8EUoWkmRyWNm3VeS6MCE6NTZIDo
        a51RgdNMWYUixd21eTRAswB8GFYnURIckZMm61/FdBwqvMkJwSTOiDW1+mzBKZ6LMPyrS0
        80IM0qpyNzmaLnxis7skY3hV1MbpDU8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-Jg7_ZU_zNV6fH1QQLWIdGw-1; Thu, 24 Jun 2021 12:13:54 -0400
X-MC-Unique: Jg7_ZU_zNV6fH1QQLWIdGw-1
Received: by mail-ej1-f70.google.com with SMTP id g6-20020a1709064e46b02903f57f85ac45so2186459ejw.15
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRUA/Y9lIwzUgTw5uRoa39eJ4yIyIch6xpJH66I9Qdc=;
        b=qfpeoFrVgkFaxwW9UHGH/Zza9g+DccwGkWssbymLz2J9nKrDnnV5wDydOWRuxKME4S
         W2o6FHosR3d4ZONW+sgfyMEFoSr2/eU/4yq4XCI3G6LXKRicfKbfBz+bAXTYzabonObj
         /LG0nKr394bSrU+ppenYsI0JthBxP88XoPbbKaCB0BvydVLf5FnGst0d7GnAn8n0aZjS
         6WLQku/lLjS0haX2uLpaItiPD0fZCoKPwjm9j1WIPLtipsP78glDqrDjjCdiaJVCtltt
         C3EFOZ2osX3NBge9T0kB91i64HhRDdMNqLOSULZ5EX46Dmvxl3o/Gy56FrkY/bKp/5cJ
         Tdkg==
X-Gm-Message-State: AOAM533U9fm5ECRy1GsYihhM+NvZnrVG1nIMgRSjrFN7UIdEwwComzqD
        S4D7ecGkL0HjUoeKarwmRmwQBd2UyTIwrNbKSnP9kyVIyyekw2rmB+TrJMapQ0Tori4loUmlzw8
        VVwcPw3uEsJRH
X-Received: by 2002:a17:907:6224:: with SMTP id ms36mr6015252ejc.423.1624551233263;
        Thu, 24 Jun 2021 09:13:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT+78mtmzK35e8akO5/2A3g2OAeHLhe/rtrcwTbal1bJnAixBqQ+JAWrNGT1lmcQfMaMJFnw==
X-Received: by 2002:a17:907:6224:: with SMTP id ms36mr6015201ejc.423.1624551232778;
        Thu, 24 Jun 2021 09:13:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id aq21sm1572080ejc.83.2021.06.24.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A1C97180740; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
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
Subject: [PATCH bpf-next v5 15/19] qede: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 24 Jun 2021 18:06:05 +0200
Message-Id: <20210624160609.292325-16-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
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

