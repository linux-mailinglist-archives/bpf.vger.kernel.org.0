Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275DF6B6159
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 23:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCKWJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 17:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCKWJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 17:09:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B82CFF3
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 14:09:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so10524002pjb.0
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 14:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678572556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZEbSwWEG5OVd/5xsgdsi9AlAcdGHpGGzv45278AjPI=;
        b=TFKrZR1ZNNSvUpnOKI7HJypcbPqvBLuR36twm9i37N9SxJZDEtudOG+sumUK8ClXkm
         9iavt+LjYzaPnBG8AND88MAl8YuJpjtagq6QMAYQlKEdRer4pZp9yJhZx66OeSDCM2ll
         J6RYVF+ATFsY7xLFVnI8m9BegOSkYC4cxYZPNG+z4g9h539E4ay5Conzg3valoS+EYjs
         noX67B5TU5BwcMdlx6kaKFP5Ga2JlrT8WPDdLdoIQ9+0e5zz0rfA2skXPA+AeJzI2YqX
         jq3oBXEqD19d0v4ZN2PaotRBMLe8SY4A9wylSJcsMtG44Avybx4LcgcCIkL79K32Jr4G
         Rfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678572556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZEbSwWEG5OVd/5xsgdsi9AlAcdGHpGGzv45278AjPI=;
        b=d/rTgtPG7L8rwe4jclIDZTZKcglMiBchiavac+LZdGSMIS4CxocE6VQsmgzEgPd+3u
         mL9wWQVS0hJMU/IenqAszLj/vDErPIMeVNhV8UoDFJnEjYguiDi7Zha+7uNUX+T8Jwu+
         mNZHAd/MRd/W6kYxx402qMIVHhZA7At3WnS89xkHQGIprNtU8dG/gn9WY2DISiKd2buL
         hvDgIBjz1OS7pD74n2YiDL/QmJzFHQVlXVXxtDcuwVSNZBH1qLQ9Rvc1WFcEusE9Dizw
         63WbE7APzvduhSahUMfdpIfxERugBwfAi5Ybwmu2zEWqqKhybQPjG0eNEURzCdOyexln
         vWwQ==
X-Gm-Message-State: AO0yUKV8sUvanapoxSNQSOtlAgSwVarlmhnjYaniD1BJSHsvA0vUmLqZ
        z1FlTYImM4CL+nvJQOGqM7MRLow3RAw=
X-Google-Smtp-Source: AK7set+06MzdulaguDwJ+jYqojguz5094k5XETP8aj6K1zcufZDQffUDcTLH50+fSzTVFfjzPmX7Lg==
X-Received: by 2002:a05:6a20:8f04:b0:cc:8107:7474 with SMTP id b4-20020a056a208f0400b000cc81077474mr34238994pzk.9.1678572556092;
        Sat, 11 Mar 2023 14:09:16 -0800 (PST)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net. [71.197.160.159])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78814000000b005a8bc154bf4sm1881068pfo.39.2023.03.11.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 14:09:15 -0800 (PST)
From:   Dave Thaler <dthaler1968@googlemail.com>
To:     bpf@vger.kernel.org
Cc:     bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next v2] bpf, docs: Add extended call instructions
Date:   Sat, 11 Mar 2023 22:09:12 +0000
Message-Id: <20230311220912.5546-1-dthaler1968@googlemail.com>
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

Add extended call instructions.  Since BPF can be used in userland
or SmartNICs, this uses the more generic "Platform-specific helper functions"
term as suggested by David Vernet, rather than the kernel specific "kfuncs".

---
V1 -> V2: addressed comments from David Vernet

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 63 +++++++++++++++++----------
 Documentation/bpf/linux-notes.rst     |  4 ++
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 5e43e14abe8..dc348544542 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -242,35 +242,52 @@ Jump instructions
 otherwise identical operations.
 The 'code' field encodes the operation as below:
 
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
+========  =====  ===  ==========================  =========================================
+code      value  src  description                 notes
+========  =====  ===  ==========================  =========================================
+BPF_JA    0x0    0x0  PC += offset                BPF_JMP only
+BPF_JEQ   0x1    any  PC += offset if dst == src
+BPF_JGT   0x2    any  PC += offset if dst > src   unsigned
+BPF_JGE   0x3    any  PC += offset if dst >= src  unsigned
+BPF_JSET  0x4    any  PC += offset if dst & src
+BPF_JNE   0x5    any  PC += offset if dst != src
+BPF_JSGT  0x6    any  PC += offset if dst > src   signed
+BPF_JSGE  0x7    any  PC += offset if dst >= src  signed
+BPF_CALL  0x8    0x0  call helper function imm    see `Platform-agnostic helper functions`_
+BPF_CALL  0x8    0x1  call PC += offset           see `BPF-local functions`_
+BPF_CALL  0x8    0x2  call runtime function imm   see `Platform-specific helper functions`_
+BPF_EXIT  0x9    0x0  return                      BPF_JMP only
+BPF_JLT   0xa    any  PC += offset if dst < src   unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src  unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src   signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src  signed
+========  =====  ===  ==========================  =========================================
 
 The eBPF program needs to store the return value into register R0 before doing a
 BPF_EXIT.
 
-Helper functions
-~~~~~~~~~~~~~~~~
+Platform-agnostic helper functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Helper functions are a concept whereby BPF programs can call into a
-set of function calls exposed by the runtime.  Each helper
+Platform-agnostic helper functions are a concept whereby BPF programs can call
+into a set of function calls exposed by the runtime.  Each helper
 function is identified by an integer used in a ``BPF_CALL`` instruction.
-The available helper functions may differ for each program type.
+The available platform-agnostic helper functions may differ for each program
+type, but integer values are unique across all program types.
+
+Platform-specific helper functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Platform-specific helper functions are helper functions that are unique to
+a particular platform.  They use a separate integer numbering space from
+platform-agnostic helper functions, but otherwise the same considerations
+apply.  Platforms are not required to implement any platform-specific
+functions.
+
+BPF-local functions
+~~~~~~~~~~~~~~
+BPF-local functions are functions exposed by the same BPF program as the caller,
+and are referenced by offset from the call instruction, similar to ``BPF_JA``.
+A ``BPF_EXIT`` within the BPF-local function will return to the caller.
 
 Load and store instructions
 ===========================
diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index f43b9c797bc..bdc41293e8a 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -20,6 +20,10 @@ integer would be read from a specified register, is not currently supported
 by the verifier.  Any programs with this instruction will fail to load
 until such support is added.
 
+For historical reasons, Linux has a number of Linux-specific helper functions
+that are encoded as platform-agnostic helper functions rather than
+ platform-specific helper functions ("kfuncs").
+
 Legacy BPF Packet access instructions
 =====================================
 
-- 
2.33.4

