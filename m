Return-Path: <bpf+bounces-7068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535AB770D6A
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671C31C21744
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500B1C3F;
	Sat,  5 Aug 2023 03:09:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECB31851
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 03:09:54 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D1A526D
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:32 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 55582C15171E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691204972; bh=6HiRKNAPtcuqLC4ZtBpL2leBfsIqBQRZWxvz5+aqx/Q=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=jq3iDPFt7eumNSWEeSyNLFt1/OO87rWCzYeF103S50SHzaTPB5uW2ogEv8MMQ+yms
	 SFAi4dc9tAUSBRD8iae7AJ3veO6f8MtfCfpGlZlUEFrxhQHXtdES2FEPPiURIpkRd0
	 QEV57YaZVm3GseIRNUcC7BVnWkNUCFfbxT8Dn+3w=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Aug  4 20:09:32 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 18E6DC151067;
	Fri,  4 Aug 2023 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691204972; bh=6HiRKNAPtcuqLC4ZtBpL2leBfsIqBQRZWxvz5+aqx/Q=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=jq3iDPFt7eumNSWEeSyNLFt1/OO87rWCzYeF103S50SHzaTPB5uW2ogEv8MMQ+yms
	 SFAi4dc9tAUSBRD8iae7AJ3veO6f8MtfCfpGlZlUEFrxhQHXtdES2FEPPiURIpkRd0
	 QEV57YaZVm3GseIRNUcC7BVnWkNUCFfbxT8Dn+3w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C902CC14CE5E
 for <bpf@ietfa.amsl.com>; Fri,  4 Aug 2023 20:09:30 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1Zsj6_nqgAE for <bpf@ietfa.amsl.com>;
 Fri,  4 Aug 2023 20:09:28 -0700 (PDT)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 9E05AC14CE39
 for <bpf@ietf.org>; Fri,  4 Aug 2023 20:09:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-76731802203so211745285a.3
 for <bpf@ietf.org>; Fri, 04 Aug 2023 20:09:28 -0700 (PDT)
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
 b=D+Ey2SnZgCN4cCOLrsYzgK8R/6KyVPRJSNn89m9rX4ivtsqw761Log1aknED/9NBxz
 0xTxvnqvtD26wKCNU0Oh/yUtEUw8fwInwEXjG83fTzS1iPpw/DAOEk4susZxyDlvI/YS
 0E+KINdryF/HAXBlihMOVBwE96e4SVtasFO/SsvGDv5pMKSqybwf6/52WrGTA7mrA1KC
 Tq58/yIFInAvONaqtn7G8t33tNMaH0M1uWanJ8mJjdHAEvuido/xiGLkscGU3Y5HUAyJ
 ySQzyGPQ9ZxjbvOK8EfyWjUfG2U7Uf3+asXEvo/Fd5GsKHPzSfNyjkz1qYkw5jQO7eMi
 ddGg==
X-Gm-Message-State: AOJu0YxcTwGdPBSiXqR+w1lQB4l+J27Fy4BWwP7c86F97lozA8ffzCr7
 ceTAIFeHa834R2EZWtTZrHPsoTzBmxlqRlZWh3o=
X-Google-Smtp-Source: AGHT+IFBiNl4C+J7kd1Kc65O3k0MhQqLgt17VqLzK6MSi/9z00IjFUygbdYd/BVaVW+tmCz957UKHg==
X-Received: by 2002:a05:620a:31a9:b0:76c:bd05:f81f with SMTP id
 bi41-20020a05620a31a900b0076cbd05f81fmr4181660qkb.63.1691204967036; 
 Fri, 04 Aug 2023 20:09:27 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a0cf594000000b0063cbb29731dsm1124501qvm.66.2023.08.04.20.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 20:09:26 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Fri,  4 Aug 2023 23:09:18 -0400
Message-ID: <20230805030921.52035-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wZX5h4jrJ80as8a48ITbYryHLw4>
Subject: [Bpf] [PATCH v3 1/2] bpf,
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

