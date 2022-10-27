Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB560FA92
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiJ0Ojt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 10:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiJ0Ojo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 10:39:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB83FA18
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:42 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f8so1038439qkg.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDdqBOIUMediN5WUAXI9KaERBAOfgJ/z4PXqa10D5vw=;
        b=fB5ll8lI96bS26jmulG4wtc0Zp+zLdba/ZysVBkx+NcVp/dkT124+zcem5qsEBC/dq
         lXpWd0uaB41mO/05Lj3bUJkQjSxLDqOzotQq+oPUvuhOoGV2/Me9hPen6jbZwM3aH5m7
         K/HvBRHxbmc3u/l7Y8UNCn+oEAPo7ppi5tOB2jHY4X085XYNL65RRA5Y4E5T7E5TQGZm
         ZrVqO4Juy1wzMeee1zE9jYPF9ICG4S63ZQrxEy/7l7Rw6lLLsefmtZIOm5bbtBFuIYNI
         6Y8PaxYpbdnxXA/JJ9kZH4JCGObJ77AHStIJbArgLy7cauVBUKHZUk2MhKuG7MELPNi2
         vFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDdqBOIUMediN5WUAXI9KaERBAOfgJ/z4PXqa10D5vw=;
        b=z9oukSLZqlO7UipulKRtW68xBMSDev3eq0ORqhieGOwAgd9qJNuGxiUKMS7r4P8ejc
         X87mW3vwLncpcxA7vSZfhJEk9NFi23egVpO2X+vZICIjJ3OD/qcmhNwD5nWdvSjr7Jb5
         YMx6oWdYOfhXe4RUTxzyR0oajcpAoEvcAsio/igxj0DZxyS/IUytmsAxrynriXIXEYZP
         dw5O/FXHlidXTKFM6kBqCXwyEX8AU+K/HffzAAN9wJWECsNhHsasL5xxMrUWDfrXMxOL
         mDK3Pc0mhNeiFz5VfFTHFxsEv/yKWEluCKpevPLmP/TifUSWJcFFJuu++FWIf3ebc7FU
         r+Tw==
X-Gm-Message-State: ACrzQf2e5kSpyUMLJwiCA3J1dT/eI3lJm+0i0FNk+5YOQ5K38bbzMEsA
        TLnuU1rYveCiVkrP36tiZQAqbETNC9ddwA==
X-Google-Smtp-Source: AMsMyM4+iiIOQ28SeuOTvpOCADhUhVXMa7dj9CbcJy/EZqrm2P7SfUEldM9jCR6qHMlpvq4o7AJ9ZA==
X-Received: by 2002:a05:620a:288b:b0:6b6:4f9b:85c6 with SMTP id j11-20020a05620a288b00b006b64f9b85c6mr34530570qkp.614.1666881570662;
        Thu, 27 Oct 2022 07:39:30 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006ed138e89f2sm1060825qkp.123.2022.10.27.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:39:30 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 2/4] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Thu, 27 Oct 2022 14:39:12 +0000
Message-Id: <20221027143914.1928-2-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221027143914.1928-1-dthaler1968@googlemail.com>
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
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
Also clarify how a negative immediate value is ued in unsigned division

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index bed6d33fc..74dcc13a9 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -104,19 +104,26 @@ code      value  description
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
@@ -135,6 +142,10 @@ where '(u32)' indicates truncation to 32 bits.
 
   src_reg = src_reg ^ imm32
 
+Also note that the division and modulo operations are unsigned,
+where 'imm' is first sign extended to 64 bits and then converted
+to an unsigned 64-bit value.  There are no instructions for
+signed division or modulo.
 
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.33.4

