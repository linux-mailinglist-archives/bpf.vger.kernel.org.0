Return-Path: <bpf+bounces-32845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54992913BEE
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2591C21B40
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010DE181BB5;
	Sun, 23 Jun 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kq0De3wp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C620E6
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155098; cv=none; b=fDu1H7QwcUqUMjzmXhoGv90p0EGVWwpi8FirU+El/+cKM5GPkIkN2HM5EA1VGbKLHMfn259Q9950lYxZ7Sqxqh6ztnk39ILtUZjsnN0H6nZIDiCs6sckU/yHgUJoSb9LHda0zUQ6rxwXiGrEaJJKaHdbRSV+4WuKdfW71lbMTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155098; c=relaxed/simple;
	bh=KN86M5KGTNnNYujLykS3fF6q7CsijoIo16X2NbF6rR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQ60mBEvZisFLsfFxlAGUIssIEjPMphoW2KH4YQa3aIsjKxo9DyCumcJ/b9Kaoeo05gfUL1b+0Oe1ZJxw8MjOW9CC8zRhZip6GXzMXu5U4FavYEY8tEwjM34fGk1axxCLJtOloFlcn3CIMjLJpx2jF4OBw4h/vCgr6GbJj15cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kq0De3wp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7066c9741fbso931732b3a.2
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719155096; x=1719759896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m25unrwg1PT9NQnxWCnDwQB5AZXe0LWwBxxc9EgNd5M=;
        b=kq0De3wp1kUC2QrxAZupZqup1bni28tQUbqQLhtasUKU+QFLUvYvZCo22kODjWQbAK
         pwVofH06W12G7Xfdkr+wtn+2cW+dTxVkInVEspPi6R5A2t3aSHMwDBQky6zFzbPEKTJZ
         LgGs45bZUk0s2rXzNcDmqkxUh8IJ1ggXyPh+sRe/9F3c2kRqYFxbKJONY1v25q6+XomD
         kkGebftHcFAnyb04ctmktVhrsY6+1Y0YC0rNYEF4x3R7srqfxsLWVRXOliTLOVzQxiNt
         /yiRmb2973zP7QcrNGuz8GWEpxbuRVmTUX8MtZys9Prgdxdwz5avDG0L1M0mKbqWAhUd
         QY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719155096; x=1719759896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m25unrwg1PT9NQnxWCnDwQB5AZXe0LWwBxxc9EgNd5M=;
        b=o1AK22q7oM0bKxqn+1z1bREn/8bVFJo/JATKLUhp73IALwAr2+HcZGgjxjrNp3IRuI
         KvAXj/FEVs7nOeZGxS9O52LYo3uh3v+19xB9jAk55gBbVKcc7M0X9d1oOU7p0tEHOkZO
         1kFkzU3P02x5zxkJcAghddxvt5eoUiKZmoh97CwPMtbSPMgtdjGjbEW3rBaOghpqFP16
         wx1AbRwgHyDl8+/PXY0PNvvEgaFntc2c7+YQ0xiOxehMYQC4d1elSMc5G4nFC1MlSwhY
         W7c8xCYrGYYShXoxgQr80w/sMIy0hN/bHEatiDf/H/Xt0mudUed5z+XnUP1SmRwqrN7i
         yjRQ==
X-Gm-Message-State: AOJu0YyBw63CyX2C/2hTzOEOcYUWEdux57TQuuFWVSVCjrtnX5siqDMK
	UIoomlggEnI5HugzQvftcFYn67YD+AYzph0nZkuY6lB6gdEjUmZgSCh9bTqv
X-Google-Smtp-Source: AGHT+IGZ2u+dzz5DeD1aYzlJumLG9lmlPnUKug6YfGmCZCgaz+L56b8gr1nDDwdRpSgaTGN3DzpgeA==
X-Received: by 2002:a05:6a20:7b06:b0:1b6:ed32:4622 with SMTP id adf61e73a8af0-1bcf7e2ad78mr2603992637.2.1719155095730;
        Sun, 23 Jun 2024 08:04:55 -0700 (PDT)
Received: from ubuntu2310.. (64-119-15-123.fiber.ric.network. [64.119.15.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512e000asm4727241b3a.179.2024.06.23.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 08:04:55 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: [PATCH bpf-next v2] bpf, docs: Address comments from IETF Area Directors
Date: Sun, 23 Jun 2024 08:04:53 -0700
Message-Id: <20240623150453.10613-1-dthaler1968@gmail.com>
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

---

1->2: Addressed nits from David Vernet

Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
---
 .../bpf/standardization/instruction-set.rst   | 80 +++++++++++--------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 398f27bab..7e636299a 100644
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
+does not stand for anything.  The original BPF is sometimes referred to
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
+found in platform-specific documentation (e.g., Linux kernel documentation).
 
 Platforms that support the BPF Type Format (BTF) support identifying
 a helper function by a BTF ID encoded in the 'imm' field, where the BTF ID
 identifies the helper name and type.  Further documentation of BTF
-is outside the scope of this document and is left for future work.
+is outside the scope of this document and standardization is left for
+future work, but use is widely deployed and more information can be
+found in platform-specific documentation (e.g., Linux kernel documentation).
 
 Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.40.1


