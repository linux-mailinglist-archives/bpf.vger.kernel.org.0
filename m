Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985662284B
	for <lists+bpf@lfdr.de>; Sun, 19 May 2019 20:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfESSVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 May 2019 14:21:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40349 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfESSVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 May 2019 14:21:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so5655283pgm.7
        for <bpf@vger.kernel.org>; Sun, 19 May 2019 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jW23EVTaONU8fGl2rO/gh8exrFRja4BdXSBKXyg60v0=;
        b=ozrAcyT0DpFtEMYykTdhJbaq66KrzCAXKUFjhOLB6dzNeGwggFwc56RbIt/G7DA7IW
         M/rItzMyRXrr1YWAA9gEUgIjPS2/IZYOtgquWDTPcOGMCesGJhlfAtsdM3AmJMoStidX
         UG8cOB3AP0ZIfOj1JoJ7+BLkc9leWofJbqyqzm1nb4jY0/EO8DfnuLFbOR7m7M545TBr
         6SXhfosIzl5Jz6BNc5h1qqlxlgTk7KpE5cAxf0VUYWAxAn9TtNp6OgRudSg/2dJgXzQe
         3wNqZg4XVFOSobHHfP5Yyge9R6Rn7EhRdQtKSXcfqhL7Hdz+MiCKzPE/n4yt9E3zIbUi
         J6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jW23EVTaONU8fGl2rO/gh8exrFRja4BdXSBKXyg60v0=;
        b=Cq8wXpWmMmEElEHzuhqXUdLqlLYOuojgvGWGgNtMDwHHMrRR7Mn3LWOfDWaiDnykbo
         +zCx5Cg/xtok3Il0PlSBU112NlNgwfuPDKgS8lGaBpp+glP0WAVj3K6Do98ZCFi8jfYw
         U6ymPeFVabs2MTFMmrh9tUqsQUfgp3g7//zOTZlBJCb2oHP+Sl8YxvBC7zVaF+zIdBKr
         N654c/DS2krLrAV/OKNoL9ffAr/exRQsSww8gW4S60/L/LUG+cCX25FW4e0KxG1Q8siv
         lvRTKwoP0zjFlr8xRB5HskA2hKGse7WnljOW99yyP4nA5gZm0gYNRXRpeP9NpP0uNTu5
         hzLQ==
X-Gm-Message-State: APjAAAVnYdF3SebcB2LLhxiEZXuYxLvKjTKWl9OY7hIXvvtH2kfDWpIE
        rPsZaxj3fB+aMji0uoQpDj9r2VJHCKE=
X-Google-Smtp-Source: APXvYqxRzJW84pUeaYRcQIKBpl3JDeUa6cqWfgZ5OSUgwQndPN6hm0wQ7j5J8ZS2QG7aTVmpTFX33A==
X-Received: by 2002:a62:fc56:: with SMTP id e83mr19902876pfh.27.1558235451125;
        Sat, 18 May 2019 20:10:51 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id s80sm39049604pfs.117.2019.05.18.20.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 20:10:49 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v2 net 1/2] netvsc: unshare skb in VF rx handler
Date:   Sat, 18 May 2019 20:10:45 -0700
Message-Id: <20190519031046.4049-2-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519031046.4049-1-sthemmin@microsoft.com>
References: <20190519031046.4049-1-sthemmin@microsoft.com>
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

