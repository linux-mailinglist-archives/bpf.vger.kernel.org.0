Return-Path: <bpf+bounces-50724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814FA2B8AB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CE188937C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1F188591;
	Fri,  7 Feb 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBzGFbMN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D016631C
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894003; cv=none; b=B+VsiUTP6hmG5xSaS5tFCvmIAM7segn2wyWuU62PfKAk0v3QCdSqfTdLGVIzRin3hGQgyAqHITPkqK5WBhCZOjRFqOmBd1ZrkTZEhOFMLS8CB210dKP9c3dyAzgK4YcZsphGmALv7kBCE5+ng8PIv4CdyOUuhvl/Uz+1kTTdb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894003; c=relaxed/simple;
	bh=9TD85PMgpDU5D2oxZLnT8DCFz4XahRBdsQKIng9CEDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f32o33h6n3cRc1kYWF3ZJ0IqG/B+Xo27O66yTCboG4p0qumXBGCvjo2B0ii1oHudioQIluKFRXWfLk9fjT99Rf1w+j0JrvczQDrYZ5cs8OreuIEMQEW/az/kZN6qBkXBxs8p7yXdK7uNI9fiGK4RNttVuyTLrI9Zaba3DqTe99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBzGFbMN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f0d8b7647so46904385ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738894001; x=1739498801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ep8DalcKj7dauwNLlP5ARZOtPwUTNVJ49jqJ539nuE=;
        b=OBzGFbMNev6db22Ug6L456fKfc1yLG3P+gqAgn8CV5iTHmJTPa1tTmDdSwYMnSsVun
         hnEPHNNIyTPpOLqSV7+VfgQWoptvufRmqgGBCPhRVhx4s21e31P1KL5g7C/TjFaos8DA
         tNrgb9GYPosETBd4T2APpFCoeZwa3B8palTtjZE9Q1l7cGlSldap/VbW8VIphXhUa+8J
         WUhWh68Zt9QpYrjsK90ep5KXkolMCOHVQ+oKDHHvEejvzUvN0mUj8paarhD4kGVwzK/4
         fO+40eg+LFavvjznL/vcFy3DTEm8CS2DpMyb9C5H3FbflV1A0I8AVnakvjSMNyUuZllw
         jnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738894001; x=1739498801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ep8DalcKj7dauwNLlP5ARZOtPwUTNVJ49jqJ539nuE=;
        b=CuiD66uWYDxIx6Ln5ayQUAXYbn/fbFP7cS+ZnoWAm/4YfZFoOm8ZPxcoBcau3oL0AP
         eILUcXmwuiqPQHxsUx2Nksf9QeIWi6l5rPunsiDrNxjErr0WW3Y3gwUrOP7Vs7cp1kcP
         M6JhNqaM3TXR+6HdYrmGZJV6l4Vnmxv6enAc5GShGBLLbNWrdplbEbax7LZah5q2hae9
         ABn5YaUntDZqaPARVzI9imFBEti73jlqz3ZV8csW66ST7mnlEOzoLC3qElSz69yGud7N
         iD8NU8evsekcH5675IiLXdaGLEBq09CtCvGhQDhunR8qmUtLkm8HQ4qooEvZGRKrevKm
         vFzg==
X-Gm-Message-State: AOJu0YyLpx5VCrV2JtHTxToN3PtA9dLNU2wtMam/tHVs14Vlpv5fPNNM
	c296iN5vkqT8siMGRrLMEbXAlCncveplXX/Fff+DiHf/tbsQAJxWd0K0DqALUEvOGppN0tdmpW7
	cdmKYUS48KgU52MtksJtLnq2/GxL8CF0SIq5CALAnESBqNpFBRTvj4LENJRH2NgyxGYvwV9MPlq
	pZvfaC5Q0xMY2zHZoA0Np+gvsxA87xAFMK9jU33+I=
X-Google-Smtp-Source: AGHT+IHO+QQmGU+1/m5wHtsMoItJdlgCTFiDvf89nZcXM296VZbNzIAooIz/Ko6Udd05tpk4RbaW4EcMXoxUsg==
X-Received: from pfnv19.prod.google.com ([2002:aa7:8513:0:b0:730:5488:ee30])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1394:b0:1e0:c77c:450d with SMTP id adf61e73a8af0-1ee03a242cemr2973087637.1.1738894000789;
 Thu, 06 Feb 2025 18:06:40 -0800 (PST)
