Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245106E6FAD
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDRWxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRWxs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:48 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB92D62
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:47 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a69a078eefso11175475ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858427; x=1684450427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6n8HUKJS4l45R+zU2zt1qNsJUjLjbYoUfgWsoXx1DY=;
        b=ncxA9ElCCEkIqcg6o1TtUMeMTEaXejApjUfQPjzbYAlmY4Y/kJrfdpl5oxaBidcI2i
         xn1iuJDMhgOsPIqU+GP9HwcWTxZ+hZoU4UONGdb21HqrDkx19LPOltdM67OTc98pzgev
         03yS72TdxRoI7PUHEZSkl1n5NTEbk0O2rPXYjLATeV1hxYY63wjDSYSapq0s6FWsLrzc
         ZL9v6cUWjdRJ8IDkmtmSg5ZVQ37J6M62Yd1c7ZWcKxOTy8s9QnxLaIowYSnPopGj2uZ5
         ntnPcxct+fw62gEvJW7YA2GzfJDeAnXuI4+zAagPat/u97jOimCeHfgBkr3RSW5DWAgO
         5Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858427; x=1684450427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6n8HUKJS4l45R+zU2zt1qNsJUjLjbYoUfgWsoXx1DY=;
        b=U9jaGqp5yosmZimhJS4S6+KuhEyuCYlXnx+2S2ZLUP7sgRU4QzGgYwiEG31alMUHhG
         /tk+gA3PExHHUP1dWtGn6Z3N/nFrtzuB05+pegJYoiCZjK8dTkfkv/gFvfa32zU7sXu+
         KetQeSLdQldgym+a7lVvQKwFuthsIJCgS2vZJ6JigDfEMFWXt7hNXMXJOzRRGlIjVhCv
         SNDcj4/NmkUICxtgNyOr37UY0EnQlPl8nZpc6gC4tNy1dPLt90nx56LbVDXv1OwWMVAE
         vD6rBwhj8sSkVNRKgsXuiNdJpWGfseDsSRsfnLPJl4J7NiUFZ+VLUlhTvBxqUYigSzQ0
         JicA==
X-Gm-Message-State: AAQBX9d3nA936Xoj6yMlWcC5F6E79NepG/6wVbl3cQjdL1AXYIsp4VAn
        zQ+maYTOhQ7q18GL3KqA89KAWtIbszsjWiOxqNjui3pRF7I6eJDJlaWTRbz3HAKOTXihIb2+aWF
        552u+hQjrfeCU4elrbED6GfddilaEm6HXB+ng2e4HRfB1cYMeNA==
X-Google-Smtp-Source: AKy350a8oO24AEnseSUmxh1/7s1gvf9F5BoyRb9H92io83X7LaOf2dUqFJ7YcwU9BCebTyYh/TLUfOo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d4ce:b0:1a6:b0d3:57f4 with SMTP id
 o14-20020a170902d4ce00b001a6b0d357f4mr1442243plg.1.1681858426800; Tue, 18 Apr
 2023 15:53:46 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:38 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-2-sdf@google.com>
Subject: [PATCH bpf-next 1/6] bpf: Don't EFAULT for getsockopt with optval=NULL
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some socket options do getsockopt with optval=NULL to estimate
the size of the final buffer (which is returned via optlen).
This breaks BPF getsockopt assumptions about permitted
optval buffer size. Let's enforce these assumptions only
when non-NULL optval is provided.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/bpf/ZD7Js4fj5YyI2oLd@google.com/T/#mb68daf700f87a9244a15d01d00c3f0e5b08f49f7
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 53edb8ad2471..a06e118a9be5 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1921,14 +1921,17 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (ret < 0)
 		goto out;
 
-	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
+	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
 	if (ctx.optlen != 0) {
-		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
-		    put_user(ctx.optlen, optlen)) {
+		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (put_user(ctx.optlen, optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
-- 
2.40.0.634.g4ca3ef3211-goog

