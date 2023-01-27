Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13067DB67
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 02:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjA0BrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 20:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjA0BrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 20:47:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1C42BF3
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 17:47:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jm10so3548257plb.13
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxFy0JRU8uL8/rOi3jW12GL9Gke2dwwegoNaq3ekEl0=;
        b=Rn4WPmGZRuE5J6li0UNnrvAvQGRTeDGR6jAyLLcRG/SUx18MtZ/s+yfIx8btUXIip/
         C8FNxTmNVSqrwERgdBUbcofAdAuared74vI0g2oVrSi5WwhFYn8CYLigvi5eY/MxNf+B
         azxvaVwEhlPg3Ivp87+ZP0sDTgzNYKSzBKoIWm27Wlfkmz0foqCmxWNv+sMkzlwZ7pHG
         By/SBe+dgoPY9dYfI2okm3JfUuApG9LnMShkOQgI4S+w+yAEWUxHETN1dfwth1+xMjt9
         GYAV9kleiSKy5VSMlH6DZgPiDzn647cCnejULT+JMF8XxpRcB+xWhY8KZrYn8mmOl7iB
         unJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxFy0JRU8uL8/rOi3jW12GL9Gke2dwwegoNaq3ekEl0=;
        b=MYj1GZx9Nxika2qVadslYUVkmkPj7HheAjWuUNYai+2iEfTNXDqmfY9z+xlq/nvEZk
         /T3fIMIlfNHm08TWLk2Ac++haq93uKskhhLNxI5MeeWZao+XOc2X4d+/yoI+xjjpxz9z
         T7O6TtwypClmCR2E171TVAbu8ts8HPCIq5Q7rELZEe0Wkar6LFNNs4kPX2sCNNd3N322
         f4hhJMYUmRHscb5ePoyLiAMICAKW3xVpttEfI4R8hXo2+PCDCjxBz4QH5fjeJ/vsF848
         YV/Pv82i3odjYReeTsOaVvJpc9OgUPk3eQveDOS2E7U7tMj+7tewaNQrdXWQf4sEyypI
         5zIg==
X-Gm-Message-State: AFqh2koZmAiJgsA3nmiS5zLd8MrXMoX5TaovKZespLLkXEQ8ur4Y85OO
        AC2VP1sJcy3AfwmNXTTwAnk6C8OvcGo=
X-Google-Smtp-Source: AMrXdXspF5Di2GnpOwsvf0pV0BPsE5R5mUpojWs2HWbk0LsV7KTTQBgIEppZNl4sohO8hP+wOEVT6Q==
X-Received: by 2002:a17:90a:77c6:b0:226:3f8:5b78 with SMTP id e6-20020a17090a77c600b0022603f85b78mr39474362pjs.13.1674784032678;
        Thu, 26 Jan 2023 17:47:12 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.11])
        by smtp.gmail.com with ESMTPSA id mp1-20020a17090b190100b002298e0641b6sm4008847pjb.27.2023.01.26.17.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:47:12 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Add note about type convention
Date:   Fri, 27 Jan 2023 01:47:06 +0000
Message-Id: <20230127014706.1005-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <Y9GPssH+6Yo5/MY9@maniforge>
References: <Y9GPssH+6Yo5/MY9@maniforge>
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

From: Dave Thaler <dthaler@microsoft.com>

Add explanation about use of "u64", "u32", etc. as
the type convention used in BPF documentation.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
V2 -> V3: updated commit message to respond to David Vernet

V1 -> V2: addressed comments from Alexei and Stanislav
by using u64 instead of uint64_t
---
 Documentation/bpf/instruction-set.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2d3fe59bd26..77990c97b5e 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+Documentation conventions
+=========================
+
+For brevity, this document uses the type notion "u64", "u32", etc.
+to mean an unsigned integer whose width is the specified number of bits.
 
 Registers and calling convention
 ================================
@@ -123,6 +128,8 @@ the destination register is unchanged whereas for ``BPF_ALU`` the upper
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
+where '(u32)' indicates that the upper 32 bits are zeroed.
+
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
   dst_reg = dst_reg + src_reg
-- 
2.33.4

