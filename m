Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4A678CA6
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 01:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjAXAM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 19:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAXAMZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 19:12:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C891F904
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:12:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c6so13155567pls.4
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEOYyOH3zxx+KN2XfEGC60b0K/oMSaLvOiOaW2gMKjk=;
        b=I7s2q08JYBdIi59Zkxa3h143M79LuqoXLoAnl086i42HY1dEFhTXRhiC56fNlOtMZ9
         9X4k6ANx3i7CdA3nnEXXinzfUM5FdCez15SFmt9Hv3mQpUVcXIKyOSzteHCFpLfPrna/
         rQ2Ov+GrizYLoFl1JJHj0WtA0gQ/vkpSQmzkDQST83YPFu8DsKX09kh/rh6cXIMEy6OR
         gMYLyG8yxkzjQDNqKU8b0H4FZTix5nrgVhrA6IE+8VSHM75hexZOx4EKaC4kKs7hPBaV
         Uqse6cCiRlte09P8yafcGEBWGFwL9WQEygjYhAVzOg2NXgIqxJcAf1LomiJx0gjz/h0I
         g5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEOYyOH3zxx+KN2XfEGC60b0K/oMSaLvOiOaW2gMKjk=;
        b=ftVLebuRwPj7FaZ4obQRgwJ1Qy/Ww3yEPprH8ObMc7YKZzoBrknPGLy+t9lxUzso0F
         rbCFRRa7prBlMhPCvbaGreDgzNr0SijQzdJV/5rkPUvZdW7hfop19e7lsTSMfLWLdK2n
         H5JPdCwDMVOi8taX4NhkCg9t9bDPg3UIdWL38JBKp0AHwXnC/Vgqjm7l3pa/GbaHRMa5
         Tg4KzkHOYFDgyBhb8UEXCBMuH6iyJkq3jWVWwexQzYkQ1xl1DbCp2J8/s6ufaqj2vQ3R
         +teuD5MaxLxvlwhcsP/hCumLmkc98C9SUb7+jLR1JIYtypCXr2123StRQeVDQuKsBw+l
         BxPw==
X-Gm-Message-State: AFqh2kpW/6PlOtxinwiKhaij9Ep1MHvv/vDVczWMqjN6AOtOw5LbwGke
        dcPYIbN9XVMmTtCzi+DbZ8iwemr8UsU=
X-Google-Smtp-Source: AMrXdXuUssIKfShMHHhqVTEPjakSTFG7LXJyEX65iCR31d77wJ6i7mewhUDTUWtnKGqvXoxSQ5bjIQ==
X-Received: by 2002:a17:902:9b97:b0:194:7b3a:e93e with SMTP id y23-20020a1709029b9700b001947b3ae93emr24281073plp.53.1674519141510;
        Mon, 23 Jan 2023 16:12:21 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id bj6-20020a170902850600b001926bff074fsm256441plb.276.2023.01.23.16.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 16:12:21 -0800 (PST)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Tue, 24 Jan 2023 00:12:18 +0000
Message-Id: <20230124001218.827-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <8f1b6f37-c46c-f493-d02c-6777049f91af@iogearbox.net>
References: <8f1b6f37-c46c-f493-d02c-6777049f91af@iogearbox.net>
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
 Documentation/bpf/instruction-set.rst | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index e672d5ec6cc..a7f4574562c 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -99,19 +99,27 @@ code      value  description
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
+If execution would result in modulo by zero, for ``BPF_ALU64``
+the value of the destination register is unchanged whereas for
+``BPF_ALU`` the upper 32 bits of the destination register are zeroed.
+
 ``BPF_ADD | BPF_X | BPF_ALU`` means::
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
@@ -128,6 +136,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
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

