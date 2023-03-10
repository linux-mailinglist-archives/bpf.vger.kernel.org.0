Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E611E6B55C1
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCJXiY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjCJXiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:38:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951C1B57B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:38:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso6652483pju.0
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678491497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBc0RjkmAJoUMHV1ZGJ9wJmJAFimaZ97KsvLEgWqlXQ=;
        b=bZOT4A/ZExCTmxknvCmYdWyLZAoJ8poIwSmfNEiVLdVlCFzmFkG2OxXxGXI3w6DOFy
         nirmHFyau7cjKBwviG8P2pN/pQnNTScjSZux8e/2zzQHMDzOl4iFD9k09NJ1ABbKkwKY
         PMnqKyOBAujCv5x7OsixmacC3QWMj+aGabXt00N9+8liP4N2xItTBPYegj4XO0HtK5Cp
         aDWiPFlB/PWjxBXnAdFsvX9gE3EUzU8IFhWrfS8iFhiJ3o7HvzlmcCFfLBzRcALMpcrW
         LlqJTJoQ8gdpvTgGQxPmPtX4HBxDYJnY+T/Gh2I5zu0Tf2vTiay7WOJ+UUHqXtHFtrX6
         Ch7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678491497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBc0RjkmAJoUMHV1ZGJ9wJmJAFimaZ97KsvLEgWqlXQ=;
        b=77+9BdYTueel2xxS5/DL0qlF7WNa3JNNghV+jQhCpbYTyWUocc1UEuYVfcE0qZHI0Y
         JJlzzCumCt2fjWHEzWmRujpRsLQpav2699LISxyldE8QNRITHyUh9HaCRbA8HHkDedDC
         T7M8Gaj2WWDSPEXn55mL2Vcs7ZRdYrmDL44ffol/ZGj6HR46+RIJ/qLGVLM3D2graGu6
         uagkGRbaWE7/GAlBZ440XzDRPZZnSw2cMwkSvRaLGP/zdbQHheO7XqYZsW8hZLe3nLu8
         fUDXGDuPQrat2rRg6jzyEqixNwz1W64YevymgjQu0YBb6lbHdNYAkIe09GnW6ZoCM6yv
         gOcg==
X-Gm-Message-State: AO0yUKVllaSavAA4c0T7nrBwctkdTZvkX/Qg1tJ4tjUmivIDQSJxeEMt
        Q6WklHObVrZ2YyF2ie7z/9bvLzljkWw=
X-Google-Smtp-Source: AK7set/uY7qVTl4b3W7RHMfqcVaguCEgGeGVIb6bKM4Zuj7ChTX/j44S55hzBIvBaPRinvG5I4c3aA==
X-Received: by 2002:a17:902:eccb:b0:19f:2503:a201 with SMTP id a11-20020a170902eccb00b0019f2503a201mr246781plh.29.1678491497036;
        Fri, 10 Mar 2023 15:38:17 -0800 (PST)
Received: from mariner-vm.. ([131.107.1.213])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902a9c700b0019cd1ee1523sm154231plr.30.2023.03.10.15.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 15:38:16 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] bpf, docs: Add signed comparison example
Date:   Fri, 10 Mar 2023 23:38:14 +0000
Message-Id: <20230310233814.4641-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Thaler <dthaler@microsoft.com>

Improve clarity by adding an example of a signed comparison instruction

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5e43e14abe8..b4464058905 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -11,7 +11,8 @@ Documentation conventions
 =========================
 
 For brevity, this document uses the type notion "u64", "u32", etc.
-to mean an unsigned integer whose width is the specified number of bits.
+to mean an unsigned integer whose width is the specified number of bits,
+and "s32", etc. to mean a signed integer of the specified number of bits.
 
 Registers and calling convention
 ================================
@@ -264,6 +265,14 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
+Example:
+
+``BPF_JSGE | BPF_X | BPF_JMP32`` (0x7e) means::
+
+  if (s32)dst s>= (s32)src goto +offset
+
+where 's>=' indicates a signed '>=' comparison.
+
 Helper functions
 ~~~~~~~~~~~~~~~~
 
-- 
2.33.4

