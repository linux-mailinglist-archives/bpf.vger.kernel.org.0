Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBB5ECC95
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiI0TA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiI0TAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CC16F9DF
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n7so1169920plp.1
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nEjrRcPm35cMRZBlAK+IjKnNfortptsF04fReDevXm4=;
        b=BGpGHz/A9P27RBk4VVnWThE/hMbTUkLNtSBHXmDhTUTx7hngbL/nr9RcNgm+FteFkd
         vSEnpXXMurpPemO6RKNDUJGKCnfORmrr0mTRGnS46/YxYyWAZgLEtcYtLQ2J2WZAUjhj
         tv+jb0heIHAyD+MeXYnOm2/8USuGHl2sRAlM8rDo12s6P4xlUv8wuZMJpkdxECquB3Rw
         UhVhxBRyRMvaGI5l15aFsf8yItRS/psqzYu/tV9hRlGQlyqGnHcKMwoA/lqMvqeSfWkC
         XCWDCDbrDiSXi6VMEV/5mPgQqH9LNlb/iSXf/g9LNDyCT8e/5qhi8/zt7b3fdpkezwYV
         sr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nEjrRcPm35cMRZBlAK+IjKnNfortptsF04fReDevXm4=;
        b=6STtTY99OvyFTAcxh8WSSQtRJZIkEKjM4wpKAhyP/rSemduilBEAzIGwJ5TC91D/eq
         gcHlztRHy3tDo/jGJXdh76idU67M8f9cqAeIQeFKSzSbHxO8c2pHDZtQgi6DJ0UoILWi
         gpVJbyAud3vLtWZsYqRX3u827aJAmaNO7IJsAT33nDYDNAw9ty/YOkg39+WZ58mFx/gh
         odLJeqzh3x71JhPZJHszvGnMLp1P/a8+pHHS1BuhxuVgN7lvUUjlJ0lFLxko1ymPyTCJ
         TwBh1/4oA0/8+0Sgly601wqs1vXKLGzxzPBmrLYVgScUmZsv6jcSJa/dFTmjDQxy8yFU
         dGdQ==
X-Gm-Message-State: ACrzQf3CJHOju5ZwtAq01A/ZZhTa2ekvquU/TRwdAcfM+qJBN5X6l6UN
        dJvK8zBbERDyBU7kqax3EkRouQWBWUU=
X-Google-Smtp-Source: AMsMyM7mW2kDdn10sphoHc1vqzenRI9O39ohJ4Ske+AgHr21qCAmuaUvWYMgSPG/qWX7DPnZXZlPfQ==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr28093948plr.1.1664305231194;
        Tue, 27 Sep 2022 12:00:31 -0700 (PDT)
Received: from mariner-vm.. ([131.107.1.181])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001f8aee0d826sm8737557pjb.53.2022.09.27.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:30 -0700 (PDT)
From:   dthaler1968@googlemail.com
To:     bpf@vger.kernel.org
Cc:     Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH 14/15] ebpf-docs: Add extended call instructions
Date:   Tue, 27 Sep 2022 18:59:57 +0000
Message-Id: <20220927185958.14995-14-dthaler1968@googlemail.com>
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
 Documentation/bpf/instruction-set.rst | 52 +++++++++++++++++----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 667d97715..2ac8f0dae 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -265,24 +265,26 @@ otherwise identical operations.
 
 The 4-bit 'code' field encodes the operation as below, where PC is the program counter:
 
-========  =====  =========================  ============
-code      value  description                notes
-========  =====  =========================  ============
-BPF_JA    0x00   PC += off                  BPF_JMP only
-BPF_JEQ   0x10   PC += off if dst == src
-BPF_JGT   0x20   PC += off if dst > src     unsigned
-BPF_JGE   0x30   PC += off if dst >= src    unsigned
-BPF_JSET  0x40   PC += off if dst & src
-BPF_JNE   0x50   PC += off if dst != src
-BPF_JSGT  0x60   PC += off if dst > src     signed
-BPF_JSGE  0x70   PC += off if dst >= src    signed
-BPF_CALL  0x80   function call              see `Helper functions`_
-BPF_EXIT  0x90   function / program return  BPF_JMP only
-BPF_JLT   0xa0   PC += off if dst < src     unsigned
-BPF_JLE   0xb0   PC += off if dst <= src    unsigned
-BPF_JSLT  0xc0   PC += off if dst < src     signed
-BPF_JSLE  0xd0   PC += off if dst <= src    signed
-========  =====  =========================  ============
+========  =====  ===  ==========================  ========================
+code      value  src  description                 notes
+========  =====  ===  ==========================  ========================
+BPF_JA    0x0    0x0  PC += offset                BPF_JMP only
+BPF_JEQ   0x1    any  PC += offset if dst == src
+BPF_JGT   0x2    any  PC += offset if dst > src   unsigned
+BPF_JGE   0x3    any  PC += offset if dst >= src  unsigned
+BPF_JSET  0x4    any  PC += offset if dst & src
+BPF_JNE   0x5    any  PC += offset if dst != src
+BPF_JSGT  0x6    any  PC += offset if dst > src   signed
+BPF_JSGE  0x7    any  PC += offset if dst >= src  signed
+BPF_CALL  0x8    0x0  call helper function imm    see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += offset           see `eBPF functions`_
+BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime functions`_
+BPF_EXIT  0x9    0x0  return                      BPF_JMP only
+BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src   signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
+========  =====  ===  ==========================  ========================
 
 Helper functions
 ~~~~~~~~~~~~~~~~
@@ -301,6 +303,18 @@ with the remaining registers being ignored.  The definition of a helper function
 is responsible for specifying the type (e.g., integer, pointer, etc.) of the value returned,
 the number of arguments, and the type of each argument.
 
+Runtime functions
+~~~~~~~~~~~~~~~~~
+Runtime functions are like helper functions except that they are not specific
+to eBPF programs.  They use a different numbering space from helper functions,
+but otherwise the same considerations apply.
+
+eBPF functions
+~~~~~~~~~~~~~~
+eBPF functions are functions exposed by the same eBPF program as the caller,
+and are referenced by offset from the call instruction, similar to ``BPF_JA``.
+A ``BPF_EXIT`` within the eBPF function will return to the caller.
+
 Load and store instructions
 ===========================
 
@@ -585,6 +599,8 @@ opcode  src  imm   description                                          referenc
 0x7f    any  0x00  dst >>= src                                          `Arithmetic instructions`_
 0x84    0x0  0x00  dst = (uint32_t)-dst                                 `Arithmetic instructions`_
 0x85    0x0  any   call helper function imm                             `Helper functions`_
+0x85    0x1  any   call PC += offset                                    `eBPF functions`_
+0x85    0x2  any   call runtime function imm                            `Runtime functions`_
 0x87    0x0  0x00  dst = -dst                                           `Arithmetic instructions`_
 0x94    0x0  any   dst = (uint32_t)((imm != 0) ? (dst % imm) : dst)     `Arithmetic instructions`_
 0x95    0x0  0x00  return                                               `Jump instructions`_
-- 
2.33.4

