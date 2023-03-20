Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F866C22F7
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 21:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCTUip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCTUih (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 16:38:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F136FF8
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 13:38:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p16so8356254wmq.5
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fr24.com; s=google; t=1679344676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQohLGEa7JjykxtbfNMa8oZs5DLFyYwmZWja+MlMiVw=;
        b=H3NCZw/1FpPI+TVY7eC4KpLOPxaWql2eACBU4jrmQDuuk88BJ12uv957pPOi+h7BM3
         cdGMsRV+KCQE6r8IsrWcW3HSJtJoMCQ3l5LFSYZUDplRoaRgpleqW4SzmYqV1JFcmp9n
         12SZSPlbjz6UPgrXVZ6xbVzX/vs7MNvDK2cZy+JjUl+2c+3hmOqDv0eyuL/Ilwu3lg4J
         NTN6TL9V3lyIbdQSprh0H/DKeWBZj2DrwOa81nb2Xf9NzYT7ukdkjZhOlpMqRdzubZih
         0OUviBDWr4/I5c0Y85kHzIwqmL/yeCMSaH2AJH7ZOmDTOPDf1a8WxIxbdzDq8NAaKq4w
         xD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQohLGEa7JjykxtbfNMa8oZs5DLFyYwmZWja+MlMiVw=;
        b=bcBxtcuIncSnNi/aJprV+dVaJNvKINtIG/KRZl9acqXK5t35zYoI5Dt5GFgAvFrVwz
         h1XY3UV+Hq38saaFXuB6biRzA1qJB/TJ6omTu04LnvxbBy0RSQOf0+6Aj7Yw0PwuNeOy
         +7ny5vB94PIQa7XjOTUVxhz5Cdq6ZlIWgZ/8xz0lQRhFvY7OA/aEs9QpbuujWPpgs3qz
         xSPQ7VzNnMPpNl2oSF9R4U50lugOWh2ko8Xoys3xT0w+7yjg0L0JBiQt41qFP+n0FerK
         qefKvt9pz1GeZbSEpyVo5V6ULxLnOZ2JBTI+4pP7j1SVUzN+4mGe6FyvDS9T2p+NFp8J
         UmQg==
X-Gm-Message-State: AO0yUKVj3PmwEx+AKowz9N68w6vJHvkOvW/KgOEcnClpvT16PBo8tgZg
        jt4wv3SHrlXgSafbXkCRc0Hsxw==
X-Google-Smtp-Source: AK7set8Vzb6zK9WqQrnemici//mFPICUUiN5gc8bbXl1Soan9EIdbLGmPd0zlkTRhO1H1UzkDGYY3A==
X-Received: by 2002:a05:600c:3792:b0:3ee:5c8:c3d8 with SMTP id o18-20020a05600c379200b003ee05c8c3d8mr630151wmr.34.1679344676271;
        Mon, 20 Mar 2023 13:37:56 -0700 (PDT)
Received: from sky20.lan (bl20-118-143.dsl.telepac.pt. [2.81.118.143])
        by smtp.googlemail.com with ESMTPSA id q4-20020a05600c46c400b003eb2e33f327sm272727wmo.2.2023.03.20.13.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:37:55 -0700 (PDT)
From:   =?UTF-8?q?Nuno=20Gon=C3=A7alves?= <nunog@fr24.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?q?Nuno=20Gon=C3=A7alves?= <nunog@fr24.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next V2] xsk: allow remap of fill and/or completion rings
Date:   Mon, 20 Mar 2023 20:37:31 +0000
Message-Id: <20230320203732.222345-1-nunog@fr24.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The remap of fill and completion rings was frowned upon as they
control the usage of UMEM which does not support concurrent use.
At the same time this would disallow the remap of these rings
into another process.

A possible use case is that the user wants to transfer the socket/
UMEM ownership to another process (via SYS_pidfd_getfd) and so
would need to also remap these rings.

This will have no impact on current usages and just relaxes the
remap limitation.

Signed-off-by: Nuno Gonçalves <nunog@fr24.com>
---
 net/xdp/xsk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 2ac58b282b5eb..e2571ec067526 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1301,9 +1301,10 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 	loff_t offset = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long size = vma->vm_end - vma->vm_start;
 	struct xdp_sock *xs = xdp_sk(sock->sk);
+	int state = READ_ONCE(xs->state);
 	struct xsk_queue *q = NULL;
 
-	if (READ_ONCE(xs->state) != XSK_READY)
+	if (state != XSK_READY && state != XSK_BOUND)
 		return -EBUSY;
 
 	if (offset == XDP_PGOFF_RX_RING) {
@@ -1314,9 +1315,11 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 		/* Matches the smp_wmb() in XDP_UMEM_REG */
 		smp_rmb();
 		if (offset == XDP_UMEM_PGOFF_FILL_RING)
-			q = READ_ONCE(xs->fq_tmp);
+			q = READ_ONCE(state == XSK_READY ? xs->fq_tmp :
+							   xs->pool->fq);
 		else if (offset == XDP_UMEM_PGOFF_COMPLETION_RING)
-			q = READ_ONCE(xs->cq_tmp);
+			q = READ_ONCE(state == XSK_READY ? xs->cq_tmp :
+							   xs->pool->cq);
 	}
 
 	if (!q)
-- 
2.40.0

