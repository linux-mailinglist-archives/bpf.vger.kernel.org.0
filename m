Return-Path: <bpf+bounces-7239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF4C773D60
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E611C2030B
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660B14F66;
	Tue,  8 Aug 2023 16:04:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2C1427F
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:04:58 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E61676B5
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:04:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7A5ACC131814
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691472467; bh=8ZumXcidc6CvWtCXYjGy0cZUt3guAegiqPDrgjlS3t0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SIHKzdlo454nGh2Tt8chZ86/5V2rJLANoFwEA8r1wjSWF3nAxvE3nZiFUmvx2J39g
	 ZfzHBhCGYQE5dW/1jeaJLfKf3otrwAnIjxgXJXGoMB7F/VWjMS4ha+j5+YKJ7tbJag
	 Yse7EiP9ghrjPXGF60o4cs9oWaDD/sOi8Uf7gid8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug  7 22:27:47 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4183CC16953C;
	Mon,  7 Aug 2023 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691472467; bh=8ZumXcidc6CvWtCXYjGy0cZUt3guAegiqPDrgjlS3t0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SIHKzdlo454nGh2Tt8chZ86/5V2rJLANoFwEA8r1wjSWF3nAxvE3nZiFUmvx2J39g
	 ZfzHBhCGYQE5dW/1jeaJLfKf3otrwAnIjxgXJXGoMB7F/VWjMS4ha+j5+YKJ7tbJag
	 Yse7EiP9ghrjPXGF60o4cs9oWaDD/sOi8Uf7gid8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 832ECC16953C
 for <bpf@ietfa.amsl.com>; Mon,  7 Aug 2023 22:27:45 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFCPvQc_uvnG for <bpf@ietfa.amsl.com>;
 Mon,  7 Aug 2023 22:27:45 -0700 (PDT)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0A978C16953B
 for <bpf@ietf.org>; Mon,  7 Aug 2023 22:27:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-40648d758f1so38790651cf.0
 for <bpf@ietf.org>; Mon, 07 Aug 2023 22:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691472464; x=1692077264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0EGKCZDiJ4NloB/y09AGL84/WyHzdyCqQmvg2p6jph0=;
 b=SlK3X/knb1NE0E/HaKA1lbWzqUtT8jVg2u5Rs5GcS8HMCNwddtq+rUk/NLKVuhdPgp
 BgsBkakLLw6AIJb+qxhbvGeUygXRrwVhx0PTR5/bGFuEMSKBa/Gyygo5PQfQFKI5HKuH
 g/A8ThNdNiXLU36boTEEJLyqlz4ofN47H7UxJAHLpf6Lh95+J9cxNHXjMygKkpKbwOpo
 wl8wd5QqDh+Ul9DSfYGalQ3wODqsYA4QaiIOLD8muNL6DoM5rBFI38fTjBxkqJOw+Hv9
 WyZzTiJHWZsQ/vZm7//ls6vwUKoLLUzSi6DLyQHY2roRgMIkAOyzxkFObOcUB1ToS5N1
 84Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691472464; x=1692077264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0EGKCZDiJ4NloB/y09AGL84/WyHzdyCqQmvg2p6jph0=;
 b=ljsfynCo8e3hLSIlh+MdefmxlhAdRJAEiqthQ+lsLAt29/WyOY7D2qaha9ugDaa3NF
 d7Uo3i86zLXATOqk9ZSWfqjzEiCAXllR/SEMHcQvc2QFop5SmMy3UA5uNJYxs9dy38jj
 jTMS375q6a+O9IqTrIloZeYKs8uh4baa3F5Iuu9TiCMx1J2Shlp7BufzlM3EPvDUyvMj
 ObQMi67DwKdx7VlWGKy0JeKB9LJbVzzeNLR9HSIVW6FCqRon6XBWIT2Gp16DLRrO+0Li
 9V8cM7xx7OCacKxQh0ZHgzbojlkAAF579hQmBw+KxUdAcbcWh5dGd5UibOah5YHhOy5s
 y88Q==
X-Gm-Message-State: AOJu0YzwV4aYICBseYw2hdmcAk7CUPSv1qwOSHWynGZp5q+oaC824hLW
 7pL0S+PzMrg3d6gLTTmzDlWzoQ==
X-Google-Smtp-Source: AGHT+IEkjCajoCyK/YJSybiGl+0sajLbVjFQGBIgAkqqZ34FP2KU31RJr/WUCkU3reXpydGUSyAhng==
X-Received: by 2002:ac8:5f08:0:b0:405:50b8:dc1d with SMTP id
 x8-20020ac85f08000000b0040550b8dc1dmr14718265qta.48.1691472463721; 
 Mon, 07 Aug 2023 22:27:43 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020ac81204000000b003f9efa2ddb4sm3102304qti.66.2023.08.07.22.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 22:27:43 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Tue,  8 Aug 2023 01:27:32 -0400
Message-ID: <20230808052736.182587-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/s_B2b1uGK-Dl9JkXsOBVPz1psPc>
Subject: [Bpf] [PATCH] bpf,
 docs: Fix small typo and define semantics of sign extension
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

Add additional precision on the semantics of the sign extension
operations in eBPF. In addition, fix a very minor typo.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

 Changelog:
   v0 -> v1:
     - Separated from an earlier patch -- fly free, patch!

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 25be958130dc..4f73e9dc8d9e 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -76,6 +76,27 @@ Functions
   format and returns the equivalent number with the same bit width but
   opposite endianness.
 
+
+Definitions
+-----------
+
+.. glossary::
+
+  Sign Extend
+    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit number, B  ,` means to
+
+    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
+    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the value of
+       the  most-significant bit of `A`.
+
+.. admonition:: Example
+
+  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-endian platform:
+  ::
+
+    A:          10000110
+    B: 11111111 10000110
+
 Registers and calling convention
 ================================
 
@@ -234,7 +255,7 @@ BPF_SMOD   0x90   1        dst = (src != 0) ? (dst s% src) : dst
 BPF_XOR    0xa0   0        dst ^= src
 BPF_MOV    0xb0   0        dst = src
 BPF_MOVSX  0xb0   8/16/32  dst = (s8,s16,s32)src
-BPF_ARSH   0xc0   0        sign extending dst >>= (src & mask)
+BPF_ARSH   0xc0   0        :term:`sign extending<Sign Extend>` dst >>= (src & mask)
 BPF_END    0xd0   0        byte swap operations (see `Byte swap instructions`_ below)
 =========  =====  =======  ==========================================================
 
@@ -266,22 +287,22 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
-The devision and modulo operations support both unsigned and signed flavors.
+The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
-'imm' is first sign extended from 32 to 64 bits, and then interpreted as
-a 64-bit unsigned value.
+'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit unsigned value.
 
 For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
-is first sign extended from 32 to 64 bits, and then interpreted as a
-64-bit signed value.
+is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit signed value.
 
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
-``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
+``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
-``BPF_ALU64 | BPF_MOVSX`` sign extends 8-bit, 16-bit, and 32-bit
+``BPF_ALU64 | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit, 16-bit, and 32-bit
 operands into 64 bit operands.
 
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
@@ -466,7 +487,7 @@ Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW`` and
 Sign-extension load operations
 ------------------------------
 
-The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
+The ``BPF_MEMSX`` mode modifier is used to encode :term:`sign-extension<Sign Extend>` load
 instructions that transfer data between a register and memory.
 
 ``BPF_MEMSX | <size> | BPF_LDX`` means::
-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

