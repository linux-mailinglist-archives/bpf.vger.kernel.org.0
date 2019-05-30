Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36383033B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3UXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 16:23:24 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41868 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3UXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 16:23:24 -0400
Received: by mail-wr1-f43.google.com with SMTP id c2so5013565wrm.8
        for <bpf@vger.kernel.org>; Thu, 30 May 2019 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RaAircRSfxoE/J3zZX/zWAIkaTRoeUAx4T8+dI0CGtA=;
        b=H8+p5wSSoyC7YQot1ES2UvUZQHfDCHnkGXnrCNOmgZ0Yx902eQ8ncAJroEg20BmDBV
         m9xyl45nY5v05Oo5tru/jsaOjd0kSB3e2Elxt/WDRNYGJPqaRLE7ICgvHNtRYN6OajUL
         tG4M1A3oW5VHd+k0P07FpfL2L+/jFvmXfmZIMAkyUT2D1GDP2FbeoauP0L4Sh5febX2Z
         YzKXuIdJJ/7WfKIYOEGqMeD05U73Y7+tUk6J+k3r8xhL2lRf1UMZmtsW+n/HA7dmWhVG
         WmAKsb236k3BssQdOtZB0zfSm/O5dpO70SgCp3AnYVr11RYaQJddsTihJRZPE270gioL
         nogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RaAircRSfxoE/J3zZX/zWAIkaTRoeUAx4T8+dI0CGtA=;
        b=jSAqwBNm1egQ8y+FaD9DEZK6npb8w3cT/GlOMk9QCkAsuE+pJcfzeMh5jfcb5Zk8vt
         ppIzbryxXZZA4LrO/qi8KpZaDFZaMTqrKU6Tmf+4b9kBVKumeZgXBX7Raw6CpVB/0u/9
         HGhaE8bK/Pv9Ag1juc14+ouIB2BlTI1RZbgNjE6jXVhe7/HV9MDPIr5tY1LCRdA8dD9W
         UxNhsOQRzg6oFTqC9yXkm4SB4NJeU8SMv33CLmfuUPRq4rLKsr7mq0hL/r1eVaQ9pUTr
         x8EtgB5aIYXp7Vepm9stNOLCyJf5k+zCIrenp3eTPVHe2QJf9/o0UWDEr94SV48VFkXV
         2PKA==
X-Gm-Message-State: APjAAAXKLHN+xEB2n7J4frGuFtBBFG/ti13yTJSBtxnQ0wmQTV2UWZeq
        SuC+eCunEmHgMKYEXxyEJFg2hg==
X-Google-Smtp-Source: APXvYqypvDYVEIi2coNpT8dQkZqVWsfifxJFC34M3rgAqpdC2UkEvlQr+hKDYAZzAqBvJLl7AfGh2w==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr3671156wro.276.1559247802709;
        Thu, 30 May 2019 13:23:22 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 74sm2561695wma.7.2019.05.30.13.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 13:23:22 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v2 bpf-next] bpf: doc: update answer for 32-bit subregister question
Date:   Thu, 30 May 2019 21:23:18 +0100
Message-Id: <1559247798-4670-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There has been quite a few progress around the two steps mentioned in the
answer to the following question:

  Q: BPF 32-bit subregister requirements

This patch updates the answer to reflect what has been done.

v2:
 - Add missing full stop. (Song Liu)
 - Minor tweak on one sentence. (Song Liu)

v1:
 - Integrated rephrase from Quentin and Jakub

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 Documentation/bpf/bpf_design_QA.rst | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index cb402c5..12a246f 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -172,11 +172,31 @@ registers which makes BPF inefficient virtual machine for 32-bit
 CPU architectures and 32-bit HW accelerators. Can true 32-bit registers
 be added to BPF in the future?
 
-A: NO. The first thing to improve performance on 32-bit archs is to teach
-LLVM to generate code that uses 32-bit subregisters. Then second step
-is to teach verifier to mark operations where zero-ing upper bits
-is unnecessary. Then JITs can take advantage of those markings and
-drastically reduce size of generated code and improve performance.
+A: NO.
+
+But some optimizations on zero-ing the upper 32 bits for BPF registers are
+available, and can be leveraged to improve the performance of JITed BPF
+programs for 32-bit architectures.
+
+Starting with version 7, LLVM is able to generate instructions that operate
+on 32-bit subregisters, provided the option -mattr=+alu32 is passed for
+compiling a program. Furthermore, the verifier can now mark the
+instructions for which zero-ing the upper bits of the destination register
+is required, and insert an explicit zero-extension (zext) instruction
+(a mov32 variant). This means that for architectures without zext hardware
+support, the JIT back-ends do not need to clear the upper bits for
+subregisters written by alu32 instructions or narrow loads. Instead, the
+back-ends simply need to support code generation for that mov32 variant,
+and to overwrite bpf_jit_needs_zext() to make it return "true" (in order to
+enable zext insertion in the verifier).
+
+Note that it is possible for a JIT back-end to have partial hardware
+support for zext. In that case, if verifier zext insertion is enabled,
+it could lead to the insertion of unnecessary zext instructions. Such
+instructions could be removed by creating a simple peephole inside the JIT
+back-end: if one instruction has hardware support for zext and if the next
+instruction is an explicit zext, then the latter can be skipped when doing
+the code generation.
 
 Q: Does BPF have a stable ABI?
 ------------------------------
-- 
2.7.4

