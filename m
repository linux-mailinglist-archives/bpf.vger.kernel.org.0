Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD25BDC4C
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 07:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiITFVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiITFVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 01:21:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AC7558C8
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:21:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l8so1053728wmi.2
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=a8YXF4FkoK4BVn3ip9rlUtWQPJoXHaS5Sh7vR1MqvPE=;
        b=WQmhzGMxqT4k0MzVa39wjOjN6R1nS4Ob/3kNG8TNGLSXt9PSeb2c6blJWFgxQBWMEE
         C23t1U2Ydi8xpeQd79xyj1NUKN159B4wlJ0uql9e2c1y40fAoftHrIB4P9nJiAzIVpEc
         7KIA6DDvj+g/2roQOyKEVsyV7TlelJzIbRSk6VdPWqmoqXMfhWm+sQJbsIOAlZ52A6TK
         jXJGpUp6Cj/yQuc7aLBdKwq/c1nHMFHqnRUyvjANVydqd1waFKYVClY2XDHkhnRFCUpI
         4mewNeL/RCaxFggAbnK/UfVspoTujKPYBB0HUdCmdO9TLqeLGv9Op2btNtAN5yn6WX1/
         o9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=a8YXF4FkoK4BVn3ip9rlUtWQPJoXHaS5Sh7vR1MqvPE=;
        b=bdK0DZCYgh4/oq/pnt9MRB0eGUZaZ32Ualx1tDDTyzJ26hWfaVkKIa6+gHw3zNEiKv
         kI2M9i4TPkrhrlRASqdWJ8sQM1oCubBl3d5poSGZaayOfswjAHoz3QzecCO5dM6iSQL1
         HzUx9JhwIvgR9TJi2sL+cc/HwtWpBW5uCtAO2G6bE4brTbMmuzwo0rweH3F/kile4n1o
         DoLdIOHToa1/4a2DalnmzBdby/uQr2f18Kb4TDL0Gfm+vW/L0BdZeRuhk50U4qIgI3M0
         ddALYC53hk6fQKULZ2yV8SPnA7MRNyc86fv/7KAVq7ZmMNvoiELb0wSv80CsCo6omuAZ
         WRHQ==
X-Gm-Message-State: ACrzQf29d1sqkROwp9PM6WZ13oVATfBCd4y09Tuk58kkBey0JGissIGN
        rzT8X2/wyqWQaMNowK0BG0291nFvypY=
X-Google-Smtp-Source: AMsMyM4tMNmk9qzQ0VFB9tQwZPblgL5ica1PQNeJhq5B5Pi13OBZ1UM1aYqDsZQrO91xFDkbaF/Hmw==
X-Received: by 2002:a05:600c:42d4:b0:3b3:3de1:7564 with SMTP id j20-20020a05600c42d400b003b33de17564mr969875wme.152.1663651260066;
        Mon, 19 Sep 2022 22:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c3ba100b003b3401f1e24sm827063wms.28.2022.09.19.22.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:20:59 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf v1] Fix the case of running rootless with capabilities
Date:   Tue, 20 Sep 2022 08:20:45 +0300
Message-Id: <20220920052045.3248976-1-arilou@gmail.com>
X-Mailer: git-send-email 2.37.3
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

From: Jon Doron <jond@wiz.io>

When running rootless with special capabilities like:
FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH

The access API will not make the proper check if there is really
access to a file or not.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/libbpf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..df804fd65493 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -875,8 +875,9 @@ __u32 get_kernel_version(void)
 	const char *ubuntu_kver_file = "/proc/version_signature";
 	__u32 major, minor, patch;
 	struct utsname info;
+	struct stat sb;
 
-	if (access(ubuntu_kver_file, R_OK) == 0) {
+	if (stat(ubuntu_kver_file, &sb) == 0) {
 		FILE *f;
 
 		f = fopen(ubuntu_kver_file, "r");
@@ -9877,9 +9878,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
 static bool use_debugfs(void)
 {
 	static int has_debugfs = -1;
+	struct stat sb;
 
 	if (has_debugfs < 0)
-		has_debugfs = access(DEBUGFS, F_OK) == 0;
+		has_debugfs = stat(DEBUGFS, &sb) == 0;
 
 	return has_debugfs == 1;
 }
-- 
2.37.3

