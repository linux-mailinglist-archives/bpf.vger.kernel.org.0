Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9923B337C
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFXQIp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231157AbhFXQIl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/RD8INVqrZhxhRYQu3p0iItEELqlKBFxEmUhyTn65o=;
        b=dJiOvCnF9+tbGOGQ30GfipsO1wzHsLtNI3s6L2vSNe8bF2kG6ze7dvjLRghXSMGQbjEzZI
        +bbbG5aj74DBUY0N26Tx8CJ5KKr8e5gsbu5fx4RttZ8a9Rov2k56Vart2Er9Tk2O5HXZUB
        HUzomUBrGksxVah5Le1dWoq0IPt3+yk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-tsb-r6tHPdeeWnwL7E1Iiw-1; Thu, 24 Jun 2021 12:06:20 -0400
X-MC-Unique: tsb-r6tHPdeeWnwL7E1Iiw-1
Received: by mail-ej1-f72.google.com with SMTP id o12-20020a17090611ccb02904876d1b5532so2188029eja.11
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/RD8INVqrZhxhRYQu3p0iItEELqlKBFxEmUhyTn65o=;
        b=V7p/IlsrMLRSh+RIrCWVH7iFIQxfRCCxcdSHRmLjHwx9l9lRxyR/oJgmrCiTydOzQ1
         C4tybdCElibwICtkN7Ky6m6YA9VvYeI/gTo+MAOL4iEmrZgdqj9mzpF37++ZiQCjR3Hu
         l0FyeayETiiZx+3pi7KTf5BZew+hurnSk8UJqdJBmI58j1wJy4xdTgBqw3cQfnJGCBIZ
         HqGXZXyTggvmmFeTtqnByFkWId4VxZigvuFgUA7DGFjiNG8aRV5zaqybqBgM+VvEmUS+
         J+kFf4KXle6ZfPF1Esv3AJMO2E3GOZoofit20RD2eqQbn3JRQiCn/xnfqf/LHE1PwXvZ
         AMew==
X-Gm-Message-State: AOAM530j4jPGmQXS8qPq5bWVwYPlWZEn1JWq89AEr5ovztcoc+9cne/O
        UTWf9ArUbfOithq9xExovH4tuJUmhoKdqOrECRukRifyyazN1hNVHzSRAWXEi3DqgArB+Rtpn96
        jOs9gM3Wi53JP
X-Received: by 2002:a05:6402:1772:: with SMTP id da18mr8150705edb.28.1624550779496;
        Thu, 24 Jun 2021 09:06:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrSaG+tP51X33gJ8kk/YPPDA/aApXSH8Z4MmxGnq2m1V2HpmdBnG2zEKLird12e9BTsl8H4g==
X-Received: by 2002:a05:6402:1772:: with SMTP id da18mr8150691edb.28.1624550779371;
        Thu, 24 Jun 2021 09:06:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cb14sm2231763edb.68.2021.06.24.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4EDF3180737; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v5 06/19] sched: remove unneeded rcu_read_lock() around BPF program invocation
Date:   Thu, 24 Jun 2021 18:05:56 +0200
Message-Id: <20210624160609.292325-7-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The rcu_read_lock() call in cls_bpf and act_bpf are redundant: on the TX
side, there's already a call to rcu_read_lock_bh() in __dev_queue_xmit(),
and on RX there's a covering rcu_read_lock() in
netif_receive_skb{,_list}_internal().

With the previous patches we also amended the lockdep checks in the map
code to not require any particular RCU flavour, so we can just get rid of
the rcu_read_lock()s.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/act_bpf.c | 2 --
 net/sched/cls_bpf.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index e48e980c3b93..e409a0005717 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -43,7 +43,6 @@ static int tcf_bpf_act(struct sk_buff *skb, const struct tc_action *act,
 	tcf_lastuse_update(&prog->tcf_tm);
 	bstats_cpu_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
 
-	rcu_read_lock();
 	filter = rcu_dereference(prog->filter);
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
@@ -56,7 +55,6 @@ static int tcf_bpf_act(struct sk_buff *skb, const struct tc_action *act,
 	}
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
-	rcu_read_unlock();
 
 	/* A BPF program may overwrite the default action opcode.
 	 * Similarly as in cls_bpf, if filter_res == -1 we use the
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 6e3e63db0e01..fa739efa59f4 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -85,8 +85,6 @@ static int cls_bpf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 	struct cls_bpf_prog *prog;
 	int ret = -1;
 
-	/* Needed here for accessing maps. */
-	rcu_read_lock();
 	list_for_each_entry_rcu(prog, &head->plist, link) {
 		int filter_res;
 
@@ -131,7 +129,6 @@ static int cls_bpf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 
 		break;
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.32.0

