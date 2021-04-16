Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB18536246C
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhDPPst (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhDPPsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Apr 2021 11:48:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81BC061574
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 08:48:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w8so15134778pfn.9
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snO1eMURjSJggbybW2/l1uxv+Il/Xq8PahjDj/Q8Vg4=;
        b=TkrXWqCsh+yxi0yTrcUf23w7/2UVhXtTjDIAVEfEr5V3pTWvlUjLHeTjs4eTTC0xDi
         UGmydNNsnLLJW6x2/HbhDEqkuHMZj69uq4grz8+pEd01UaWmn+AdlD94lqs0qDYCiqdS
         r4t+JgZ9MdFQhyPk7McKU+lkWd15xthLgCstoZOjMpqviCIQlS9AtpdinEPzMnqE85tc
         fd2XB+dVy1YpPKj9yFXAcApAOHOaGQBausXgsiEb+eAFo77UUqB9nzDJmdU35c1SpWSV
         ULFnPgGnTdpxnBfNMcXIx1GKZ15pn2VMZmR0U18fANtkCtih4GY+7UnCqi7Pq8UvgTQ/
         YuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snO1eMURjSJggbybW2/l1uxv+Il/Xq8PahjDj/Q8Vg4=;
        b=aGQny8huCf3bn4j0saUwqaqZ/5ireTzPo12JEPEt4lkIKl+pA97jATxP0uYlwRHns/
         7CrMlFsGBCoNZ/1mTTAB+i4yGXhtW6JrT9zlIFJQbF6N29O1JeOF/8UjQl4UVGC0pJ+B
         39v1UW/z7ZFcrzTUEiWfyw5rps3RIbpthf7lA+T7prfjjoqhwr948c9kwNJl0plEjbVB
         HGz0EcLGqKtSvlsTeq0gNYOOADllc0mClts1lMD7/49bee3ywUzGZRBvrdr9ORMbCIgu
         fgzyQkNvKGIjTTD3qIpbmhchrYfGRQ+Wjx6RFOfJ2mEC0rFDo4R1M9GPA1jVX1ITMHF4
         i5MQ==
X-Gm-Message-State: AOAM533aZOyDAuEYDY+Xa+YHXcJ97+cPx4DZ3kCWwAzU9ylnatDcSqbP
        UAo/Igh0zkhF5bW2xTbK6l8=
X-Google-Smtp-Source: ABdhPJwwqm57e0tQ3kM0YOjAjCgdFxvuVUnZl10g5I/zBM2mUP3qiNXbhgGzYocTtXRwwqZ0mnv+cQ==
X-Received: by 2002:aa7:84c1:0:b029:25b:75aa:1e7e with SMTP id x1-20020aa784c10000b029025b75aa1e7emr763922pfn.69.1618588098888;
        Fri, 16 Apr 2021 08:48:18 -0700 (PDT)
Received: from instance-iu8rspk4.novalocal ([154.85.41.57])
        by smtp.gmail.com with ESMTPSA id g24sm5743578pgn.18.2021.04.16.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:48:18 -0700 (PDT)
From:   Yaqi Chen <chendotjs@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, yhs@fb.com
Cc:     bpf@vger.kernel.org, Yaqi Chen <chendotjs@gmail.com>
Subject: [PATCH bpf] samples/bpf: Fix broken tracex1 due to kprobe argument change
Date:   Fri, 16 Apr 2021 23:48:03 +0800
Message-Id: <20210416154803.37157-1-chendotjs@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From commit c0bbbdc32feb ("__netif_receive_skb_core: pass skb by
reference"), the first argument passed into __netif_receive_skb_core
has changed to reference of a skb pointer.

This commit fixes by using bpf_probe_read_kernel.

Signed-off-by: Yaqi Chen <chendotjs@gmail.com>
---
 samples/bpf/tracex1_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/tracex1_kern.c b/samples/bpf/tracex1_kern.c
index 3f4599c9a202..ef30d2b353b0 100644
--- a/samples/bpf/tracex1_kern.c
+++ b/samples/bpf/tracex1_kern.c
@@ -26,7 +26,7 @@
 SEC("kprobe/__netif_receive_skb_core")
 int bpf_prog1(struct pt_regs *ctx)
 {
-	/* attaches to kprobe netif_receive_skb,
+	/* attaches to kprobe __netif_receive_skb_core,
 	 * looks for packets on loobpack device and prints them
 	 */
 	char devname[IFNAMSIZ];
@@ -35,7 +35,7 @@ int bpf_prog1(struct pt_regs *ctx)
 	int len;
 
 	/* non-portable! works for the given kernel only */
-	skb = (struct sk_buff *) PT_REGS_PARM1(ctx);
+	bpf_probe_read_kernel(&skb, sizeof(skb), (void *)PT_REGS_PARM1(ctx));
 	dev = _(skb->dev);
 	len = _(skb->len);
 
-- 
2.18.4

