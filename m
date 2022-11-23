Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF1963623E
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiKWOsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiKWOrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0E663EA
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669214811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4AIn+quvPgiVICTvsFmAlgR+g1gZGyh/F5Rd1nBfOI=;
        b=YDXb++VvFd7oKQwH47j9uFcIuevVqEjUQyRKO04SozzeVy2N56Qnm+OjwYdtGiQuKOI4un
        COwFrccBjtLWfF/RtigHoac7WcVi+E3sJkCvVUbLrYNTngIgs8kg31ZzFdIQcvP+JukVh9
        nu4Zn4S4u+N1TxjpglXEw92TTzsPx70=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-XQtCS63iPVqmbhT_mEVABg-1; Wed, 23 Nov 2022 09:46:50 -0500
X-MC-Unique: XQtCS63iPVqmbhT_mEVABg-1
Received: by mail-ej1-f71.google.com with SMTP id hr21-20020a1709073f9500b007b29ccd1228so10047784ejc.16
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4AIn+quvPgiVICTvsFmAlgR+g1gZGyh/F5Rd1nBfOI=;
        b=vWj2A8bHy9UQKZd477dejM9EaptWMGFOjWELd1A8l5q+3qJ0RvM8ZHHLZxhOGgVvkG
         /5tCQbOWV0AObKJ92Mn5p2Rq5TlepeJS94j8+Yct7gYQFYIPs7OooBfyGpWrsKbjPiFl
         TEEMGGt1Y3oterRJehazed1gug0VGqkOmL/71vcYzp+Nn9Jr6+V+NMH9EJL9QhBv+F37
         smWBhD+QqtzS1vrUqBZt5s77PupsVFw2MzEd6dJNq3Rk6Z+gXSjS4wT3inBisMI7o9qW
         vdX/sNn/pXLSHXq2V/FbNsWFk2e5VlBCXoZomA56M/XwS7qLnm7r7HBoh0pqo7mWExQc
         VuXA==
X-Gm-Message-State: ANoB5pnHM74g8tddIqCJ/ZYD7WdLrDJunp5nP3zmqoTDphTgmlTUnp9a
        NxcN8kZH3m+muGvBYGnqeZIsPl1kMaOE5IUHL0MM5qx4YNW9vJjp3rrTF7sYoLQXdaJaOP7Sovh
        IJeADPrfQIPoi
X-Received: by 2002:aa7:db98:0:b0:46a:d57:d9d0 with SMTP id u24-20020aa7db98000000b0046a0d57d9d0mr4617908edt.113.1669214808093;
        Wed, 23 Nov 2022 06:46:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf76Xwlecz3uWnEPrUVfOZ2j2sVz2PufzKSvKkuGlwgVHmxvQrWUtXtZI6kmUXc9mVNmnnYO8A==
X-Received: by 2002:aa7:db98:0:b0:46a:d57:d9d0 with SMTP id u24-20020aa7db98000000b0046a0d57d9d0mr4617851edt.113.1669214807256;
        Wed, 23 Nov 2022 06:46:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm7631864edt.66.2022.11.23.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:46:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5E7F97D5120; Wed, 23 Nov 2022 15:46:46 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>,
        Stanislav Fomichev <sdf@google.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/2] xdp: Add drv_priv pointer to struct xdp_buff
Date:   Wed, 23 Nov 2022 15:46:40 +0100
Message-Id: <20221123144641.339138-1-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121182552.2152891-1-sdf@google.com>
References: <20221121182552.2152891-1-sdf@google.com>
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

This allows drivers to add more context data to the xdp_buff object, which
they can use for metadata kfunc implementations.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/xdp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 348aefd467ed..27c54ad3c8e2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -84,6 +84,7 @@ struct xdp_buff {
 	struct xdp_txq_info *txq;
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	void *drv_priv;
 };
 
 static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
-- 
2.38.1

