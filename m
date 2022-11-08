Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523276214FC
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiKHOHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiKHOHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA6C69DCF
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 06:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667916369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sl3yRy218aHzyQly56lFG09Q5E7qWzHqb5L/W0IjWek=;
        b=TTA6Ew7wKseKOJNLEWCF9htc9WSK9+/nInvbFp6HbBaJ2qNK1Y8ULvNEmo/ZKoh5jDkR37
        5zdk3kNN0Lx9gLqAn5z0a4CpOVw52XDFbSQOgAC+paPzPU7qDbvxgzjA2+BQFvBbjIM0eY
        XAo5V1EnCARP1s98YRPbYlelwx3yZ0I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-5zXCYx6sPViI2PGdm1CsoQ-1; Tue, 08 Nov 2022 09:06:08 -0500
X-MC-Unique: 5zXCYx6sPViI2PGdm1CsoQ-1
Received: by mail-ed1-f71.google.com with SMTP id l18-20020a056402255200b004633509768bso10511743edb.12
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 06:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl3yRy218aHzyQly56lFG09Q5E7qWzHqb5L/W0IjWek=;
        b=0bMEUR3fhLdb0BqZRhmRCIuRm0VCUJP3EW9mrc65nK0j8C7hLS0pu0Ks7qBwIPuIin
         J6LvqTiu5t4w0V8c08ofIi49T+ZKM6TxYEZ/Yv2Es/waN29ix73kcKhN6Q7xZgu+1iEx
         LMXzBOpPQ6F7MJK+GMa880JLzEQ5YnY2Yy1gjVjBeFGVe5Flvqa7XRTBaRI6UVRkpXUr
         Tk788TjotFEZLC5BSjTSuHNMvGjxdP5ITI8t8XfJRcu3EJ4/nE8ILMUJD/8O0ih80yE1
         i3uV95Mz/2/KwIT5ZK11ta2okZeKg8sBhIfSMkF5SXXRsvlTu/l+kdAj/bKwBy+7pAvv
         2v0g==
X-Gm-Message-State: ACrzQf2dD19mDtI3eWf157HxH85KKIXJUVEQd82BNQe9ghwqQQ1KhUyr
        b2ArOPiP922o5c/ZUgO2v7rSYKLpWy0yFooFEBhiCwEY2PIilFa4+g1G3HSFiYlDA5R/bNx165h
        DSov3QIgLJTPQ
X-Received: by 2002:a05:6402:22f1:b0:462:f6eb:6c6b with SMTP id dn17-20020a05640222f100b00462f6eb6c6bmr55960113edb.365.1667916365696;
        Tue, 08 Nov 2022 06:06:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5NJ2carxvOY0HrxOeFub8azKnPISPzrmR2iGDEEi5HaGLkHXFnfsllxFWTzbboNTOG2giGoA==
X-Received: by 2002:a05:6402:22f1:b0:462:f6eb:6c6b with SMTP id dn17-20020a05640222f100b00462f6eb6c6bmr55959945edb.365.1667916363837;
        Tue, 08 Nov 2022 06:06:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4679728ejc.84.2022.11.08.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:06:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E65E278152D; Tue,  8 Nov 2022 15:06:02 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] dev: Move received_rps counter next to RPS members in softnet data
Date:   Tue,  8 Nov 2022 15:05:59 +0100
Message-Id: <20221108140601.149971-2-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108140601.149971-1-toke@redhat.com>
References: <20221108140601.149971-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the received_rps counter value next to the other RPS-related members
in softnet_data. This closes two four-byte holes in the structure, making
room for another pointer in the first two cache lines without bumping the
xmit struct to its own line.

Acked-by: Song Liu <song@kernel.org>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4b5052db978f..31c53d409743 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3114,7 +3114,6 @@ struct softnet_data {
 	/* stats */
 	unsigned int		processed;
 	unsigned int		time_squeeze;
-	unsigned int		received_rps;
 #ifdef CONFIG_RPS
 	struct softnet_data	*rps_ipi_list;
 #endif
@@ -3147,6 +3146,7 @@ struct softnet_data {
 	unsigned int		cpu;
 	unsigned int		input_queue_tail;
 #endif
+	unsigned int		received_rps;
 	unsigned int		dropped;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
-- 
2.38.1

