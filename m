Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA072670DD3
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 00:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAQXol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 18:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjAQXoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 18:44:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799EA70C66
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:49:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso462700pjt.0
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOZktqMpTUMrIIQ1iYnsdM8Pvql8GU2qMZDngdI8BQA=;
        b=mYPHRRQAf657D9uDG7xYOVpnjEYoSWFR0Sc00N71017O2/tFlFwGeycJahLak4UkKU
         oZ3nPP5NHph8zD5lxN2dUdg5DvhSVBm87Tw548yGdvWsTsf9iknntcXoWH5MWC/oJOc3
         yKZ4norfEEHf8NApmg0k3Qn4dFt8D1/DAkSYotPfVNAuR/XtgFOkJwcRvbQdracw9EJv
         OiZdZj74aIIU10npf15d8Hv4b0ZdkJvcF4x+cFMDB5FrrfdfxDk3f11Li2rUoHl5/h0O
         czCCkD8xZ8cXqRi7S7KigG+5nH5t+0oDAdsL/0rKcxxcp2E7xAT5KuGo1Fj2dVhn4Byr
         homA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOZktqMpTUMrIIQ1iYnsdM8Pvql8GU2qMZDngdI8BQA=;
        b=gxDKTK6pODtbrHIzvXURI4qIkyy+ZW/J9IlCR/PgXan96Ow5LQ2mMRYZ2kcBXGvv89
         nvkQR9NJHGcFgIbXV8d/WGx4z8hoMAbcHFwZIqwzY9DcCOEcd9xwpHs4vlYLQw6JvYtM
         4tCGFr/4YAOQ5YIPs3IGwYKrF+JLasHdUPDCN3dTmfrzH7J+liIbin3uC5uyXT0R+nZ3
         eDOZ0HrL1jxEwyOFm56A8vZUJOANZMLWlczpINA+IZxjl1yh3Zsj3ladP4gkhWqMmyP5
         EaqDSgQG8y5Xr4D8jgXgS41UoMBkH5UkL+Wgts8c/8Hz3DOsMFpnuMDBOiq6YJ0vmgPI
         kmBQ==
X-Gm-Message-State: AFqh2kqpMAguv45bnAArLs/hW3502A59KxyRIjmBWSWWTcO5vO14OaFi
        n6M/fByxs3ub/ByyxwkuXMUEw7mMnag=
X-Google-Smtp-Source: AMrXdXsj4zVu0ttT+930ZalN1j4Xuq8w/X1TPVWEBTH8byR3mOMB/eZCOfEqcsuOnx5wkzFeE2NGSg==
X-Received: by 2002:a17:902:e811:b0:194:98ef:a40e with SMTP id u17-20020a170902e81100b0019498efa40emr6381544plg.31.1673995796596;
        Tue, 17 Jan 2023 14:49:56 -0800 (PST)
Received: from mariner-vm.. ([131.107.8.65])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b00177efb56475sm21692728plg.85.2023.01.17.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:49:56 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Tue, 17 Jan 2023 22:49:51 +0000
Message-Id: <20230117224951.984-1-dthaler1968@googlemail.com>
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

Changes from last submission: addressed 32-bit comments from
Daniel and Stanislav.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..fcd4db45717 100644
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
@@ -128,6 +135,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
   dst_reg = dst_reg ^ imm32
 
+Also note that the division and modulo operations are unsigned.
+Thus, for `BPF_ALU`, 'imm' is first converted to an unsigned
+32-bit value, whereas for `BPF_ALU64`, 'imm' is first sign extended
+to 64 bits and then converted to an unsigned 64-bit value.  There
+are no instructions for signed division or modulo.
 
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.33.4

