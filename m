Return-Path: <bpf+bounces-56054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA9A90C2F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89F2188B195
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D33224B0F;
	Wed, 16 Apr 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpR7nmUO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045328373;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831267; cv=none; b=nzbg1a6Rd8zq8AIuCuHhMkxtQQI9AIyZx/Y94GA3ijpGMxkIrS/Ece0IPXe0NOVinbvwVPUV9AxSPj9bzlRkXDNiwDfLpf3gSdEcz7YiVXM19IXkKA96/iUvQpzP7ygFgbLDydz57OWydGU6Nbq1oz6Dq7fEG7+MqRMeSZA4nsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831267; c=relaxed/simple;
	bh=Lc+Vg2cKW4n3CYvpeyaRufqKP0NY0w4a/MSRYkAwhE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JH2HRSGhLKCf9Dpj5t1Mu8hOBo047p5giDDf+4OVx6Cs+kvJi9HLwZiMoUHz0i8ZFBg9P2fccWE+WtfP+D3U9AC2QOfrDmsVUNq9L8VwvAT5rienJKckY0AODrjMEZ4pJDywzYmpiuhIp4GjonWobhQ1VeumgR2KMJxys5COnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpR7nmUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E20FC4CEE2;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831267;
	bh=Lc+Vg2cKW4n3CYvpeyaRufqKP0NY0w4a/MSRYkAwhE8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TpR7nmUOTKE0uC/AZHiGTOKE4huIzb+Z+aezu7t48zjOlaH9fBT3EbG5QHsF13DLP
	 qpUV6rGJY+cN38/gGPSphrBBMBDPWhOhPn4H0HyYW9VLZ1SL6SiH9qxmx5RBv7FF4q
	 gOZ7oWKCtqSbA6vJIL9BLSgFvs6ZzLQibrvXNeGP/Dmj5KAqCQksBJUPLq75P16ezT
	 COj4sPb/sZSD5W19OhYo/691xGenxffinKEtBvqH/M/8Yqvzj/KIFb2jkSTz72UNBx
	 J3y3LdjrUsJWCQhz073+4jElktyxT9FMHWdMmryuvpKel1tDmyuqwYkf7SjNnVKUg6
	 8EWe8Lv98efBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C539C369C5;
	Wed, 16 Apr 2025 19:21:07 +0000 (UTC)
From: Thierry Treyer via B4 Relay <devnull+ttreyer.meta.com@kernel.org>
Subject: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Date: Wed, 16 Apr 2025 19:20:34 +0000
Message-Id: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIDAGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Mz3aSStPjMvJzMvFTdVKCIeWpqomWSWZoSUENBUWpaZgXYsGilIDd
 npdjaWgDWL0b3YQAAAA==
X-Change-ID: 20250416-btf_inline-e5047eea9b6f
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: Thierry Treyer <ttreyer@meta.com>, acme@kernel.org, ast@kernel.org, 
 yhs@meta.com, andrii@kernel.org, ihor.solodrai@linux.dev, 
 songliubraving@meta.com, alan.maguire@oracle.com, mykolal@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744831265; l=7233;
 i=ttreyer@meta.com; s=20250416; h=from:subject:message-id;
 bh=Lc+Vg2cKW4n3CYvpeyaRufqKP0NY0w4a/MSRYkAwhE8=;
 b=UTugkyM0H1twWNaeXI3tPA6mbDOGVXHJXmnKZoBBFnFHCZ3DOABtO4D8BsPgGUPVv7b18iBdv
 nk4sWts344cCoefLfbvOfi7AHu83dEBPiOcXYYIC/9RtDXCZrmvTT7o
X-Developer-Key: i=ttreyer@meta.com; a=ed25519;
 pk=2NAyAkZ6zhou7+5zqr5ikv3g5BfFbkznGzvzfKv1nbU=
X-Endpoint-Received: by B4 Relay for ttreyer@meta.com/20250416 with
 auth_id=382
X-Original-From: Thierry Treyer <ttreyer@meta.com>
Reply-To: ttreyer@meta.com

This proposal extends BTF to list the locations of inlined functions and
their arguments in a new '.BTF.inline` section.

== Background ==

Inline functions are often a blind spot for profiling and tracing tools:
* They cannot probe fully inlined functions.
  The BTF contains no data about them.
* They miss calls to partially inlined functions,
  where a function has a symbol, but is also inlined in some callers.
* They cannot account for time spent in inlined calls.
  Instead, they report the time to the caller.
* They don't provide a way to access the arguments of an inlined call.

The issue is exacerbated by Link-Time Optimization, which enables more
inlining across Object files. One workaround is to disable inlining for
the profiled functions, but that requires a whole kernel compilation and
doesn't allow for iterative exploration.

The information required to solve the above problems is not easily
accessible. It requires parsing most of the DWARF's '.debug_info` section,
which is time consuming and not trivial.
Instead, this proposal leverages and extends the existing information
contained in '.BTF` (for typing) and '.BTF.ext` (for caller location),
with information from a new section called '.BTF.inline`,
listing inlined instances.

== .BTF.inline Section ==

