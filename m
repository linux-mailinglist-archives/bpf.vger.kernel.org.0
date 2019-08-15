Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C28F60D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfHOU4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 16:56:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39413 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbfHOU4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 16:56:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id x4so3413347ljj.6
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=205QOW+yfCAbUC7sqLeSze+Vg1m2Bj7bh4Zpv9ddbPA=;
        b=aHSHLFL2ibBV/js7b7q+6nct87exfpVR8oXwxPxV1O3q6wd5IOfaorpO5msfvRyevT
         nYKoDnt9kqYmiQu9PjsrPREPSVxpT9OzKTUoF3JQdooYysuqXafyRNzG7iDVEFoE0IeS
         3ZoOHiiqJprJgUr8Tfrc/9AbsMPLPS0kBBA/XGerv/Vt/XOsD71F+/3fM9gEBNUCWZAk
         65kZb29OLfGg5zb6VfW7gyr4F/F42sB/LPn1fUg0usLHPPnJzxH+vgNnMrCd32OsCh0f
         AsVZGyYS1Hp9/Ychz/oDWhBSoli78rvDYq7YI7yYJHv7gCl/+GTOkq96i3FHnuHbFrLk
         kNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=205QOW+yfCAbUC7sqLeSze+Vg1m2Bj7bh4Zpv9ddbPA=;
        b=ZjPyuXXvkaIsgQL+hTfCV8OI93gTFpySXYcXoIs3cjx89PBjqvjy8Ow+HGwQYWGbzD
         /g/dji2PhggxxfHuXZZpli06NrbQazTRH07A4jplMhfQoETLC4bSt6x+QFRSyuuKZEpo
         dDsziMeQpbEQb3P0RGJeB4l+Hk5+w+3Ts6Jqta6P6hp5FQzafUJcRU/mh2iyWY/AauFT
         mZD4W1DOl2lWyN98XzYvqSRUv9g6DltlQRTB/+rQlBMaWe7CjiLHQ5hCOLgudNrID9fr
         Ezx0XYRZQXK6JXvYfjx0yVwcpxsmyIJu9yeUYpvxnSqtnUjHH+fwagvG16f6MVkk0u+F
         BQ1A==
X-Gm-Message-State: APjAAAVzkrbLMRXIIVOMXo5ovoa4+vmtRsvZVXPnK3haQoDzhIEJ1uUw
        lZz4i5sLOxZJu/sJf0OshOSY0Q==
X-Google-Smtp-Source: APXvYqyuY8R61y7WvPEvbnEg7y6ACV3N9GK5MW1RpPiIpvbgr2NsI7s4+uvjBaACZ8Tx4DVi1QBdDA==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr3721390lji.174.1565902600461;
        Thu, 15 Aug 2019 13:56:40 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id j14sm651676ljc.67.2019.08.15.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 13:56:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     bjorn.topel@intel.com
Cc:     magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf 1/1] xdp: unpin xdp umem pages in error path
Date:   Thu, 15 Aug 2019 23:56:35 +0300
Message-Id: <20190815205635.6536-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix mem leak caused by missed unpin routine for umem pages.
Fixes: 8aef7340ae9695 ("commit xsk: introduce xdp_umem_page")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on bpf/master

 net/xdp/xdp_umem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 83de74ca729a..688aac7a6943 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -365,7 +365,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pages = kcalloc(umem->npgs, sizeof(*umem->pages), GFP_KERNEL);
 	if (!umem->pages) {
 		err = -ENOMEM;
-		goto out_account;
+		goto out_pin;
 	}
 
 	for (i = 0; i < umem->npgs; i++)
@@ -373,6 +373,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 	return 0;
 
+out_pin:
+	xdp_umem_unpin_pages(umem);
 out_account:
 	xdp_umem_unaccount_pages(umem);
 	return err;
-- 
2.17.1

