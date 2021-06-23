Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A63B1871
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFWLKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230180AbhFWLJy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/RD8INVqrZhxhRYQu3p0iItEELqlKBFxEmUhyTn65o=;
        b=DFYu4DMGN3RwHXbmP+9cbPQYkVulaUttcBP5F6xoMiL3WYv7xAUugigQMpBQKAy8KX2hEC
        llUb8OpUfp507cq1L+O4LMaYhS8VHNHtDc/Fva2hAZUrdRx8rdJj9s5Kxtap1PR6ozFZzV
        aDDmugyzuvxZfLWpYcWCjO7Vbj2b89A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-2SNfBwGuM8-bAruu28jlMg-1; Wed, 23 Jun 2021 07:07:35 -0400
X-MC-Unique: 2SNfBwGuM8-bAruu28jlMg-1
Received: by mail-ej1-f69.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso839514ejo.13
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/RD8INVqrZhxhRYQu3p0iItEELqlKBFxEmUhyTn65o=;
        b=mv2Pya3FXQXQCy+sLuuDcmpM4xMcYnd3Tp+V2Bd8A77u/EldCei5HWv5LlbJIf0hsk
         a7jNANNVRnvVfI8pp/FrUzI4az+nEbuJDGL826fO2lpdwNUwvAinLcoIj8zOqBQe3Rv1
         RZCpEQqWDhlP4pXUb307EWF2UUm8RLAeXNW92YXlCloRoWAaLhYnGJNComJSxYE63sUv
         gQbTg0myzVBo77dx4mKTZsZ1BEG0srcM2i5F9s7+dZ1/zhLgwP38PkavmMUWAMn64qn3
         MnuCyy8IipPqx4tlDWAB/l01jgH5nIUS5zNGrTy5ZExnkRXxobSPOBUg3RP8FSES0rW2
         x6hQ==
X-Gm-Message-State: AOAM532dfjipiMefBgQWxIKe0zvF11KjmIKiJSwjwzD0qVsPE7/uPvDx
        X/AH/UPZwsvF9QgknF5ILQ6BhX7+HD5SvwNUTkeCodX2Q+epwyDI2sCa4Z3enB/kOHwzlPrL7h0
        9cD0bUEj51Jk6
X-Received: by 2002:a05:6402:18f6:: with SMTP id x54mr11865257edy.53.1624446454210;
        Wed, 23 Jun 2021 04:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkLnLptVgUW3clOL3nBx1FYnj3knCIVTef6R4LuM+oJs85AS2SKwdWmRQkxek9cThzk7dCeg==
X-Received: by 2002:a05:6402:18f6:: with SMTP id x54mr11865234edy.53.1624446454079;
        Wed, 23 Jun 2021 04:07:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z20sm7246260ejd.18.2021.06.23.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:07:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1DB33180736; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v4 06/19] sched: remove unneeded rcu_read_lock() around BPF program invocation
Date:   Wed, 23 Jun 2021 13:07:14 +0200
Message-Id: <20210623110727.221922-7-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
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

