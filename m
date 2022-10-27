Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1959D60FA91
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiJ0Ojk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiJ0Oji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 10:39:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12A2AE3D
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z6so1245764qtv.5
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLdop4erkgbxyis05cdwFFJcQiYkQNAYLZdIA/YIkqw=;
        b=Qlspinaceyxc+IAGQarnfJqatVaRdnOKaMm0HDqRGX2pDwTliEYFiRUR33rgg/Te9x
         duCH4lGQNt9oCmYkQsVF0DLdK+CurWJqsKiWTeUkyq6W3HIf8dArSPo1iGGugkwU2SJD
         WiyJUm5+UIVDTTYm+lZCSgd/3PmjQ5uO4i7bdL7O22NyHMEt0uyJWrMxdVsNJSYUtkKi
         zn6AHavgjxHUzhILwZm+smHKxSpnQyQs0TCNdIKF4UsU1uB+t0b6I+gm/Ahp/cEgI12y
         ZAdskzcK5D9psMUxQh4U00bnYZOYRc17qcIkNawAUs+of38MfiLu3rcwGx8F3EHxR0uy
         GYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLdop4erkgbxyis05cdwFFJcQiYkQNAYLZdIA/YIkqw=;
        b=WXpVnqQnY19thH4J705IvvqjRsJxrCesZ5SeMQjbEQlNUdNlG1QygbukIuNKfOxCpM
         N6QpboiSHDdVWgXHbb+r+Jcj6eZEwOCzFQ6ccneEEDfutYKvtv71uO4O5GI/WHFTSsHB
         iTTSb2ZLSxz3rTJEvSpZtVum6NX1E3xqxz4jjey2RabKeVZgFSpEvjRAMinne+NtSRMc
         wBLaVOvofwmO8JmGFYXwpryVvR+pr0Vf052VEiCr0OS3etiLlqwZDTji+HeCiGshSSh0
         sEq1QmYwqbtmH17S+bcRPL6AYGTTQHEgszV0GecE8k0oHqb6zUuhxJYDhIDiMdtD7RxN
         d23A==
X-Gm-Message-State: ACrzQf17HVt6lqVfvF2WIBdvz0+DKBO+QupIRJQ73oOwq2rn5nLZq1t2
        txdw3pQ9/XwUoShel2kF5O9a1Gy6G9mCog==
X-Google-Smtp-Source: AMsMyM4W2/F8Qg1Qdx3tDH//GZRtCEgtf5O8JOqGPTHPEMRO42GmPA4KEtC6FGiLTuDT1KcQfSgK3w==
X-Received: by 2002:ac8:5746:0:b0:39c:deac:c69c with SMTP id 6-20020ac85746000000b0039cdeacc69cmr41363642qtx.292.1666881575468;
        Thu, 27 Oct 2022 07:39:35 -0700 (PDT)
Received: from mariner-vm.. (c-67-185-99-176.hsd1.wa.comcast.net. [67.185.99.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a05620a294300b006ed138e89f2sm1060825qkp.123.2022.10.27.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:39:35 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 4/4] bpf, docs: Explain helper functions
Date:   Thu, 27 Oct 2022 14:39:14 +0000
Message-Id: <20221027143914.1928-4-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
In-Reply-To: <20221027143914.1928-1-dthaler1968@googlemail.com>
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
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

Explain helper functions

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index aa1b37cb5..40c3293d6 100644
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

