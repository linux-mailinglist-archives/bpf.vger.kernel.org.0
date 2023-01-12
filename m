Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C6667A2F
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjALQBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALQAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:49 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121163CD
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:40 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h21so16647162qta.12
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5Uabr6rMB0Xp+uFEKRqPdRCxhNWiBeN0NwYKLeAixU=;
        b=IZZcCnX8wvwbpWe4gRFRcNAA8cfuZZ0wsr6T2tk5JqzyUrWoECk/4yqCErfaMsazk6
         N7DKy/pwRR8tik0IPz2om2ZlUpPenM3WYjJKSGh/XM0KWou/YEj178TroQUGudA3Gr/0
         A+wXOR5mzYBFFtuLD/Xyosv98vs84h0GPrJUuURrbn0BVmnGez0uawzzxWR/bhJ3jYWF
         oncdliudHrevq3hyfaG8LM68B4V9wn4EXhKt8v+tGioF2P21ja/ntPiVXqNgI3SYQF1m
         hXMe2o3dK6RgqFDyGs5TPySYbn19i6IgD2uZok0X+D/OLeRK3WA7uktdtx5xsJDT4zhY
         ZcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5Uabr6rMB0Xp+uFEKRqPdRCxhNWiBeN0NwYKLeAixU=;
        b=32vMle3w4gRruGwO8qQTiMMhziNt/l2BC4lfPvdWZFRyuLlbr8ifUDJgJtCTQrrT75
         fYRYaOHsNOykVBU+yMZUsOCUwBZyve3vRAEJO2VXEesXt0VJPvvQxPqHtW39HuOAhP2R
         IN8zUf87BAAPmpFwSPk/2JKNZk9pUG8hdzOyUBGyDjEnH1STp/N7KnigsQmCmXC9eVyN
         AY6wsGjMqhdhW9n5/4HFz4ferH1EkJ6csZcw/F4Y5u1R5b0QvgG+SZmA2/5Fr5SUVZKm
         Lj2Tx+6pECiEorztDjwbbURwcqwEX+k0R/yqgAX1Bxji8wxPou+bafoI/zPMCyzkOvXO
         GRaQ==
X-Gm-Message-State: AFqh2kpsJB1CeymVAQekCsw0lWwQftV6drJY9Kq9Ti7kFytLBvbi+zfl
        3xARM55u6jpQpSl8/ZMJ8YM=
X-Google-Smtp-Source: AMrXdXteMaFBBBox4hoGYeP7OQ1QSvsy+19+ts6oymG9XgnQ4GKqRTiAV+vZ7JEEP0SB0OSyUI7vXQ==
X-Received: by 2002:ac8:5197:0:b0:3ac:940c:6a6c with SMTP id c23-20020ac85197000000b003ac940c6a6cmr22208861qtn.34.1673538820190;
        Thu, 12 Jan 2023 07:53:40 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:39 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 05/11] mm: vmalloc: introduce vsize()
Date:   Thu, 12 Jan 2023 15:53:20 +0000
Message-Id: <20230112155326.26902-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a helper to report full size of underlying allocation of a
vmalloc'ed address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/vmalloc.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48a..52f925f 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -297,4 +297,19 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+/* Report full size of underlying allocation of a vmalloc'ed addr */
+static inline size_t vsize(const void *addr)
+{
+	struct vm_struct *area;
+
+	if (!addr)
+		return 0;
+
+	area = find_vm_area(addr);
+	if (unlikely(!area))
+		return 0;
+
+	return area->size;
+}
+
 #endif /* _LINUX_VMALLOC_H */
-- 
1.8.3.1

