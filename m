Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C44675ECD
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjATUQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 15:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjATUQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:16:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C0511EB1
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:16:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2311375pju.0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KODQln6ez+ic1HmSpOLuD+9tDffxvK9UB2QVFZ+XXoQ=;
        b=ZSN/FROfi5I5/TLO7caUFgwNIVpTG34HUBzJNUKi1uF7SLVVx9oSkQ9LuqLT6oYexl
         p9wOqAfGGFUP275tI0F7F85uXZUT8CvxxtOS7dPiaJdsf18KABQ26sTRy691fXb/2U3j
         xSqstwY8aESKyi27FYbY1KbAanRcNU1xwkPVv91NJ1al8FLmlUbh3V6S6LozKZxI6QdX
         haejV5udcEUTf7sgMx+DCsMx9rpbQmOy1dsIWJ/qiIUnyYCVulnmeyLfQpww/Q0BgTMC
         HSRDQPStHntWNNNiBHRoSfw1rPkcs6734+qd8KEe7+SFDteGxxhN9hyk0pm2QTosskpE
         sOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KODQln6ez+ic1HmSpOLuD+9tDffxvK9UB2QVFZ+XXoQ=;
        b=vzKLUxwqQmS3AaPtiwDygLf7nR0CbbSpFL6Nkg/XtZ2QDJ71PyTi11zadrUl97avid
         cJOjE7xUylLt5Lb6NqAIC+43VFHoMDx8Rn6DkF5QR/iNmWtSk6rrpVbuNPxcvnQddeBt
         m5GUvqISfHAIBX9ijs01RuQtF6am5RMhTbcAcfvlvJkOe/iViCRRLFdvbxDmyq9wPfSC
         Fo4VZREhtKItkwUUNwk/Cg7q1MVStstdznvW1EidWeJYPc1A2QNNxn52JcuplR2hWXwl
         5qaa5P+lyrxpX3zuCr/ZIrvGONZZdQ0UoHIW8dYfpA4hFHa5c5vsx6m0p8YSR4ljUXES
         6+Jg==
X-Gm-Message-State: AFqh2kpphv1ebzYavMGACvH7XVIjHYjqGmK61LIR0c/QYX93qGTKX5i+
        1WuUKYL6lfO0wvBkIvfu7DdlmAf6v7k=
X-Google-Smtp-Source: AMrXdXsfhcYSI2PUS058d0WZL9Lx6PWVPhuyJ+e6FYSgR2ZViErYUNJDh1pOUuosYZkiVlKREVzXnA==
X-Received: by 2002:a17:902:eb44:b0:194:84eb:290a with SMTP id i4-20020a170902eb4400b0019484eb290amr16610878pli.50.1674245798037;
        Fri, 20 Jan 2023 12:16:38 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00186b69157ecsm27168127pln.202.2023.01.20.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:16:37 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Fri, 20 Jan 2023 20:16:34 +0000
Message-Id: <20230120201634.1588-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <CAADnVQLZd1u_wJUC2ViRcEPveRcGaAnOsjbPiZ8bPZcwV1p=gw@mail.gmail.com>
References: <CAADnVQLZd1u_wJUC2ViRcEPveRcGaAnOsjbPiZ8bPZcwV1p=gw@mail.gmail.com>
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

Changes from last submission: addressed comments from Alexei.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..2546630fcbd 100644
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
+is unchanged whereas for ``BPF_ALU`` the upper 32 bits are zeroed.
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

