Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28425FE3B8
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMVHQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJMVHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 17:07:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F33183DB8;
        Thu, 13 Oct 2022 14:07:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy4so6565008ejc.5;
        Thu, 13 Oct 2022 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ5njUsMjpaWj9YOz1Vm++un7O5+eC1XTxzvAZerpow=;
        b=faWAR8yx9y/ximCfiagbNCy/0PAKrBsY8wEvnxUxd7VFrwze8WrW/LXuOEsD1B1MgC
         bmzapz1zdHF1jE76T+mA54DNMXKki/cswG3sXkx6RAEOiC9LYHXvBWUkBqkVC/OutC6w
         TBoPedYKZEP4+ld5ZJzts0nQv+3AjeM1WBzF9oIZsaGYMjz2koC525mlMh4cImsSStp6
         XSWzJkXeoFofq4dZ0tkjtoHD4Jl4nliDAg9B+Vd6RKf38AjPS//hn7h+QcZjjgk0xM+g
         X3Q+S3ElOX8GsPkSJbBAoFNFKK+vjKbNMwCVHL9RQlOConV4BRjaHXXF9yIEoDbdhF1L
         19Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ5njUsMjpaWj9YOz1Vm++un7O5+eC1XTxzvAZerpow=;
        b=JrAgMraWu9PHel5PSEmuAjHc+NRsWwuD5UjI2njwqbWzvA1+e+qRablmULnEt+5Ehp
         HVGYkMUYyOW1hDjuHGuAQjSQJkPbF1QiLhlrogPEL8xKnrQExHCQiDRtO1DN+OBi2BXt
         qDsbCCFE5ZNBxqFZq54bz9kna9uqR42Z2fmurVJXB620vharTvZtAS2FVXUGPHIuhcfm
         93hDFB+BoMfZ6G8MwfkRUbHSm6zc1hpn2gKKiorhmkqWzbtepSYpQ1vBzMYgM821anga
         empHjWbIPb67nKnpc6DatZaZybQsGlwQQpQ8vgBhA+9JXm+rsnFdGFSpoSY+TZf9pCIk
         ZXqw==
X-Gm-Message-State: ACrzQf0sAnlrVlRbJntAcXjAF0s/AnFkWJQzhhqYZVhgJuFDmXtQnrL6
        INeu+/dGUimt90HmsPEbeoA=
X-Google-Smtp-Source: AMsMyM4cU3vLsTSiWCSsbEcY7UV+UJBrC5a07f1dY57EL9s1EUxZ5n3i98uvEdXbgJXpbA6zfUHWAw==
X-Received: by 2002:a17:907:980e:b0:78d:b6d5:661e with SMTP id ji14-20020a170907980e00b0078db6d5661emr1253849ejc.46.1665695233566;
        Thu, 13 Oct 2022 14:07:13 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id v25-20020a17090651d900b0078da24ea9c7sm443973ejk.17.2022.10.13.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:07:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Date:   Thu, 13 Oct 2022 23:07:14 +0200
Message-Id: <20221013210714.16320-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Therefore, replace kmap() with kmap_local_page() in radeon_ttm_gtt_read().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index d33fec488713..bdb4c0e0736b 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -869,11 +869,11 @@ static ssize_t radeon_ttm_gtt_read(struct file *f, char __user *buf,
 
 		page = rdev->gart.pages[p];
 		if (page) {
-			ptr = kmap(page);
+			ptr = kmap_local_page(page);
 			ptr += off;
 
 			r = copy_to_user(buf, ptr, cur_size);
-			kunmap(rdev->gart.pages[p]);
+			kunmap_local(ptr);
 		} else
 			r = clear_user(buf, cur_size);
 
-- 
2.37.3

