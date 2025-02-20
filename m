Return-Path: <bpf+bounces-52028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A388EA3CE99
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016C3189A0ED
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58D1D5154;
	Thu, 20 Feb 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Erh0K0g2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798A1D5160
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014520; cv=none; b=b/31aoDJjxwUzDy7mdaxS8XajPNpZ9nIvUEghvvtrWBwar1OX4cOJwfczcKs2xgeECktCExaUwl45lSu0a7pMWbflII+fraRnlSUaKCrNKeKb7/MjJ6OJo+OYGiYKzE1JN/QlDPBVbN2+nsIf8MwjqpgVQBzF5Bf9JPGMl4OQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014520; c=relaxed/simple;
	bh=bPMoA+CFaJBzUEli+R/wxfQ9GKlfi77k+zzXMDFtLiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNSfL2I2Ho2puP8y1JBd4fnudiKbb34XHJqSlYdzH2TGYwQSnIcpG9kG5WcewiYtWi4ooWnD7qB9AdA4CzTO5R7YYVQ3uAX7u/GVNnoBbVcJ4hAaawFFX2sQ0Vk77leX0Fufdmlx9INbXeJUhkv3Yatl94duD4tf22bK40zPfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Erh0K0g2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ee2e7746so7642845ad.2
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014518; x=1740619318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GS6vyNS6k+QCogrM+ZqTPx58CsLeQh5Yn8lInF1h/Hk=;
        b=Erh0K0g2rnAcYd9mni8GAJTqe+RFeGMPn/D3pfZsEWW/zgrKHkVGSiQZMxVXgP2X3y
         IToH7tqGtk/GroT9lNq0IfNR5Yrcym54g1k2vR3FpcBih0cFlwGSVhYAdcks1dAlNNvE
         /Q33ODaXf7vXrNLNC8cmUQI0mEMsjK+kNTErSwzy4qHkau2lqQk0jWVdDKAlmvF0gtVV
         rnIF3I+nluZ3ug+jR6+YORuIQKNC8ymQ9BQqeEzjnoGQxRbC35A0kN8QBWxlTKzO/10d
         KjLXl+qnClEXyazrb80IJGse9n5QwCvmtrjV+HnoYeMM8miyqoeqhr+JJuzep55JDXgv
         B7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014518; x=1740619318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS6vyNS6k+QCogrM+ZqTPx58CsLeQh5Yn8lInF1h/Hk=;
        b=l3kGMdV2n6PDCqtfRZoA4IMuyMQIocy5AWTeZUfCJT2PTUrzPEX3FGrpmiRe7Z4RMM
         58UnCaRmICuwSaktGmGzjhPzLdwFWOx+SgiOdYmwWBqUnOclkTCpYPXFiNLQECtLmVoZ
         b7yuZWQwVqs/05SOiIPNHpILa5oMvyp88lZAhKG6yxY8oA4tmZeW5Jcedvdvb8Kci9Zf
         VLB1CnEYoAQ+7e35wDOa64f2qLnqCpgCd3HBvv0HFWlOMnzG+8OKUpfDCQh2dBfagaPj
         PVq1z8KUoxLb+mCOq2V83TBs3W75ZaY7GaFocFuALXRTNrw7NwXglIq7dLFasYPc+w6X
         /xgA==
X-Gm-Message-State: AOJu0YwjfBMvKvBNtKk85hmwg/ohBt1njMLKQgV8U5ETX6bCaAP2paH7
	wTpcfyROAaH0MmLJds1Co0C81RPH5VZA2jHEu+pHnwU5WMQkavWgiidkT7Ai5dKoLU9eSHepl+e
	bCpHkyD/JgUmLfduqmRd17l77Lzeh5dGiE1ox/SwED4NJi9HqRl/FFTpb7AlcspqruGnrS1cYoR
	WhfzNaO+d4Hta+EKPyiuqnWIjnMuy7UsqGv2XG8TA=
X-Google-Smtp-Source: AGHT+IGJ+ltKK6y+HaMblCOKbNV2LzZDguEqlJAUdmJ+I1P4WWwmJBB8qhJ2SRtkJLX7OgW2ONsd+pG1Ym0kVA==
X-Received: from plbkh4.prod.google.com ([2002:a17:903:644:b0:220:e392:340b])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94d:b0:215:6995:1ef3 with SMTP id d9443c01a7336-2217055ddc0mr83991925ad.3.1740014517696;
 Wed, 19 Feb 2025 17:21:57 -0800 (PST)
Date: Thu, 20 Feb 2025 01:21:51 +0000
In-Reply-To: <cover.1740009184.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740009184.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <86e925a5f2bd1d5aa22ff604a505be1d2e88784c.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 9/9] bpf, docs: Update instruction-set.rst for
 load-acquire and store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update documentation for the new load-acquire and store-release
instructions.  Rename existing atomic operations as "atomic
read-modify-write (RMW) operations".

Following RFC 9669, section 7.3. "Adding Instructions", create new
conformance groups "atomic32v2" and "atomic64v2", where:

  * atomic32v2: includes all instructions in "atomic32", plus the new
                8-bit, 16-bit and 32-bit atomic load-acquire and
                store-release instructions

  * atomic64v2: includes all instructions in "atomic64" and
                "atomic32v2", plus the new 64-bit atomic load-acquire
                and store-release instructions

