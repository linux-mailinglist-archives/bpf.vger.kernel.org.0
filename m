Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE61A9790F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfHUMRZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 08:17:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44601 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfHUMRY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 08:17:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id v16so1596052lfg.11
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KcSv9I/AsPeVximJhFUVD9sZ1/koeFyLmZnjNgXSj8=;
        b=zLezPN9BDAmeEzUp7RC5RWtnZqxhiZV8LjE8EInGPMk+tkajmarjj8jTD7rEGZA/jf
         IpuLS8eF8vSzsHmC/zjPoPgngruahBPsteHGaUl+azsEHJRipqTtsXFHsr1zLWZRqJ26
         CRSJ5qB9vYUxzqmtz9JmgUw8FMpsz8baBUDbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+KcSv9I/AsPeVximJhFUVD9sZ1/koeFyLmZnjNgXSj8=;
        b=DVdQQwtWA8gVg+wNT5yBlHOjTQnypxaQf+eWgK3kWE+2IEJCEAypIk34K0eIJYPKhb
         AXfgvE4iBl2iwY4O+T+BSLy/GPonL6/wJs4Gin+3DfijcHj1QUnKtSRk1MjVMocHR70n
         0esuXc4A19lL3vAogB21523/Bz8rHNMMpmHqrQA8wcw+J7G/QF2af2l+JgJG9sSO3TN1
         gJkMH8tbQckMTbOnvZFRAKUD13c0MLRGmQCQajR1RChIKGtBuh1815s01DPPgivRKyOE
         TJ8H5dbIPoosAyggWBNAo7eIdzuZmWFlCdxP0RBlxa2eS/9QsvFZQyDJxEhFLDWJFDtL
         /81w==
X-Gm-Message-State: APjAAAXNc09HDVZICWSib0y4iJiV44LowgvnyeiNi+HTDPDr4CtKb43I
        PVLtnl6GQv6lNQFU2wESvN/zHwrAbAPvNA==
X-Google-Smtp-Source: APXvYqzS1ABrw1F1qVHRZ4NJjgUoTwUbuL8XDJ5Kzcjj485s/P1hXeo51xGbJXx1hbo+0WdwMvL1rA==
X-Received: by 2002:a19:f11a:: with SMTP id p26mr18136589lfh.160.1566389841933;
        Wed, 21 Aug 2019 05:17:21 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w13sm3374947lfe.8.2019.08.21.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:17:21 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] flow_dissector: Fix potential use-after-free on BPF_PROG_DETACH
Date:   Wed, 21 Aug 2019 14:17:20 +0200
Message-Id: <20190821121720.22009-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Call to bpf_prog_put(), with help of call_rcu(), queues an RCU-callback to
free the program once a grace period has elapsed. The callback can run
together with new RCU readers that started after the last grace period.
New RCU readers can potentially see the "old" to-be-freed or already-freed
pointer to the program object before the RCU update-side NULLs it.

Reorder the operations so that the RCU update-side resets the protected
pointer before the end of the grace period after which the program will be
freed.

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Reported-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/flow_dissector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 3e6fedb57bc1..2470b4b404e6 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -142,8 +142,8 @@ int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 		mutex_unlock(&flow_dissector_mutex);
 		return -ENOENT;
 	}
-	bpf_prog_put(attached);
 	RCU_INIT_POINTER(net->flow_dissector_prog, NULL);
+	bpf_prog_put(attached);
 	mutex_unlock(&flow_dissector_mutex);
 	return 0;
 }
-- 
2.20.1

