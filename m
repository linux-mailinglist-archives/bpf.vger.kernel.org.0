Return-Path: <bpf+bounces-49752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B8A1C076
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EB97A580B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD89F2046A3;
	Sat, 25 Jan 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pM0HdtDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AD204685
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771590; cv=none; b=alrpkhlDvxvGQD/A+3u8YZsSEC1J3J/Q+5rMYOyWhCIxg1nxEpY9mPZuT9U5z6oo2UDiSVhbgotDjoDCLmUraEsh8+fTv+HUZnwjqt5UVOnsuVF45KjxZp1QCqPcMjeneJWSEkJwWuMzd2SX48WWQclO9XWP7p8673DC+gpSO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771590; c=relaxed/simple;
	bh=fwAIKVLFLiF2lkUBIMqPgWM5xGFj0kGqNXQ696QGQxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VuE7J7O72ueLJh3iW5q+kjOic3DldACe6ySBn8MWR4NuwXXrExu+h555rF34XaQJGgaQWUPRR0Zjq0HNNxpId7Ft7t4+u0957GuL1IByAgYx7j4UI9keV1A0Pq5FayC4rQFttmtI8DtDy7ft4RjdW2arDVRMuP2YeuXxEFNnt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pM0HdtDG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21648ddd461so54250785ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771588; x=1738376388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoHUEUhOV0x0mPYHihiLdSKtz41TIEtVbSj3jmRsaOk=;
        b=pM0HdtDGWxprW/V2laO2Dt3hkKHbSeI6uw0nQUA/6BgJ09+gtLHa4xzziDuaW7ibMd
         9jahm2pIXYeCqkkFn7pykz0iyiqi7ZaCfEUyzotVRkOux1hvGuL3SAHjAirp+0VFYJL6
         8VlAQLBAVnSAoRwDcgDrgH6/gn0MN0r/jXvy3S8TqF5hrZWfL//Jktu/r09SnUfsjJtx
         7ZJgg2CEo9WwPuyS+zrwN/ERQ7oUDY8HFFlfDdfHX02OvIUtHLh8fJ/WdZsQDUIqAYh9
         fCu21KCpSsa7zAaL9TIJYspEgakGhjAv5gczK7mupW45hQ7nNnM/aiFUxV96jFQHKRxm
         d6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771588; x=1738376388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoHUEUhOV0x0mPYHihiLdSKtz41TIEtVbSj3jmRsaOk=;
        b=ouiucfVd/xTEchHZ93VSNJ+jMxT8cDKjsd0uXwX24QfPggdi4B3vsXR8fNNyLvtT3F
         L1Ibr2hCtPhMUEr9H7vr6osYMY7X3l1Opb6QPiQXOElNkZo0v9QHNGI9Zn2RLn3BSuJg
         mB40FsC6H54VSZjSdna9fZhCiby3JJvQdoRMNTUJjg8RUYl6AhCCA0agv2p6I9igzeiF
         EUKTcXgoXppPaKqWJjpOPj6CuAoZG6hUi0d0ylocEXb8lM/ptip3KJ5/Gg9aMYzinUFT
         JTWTpcfN7xcPSWbw6sbBet+OsSpgZG6yLqiKpVulWbfcRyHsbcyJHRTBcn5kuWCdaHwY
         xkoQ==
X-Gm-Message-State: AOJu0YwlGsjM2zKaWAlE6sxesBD5bPtmX3ALEJDIeyf+74XMjYTDv1lV
	t160G7pqgoLo8oljNIB6BcDec5EM1f4zppMMqWA84nv+DLxfTihM2cluIc77loKxuCPKoChfeFl
	/yBXTHlUswdOt9OCQJ8YRQA7bCqfZtnOt8FKzeOP4//9gK+0vGM6GrlGDGS4Vz0lvGjINV3+Vgs
	6OtWbNpgQFjRQTPFn3BbggqzJRejMqQNEqTjhSWA8=
X-Google-Smtp-Source: AGHT+IHGh/EcJQlJc3OUFLXhqDr5SV+ajo77ZpLxRt1CFaw1WVG3Fg0XoLCrcpjLJvkD2sLS2HovJh1AnpwYjQ==
X-Received: from plez12.prod.google.com ([2002:a17:902:cccc:b0:215:dbd8:a6e7])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1381:b0:216:361a:783d with SMTP id d9443c01a7336-21c3562097amr541898135ad.28.1737771587999;
 Fri, 24 Jan 2025 18:19:47 -0800 (PST)
Date: Sat, 25 Jan 2025 02:19:39 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <e2072e24a6773b346f2a71c80b6a28d5b98e6194.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 8/8] bpf, docs: Update instruction-set.rst for
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
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
2.48.1.262.g85cc9f2d1e-goog


