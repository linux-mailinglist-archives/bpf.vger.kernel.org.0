Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0206EA26
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfGSRbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35034 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbfGSRbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so23847514qke.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VfBYKXGqMN603JK/mOP746M3s/e0VEm3g6mJUQVwPg=;
        b=cCEhw1NfdSLPAkIExliXrXF1MaxRBVWKFBguxs2EyW8mkbFLGzfsPqiIOQSTRW9zUp
         p6ZqMNED7AnfuqGLyfaV6rM+bn4dVbZX/BqV6btqOEHFWp7eMfevRrGN+CLgFdjIn1ZU
         EcHyFTn3wZswOmsdlbycd8GxD5GlbgIhvftgi69p1TpOv+SBJngMuM1f/UKTS9+3iXj8
         RHaLofgf3/bPPxdxK/YLL7ViQ5FFZ4lGVQy6hOalwQ/ex+iuhf1IIQSZqYw4hmybj4I9
         VQvgJC+XNafRDeiaQpTqa5XlZe0dMw/JSSwpzqxSVI79Bna6sAWtH0MjuydAwFFs07Mh
         NpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VfBYKXGqMN603JK/mOP746M3s/e0VEm3g6mJUQVwPg=;
        b=VGI0QCiEHdTke7EB6d96huawm7f+2AJ7xEIDUmrNtBwdzIIekbl5sBMd5sf1plSMBq
         g4xkPufSPlLPFFPNuMEAXnq2bVhjUzkY1ggrjDUxYI6UpXYdPXqp1/eTrbU3bsNlIsPM
         INcv7zWdVxcmkgScSIL6taLEH/cPKs5gV/OSVBQQ5s8uuVuVvD3N4zeB7ZHl95l+7wd8
         rmmyIMj5q/wK6V7Wj5j1DHJHFgoZ35JZTs3qi1sLbVs4FPcDEqvQgueA4pDRfgUqk82+
         bu4X5GTkB46N9RdU4bDib5ie5okB5kCSGm8cqEWmIShCq1J6NZlcdTFJEucda9QUaY5N
         i6fA==
X-Gm-Message-State: APjAAAWtdOGwBSLzKobPvEyEv1ZIZaT/PfpWBr+tb4IPNsY0eVbxL/lC
        exbEiIEfbEQ1TTffCqts49DNHg==
X-Google-Smtp-Source: APXvYqwOpDCkEuRPMUtRhYP7hvcEZYVKI21TlNIcPKPrM2GMACY7oRN1w2xZtybC9l0m+JRYvlBamQ==
X-Received: by 2002:ae9:e202:: with SMTP id c2mr33533918qkc.15.1563557470634;
        Fri, 19 Jul 2019 10:31:10 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:31:10 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf v4 07/14] bpf: sockmap, synchronize_rcu before free'ing map
Date:   Fri, 19 Jul 2019 10:29:20 -0700
Message-Id: <20190719172927.18181-8-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

We need to have a synchronize_rcu before free'ing the sockmap because
any outstanding psock references will have a pointer to the map and
when they use this could trigger a use after free.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/sock_map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 28702f2e9a4a..56bcabe7c2f2 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -247,6 +247,8 @@ static void sock_map_free(struct bpf_map *map)
 	raw_spin_unlock_bh(&stab->lock);
 	rcu_read_unlock();
 
+	synchronize_rcu();
+
 	bpf_map_area_free(stab->sks);
 	kfree(stab);
 }
-- 
2.21.0

