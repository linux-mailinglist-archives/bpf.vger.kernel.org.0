Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF655AD9AC
	for <lists+bpf@lfdr.de>; Mon,  5 Sep 2022 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiIETeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiIETeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 15:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416C947B95
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662406445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAd/VecP2MZRhwRKWI0cKHnWo4GF5vigtD9fuoHU34o=;
        b=Pi6qBQs4aBKFK+aANY7c4HUWGWNshtm5s8iaFngjKmMWF989pWEmWrgP2TygvC0uKBl42Q
        Q8wFXroz/5X0wGvus4EqRo3Jk0779YC6ktF5KcaXzUFgoo2M5YQq/Jy/CVflGKteOWLTCQ
        JYR58Gp4aplX/YpdA8BX8+qrY3PJnhM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-pcRjbfQRNgSgEW7qI24MOg-1; Mon, 05 Sep 2022 15:34:04 -0400
X-MC-Unique: pcRjbfQRNgSgEW7qI24MOg-1
Received: by mail-ed1-f70.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso6202034edd.2
        for <bpf@vger.kernel.org>; Mon, 05 Sep 2022 12:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CAd/VecP2MZRhwRKWI0cKHnWo4GF5vigtD9fuoHU34o=;
        b=5TW9/N+rqa5fyHJbS1ZDY/R6YY/Uxt4u9TNOaWEuSZDO+N0SKnS/UHrGn/lH+xjzY+
         1sR3mEu2BvQ/55XkW71aln2w+4lMTsrq7V9Efy1u3RRR8eECkS8SqVXqNuvq/8b1V5qw
         s24OmnmxIKULCmEmmMhZdTLzGJYcON8yYNMgP+N6+9889Odvi/8U8dXKazmLMQIMTblQ
         2361/Np/MddqxxHOFY/RLG1KXMfQwd+Odcp9MwklbjFCmEQQVknY1Q7BQcJLhl03hopp
         bazej6Rl7++RRPa4BYuufq7Co5gZKNMvFZtah1ANYuqxPDRalQCrlFA2+4Qp/4ypHjhA
         mzDQ==
X-Gm-Message-State: ACgBeo3oChYTz5VyvX81E8djCRvOwkgbrVQTYnz8BuK7fSzcXFXU9wzJ
        ybC9nHVgooJUopZBsunE15ZqyNSzcVefQUSsHUqsYhveaGYV+TA0G3e88eZ4PkW3Q9g0MGlmV9M
        VGSP/B7Rvv3B+
X-Received: by 2002:a05:6402:493:b0:445:b5f0:7a0f with SMTP id k19-20020a056402049300b00445b5f07a0fmr44256653edv.120.1662406443146;
        Mon, 05 Sep 2022 12:34:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4pVQe3qSOx/wgHtodZiQ05j0d4BFeDOSZcdI6v8z0vqKVgnSZkHXtYC655WjdM8Wlk1NoOMw==
X-Received: by 2002:a05:6402:493:b0:445:b5f0:7a0f with SMTP id k19-20020a056402049300b00445b5f07a0fmr44256636edv.120.1662406442837;
        Mon, 05 Sep 2022 12:34:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090640c500b0073c9d68ca0dsm5481754ejk.133.2022.09.05.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:34:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 74372589582; Mon,  5 Sep 2022 21:34:00 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] dev: Move received_rps counter next to RPS members in softnet data
Date:   Mon,  5 Sep 2022 21:33:57 +0200
Message-Id: <20220905193359.969347-2-toke@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905193359.969347-1-toke@redhat.com>
References: <20220905193359.969347-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Stanislav Fomichev <sdf@google.com>
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

