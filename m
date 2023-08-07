Return-Path: <bpf+bounces-7170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D477270F
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A144A281356
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBA10960;
	Mon,  7 Aug 2023 14:07:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A510953
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 14:07:43 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BC19B4
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:07:25 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 725D9C15AE03
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691417230; bh=ube2C51H/pGyfuwMn6lazlJyXzbjNc2M20wGcD6YCGw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=u2s7YMGpmO4NXu4w44QMqBIQtzA3oYpQ/m1faiBpH1ZT3Q/AbEf6J+D+M5FetUHbM
	 PQA9viigyM/BauDEfGzJcqMiyoXtrZv7RYT6YVTrB/3FBKfdIcQ+B4rD+PBcS1IcJG
	 yOygWZrkKal4C9qCmxQVNmzY1mgOlBcUIyTGpOX0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug  7 07:07:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 51FABC1524D3;
	Mon,  7 Aug 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691417230; bh=ube2C51H/pGyfuwMn6lazlJyXzbjNc2M20wGcD6YCGw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=u2s7YMGpmO4NXu4w44QMqBIQtzA3oYpQ/m1faiBpH1ZT3Q/AbEf6J+D+M5FetUHbM
	 PQA9viigyM/BauDEfGzJcqMiyoXtrZv7RYT6YVTrB/3FBKfdIcQ+B4rD+PBcS1IcJG
	 yOygWZrkKal4C9qCmxQVNmzY1mgOlBcUIyTGpOX0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4CA73C1522B9
 for <bpf@ietfa.amsl.com>; Mon,  7 Aug 2023 07:07:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLMGLwd7v4pN for <bpf@ietfa.amsl.com>;
 Mon,  7 Aug 2023 07:07:05 -0700 (PDT)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F230FC1524D3
 for <bpf@ietf.org>; Mon,  7 Aug 2023 07:07:04 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bca6c06e56so4099512a34.1
 for <bpf@ietf.org>; Mon, 07 Aug 2023 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691417224; x=1692022024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RKo8nBg2SOqa0ec9RKIPQwMcKqlyBrBVHKJDKTiNIJw=;
 b=YG6wsiHHXZAdyluSxlFs0s7ByDo8WP9//kUSqkllmPdU8O8/tZP/X9YOveOdlrSccI
 DSsqoF7OUppG+2dooy5HMcIMuW2f8QkG1Qh31dykdiw3bb7n2HY+UIfORKZ1/N7xTxT5
 oziOhwWQ3UMnba/ZYxiY2AeS7uzbOh0BAXYLrYBc6SYOXOYkGva4Eynx3j3zYk9OfcNk
 cqn6uB6gRt7LAq7N3KTclR+aotKCk5BT3U7e3oMZ6xv1T4Zu6SxAktDulr+24EtSKvv0
 DWE1frSDT5FeGj9JuLUtK8oHW3zmeOKQ8w9B44/fPcZSDUG94PTRUa9gBLeC47mjNZOF
 EI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417224; x=1692022024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKo8nBg2SOqa0ec9RKIPQwMcKqlyBrBVHKJDKTiNIJw=;
 b=ORfMVaf6ghOWfgZ+9uDDqOef3JXQEfxokmbVQ5gDkgyKlf7qmEYzZ3Cvm4s5Nn5Rlq
 r0TwSsdxafJeLyra1JIyhtVFD87lj2wsgFfQI3IxOuEAcm/BwGvFkPbcTdMN/+YPerhH
 KIVKL3sICaDWt6r8NUq26R57FsfHv6+4V+rHjecMdXKYEtVGlgc+D34sKW89p7nWkYUs
 xCLi3W31Ea6NONl9/iMqlTGfx1n7Usvn4RZYGuB/xtDYOStPfhaO10xTyg01NJRlerlp
 1xbfcCa6IuLGn0IfF4YofHEQ77ZPamyCmLkxNQ79sELtdSnY5J5ZSLFwRhRtu44kNe9+
 jOdQ==
X-Gm-Message-State: AOJu0YxePFqIkJO8l7XunJHE7o1FcDxNoLWFkpIRi2Sr8K1+Rm88DQYH
 jfOKJMbJMyXEapVeCjOb8sugkZ49Xy7rEVSvKy0=
