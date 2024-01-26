Return-Path: <bpf+bounces-20370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498283D34B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5731F21C12
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1E1B665;
	Fri, 26 Jan 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Atw6zlfX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092AA14A8D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241658; cv=none; b=NF/QK8jMkV0hozPpie+WKjiRISBnOtD/vOROz208DDH/fjeijcjIdY8bWv9BZ6QSUIevL8bTRG6ayrNRQMyXsYLOhMOFp9CqH7TBuuuoPiPdGPl6unHp1tcJRw6Ku2309gMHRdDmeTYsuGiprtFURRXqbqtcxWCtglESyHFPr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241658; c=relaxed/simple;
	bh=3B1nfAzvBW0dyLVuEMc65aJUE6HiHmUjue5wN21BxKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzlWOtQJfXo3onxSWzz+dtt1EJotvsZHBIC4VnqH785H8CZT4A26SKdCAQYyb09+PjjhI3+2UYDOfauG+xhpqP/ct+Gi6iLrKU9aFqHWo4oi2cAQ0DAHONriHYwu8Ao90SS1b9S9QqE9C6b2Zo90LyUlDNEBSi5czDJY685fSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Atw6zlfX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2856194a91.2
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706241656; x=1706846456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0x31n0EPtABRR56/sibSB0ELoGXe+A/qk2xER5E7aU=;
        b=Atw6zlfXxhFpIp2/CWmzrC5WtR3eTGSBpE748Jb8hwOMEPJXYCNdm0QmcER1K5q78D
         S7nk6JUiX77rPajBTeiwR5iyuGRze1Lqm8U+vg4zOkNcpXRFIEy56L18nQmY3XsrytHj
         +yl6o4B/wIy10W356gv8zcP9SgpYZuRFF5CgJDL2lZS6ErW8JDLIM1HEgpDKtiUb80pc
         Co+jjLBS8Hqqolif1pq4YWY0Wan71Uk5kkMHzZQF4bJUiO2nw6e8VltjfcG4H0frjBE1
         FCQx24llgUKUSsUVQpQ7EA76MzK9l3m51tyS7H2IUgzVNcd9avP9CViu7dldm1YDm1YY
         ru+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241656; x=1706846456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0x31n0EPtABRR56/sibSB0ELoGXe+A/qk2xER5E7aU=;
        b=PZLu0Huqfh6V57uQ9NdfMJbEnObwS52NPegZJkL0RRUgy60UexQjC5gfyARgLM6vTe
         I3Xhkn/V4NsZIUHr6VXbemvtLTY+bOBWsUN9IukVB8rXh8b7ksUTw67p9RtRtRFir8A3
         U8sJ7LCg8+Nld9BhfO2mYVCea3H07Zo1ou9bHBByRnEKLfSUVjYEmed7iGN0aX0gtlWb
         yPbMsq7kpN6NqwEFzkqv2C3Ob5VR8cCJABJZ6JztHf2fP5fsj5JM5ENSUN8YH6OmYqVG
         erw0ioPnDS2LPPmZxX7QadmSx/U9+9rxofcpYeW8yTHUD6dT7PDicS0SodUEzf2hWHaS
         xpew==
X-Gm-Message-State: AOJu0Yw8TbFKGpmZway2N6DqwPRuz3ckUFaY9EoqdQXt409HS6/A97tU
	ZGfhlBusRsJk4DllwXJ+ybJXhWa+Vp6WEn3ne30u8ct7mUm9rV2y3X8H9Am7xFg=
X-Google-Smtp-Source: AGHT+IGvqszPt/mStnydxNWexu1RZXFyTu1pyTnXJMLN5VPaWle/TBh7mfq4wLUW7667ON/mxf5WHA==
X-Received: by 2002:a17:90b:3842:b0:290:415d:4a46 with SMTP id nl2-20020a17090b384200b00290415d4a46mr560630pjb.66.1706241655978;
        Thu, 25 Jan 2024 20:00:55 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b001d74502d261sm250863plb.115.2024.01.25.20.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 20:00:55 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Clarify definitions of various instructions
Date: Thu, 25 Jan 2024 20:00:50 -0800
Message-Id: <20240126040050.8464-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify definitions of several instructions:
* BPF_NEG does not support BPF_X
* BPF_CALL does not support BPF_JMP32 or BPF_X
* BPF_EXIT does not support BPF_X
* BPF_JA does not support BPF_X (was implied but not explicitly stated)

Also fix a typo in the wide instruction figure where
the field is actually named "opcode" not "code".

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 51 ++++++++++---------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index d17a96c62..af43227b6 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -174,12 +174,12 @@ and imm containing the high 32 bits of the immediate value.
 This is depicted in the following figure::
 
         basic_instruction
-  .-----------------------------.
-  |                             |
-  code:8 regs:8 offset:16 imm:32 unused:32 imm:32
-                                 |              |
-                                 '--------------'
-                                pseudo instruction
+  .------------------------------.
+  |                              |
+  opcode:8 regs:8 offset:16 imm:32 unused:32 imm:32
+                                   |              |
+                                   '--------------'
+                                  pseudo instruction
 
 Thus the 64-bit immediate value is constructed as follows:
 
@@ -320,6 +320,9 @@ bit operands, and zeroes the remaining upper 32 bits.
 operands into 64 bit operands.  Unlike other arithmetic instructions,
 ``BPF_MOVSX`` is only defined for register source operands (``BPF_X``).
 
+The ``BPF_NEG`` instruction is only defined when the source bit is clear
+(``BPF_K``).
+
 Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
 for 32-bit operations.
 
@@ -375,27 +378,27 @@ Jump instructions
 otherwise identical operations.
 The 'code' field encodes the operation as below:
 
-========  =====  ===  ===========================================  =========================================
-code      value  src  description                                  notes
-========  =====  ===  ===========================================  =========================================
-BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP class
-BPF_JA    0x0    0x0  PC += imm                                    BPF_JMP32 class
+========  =====  ===  ===============================  =============================================
+code      value  src  description                      notes
+========  =====  ===  ===============================  =============================================
+BPF_JA    0x0    0x0  PC += offset                     BPF_JMP | BPF_K only
+BPF_JA    0x0    0x0  PC += imm                        BPF_JMP32 | BPF_K only
 BPF_JEQ   0x1    any  PC += offset if dst == src
-BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
-BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
+BPF_JGT   0x2    any  PC += offset if dst > src        unsigned
+BPF_JGE   0x3    any  PC += offset if dst >= src       unsigned
 BPF_JSET  0x4    any  PC += offset if dst & src
 BPF_JNE   0x5    any  PC += offset if dst != src
-BPF_JSGT  0x6    any  PC += offset if dst > src                    signed
-BPF_JSGE  0x7    any  PC += offset if dst >= src                   signed
-BPF_CALL  0x8    0x0  call helper function by address              see `Helper functions`_
-BPF_CALL  0x8    0x1  call PC += imm                               see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID               see `Helper functions`_
-BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
-BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
-BPF_JLE   0xb    any  PC += offset if dst <= src                   unsigned
-BPF_JSLT  0xc    any  PC += offset if dst < src                    signed
-BPF_JSLE  0xd    any  PC += offset if dst <= src                   signed
-========  =====  ===  ===========================================  =========================================
+BPF_JSGT  0x6    any  PC += offset if dst > src        signed
+BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
+BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
+BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
+BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
+BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
+BPF_JSLT  0xc    any  PC += offset if dst < src        signed
+BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
+========  =====  ===  ===============================  =============================================
 
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
-- 
2.40.1


