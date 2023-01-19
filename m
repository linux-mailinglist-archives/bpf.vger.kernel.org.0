Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E86745D1
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjASWWQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjASWVS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:21:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381B4588D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:04:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c26so2579059pfp.10
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRmLlu0v6eoknlC6zz3dfMB8QF9ZrXn8pgVWAlV4q2k=;
        b=cBptspiWq2AvF8T1Lo64EBDc1QrcJZkVCYca/eS+aWDYrmYKu2k1MpAGA+uaqTlaFP
         as3PJiOHM3LTI4Ox3V4IUar34z64BUMnly1D0hFVxmiNdh9qQuGqx/PdEzvSiC//CORz
         C0J3xe8jCVdZ+BRrHm25mT1b/3Etf7BRj/W75CnCIThvztc6m2EP0K8xp+OQiCRyDzZs
         f82OGhdSvaepZhsisQsNre+3sMl95HUoA2pUA6pfpPy79FaMUA6Y3V0EwmyJa3gTG5gk
         lujUy/kwC0pplKqyQL84zDSChs7PTEyJO8JXEPSMMJrE4X1563aY2FA9BdCRlo78fnXz
         /zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRmLlu0v6eoknlC6zz3dfMB8QF9ZrXn8pgVWAlV4q2k=;
        b=N7rIyTuspROVhTUqHZPOxGzE6mAGN1O4V+7Y4uWtfVqO7S+QG7JmHnLBkI+LY3HEkU
         I2PdLgouC/TSiPwySt2G/k+KOhXs2ASiqKjVNasLpivWp24wRu1cHN1EpkuzMujGfeLm
         N8IRLI+C8p1FiFPZoZFc2orroGBJxfdwndBWnoYelbu1entKGFZXc7Z2C6HEMfPlGUsy
         Miru8vwmw7/rZV2+kTqYz5oZJ53SGJILWvqLOo1bSbo+bo/JqkreGx9Zhp+nUex2tIZw
         MYpJ3f55uUL3MaGMOIu0lTFPDuZoDasw2+/1KBBbotyTxC4O2rJ1bRNmz+84JQp3AV6+
         ZQCg==
X-Gm-Message-State: AFqh2kpcnTVGm1nvBLUosb38updAPXUxHHQvCE7hBXTyZXyBYeOcydzy
        ubcH7QN6Drm4zMEMuxEEU7sxJguYtso=
X-Google-Smtp-Source: AMrXdXtvz+0r2HB1yiHitaXaWFxT9ozNm0hoGAqcyf5Muk00WY59zr2pAUGwCBU08IJUi4zqLp2qpw==
X-Received: by 2002:a05:6a00:3390:b0:581:c0ee:3a5e with SMTP id cm16-20020a056a00339000b00581c0ee3a5emr13746084pfb.20.1674165888831;
        Thu, 19 Jan 2023 14:04:48 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id w67-20020a628246000000b005892ea4f092sm20438473pfd.95.2023.01.19.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:04:48 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Thu, 19 Jan 2023 22:04:45 +0000
Message-Id: <20230119220445.875-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20230118152329.877-1-dthaler1968@googlemail.com>
References: <20230118152329.877-1-dthaler1968@googlemail.com>
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

Fix modulo zero, division by zero, overflow, and underflow.
Also clarify how a negative immediate value is used in unsigned division

Changes from last submission: addressed comments from Daniel.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..dd37cc5c0bf 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -99,19 +99,28 @@ code      value  description
 BPF_ADD   0x00   dst += src
 BPF_SUB   0x10   dst -= src
 BPF_MUL   0x20   dst \*= src
-BPF_DIV   0x30   dst /= src
+BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
 BPF_OR    0x40   dst \|= src
 BPF_AND   0x50   dst &= src
 BPF_LSH   0x60   dst <<= src
 BPF_RSH   0x70   dst >>= src
 BPF_NEG   0x80   dst = ~src
-BPF_MOD   0x90   dst %= src
+BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
 BPF_XOR   0xa0   dst ^= src
 BPF_MOV   0xb0   dst = src
 BPF_ARSH  0xc0   sign extending shift right
 BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 ========  =====  ==========================================================
 
+Underflow and overflow are allowed during arithmetic operations,
+meaning the 64-bit or 32-bit value will wrap.  If
+eBPF program execution would result in division by zero,
+the destination register is instead set to zero.
+If execution would result in modulo by zero,
+the destination register is instead set to the source register
+as ``BPF_MOV`` would do, meaning that for ``BPF_ALU64`` the value
+is unchanged whereas for ``BPF_ALU`` the value is truncated to 32 bits.
+
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
@@ -128,6 +137,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
   dst_reg = dst_reg ^ imm32
 
+Also note that the division and modulo operations are unsigned.
+Thus, for ``BPF_ALU``, 'imm' is first interpreted as an unsigned
+32-bit value, whereas for ``BPF_ALU64``, 'imm' is first sign extended
+to 64 bits and the result interpreted as an unsigned 64-bit value.
+There are no instructions for signed division or modulo.
 
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.33.4

