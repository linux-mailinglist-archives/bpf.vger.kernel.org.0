Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1A3B6B20
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhF1XDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 19:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235942AbhF1XDg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Jun 2021 19:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624921269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wET16Z+BojG4tjaqWO4XLxsxQNkC9SqpExUXVqFNB/Y=;
        b=Um4/V7d07wIP9/cvoE1GB5eooJw35vgVyjhApnCquN05LAvx4Mqtbx+FmFvAc/kNee9Wur
        owp/sYILmHd2lAg6DxeQoWEH7cJK9B+IwwYnffN0V1qDNvHRm4urLQ8CFD7eCn6TyjINc+
        yxnds9gjhQt/kcuK6P4KSleryU7Hj/8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-cOfyTmCpNFOhzVwNCcXAiw-1; Mon, 28 Jun 2021 19:01:08 -0400
X-MC-Unique: cOfyTmCpNFOhzVwNCcXAiw-1
Received: by mail-ej1-f70.google.com with SMTP id w22-20020a17090652d6b029048a3391d9f6so4962359ejn.12
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 16:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wET16Z+BojG4tjaqWO4XLxsxQNkC9SqpExUXVqFNB/Y=;
        b=Uw3R45qqp3zOnixGhUZ+oh/TuhhvTn2Gen6FdA4vW72SpowHMz/6onXVOEwggoQcwd
         OtupaeJKSIaJDqst8PFTZ/mLaCbM2H0P8DsqE7wX9l6wNNCvIB5TU+DzHnxEiMHfXrAS
         9MIm5XskPqN9RTx2iy8NQe9p+Gql5IG4wWqAzWvqmGZn9GO1tbMsCtUSThVz+LMSbkUe
         QWpNwDi8wBYDkj95WIjxEQMkw5BNZpChZB21b6eVYaIRnK/tcuiPl1dc+mDpLfC8JJEo
         ETg3Wa8VO68JY1UE9vmDLzIv1Fe+6ONztnbQdL/DfIF1dso0dFijsq8J+fFWBtVcpJp6
         wuiQ==
X-Gm-Message-State: AOAM530yFvPVTSRotlwPhWoW0F7mezfyFxMk5RSXv+eR+12BBSfbxZFj
        aPfxaS7uw4F0US0T0C2l+37nmEW76Jp7wcojRpaEydPjFFxexkpK7D3ehOUjB3h98icsr6eWE2Z
        dgybfYXCxt2fh
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr18788264edb.118.1624921266882;
        Mon, 28 Jun 2021 16:01:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOkhovZmeE6X4ovlHzS0eNaA0YXEDY/lSgliR+5z8ViDbIlcWecWw/i/RKdJoqWe8GOiDYuw==
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr18788244edb.118.1624921266707;
        Mon, 28 Jun 2021 16:01:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z28sm7165024ejl.69.2021.06.28.16.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 16:01:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 280AE18071E; Tue, 29 Jun 2021 01:01:03 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf/devmap: convert remaining READ_ONCE() to rcu_dereference()
Date:   Tue, 29 Jun 2021 01:00:51 +0200
Message-Id: <20210628230051.556099-1-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There were a couple of READ_ONCE()-invocations left-over by the devmap RCU
conversion. Convert these to rcu_dereference() as well to avoid complaints
from sparse.

Fixes: 782347b6bcad ("xdp: Add proper __rcu annotations to redirect map entries")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2f6bd75cd682..7a0c008f751b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -558,7 +558,7 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
-			dst = READ_ONCE(dtab->netdev_map[i]);
+			dst = rcu_dereference(dtab->netdev_map[i]);
 			if (!is_valid_dst(dst, xdp, exclude_ifindex))
 				continue;
 
@@ -654,7 +654,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
-			dst = READ_ONCE(dtab->netdev_map[i]);
+			dst = rcu_dereference(dtab->netdev_map[i]);
 			if (!dst || dst->dev->ifindex == exclude_ifindex)
 				continue;
 
-- 
2.32.0

