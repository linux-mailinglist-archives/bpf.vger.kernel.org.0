Return-Path: <bpf+bounces-53014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D4A4B7B0
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF503B0E7B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DC1E98E0;
	Mon,  3 Mar 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SICV0Q5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FF1DED52
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980319; cv=none; b=EyUEejuwr0/AqdeSa0LLPT0Mi5/L7UXmJRkPxFRICq8QtukG4xPnerieCbV5g/2edEew+yiinnBtHXZo3fSVGmhWzEOiyzduX1RFHiyqjwlHpBTpMV4JQ3CAnzzL4KG6ZuC1iG0vKMwS2ukZjnmqmFvzNcxm+JD/pGiVLjsoArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980319; c=relaxed/simple;
	bh=Rxxup+Tv98QPQYKKPXDiM+/qq07KKlfXEu4t+pf9j/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h4p5H7NUE3rRnsVe3b2CMgPm9czHLjzLvCUvUFTlmulnfYnOuZTET3upiR3XxjsZgHShCCveDPyTUzPSOxOwiawy3RTlpDmzxN87zqtkoyxISYFZ+wgwvZIvic06fCZ9erLpvZM7yyPK+WiUAQvxU/Fvk13S9OfWWrOYd9imKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SICV0Q5x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6cb3097bso112473805ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980317; x=1741585117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdFMJ3eJb2l/jj7P1Me0JuhIKyhrXbqRhtqcohr3hSo=;
        b=SICV0Q5x1S0HmhzQ93zonrrIRI6w8RYXe7spuPMKVmRhpGW+Ys0Vj+Z1h77PaRPkgu
         YMGltynesWbGi3xJLtqypF+7FyB1uodLGC0h+NM52xRHWpJvT3lSWJMQ5EO5SmmqDs2a
         /WJJh0HQNp0hYilS0p3WAUmjr6cMt2d4NO7qh6eV+7hs+FKtOafWH+3W+3uYK2P0WGXv
         f5awJd0tZg3aA+cb4ibItnkn4SRiwUGeBAdhnv8hIofQ+yalTfh3DcAdV16S2NVUFC+Y
         JLXDVJhRJXqBg5vK74IZYby1zMq7ve8dTxRqacVLgWLZ5zGy/gYBksv/kXtyp9IPdYSt
         WIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980317; x=1741585117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdFMJ3eJb2l/jj7P1Me0JuhIKyhrXbqRhtqcohr3hSo=;
        b=E/ik83YLBX95Esbr/gH3zkp9o+ArI1xefdohQkyL9DBjAx0VG8bQ/3pIufWf1A/Klf
         nVv1UeyesbHOo92w73v95VZ7t0PmOp1n8mB49Azy5uYehgcnfWZ9ebAFYTy1vBEP7yPk
         vwKBUl7Rgi30Q4V2R9UlWhpQ0f+RrzIXxo2ZHp17lbxmwe5PnB1GxHQZ1aZPH7j7Ihio
         G3UO7OYPfg+/1ePUsrUd4c7VI2Ciliql6aQwTExV/4yfTN7tUzxgXGHj9KXC7jzkGCeq
         uNA4gw8SNDrwF5E3jokmqBWcSJeXqxKexEmWDcQ3W348SqAaICH4a3O0xU3c4KZ0jHFJ
         3SBA==
X-Gm-Message-State: AOJu0YwSD0x/WbElIiNhi5V3JUBPl2m5MTfyRC5VVEqZ+NQbubbKRKgh
	jI+MBwoERepplUhH5s066utduMQQo3i6WNNsf0a6uKGebB44Slig4cktHSjpgvjH/g1YBDDef85
	e68QLW8ibhqOEHFZwwNbEWuvZY72SM6lRFB6TrN35Hg7+QQVEprhX66bsyDlM+Lagkz2Sabay0/
	R/wx5yT0Ws0+bp9D4EstTyjlk/SR5U6luxiWXcY38=
X-Google-Smtp-Source: AGHT+IG8yh55rFOhOTZMMGs/yTblMQoM/f6tZY3/AfjWMjgR3Y/YqigzRqn2h1ts0C33WfA1yC4VrhUHSjzCMg==
X-Received: from pfhm17.prod.google.com ([2002:a62:f211:0:b0:734:c237:abe7])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d4c:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-73660437d47mr1216182b3a.19.1740980316852;
 Sun, 02 Mar 2025 21:38:36 -0800 (PST)
Date: Mon,  3 Mar 2025 05:38:29 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <c835515c35ec4ed59232adc3c02e1e90aa8ed8be.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 10/10] bpf, docs: Update instruction-set.rst for
 load-acquire and store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
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
index fbe975585236..1bed27572bca 100644
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
@@ -661,20 +667,29 @@ Atomic operations are operations that operate on memory and can not be
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
@@ -694,10 +709,10 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
-two complex atomic operations:
+In addition to the simple atomic RMW operations, there also is a modifier and
+two complex atomic RMW operations:
 
-.. table:: Complex atomic operations
+.. table:: Complex atomic read-modify-write operations
 
   ===========  ================  ===========================
   imm          value             description
@@ -707,8 +722,8 @@ two complex atomic operations:
   CMPXCHG      0xf0 | FETCH      atomic compare and exchange
   ===========  ================  ===========================
 
-The ``FETCH`` modifier is optional for simple atomic operations, and
-always set for the complex atomic operations.  If the ``FETCH`` flag
+The ``FETCH`` modifier is optional for simple atomic RMW operations, and
+always set for the complex atomic RMW operations.  If the ``FETCH`` flag
 is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
@@ -721,6 +736,37 @@ The ``CMPXCHG`` operation atomically compares the value addressed by
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
2.48.1.711.g2feabab25a-goog


