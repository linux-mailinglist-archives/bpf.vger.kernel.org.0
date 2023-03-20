Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735A36C0FED
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCTK6U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 06:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCTK5r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 06:57:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546696198
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 03:54:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p16so7164953wmq.5
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fr24.com; s=google; t=1679309667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VF6kF1o1a7cu8qLgevPU4rykmBSUA6+nY/q/8AQKG+s=;
        b=J2QPCQwoQzZV/g7X/6BHpJif6dBwX1dXBsRVKz18ug9+/uaEsgiAv2Aupyjhy1gNW4
         WnAo9zA74I9hVqOcjXv19lJ2UkTiagnI2f/SPiSW5TuqWyaACigxOg/aCp6N+gXfKNQM
         S09UTTPTjCYJbxbcQBZoh2Un+zilCkcI9PmahyASmZ/1+12CLHHGNrP7Vc0iMfqBtkIe
         rLGkB3Z/vZ8Kxcx/8WBKdaEZr9sr1nPEVcDzFZVeAcCQrNmN2nbufs86TEVnsfBH1TpC
         YtPwbk8cyzz/XbHm4yS6YSYajanZuUDr6d+ceGb1n1xoAFKLJo26vcokTmiLfq1+G6oh
         Kt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF6kF1o1a7cu8qLgevPU4rykmBSUA6+nY/q/8AQKG+s=;
        b=5+t76YihrIjqIniMR3JllOk+gamHQQPJoELaW9PdPYCvih6RRX71Mv3dg0BhMJXo/Z
         tEl8cx1FDpy+wUAT8D1FDNquZ/WI8+PuLFGLr4/orw6VaGE34GK9tlIRldu414/1peBd
         WVF4TW+nLc8XiNe4Cd7pVGfnboVJgEZVH0T2KfS9j+oIpDqxGrnVhf17bhXCLIbBZzq+
         Sq75SRpq1dXQ+ZXj5K84DRvvxAwsv674N8TjyyoZcrz3WWEBqtiCvvHd//u5JinGISDS
         MXWul5kxkKTK91Q/FqCKxbJ7Hs/7H4SFPHa5V4N9wfs6frmsxUymRNBgQ6UnjoSkWTag
         Nkkg==
X-Gm-Message-State: AO0yUKUXA3JBa5MhZoAEnYxwFccYn8ipJ4xFE8ypZyITex228uQlyaMH
        MWg+DzB21yxDooBkG3vT0C39pQ==
X-Google-Smtp-Source: AK7set9xRggsNfxxmQrR3m54yS4IVWcKjDjcEgoObH5Xno7a4mIpVQm4JFF9+5fbYXFD88l9WZ2J1g==
X-Received: by 2002:a05:600c:a0a:b0:3ed:2105:9ac6 with SMTP id z10-20020a05600c0a0a00b003ed21059ac6mr26330403wmp.28.1679309667180;
        Mon, 20 Mar 2023 03:54:27 -0700 (PDT)
Received: from sky20.lan (bl20-118-143.dsl.telepac.pt. [2.81.118.143])
        by smtp.googlemail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm8561969wrx.97.2023.03.20.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:54:26 -0700 (PDT)
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
Subject: [PATCH bpf-next] xsk: allow remap of fill and/or completion rings
Date:   Mon, 20 Mar 2023 10:53:23 +0000
Message-Id: <20230320105323.187307-1-nunog@fr24.com>
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
At the same time this would disallow the remap of this rings
into another process.

A possible use case is that the user wants to transfer the socket/
UMEM ownerwhip to another process (via SYS_pidfd_getfd) and so
would need to also remap this rings.

This will have no impact on current usages and just relaxes the
remap limitation.

Signed-off-by: Nuno Gonçalves <nunog@fr24.com>
---
 net/xdp/xsk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 2ac58b282b5eb..2af4ff64b22bd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1300,10 +1300,11 @@ static int xsk_mmap(struct file *file, struct socket *sock,
 {
 	loff_t offset = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long size = vma->vm_end - vma->vm_start;
+	int state = READ_ONCE(xs->state);
 	struct xdp_sock *xs = xdp_sk(sock->sk);
 	struct xsk_queue *q = NULL;
 
-	if (READ_ONCE(xs->state) != XSK_READY)
+	if (!(state == XSK_READY || state == XSK_BOUND))
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