The new '.BTF.inline` section has a layout similar to '.BTF`.

 off |0-bit      |16-bits  |24-bits  |32-bits                           |
-----+-----------+---------+---------+----------------------------------+
0x00 |   magic   | version |  flags  |          header length           |
0x08 |      inline info offset       |        inline info length        |
0x10 |        location offset        |          location length         |
-----+------------------------------------------------------------------+
     ~                        inline info section                       ~
-----+------------------------------------------------------------------+
     ~                          location section                        ~
-----+------------------------------------------------------------------+

It starts with a header (see 'struct btf_inline_header`),
followed by two subsections:
1. The 'Inline Info' section contains an entry for each inlined function.
   Each entry describes the instance's location in its caller and is
   followed by the offsets in the 'Location' section of the parameters
   location expressions. See 'struct btf_inline_instance`.
2. The 'Location' section contains location expressions describing how
   to retrieve the value of a parameter. The expressions are NULL-
   terminated and are adressed similarly to '.BTF`'s string table.

struct btf_inline_header {
  uint16_t magic;
  uint8_t version, flags;
  uint32_t header_length;
  uint32_t inline_info_offset, inline_info_length;
  uint32_t location_offset, location_length;
};

struct btf_inline_instance {
  type_id_t callee_id;     // BTF id of the inlined function
  type_id_t caller_id;     // BTF id of the caller
  uint32_t caller_offset;  // offset of the callee within the caller
  uint16_t nr_parms;       // number of parameters
//uint32_t parm_location[nr_parms];  // offset of the location expression
};                                   // in 'Location' for each parameter

== Location Expressions ==

We looked at the DWARF location expressions for the arguments of inlined
instances having <= 100 instances, on a production kernel v6.9.0. This
yielded 176,800 instances with 269,327 arguments. We learned that most
expressions are simple register access, perhaps with an offset. We would
get access to 87% of the arguments by implementing literal and register.

Op. Category      Expr. Count    Expr. %
----------------------------------------
literal                 10714      3.98%
register+above         234698     87.14%
arithmetic+above       239444     88.90%
composite+above        240394     89.26%
stack+above            242075     89.88%
empty                   27252     10.12%

We propose to re-encode DWARF location expressions into a custom BTF
location expression format. It operates on a stack of values, similar to
DWARF's location expressions, but is stripped of unused operators,
while allowing future expansions.

A location expression is composed of a series of operations, terminated
by a NULL-byte/LOC_END_OF_EXPR operator. The very first expression in the
'Location' subsection must be an empty expression constisting only of
LOC_END_OF_EXPR.

An operator is a tagged union: the tag describes the operation to carry
out and the union contains the operands.
 
 ID | Operator Name        | Operands[...]
----+----------------------+-------------------------------------------
  0 | LOC_END_OF_EXPR      | _none_
  1 | LOC_SIGNED_CONST_1   |  s8: constant's value
  2 | LOC_SIGNED_CONST_2   | s16: constant's value
  3 | LOC_SIGNED_CONST_4   | s32: constant's value
  4 | LOC_SIGNED_CONST_8   | s64: constant's value
  5 | LOC_UNSIGNED_CONST_1 |  u8: constant's value
  6 | LOC_UNSIGNED_CONST_2 | u16: constant's value
  7 | LOC_UNSIGNED_CONST_4 | u32: constant's value
  8 | LOC_UNSIGNED_CONST_8 | u64: constant's value
  9 | LOC_REGISTER         |  u8: DWARF register number from the ABI
 10 | LOC_REGISTER_OFFSET  |  u8: DWARF register number from the ABI
                           | s64: offset added to the register's value
 11 | LOC_DEREF            |  u8: size of the deref'd type

This list should be further expanded to include arithmetic operations.

Example: accessing a field at offset 12B from a struct whose adresse is
         in the '%rdi` register, on amd64, has the following encoding:

[0x0a 0x05 0x000000000000000c] [0x0b 0x04] [0x00]
 |    |    ` Offset Added       |    |      ` LOC_END_OF_EXPR
 |    ` Register Number         |    ` Size of Deref.
 ` LOC_REGISTER_OFFSET          ` LOC_DEREF

== Summary ==

Combining the new information from '.BTF.inline` with the existing data
from '.BTF` and '.BTF.ext`, tools will be able to locate inline functions
and their arguments. Symbolizer can also use the data to display the
functions inlined at a given address.

Fully inlined functions are not part of the BTF and thus are not covered
by this proposal. Adding them to the BTF would enable their coverage and
should be considered.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
---
Thierry Treyer (3):
      dwarf_loader: Add parameters list to inlined expansion
      dwarf_loader: Add name to inline expansion
      inline_encoder: Introduce inline encoder to emit BTF.inline

 CMakeLists.txt   |   3 +-
 btf_encoder.c    |   5 +
 btf_encoder.h    |   2 +
 btf_inline.pk    |  55 ++++++
 dwarf_loader.c   | 176 ++++++++++++--------
 dwarves.c        |  26 +++
 dwarves.h        |   7 +
 inline_encoder.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 inline_encoder.h |  25 +++
 pahole.c         |  40 ++++-
 10 files changed, 765 insertions(+), 70 deletions(-)
---
base-commit: 4ef47f84324e925051a55de10f9a4f44ef1da844
change-id: 20250416-btf_inline-e5047eea9b6f

Best regards,
-- 
Thierry Treyer <ttreyer@meta.com>



