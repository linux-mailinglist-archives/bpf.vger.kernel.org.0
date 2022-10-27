Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B1560FA8F
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ0Ojc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiJ0Ojb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 10:39:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF8765B
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z6so1245508qtv.5
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3mDVrST8R55B5LKmbjpdi1H/+/Vgvj4Ij8kYvApKU0=;
        b=BSi737I2htrWAisuysHLhNn2JrXto92dIeHLQq/jHmy/r5TXniNp1I3AUtOdmc2gQp
         0XsR4lbsj2GMq//WZK/3pfrTDcol9oxBhCFge2w3uMURF+3zLMOYdFu9R7h1PTXRBHPD
         ALv33kqp3AXtYY/5GbrBUMAyus5nS+mc/CiUQS/l44ZBu7YYo2PjGJnBpDTRHQ+DG0rv
         tKn7auRVzthzVP3OJ0GwwKeZaMQmh9oVmNKzwgnKMt6k+eBhwc46vO4KRbZU8K540G7s
         HIuac6xfq+LQKqaWHeHWiNRR0YO4duWHNtPLeLLu8TpfMzSiyYz1cxxEXy3HWCI6s8Uv
         HZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3mDVrST8R55B5LKmbjpdi1H/+/Vgvj4Ij8kYvApKU0=;
        b=xS3aR9rLjMhDcZaBSft8JTKeJSf7bSIsss9WgUyCapBKeRPhrKVWgRUASXRzIT/6xm
         rCM8VXPYvrBrCL6rKk16POe/N/guMEJcf6vWkiBcuHqB5vDyEJ9PPqKXvBtMk1ouISfr
         3rPZBgCrpaIF/+vfIFShY/9+ltssZMTLrwqNzzQFxauGV2aUP8jmpeiuscrqs8JN3JAL
         dgcawI62I3z9QstyMAl5varikA7TVp3NdEKhIxJRSH9I4A+U7UIR3R/Oa4MaU4kamkd/
         Yml6//uT7nVE3fxzWo4nP9BKGgELWFZ79QsyNw73ZLUb0ZYi9j30p+0pjDehvdrYHX8a
         r3mQ==
X-Gm-Message-State: ACrzQf1pehUeGqVtR9g1mMa8D4KxpBeCqztG2kNgrx9FrTvRD98j5bu4
        ze9Ip1XjsLieUjam2A6ZBLlpL+nOX2hnZw==
X-Google-Smtp-Source: AMsMyM5x7/RACF5/Rbz1dFDIYncP9babSo6HjI7WFum8L2pzNZqL29dBSg+QVLVSichW8VhfGbvH4A==
X-Received: by 2002:ac8:7e82:0:b0:39c:f746:9250 with SMTP id w2-20020ac87e82000000b0039cf7469250mr41819246qtj.620.1666881569501;
        Thu, 27 Oct 2022 07:39:29 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006ed138e89f2sm1060825qkp.123.2022.10.27.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:39:29 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 1/4] bpf, docs: Add note about type convention
Date:   Thu, 27 Oct 2022 14:39:11 +0000
Message-Id: <20221027143914.1928-1-dthaler1968@googlemail.com>
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

Add note about type convention

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5d798437d..bed6d33fc 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -7,6 +7,11 @@ eBPF Instruction Set Specification, v1.0
 
 This document specifies version 1.0 of the eBPF instruction set.
 
+Documentation conventions
+=========================
+
+For brevity, this document uses the type notion "u64", "u32", etc.
+to mean an unsigned integer whose width is the specified number of bits.
 
 Registers and calling convention
 ================================
@@ -116,6 +121,8 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
 
   dst_reg = (u32) dst_reg + (u32) src_reg;
 
+where '(u32)' indicates truncation to 32 bits.
+
 ``BPF_ADD | BPF_X | BPF_ALU64`` means::
 
   dst_reg = dst_reg + src_reg
-- 
2.33.4

