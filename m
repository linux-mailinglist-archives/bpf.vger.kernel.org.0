Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778E35F4C2B
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiJDWr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJDWrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:47:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FF6E88E
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:47:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gf8so11545086pjb.5
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M0k3UitIuZs8QbREBS2h3Pc+EVFq/RHeV38kSddPEQQ=;
        b=NMfBKlnwsWwXQGP5WhQI/VFLnw0jJ8sENJXELWGqZuwJu4lbWmZXbshzam+ZYYuyQB
         U88T7SDsEDdP6tLOIDswmyRmGhI3IKOytgHi+Rf3UN64iBoo6togvHpwApRvGU3xjvji
         c5YKqIMDl5+uIbR4NO7PD23SfSqsr5n/TYMKuq5AK4AHGryhTBKf1SXr66taAJKTb6HF
         y3czNb3Tl7DKQN8sexHq4CE1Whu4ccKUz8UTRtife7rNjMH+VnTN6c0WLVXIj5Vp9dhL
         h24FXrnnr+GVM1z9YGDDwVowGmBN3V2YrsARZzLspXQyBzk5ch/mZayre868H5RGGvXF
         5vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M0k3UitIuZs8QbREBS2h3Pc+EVFq/RHeV38kSddPEQQ=;
        b=qDcAvUfLd5aUmjU8ex4MfSEjcB57VZW9mqMuVrSfVmZnUSbAiwWAw0QIdMjIf13Kxm
         UslwgJoIhbsQiLGIEoJnPHCJwaY/l/jC7TCpFwsgiUBQ+yeHpGj0+VYnJElCGjHvEC4Y
         ZAMbzztfyMndMcd7F+6qO72i1BdKljiLPG1Bb+oyXOIbkn+jBel7ylTSj21+GfHOOR1j
         IqJy33vBngeAhGFk6ZeZ9l97+XY6oYYvyH+iIY0y0iDQAIyXweHf93FiE9rQ6B8wceHh
         BVkz/t9WMeTA9MsEK5e8g5wys6SNv0hDCpUDbcOOB3l4JI3F+GxYYGlIAdxoyLQt4MEl
         M7FQ==
X-Gm-Message-State: ACrzQf1B5q8etGionA4URvFLA62xd0FrM8pk+kJArOgfVySZFasGlhGl
        WM5HO7FsXEoaszpaKTOHSPVXXuLxw8g=
X-Google-Smtp-Source: AMsMyM7cfTOScEbOHe6ORrAhJVsARAJWE9KzemXNaPAW/F4TCiKCx0SE3UZjfcrTUXUS7LBMEajvdw==
X-Received: by 2002:a17:902:7009:b0:178:b9c9:979f with SMTP id y9-20020a170902700900b00178b9c9979fmr28005821plk.39.1664923672098;
        Tue, 04 Oct 2022 15:47:52 -0700 (PDT)
Received: from mariner-vm.. ([131.107.174.139])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b0016c0eb202a5sm9487369plg.225.2022.10.04.15.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:47:51 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 4/9] bpf, docs: Explain helper functions
Date:   Tue,  4 Oct 2022 22:47:40 +0000
Message-Id: <20221004224745.1430-4-dthaler1968@googlemail.com>
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

