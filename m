Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB482F35C6
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 17:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392603AbhALQ3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 11:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392201AbhALQ3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 11:29:12 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED6DC061786
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 08:28:32 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id y187so1913222qke.20
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mWcf/+iFwpreBNElvxMjcceqxx7yuNB9Ov/Q1i5x95c=;
        b=GtbUADTogOQ/ogEKQtWG8v5LTG+fN37POyE1dZSnbv0gP+hOo5hgjsZsc85mKhIYX0
         hb7/fOogYbJykyHNMEowmiR1JlKSKPLvU1cr0bjgdL8IB+ZWBZl9BJP+Ob4FRTrMA58G
         07eOIGDFGX9n2vdkjjC2X7MsZ2VXqzVSIQHUI+ETEIC20eIsjWmWTRpZClCAXFlvBcR0
         XGfQ+eNq8qBpnxrcbXBUXg9OArGD0piKiggHQBkDEgASpAswHK8wyoHUWFhO1u5jDOPz
         BPN2cVdRnrWDbBsjHIVXX/AsF0tOQqNkArhkzV9RvOBWN0ehop1O6Ruvq3BMRgncr3YC
         /Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mWcf/+iFwpreBNElvxMjcceqxx7yuNB9Ov/Q1i5x95c=;
        b=O58yu9sUvdQOutU8WPYTDLAcvoWe7+mjeTR5B+spTcC/3OYipUpEmT7GZdwYi+2TkX
         RC2o5/ttQadXIOm+ib3M9ux5nVDJerO7Vh6BhhzqviEd3EaI2L0mYDREHDPaktdw29u7
         AQZtEBnxNG2aeb30KZPck7giSsCoqwVPPI0EzReLwpT1ZvTnQt2W1DCnqGJlj0QCqyNv
         tXhIASFQ0lXOAnVNuKXxhEDUJaLXcSEh6fGeBnilYvW4vWUx1EH/vKGL0EcidLzcHmTG
         oEkVRoxaugdKzygG8u7JDA0KppAaEP1RO98f4lOWPtWCu15fMwsx0QStnZLtGEJafg81
         fYOA==
X-Gm-Message-State: AOAM533x1dlDWTDFQogMARKtcmLz+Lz5wnkz3awpKUoueI028yl3KbiP
        4GOSLHxND5CAcaXQdWZsNYoS83M=
X-Google-Smtp-Source: ABdhPJzNYjN/PhOiSRUE+jMM4Yn5u04yvHhluC6A2cuHl4benPwxniuxname9VeK/WdxPK0tgjeZR+g=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:ad4:4f4a:: with SMTP id eu10mr5576394qvb.17.1610468911514;
 Tue, 12 Jan 2021 08:28:31 -0800 (PST)
Date:   Tue, 12 Jan 2021 08:28:29 -0800
Message-Id: <20210112162829.775079-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf v2] bpf: don't leak memory in bpf getsockopt when optlen
 == 0
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

optlen == 0 indicates that the kernel should ignore BPF buffer
and use the original one from the user. We, however, forget
to free the temporary buffer that we've allocated for BPF.

Reported-by: Martin KaFai Lau <kafai@fb.com>
Fixes: d8fe449a9c51 ("bpf: Don't return EINVAL from {get,set}sockopt when optlen > PAGE_SIZE")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6ec088a96302..96555a8a2c54 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1391,12 +1391,13 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		if (ctx.optlen != 0) {
 			*optlen = ctx.optlen;
 			*kernel_optval = ctx.optval;
+			/* export and don't free sockopt buf */
+			return 0;
 		}
 	}
 
 out:
-	if (ret)
-		sockopt_free_buf(&ctx);
+	sockopt_free_buf(&ctx);
 	return ret;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

