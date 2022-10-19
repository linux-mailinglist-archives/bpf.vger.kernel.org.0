Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2036604FC8
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJSSiw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJSSiv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:38:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1517D87F
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q1so17011111pgl.11
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9xNB+9pkjsuEgXzNEYq8ChwptKRSqWxHSgvfEMrQ0s=;
        b=RZkENNSDBphbae7yFwQJUAEfHL4MQZtPZhxVSeHnCXf8cOa+O8p3sJHobXGG4pmnWK
         FWzVWx4ZFP+Tl5b7DUYFa76SbU7Lts7TTwuC7Y/NpNiDl1bJURKpU2Vh3I4so1BRH/Vv
         4Ii2bo6O6mHAbh3SJGFa4t66Pde4dSHB6Tvk9sO0DyAo48Kq1iLHo7fJNyUF2EyYurcY
         aXuAq9UJR1XHqRzHvqHRWQI4Km97TnI9ulalzibruTbaTI7mdBG5T9vwVQI4mxuDO7sO
         P/a67ZXGJH1WjmaJ0ag3uBeo9spGKNhlmtPmkYIwwBEhATO42XtKEo+ufdIGt5ebqLr/
         gu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9xNB+9pkjsuEgXzNEYq8ChwptKRSqWxHSgvfEMrQ0s=;
        b=zjXWDxDZ/W6ZveYvdyJTISpV7F5eljpWQzhcHylbOKbRnGq9l/oB1Ug9bjtyPjnQ5R
         MKEAP3lKpuRsUuA0v0FAXqO5fsgMr0I2c40DRsC/ZTTt9SZlR1eNRil0tyQ1Sz72xo8c
         W1f+t4TnVGT1yHlzaYUQ9u0xvpkEyjf6wy1G0ub+pFifnTyT1WjE6DOfiS7B76v/MFKv
         DskFqQCsEWz2E9UllYDwmiOfl1RmK2mfAa5WKiZNFuVvBR4RCTIE1fcx4GJzfF73es34
         bfKER32ZOQCzCi58oa0qsPcY1wDtVdkN2QB5Kw/PIcH5M5bCt+2YsTQNMFmE+iUldpoG
         KRhA==
X-Gm-Message-State: ACrzQf2G2JIFjS+k+uo/JSAjl0o2P2MxjJkLpb4cLCYmUcGVxjRvVEjd
        K+qx3ccFV+U0aPCbKwRyABvK/MWibIF7SQ==
X-Google-Smtp-Source: AMsMyM4FBUjNwC1kSVow/araIYsSfON5R3NnsXWGO0/P7G3RslCE4EHApcxHHClKlbO/wPaMuSPDtg==
X-Received: by 2002:a63:1e47:0:b0:43c:261f:f773 with SMTP id p7-20020a631e47000000b0043c261ff773mr8444942pgm.1.1666204729976;
        Wed, 19 Oct 2022 11:38:49 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902a38200b00177ff4019d9sm11104510pla.274.2022.10.19.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:38:49 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 1/4] bpf, docs: Add note about type convention
Date:   Wed, 19 Oct 2022 18:38:42 +0000
Message-Id: <20221019183845.905-1-dthaler1968@googlemail.com>
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
index 4997d2088..6847a4cbf 100644
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

