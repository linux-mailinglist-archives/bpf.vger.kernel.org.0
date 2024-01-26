Return-Path: <bpf+bounces-20371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1783D34D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290F9B22111
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3EB660;
	Fri, 26 Jan 2024 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IQ3Eg2ek";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qUsI9ZDM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TEqOs2nO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACC125B7
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241669; cv=none; b=KNg2iIcMYhqgqVq1AXmu2c6FGbhrXJjN0R4P9061DS+qSpM/qTFIcKAiAEezyZNZOVOnTwWRqaNm08oWVqGM4vPbODeZ+33egE+Zd+eWpwCSH7Z5+AFz4HFseBR8lxr1hiyylZ2UbimGmkIMReZddjWAzH2aOjdKghh9J+BdtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241669; c=relaxed/simple;
	bh=ynjMyen32ouSSi3H048rO0SGdLUeVMoCr97iz77MK8A=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=lba2Moedt4E4eJCSSNNoc1FH/2rCg8gA1cBapyAwEW495V9dPp6oeIH64YrRC2R9fLiV3UcwuyHPomFB5LV7BlXzTMIMDX6dzJ749EPchsEIZUZvW/8s67X2fx3Dx4R3qb7mT1g4SPoPaxTbg23IVn2LcwZOB389v7ivsnD3unU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IQ3Eg2ek; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=qUsI9ZDM reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TEqOs2nO reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 08DCDC14CEF9
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706241663; bh=ynjMyen32ouSSi3H048rO0SGdLUeVMoCr97iz77MK8A=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IQ3Eg2ek2EqCtbpVsN7T7Y1JRSkmJeTanAlbSNe3NhRdF7WdeRUnbYR2mqJglVLYI
	 tNcUl98UpGKxenEa4St4W4zLsczv6/yxG7Rwm7HkrdadJTMNSgcxhCVnJG4ChLn3u6
	 4z79rk9Ceyyj4jaUT6wjkyB6jQA9iVTwHZuiaLdE=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C57D0C14F6B5;
 Thu, 25 Jan 2024 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706241662; bh=ynjMyen32ouSSi3H048rO0SGdLUeVMoCr97iz77MK8A=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=qUsI9ZDM1qV+ju8Zi9vcyNS+3OUBbdo9CjBASc3nUV0i1PbMEMZCDYfPz3tquMLqC
 wOcELZs6Qse3HXbFaRzkhndNtPA73Ps+/KATsqTshwNOrwkreEQcBDv04WPaiXdfpz
 IAL9bGeiu1kHtdhyWwjCvwm9Jszm2UxVuanh2l2c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1764DC14F6B5
 for <bpf@ietfa.amsl.com>; Thu, 25 Jan 2024 20:01:01 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXKigahOVsiK for <bpf@ietfa.amsl.com>;
 Thu, 25 Jan 2024 20:00:57 -0800 (PST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0AADEC14F5FB
 for <bpf@ietf.org>; Thu, 25 Jan 2024 20:00:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2906dffd8ddso4867075a91.3
 for <bpf@ietf.org>; Thu, 25 Jan 2024 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706241656; x=1706846456; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F0x31n0EPtABRR56/sibSB0ELoGXe+A/qk2xER5E7aU=;
 b=TEqOs2nO5EtDyc2HH6pjXjaZCRzrp07MNQB5Nq6/nahwHWodfIYkPwOE7dyudn26rw
 UElshWq4P6K4QOZvKBG1mhXGsW+/ocACcz+Z6zvvYCqQBmoqx1LspOhyZ3Opm7SSpIY3
 FpJT4I2+ncFzqZkCfEhXzqn1uA5J+aZxFym8gQLXupW7YzNzv25fzvWFKh/CHzP231/s
 TJ2HY7yqhfk6StOLBr4QqcfbJfvbDLQYyFIQ53OwyX12BjE2lpkBnW9AEMV/SOJfUKEL
 1vXlreQRMFbocALKLA5hP5CV4KvgUksGPOa0HECa1Aqvgu/VhHMa8tOwaDggySWJ/bEr
 8TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706241656; x=1706846456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0x31n0EPtABRR56/sibSB0ELoGXe+A/qk2xER5E7aU=;
 b=jC8NbJqpD9K0tJ/+Tb1e8bl0NedQ60KWofVcYR8f+npf83yaJBrp7qZSaTrgD3pSi0
 RVFqJi9w4NwarahXNwVJw8LbROEKLaxCwDCOzCowrD9JwJ6WXwOgskq6hEcUf0fRweKh
 lcmoTLcwffpssuJ0QQwR62lY5BAg4kiBt0BI+LElXLqcGqzBsimyVsNSpZ9P9Wusmpw0
 hUyIxJjgnQw7h2z9fF89YmiesKzm9UM1iVJ2xzq2nzqZ7l0aURQVh7USp+kIGVj92ZGA
 7HsgnRMIt1Ve16xBslwfIKXXuYDp+50fZy4I3yJVBSKNY66LRZkI14q0Lf0nsWUDnQFl
 FUHg==
X-Gm-Message-State: AOJu0Yy6JxVo0XfpfgqqLfCEq/XIJAYErUa6+WYgr5a6yENJzi0bXMBD
 keJtThe9djKI750cGBQFneK+UBoPjWwfpsOlTeTTecNjkUmj+2PF
X-Google-Smtp-Source: AGHT+IGvqszPt/mStnydxNWexu1RZXFyTu1pyTnXJMLN5VPaWle/TBh7mfq4wLUW7667ON/mxf5WHA==
X-Received: by 2002:a17:90b:3842:b0:290:415d:4a46 with SMTP id
 nl2-20020a17090b384200b00290415d4a46mr560630pjb.66.1706241655978; 
 Thu, 25 Jan 2024 20:00:55 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 jz6-20020a170903430600b001d74502d261sm250863plb.115.2024.01.25.20.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 20:00:55 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Thu, 25 Jan 2024 20:00:50 -0800
Message-Id: <20240126040050.8464-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/y6SpFG1-y0G09lW-Ib5BbTf0jHo>
Subject: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify definitions of various instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

