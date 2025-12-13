Return-Path: <bpf+bounces-76558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECBCBA72C
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7475630012DB
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028042BFC8F;
	Sat, 13 Dec 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="ivBWWDud"
X-Original-To: bpf@vger.kernel.org
Received: from mail40.out.titan.email (mail40.out.titan.email [209.209.25.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5242BDC00
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765614521; cv=none; b=Qk7xf4BiGGbnj+9D08+k4GJ3oa/pr76ZJVh2ou7q7y7utrNwF9dQIqbKZbE2W2KX2NJ/WVI196KkM8WbRZUZtlHmGjfVX/UFhQCs9e3bpfKXKNYXMcUe1Zek9Vl9tHkx1ip5rwOS7oNeZxDBL5ASSFDW/QTQx0t+H2U+Pwu9lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765614521; c=relaxed/simple;
	bh=k6Qmogr9eLDA2Al/XUsWPyZwZwYDDwb+4AUYEPxoA6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZBkQKQRF7hti9Xy9WXGNx17YnfFek7wFwmlrUovPVdJTNSXF3m+OYzr1zAlF07LNCKB+rCTvAcHYoPMVsilsjr4oBQWpIul8TRghBRsigiL5KKPz0kVbZqqYTHYEIWt+RQzmiKC2ePwq9DHsO7fvCjhvzuVSCWTfEfXyLocFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=ivBWWDud; arc=none smtp.client-ip=209.209.25.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dSzxF0gMbz9rw7;
	Sat, 13 Dec 2025 08:28:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=tc1tIhIQc7O4v6s79H8PuGEoalgFoaAAlQMd9v2xupw=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=date:message-id:from:to:cc:mime-version:subject:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1765614512; v=1;
	b=ivBWWDudLREa//AbpZzsInO04aAZbu40lFhuVmGrSVZINt4VDyzQjMG2LsoqchfAugVv3fGt
	9TufpUcdT7on73BJkSkH2H9OTnhAigWER6d3k74J0J2q3DrExwiZJarsjQubfu9OBbkRK6KsZv6
	0llJsXqltOCJjG3j1RU9P1/E=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dSzxB5gQjz9rvR;
	Sat, 13 Dec 2025 08:28:30 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Yao Zi <me@ziyao.cc>,
	q66 <me@q66.moe>
Subject: [PATCH dwarves v2] dwarf_loader: Handle DW_AT_location attrs containing DW_OP_plus_uconst
Date: Sat, 13 Dec 2025 08:27:22 +0000
Message-ID: <20251213082721.51017-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765614512931531904.21635.655533790920244735@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=693d23b0
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8
	a=VwQbUJbxAAAA:8 a=LpNgXrTXAAAA:8 a=oMbLxBo4_5qdfzbMrdIA:9
	a=LqOpv0_-CX5VL_7kjZO3:22 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

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
Signed-off-by: Yao Zi <me@ziyao.cc>
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

Changed from v1
- Add missing dereference to *addr
- Change my mail address to me@ziyao.cc
- Link to v1: https://lore.kernel.org/dwarves/20251130032113.4938-2-ziyao@disroot.org/

 dwarf_loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 79be3f516a26..77aab8a0960b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -708,6 +708,11 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
 		case DW_OP_addrx:
 			scope = VSCOPE_GLOBAL;
 			*addr = expr[0].number;
+
+			if (location->exprlen == 2 &&
+			    expr[1].atom == DW_OP_plus_uconst)
+				*addr += expr[1].number;
+
 			break;
 		case DW_OP_reg1 ... DW_OP_reg31:
 		case DW_OP_breg0 ... DW_OP_breg31:
-- 
2.51.2


