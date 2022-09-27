Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71175ECC92
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiI0TAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiI0TAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46D18A4A3
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so9901509plr.6
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XxkoEN7lZP3Dtq56SUjv5/hG8wKNzCHhcEcj/U1ulzU=;
        b=DDCdeVJ7ww8Lrc/EalswqOY30PfAlCZ8IoZiAdrx9UPZpt+DSiu32A+7V3sM7/19A7
         8Kmz/L73b/04hJfPbxVCezyd0Jo4RHvbkUDL0J5rpxSIoHRTH2w6mIsXbQWBJzJmQjIF
         SU8dOw41pwU/RMzvuClNSSsyZf3mgLFlAte9HS9IrBaPMKaoXGw1Krpz85GzKv+oGjAI
         2vTdWW9hVDNzmQy1QH/Owjvz4w64sWZ1y+r0cBImNKftTZO55Y9g1oRrprfYB9GvhJGQ
         CQNpX8hc+2NwX6JiKqWykfHTVD+SG9at179a8/TeyI9IXrRi3sgz3oOMO+bJQ+Q5ENGR
         YkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XxkoEN7lZP3Dtq56SUjv5/hG8wKNzCHhcEcj/U1ulzU=;
        b=SMSbDC3hw/KmMsSlqFh/QsR0ltYrFebz7VdqS8tL4nUXYQKWXClAHZui9nifhQAr3V
         QSDGIBZMKxTvXhSIx6YgvwhpeMUhWFZjX7r2PB0XbcjO9ig2l/rgvS66u7D/5VYSjkll
         W7bLTtyojjHd/E5ZYcmhpLc1c7aKDz0eeSZb21NIe+JWDqIzIrC7a13riKR8TsSi6ZOm
         dxEiGG6Rpi7CEiEpgY7kaSLBch72T0bkwoiZ8QcF5BQrtIjG23f5+dX5765sabQY576W
         IDnceN7oWFKKl9/cLy/6MErv0Nx/scl8EOSnzO1TIKNdeGf8QsieB3FcgxOhmkFVeDYM
         9BPA==
X-Gm-Message-State: ACrzQf0Rrb4PgDaPVHfozhoVx6vbYeYNLJ0ZAmPh6sTrAHXELw8RrMFa
        S4+Bjx2+UboqnlZr2br3L0ZiFE2r4j0=
X-Google-Smtp-Source: AMsMyM6oQPkHYKJuIt9OoZrZ64Z9+5WAVxfCU6MRKYmkekti6AjyNN4HcvLvQdzDai8kBYH2BMHHOQ==
X-Received: by 2002:a17:90a:ba8f:b0:202:f6b1:eebc with SMTP id t15-20020a17090aba8f00b00202f6b1eebcmr6137485pjr.241.1664305222644;
        Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:22 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Tue, 27 Sep 2022 18:59:50 +0000
Message-Id: <20220927185958.14995-7-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index a24bc5d53..3c5a63612 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -103,19 +103,26 @@ code      value  description
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
 
   dst_reg = (uint32_t) dst_reg + (uint32_t) src_reg;
@@ -135,6 +142,14 @@ where '(uint32_t)' indicates truncation to 32 bits.
   src_reg = src_reg ^ imm32
 
 
+Also note that the modulo operation often varies by language
+when the dividend or divisor are negative, where Python, Ruby, etc.
+differ from C, Go, Java, etc. This specification requires that
+modulo use truncated division (where -13 % 3 == -1) as implemented
+in C, Go, etc.:
+
+   a % n = a - n * trunc(a / n)
+
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.33.4

