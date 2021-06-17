Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6974F3ABE12
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhFQVaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233106AbhFQVaN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623965284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nO6s/4BqIfWQwa6yGTA6YR9i3EYkNdVjQ6416QGe4OM=;
        b=ZrHGbjWQxb2wDBGtCsc0oox+Ls3J9Mx8lg4/5gUBAyhStSsk0Qq5NlurmE7CUdWT06kLaW
        YDxIc9GVIWqskMXmGNIOWGIv0/MKsfjX8Pzg1Q+HRbJ8abSx6T5dhZ6PGgJm3xKi9Vvi1z
        HDhCGVfvg6ZdNPmahoEMfxeJASNkxu8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-vlIMDKgXOwaO7qku8GhG2g-1; Thu, 17 Jun 2021 17:28:03 -0400
X-MC-Unique: vlIMDKgXOwaO7qku8GhG2g-1
Received: by mail-ed1-f69.google.com with SMTP id j3-20020aa7c3430000b0290393f7aad447so226219edr.18
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nO6s/4BqIfWQwa6yGTA6YR9i3EYkNdVjQ6416QGe4OM=;
        b=n8NZml38CWU5Ifv2lawsFnWeDwXvPd9AZPSJYvkpJbcED21paumvUOLSGd+fAcp2Z9
         8H9ixRjo765r7fY1XK56uOtH2DgOLXbfLF7DZKJseytvv2cywTxC5rafgCYjieCMOTHe
         MmsnyYKXAwxIqLgksq1TMzyyEjamJmtsqGRuL2KGHFWsLLjrmlvo5ydhbjlmcPDSckSB
         Fo47vNjSvOnn3BDhvucbOwFgYow2nffcXCzEWi7G3ArB98PXSxxz1cV6EiR1SGvq6W7j
         DID4/C9ohkaX+oAOT3KyRQ2fz89eZwk9j4qBvYD9bmcPabW0zOyRdQ8PNEEarSFzJAPB
         nx2Q==
X-Gm-Message-State: AOAM532/AjGXwGEeU2X4Saa0MDkBv3q2Hr68+sFeWBo9IGl8uKAev6c2
        XxVotkYuA6U3mC/PpRQPqhUs3Sjpk937erBlGyl05pJuj/gqEHwWZsqRnJ8L9AtFKeKo2Psuibq
        mpN8SBj+X9lT6
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr7480626ejg.88.1623965282187;
        Thu, 17 Jun 2021 14:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMnbPrCh3ymsX9SRGg5ZxHfU1Rt4PKuNVke7r/Sv+gD0iKkUHnyz2chwe6+FBIOwlgHOcrZw==
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr7480611ejg.88.1623965282049;
        Thu, 17 Jun 2021 14:28:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c23sm5072627eds.57.2021.06.17.14.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:27:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C520F180735; Thu, 17 Jun 2021 23:27:54 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 12/16] qede: remove rcu_read_lock() around XDP program invocation
Date:   Thu, 17 Jun 2021 23:27:44 +0200
Message-Id: <20210617212748.32456-13-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617212748.32456-1-toke@redhat.com>
References: <20210617212748.32456-1-toke@redhat.com>
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
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 8e150dd4f899..d806ab925cee 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1089,13 +1089,10 @@ static bool qede_rx_xdp(struct qede_dev *edev,
 	xdp_prepare_buff(&xdp, page_address(bd->data), *data_offset,
 			 *len, false);
 
-	/* Queues always have a full reset currently, so for the time
-	 * being until there's atomic program replace just mark read
-	 * side for map helpers.
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
 	 */
-	rcu_read_lock();
 	act = bpf_prog_run_xdp(prog, &xdp);
-	rcu_read_unlock();
 
 	/* Recalculate, as XDP might have changed the headers */
 	*data_offset = xdp.data - xdp.data_hard_start;
-- 
2.32.0