X-Google-Smtp-Source: AGHT+IEoggNdMIDGsRkPz9k+2YWm0Wj5bCgsYO4ksHWEMCf7razAGWREQOhM3TS8d1plQP4W7zozgA==
X-Received: by 2002:a9d:7a5a:0:b0:6b9:9f84:dc8b with SMTP id
 z26-20020a9d7a5a000000b006b99f84dc8bmr10954012otm.19.1691417224131; 
 Mon, 07 Aug 2023 07:07:04 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 b17-20020ac86bd1000000b0040ff25d8712sm2660661qtt.18.2023.08.07.07.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:07:03 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Mon,  7 Aug 2023 10:06:48 -0400
Message-ID: <20230807140651.122484-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/GLM4gSrowalgEUXPBuNJgLRj7pw>
Subject: [Bpf] [PATCH v4 1/1] bpf,
 docs: Formalize type notation and function semantics in ISA standard
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Give a single place where the shorthand for types are defined and the
semantics of helper functions are described.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 82 +++++++++++++++++--
 1 file changed, 74 insertions(+), 8 deletions(-)

 Changelog:
   v1 -> v2:
     - Remove change to Sphinx version
     - Address David's comments
     - Address Dave's comments
   v2 -> v3:
	   - Add information about sign-extending
   v3 -> v4:
	   - Address David's helpful comments!
		 - Remove part 2 (re: sign extension)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 655494ac7af6..25be958130dc 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -10,9 +10,71 @@ This document specifies version 1.0 of the eBPF instruction set.
 Documentation conventions
 =========================
 
-For brevity, this document uses the type notion "u64", "u32", etc.
-to mean an unsigned integer whose width is the specified number of bits,
-and "s32", etc. to mean a signed integer of the specified number of bits.
+For brevity and consistency, this document refers to families
+of types using a shorthand syntax and refers to several expository,
+mnemonic functions when describing the semantics of instructions.
+The range of valid values for those types and the semantics of those
+functions are defined in the following subsections.
+
+Types
+-----
+This document refers to integer types with the notation `SN` to specify
+a type's signedness (`S`) and bit width (`N`), respectively.
+
+.. table:: Meaning of signedness notation.
+
+  ==== =========
+  `S`  Meaning
+  ==== =========
+  `u`  unsigned
+  `s`  signed
+  ==== =========
+
+.. table:: Meaning of bit-width notation.
+
+  ===== =========
+  `N`   Bit width
+  ===== =========
+  `8`   8 bits
+  `16`  16 bits
+  `32`  32 bits
+  `64`  64 bits
+  `128` 128 bits
+  ===== =========
+
+For example, `u32` is a type whose valid values are all the 32-bit unsigned
+numbers and `s16` is a types whose valid values are all the 16-bit signed
+numbers.
+
+Functions
+---------
+* `htobe16`: Takes an unsigned 16-bit number in host-endian format and
+  returns the equivalent number as an unsigned 16-bit number in big-endian
+  format.
+* `htobe32`: Takes an unsigned 32-bit number in host-endian format and
+  returns the equivalent number as an unsigned 32-bit number in big-endian
+  format.
+* `htobe64`: Takes an unsigned 64-bit number in host-endian format and
+  returns the equivalent number as an unsigned 64-bit number in big-endian
+  format.
+* `htole16`: Takes an unsigned 16-bit number in host-endian format and
+  returns the equivalent number as an unsigned 16-bit number in little-endian
+  format.
+* `htole32`: Takes an unsigned 32-bit number in host-endian format and
+  returns the equivalent number as an unsigned 32-bit number in little-endian
+  format.
+* `htole64`: Takes an unsigned 64-bit number in host-endian format and
+  returns the equivalent number as an unsigned 64-bit number in little-endian
+  format.
+* `bswap16`: Takes an unsigned 16-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
+* `bswap32`: Takes an unsigned 32-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
+* `bswap64`: Takes an unsigned 64-bit number in either big- or little-endian
+  format and returns the equivalent number with the same bit width but
+  opposite endianness.
 
 Registers and calling convention
 ================================
@@ -252,19 +314,23 @@ are supported: 16, 32 and 64.
 
 Examples:
 
-``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16 means::
+``BPF_ALU | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
 
   dst = htole16(dst)
+  dst = htole32(dst)
+  dst = htole64(dst)
 
-``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 64 means::
+``BPF_ALU | BPF_TO_BE | BPF_END`` with imm = 16/32/64 means::
 
+  dst = htobe16(dst)
+  dst = htobe32(dst)
   dst = htobe64(dst)
 
 ``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16/32/64 means::
 
-  dst = bswap16 dst
-  dst = bswap32 dst
-  dst = bswap64 dst
+  dst = bswap16(dst)
+  dst = bswap32(dst)
+  dst = bswap64(dst)
 
 Jump instructions
 -----------------
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

