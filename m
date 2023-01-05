Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAEF65F13F
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 17:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjAEQcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjAEQcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 11:32:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1A5D423
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 08:32:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so24831579pgm.13
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow2r2TZdrVhfIknj/l1EkyeUhZdKgzWR4bhV6QJcLZM=;
        b=RNH1RNWDmugvTkQ9quJjXS8UMMS4yhPMAQRQBWh3M0TIU/APglmLfVUWsL6REJwkEL
         8VxHIJJyQj/1Z1Zj51W5g73OX32SIU7+asrHG3rH35LdvX8vrRqmLhLiUruXrjetDkR4
         oWcMAf0U9mkfV6dDO7KvUB3TIUjrf2F7t0auzUkhirxlw0IB96yuxPdQnn10rAl3WMvd
         HhO74sTBTqlviH5WSwP1OEXhRYepVovwhLcX7t2zmC0GyVV8BHVRUs5D4lZgFRTV4C3P
         qeh9PI85Wi54dxuWvekAuXW37w5VkIKVQ2e6kY9YfnPIsgUb3Kz+2MxmXGuX/d88dLsS
         lPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow2r2TZdrVhfIknj/l1EkyeUhZdKgzWR4bhV6QJcLZM=;
        b=A1lYUfHbcPeZ98AmUTi8GVFFf5Dmtbnin4K9a5N8PEsvJgVc0JF26b9JFrE073YYsZ
         fOhdCtd2phBgnzjxlKs5AJ2xwr33xtiqcOpFH8IPqdR8zdF5jhV/zrSLKKEG0mT1l/Bi
         /UzW4rs5qgELLEAdPw0q1RWKNDpqTTbjeB0JcLn6vfBiCDiOdT/cTyfhQ+hf1XC7cMme
         I9Vwh1u+kHl0XDyzRgmTUDp17raUtzC22dup52EPT5Lz27zMGQrnmTjjeoIrXhlGK91v
         6jqyKNnm14/ARsT6ssQrrDKJzmY3UdFqhO7kMFtil/rLmy1cCv+wSXsFHYMFk+jPi9Gp
         hx0w==
X-Gm-Message-State: AFqh2kp12tZn/yb4lW03rTjoCzyL60f5x1Cd68H6OXo5TkjPVZt8P+xH
        VJnY7Nk7L48OOOQNnTAOQLxHnHxY4UC89A==
X-Google-Smtp-Source: AMrXdXtNvg7212lkqlfpekfb99VROoN4KnstcQvEkXn+PPPfGkjVc6UW8ejjLUsgNiINCVmesT628w==
X-Received: by 2002:a62:14cb:0:b0:583:3a9c:1df8 with SMTP id 194-20020a6214cb000000b005833a9c1df8mr1059898pfu.23.1672936357872;
        Thu, 05 Jan 2023 08:32:37 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id k26-20020aa79d1a000000b0058130f1eca1sm19224375pfp.182.2023.01.05.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:32:37 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Thu,  5 Jan 2023 16:32:23 +0000
Message-Id: <20230105163223.3472-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..2ba7c618f33 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -99,19 +99,26 @@ code      value  description
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
+the destination register is instead left unchanged.
+
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
@@ -128,6 +135,10 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
   dst_reg = dst_reg ^ imm32
 
+Also note that the division and modulo operations are unsigned,
+where 'imm' is first sign extended to 64 bits and then converted
+to an unsigned 64-bit value.  There are no instructions for
+signed division or modulo.
 
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.33.4

