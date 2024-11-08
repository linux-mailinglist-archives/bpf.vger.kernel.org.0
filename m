Return-Path: <bpf+bounces-44371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BA9C24A0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF051F242FB
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA2233D84;
	Fri,  8 Nov 2024 18:05:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55D233D7F
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089140; cv=none; b=f6jJxzOpnZnTPlPgUr48MeRn2wDXrLnu8lteCDOyxJWlJne2NEfzIc/zX2UeFxmKsxXoyZPb/y2x7GBl5lRUH0SA2tHhw6noQqJMc2qtB6fJgOI11mIfqa4bV8EoKLc4k6GBnIHfMMUhKX7JI1/z3Q1kNE9PEYCiVH1jzJ5rjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089140; c=relaxed/simple;
	bh=GlkCP08p0eqAT92FlAT8fDKmDzDhz9aB/Ri1AEPvhKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8r32mcZDkz9NrGuOAKbtsr1fXcsQ+qls7weg+JXm4N2iloOhhonXsKYVeB9jwCQM6gaumm5FwZSfa47PiqYF/CF6W7opfgKXMEQ2gMkIlULOI+NCRJ75GBhdAY/V8vmdeGMBu4WAY3mXnJqQde0TFduaQVnYGTHMRp++3cGY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E9B9EADDC559; Fri,  8 Nov 2024 10:05:24 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter matching
Date: Fri,  8 Nov 2024 10:05:24 -0800
Message-ID: <20241108180524.1198900-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108180508.1196431-1-yonghong.song@linux.dev>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Song Liu reported that a kernel func (perf_event_read()) cannot be traced
in certain situations since the func is not in vmlinux bTF. This happens
in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.

The perf_event_read() signature in kernel (kernel/events/core.c):
   static int perf_event_read(struct perf_event *event, bool group)

Adding '-V' to pahole command line, and the following error msg can be fo=
und:
   skipping addition of 'perf_event_read'(perf_event_read) due to unexpec=
ted register used for parameter

Eventually the error message is attributed to the setting
(parm->unexpected_reg =3D 1) in parameter__new() function.

