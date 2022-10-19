Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A0604FCA
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJSSi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 14:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJSSiz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 14:38:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C77189C30
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e129so17023157pgc.9
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0k3UitIuZs8QbREBS2h3Pc+EVFq/RHeV38kSddPEQQ=;
        b=cJIdnYGrlFLTQ/pmsfdG6vB3y/ot1C7WuTo0EQv85ateL6+L/hYQRtD3QLoXxIkxBf
         fhWG6SYs0aMulhAFsj7xr2OGF5Suk387VXzIVH5PPRqPTuogyp5PS9E5XkjaPzdMtYRR
         vVd0HVJH3l/vk/MhCco3mS48Lk7AzVPursUfIcvFCH8zkFEcV4PFqzZu8Hcs71axxyK0
         9stR6kfTPKJRD1v2io1cZL4HClTEY+OLIdLpPxKxrTfLzXJrVzTIFn/6orfaRZKdOPIf
         GqQxKZS7OnrTWqpAb6ADFzdjmZBYwZU5VNVsM3lOCgBCofH6Gzm5F1hBEKo1iNpZsGYo
         3nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0k3UitIuZs8QbREBS2h3Pc+EVFq/RHeV38kSddPEQQ=;
        b=xd78yLEABrmh4GCNNLW30Krq3EhU38OH0zyWN7NnGIXW2NPoeY1mCK6vtfOyuvF7cw
         MJdGwh9aq46E8UL9JXAEzTRzcUwAe9/OUF6PqUaB2uu7SBDnCqJ+As/zcK2cI3grSEB+
         xBe7G+9KXFzUkgmnWYgZjaN/AZ7t/+/dbInESEE4vbPbJqOTUmkcCs9jW0CrQPcy7YNB
         xoRlyca9pJhE3OOT/407Fy+3hLGfcQ+CP1ldj3ioQVfuukqNXqKY4Zth20RLeI8Jtxcs
         T1enJJVage31kKhdOY4swv0PgI7JnBUzBHedJp7nwnBdsZSP52zBp3JrXv+TpE0z5UKy
         K8TQ==
X-Gm-Message-State: ACrzQf1BIX51e3vCQjcHWVbRyEb2S4ALZcWp7Sc4u3kbPhZ8fG/yJMA2
        +ll93i3IbPJ4nYXMBocevgEka7JXB4Edqw==
X-Google-Smtp-Source: AMsMyM647pe54sjfn91KpZTfSIEArldRGfeq3X3oQcbXBYMNs8zSTUJE/WoXxq2JvPGn2qpwNpq2/A==
X-Received: by 2002:a63:5519:0:b0:457:dced:8ba1 with SMTP id j25-20020a635519000000b00457dced8ba1mr8161929pgb.163.1666204733726;
        Wed, 19 Oct 2022 11:38:53 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902a38200b00177ff4019d9sm11104510pla.274.2022.10.19.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:38:53 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 4/4] bpf, docs: Explain helper functions
Date:   Wed, 19 Oct 2022 18:38:45 +0000
Message-Id: <20221019183845.905-4-dthaler1968@googlemail.com>
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

Explain helper functions.

Kernel functions and bpf to bpf calls are covered in
a later commit in this set ("Add extended call instructions").

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 29b599c70..f9e56d9d5 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -242,7 +242,7 @@ BPF_JSET  0x40   PC += off if dst & src
 BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call
+BPF_CALL  0x80   function call              see `Helper functions`_
 BPF_EXIT  0x90   function / program return  BPF_JMP only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
@@ -253,6 +253,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
+Helper functions
+~~~~~~~~~~~~~~~~
+Helper functions are a concept whereby BPF programs can call into a
+set of function calls exposed by the eBPF runtime.  Each helper
+function is identified by an integer used in a ``BPF_CALL`` instruction.
+The available helper functions may differ for each eBPF program type.
+
+Conceptually, each helper function is implemented with a commonly shared function
+signature defined as:
+
+  u64 function(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
+
+In actuality, each helper function is defined as taking between 0 and 5 arguments,
+with the remaining registers being ignored.  The definition of a helper function
+is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
+the number of arguments, and the type of each argument.
 
 Load and store instructions
 ===========================
-- 
2.33.4

