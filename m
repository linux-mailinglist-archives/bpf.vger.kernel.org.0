Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD65F4C29
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJDWry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJDWrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898366CF78
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w2so14378268pfb.0
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rCDmQ9xrAmjZGrgEFa9vY4JR2yCT6Jw9ahBiSCvLJ/g=;
        b=nk0bbYG7LEC2zzhSCCt9z6ZmFvvnVVwoKn3ejpjiNwNFqeEJDB+ObBFHb8u6fXiS6p
         VcBd4XDhdeDvslTMYYXTtcBvLAElEexkTciMIkcFkQstCo4OOIkEOL+W0ZCvVlt89/R8
         iOfc8SJ2GSVyUwc9dW70ayL9u5nsaCfmF0M2p9vDS6uHVpYul8bm86HZ/P6RrqUBx7PE
         5OHCtrpnxRJcILpR07CMt13TbgUnPO8+7xoutlstM8QFUXUS+omKNYMqPjwtUkRaH0xh
         heV95TubwbHyFgZfhSIaURleUi20iFVTbgttRbi10B8PC26vjzIxcAxO2Kefd9n6QdIj
         do9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rCDmQ9xrAmjZGrgEFa9vY4JR2yCT6Jw9ahBiSCvLJ/g=;
        b=r7x4N58sR6WlmvJaGpeHWWkZvrUJuazqc5WS5l/RXYoRHU5Kc8/tbV6fd48wSstmYn
         4t0ZAQ5KLLVShVLAFOb92XaTaWfOwOdliv7OW2yIvmNZU+Wm/0N9PWwX26FppWaTWqkN
         F/9++n2zDoo8cKGJ6ZMs4OxnIGLWdewDZ7B9nylVV9SxghkmJD7o96Gzaz1zXrI8Mkfj
         784kXwV+HthOzCYC38zqwZ88g71HD1AE1ARza/uMVtlb6u0GFq/zpNvzOWlF6a3jPqAl
         wCSxgFiBJtxJV/v2imlhol1jq+rCq2ZBeTJyARboV+DuDVLig29t7KaiS61xRdUJOs25
         TRZA==
X-Gm-Message-State: ACrzQf2oVf2J02QcoGuAh0RBITSNWVKgN9sL8usO+5TRwkAZ1zbf752y
        MPI9WUjbCwVRnY3sIqY6lXcCv6bu/tQ=
X-Google-Smtp-Source: AMsMyM76Y95ktXGnRIjZMvjJGT+JosVCzgeoBahSGZrEQnGK903BXez6IhUjKehGAXozevdt2eyKyA==
X-Received: by 2002:a05:6a00:3392:b0:547:f861:1fc9 with SMTP id cm18-20020a056a00339200b00547f8611fc9mr29792961pfb.17.1664923670003;
        Tue, 04 Oct 2022 15:47:50 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:49 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 2/9] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Tue,  4 Oct 2022 22:47:38 +0000
Message-Id: <20221004224745.1430-2-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221004224745.1430-1-dthaler1968@googlemail.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
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
index 6847a4cbf..3a64d4b49 100644
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

