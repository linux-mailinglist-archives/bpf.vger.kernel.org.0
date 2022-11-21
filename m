Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2B632BB0
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKUSDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKUSDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:03:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF95C776
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:03:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-38f92b4b3f2so118669927b3.1
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NVggj3/8SQuAZWQeHPxaxUL9OMkb+u39cDymqpn/oRc=;
        b=klAOaQnyuLDNYweE3hQQZy6pgtKcAEQs83RwdXPyC02TtqS+AM6tACv7n4bu7eKCtb
         PUdb0dn8PCb2a5Gu1oYhg05IMeM6PnbjGSq3adzXQOXActhrzlmrl6/KGvzksN2E1+hr
         49yF27ywZ9js+uBZwcUiYeN6YJq3yMF6dIercxrMKs85fENvrQdp4i0EFQrS14esGAmK
         93FA9s6bQWCDXPNLvUz0AzMq0HsLPDhC55hBRdTRZqTgvKrLX/6iXA2OZdwlmnE+0rXS
         qldcIFcZojSoJTxoEaXme41i0CrNBthqAV93OnVmg5AmXOE+AceVCvsoI7ungECnoOdC
         JxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVggj3/8SQuAZWQeHPxaxUL9OMkb+u39cDymqpn/oRc=;
        b=ZVjD7IdH6TKa1pgpm0tDwPVztQkI0KEwBVi8Vf7dMT8bBYAQaA80NH/fRwnHOtOFqG
         ZD/oyRLo+3PUi667qrD2kL+UtfOBOW3TYaTlpUbbKRr1H8EnRBN/XRqt7rcfhXbc7zwC
         z37fqbTso3XExU2kRQVyNnGlhrvl32C9PWL3IMV6BJybAGP4VkITvoyJ5O8pScZk6PdE
         4t3P7X+M/QEucOVao0msvLjfFHGLbEIOHzbq4ed8EuldcLPXbUTmwjJS6pcvTogtus1J
         uKfGY9xBuGrbszRMgktMwTf+XpuzqpEAvDhSi1l/A+Ox/rUmthIyGaNLFSGdcWKnwbJU
         e/4Q==
X-Gm-Message-State: ANoB5plLhXVm9Pflvtsmd8Td7kSWuuopViOGjf25SECk9ZcWVp6MrjWP
        yzdlmglwrpoM/vz4bj6fcQ7LT9s1luuldR/kVH5r2o/M0C/qRYo35WIBkH1hkfEF2lNUgf8SXqS
        0A7ErRNSBWT8ivjHHU8JhWEBEVDh9aY6sAFXHjP+HfLE39xvzXA==
X-Google-Smtp-Source: AA0mqf7whjH8Flk4akdyY1w8mhCaSGupZAlBzZWhdIs3FbG75FOHhgQzF4ny77+j8I6LOZPeS4Aj+AA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:ae12:0:b0:6d0:704:f19f with SMTP id
 a18-20020a25ae12000000b006d00704f19fmr2687234ybj.191.1669053821634; Mon, 21
 Nov 2022 10:03:41 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:03:39 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121180340.1983627-1-sdf@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Move skb->len == 0 checks into __bpf_redirect
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
index 2a105fb1ceb2..b6e1b81cdfae 100644
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
2.38.1.584.g0f3c55d4c2-goog

