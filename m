Return-Path: <bpf+bounces-7169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8177270E
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F401B2811A8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EDC1095B;
	Mon,  7 Aug 2023 14:07:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A410953
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 14:07:29 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9C1BFE
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:07:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bc886d1504so4121957a34.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 07:07:13 -0700 (PDT)
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
        b=hZZK9frOiPoXc5gxpkh5sFbzhowxULFoRJb/NyWUzTOTnO/fPdcHU94MHUtfPyPmes
         Cu94rP6aKvRdeL7TBPIuplDbD3nERO7GRmjNRFUsQ3+B6dJDx2bzHIro5br0jHzZGRCE
         9VhESWJSk+wto+QDJIdEtxGVWuaIKDcmtOkSy9qIcB4XuuxEzYo0vH2baM/3WHsIGAOx
         DLHUYVqc0DnoEzDsxI9MwRYeTfwfV/WvN1A4Wr6/VmVDvu5sijv/GiOccPGD5/d5Yn4C
         JViZe7467oDDRK7EX6VIeOi5JbGKeeac15CTLcpv+liYyGo4g48F0wAjCs512cn8QBn9
         9dVw==
X-Gm-Message-State: AOJu0YxArilCv5MNavsl6t/ZfX5UkO0DVFCgQhQyjWKKu92CcaN3INU0
	WdUjD1NmylS3vFaHRSkiFS/HGAMnjAq46R50g+s=
X-Google-Smtp-Source: AGHT+IEoggNdMIDGsRkPz9k+2YWm0Wj5bCgsYO4ksHWEMCf7razAGWREQOhM3TS8d1plQP4W7zozgA==
X-Received: by 2002:a9d:7a5a:0:b0:6b9:9f84:dc8b with SMTP id z26-20020a9d7a5a000000b006b99f84dc8bmr10954012otm.19.1691417224131;
        Mon, 07 Aug 2023 07:07:04 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86bd1000000b0040ff25d8712sm2660661qtt.18.2023.08.07.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:07:03 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v4 1/1] bpf, docs: Formalize type notation and function semantics in ISA standard
Date: Mon,  7 Aug 2023 10:06:48 -0400
Message-ID: <20230807140651.122484-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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


