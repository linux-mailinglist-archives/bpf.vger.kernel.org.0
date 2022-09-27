Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1695ECC8F
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiI0TAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI0TA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E65160E7E
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 3so10239697pga.1
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=j3/b2wUTfsE5qVDAxGn10zca1M0PYuiEt7a+BrViBG4=;
        b=OVAkg0cO1XTzq99+U5oBUSHN03Zj0ErumSrI2IuBmsIjaQ5OOHnsThBbLIppr/FDwQ
         v+XlUvYS73fd4unsSFt3SMMlJ3WCXEMNiKzR1YMxIGvMqGNWnPe+68AlLXpeBBI6uHqc
         DIcLo9nrkLtVrO7B7oLpyG4dVEZSTxGYRANbZgaruEPKnc1pUrJNrarn6yopSEYQz2fJ
         1aFfcbohZaXcIebn7E7lAZder+bzDxct41OgxIqhk89uz8TatKf4+xLstWu+J7JNx8tt
         4wEpgvxjfQK212Lfa5VAir2C5z7iGAi46rH0XD4bzFJ94DvVhWW6cIgLQox7qTJME2Cg
         9evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j3/b2wUTfsE5qVDAxGn10zca1M0PYuiEt7a+BrViBG4=;
        b=aLIcPfytqRZ4k/Uh8xZXkOfJRfda6uBp44RZZFjEpY5LlidJc+66MtvOqkX0EurQYE
         4ETo7qG7+jEQ+vQo3RcVe4kG48Bm8atZzPy19gEsDz3MDjgQib96EUnev8F0JcXkBtBh
         eExgTe7H5xF5sTgJYJP8WV1kmxGV2zhzBTocj5rqe6R0Bp5XoCL3676yfnpH9Ogkw/BO
         G4xEu8UdgIbp8baJcPT0TjbZM1RyGUknE+drDlYHXXpGCGQV1LgvqSkcs7Fty/tMkNrA
         WG5LBmiC4oS1tGKMsK0TA1HVHgFiuh+H+AQhvYEqoz9oSppwYmMgtr9Yb2HWcV1iv8sz
         jZTA==
X-Gm-Message-State: ACrzQf1atrvEMeaI+nczGu381O50Q6i7RAyvTLrUAq1k9ueaXTJeCnWU
        0dHHtYhPPgl+QjtjZcRYYUjEh0TIRDg=
X-Google-Smtp-Source: AMsMyM4cySSzW/ENDiU+zgvY00gEl1adqOicC6QCyKKxeiu4HPRoBkgRMGViby1sCcfLv38MqRn0vg==
X-Received: by 2002:a63:4449:0:b0:43c:c1c4:bd54 with SMTP id t9-20020a634449000000b0043cc1c4bd54mr8206042pgk.150.1664305224869;
        Tue, 27 Sep 2022 12:00:24 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:23 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 09/15] ebpf-docs: Explain helper functions
Date:   Tue, 27 Sep 2022 18:59:52 +0000
Message-Id: <20220927185958.14995-9-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20220927185958.14995-1-dthaler1968@googlemail.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
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

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 2987234eb..926957830 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -245,7 +245,7 @@ BPF_JSET  0x40   PC += off if dst & src
 BPF_JNE   0x50   PC += off if dst != src
 BPF_JSGT  0x60   PC += off if dst > src     signed
 BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call
+BPF_CALL  0x80   function call              see `Helper functions`_
 BPF_EXIT  0x90   function / program return  BPF_JMP only
 BPF_JLT   0xa0   PC += off if dst < src     unsigned
 BPF_JLE   0xb0   PC += off if dst <= src    unsigned
@@ -256,6 +256,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
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
+  uint64_t function(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4, uint64_t r5)
+
+In actuality, each helper function is defined as taking between 0 and 5 arguments,
+with the remaining registers being ignored.  The definition of a helper function
+is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
+the number of arguments, and the type of each argument.
 
 Load and store instructions
 ===========================
-- 
2.33.4