The following is the dwarf representation for perf_event_read():
    0x0334c034:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff812c6110)
                DW_AT_high_pc   (0xffffffff812c640a)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_GNU_all_call_sites        (true)
                DW_AT_name      ("perf_event_read")
                DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
                DW_AT_decl_line (4641)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x03324f6a "int")
    0x0334c04e:     DW_TAG_formal_parameter
                  DW_AT_location        (0x007de9fd:
                     [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5=
 RDI
                     [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg1=
4 R14
                     [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_=
entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg1=
4 R14
                     [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_=
entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                  DW_AT_name    ("event")
                  DW_AT_decl_file       ("/rw/compile/kernel/events/core.=
c")
                  DW_AT_decl_line       (4641)
                  DW_AT_type    (0x0333aac2 "perf_event *")
    0x0334c05e:     DW_TAG_formal_parameter
                  DW_AT_location        (0x007dea82:
                     [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg1=
2 R12
                     [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_=
entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg1=
2 R12)
                  DW_AT_name    ("group")
                  DW_AT_decl_file       ("/rw/compile/kernel/events/core.=
c")
                  DW_AT_decl_line       (4641)
                  DW_AT_type    (0x03327059 "bool")

By inspecting the binary, the second argument ("bool group") is used
in the function. The following are the disasm code:
    ffffffff812c6110 <perf_event_read>:
    ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
    ffffffff812c6115: 55                    pushq   %rbp
    ffffffff812c6116: 41 57                 pushq   %r15
    ffffffff812c6118: 41 56                 pushq   %r14
    ffffffff812c611a: 41 55                 pushq   %r13
    ffffffff812c611c: 41 54                 pushq   %r12
    ffffffff812c611e: 53                    pushq   %rbx
    ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
    ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
    <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NOTE that here '%esi' is used and =
moved to '%r12d'.
    ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
    ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
    ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
    ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
    ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
    ffffffff812c613f: 75 3f                 jne     0xffffffff812c6180 <p=
erf_event_read+0x70>
    ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%ra=
x)
    ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
    ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
    ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
    ffffffff812c615a: e8 c1 a0 d7 00        callq   0xffffffff82040220 <_=
raw_spin_lock_irqsave>
    ffffffff812c615f: 49 89 c7              movq    %rax, %r15
    ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
    ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
    ffffffff812c616b: 0f 84 9a 00 00 00     je      0xffffffff812c620b <p=
erf_event_read+0xfb>
    ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
    ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
    <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NOTE: %rsi is overwritten
    ......
    ffffffff812c63f0: 41 5c                 popq    %r12
    <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D POP r12
    ffffffff812c63f2: 41 5d                 popq    %r13
    ffffffff812c63f4: 41 5e                 popq    %r14
    ffffffff812c63f6: 41 5f                 popq    %r15
    ffffffff812c63f8: 5d                    popq    %rbp
    ffffffff812c63f9: e9 e2 a8 d7 00        jmp     0xffffffff82040ce0 <_=
_x86_return_thunk>
    ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
    ffffffff812c6400: e9 be fe ff ff        jmp     0xffffffff812c62c3 <p=
erf_event_read+0x1b3>

It is not clear why dwarf didn't encode %rsi in locations. But
DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
the entry of perf_event_read(). So this patch tries to search
DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
the expected parameter register matchs the register in
DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
is not optimized.

For one of internal 6.11 kernel, there are 62498 functions in BTF and
perf_event_read() is not there. With this patch, there are 61552 function=
s
in BTF and perf_event_read() is included.

Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e0b8c11..1fe44bc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1169,34 +1169,67 @@ static bool check_dwarf_locations(Dwarf_Attribute=
 *attr, struct parameter *parm,
 		return false;
=20
 #if _ELFUTILS_PREREQ(0, 157)
-	/* dwarf_getlocations() handles location lists; here we are
-	 * only interested in the first expr.
-	 */
-	if (dwarf_getlocations(attr, 0, &base, &start, &end,
-			       &loc.expr, &loc.exprlen) > 0 &&
-		loc.exprlen !=3D 0) {
-		expr =3D loc.expr;
-
-		switch (expr->atom) {
-		case DW_OP_reg0 ... DW_OP_reg31:
-			/* mark parameters that use an unexpected
-			 * register to hold a parameter; these will
-			 * be problematic for users of BTF as they
-			 * violate expectations about register
-			 * contents.
+	bool reg_matched =3D false, reg_unmatched =3D false, first_expr_reg =3D=
 false, ret =3D false;
+	ptrdiff_t offset =3D 0;
+	int loc_num =3D -1;
+
+	while ((offset =3D dwarf_getlocations(attr, offset, &base, &start, &end=
, &loc.expr, &loc.exprlen)) > 0 &&
+	       loc.exprlen !=3D 0) {
+		ret =3D true;
+		loc_num++;
+
+		for (int i =3D 0; i < loc.exprlen; i++) {
+			Dwarf_Attribute entry_attr;
+			Dwarf_Op *entry_ops;
+			size_t entry_len;
+
+			expr =3D &loc.expr[i];
+			switch (expr->atom) {
+			case DW_OP_reg0 ... DW_OP_reg31:
+				/* first location, first expression */
+				if (loc_num =3D=3D 0 && i =3D=3D 0) {
+					if (expected_reg >=3D 0) {
+						if (expected_reg =3D=3D expr->atom) {
+							reg_matched =3D true;
+							return true;
+						} else {
+							reg_unmatched =3D true;
+						}
+					}
+					first_expr_reg =3D true;
+				}
+				break;
+			/* For the following dwarf entry (arch x86_64) in parameter locations=
:
+			 *    DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
+			 * RSI register should be available at the entry of the program.
 			 */
-			if (expected_reg >=3D 0 && expected_reg !=3D expr->atom)
-				parm->unexpected_reg =3D 1;
-			break;
-		default:
-			parm->optimized =3D 1;
-			break;
+			case DW_OP_entry_value:
+			case DW_OP_GNU_entry_value:
+				if (reg_matched)
+					break;
+				if (dwarf_getlocation_attr (attr, expr, &entry_attr) !=3D 0)
+					break;
+				if (dwarf_getlocation (&entry_attr, &entry_ops, &entry_len) !=3D 0)
+					break;
+				if (entry_len !=3D 1)
+					break;
+				if (expected_reg >=3D 0 && expected_reg =3D=3D entry_ops->atom) {
+					reg_matched =3D true;
+					return true;
+				}
+				break;
+			default:
+				break;
+			}
 		}
-
-		return true;
 	}
=20
-	return false;
+	if (reg_unmatched)
+		parm->unexpected_reg =3D 1;
+	else if (ret && !first_expr_reg)
+		parm->optimized =3D 1;
+
+	return ret;
 #else
 	if (dwarf_getlocation(attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
 		loc.exprlen !=3D 0) {
--=20
2.43.5


