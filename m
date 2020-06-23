Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D7204F1D
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgFWKfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbgFWKfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:35:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE3C061755
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so22812640ljv.5
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAmB6IQ2ihbTF0EoTJg7CQVNnUZviq0ZaHrzfSg2vHg=;
        b=I5dysNAs8kpwwNf91POvTJpw7OQ8rgPhGfekjXMB3vCvu/sKu2GGXxqrU95ms1ogFr
         LCAIwhT3xNHhBRY7tiZe1G6GeD9GNpkEvYv+rVsUuRga3mLfpZqJxjmL2ouq0w38dIPA
         Nc1L7sioKlQNzQ1GFP/rFwCVZJbkiFpGu1TNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAmB6IQ2ihbTF0EoTJg7CQVNnUZviq0ZaHrzfSg2vHg=;
        b=Xd9wo97G8JbcQ+LQuppLwLhG1ScLDDC+e6JGkTRN2YYTcg7sy0uGUBGgId0Nfd3CWH
         TendSRypO1aAWFPMTz5hJgO7Iuvmsi1kjYyr0UcnSl652QAwdXUJX5NUqyDcydH37aTM
         R/bH1K00eOOuRwFPAnGrdk6OuRH/iqCr7QySzBJXKNfx4yysJIJ2q5qeZYBqbr68gDnD
         YrMB20/MhXooEXVeOVWMhjyp0NZC2Qsf+tON/CCOhVaaBmO1DyMoEvt06FG8hOE/Fob3
         XvwIV5rAmj8gtMBEcuizZ5aK1toIEOXl2okBmaMm77FeZFRunYnLZDV4D0Pv3KsQ7Ukw
         yR6g==
X-Gm-Message-State: AOAM531T/UQJV7F+nwHVWZ6tLC24yMUS7p2CvpKwW79qnSJkEKM8TpfO
        kCyTIvAtXndds0kl12F5/Gkue9hM4PmggQ==
X-Google-Smtp-Source: ABdhPJz0CjueuwHwEDiQnXYFD9kW5Qdmud42p8gOx3h8ilmRef+Aq2v5pRRnkVhZVkSou8QpSX3Byw==
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr11637374ljn.286.1592908505228;
        Tue, 23 Jun 2020 03:35:05 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id o5sm1224914lfg.27.2020.06.23.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:35:04 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v2 3/3] bpf, netns: Keep a list of attached bpf_link's
Date:   Tue, 23 Jun 2020 12:34:59 +0200
Message-Id: <20200623103459.697774-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200623103459.697774-1-jakub@cloudflare.com>
References: <20200623103459.697774-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To support multi-prog link-based attachments for new netns attach types, we
need to keep track of more than one bpf_link per attach type. Hence,
convert net->bpf.links into a list, that currently can be either empty or
have just one item.

Instead of reusing bpf_prog_list from bpf-cgroup, we link together
bpf_netns_link's themselves. This makes list management simpler as we don't
have to allocate, initialize, and later release list elements. We can do
this because multi-prog attachment will be available only for bpf_link, and
we don't need to build a list of programs attached directly and indirectly
via links.

No functional changes intended.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/net/netns/bpf.h    |  2 +-
 kernel/bpf/net_namespace.c | 42 +++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/net/netns/bpf.h b/include/net/netns/bpf.h
index a5015bda9979..0ca6a1b87185 100644
--- a/include/net/netns/bpf.h
+++ b/include/net/netns/bpf.h
@@ -15,7 +15,7 @@ struct netns_bpf {
 	/* Array of programs to run compiled from progs or links */
 	struct bpf_prog_array __rcu *run_array[MAX_NETNS_BPF_ATTACH_TYPE];
 	struct bpf_prog *progs[MAX_NETNS_BPF_ATTACH_TYPE];
-	struct bpf_link *links[MAX_NETNS_BPF_ATTACH_TYPE];
+	struct list_head links[MAX_NETNS_BPF_ATTACH_TYPE];
 };
 
 #endif /* __NETNS_BPF_H__ */
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 593523a22168..3e89c7ad42cb 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -19,20 +19,12 @@ struct bpf_netns_link {
 	 * with netns_bpf_mutex held.
 	 */
 	struct net *net;
+	struct list_head node; /* node in list of links attached to net */
 };
 
 /* Protects updates to netns_bpf */
 DEFINE_MUTEX(netns_bpf_mutex);
 
