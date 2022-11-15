Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990762908B
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKODKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 22:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiKODKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 22:10:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B92263D
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:10:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o5-20020a17090a744500b002184049217aso1554186pjk.9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUlSKv9E0vl3kFdY3gqPlGDz72/1PsMjxppIL0hF14E=;
        b=cFbBY/TeQheP5lKm/k4spJ+X3nq6JMsDt65hczh4AzY7JX+VkF0yDHR8S5ME6L6ed/
         +y/OL2bZM694z3ftChmBMEpEshwF8DRbp+uO0+yEg3V/EAMm5hBjCuvazTZCr6CSA9Qb
         Hgo+KXbgFQ1tjnsio4jkXEJGiJUmCiqUdpjJlq4Hd8iBQDqZnb7mFhGWdFC81dWNuA7g
         AIP1w2s5dPdlW/aoZAZ17zJX3WePijQHwveERwQUBUO+a1Bd7CghOagOwCVi0hkhORIG
         i5yqmKgPggKpjthat/eyMv9oOfRiKiZhp/u5lgT0V4agMz1rooBfkzg6cSyfTRDf/Icd
         pQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUlSKv9E0vl3kFdY3gqPlGDz72/1PsMjxppIL0hF14E=;
        b=b/tU73r/DifjYRF25/RLD+b70l0MxBjSrvWTmSy4BQ9sii2Uh6f0gZ0BjPBohPIAZH
         sThXLpESFrPKV8ZE7yuOkeAjtb9qEvA6ieRvXborJiGp7lRFpwKPXV5BRdK1qMkhHuaH
         FdZbzucSNIQbgSBPM/Ofx9xZ+66injvKvjfBt9ckkM405zUwdLp/DFJ3ib7q+U/6a7Dp
         bHKrv1MbS4RQe1OLE3R2/go9sRpd2RdnsQJ+hhlOld4uNTbi0pmK9Em0dvdoSql7coIt
         jo8R2e7oivtMnrisGqmXuRM47E2zASuQzMGjI+80CBDAvcELDDLkkFvXcUyIUpKcGhNl
         4zoQ==
X-Gm-Message-State: ANoB5pm6AP67+mHCxBgY+AHcp0//Bo9tSZEV5P7NXLkeXcxURWToff99
        6xP9CuMvPiC/LaNOZ68gkracPk8Rf2Lq2TTUUo/0MiV+R/4QNHY4d7diKIvFJMk1w6pV9ioJq9i
        6KLz4g6Wcp0Mn1WaO3BXtFMmtnpKSZQujqnyNcYiBJcbTByN2aA==
X-Google-Smtp-Source: AA0mqf7IcAAuGDiGtAzRofZJl+gvUNY2iSUBvQP1hROH8Vg+ENJ3zOsLsdI54I6mdl33mjI2yZlkKss=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:9503:b0:20a:eab5:cf39 with SMTP id
 t3-20020a17090a950300b0020aeab5cf39mr78150pjo.1.1668481833133; Mon, 14 Nov
 2022 19:10:33 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:10:30 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115031031.3281094-1-sdf@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Move skb->len == 0 checks into __bpf_redirect
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To avoid potentially breaking existing users.

Both mac/no-mac cases have to be amended; mac_header >= network_header
is not enough (verified with a new test, see next patch).

Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c |  3 ---
 net/core/filter.c  | 11 ++++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 13d578ce2a09..6fba440efc40 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -979,9 +979,6 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 {
 	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
 
-	if (!skb->len)
-		return -EINVAL;
-
 	if (!__skb)
 		return 0;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 6dd2baf5eeb2..910ccd416465 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2124,12 +2124,13 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
 {
 	unsigned int mlen = skb_network_offset(skb);
 
+	if (unlikely(skb->len <= mlen)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
+
 	if (mlen) {
 		__skb_pull(skb, mlen);
-		if (unlikely(!skb->len)) {
-			kfree_skb(skb);
-			return -ERANGE;
-		}
 
 		/* At ingress, the mac header has already been pulled once.
 		 * At egress, skb_pospull_rcsum has to be done in case that
@@ -2149,7 +2150,7 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 				 u32 flags)
 {
 	/* Verify that a link layer header is carried */
-	if (unlikely(skb->mac_header >= skb->network_header)) {
+	if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
 		kfree_skb(skb);
 		return -ERANGE;
 	}
-- 
2.38.1.431.g37b22c650d-goog

