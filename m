Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177D672135
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 16:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjARP0E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 10:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjARPZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 10:25:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BF7AAF
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 07:23:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so2687564pjg.4
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO7Ols+zZeQGf+J3cC8olCPWGDhwo2msUz9ib2LBbz4=;
        b=eT33UcG0XdApTA6oVDJInO0j1i8pKsGHpTtM5S/NEFg1QRksUGQH/vn9w6at1Ol1Fy
         FENqxUbP48bsdwcZiIyY61dM1Ee2nB3FKyNWKIPzABiLYBw3DUeGS+Oh5yxuzaILWJYI
         GICAIAvkvKPhalW3ePYX11Lr/re3Y/62xqO4ljluXRDiokwRDrtXEhatDaYYTX8tC90s
         t1Smt6E08scfloaIWwqTmpmq0/9e1qjgAbWCqE+sh/c/r8GkLzFd4fAnOgIXkQj5PG0d
         WVrkyo0wMjwdAWv6G/nqvk80VjzN9DOEzuv6hclgdCpv0LJfqkBO0WJsKoj+sK1So3vR
         nqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO7Ols+zZeQGf+J3cC8olCPWGDhwo2msUz9ib2LBbz4=;
        b=pDNaXxMw6n37WeBflb2POPMu5JyGphjDXOWen4Hqet01toaCdgaED1lrvINoY8Vd/M
         K+ZjYyZAJmCTkOPAngRT4TkwdqvZNSFMU9WZI3a58SISqeJX3sou4zol37GDSzEjPYxV
         EzuEgIunAisi4SY6Vv0ljdVmanuy88+rAHbl7w5AMN8lkQ77lzXAPF1jUIqlPIXLPTpl
         ic/GtIQe9VtPW2RmwVOeD5KWOHUlRp1d34IH5QsY661r+GFs0TFIn6muo/S1d5cJE6AA
         vrkRKqjGskJaiL33fDs8bChKBTJHIbK4YJS0cRev3UGogVFXcR07QZn6LH/hL1Dk2duf
         qjnw==
X-Gm-Message-State: AFqh2korosDJc+TcP3pd4K9bRvgDzUM1vtXVHUx8KhCORNDWXNz0OMoh
        YMW8Lr5HyC1RWBOUjfmVOGJaZxmpkmc=
X-Google-Smtp-Source: AMrXdXuOYrLIEhbvyVa3YP9dCDiT7oBipIkqOXbdAgfAW1ZF+1KkKO2lFYIrKLdMAxQoo7uMCM+z+w==
X-Received: by 2002:a17:902:8304:b0:194:9de0:bed1 with SMTP id bd4-20020a170902830400b001949de0bed1mr6465648plb.32.1674055412639;
        Wed, 18 Jan 2023 07:23:32 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id a1-20020a63d201000000b004ae6e97ed10sm17465967pgg.17.2023.01.18.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:23:32 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Wed, 18 Jan 2023 15:23:29 +0000
Message-Id: <20230118152329.877-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <87o7qw18l8.fsf@oracle.com>
References: <87o7qw18l8.fsf@oracle.com>
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

Changes from last submission: addressed conversion comment from
Jose.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..f79dae527ad 100644
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
+Thus, for `BPF_ALU`, 'imm' is first interpreted as an unsigned
+32-bit value, whereas for `BPF_ALU64`, 'imm' is first sign extended
+to 64 bits and the result interpreted as an unsigned 64-bit value.
+There are no instructions for signed division or modulo.
 
 Byte swap instructions
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.33.4

