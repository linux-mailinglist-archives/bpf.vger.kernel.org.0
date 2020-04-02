Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1221D19C185
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgDBMz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 08:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41078 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbgDBMz2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 08:55:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so4062805wrc.8
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvQU/wMoeI9IwhYE8khExbOGB+mgQpWwEzF/G9fu0Lk=;
        b=KwdghZ0nyQVmoTiH8kbtQxiolx13vc2xqeV91eWm8aV3b9FELpMKkvos7u7TKORUX3
         OhpIvj9gk1oGDk0T0l1Xo+Eya0Mi2iCIy90p+VMLNng8Y4b4QJEiIKvagNzDZXup0uHz
         dggXepoctVsUmMSSTm+eQpYWRErvE8YwIVr28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvQU/wMoeI9IwhYE8khExbOGB+mgQpWwEzF/G9fu0Lk=;
        b=EIx9wO96qRsseRIxo72yz2Z+F9H3zgpDS8iEX3IDFuAlAf7b+l4ClCp8Lb0+86ms8c
         judggd1HX6a8eLfioEoghuuedz1jfLiCCgdKtUbmo7Vy6vB58GmHftxkXU3qvgMqgna8
         CK+hBdt0w3UfHVeshBj4mz2yWAoZ65jy+BLQ8ZDTUK+hJlL0jeUBsQmnbZn4D/2DWYmD
         DuQA0Pl4zoYVl7cIc1CuxRGBUbY6ZZlmHWrV/wLghIBTO2oWBYyR18k3nrM55sUunOQZ
         5bAaB9OTZCIwyHGno6sI5scyA4l/paKr4KaEiUC96OIzg4io3FHPOBusV9NsWGQTwxX9
         +wUg==
X-Gm-Message-State: AGi0PubgNdECWL4L2yciOmQIdmzCZbSyeEsmKcGxPCYhWm8naaXw31b2
        gtqY4HY7xS3bpbzaO4JKWt/pveCc7sG+Dg==
X-Google-Smtp-Source: APiQypLdbGkkqmf7rYFMk7tvmgK/1MixUlCsrxRpbnmSxgXYbWZECpghHfw0uDW9ymE27rHOvlBBbw==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr3643042wrc.116.1585832126595;
        Thu, 02 Apr 2020 05:55:26 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id u17sm8056942wra.63.2020.04.02.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:55:26 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH bpf] net, sk_msg: Don't use RCU_INIT_POINTER on sk_user_data
Date:   Thu,  2 Apr 2020 14:55:24 +0200
Message-Id: <20200402125524.851439-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sparse reports an error due to use of RCU_INIT_POINTER helper to assign to
sk_user_data pointer, which is not tagged with __rcu:

net/core/sock.c:1875:25: error: incompatible types in comparison expression (different address spaces):
net/core/sock.c:1875:25:    void [noderef] <asn:4> *
net/core/sock.c:1875:25:    void *

... and rightfully so. sk_user_data is not always treated as a pointer to
an RCU-protected data. When it is used to point at an RCU-protected object,
we access it with __sk_user_data to inform sparse about it.

In this case, when the child socket does not inherit sk_user_data from the
parent, there is no reason to treat it as an RCU-protected pointer.

Use a regular assignment to clear the pointer value.

Fixes: f1ff5ce2cd5e ("net, sk_msg: Clear sk_user_data pointer on clone if tagged")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index da32d9b6d09f..0510826bf860 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1872,7 +1872,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		 * as not suitable for copying when cloning.
 		 */
 		if (sk_user_data_is_nocopy(newsk))
-			RCU_INIT_POINTER(newsk->sk_user_data, NULL);
+			newsk->sk_user_data = NULL;
 
 		newsk->sk_err	   = 0;
 		newsk->sk_err_soft = 0;
-- 
2.25.1