Date: Fri,  7 Feb 2025 02:06:36 +0000
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <d5ef5b58910bb83ecd7375220eade06fdf16a10e.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 9/9] bpf, docs: Update instruction-set.rst for
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
 .../bpf/standardization/instruction-set.rst   | 114 +++++++++++++++---
 1 file changed, 98 insertions(+), 16 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index ab820d565052..86917932e9ef 100644
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
@@ -653,20 +659,31 @@ Atomic operations are operations that operate on memory and can not be
 interrupted or corrupted by other access to the same memory region
 by other BPF programs or means outside of this specification.
 
-All atomic operations supported by BPF are encoded as store operations
-that use the ``ATOMIC`` mode modifier as follows:
+All atomic operations supported by BPF are encoded as ``STX`` instructions
+that use the ``ATOMIC`` mode modifier, with the 'imm' field encoding the
+actual atomic operation.  These operations are categorized based on the second
+lowest nibble (bits 4-7) of the 'imm' field:
 
-* ``{ATOMIC, W, STX}`` for 32-bit operations, which are
+* ``ATOMIC_LOAD`` and ``ATOMIC_STORE`` indicate atomic load and store
+  operations, respectively (see `Atomic load and store operations`_).
+* All other defined values indicate an atomic read-modify-write operation, as
+  described in the following section.
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
@@ -686,10 +703,10 @@ arithmetic operations in the 'imm' field to encode the atomic operation:
 
   *(u64 *)(dst + offset) += src
 
-In addition to the simple atomic operations, there also is a modifier and
-two complex atomic operations:
+In addition to the simple atomic RMW operations, there also is a modifier and
+two complex atomic RMW operations:
 
-.. table:: Complex atomic operations
+.. table:: Complex atomic read-modify-write operations
 
   ===========  ================  ===========================
   imm          value             description
@@ -699,8 +716,8 @@ two complex atomic operations:
   CMPXCHG      0xf0 | FETCH      atomic compare and exchange
   ===========  ================  ===========================
 
-The ``FETCH`` modifier is optional for simple atomic operations, and
-always set for the complex atomic operations.  If the ``FETCH`` flag
+The ``FETCH`` modifier is optional for simple atomic RMW operations, and
+always set for the complex atomic RMW operations.  If the ``FETCH`` flag
 is set, then the operation also overwrites ``src`` with the value that
 was in memory before it was modified.
 
@@ -713,6 +730,71 @@ The ``CMPXCHG`` operation atomically compares the value addressed by
 value that was at ``dst + offset`` before the operation is zero-extended
 and loaded back to ``R0``.
 
+Atomic load and store operations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To encode an atomic load or store operation, the lowest 8 bits of the 'imm'
+field are divided as follows::
+
+  +-+-+-+-+-+-+-+-+
+  | type  | order |
+  +-+-+-+-+-+-+-+-+
+
+**type**
+  The operation type is one of:
+
+.. table:: Atomic load and store operation types
+
+  ============  =====  ============
+  type          value  description
+  ============  =====  ============
+  ATOMIC_LOAD   0x1    atomic load
+  ATOMIC_STORE  0x2    atomic store
+  ============  =====  ============
+
+**order**
+  The memory order is one of:
+
+.. table:: Memory orders
+
+  =======  =====  =======================
+  order    value  description
+  =======  =====  =======================
+  RELAXED  0x0    relaxed
+  ACQUIRE  0x1    acquire
+  RELEASE  0x2    release
+  ACQ_REL  0x3    acquire and release
+  SEQ_CST  0x4    sequentially consistent
+  =======  =====  =======================
+
+Currently the following combinations of ``type`` and ``order`` are allowed:
+
+.. table:: Atomic load and store operations
+
+  ========= =====  ====================
+  imm       value  description
+  ========= =====  ====================
+  LOAD_ACQ  0x11   atomic load-acquire
+  STORE_REL 0x22   atomic store-release
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
2.48.1.502.g6dc24dfdaf-goog


