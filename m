Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9276F498C
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjEBSOh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjEBSOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 14:14:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA5E4E
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 11:14:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a26b46003so42048027b3.1
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683051263; x=1685643263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phucGHCFvDgwFvFJtwltySSux5cfdwdoE4uI3AyocN0=;
        b=LLnkvm2EY3MIohLGtH2TtsIhHEX4QYQeOPf0yfSPeqTcz8P8YsOURf5RH0zvrJbwMi
         ZQZgd1Ooct49lp5P9CpjqluamEN1OymqHo7HJxW7cd66KNPe1d3KM6QBNJwe6uOwCTif
         AckXPW2uhN3dSsEnYC81hXjcHX2DnHg+eQ9Q2VCUDi2kr2OpQRHPz/DfG5ARCQDVgwlW
         EEeyEKGc4kP1ALfmeYaCgNT/WudRA+vp6R+XJpnI7RCyp3ti+lu1EnLZqoO6DyC7uzv7
         Qr7tt1HyS0yGapKxUsSjB4CdZLcT0acpNq9R5PGX+9nsSNcUgmKZT/eF+feXANzsqop5
         CQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683051263; x=1685643263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phucGHCFvDgwFvFJtwltySSux5cfdwdoE4uI3AyocN0=;
        b=QhKVwAUr1dSFkON3G8bQYCHlWwOCStNcMJrpZlx4C30VPVH3MD/4naeHKe6QuXOIp/
         Drp63cN7Gi0VWuRbBm6O6kzhxrLiOY1hzQ2zJf3DVgO6UlryCRCZ/sMSgxAj0YO3+ebb
         igh8R21k2bdopWElap4WwcaBxq8NtSbp65KrOpAH/yf0ghhwjgK20F5T68zgbKceZOtp
         BCKt4Hv+v/Ckc0FU5s/hPGOU3kjbvPH7q598G/nrSq9Y73i2aiag8hiB6zMfAoHi6xCn
         Dz6YTjaKJqRmGV3mmjAuUUZtALl3lqISsiuU5wpEKzEhPgnk8jkKKvb3QNvXYUAfJc7r
         gWrA==
X-Gm-Message-State: AC+VfDyJHlN7f6qwNbWld1Z0F7iJgg0a8h319S3mnjftCvK/7ZFOhDxw
        SGot/D3cZPB6Y/g0YERFGkJRK5VKytEHpA==
X-Google-Smtp-Source: ACHHUZ6DnXcHEVuVI+NIaaOLmcFcriIiaW+QGfBy2dHys0mHwm4THMQSKSD0K9KQN59gbk9EBQDk5w==
X-Received: by 2002:a0d:e2d2:0:b0:559:e54d:4dde with SMTP id l201-20020a0de2d2000000b00559e54d4ddemr12447581ywe.8.1683051262992;
        Tue, 02 May 2023 11:14:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:781c:6868:b580:4220])
        by smtp.gmail.com with ESMTPSA id r186-20020a815dc3000000b0055a6f26fbbasm1132808ywb.38.2023.05.02.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:14:22 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next] bpf: Print a warning only if writing to unprivileged_bpf_disabled.
Date:   Tue,  2 May 2023 11:14:18 -0700
Message-Id: <20230502181418.308479-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only print the warning message if you are writing to
"/proc/sys/kernel/unprivileged_bpf_disabled".

The kernel may print an annoying warning when you read
"/proc/sys/kernel/unprivileged_bpf_disabled" saying

  WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
  via Spectre v2 BHB attacks!

However, this message is only meaningful when the feature is
disabled or enabled.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573e..909c112ef537 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5380,7 +5380,8 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 		*(int *)table->data = unpriv_enable;
 	}
 
-	unpriv_ebpf_notify(unpriv_enable);
+	if (write)
+		unpriv_ebpf_notify(unpriv_enable);
 
 	return ret;
 }
-- 
2.34.1

