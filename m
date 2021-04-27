Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BCF36C760
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhD0N4l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhD0N4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 09:56:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E67C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 06:55:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n84so4694608wma.0
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7+whzqW5x/zOs8ASzvzaNm5ZsDnTaE7h9NdF0ufML8=;
        b=sebZ6nFVa3F09s9ijslenAdin27tp3PgOUprQCA9BP84HER563/pzG5ytjfdm++SaT
         tANJAmYt5b3b7PB/2sKw+e8mXqzU8NlVtqdcq8Dql3as5aTLU77z+4RCbr2giULufhQF
         L4hiKhWxzHi3Uwukp8m4+X9wcwYEpqMYXwDscISKEQVwUj1xQ8iPEX9L3pEMZoLgBh1Q
         ZY2PQFcrcoGNtBLvuVIJtItTwNDtkLmAI+A1BldROrJUCgZY3rUYEJnS7H2VjBPV65fK
         VH9WN2bF/G53IeHcA+gQdjeunBWBSTOnu7AN7hH0XKXuGqO//h0ObVhcA7og2b9RorUW
         nsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7+whzqW5x/zOs8ASzvzaNm5ZsDnTaE7h9NdF0ufML8=;
        b=dqoaqmCH95sGT1eVEadrlQ75FWauoljQsz2OLPfmkLDrFPquyTTdbdAjBmZ9SZXoYB
         VAkkOtVa5fORQr39p4hUGT5K4ewCxutmDDZrxAAdIPd2/IjYu2QUT6qDpVqzl9duvdNy
         YlEPvy0LtKdO/68ypYR48npBsAGaF+IzUDFfU25/oQLjer1yybO7Tp0GRXSG6yKBykqx
         VNRKctAUuszor+WTU0hif7sjW83E4cmFF3wV1YEGRytOQJ11g+0xvpSicwGHVvC/Kl1d
         cTR1rJ08kG8UISZ6F0yE6cYMz+FPaQ2puiCGOv+mSHB4N6Vm4uqMFvcCZTMVozBvMNYU
         jb8g==
X-Gm-Message-State: AOAM530olvLSs6ctKfKMf5SwcI/GzCo2BP22syPK5e+WNGttyB9whzOw
        K1VGLISf+eb5TE2yWxbxsIagYnZ+WbyT
X-Google-Smtp-Source: ABdhPJxqTm+bgZJPk2M7Lr8YSAWNl/n8o+eZUtyP17jawLiVNHU+bxCZ+T4vc8AMl20UjmgQfhpDwQ==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr8398186wmi.82.1619531756520;
        Tue, 27 Apr 2021 06:55:56 -0700 (PDT)
Received: from balnab.. (212-51-151-38.fiber7.init7.net. [212.51.151.38])
        by smtp.gmail.com with ESMTPSA id t7sm1086991wrw.60.2021.04.27.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:55:56 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Set mac_len in bpf_skb_change_head
Date:   Tue, 27 Apr 2021 13:55:49 +0000
Message-Id: <20210427135550.807355-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
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