Cc: bpf@ietf.org
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 .../bpf/standardization/instruction-set.rst   | 78 +++++++++++++++----
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index ab820d565052..6bd62e79c4ed 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -139,8 +139,14 @@ This document defines the following conformance groups:
   specification unless otherwise noted.
 * base64: includes base32, plus instructions explicitly noted
   as being in the base64 conformance group.
-* atomic32: includes 32-bit atomic operation instructions (see `Atomic operations`_).
-* atomic64: includes atomic32, plus 64-bit atomic operation instructions.
+* atomic32: includes 32-bit atomic read-modify-write instructions (see
+  `Atomic operations`_).
+* atomic32v2: includes atomic32, plus 8-bit, 16-bit and 32-bit atomic
+  load-acquire and store-release instructions.
+* atomic64: includes atomic32, plus 64-bit atomic read-modify-write
+  instructions.
+* atomic64v2: unifies atomic32v2 and atomic64, plus 64-bit atomic load-acquire
+  and store-release instructions.
 * divmul32: includes 32-bit division, multiplication, and modulo instructions.
 * divmul64: includes divmul32, plus 64-bit division, multiplication,
   and modulo instructions.
@@ -653,20 +659,29 @@ Atomic operations are operations that operate on memory and can not be
 interrupted or corrupted by other access to the same memory region
 by other BPF programs or means outside of this specification.
 
-All atomic operations supported by BPF are encoded as store operations
-that use the ``ATOMIC`` mode modifier as follows:
+All atomic operations supported by BPF are encoded as ``STX`` instructions
+that use the ``ATOMIC`` mode modifier, with the 'imm' field encoding the
+actual atomic operation.  These operations fall into two categories, as
+described in the following sections:
 
-* ``{ATOMIC, W, STX}`` for 32-bit operations, which are
+* `Atomic read-modify-write operations`_
+* `Atomic load and store operations`_
+
+Atomic read-modify-write operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The atomic read-modify-write (RMW) operations are encoded as follows:
+
+* ``{ATOMIC, W, STX}`` for 32-bit RMW operations, which are
   part of the "atomic32" conformance group.
-* ``{ATOMIC, DW, STX}`` for 64-bit operations, which are
+* ``{ATOMIC, DW, STX}`` for 64-bit RMW operations, which are
   part of the "atomic64" conformance group.
-* 8-bit and 16-bit wide atomic operations are not supported.
+* 8-bit and 16-bit wide atomic RMW operations are not supported.
 
-The 'imm' field is used to encode the actual atomic operation.
-Simple atomic operation use a subset of the values defined to encode
-arithmetic operations in the 'imm' field to encode the atomic operation:
+Simple atomic RMW operation use a subset of the values defined to encode
+arithmetic operations in the 'imm' field to encode the atomic RMW operation:
 
-.. table:: Simple atomic operations
+.. table:: Simple atomic read-modify-write operations
 
   ========  =====  ===========
   imm       value  description
@@ -686,10 +701,10 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
-two complex atomic operations:
+In addition to the simple atomic RMW operations, there also is a modifier and
+two complex atomic RMW operations:
 
-.. table:: Complex atomic operations
+.. table:: Complex atomic read-modify-write operations
 
   ===========  ================  ===========================
   imm          value             description
@@ -699,8 +714,8 @@ two complex atomic operations:
   CMPXCHG      0xf0 | FETCH      atomic compare and exchange
   ===========  ================  ===========================
 
-The ``FETCH`` modifier is optional for simple atomic operations, and
-always set for the complex atomic operations.  If the ``FETCH`` flag
+The ``FETCH`` modifier is optional for simple atomic RMW operations, and
+always set for the complex atomic RMW operations.  If the ``FETCH`` flag
 is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
@@ -713,6 +728,37 @@ The ``CMPXCHG`` operation atomically compares the value addressed by
 value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
+Atomic load and store operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To encode an atomic load or store operation, the 'imm' field is one of:
+
+.. table:: Atomic load and store operations
+
+  ========= =====  ====================
+  imm       value  description
+  ========= =====  ====================
+  LOAD_ACQ  0x100  atomic load-acquire
+  STORE_REL 0x110  atomic store-release
+  ========= =====  ====================
+
+``{ATOMIC, <size>, STX}`` with 'imm' = LOAD_ACQ means::
+
+  dst = load_acquire((unsigned size *)(src + offset))
+
+``{ATOMIC, <size>, STX}`` with 'imm' = STORE_REL means::
+
+  store_release((unsigned size *)(dst + offset), src)
+
+Where '<size>' is one of: ``B``, ``H``, ``W``, or ``DW``, and 'unsigned size'
+is one of: u8, u16, u32, or u64.
+
+8-bit, 16-bit and 32-bit atomic load-acquire and store-release instructions
+are part of the "atomic32v2" conformance group.
+
+64-bit atomic load-acquire and store-release instructions are part of the
+"atomic64v2" conformance group.
+
 64-bit immediate instructions
 -----------------------------
 
-- 
2.48.1.601.g30ceb7b040-goog


