Return-Path: <bpf+bounces-7066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AED770D68
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 05:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FF61C2174B
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C617F5;
	Sat,  5 Aug 2023 03:09:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083315A6
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 03:09:52 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E25259
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7672303c831so211717585a.2
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 20:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691204967; x=1691809767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fojs37CSusgXFNPD59YqeUvU0yZC7xWXLmI6cdbNptY=;
        b=sV1kI8ksyHQpK3WcPSE+nvxe7gI/zDfgwmmUmn5e8JbvxhdJJ0sYwUddlhL7zX9nBr
         TMWbvzubRuW4oNXhazswuCjRyGZlftC+CCx4e66FfMCjYroEN6rK+A+vCqEqonj9HgFB
         bswjyW690vhfnLslpF8dDv7xDZh5/xfmQeFAprrvxZINmaLvazojm/Kt45kAg/Ws+nZH
         gFCNFNXo2mxWUCMtlsFcshjfHvH4ts+byDAfnSDWsof6YrvbaPLECIDiwM92uNwRRseC
         QpEgTmfOCsBBqPytSnPmcENmr/+k62vG9bZCkYYN4NwBXO+3en/7ql3UBTUIOWf2Sl0s
         6ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691204967; x=1691809767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fojs37CSusgXFNPD59YqeUvU0yZC7xWXLmI6cdbNptY=;
        b=efCHOIu3PN5fIX1heM5KEWZz6hXfEFret6ZA34xOzev867eaIK24nWsfoABWSWStRl
         Zs/uABSUpg/FjmOlyQpr6sscq8pIkLyxttuye06LD5G4XymwLIBzzgcev1mHSS7S7iXr
         FcXnaLtN2tp7TwkNm7ffjoHP5uUf5E4gXwh5BjFUJfv9lU5g6YMHb6oX+6LZvJSRfUGI
         XhAvb7kYzwgukJMxif45S+eQrS1X9maD1Gc3lKuJHNb6WhVGO+xJGvYYXSFQeHttxeJ1
         tvt7YQz3QwvBHF13YKpgeGSjglOvgXyn6qMJx68Q1aQHo6Y2ITKosJXACeXwXbQaaq5Q
         vifQ==
X-Gm-Message-State: AOJu0YzODTUBtzuJo7poKcHw05ovFVJdACqV2XpFnsix6S409jTl+R0B
	C6j6IUzgiEtw7aQst5zwd/uWWbn5vhyHkhS8od0=
X-Google-Smtp-Source: AGHT+IFBiNl4C+J7kd1Kc65O3k0MhQqLgt17VqLzK6MSi/9z00IjFUygbdYd/BVaVW+tmCz957UKHg==
X-Received: by 2002:a05:620a:31a9:b0:76c:bd05:f81f with SMTP id bi41-20020a05620a31a900b0076cbd05f81fmr4181660qkb.63.1691204967036;
        Fri, 04 Aug 2023 20:09:27 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id k20-20020a0cf594000000b0063cbb29731dsm1124501qvm.66.2023.08.04.20.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:09:26 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v3 1/2] bpf, docs: Formalize type notation and function semantics in ISA standard
Date: Fri,  4 Aug 2023 23:09:18 -0400
Message-ID: <20230805030921.52035-1-hawkinsw@obs.cr>
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

Give a single place where the shorthand for types are defined, the
semantics of helper functions are described, and certain terms can
be defined.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 79 +++++++++++++++++--
 1 file changed, 71 insertions(+), 8 deletions(-)

 Changelog:
   v1 -> v2:
	   - Remove change to Sphinx version
		 - Address David's comments
		 - Address Dave's comments
   v2 -> v3:
	   - Add information about sign extending

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 655494ac7af6..fe296f35e5a7 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -10,9 +10,68 @@ This document specifies version 1.0 of the eBPF instruction set.
 Documentation conventions
 =========================
 
-For brevity, this document uses the type notion "u64", "u32", etc.
-to mean an unsigned integer whose width is the specified number of bits,
-and "s32", etc. to mean a signed integer of the specified number of bits.
+For brevity and consistency, this document refers to families
+of types using a shorthand syntax and refers to several expository,
+mnemonic functions when describing the semantics of opcodes. The range
+of valid values for those types and the semantics of those functions
+are defined in the following subsections.
+
+Types
+-----
+This document refers to integer types with a notation of the form `SN`
+that succinctly defines whether their values are signed or unsigned
+numbers and the bit widths:
+
+=== =======
+`S` Meaning
+=== =======
+`u` unsigned
+`s` signed
+=== =======
+
+===== =========
+`N`   Bit width
+===== =========
+`8`   8 bits
+`16`  16 bits
+`32`  32 bits
+`64`  64 bits
+`128` 128 bits
+===== =========
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
@@ -252,19 +311,23 @@ are supported: 16, 32 and 64.
 
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


