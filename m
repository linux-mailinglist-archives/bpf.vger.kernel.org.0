Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7F1E4B73
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgE0RIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbgE0RIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:08:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6081AC08C5C2
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nr22so12606009ejb.6
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aNYzFZ3HQztQJxIHCfXbNBHtKfIZ7aoRnKs0QLw/oE=;
        b=UbtuMdTdaVEj1t1nuIVBixpqHZcjOrac9qGZFczd4DtMvVa+hiueDk/NSOW5GT8KRZ
         YqwyEP2w42/7XndFUvr6Cn4+/LAKTrUD/GMxTlcMgoxZ4I4VQCtBAjZrJzl8VCUmISrP
         rhm+Cu02/+iztj1R2eXop3lJwrDBagqKqUKpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aNYzFZ3HQztQJxIHCfXbNBHtKfIZ7aoRnKs0QLw/oE=;
        b=Esk5ah+O4aIH5Ss8fWBwiHLgTlRLgaMqyRmExBCmbzjvE4XrlVTDEh04I+9ItVV6yf
         Zd0mGlAiu/+EqBOzaAk4ZZkHl3oNv6JrBgFVVSW9RGL7ADZjYrLSAfEa3tjjZ4WF8Up3
         yuaaDCIJUwj8FcKqs2uzDyyupJ3sQN9w/3L7sl+b8Tmx5GkMx7KgEeToIZxoSyhMebdN
         GELHzY7UnH1p2lmX2z27fnwcMDGE7bc0NUY4qjWMz4iE7YcXLovAW6fyut4DsZbvA+TQ
         fgGjM96xkiJm28V4QnK1uDuzcmLd9066Mvgl66DeNLGi8GEHxADV9L+EVByeWfw8hN8w
         MFdQ==
X-Gm-Message-State: AOAM53302AN2crN3RHTiC+Crh+SS4A/M8O6PvoeaV+wi0N1vMhtJahFk
        Oz2UsmZz6o1v2QEhjjsd1AmqnCUN/3s=
X-Google-Smtp-Source: ABdhPJxM1aq2ausULE8+zhL4DTIGQiqUBoIXA++dwmTCA8sckm6c+YMf2xtAt2Xwf/NVatKH5l7TYg==
X-Received: by 2002:a17:906:eda5:: with SMTP id sa5mr6871910ejb.289.1590599324729;
        Wed, 27 May 2020 10:08:44 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id e9sm2716447edl.25.2020.05.27.10.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:08:44 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 2/8] flow_dissector: Pull locking up from prog attach callback
Date:   Wed, 27 May 2020 19:08:34 +0200
Message-Id: <20200527170840.1768178-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527170840.1768178-1-jakub@cloudflare.com>
References: <20200527170840.1768178-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split out the part of attach callback that happens with attach/detach lock
acquired. This structures the prog attach callback similar to prog detach,
and opens up doors for moving the locking out of flow_dissector and into
generic callbacks for attaching/detaching progs to netns in subsequent
patches.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/flow_dissector.c | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 73cc085dc2b7..4f73f6c51602 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -109,15 +109,10 @@ int skb_flow_dissector_prog_query(const union bpf_attr *attr,
 	return 0;
 }
 
-int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
-				       struct bpf_prog *prog)
+static int flow_dissector_bpf_prog_attach(struct net *net,
+					  struct bpf_prog *prog)
 {
 	struct bpf_prog *attached;
-	struct net *net;
-	int ret = 0;
-
-	net = current->nsproxy->net_ns;
-	mutex_lock(&flow_dissector_mutex);
 
 	if (net == &init_net) {
 		/* BPF flow dissector in the root namespace overrides
@@ -130,33 +125,38 @@ int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 		for_each_net(ns) {
 			if (ns == &init_net)
 				continue;
-			if (rcu_access_pointer(ns->flow_dissector_prog)) {
-				ret = -EEXIST;
-				goto out;
-			}
+			if (rcu_access_pointer(ns->flow_dissector_prog))
+				return -EEXIST;
 		}
 	} else {
 		/* Make sure root flow dissector is not attached
 		 * when attaching to the non-root namespace.
 		 */
-		if (rcu_access_pointer(init_net.flow_dissector_prog)) {
-			ret = -EEXIST;
-			goto out;
-		}
+		if (rcu_access_pointer(init_net.flow_dissector_prog))
+			return -EEXIST;
 	}
 
 	attached = rcu_dereference_protected(net->flow_dissector_prog,
 					     lockdep_is_held(&flow_dissector_mutex));
-	if (attached == prog) {
+	if (attached == prog)
 		/* The same program cannot be attached twice */
-		ret = -EINVAL;
-		goto out;
-	}
+		return -EINVAL;
+
 	rcu_assign_pointer(net->flow_dissector_prog, prog);
 	if (attached)
 		bpf_prog_put(attached);
-out:
+	return 0;
+}
+
+int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
+				       struct bpf_prog *prog)
+{
+	int ret;
+
+	mutex_lock(&flow_dissector_mutex);
+	ret = flow_dissector_bpf_prog_attach(current->nsproxy->net_ns, prog);
 	mutex_unlock(&flow_dissector_mutex);
+
 	return ret;
 }
 
-- 
2.25.4

