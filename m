Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50563598981
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbiHRQ7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiHRQ7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 12:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3D3AB24
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660841954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPnZg5sieCcrClfL19KUprDR1I1cYNohdHMRFExuYds=;
        b=Pu+T2TfITzWc0LHamaMpLxydExXGjV4/Y8+31wS9lBOdk4nIdAM0byA218pZfRcWyz03IC
        trMIN9dfyAsNQv7Nc5GXCzXq2/LnGnB0pTopQaYbBIK9xCYHdC2Z63kkn2CnLslKlTAwT8
        QEydGSE+O4N/0ss2kHA3daBONcnkaOY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-A-9vFfMhNK-sc1kVxyQFYg-1; Thu, 18 Aug 2022 12:59:12 -0400
X-MC-Unique: A-9vFfMhNK-sc1kVxyQFYg-1
Received: by mail-ej1-f70.google.com with SMTP id sb17-20020a1709076d9100b00730fe97f897so888136ejc.16
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qPnZg5sieCcrClfL19KUprDR1I1cYNohdHMRFExuYds=;
        b=gqPkWSr2KG+lFITMktQrRpTcnoEuw7ctLeVZSEa+z3z469V6d5XtiH5V4kZEBwJA79
         nQETMw1TMqPorQOS+6z1Gr2A4lWLt9P71UR/sTI4CdIxy3SwGA8PtRhVawEETVjC5Ijy
         h9jCEWzM1IR5ncHl5qQlinMlYXOcpZ1MlzLq20Hk1dWHCh/h7lkM49bm2JTG87vh0m9Y
         SuzuozO/7Wbm1bDZ/a1koWBtcYH4x2Kkk7eYo4p7vDyLakrQDfgL7x8F7ZqGQg1m/a4C
         5LgM0f1NK6Whv2b686KU5Qf+0Qy3Dd2nJ5kC1yrFy687zxypB5OpxmWqB4VGmYPJRMlS
         Ex0A==
X-Gm-Message-State: ACgBeo0J1nZymTWZU/0WFI1sUkoAvA3GSqrqXvPomHV2lnTJvbe6XQVU
        vxFI2dYHeuxbjlL4KOThT4MU8mDgPi7u8gOaOCctmSQQAEaUHZs7i80e2UMSUPmOSYBy+hPXV0I
        YFwNAcjOZHR1q
X-Received: by 2002:a05:6402:3485:b0:43d:7fe0:74d1 with SMTP id v5-20020a056402348500b0043d7fe074d1mr2974820edc.413.1660841951032;
        Thu, 18 Aug 2022 09:59:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kfeZHBJ6EhZ2RgJtrW4x5BxNJKyM6xSp+khI45JVy8cxbv3UMGDoijwluWRgq89Z1KUA9NA==
X-Received: by 2002:a05:6402:3485:b0:43d:7fe0:74d1 with SMTP id v5-20020a056402348500b0043d7fe074d1mr2974800edc.413.1660841950692;
        Thu, 18 Aug 2022 09:59:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b0072af930cf97sm1045882ejn.115.2022.08.18.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:59:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1E51055FA97; Thu, 18 Aug 2022 18:59:09 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/3] dev: Move received_rps counter next to RPS members in softnet data
Date:   Thu, 18 Aug 2022 18:59:03 +0200
Message-Id: <20220818165906.64450-2-toke@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818165906.64450-1-toke@redhat.com>
References: <20220818165906.64450-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1a3cb93c3dcc..fe9aeca2fce9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3100,7 +3100,6 @@ struct softnet_data {
 	/* stats */
 	unsigned int		processed;
 	unsigned int		time_squeeze;
-	unsigned int		received_rps;
 #ifdef CONFIG_RPS
 	struct softnet_data	*rps_ipi_list;
 #endif
@@ -3133,6 +3132,7 @@ struct softnet_data {
 	unsigned int		cpu;
 	unsigned int		input_queue_tail;
 #endif
+	unsigned int		received_rps;
 	unsigned int		dropped;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
-- 
2.37.2

