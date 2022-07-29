Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1677584B75
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 08:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiG2GNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiG2GNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 02:13:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED27C18A;
        Thu, 28 Jul 2022 23:13:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a7-20020a17090a008700b001f325db8b90so2876252pja.0;
        Thu, 28 Jul 2022 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bC82jqnlZyE9sFwaX+pW7l900XlAr1Ide/meMXZQ3zU=;
        b=efKYn1RFw4ObOgo+diWgkXAEUlt2BpQvDEJ/5tZwPH+PATP0+lrB8bossz0ofM0PqY
         l6XNhSMJGcl950L93pnsgc23tea4IInLNuv6G7BDEj5WiM72Kc2dOLMdRBHE9q4881+D
         qElUGYGTukPTUlEd20LZ3v7Eey5dLI6qOOWpAJqovTXWhV5Aa4bw4fneVYc6hCekuWpm
         TL08X1/gXWBDqqI3Bswz98nyv6AY2tnYtaYciovrohxZvrycDvtMxM5m36PJmPuTRhE4
         vgdQ19nEXoY/GPupGOfh9i9LhlJmGSuCC/DGH47vPj0/kA57Yf8w4kAaTX6hMcBLBlCp
         78zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bC82jqnlZyE9sFwaX+pW7l900XlAr1Ide/meMXZQ3zU=;
        b=aqzXRs3CkYsqbd6WZJVlznfUS6fdKNekL2fRsic6iHlh3Hjkhe3zuc9H15eCu4cEG8
         Fp72SA3ufn+YDE7LcXUMBjMLi4ZQW8CVV9LuTGuusXeXkkmJaCOEMUXIr/joIrzKnoDY
         2E8ID2ue3Kgob5Z8LYo/UjBu2QNE97a9VO4ZhOwF30DjRan2T0kEX7zJwt4BMlfRZMpt
         yMd+ZGD4ljalIxO824glEJ9qLyhkyBLNFM12yT78sBNzXix5pR9qfRqFm466Je8OkhqJ
         /bNXEoC5weCrqShGfxg0KsGSxHkwWc+9MO2uCDdR5cYFSCgqr9BIJr6aERjqIfNvR9bS
         LURQ==
X-Gm-Message-State: ACgBeo0tYZXZoNsUSxyPW0G9qxwGxgTThR/PWeRj09eE1goP/rpBuoQK
        juq9bVZj64+t2q5X4tSe+wM=
X-Google-Smtp-Source: AA6agR7rnSWQpFmI80wFZp4oXEFtiGZFlWfLEzTT5EkDlgqiJ+8Nw/w0TV0AqVLHRvbzuIfFtG5iUg==
X-Received: by 2002:a17:902:cccf:b0:168:c4c3:e8ca with SMTP id z15-20020a170902cccf00b00168c4c3e8camr2375160ple.40.1659075199634;
        Thu, 28 Jul 2022 23:13:19 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a400f00b001f2c22fa4ddsm4960511pjc.50.2022.07.28.23.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:13:19 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] bpf/verifier: fix control flow issues in __reg32_bound_s64()
Date:   Fri, 29 Jul 2022 14:13:12 +0800
Message-Id: <20220729061312.2157151-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

expression "a <= S32_MAX" is always true
1580	static bool __reg32_bound_s64(s32 a)
1581	{
1582		return a >= 0;
1583	}

Fixes: e572ff80f05c ("bpf: Make 32->64 bounds propagation slightly more robust")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0efbac0fd126..bd154bcf1599 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1579,7 +1579,7 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 
 static bool __reg32_bound_s64(s32 a)
 {
-	return a >= 0 && a <= S32_MAX;
+	return a >= 0;
 }
 
 static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
-- 
2.27.0

