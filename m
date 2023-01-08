Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2AC6617FE
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjAHSUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAHSUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 13:20:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021921DA
        for <bpf@vger.kernel.org>; Sun,  8 Jan 2023 10:20:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso7414812wms.5
        for <bpf@vger.kernel.org>; Sun, 08 Jan 2023 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tPoncGXTLNRxdDVgMHCAQCttzuU5+X9I7EJBTDUues=;
        b=LGMqMb9TIsPqUco6O/LdH34tw+Q1kDY9w5xEHdKMG4bHEIa7rzqQyr79Z/6iZIWX9T
         MaKMdwK1RlqjfeGTvhCOHT2OOW1mK2OdNCpMzSLDjOLLyCd+mQyULjtdoIu+BapyKNs2
         sdnvt5qo6rbgscqfeX7wDbOlTGX/GsXaP7rGzn7CUHypt5JGkxZFuIa/r7SlheQ5zGPg
         9l3VAv1+EEjvf7Fe4ZmC7Yt2OxSaqi+rbRmewQ3ZxOsBKzIiNpMXFByHrmnRCEBgFJQs
         PLj294fjcKnKs1Ecek/rFYVQ1dS5+lpSBFucNKoBlkh8QqELtj3+dODBcJBp5uH9jHlo
         lboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tPoncGXTLNRxdDVgMHCAQCttzuU5+X9I7EJBTDUues=;
        b=RyajFJTnAWYEaNxR0L3x0cIrZzu1p1FGnFKH80Ei45H+o8sHMnpItfpJQP26ShGAt8
         bbkW3kRvH3RZepE9KTXGXYyfE0LXtr8rneI/2UH7dZw6vIsNUzR2uzbO+yk4GQLvXClE
         CkTQgSCbegaTNWD1wulbKuFLXXjh92ajcpB3/4+QPEWin3e2Beg4RtOwRCcNdwbSmnFT
         f9JIzvr3Gu1O0Ql2m17a6OBAcFSXnAp7p7YNuM6UVUX/ZQuPNN9MZpzFq8sZSs4ppdmh
         Pocd0i+BoQLoQ01W9pVjpKqlq04Wcbw9H084CUUmX7EsI2fqVg5BYo0yNHL2wTelF50b
         5nkg==
X-Gm-Message-State: AFqh2ko9Kckty9USCZzlHc6aHvBvhY4dRIwiQqkyG6OEhdGfutUtdity
        haFtkkpTxfeq03WHQBrdfeM=
X-Google-Smtp-Source: AMrXdXvqny7SwFn8dljUGagiA2J2dUVcHX0kn78X4PtOKbRka8v0hX5qij8pa1GYZx5xwzZ2JzYhzQ==
X-Received: by 2002:a05:600c:3d91:b0:3d9:103d:9078 with SMTP id bi17-20020a05600c3d9100b003d9103d9078mr43278336wmb.22.1673202021483;
        Sun, 08 Jan 2023 10:20:21 -0800 (PST)
Received: from localhost.localdomain (2a01cb088f43a50095017c09ef444c72.ipv6.abo.wanadoo.fr. [2a01:cb08:8f43:a500:9501:7c09:ef44:4c72])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003d1de805de5sm9937330wmb.16.2023.01.08.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:20:21 -0800 (PST)
From:   Ludovic L'Hours <ludovic.lhours@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org, Ludovic L'Hours <ludovic.lhours@gmail.com>
Subject: [PATCH] libbpf: Fix map creation flags sanitization
Date:   Sun,  8 Jan 2023 19:20:18 +0100
Message-Id: <20230108182018.24433-1-ludovic.lhours@gmail.com>
X-Mailer: git-send-email 2.25.1
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

As BPF_F_MMAPABLE flag is now conditionnaly set (by map_is_mmapable),
it should not be toggled but disabled if not supported by kernel.

Fixes: 4fcac46c7e10 ("libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars")
Signed-off-by: Ludovic L'Hours <ludovic.lhours@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a5c67a3c93c5..f8dfee32c2bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7355,7 +7355,7 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 		if (!bpf_map__is_internal(m))
 			continue;
 		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
-			m->def.map_flags ^= BPF_F_MMAPABLE;
+			m->def.map_flags &= ~BPF_F_MMAPABLE;
 	}
 
 	return 0;
-- 
2.25.1

