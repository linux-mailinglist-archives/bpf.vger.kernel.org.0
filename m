Return-Path: <bpf+bounces-7268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DA774D02
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B085281710
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49286174C4;
	Tue,  8 Aug 2023 21:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2B171C2
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 21:25:16 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47390
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:25:15 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 91073C13AE25
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691529915; bh=5iksRQfX3TG8KheGQYF9vpvnD8n5LjW3v54R37uTPis=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=UuUPQiygw6qn4HKBJPkge9mreoaPmr2ANfmX+nUzO84CSJY+Rs/Mm1C/7d2SXlFHT
	 nLaMUMZUjNXHpItOez346hgE1mIKr2JZFayg+o+7aYyw1CJGmy+IZgR6KiEy95yJqi
	 8zXQhrzqzq/IAfZYWmd6z58bzxm2pFMmV+/1wNvs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Aug  8 14:25:15 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 610E2C15C510;
	Tue,  8 Aug 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691529915; bh=5iksRQfX3TG8KheGQYF9vpvnD8n5LjW3v54R37uTPis=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=UuUPQiygw6qn4HKBJPkge9mreoaPmr2ANfmX+nUzO84CSJY+Rs/Mm1C/7d2SXlFHT
	 nLaMUMZUjNXHpItOez346hgE1mIKr2JZFayg+o+7aYyw1CJGmy+IZgR6KiEy95yJqi
	 8zXQhrzqzq/IAfZYWmd6z58bzxm2pFMmV+/1wNvs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 78EF5C15C509
 for <bpf@ietfa.amsl.com>; Tue,  8 Aug 2023 14:25:13 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
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
 with ESMTP id 4osv37CFmoSw for <bpf@ietfa.amsl.com>;
 Tue,  8 Aug 2023 14:25:09 -0700 (PDT)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 27868C151530
 for <bpf@ietf.org>; Tue,  8 Aug 2023 14:25:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7679ea01e16so487223885a.2
 for <bpf@ietf.org>; Tue, 08 Aug 2023 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691529907; x=1692134707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xvp4iJKE7Z19HMvi7ePuhF1OInAtM666cdZAYnZR9qA=;
 b=y15g18XzsXzeIBvf2/YOvNq0F460/IbLkdKffpnysQn5hiav/TIKXJoYkDX6W5ITk/
 ESWYCaLUhpk4GlvXIrq7FsVm0/6U6LoN6GTKEe0+McdBS7uteo1t/2HO7dNbaYcXnb74
 SF+GI5uiB7sg781isQ6Q2AKyT/DNLCsTzvY8YQmZPZ2XHbj6FOgRYNLCySqPusP0LSPu
 R1oxi/oxfgOvs8CVoqT8Cupm8AJmxuwl6tQ9kNUDR1C3qbEUig9nOKn3t6aliC6hqDWB
 jx1ZicwjP/QUxwvLorebdzsYcMTwJwMQPOegpbE+DkQmW57MFWL6aLqkfyHDHb3/DfIn
 GODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529907; x=1692134707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xvp4iJKE7Z19HMvi7ePuhF1OInAtM666cdZAYnZR9qA=;
 b=d7ldJ6jQ05Mq4ZQ1gyhaqNAIXChHY9dcuaFeToUq2pgxG++hmGc6VppRh3NKrKJ9T8
 FCgUUtS/7kRzSLG4/cIWGfoDUdh/0yuOIjxCnIvagZT62LIL9Q+Ff6oaIs34pUTjB8qP
 h+LFcjP1FzJ7IWE/iAGQYcAERf9jpfVBOv9y9/YbkUrHpNpKJ+8O/uDjxT7Hc8NQ+nKD
 vJqSMZraSQqnvNxY9eKvgA5oY/eZgNL2yH0yhE5a4cQHZ8sWw726H4pmMVb+joUXq4WM
 cB2+TdkYiHskPg1mX5u+YcqDD4vDEiXCTAgJmbol9bnftVsdj0RnsbvVrSDuH9AlZWCr
 gsTQ==
X-Gm-Message-State: AOJu0YwAf78M5vSkqE3VpN77nU7/8mdqsq/MIMCDIaXwYf4c+ZBmAWaN
 FfZKiKsrn6QgSgnWra9HG5psvnXE4XqD4zTtqsA=
X-Google-Smtp-Source: AGHT+IHjJfaJfqZFf9glga7wdJolaaerRIxQmoXjwBM/+ZzH4U/x+W+GZCLYugEIyYXDb512RkYatg==
X-Received: by 2002:ae9:e013:0:b0:76c:d04f:7426 with SMTP id
 m19-20020ae9e013000000b0076cd04f7426mr868737qkk.18.1691529907581; 
 Tue, 08 Aug 2023 14:25:07 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a05620a142300b0075ca4cd03d4sm3556835qkj.64.2023.08.08.14.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:25:07 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>,
	David Vernet <void@manifault.com>
Date: Tue,  8 Aug 2023 17:25:01 -0400
Message-ID: <20230808212503.197834-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/k7TvkgosZdNDlO89_gLxD_av9DU>
Subject: [Bpf] [PATCH v2] bpf,
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
operations in BPF. In addition, fix a very minor typo.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
Acked-by: David Vernet <void@manifault.com>

---
 .../bpf/standardization/instruction-set.rst   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

 Changelog:
   v0 -> v1:
     - Separated from an earlier patch -- fly free, patch!
   v1 -> v2:
     - Fix commit message -- s/eBPF/BPF/
     - Add David's ack.

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

