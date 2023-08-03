Return-Path: <bpf+bounces-6769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43876DCD7
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D76D281EEB
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 00:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A0186F;
	Thu,  3 Aug 2023 00:45:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5377F
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 00:44:59 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79064269E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 17:44:54 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so2443256d6.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691023493; x=1691628293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4IMVKQB/M/BGfgrAlLnz9LNwg8THKte5dq0iGg0J1A=;
        b=Vn89qSlYVCxnHm7VTfyyeeyHc1oIIb6IqWJo4IFTUekQqYpXXdpdOxbBPm/kaFpe/w
         EcJKADledDEhmpjBfXlpAnSv3r8b2jqIL3nyxkXbz12KSvOzJGJD0i1gQuHXBwP86Joi
         ol5olyg3HnY57Ll1ekSvExePjTF/k/ozziAbZ5R2vNqz/+OojC23B/dhjTKCu0YkS8+a
         jbpq622w4Ck1o1vGEaOd8LQtpfd4O/5H+JSg0X1uZ1J9ltmvaDqCUMT72eRXbn2iL0oX
         1MJeXMk/uyPs7dpxNHBDmDyOJMbIqTeaGPYdt6kz/6CFEcFqjIFKBh+x8pOLqUw1/GxU
         /O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691023493; x=1691628293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4IMVKQB/M/BGfgrAlLnz9LNwg8THKte5dq0iGg0J1A=;
        b=jRCzsBCRUR5MjvgIN9UPGytVFt/WjDXPs8RYe5d/9ZRsCFZgwiPOhPiqG6boTZjfsQ
         Yn/3IJWnOMMUEhaGdE4kznzKNP8/+x8MKt1AD6iEs/vZSgCxUC3Ccu3V9xm/iBa4C2u6
         0p/+udC3biy2+3rZuhuShIuIT82gQlIsio9Rbonew0MDMUf/5DJEXXb6rcabkWmV9zHW
         2lcQKixsh2xbZdqUeeogG/uHXEn6y4jFJjDZARnSfOEkwW/Zt/moWmXXMEEwpg4lPGmJ
         DLRajF0hW3PW8CpsbX/+XHA3RHFz0Idx2ThyzkTGOYouJUnths4jYRWHa+vWjjXaTIfO
         pYlA==
X-Gm-Message-State: ABy/qLa8kWK2CREsKfu6ORIGP27CW7Hhz/2pQrkZZP5Y8BcjJOyBTTM/
	OHB/r2Z3p//jN3X0hSKR80qH8YB1fDj9HNvUxMQ=
X-Google-Smtp-Source: APBJJlGH3NcWBijO5N5zDrgFd6RLatRnR1IpRxSGhVpRDJpf4Kv4aft3NTMlI5ctwegEDltP/8dQ1w==
X-Received: by 2002:a05:620a:14e:b0:76c:d8ce:bc86 with SMTP id e14-20020a05620a014e00b0076cd8cebc86mr2129820qkn.62.1691023493439;
        Wed, 02 Aug 2023 17:44:53 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id p7-20020a0ccb87000000b0063d3744c5c5sm5888640qvk.5.2023.08.02.17.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:44:53 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v2] bpf, docs: Formalize type notation and function semantics in ISA standard
Date: Wed,  2 Aug 2023 20:44:50 -0400
Message-Id: <20230803004450.3006690-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Give a single place where the shorthand for types are defined and the
semantics of helper functions are described.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 79 +++++++++++++++++--
 1 file changed, 71 insertions(+), 8 deletions(-)

 Changelog:
   v1 -> v2:
	   - Remove change to Sphinx version
		 - Address David's comments
		 - Address Dave's comments

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
2.40.1


