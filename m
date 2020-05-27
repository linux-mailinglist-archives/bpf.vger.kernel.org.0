Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAE1E4B72
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgE0RIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgE0RIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 13:08:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF88C08C5C1
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so28992024ejb.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKJeDOq+HqmTFfnS/vZ8EmCIUcvnA2ca6FYbu52upNA=;
        b=naGrXBhWjhX2ex2vl2P12O8p4VmykqhgVirqJjE4EEyvoDryLC9vqcA4CTJI/0B/X6
         HEdQtUZcyrwPiMj2IDdCiuWgwB5uqjZwfsakCnQLaTowYCL41B5iKbrl9igiRoM3/wsd
         8iskYp5ykF+gmIbejeodV3lZ78iojzFcB3W94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKJeDOq+HqmTFfnS/vZ8EmCIUcvnA2ca6FYbu52upNA=;
        b=kmIkxWJMBF/3/cgSs++IutwR1JRqAH/53yietNYj+uDmTpNLLgIkGotsem7f06WhGX
         JQBflctfJ3E4P1r/evEjAwPr4daN1rgZJE5cFSYSJsqJb3pm8ivO+yUXNxvfc2ICMkqc
         19oHP8kdAbioDRCHRnINzIfcbSUz8TXcM0bj1UKDWlnv82b/qtCNnd/KslqJOct7HeO3
         UsKDarq40cTv846tWhJbFnEdtZEcYH4lg4/tbgd1UY75asGNdCD8ooAIwHmjc2+IYfOm
         I4dzNdxTJBFqW/si86iKNkrrHrGvS6YTjlgCs1xuAcOPmWyQvcYeuycSaODEpYUqgJ3/
         BSWg==
X-Gm-Message-State: AOAM533jyImib18pT0CcZlMqN8M9xOSk5M/f+F0v5EAgreX1V/Lf+rcF
        HlDwUDKcM5KOILnLJvPY7hAx7kI1urU=
X-Google-Smtp-Source: ABdhPJwoxnIGPgUv5ELsctlJ4MYFhrzjq84+GSTcQL46+ZXJMIy64lmmrjWPcJP/WsaOv0+L/m+1qA==
X-Received: by 2002:a17:907:364:: with SMTP id rs4mr6732284ejb.311.1590599323269;
        Wed, 27 May 2020 10:08:43 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id ch8sm3169670ejb.53.2020.05.27.10.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:08:42 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 1/8] flow_dissector: Don't grab update-side lock on prog detach from pre_exit
Date:   Wed, 27 May 2020 19:08:33 +0200
Message-Id: <20200527170840.1768178-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200527170840.1768178-1-jakub@cloudflare.com>
References: <20200527170840.1768178-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When there are no references to struct net left, that is check_net(net) is
false, we don't need to synchronize updates to flow_dissector prog with BPF
prog attach/detach callbacks. That allows us to pull locking up from the
shared detach routine and into the bpf prog detach callback.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/flow_dissector.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5dceed467f64..73cc085dc2b7 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -164,22 +164,26 @@ static int flow_dissector_bpf_prog_detach(struct net *net)
 {
 	struct bpf_prog *attached;
 
-	mutex_lock(&flow_dissector_mutex);
+	/* No need for update-side lock when net is going away. */
 	attached = rcu_dereference_protected(net->flow_dissector_prog,
+					     !check_net(net) ||
 					     lockdep_is_held(&flow_dissector_mutex));
-	if (!attached) {
-		mutex_unlock(&flow_dissector_mutex);
+	if (!attached)
 		return -ENOENT;
-	}
 	RCU_INIT_POINTER(net->flow_dissector_prog, NULL);
 	bpf_prog_put(attached);
-	mutex_unlock(&flow_dissector_mutex);
 	return 0;
 }
 
 int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 {
-	return flow_dissector_bpf_prog_detach(current->nsproxy->net_ns);
+	int ret;
+
+	mutex_lock(&flow_dissector_mutex);
+	ret = flow_dissector_bpf_prog_detach(current->nsproxy->net_ns);
+	mutex_unlock(&flow_dissector_mutex);
+
+	return ret;
 }
 
 static void __net_exit flow_dissector_pernet_pre_exit(struct net *net)
-- 
2.25.4

