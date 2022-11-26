Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC53063958B
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiKZKyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZKyQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 05:54:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246B19284
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g10so6010422plo.11
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLdaMJYFMRdixiJx9gQFW3gfc6DJNc59TlD4HEW2hj4=;
        b=eKNaMZyz9RjOhHKnrAEsIdExsHnr1wY5X4PSfbnRZTzFfOqaTQ4ip1NPPKDEH96qDO
         N6eJcPaokzZofwMBmOSaYWZev5mgSZwHWB3Qm8sXM3Oy+NMc+iyup61dbu0FBgiwkSIs
         GtP5WgaICO/4FdoTyXVIOE6dxyqWz+0BBiwc080C9bruicVA+KRz7vrNRRbohi3WKIsq
         baxGE62gyjujlB/3DANgud/sV+RpbQfedREvKKlcucQhhKU+HkBEY3U8tUey2r5W+JhM
         Szu4gWwGYtjOXp/D+oRX0fI+OHLqZyEtxgEM/F7gORsd7Ll/lZwcUP/XVPy7+acsHBMF
         t07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLdaMJYFMRdixiJx9gQFW3gfc6DJNc59TlD4HEW2hj4=;
        b=uOw2q2ueJhMnyQJJ94VMv7mi32z9eN11yniEx0TjP9LnrPVtJfGvm2uXMTortsOgbe
         xW3AEc+rOCBRC3vtR3k7+miyOC8B+NQHH0LZVEXGA/eb9LXIdvRdL63K7sq3TJQrKDev
         29i2CvfEkw+igJoKhG7uowV8lfsZuCw5jbTGG80f2Dh3IB6W4JJVuE+J2pCCPaXNSrWI
         vH80y53Eeiv7qd6pJz0NYeQkPDZJjfftIQyIL12zCrsSRH/TjoGV6HEK6SVqanF+0F/q
         1puMdIs8Qu1oQexg/7/sCJsDjd2KwnIsdQrU6P1ce+8P8RgPyZb8BMTaQlszBSM0GKUl
         GrrA==
X-Gm-Message-State: ANoB5pmM+cGRmNUUsY+lRazIpwZPyCjTROpu/zeNyEVpkq2zXHRMAXCy
        6SLoyV5G7V4BfefBO1RaBKGtnAq6tXE=
X-Google-Smtp-Source: AA0mqf5YyUQPeRycRHZClomlkjVsk9Nlt6apgjIW9I4o8lKGNyE8K3WXFOzUE0zWIaWc7t2pdJc+Aw==
X-Received: by 2002:a17:902:e74f:b0:186:61fd:7446 with SMTP id p15-20020a170902e74f00b0018661fd7446mr32288998plf.150.1669460055320;
        Sat, 26 Nov 2022 02:54:15 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00188fdae6e0esm5079904pla.44.2022.11.26.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 02:54:14 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com, toke@redhat.com,
        hengqi.chen@gmail.com
Subject: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map value have timer
Date:   Sat, 26 Nov 2022 18:53:50 +0800
Message-Id: <20221126105351.2578782-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221126105351.2578782-1-hengqi.chen@gmail.com>
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
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

The timer_off value could be -EINVAL or -ENOENT when map value of
inner map is struct and contains no bpf_timer. The EINVAL case happens
when the map is created without BTF key/value info, map->timer_off
is set to -EINVAL in map_create(). The ENOENT case happens when
the map is created with BTF key/value info (e.g. from BPF skeleton),
map->timer_off is set to -ENOENT as what btf_find_timer() returns.
In bpf_map_meta_equal(), we expect timer_off to be equal even if
map value does not contains bpf_timer. This rejects map_in_map created
with BTF key/value info to be updated using inner map without BTF
key/value info in case inner map value is struct. This commit lifts
such restriction.

Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/bpf/map_in_map.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..0840872de486 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -80,11 +80,18 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1)
 {
+	bool timer_off_equal;
+
+	if (!map_value_has_timer(meta0) && !map_value_has_timer(meta1))
+		timer_off_equal = true;
+	else
+		timer_off_equal = meta0->timer_off == meta1->timer_off;
+
 	/* No need to compare ops because it is covered by map_type */
 	return meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
-		meta0->timer_off == meta1->timer_off &&
+		timer_off_equal &&
 		meta0->map_flags == meta1->map_flags &&
 		bpf_map_equal_kptr_off_tab(meta0, meta1);
 }
--
2.34.1
