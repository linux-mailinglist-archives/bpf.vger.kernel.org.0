Return-Path: <bpf+bounces-32823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DC913743
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2702830F3
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 01:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ACD747F;
	Sun, 23 Jun 2024 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hQheoriq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913A5CB8
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719107738; cv=none; b=OuwZxb7Kj+gNbD0fRqly791D+Yl21AXuw1ZjIZSEzrFjbIW3Uc2PBhWTk8qBsbop/yt8hGnPi1RPzYCWJQCyZjOneu4+pLGE/ckwksgdH/8W+aZ6RlKFN+tnr04glIHiaCeeIHHpkpt2IVPmqvP81cxj1FrC7ZEhaxqK1e047eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719107738; c=relaxed/simple;
	bh=qVdZynof7qdYZWU1dYsCnqtmXJzK31VTd6bIz1e83n0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JixuUHBi8wSpr+w3XoFQW89gcb0YQW3CxK898Q9FO1Tk3U4lznAGMe4vK3o7faI+9CXG7ymNIpuwh4B3jQ6faRpJivt2Y5PXqj3nTKysp/79rK2JaSC+b+o3LCeMmwofFptIWDjD9Sjz0oik/DOmAqcHCIvdLJV9KwQOCBG7tVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hQheoriq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7067108f2cdso368327b3a.1
        for <bpf@vger.kernel.org>; Sat, 22 Jun 2024 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719107735; x=1719712535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbF8PtTy7Xfc8Y63Ge1vK+fN2uAE3hJ07nBHqRKLDB8=;
        b=hQheoriqbu5TuTbab5um/H0SUnGm0/rKgjXWr3MgzRDRPxnTl4pJArL6eBMkDnGFj9
         VFk35D/m2uOe6CgM0tyTXgvKF0aYDCdyTVkNSeudkH5w5r0/k5KhkYNj6+1DUU0Bg7ID
         Md5W3W4NNINgbft2Lyeoakqo1P+ETJYNLOBMPQPKGXK10qybSLgZn1+VWcnfG833w1X0
         NzKTXNuCYAEPLro944Ww6jTIPOxUYRfy5HLaWu5XJPAMzhdUlvhM1gJFp4tqFr+8I0p8
         R9XRGJmhOG7yeD+I3gl5UUM6D2TKVQqEg+XblXK5oGeVNiTd90d+hgA3UThAT8q5jBXG
         h0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719107735; x=1719712535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbF8PtTy7Xfc8Y63Ge1vK+fN2uAE3hJ07nBHqRKLDB8=;
        b=XY3sYJ+UIrR7TXlz7UVVYmlKlY82SB73Bs4UMx+y/bW54gspKebO5NFAkir3PzFIWT
         O5CYA1/cF3veWjzTZl9d6PjSW/TrmZGE7e2Tq/EijZO9zUGWg0Ldkz4U17+qrJeIelpc
         6nu5jsHLYX8bRkvVFdHL3EK2llH7Uav/QQ+9ylR9PnJuUACh7bYtzE/ncAFvR4ZQq7r5
         X1BgoyehQAzJA68iJQRM+rrtNLNImIhm98FRRXH4TlGdPT5fQRNFG9ISCAhuP3tlDeUg
         9Zb5Hcw+fkW3oS3qUCrnlZkzcJI77+PSaAXEc2i+K1GsHe973q9MxExIMTmi4Xcrg2pS
         LsBw==
X-Gm-Message-State: AOJu0YyiHngNv2YQZqHAYAkOusbctSv2JhlTwigFpRav0aJdaDX8HUgR
	qmDR/IM/gP5H9FmFeojHs+22YeOFhjmCj4wLbPGpMEPqTPXU/1o9CEIspiNr
X-Google-Smtp-Source: AGHT+IHJPBrI42xZdKt+PS5aMfU1GbhmjqaDZWaRL1/2TN6QtDyfMIv1m8ilk+LHoXG6XwQU5xX0Ng==
X-Received: by 2002:aa7:8116:0:b0:705:c273:d19 with SMTP id d2e1a72fcca58-70670eaf285mr1683865b3a.12.1719107735346;
        Sat, 22 Jun 2024 18:55:35 -0700 (PDT)
