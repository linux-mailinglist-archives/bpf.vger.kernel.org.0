Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3225921057
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfEPVy2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 May 2019 17:54:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45540 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfEPVy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 17:54:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2187739pgi.12
        for <bpf@vger.kernel.org>; Thu, 16 May 2019 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jW23EVTaONU8fGl2rO/gh8exrFRja4BdXSBKXyg60v0=;
        b=zZ6dq6JYsNCTLilh4tdiqHrmv23xzcGSKF4r/LqIMcfbTyNphvxWoH9D2upjSAHuz0
         e9u/x6/0LdA6y7vansZpzlI25i5pXMmuex74Y0zuhc6kkxgG5UXePl8Mkqw3MZEb8Q1K
         fpPH7OlTG6MWtYaTTmh1Q6NAkCjEC7go7jEA+EP+cYezRte27zS3LRUfH1ymuFXKM6Ke
         iComxjPK+RX3NZgq4QGr3wNs4OgEzYvkfQeLDUFWkEIJ8b9TGMDeD+6DZN+ec7zigPMM
         kC6e8ypK+ANYfp2gFTL+W4KOxbt/pHRiS3C2Km5XDfUepuALZA8Fk6lE5mVizH7wd791
         WrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jW23EVTaONU8fGl2rO/gh8exrFRja4BdXSBKXyg60v0=;
        b=tssGb05XuVCjL/tygURhIOtOdtrr1TgMKRWjGxUx5tpOBT6H50s7E88SmYniABA016
         1lpTzoonL1hn1gVyasAbaECDzIt1cffp0gqWDlCoPQihBhSNbfEnvWRghjtsg7n0HULq
         6EQ2UcjHAlg0HkHy5VIyvSR8JJDxRq9o/9rx9nqnwo7A+zWzStAB11kaOfjScps1QaaX
         SsxXkqOH+8aGdwKdMkMGGYXJxnur3cOk45rCvbxEE7VrbnxZqYOYvcII/Cc6HJl1JVNg
         J5yElCcDWVZEZU3codqazzZ/IsvyDhiuw4UtkIfj8N3yK+Lr4D6kGaty0i/Rm6AyygZ9
         r+Kw==
X-Gm-Message-State: APjAAAUzyx4gW0a9AcH7a70eWn5R0lLEifPAkUtKC4wKWk9GzC621TCn
        +tcXtQig0qa/wFQOXM6RuQkmTQ==
X-Google-Smtp-Source: APXvYqx2B9kBrdR04F1t4i1XgaAah3bmKTotNbx3FQ2RNR9kO4Y5NeCwckRaxlUBDkYf1mqjeiOSIg==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr56143116pfb.19.1558043667786;
        Thu, 16 May 2019 14:54:27 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d15sm19842506pfm.186.2019.05.16.14.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:54:26 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net 1/3] netvsc: unshare skb in VF rx handler
Date:   Thu, 16 May 2019 14:54:21 -0700
Message-Id: <20190516215423.14185-2-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516215423.14185-1-sthemmin@microsoft.com>
References: <20190516215423.14185-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The netvsc VF skb handler should make sure that skb is not
shared. Similar logic already exists in bonding and team device
drivers.

This is not an issue in practice because the VF devicex
does not send up shared skb's. But the netvsc driver
should do the right thing if it did.

Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 06393b215102..9873b8679f81 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2000,6 +2000,12 @@ static rx_handler_result_t netvsc_vf_handle_frame(struct sk_buff **pskb)
 	struct netvsc_vf_pcpu_stats *pcpu_stats
 		 = this_cpu_ptr(ndev_ctx->vf_stats);
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return RX_HANDLER_CONSUMED;
+
+	*pskb = skb;
+
 	skb->dev = ndev;
 
 	u64_stats_update_begin(&pcpu_stats->syncp);
-- 
2.20.1

