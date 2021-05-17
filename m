Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491A238298C
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhEQKM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbhEQKM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 06:12:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35513C061573
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x8so5730612wrq.9
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eb/sZnC9tKTa5Nfr2VgpjZ1wdFsVZqEEbySK0mhbpQ=;
        b=UDjoR8zKVOTEjKw33+F+/8rHUPeNQ3QApgOwIJ7lhadw2f5WOSJz6+CrWfNnYgRawd
         6iQLE43Tbz8lJ8aE8WV6abNwDfRX6902C9nVtPKFgxiSWfuWjbVXeqYxJyCIxbuIdcgW
         6ehZnCiFs9OMgqypdj+SM3Piy8btC8CG6insB9Q5EP00IQaK4kk6CQjin+9aE2StJg6z
         P8YNEItv6plO1lKGfGr1luPo8M14GU8s1VUEiy2n1UJj9QUwAJ83ACO93TkzEP+83w7b
         amcz/VX46/v+djbj0ioRn07wsMkSaNQmUdeaYKgbpYOWQiFnPWlQU+yAXFZZtrSpq1ZN
         kiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eb/sZnC9tKTa5Nfr2VgpjZ1wdFsVZqEEbySK0mhbpQ=;
        b=WyELrRLfutc03jLY6JF8nvuwJH5/RXdODoQ++AhBbM139SLWZOD0ueYMUzoyLlkYOm
         jWF0dFAmiMLnve2euUec+eW1nIKLAuhcZQiD9WH15AjciHVwILi9jVsoUZCFtUl7B1CL
         c/zrl8F5wOlaCGFD64DRZIAD9jXJHN1iPX6KxPyiFuRn3Xvs323AAkUdOl996g98slas
         pXEbsMwxhb2aNC8UKCobqmKl3vZ5nmvmCF01U14VHcf16FRevUeYB6/PlNy7m4MxGIE3
         zEgn83LOCoYd/ubADNLJm9ohj9iRAfWJFL50hWUS5gHYDMoFeXAA4wv6aCJl1uc1A/Wu
         0sxQ==
X-Gm-Message-State: AOAM532hRG55pWFzE05doM5D13uOHUll7iG4DTsra0AoF6Ms7Os5sjVO
        rwsPxPKm9xgBQiMhGqzBUl/naD8/muu2nsA=
X-Google-Smtp-Source: ABdhPJweNXUO3Y3iqmkQuEqImCLpxac0XjL0hN8vw/7OaDyIIRnSfq5Vnxv29sVdqxNYTgqRkq6ZVw==
X-Received: by 2002:adf:d4d1:: with SMTP id w17mr7668184wrk.413.1621246298603;
        Mon, 17 May 2021 03:11:38 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id q12sm16993265wrx.17.2021.05.17.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:11:37 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v2 2/2] bpf: Set mac_len in bpf_skb_change_head
Date:   Mon, 17 May 2021 10:11:28 +0000
Message-Id: <20210517101128.641827-3-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517101128.641827-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210517101128.641827-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The skb_change_head() helper did not set "skb->mac_len", which is problematic
when it's used in combination with skb_redirect_peer(). Without it, redirecting
a packet from a L3 device such as wireguard to the veth peer device will cause
skb->data to point to the middle of the IP header on entry to tcp_v4_rcv() since
the L2 header is not pulled correctly due to mac_len=0.

Fixes: d98138927f3e ("selftests/bpf: Add test for l3 use of bpf_redirect_peer")
Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index cae56d08a670..65ab4e21c087 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3784,6 +3784,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		__skb_push(skb, head_room);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
+		skb_reset_mac_len(skb);
 	}
 
 	return ret;
-- 
2.30.2

