Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590782F3AE5
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 20:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436775AbhALTne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436746AbhALTnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 14:43:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B325C061389
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:18 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so3713457wrb.12
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUG4KrkwS/48VCqb3gPEYEavBv7WJyPV6SrQz/KaLAM=;
        b=xXVp4dUFwGopoDHrk5N2q6tlpNzp6UcAVfATe6wqsrEI6AsT8zMquFk3s5PrenaRNS
         HsXPG8kYC0iqaJhsbWLQQVLvJzZ9fyG5MMwDHgKfhYHzVUADW8tULfPsAXPKdSzmExXs
         xGkgY8UjXhz4pr/tWYY6LIg0OPuFo4/wilerVoD5vOLJ7+xE3zVBI8l4tgeDUNGcSQS2
         w9lpFADgtL5YNaNmRW34ldPIRi8yBgvDVWpenxM8ASJiWwqp+czbRrxXsd0c45UYufcX
         ORCyuOBerYo0JFSjBUJNikFQv/KEcc3YsnoAYO8aGPrCVo2pExXlWpwTZijTWq2Ccxf6
         uguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUG4KrkwS/48VCqb3gPEYEavBv7WJyPV6SrQz/KaLAM=;
        b=MSdebTbyDGtZCwGVmTqlrghjKZkudoKxu07JqWPYy1y60Ht89bhA8F9VFAcSx0ZgIj
         sIHrjPQZWmg4XrIzRpaAsSLmGD6Bb3/I38RdLhpxAfIwsaVd9aDyxCk8wXGPMp3t3v8V
         JMQzsSk+n7l36jbv6lDu23NuYmTnTFjEBUA+elcZOzUBGhXRydBN1XA0993rXgbAICwx
         TBMcVq747JYgUELrxC4P/TYa65tPVLT3qIoWmSqxSnaXAdSLtmmiio3NEry8f08Js9rz
         jYrMmItJQkpOLcLwOGNcRHyWJFwwf5YU12qw4czMk2yQIXGan3GuP4QtN+EBN/faKwkD
         7/5A==
X-Gm-Message-State: AOAM532pPiTAXxt+rBxjdjiRE1oHPLb4/AGyGRKbJxbYrCiWDoPW9VOM
        pjjexRiOoplF7mzk2BwOefHdRA==
X-Google-Smtp-Source: ABdhPJzCa62kAiSj5dwvAhD+eWjgsemDiqG4ohfKFPsazH9lExZh5CateUK1KDaOpknKxeSQxHaBJA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr454259wrw.36.1610480536897;
        Tue, 12 Jan 2021 11:42:16 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 11:42:16 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        nogikh@google.com, pablo@netfilter.org, decui@microsoft.com,
        cai@lca.pw, jakub@cloudflare.com, elver@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     yan@daynix.com
Subject: [RFC PATCH 7/7] tun: report new tun feature IFF_HASH
Date:   Tue, 12 Jan 2021 21:41:43 +0200
Message-Id: <20210112194143.1494-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

IFF_HASH feature indicates that the tun supports
TUNSETHASHPOPULATION ioctl and can propagate the hash
data to the virtio-net packet.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c           | 2 +-
 include/uapi/linux/if_tun.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 214feb0b16fb..b46aa8941a9d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -88,7 +88,7 @@ static void tun_default_link_ksettings(struct net_device *dev,
 #define TUN_VNET_LE     0x80000000
 #define TUN_VNET_BE     0x40000000
 
-#define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
+#define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | IFF_HASH |\
 		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
 
 #define GOODCOPY_LEN 128
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 0fd43533da26..116b84ede3a0 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -73,6 +73,7 @@
 #define IFF_ONE_QUEUE	0x2000
 #define IFF_VNET_HDR	0x4000
 #define IFF_TUN_EXCL	0x8000
+#define IFF_HASH	0x0080
 #define IFF_MULTI_QUEUE 0x0100
 #define IFF_ATTACH_QUEUE 0x0200
 #define IFF_DETACH_QUEUE 0x0400
-- 
2.17.1

