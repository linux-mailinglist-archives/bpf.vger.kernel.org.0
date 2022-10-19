Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57B604FC9
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJSSix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiJSSiw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:38:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674217D87F
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fw14so17662474pjb.3
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCDmQ9xrAmjZGrgEFa9vY4JR2yCT6Jw9ahBiSCvLJ/g=;
        b=c8+eQ40FIkjNEj8ttqyXmUcelsZu7ov0f0IGlxfmrIxlo3FG0SE+a6jX1kP3dd2U7u
         8U95OVG+txXYb2ZtBvewi/ukEiyNYbo4yID+wkvSuuGX2nxwu59wCaI/Y2C9sHtQaKS5
         TwYO8hkGsxVPEX7UlkCPw6TDu+bwl1/ufC6uDq8Zz9HA1fmi2Eo/oQMdzPyI9fp17Gez
         YtnunUOof5uMvIPgx+IH06G5nlb0E8d9bD2vwZkr5VM4vyJsQyORe0yOmTxD7HvrpBJT
         r/7xz+WxxXZ4xHVWqWsotOHSQQlMxfuM4HmcwVaq6rz/74bmq3ToLn1oFcCq7iAOwRqJ
         tcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCDmQ9xrAmjZGrgEFa9vY4JR2yCT6Jw9ahBiSCvLJ/g=;
        b=cfxDAWE+83iltfRS3yE2zyev4fnhKXG/eJoCSl2Q9pQ/kSuiZgvTPWdvTWunl+GKQ6
         gGqQokR9m63iSHWdJYwHsjkt/sKsOeuWz72hWsyXz3U7jrivWvywQy5Fx5mYnCdGWSCh
         9vxY5BGJaQSVdwlk3jdHacvMLAYxkUqFG0QoZ89YY3Urtgr+rPVac3lUBFlw1+Gpqi3M
         NsWVL2oL6PiuRKAZOxq5QPdluL3Be+XLBMehqQ5JdwbWNyGy1SuAJeR91vxh26hLGCP7
         G0YIdMQ9tN5ySwaHzm4Y4XCrV5rtfMF1Y5utl/0kPE8DtQSgQTJuEExU1XQL5HDCNW9F
         BuRg==
X-Gm-Message-State: ACrzQf07oRrGEioVtc5HgO+3ROL0gdvB0WxFcqoggPG7GB9f0zViLT0M
        h6tWac8mQITe5KblO3Zr2udPGTBHKaIuOQ==
X-Google-Smtp-Source: AMsMyM6+yFOsW5lsUTCDsJKLSuYkQLB0C4SGONr/bjWBT8Bk7mMw/r794zH3+i0bQtzxbM4OyDSwDQ==
X-Received: by 2002:a17:902:8c81:b0:178:1701:cd with SMTP id t1-20020a1709028c8100b00178170100cdmr10018742plo.138.1666204731188;
        Wed, 19 Oct 2022 11:38:51 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902a38200b00177ff4019d9sm11104510pla.274.2022.10.19.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:38:50 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 2/4] bpf, docs: Fix modulo zero, division by zero, overflow, and underflow
Date:   Wed, 19 Oct 2022 18:38:43 +0000
Message-Id: <20221019183845.905-2-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221019183845.905-1-dthaler1968@googlemail.com>
References: <20221019183845.905-1-dthaler1968@googlemail.com>
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