Received: from ubuntu2310.. (64-119-15-123.fiber.ric.network. [64.119.15.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129bd03sm3711333b3a.163.2024.06.22.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:55:34 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next] bpf, docs: Address comments from IETF Area Directors
Date: Sat, 22 Jun 2024 18:55:31 -0700
Message-Id: <20240623015531.9433-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does the following to address IETF feedback:

* Remove mention of "program type" and reference future
  docs (and mention platform-specific docs exist) for
  helper functions and BTF. Addresses Roman Danyliw's
  comments based on GENART review from Ines Robles [0].

* Add reference for endianness as requested by John
  Scudder [1].

* Added bit numbers to top of 32-bit wide format diagrams
  as requested by Paul Wouters [2].

* Added more text about why BPF doesn't stand for anything, based
  on text from ebpf.io [3], as requested by Eric Vyncke and
  Gunter Van de Velde [4].

* Replaced "htobe16" (and similar) and the direction-specific
  description with just "be16" (and similar) and a direction-agnostic
  description, to match the direction-agnostic description in
  the Byteswap Instructions section. Based on feedback from Eric
  Vyncke [5].

[0] https://mailarchive.ietf.org/arch/msg/bpf/DvDgDWOiwk05OyNlWlAmELZFPlM/

[1] https://mailarchive.ietf.org/arch/msg/bpf/eKNXpU4jCLjsbZDSw8LjI29M3tM/

[2] https://mailarchive.ietf.org/arch/msg/bpf/hGk8HkYxeZTpdu9qW_MvbGKj7WU/

[3] https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for

[4] https://mailarchive.ietf.org/arch/msg/bpf/i93lzdN3ewnzzS_JMbinCIYxAIU/

[5] https://mailarchive.ietf.org/arch/msg/bpf/KBWXbMeDcSrq4vsKR_KkBbV6hI4/

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 .../bpf/standardization/instruction-set.rst   | 80 +++++++++++--------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 398f27bab..84f581dd2 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -5,12 +5,19 @@
 BPF Instruction Set Architecture (ISA)
 ======================================
 
-eBPF (which is no longer an acronym for anything), also commonly
+eBPF, also commonly
 referred to as BPF, is a technology with origins in the Linux kernel
 that can run untrusted programs in a privileged context such as an
 operating system kernel. This document specifies the BPF instruction
 set architecture (ISA).
 
+As a historical note, BPF originally stood for Berkeley Packet Filter,
+but now that it can do so much more than packet filtering, the acronym
+no longer makes sense. BPF is now considered a standalone term that
+doesn't stand for anything.  The original BPF is sometimes referred to
+as cBPF (classic BPF) to distinguish it from the now widely deployed
+eBPF (extended BPF).
+
 Documentation conventions
 =========================
 
@@ -18,7 +25,7 @@ The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
 "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
 "OPTIONAL" in this document are to be interpreted as described in
 BCP 14 `<https://www.rfc-editor.org/info/rfc2119>`_
-`RFC8174 <https://www.rfc-editor.org/info/rfc8174>`_
+`<https://www.rfc-editor.org/info/rfc8174>`_
 when, and only when, they appear in all capitals, as shown here.
 
 For brevity and consistency, this document refers to families
@@ -59,24 +66,18 @@ numbers.
 
 Functions
 ---------
-* htobe16: Takes an unsigned 16-bit number in host-endian format and
-  returns the equivalent number as an unsigned 16-bit number in big-endian
-  format.
-* htobe32: Takes an unsigned 32-bit number in host-endian format and
-  returns the equivalent number as an unsigned 32-bit number in big-endian
-  format.
-* htobe64: Takes an unsigned 64-bit number in host-endian format and
-  returns the equivalent number as an unsigned 64-bit number in big-endian
-  format.
-* htole16: Takes an unsigned 16-bit number in host-endian format and
-  returns the equivalent number as an unsigned 16-bit number in little-endian
-  format.
-* htole32: Takes an unsigned 32-bit number in host-endian format and
-  returns the equivalent number as an unsigned 32-bit number in little-endian
-  format.
-* htole64: Takes an unsigned 64-bit number in host-endian format and
-  returns the equivalent number as an unsigned 64-bit number in little-endian
-  format.
+
+The following byteswap functions are direction-agnostic.  That is,
+the same function is used for conversion in either direction discussed
+below.
+
+* be16: Takes an unsigned 16-bit number and converts it between
+  host byte order and big-endian
+  (`IEN137 <https://www.rfc-editor.org/ien/ien137.txt>`_) byte order.
+* be32: Takes an unsigned 32-bit number and converts it between
+  host byte order and big-endian byte order.
+* be64: Takes an unsigned 64-bit number and converts it between
+  host byte order and big-endian byte order.
 * bswap16: Takes an unsigned 16-bit number in either big- or little-endian
   format and returns the equivalent number with the same bit width but
   opposite endianness.
@@ -86,7 +87,12 @@ Functions
 * bswap64: Takes an unsigned 64-bit number in either big- or little-endian
   format and returns the equivalent number with the same bit width but
   opposite endianness.
-
+* le16: Takes an unsigned 16-bit number and converts it between
+  host byte order and little-endian byte order.
+* le32: Takes an unsigned 32-bit number and converts it between
+  host byte order and little-endian byte order.
+* le64: Takes an unsigned 64-bit number and converts it between
+  host byte order and little-endian byte order.
 
 Definitions
 -----------
@@ -441,8 +447,8 @@ and MUST be set to 0.
   =====  ========  =====  =================================================
   class  source    value  description
   =====  ========  =====  =================================================
-  ALU    TO_LE     0      convert between host byte order and little endian
-  ALU    TO_BE     1      convert between host byte order and big endian
+  ALU    LE        0      convert between host byte order and little endian
+  ALU    BE        1      convert between host byte order and big endian
   ALU64  Reserved  0      do byte swap unconditionally
   =====  ========  =====  =================================================
 
@@ -453,19 +459,19 @@ conformance group.
 
 Examples:
 
-``{END, TO_LE, ALU}`` with 'imm' = 16/32/64 means::
+``{END, LE, ALU}`` with 'imm' = 16/32/64 means::
 
-  dst = htole16(dst)
-  dst = htole32(dst)
-  dst = htole64(dst)
+  dst = le16(dst)
+  dst = le32(dst)
+  dst = le64(dst)
 
-``{END, TO_BE, ALU}`` with 'imm' = 16/32/64 means::
+``{END, BE, ALU}`` with 'imm' = 16/32/64 means::
 
-  dst = htobe16(dst)
-  dst = htobe32(dst)
-  dst = htobe64(dst)
+  dst = be16(dst)
+  dst = be32(dst)
+  dst = be64(dst)
 
-``{END, TO_LE, ALU64}`` with 'imm' = 16/32/64 means::
+``{END, TO, ALU64}`` with 'imm' = 16/32/64 means::
 
   dst = bswap16(dst)
   dst = bswap32(dst)
@@ -545,13 +551,17 @@ Helper functions are a concept whereby BPF programs can call into a
 set of function calls exposed by the underlying platform.
 
 Historically, each helper function was identified by a static ID
-encoded in the 'imm' field.  The available helper functions may differ
-for each program type, but static IDs are unique across all program types.
+encoded in the 'imm' field.  Further documentation of helper functions
+is outside the scope of this document and standardization is left for
+future work, but use is widely deployed and more information can be
+found in platform-specific documentation (e.g., Linux kernel documentations).
 
 Platforms that support the BPF Type Format (BTF) support identifying
 a helper function by a BTF ID encoded in the 'imm' field, where the BTF ID
 identifies the helper name and type.  Further documentation of BTF
-is outside the scope of this document and is left for future work.
+is outside the scope of this document and standardization is left for
+future work, but use is widely deployed and more information can be
+found in platform-specific documentation (e.g., Linux kernel documentations).
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.40.1


