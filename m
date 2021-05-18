Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BDE387B11
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhEROZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEROZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 10:25:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D0C061756
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 07:24:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1582570wmn.2
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wY0U3yml1FmuDrNFJkneaRlN73+pBj2uZ2euwBiv1Z8=;
        b=SBFEuVXdkUlNmLFVLW45iBEAc0PrgUa41CzeM+asnkYBiWxVkJd/3v4GnoW5uzdhLr
         Bv1KASBW+M0FwDEqllmpYCFcfEjH5WU2lC0YMB5yXSyx/45lyRIvRJ3j/61aBMWwZ4yr
         v5UXVpIo65xI/Z9PvHTWvSdQH//E+h9PJGHBZ5Ah2es0m4rWCAwinMgEQDcD5ZYVB82b
         PFx8FQZBYWO6UJUt80TFOIL6qNdA2Ar8cGao7iwDVCKNFyi7ybv0W4kJfCZz0S2xGMXT
         QDHCjlQmWgXw1np2jyXoZCsoERfLp7eYYnfbJboJALtmhqBUnTFTIv22zIgPyO2qz2eS
         HgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wY0U3yml1FmuDrNFJkneaRlN73+pBj2uZ2euwBiv1Z8=;
        b=hvqx5gczMqK9SwSW8DIzhoUBay/zPOtubaSX7EzW81enIFCrOiUMH/lnrfyBP/ntS4
         och8TyAAtYXivzoWdcOpbiCZxlYLQdAbeEqBJxDil1wmNAFGCdg9Ebrht4kF7n5A9iGH
         MJ9dmahpCOSzu/QyMTbM+44gWxIG2E7NrvD0afSKSJXrPMl28TB7wmTAZ7XvTc2Xyj3z
         UNtRrvzNOn0qKRSgFI5lQbKJAlkMYW+8d3NHkGsnGSVIGIzPMNOwaifZH8cPEwaF3bUx
         fdwzIYVquHKAvJdKdzpiT7LaYvDBKBXRkIzVV7/h4hj3nOIcKWtKB9/vd7cvkFw9M4/h
         5gbA==
X-Gm-Message-State: AOAM530QiTFLlub8yNE6tYORPhaxxDSgpDH5fH1LtCKfm5kny2TEmEbt
        Vi19GucTuddPBhHaALD8/3TLd6Fbron7
X-Google-Smtp-Source: ABdhPJzoxwbygQFeCsE6Orfqtp2Yfmii1V2N5uSUwruFM3Vb62Fi5jEvQStxLtdqIw9fZ21U44R7qg==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr5215237wmi.160.1621347840483;
        Tue, 18 May 2021 07:24:00 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id u126sm3443332wmb.9.2021.05.18.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:23:59 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Set mac_len in bpf_skb_change_head
Date:   Tue, 18 May 2021 14:23:55 +0000
Message-Id: <20210518142356.1852779-2-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518142356.1852779-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
 <20210518142356.1852779-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The skb_change_head() helper did not set "skb->mac_len", which is
problematic when it's used in combination with skb_redirect_peer().
Without it, redirecting a packet from a L3 device such as wireguard to
the veth peer device will cause skb->data to point to the middle of the
IP header on entry to tcp_v4_rcv() since the L2 header is not pulled
correctly due to mac_len=0.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
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

