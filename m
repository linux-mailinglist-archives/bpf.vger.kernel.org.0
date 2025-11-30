Return-Path: <bpf+bounces-75771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EBDC94B13
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 04:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 423053459C4
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005822A4E1;
	Sun, 30 Nov 2025 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gBfUj9lj"
X-Original-To: bpf@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F697189906;
	Sun, 30 Nov 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764472935; cv=none; b=mzxaSoeMk88fJm795+ubqOP47Qv0HZb/2hTNzx0Ojfr/aiWBLJHTMUPbZC6JYlU08m18ESmprmKoPS2xrqMezkMh47S02ONpcgKJ+rf9JK5V1qChYnP6TKUY5zsj+c8XZB8D8/YgVz/YI9dwCO5LRtO4eJzVGTlc0dJUwiPyFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764472935; c=relaxed/simple;
	bh=FZ/WvfCqo8xDaaAaSqJFYv1l/GPzCL60qrZ5Pt1GyLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFqMZdY98vbsiH4ppe2dzD3xGLFz9eOMf0h/nexdiXqn0Z2vHPhfFT4DsCggyTKoG6hXPVAavfhcUTHh5uH+pvlpOvQPqovebZpw4fkBwjMR6M0n/m2ofpOf/rF/FZVnqBuWIRbjPagQ/K0V4v2N9zIjt8XTJU8mzbxB7wQjfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gBfUj9lj; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 702DA25DAA;
	Sun, 30 Nov 2025 04:22:02 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBLmcre_4clJ; Sun, 30 Nov 2025 04:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764472921; bh=FZ/WvfCqo8xDaaAaSqJFYv1l/GPzCL60qrZ5Pt1GyLE=;
	h=From:To:Cc:Subject:Date;
	b=gBfUj9ljMH7eG7MDi6VR0AysnYUwtcvof9YYxd1GODhgIg5qzBUzdNJL6ELjfByCm
	 /3Cln+MUoDQEldwU1/I6qe+zFRoCpw79zyO4EcKI3BuRlREwTKtOD0QXAd/t1RPWfZ
	 fXsSD6F+cgOdDRCxacTihraO1mU86F6jJTQOQhk95WhLcrcWQN8Bqd0h9J8gnkPDxP
	 zvSluth+K4D0lGuNE01bjn8vkjYCGBXbhK6m17qQ4rqX/EZGEZkQLFHEJaM+fVPrrK
	 Pt0FI0WCcche+4r2+1yNEYKwPXnEOXUsYzcb92krtDqzjGL2H2VZMEza+XvDS5KAQR
	 kjAngLQz7/EjA==
From: Yao Zi <ziyao@disroot.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>,
	q66 <me@q66.moe>
Subject: [PATCH dwarves] dwarf_loader: Handle DW_AT_location attrs containing DW_OP_plus_uconst
Date: Sun, 30 Nov 2025 03:21:14 +0000
Message-ID: <20251130032113.4938-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM has a GlobalMerge pass, which tries to group multiple global
variables together and address them with through a single register with
offsets coded in instructions, to reduce register pressure. Address of
symbols transformed by the pass may be represented by an DWARF
expression consisting of DW_OP_addrx and DW_OP_plus_uconst, which
naturally matches the way a merged variable is addressed.

However, our dwarf_loader currently ignores anything but the first in
the location expression, including the DW_OP_plus_uconst atom, which
appears the second operation in this case. This could result in broken
BTF information produced by pahole, where several merged symbols are
given the same offset, even though in fact they don't overlap.

LLVM has enabled MergeGlobal pass for PowerPC[1] and RISC-V[2] by
default since version 20, let's handle DW_OP_plus_uconst operations in
DW_AT_location attributes correctly to ensure correct BTF could be
produced for LLVM-built kernels.

Fixes: a6ea527aab91 ("variable: Add ->addr member")
Reported-by: q66 <me@q66.moe>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2089
Link: https://github.com/llvm/llvm-project/commit/aaa37d6755e6 # [1]
Link: https://github.com/llvm/llvm-project/commit/9d02264b03ea # [2]
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

The problem is found by several distros building Linux kernel with LLVM
and BTF enabled, after upgrading to LLVM 20 or later, kernels built for
RISC-V and PowerPC issue errors like

[    1.296358] BPF:      type_id=4457 offset=4224 size=8
[    1.296767] BPF:
[    1.296919] BPF: Invalid offset

on startup, and loading any modules fails with -EINVAL unless
CONFIG_MODULE_ALLOW_BTF_MISMATCH is turned on,

# insmod tun.ko
[   12.892421] failed to validate module [tun] BTF: -22
[   12.936971] failed to validate module [tun] BTF: -22
insmod: can't insert 'tun.ko': Invalid argument

By comparing DWARF dump and BTF dump, it's found BTF contains symbols
with the same offset,

type_id=4148 offset=4208 size=8 (VAR 'vector_misaligned_access')
type_id=4147 offset=4208 size=8 (VAR 'misaligned_access_speed')

while the same symbols are described with different DW_AT_location
attributes,

0x0011ade7:   DW_TAG_variable
                DW_AT_name      ("misaligned_access_speed")
                DW_AT_type      (0x0011adf2 "long")
		DW_AT_decl_file	("...")
                DW_AT_external  (true)
                DW_AT_decl_line (24)
                DW_AT_location  (DW_OP_addrx 0x0)

...

0x0011adf6:   DW_TAG_variable
                DW_AT_name      ("vector_misaligned_access")
                DW_AT_type      (0x0011adf2 "long")
                DW_AT_external  (true)
                DW_AT_decl_file ("...")
                DW_AT_decl_line (25)
                DW_AT_location  (DW_OP_addrx 0x0, DW_OP_plus_uconst 0x8)

For more detailed analysis and kernel config for reproducing the issue,
please refer to the Closes link. Thanks for your time and review.

 dwarf_loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 79be3f516a26..635015676389 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -708,6 +708,11 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
 		case DW_OP_addrx:
 			scope = VSCOPE_GLOBAL;
 			*addr = expr[0].number;
+
+			if (location->exprlen == 2 &&
+			    expr[1].atom == DW_OP_plus_uconst)
+				addr += expr[1].number;
+
 			break;
 		case DW_OP_reg1 ... DW_OP_reg31:
 		case DW_OP_breg0 ... DW_OP_breg31:
-- 
2.51.2