-/* Must be called with netns_bpf_mutex held. */
-static void __net_exit bpf_netns_link_auto_detach(struct bpf_link *link)
-{
-	struct bpf_netns_link *net_link =
-		container_of(link, struct bpf_netns_link, link);
-
-	net_link->net = NULL;
-}
-
 static void bpf_netns_link_release(struct bpf_link *link)
 {
 	struct bpf_netns_link *net_link =
@@ -69,7 +61,7 @@ static void bpf_netns_link_release(struct bpf_link *link)
 		bpf_prog_array_free(old_array);
 	}
 
-	net->bpf.links[type] = NULL;
+	list_del(&net_link->node);
 
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
@@ -233,7 +225,7 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	mutex_lock(&netns_bpf_mutex);
 
 	/* Attaching prog directly is not compatible with links */
-	if (net->bpf.links[type]) {
+	if (!list_empty(&net->bpf.links[type])) {
 		ret = -EEXIST;
 		goto out_unlock;
 	}
@@ -296,7 +288,7 @@ static int __netns_bpf_prog_detach(struct net *net,
 	struct bpf_prog *attached;
 
 	/* Progs attached via links cannot be detached */
-	if (net->bpf.links[type])
+	if (!list_empty(&net->bpf.links[type]))
 		return -EINVAL;
 
 	attached = net->bpf.progs[type];
@@ -327,13 +319,15 @@ int netns_bpf_prog_detach(const union bpf_attr *attr)
 static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 				 enum netns_bpf_attach_type type)
 {
+	struct bpf_netns_link *net_link =
+		container_of(link, struct bpf_netns_link, link);
 	struct bpf_prog_array *old_array, *new_array;
 	int err;
 
 	mutex_lock(&netns_bpf_mutex);
 
 	/* Allow attaching only one prog or link for now */
-	if (net->bpf.links[type]) {
+	if (!list_empty(&net->bpf.links[type])) {
 		err = -E2BIG;
 		goto out_unlock;
 	}
@@ -362,7 +356,7 @@ static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 	rcu_assign_pointer(net->bpf.run_array[type], new_array);
 	bpf_prog_array_free(old_array);
 
-	net->bpf.links[type] = link;
+	list_add_tail(&net_link->node, &net->bpf.links[type]);
 
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
@@ -421,24 +415,34 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	return err;
 }
 
+static int __net_init netns_bpf_pernet_init(struct net *net)
+{
+	int type;
+
+	for (type = 0; type < MAX_NETNS_BPF_ATTACH_TYPE; type++)
+		INIT_LIST_HEAD(&net->bpf.links[type]);
+
+	return 0;
+}
+
 static void __net_exit netns_bpf_pernet_pre_exit(struct net *net)
 {
 	enum netns_bpf_attach_type type;
-	struct bpf_link *link;
+	struct bpf_netns_link *net_link;
 
 	mutex_lock(&netns_bpf_mutex);
 	for (type = 0; type < MAX_NETNS_BPF_ATTACH_TYPE; type++) {
 		netns_bpf_run_array_detach(net, type);
-		link = net->bpf.links[type];
-		if (link)
-			bpf_netns_link_auto_detach(link);
-		else if (net->bpf.progs[type])
+		list_for_each_entry(net_link, &net->bpf.links[type], node)
+			net_link->net = NULL; /* auto-detach link */
+		if (net->bpf.progs[type])
 			bpf_prog_put(net->bpf.progs[type]);
 	}
 	mutex_unlock(&netns_bpf_mutex);
 }
 
 static struct pernet_operations netns_bpf_pernet_ops __net_initdata = {
+	.init = netns_bpf_pernet_init,
 	.pre_exit = netns_bpf_pernet_pre_exit,
 };
 
-- 
2.25.4

