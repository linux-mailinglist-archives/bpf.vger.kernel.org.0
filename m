Return-Path: <bpf+bounces-22443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367A85E4AA
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E9C1C23008
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFBD83CD8;
	Wed, 21 Feb 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="F6lQU/RM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="J4wyKb2b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JlRiHQk2"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93382D9B
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536954; cv=none; b=gjIAh2GYE9ZijEv6wDpX9o98MgKuYmkOxrStuiFyxeFWA0tN7WxCpnyaDClXI+lcOrvmeaaF6CwV++ATiH3Ne0zKEhzLc1KuVz2crcWy+f5uFRp0mMitkH/IJLUozGmDXBgRMMIJBch/Az8F8ECjzL6ebnhzfJMfN5h9xVZz8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536954; c=relaxed/simple;
	bh=T8N7796kv+vy1G0sZqJdpiL5m6J1N0ns129AAoP50Zg=;
	h=To:Cc:Date:Message-Id:MIME-Version:Subject:Content-Type:From; b=DNnJ3/54byz+fJb/VToQe00zFwvjR88/nYGslwXRgLmqXLYoRwEbP1FJGkRTCTvYPhnUXFqguBDvRPaZSwR+BK21gZI+qXlli0b8Lkny6WmKYeP3pw+apr1rUANMVkX3HdQSaTTNkGOuDucILcCtAttJBfqdFY5MFVCoZ3A7fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=F6lQU/RM; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=J4wyKb2b reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JlRiHQk2 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 07178C15199D
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708536946; bh=T8N7796kv+vy1G0sZqJdpiL5m6J1N0ns129AAoP50Zg=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F6lQU/RMMjMS8uH9lFBKSUQMEnV150+3WimWlVOJvb2T+OVjlNUUjql6mwLZHQBV4
	 B1EK6nwHnLTFRbMO/Bnw1fqVWcvGEXqPnv56DXA0DfQ4X33CfHcEOHvYrAaUk9XHiZ
	 6XRwBCTPTL0KNZtI2eVl6qfEieDdxwR2MgdRtS/M=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BE663C151084;
 Wed, 21 Feb 2024 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1708536945; bh=T8N7796kv+vy1G0sZqJdpiL5m6J1N0ns129AAoP50Zg=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=J4wyKb2bCI4/nJTtYn9+gi63Y0WZpNSyHtZ1vLZYmtyQLpwlEnAb9YxwE1TPvuxqx
 sq+qY5n3+0myncBhA1tH2XzDRJK33iEWLxTXbTZtNZjNCG+/6gWtsjed6IyOuoYjk5
 ieig891Qans9hjxA2inS99IZwSHAlCDGl4m2m3LY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 56F30C14F73F
 for <bpf@ietfa.amsl.com>; Wed, 21 Feb 2024 09:35:44 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJhNUvusunqP for <bpf@ietfa.amsl.com>;
 Wed, 21 Feb 2024 09:35:40 -0800 (PST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0CBFDC14F5F4
 for <bpf@ietf.org>; Wed, 21 Feb 2024 09:35:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e4c359e48aso269876b3a.1
 for <bpf@ietf.org>; Wed, 21 Feb 2024 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1708536939; x=1709141739; darn=ietf.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wpj+dPbs6Bu1AaIzKNJqZxlV6H6VhuRxK9TUVjicr9s=;
 b=JlRiHQk2w2DF+dflO5dD9vL7nK4qaC4NXN5Vlgf0hNm0/9Yk8G21GOTt5e9IxZviaa
 jYZ7F4tC/RdT2tJaYtceF9gIReGALu36RVUI2pOYLhKu8AMD+XPXboJzgRz1AKXU/sxi
 3PcOLi/qPFmol9+JP1POb0eXwjY/SjBV9egZFxhzUnYfvujjH+wZGfjdt5vv7N1AZ+hZ
 MXnCifoiZ3nW+e++ImDBOWdWnAd5nGMwwM/9elWWChDx1MrxjL4nCWxs+XHupAeYXczR
 dJDbGoO1ZB+GS7zACtVA0q2DNmLJAMivqlsaEhHF7cGJhl8Ryu4IQ1mWquidKxS7jkMI
 pjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536939; x=1709141739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wpj+dPbs6Bu1AaIzKNJqZxlV6H6VhuRxK9TUVjicr9s=;
 b=d7h5ov7AKhQl67/YeEC29dxd4lL5fz1w6zwTWTPpa/ni+DDie5Y+cxu3J9E/O0h9VK
 k9764W8IeesQuqRNF3+tmYt0WbYoeCWNLRQQLoKzy/MfofKk8Ts1NAvNI/HQptUjBCLk
 dS1wtzpBIslH/bZ9kY4uNQvCh/W6B2HF92QF/dVw7WdePBQWewAbceOoVkFEZWiAea7M
 XSC+Q23/Td37uzDHwrj3peOcjVn4wF2X466WjiU38WFb7Fs8ZMDYRyGFWYz/KCiJtx3q
 uoiQlkzA6BL8x6VwBhKx6P53LrBCyGk1LRtT21r3vPXQi22LPVxdN+RaYR4p8XYHGsXz
 wuWw==
X-Gm-Message-State: AOJu0Yza4tS1mjrHxSxVJobhZ5KO/O6yQGRIb/YX6zNT+3CeNqKEU0G9
 lZG26S6BFS2tDIK/KcRUXLiHAmenL1blkxMJNWcYlSgfxLwbcvmk
X-Google-Smtp-Source: AGHT+IEhw3qZ/ySFNjXs7jxgsLM6rU4BeheA9SRanQkzz8/Fs4zHlksf1nSq+sce6lrLdARGxAhu0Q==
X-Received: by 2002:a05:6a21:1394:b0:1a0:9e45:1537 with SMTP id
 oa20-20020a056a21139400b001a09e451537mr10368905pzb.30.1708536939122; 
 Wed, 21 Feb 2024 09:35:39 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 h24-20020aa786d8000000b006e04553a4c5sm7343197pfo.52.2024.02.21.09.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 09:35:38 -0800 (PST)
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Date: Wed, 21 Feb 2024 09:35:35 -0800
Message-Id: <20240221173535.16601-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/y3aNV8BEIY-RD0_4fn1R7h-mKho>
Subject: [Bpf] [PATCH bpf-next] bpf, docs: Fix typos in instruction-set.rst
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

* "BPF ADD" should be "BPF_ADD".
* "src" should be "src_reg" in several places.  The latter is the field name
  in the instruction.  The former refers to the value of the register, or the
  immediate.
* Add '' around field names in one sentence, for consistency with the rest
  of the document.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 868d9f617..56b5e7dad 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -178,7 +178,7 @@ Unused fields shall be cleared to zero.
 As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
 instruction uses two 32-bit immediate values that are constructed as follows.
 The 64 bits following the basic instruction contain a pseudo instruction
-using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
+using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'offset' all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
 This is depicted in the following figure::
@@ -392,27 +392,27 @@ otherwise identical operations, and indicates the base64 conformance
 group unless otherwise specified.
 The 'code' field encodes the operation as below:
 
-========  =====  ===  ===============================  =============================================
-code      value  src  description                      notes
-========  =====  ===  ===============================  =============================================
-BPF_JA    0x0    0x0  PC += offset                     BPF_JMP | BPF_K only
-BPF_JA    0x0    0x0  PC += imm                        BPF_JMP32 | BPF_K only
-BPF_JEQ   0x1    any  PC += offset if dst == src
-BPF_JGT   0x2    any  PC += offset if dst > src        unsigned
-BPF_JGE   0x3    any  PC += offset if dst >= src       unsigned
-BPF_JSET  0x4    any  PC += offset if dst & src
-BPF_JNE   0x5    any  PC += offset if dst != src
-BPF_JSGT  0x6    any  PC += offset if dst > src        signed
-BPF_JSGE  0x7    any  PC += offset if dst >= src       signed
-BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_CALL  0x8    0x1  call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
-BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
-BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K only
-BPF_JLT   0xa    any  PC += offset if dst < src        unsigned
-BPF_JLE   0xb    any  PC += offset if dst <= src       unsigned
-BPF_JSLT  0xc    any  PC += offset if dst < src        signed
-BPF_JSLE  0xd    any  PC += offset if dst <= src       signed
-========  =====  ===  ===============================  =============================================
+========  =====  =======  ===============================  =============================================
+code      value  src_reg  description                      notes
+========  =====  =======  ===============================  =============================================
+BPF_JA    0x0    0x0      PC += offset                     BPF_JMP | BPF_K only
+BPF_JA    0x0    0x0      PC += imm                        BPF_JMP32 | BPF_K only
+BPF_JEQ   0x1    any      PC += offset if dst == src
+BPF_JGT   0x2    any      PC += offset if dst > src        unsigned
+BPF_JGE   0x3    any      PC += offset if dst >= src       unsigned
+BPF_JSET  0x4    any      PC += offset if dst & src
+BPF_JNE   0x5    any      PC += offset if dst != src
+BPF_JSGT  0x6    any      PC += offset if dst > src        signed
+BPF_JSGE  0x7    any      PC += offset if dst >= src       signed
+BPF_CALL  0x8    0x0      call helper function by address  BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_CALL  0x8    0x1      call PC += imm                   BPF_JMP | BPF_K only, see `Program-local functions`_
+BPF_CALL  0x8    0x2      call helper function by BTF ID   BPF_JMP | BPF_K only, see `Helper functions`_
+BPF_EXIT  0x9    0x0      return                           BPF_JMP | BPF_K only
+BPF_JLT   0xa    any      PC += offset if dst < src        unsigned
+BPF_JLE   0xb    any      PC += offset if dst <= src       unsigned
+BPF_JSLT  0xc    any      PC += offset if dst < src        signed
+BPF_JSLE  0xd    any      PC += offset if dst <= src       signed
+========  =====  =======  ===============================  =============================================
 
 The BPF program needs to store the return value into register R0 before doing a
 ``BPF_EXIT``.
@@ -568,7 +568,7 @@ BPF_XOR   0xa0   atomic xor
 
   *(u32 *)(dst + offset) += src
 
-``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF ADD means::
+``BPF_ATOMIC | BPF_DW | BPF_STX`` with 'imm' = BPF_ADD means::
 
   *(u64 *)(dst + offset) += src
 
@@ -601,24 +601,24 @@ and loaded back to ``R0``.
 -----------------------------
 
 Instructions with the ``BPF_IMM`` 'mode' modifier use the wide instruction
-encoding defined in `Instruction encoding`_, and use the 'src' field of the
+encoding defined in `Instruction encoding`_, and use the 'src_reg' field of the
 basic instruction to hold an opcode subtype.
 
 The following table defines a set of ``BPF_IMM | BPF_DW | BPF_LD`` instructions
-with opcode subtypes in the 'src' field, using new terms such as "map"
+with opcode subtypes in the 'src_reg' field, using new terms such as "map"
 defined further below:
 
-=========================  ======  ===  =========================================  ===========  ==============
-opcode construction        opcode  src  pseudocode                                 imm type     dst type
-=========================  ======  ===  =========================================  ===========  ==============
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = (next_imm << 32) | imm               integer      integer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
-BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
-=========================  ======  ===  =========================================  ===========  ==============
+=========================  ======  =======  =========================================  ===========  ==============
+opcode construction        opcode  src_reg  pseudocode                                 imm type     dst type
+=========================  ======  =======  =========================================  ===========  ==============
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x0      dst = (next_imm << 32) | imm               integer      integer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x1      dst = map_by_fd(imm)                       map fd       map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x2      dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x3      dst = var_addr(imm)                        variable id  data pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x4      dst = code_addr(imm)                       integer      code pointer
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x5      dst = map_by_idx(imm)                      map index    map
+BPF_IMM | BPF_DW | BPF_LD  0x18    0x6      dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
+=========================  ======  =======  =========================================  ===========  ==============
 
 where
 
-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

