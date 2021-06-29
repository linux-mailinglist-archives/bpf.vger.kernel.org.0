Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B783B702E
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhF2Jlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 05:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232849AbhF2Jls (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 05:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624959561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZT++255iqRcOAkWgZdalc/u12HxSGhrAL9pUT0ppFYw=;
        b=QHXiKCDR6iCosg58T3POS4JhFcM0sQjBamR/o1WS3ayrZ/bCtR14nglVz7wnm3VWj4qE8z
        BmCMJ7zR79Ww78H7pcn7/vGapr+WYtSEY8Rl8vj3VJA96Kb/kPvTobEAaO+xNJ/KkoFlR8
        1LMrQo/HJY0pln3PUUDnLIhv/bnuCpw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-cN9Y_OYyM9eMSswNE-9JVg-1; Tue, 29 Jun 2021 05:39:19 -0400
X-MC-Unique: cN9Y_OYyM9eMSswNE-9JVg-1
Received: by mail-ed1-f70.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so3520747edu.17
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 02:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT++255iqRcOAkWgZdalc/u12HxSGhrAL9pUT0ppFYw=;
        b=afUuNmWbONkD9s3ZoaOkkklXSwR1oa4MxRDM/uX9kqK0TffjVu23vFNmj2UfNEleyL
         l8UsmLaPoRE70wNbCdoncIGH5uJK3xzExTh2FckfLxrlkg9smJBKhKQwLLFKISgTc6F2
         ku49rrnsPnVTMZuYTgkjie4wO8/dukvP1aBgStH07/SgvK2znQOeWD8z2XfBxSD2FKBv
         3R3/jneHEmgc7rYV6+Z3DfFlDHUYUBJ/2DDK4MGI2YpYoy5OWEllDKLZ3w9c2Y1UYpoz
         QIakH0ABmf6PVBaf6sPKwGwgd7TsGhsuy5hEQS6CX8Lboj2XWCi57kZBniamwrrdJm3/
         /X5Q==
X-Gm-Message-State: AOAM5339jt66sfSKecUMvhAN2BeoRNP423ZwzwDVTn/Wme5Ou87b7JpW
        tz26O4AvN4soSj45D6SdPxSHAxzvK2hxiFYCYUSLSnKkUUy7kcD4wmEO/mFbvhMQvOlgRPXwRpA
        64/T0Z3d8tuXr
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr28736681ejc.303.1624959558312;
        Tue, 29 Jun 2021 02:39:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmjvf2EJK2EsiOzDEDrxIawgGQC58TKlX74opPDvUg3ZH5HSm40WXKC0RkKw7ZuHM1IJR91Q==
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr28736647ejc.303.1624959557849;
        Tue, 29 Jun 2021 02:39:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bf25sm10882583edb.56.2021.06.29.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:39:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5911018071E; Tue, 29 Jun 2021 11:39:16 +0200 (CEST)
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
Subject: [PATCH bpf-next v2] bpf/devmap: convert remaining READ_ONCE() to rcu_dereference_check()
Date:   Tue, 29 Jun 2021 11:39:07 +0200
Message-Id: <20210629093907.573598-1-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There were a couple of READ_ONCE()-invocations left-over by the devmap RCU
conversion. Convert these to rcu_dereference_check() as well to avoid
complaints from sparse.

v2:
 - Use rcu_dereference_check()

Fixes: 782347b6bcad ("xdp: Add proper __rcu annotations to redirect map entries")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2f6bd75cd682..e4ebe70cf201 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -558,7 +558,8 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, struct net_device *dev_rx,
 
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
-			dst = READ_ONCE(dtab->netdev_map[i]);
+			dst = rcu_dereference_check(dtab->netdev_map[i],
+						    rcu_read_lock_bh_held());
 			if (!is_valid_dst(dst, xdp, exclude_ifindex))
 				continue;
 
@@ -654,7 +655,8 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 
 	if (map->map_type == BPF_MAP_TYPE_DEVMAP) {
 		for (i = 0; i < map->max_entries; i++) {
-			dst = READ_ONCE(dtab->netdev_map[i]);
+			dst = rcu_dereference_check(dtab->netdev_map[i],
+						    rcu_read_lock_bh_held());
 			if (!dst || dst->dev->ifindex == exclude_ifindex)
 				continue;
 
-- 
2.32.0

