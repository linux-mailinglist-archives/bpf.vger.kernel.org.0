Return-Path: <bpf+bounces-49486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15DA1921F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 14:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7A188CAF4
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926792135A8;
	Wed, 22 Jan 2025 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="go5uqKuo"
X-Original-To: bpf@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5A212FAC
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551524; cv=none; b=cuFoCT+X/S+oWIblRxiRPYZmVGb9dWa/IpSozn1MSxN0qUJlqpqZuo8HHbKphuGw2l9/yoqCgf3Vpw6c31B5yhDMxv04FdpZw312JoB++ac8tbEnXCnVuTwN3FzYK6sjBJg6y6nD2yRxdTxdYssUz/uVdm3bN1Vp16Wobi5G2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551524; c=relaxed/simple;
	bh=MbU5Hw2NrLk73hMJf5KX8qD3kbzHOA7c/mMUYxH4Syc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:
	 In-Reply-To:To:CC:References; b=j/nwpIF8DUaMEZ/q4t5z3D9YuM1ns9jnwgATQIVoKdA9tl64PgDtvFgGzvdN8XBqmeUwrlNviTaVKZXShFgx9hpgV501OYYQ6sEdYjfumtt3raL/DK9K7W1mK1SoxtGH9yetNU69nnek1RuIFQH6eo0GaOT6hO2uKa//pDUH4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=go5uqKuo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250122131200euoutp026a4cf340a79e17664ebc1c00b2d71a90~dBebRe7RM3063030630euoutp02S
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250122131200euoutp026a4cf340a79e17664ebc1c00b2d71a90~dBebRe7RM3063030630euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737551520;
	bh=AQSHP5JpmUfq+hzDVRcryuFhQ34puHtIRq2CRpsyNAM=;
	h=From:Date:Subject:In-Reply-To:To:CC:References:From;
	b=go5uqKuoWqqeLCDIwiH/lCasZjoSPNWgHCetAF2cwG6hU71ccnSAcgKzA5WmjEsb3
	 /7HbUhgxcQn21l8+oWyiQ8etrAJNsFCudiotzho6of3rJZ4gzs8IThQId2R0JcBRz4
	 ekVpZ+TPClpF8VET8/3y3EAd0J4ERLtSfOdpoFkU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250122131159eucas1p1142f0f4848b1362552270be6d32365a1~dBea-zQvY2302923029eucas1p1d;
	Wed, 22 Jan 2025 13:11:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.85.20821.F9EE0976; Wed, 22
	Jan 2025 13:11:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c~dBeag14Ss2303723037eucas1p1d;
	Wed, 22 Jan 2025 13:11:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250122131159eusmtrp2b8e689e35105e5b26262c5c6214aeda7~dBeagDFsR0895308953eusmtrp2S;
	Wed, 22 Jan 2025 13:11:59 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-41-6790ee9f0b8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.A2.19920.F9EE0976; Wed, 22
	Jan 2025 13:11:59 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250122131159eusmtip286f64d8a3d84a40be30419b852a81ae3~dBeaPM6BZ1589415894eusmtip2-;
	Wed, 22 Jan 2025 13:11:59 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id
	15.0.1497.48; Wed, 22 Jan 2025 13:11:58 +0000
From: Daniel Gomez <da.gomez@samsung.com>
Date: Wed, 22 Jan 2025 14:11:14 +0100
Subject: [PATCH 2/2] moderr: add module error injection tool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
In-Reply-To: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
	Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <llvm@lists.linux.dev>,
	<iovisor-dev@lists.iovisor.org>, <gost.dev@samsung.com>, Daniel Gomez
	<da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737551516; l=17312;
	i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
	bh=MbU5Hw2NrLk73hMJf5KX8qD3kbzHOA7c/mMUYxH4Syc=;
	b=3ASmzQ/7ChWwXKdLj0GcxXs4rURe/NQbtqQo+guV0rSYZwgxR86vmgKsOOq+APhffW6MNYnSX
	VacFH3Q1C1fDYM9GhQI78CawTHSpUrx7vuk813J/BcOkQa3iaXomWvT
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
	pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGPffe3pa6skuL4YShYhO3uGjFzJmTwRaWEXchW7ZMErMlC+vg
	rqhATcvH5moCEi2gzM4xhUoDyKptoeusoNixFjugCGwaKbVxIwFpZXXU4UqohWBHP8z873ee
	533ec57kcHB+DZnKOVBWzsjKxCVCkktcHQ7d2tH2SCXJCHu2o+DKeRwthv5go8Cgg0SdHUs4
	cuuacWR32NjoidYJ0LE+HYYGm9Q4OtvVSaI5ayOGJiytJKo+H2QhT5ONRN31ehZyq7wAmScC
	LKTUe0m0oApjSLv4CEdanZ+FJlssGHJcWiXRdNdVVjak3dZRjL6unmLT7eYKusF9B6fNhnqS
	7qj+HqeHThwj6L+utADa1DNJ0AHzpg+5n3CzipiSA5WMbOdbn3GLPRenicMXlODLwNQVUA1m
	pQ0ggQOp3VC/4mQ1AC6HT+kA1Du72RGDTy0C+KA2J8YBAH8dYD0LdM1Xg1jgEoDjF51Y7LA2
	5G7qj6/qAfDy4lg0QlLboPWmObqWoLZC710jEWEBlQVn7zZHmUclwZstnjXmcPC1eZNlZ0TG
	qc3wmr8Vj8g86j048ntRRE6g3odnh7xE5KpkysWC1+7diB5wygVg46SWjD11A1z5zhI1IDWA
	wTu+IB4zGKi7/2ect8Dmb/VEjI9C4/A4OxYwcuFE8Kf4phxo+DGMxVgAHzp62DFOg+HrbXH9
	EPwt2A9iXA6fLizHl2bCsHEqrr8NZ7oN0ZaQSoRuf5IKvKx+rr/6//7q5/q3A9wAUpgKeamE
	ke8qY6pEcnGpvKJMIiqUlprB2i8de+r4tw9oHj4W2QHGAXYAObgwmRf2qCR8XpH4qyOMTFog
	qyhh5HbwEocQpvAu2I5L+JREXM4cYpjDjOyZi3ESUquxvfdD7jNJ4vqGH9rCOaXW1BpR58cd
	gtyD+bc/qhuZMi18PV85mG45vpyct93dXT89D9KVLxasX/p8n+HcO2m+uQW79u9XukLv1u15
	IprafYolbPQVtgrrx9aPn9xb3Jubd06hyNhU0T6344ZR+2BGI5JusFm+GFg93Tm0sSY9k83+
	lDDfvld5cDgte4lRhqZPrdvXO9n3QePPLr9x85kt+/e3vDaoKDhZV5gkatZorbcUmTOzVVnr
	3viHnbGN/6bAvJHhLvse86UOib+2NT33BY25Cl7uz/6mxKs8kZhYYFIMnc7vPeJSjo68niU4
	2m+yuXz5zjwP/ctWzZ6i1dGU2lkhIS8W73oVl8nF/wG8fQEIFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsVy+t/xe7rz301IN5j0hNPi++/ZzBZfft5m
	t/h85DibxeKF35gtbqyYwWxx6Ph+dosfS68wWjTtWMFkcWTKLGaLaasXs1k839fLZHF51xw2
	i4bZ31ktnkzZz2axpnMlq8WNCU8ZLTZd/sxq0b7yKZvFhwn/mSyWfnnHbLF0xVtWi6szdzFZ
	HF/+l83iweptrA4SHjf2nWLy2DnrLrvHgk2lHl03LjF7bFrVyeaxsGEqs8fRtiYWjxebZzJ6
	rN9ylcXj8ya5AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
	stQifbsEvYwnyx6wFCxqZ6z4fHczYwPj4/wuRk4OCQETidVvGhi7GLk4hASWMkp0bd7FBJGQ
	kdj45SorhC0s8edaFxtE0UdGia+fdrJCOFsYJRo/PGUDqWIT0JTYd3ITO4jNIqAq8fT6WhYQ
	W1jARuLx9RlgNq+AoMTJmU+AbA4OZqD69bv0QcLMAvIS29/OYQYJ8wr4SJw4lwISFgIyv61d
	DtbJKeArMe3oUxaQtSIC11glpsw7BXY1s8A1Roneq0vZIC4Vlfg9eRcLhH2ASWL3IgcIO1Vi
	+5UlUDWKEjMmroSqqZV4dX834wRGsVlIzpuFcN4sJOctYGRexSiSWlqcm55bbKhXnJhbXJqX
	rpecn7uJEZiYth37uXkH47xXH/UOMTJxMB5ilOBgVhLh/f9kQroQb0piZVVqUX58UWlOavEh
	RlNgEE1klhJNzgemxrySeEMzA1NDEzNLA1NLM2MlcV63y+fThATSE0tSs1NTC1KLYPqYODil
	GpiEDvMYukw7Ka/+rpvBrucQr0hj6N/ueHfR7E/5Uy6fDU+0l062YHwUqLrJ48HZZ3M/2ey0
	a+koLv1xxZTBcnO2qI8fC6POpbLQ64ed86PLN73ma4hiaomweJIgyJa25qgW28/X/AeZHC+U
	2jyc8inxyI82xsIpHxwZ25/5K0WxrZL30ty5cdZr4x/stUJXNnvcNX8WtPata9TOzGVntORX
	Rxwzf6GuPSOsdNVrkfKtfSk2ddU6ixsDNm9KSr5VtXutaZlWWe3E+bURxdddIzOdjrjPOxMS
	Lys/0UTpxeLN2QsXfnSqvZ9+sffU6v9ysxhvmD1SSuSv2Lnj15Zj969940m/2WQyqZijSDO3
	W4mlOCPRUIu5qDgRAP0fIqfVAwAA
X-CMS-MailID: 20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c
X-Msg-Generator: CA
X-RootMTR: 20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c
References: <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
	<CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>

Add support for a module error injection tool. The tool
can inject errors in the annotated module kernel functions
such as complete_formation(), do_init_module() and
module_enable_rodata_after_init(). Module name and module function are
required parameters to have control over the error injection.

Example: Inject error -22 to module_enable_rodata_ro_after_init for
brd module:

sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
--error=-22 --trace
Monitoring module error injection... Hit Ctrl-C to end.
MODULE     ERROR FUNCTION
brd        -22   module_enable_rodata_after_init()

Kernel messages:
[   89.463690] brd: module loaded
[   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
ro_after_init data might still be writable

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 tools/bpf/Makefile            |  13 ++-
 tools/bpf/moderr/.gitignore   |   2 +
 tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
 tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
 tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
 tools/bpf/moderr/moderr.h     |  40 +++++++
 6 files changed, 510 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 243b79f2b451e52ca196f79dc46befd1b3dab458..018cab5102e7e42b8b7b2749f4f463bf55c5119b 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -38,7 +38,7 @@ FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
 FEATURE_DISPLAY = libbfd
 
 check_feat := 1
-NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
+NON_CHECK_FEAT_TARGETS := clean bpftool_clean moderr_clean runqslower_clean resolve_btfids_clean
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CHECK_FEAT_TARGETS),$(MAKECMDGOALS)),)
   check_feat := 0
@@ -76,7 +76,7 @@ $(OUTPUT)%.lex.o: $(OUTPUT)%.lex.c
 
 PROGS = $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg $(OUTPUT)bpf_asm
 
-all: $(PROGS) bpftool runqslower
+all: $(PROGS) bpftool moderr runqslower
 
 $(OUTPUT)bpf_jit_disasm: CFLAGS += -DPACKAGE='bpf_jit_disasm'
 $(OUTPUT)bpf_jit_disasm: $(OUTPUT)bpf_jit_disasm.o
@@ -92,7 +92,7 @@ $(OUTPUT)bpf_exp.lex.c: $(OUTPUT)bpf_exp.yacc.c
 $(OUTPUT)bpf_exp.yacc.o: $(OUTPUT)bpf_exp.yacc.c
 $(OUTPUT)bpf_exp.lex.o: $(OUTPUT)bpf_exp.lex.c
 
-clean: bpftool_clean runqslower_clean resolve_btfids_clean
+clean: bpftool_clean moderr_clean runqslower_clean resolve_btfids_clean
 	$(call QUIET_CLEAN, bpf-progs)
 	$(Q)$(RM) -r -- $(OUTPUT)*.o $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg \
 	       $(OUTPUT)bpf_asm $(OUTPUT)bpf_exp.yacc.* $(OUTPUT)bpf_exp.lex.*
@@ -118,6 +118,12 @@ bpftool_install:
 bpftool_clean:
 	$(call descend,bpftool,clean)
 
+moderr:
+	$(call descend,moderr)
+
+moderr_clean:
+	$(call descend,moderr,clean)
+
 runqslower:
 	$(call descend,runqslower)
 
@@ -131,5 +137,6 @@ resolve_btfids_clean:
 	$(call descend,resolve_btfids,clean)
 
 .PHONY: all install clean bpftool bpftool_install bpftool_clean \
+	moderr moderr_clean \
 	runqslower runqslower_clean \
 	resolve_btfids resolve_btfids_clean
diff --git a/tools/bpf/moderr/.gitignore b/tools/bpf/moderr/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..ffdb70230c8bc308efcc8b7d2084856e2225da91
--- /dev/null
+++ b/tools/bpf/moderr/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/.output
diff --git a/tools/bpf/moderr/Makefile b/tools/bpf/moderr/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..e6331179f7800e6c1d1945ca713e34f74f7d805d
--- /dev/null
+++ b/tools/bpf/moderr/Makefile
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+include ../../scripts/Makefile.include
+include ../../scripts/Makefile.arch
+
+OUTPUT ?= $(abspath .output)/
+
+BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
+DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bootstrap/bpftool
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+LIBBPF_SRC := $(abspath ../../lib/bpf)
+BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
+BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
+BPF_DESTDIR := $(BPFOBJ_OUTPUT)
+BPF_INCLUDE := $(BPF_DESTDIR)include
+INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
+CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
+CFLAGS += $(EXTRA_CFLAGS)
+LDFLAGS += $(EXTRA_LDFLAGS)
+LDLIBS += -lelf -lz
+
+# Try to detect best kernel BTF source
+KERNEL_REL := $(shell uname -r)
+VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)		\
+	$(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) \
+	../../../vmlinux /sys/kernel/btf/vmlinux	\
+	/boot/vmlinux-$(KERNEL_REL)
+VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
+					  $(wildcard $(VMLINUX_BTF_PATHS))))
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+MAKEFLAGS += --no-print-directory
+submake_extras := feature_display=0
+endif
+
+.DELETE_ON_ERROR:
+
+.PHONY: all clean moderr libbpf_hdrs
+all: moderr
+
+moderr: $(OUTPUT)moderr
+
+clean:
+	$(call QUIET_CLEAN, moderr)
+	$(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
+	$(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
+	$(Q)$(RM) $(OUTPUT)moderr
+	$(Q)$(RM) -r .output
+
+libbpf_hdrs: $(BPFOBJ)
+
+$(OUTPUT)moderr: $(OUTPUT)moderr.o $(BPFOBJ)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+
+$(OUTPUT)moderr.o: moderr.h $(OUTPUT)moderr.skel.h	      \
+			$(OUTPUT)moderr.bpf.o | libbpf_hdrs
+
+$(OUTPUT)moderr.bpf.o: $(OUTPUT)vmlinux.h moderr.h | libbpf_hdrs
+
+$(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o | $(BPFTOOL)
+	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
+
+$(OUTPUT)%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
+	$(QUIET_GEN)$(CLANG) -g -O2 --target=bpf $(INCLUDES) \
+		 -D__TARGET_ARCH_$(SRCARCH)						 \
+		 -c $(filter %.c,$^) -o $@ &&				     \
+	$(LLVM_STRIP) -g $@
+
+$(OUTPUT)%.o: %.c | $(OUTPUT)
+	$(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
+
+$(OUTPUT) $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT):
+	$(QUIET_MKDIR)mkdir -p $@
+
+$(OUTPUT)vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
+ifeq ($(VMLINUX_H),)
+	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
+		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
+			"specify its location." >&2;			       \
+		exit 1;\
+	fi
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
+else
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(BPFOBJ_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(BPFOBJ_OUTPUT) \
+		    DESTDIR=$(BPFOBJ_OUTPUT) prefix= $(abspath $@) install_headers
+
+$(DEFAULT_BPFTOOL): | $(BPFTOOL_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../bpftool OUTPUT=$(BPFTOOL_OUTPUT) bootstrap
diff --git a/tools/bpf/moderr/moderr.bpf.c b/tools/bpf/moderr/moderr.bpf.c
new file mode 100644
index 0000000000000000000000000000000000000000..1c5d03336dd87a2f065ef6b608f077a8b988e5cf
--- /dev/null
+++ b/tools/bpf/moderr/moderr.bpf.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Samsung */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "moderr.h"
+
+const volatile bool filter_modname = false;
+const volatile char targ_modname[MODULE_NAME_LEN];
+const volatile bool set_errinj = false;
+const volatile int targ_errinj = 0;
+const volatile bool filter_modfunc = false;
+const volatile int targ_modfunc = 0;
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 2097152);
+} rb SEC(".maps");
+
+static __always_inline bool filter_module_name(struct module *mod)
+{
+	char modname[MODULE_NAME_LEN];
+
+	bpf_probe_read_str(modname, sizeof(modname), mod->name);
+
+	if (!filter_modname ||
+	    filter_modname && bpf_strncmp(modname, MODULE_NAME_LEN,
+					  (const char *)targ_modname) != 0)
+		return false;
+
+	return true;
+}
+
+static __always_inline bool filter_module_func(enum modfunc fc)
+{
+	if (!filter_modfunc || filter_modfunc && targ_modfunc != fc)
+		return false;
+
+	return true;
+}
+
+static __always_inline bool
+generate_errinj_event(struct pt_regs *ctx, struct module *mod, enum modfunc fc)
+{
+	struct event *e;
+
+	e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
+	if (!e)
+		return false;
+
+	e->err = 0;
+	e->func = fc;
+	bpf_probe_read_str(e->modname, sizeof(e->modname), mod->name);
+
+	if (set_errinj) {
+		bpf_override_return(ctx, targ_errinj);
+		e->err = targ_errinj;
+	}
+
+	bpf_ringbuf_submit(e, 0);
+	return true;
+}
+
+static __always_inline bool generate_debug_event(struct pt_regs *ctx,
+						 struct module *mod,
+						 enum modfunc fc,
+						 const char *fmt)
+{
+	struct event *e;
+
+	e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
+	if (!e)
+		return false;
+
+	e->dbg = BPF_SNPRINTF(e->msg, sizeof(e->msg), "[%s:%s]: %s", mod->name,
+			      modfunc_to_string(fc), fmt);
+
+	bpf_ringbuf_submit(e, 0);
+	return true;
+}
+
+static __always_inline int
+module_error_injection(struct pt_regs *ctx, struct module *mod, enum modfunc fc)
+{
+	if (!filter_module_name(mod)) {
+		generate_debug_event(ctx, mod, fc,
+				     "Target module does not match");
+		return 0;
+	}
+
+	if (!filter_module_func(fc)) {
+		generate_debug_event(ctx, mod, fc,
+				     "Target function does not match");
+		return 0;
+	}
+
+	if (!generate_errinj_event(ctx, mod, fc)) {
+		generate_debug_event(
+			ctx, mod, fc,
+			"Error injection event cannot be generated");
+		return 0;
+	}
+
+	return 0;
+}
+
+SEC("kprobe/complete_formation")
+int BPF_KPROBE(complete_formation, struct module *mod, struct load_info *info)
+{
+	return module_error_injection(ctx, mod, COMPLETE_FORMATION);
+}
+
+SEC("kprobe/do_init_module")
+int BPF_KPROBE(do_init_module, struct module *mod, struct load_info *info)
+{
+	return module_error_injection(ctx, mod, DO_INIT_MODULE);
+}
+
+SEC("kprobe/module_enable_rodata_ro_after_init")
+int BPF_KPROBE(module_enable_rodata_ro_after_init, struct module *mod)
+{
+	return module_error_injection(ctx, mod,
+				      MODULE_ENABLE_RODATA_AFTER_INIT);
+}
diff --git a/tools/bpf/moderr/moderr.c b/tools/bpf/moderr/moderr.c
new file mode 100644
index 0000000000000000000000000000000000000000..dce18b02b55d1ad1f7e304cb49985d570b115aa4
--- /dev/null
+++ b/tools/bpf/moderr/moderr.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Samsung */
+#include <argp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <stdlib.h>
+#include <string.h>
+#include "moderr.h"
+#include "moderr.skel.h"
+
+static struct env {
+	bool verbose;
+	char modname[MODULE_NAME_LEN];
+	enum modfunc func;
+	bool trace;
+	int errinj;
+} env;
+
+const char *argp_program_version = "moderr 0.1";
+const char *argp_program_bug_address = "<da.gomez@samsung.com>";
+const char argp_program_doc[] =
+"BPF moderr application.\n"
+"\n"
+"It injects errors in module initialization\n"
+"\nUSAGE: "
+"moderr [-m <module_name>] [-f <function_name>] [-e <errno>]\n";
+
+static volatile bool exiting = false;
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+static const struct argp_option opts[] = {
+	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
+	{ "trace", 't', NULL, 0, "Enable trace output", 0 },
+	{ "modname", 'm', "MODNAME", 0, "Trace this module name only", 0 },
+	{ "modfunc", 'f', "MODFUNC", 0, "Trace this module function only", 0 },
+	{ "list", 'l', NULL, 0, "List available module functions", 0 },
+	{ "error", 'e', "ERROR", 0, "Inject this error", 0 },
+	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help", 0 },
+	{},
+};
+
+static void help_modfunc(void)
+{
+	printf("\nAvailable modfunc options are:\n"
+	       "- complete_formation\n"
+	       "- do_init_module\n"
+	       "- module_enable_rodata_ro_after_init\n\n");
+}
+
+static enum modfunc string_to_modfunc(char *arg)
+{
+	if (strncmp(arg, "complete_formation", strlen(arg)) == 0)
+		return COMPLETE_FORMATION;
+
+	if (strncmp(arg, "do_init_module", strlen(arg)) == 0)
+		return DO_INIT_MODULE;
+
+	if (strncmp(arg, "module_enable_rodata_ro_after_init", strlen(arg)) ==
+	    0)
+		return MODULE_ENABLE_RODATA_AFTER_INIT;
+
+	return UNKNOWN;
+}
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case 'h':
+		argp_state_help(state, stderr, ARGP_HELP_STD_HELP);
+		break;
+	case 'l':
+		help_modfunc();
+		argp_usage(state);
+		break;
+	case 'v':
+		env.verbose = true;
+		break;
+	case 'm':
+		if (strlen(arg) + 1 > MODULE_NAME_LEN) {
+			fprintf(stderr, "module name error\n");
+			argp_usage(state);
+		}
+		strncpy(env.modname, arg, sizeof(env.modname) - 1);
+		break;
+	case 'f':
+		if (strlen(arg) + 1 > MODULE_FUNC_LEN) {
+			fprintf(stderr, "module function too long\n");
+			argp_usage(state);
+		}
+		env.func = string_to_modfunc(arg);
+		if (!env.func) {
+			fprintf(stderr, "invalid module function\n");
+			help_modfunc();
+			argp_usage(state);
+		}
+		break;
+	case 'e':
+		env.errinj = atoi(arg);
+		break;
+	case 't':
+		env.trace = true;
+		break;
+	case ARGP_KEY_ARG:
+		argp_usage(state);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+static const struct argp argp = {
+	.options = opts,
+	.parser = parse_arg,
+	.doc = argp_program_doc,
+};
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format,
+			   va_list args)
+{
+	if (level == LIBBPF_DEBUG && !env.verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sig_handler(int sig)
+{
+	exiting = true;
+}
+
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	const struct event *e = data;
+
+	if (!env.trace)
+		return 0;
+
+	if (e->dbg) {
+		if (env.verbose)
+			printf("%s\n", e->msg);
+		return 0;
+	}
+
+	printf("%-10s %-5d %-20s\n", e->modname, e->err,
+	       modfunc_to_string(e->func));
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct ring_buffer *rb = NULL;
+	struct moderr_bpf *obj;
+	int err;
+
+	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
+	if (err)
+		return err;
+
+	if (!strlen(env.modname) || !env.func) {
+		fprintf(stderr, "missing arguments\n");
+		return EXIT_FAILURE;
+	}
+
+	libbpf_set_print(libbpf_print_fn);
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	obj = moderr_bpf__open();
+	if (!obj) {
+		fprintf(stderr, "failed to open and load BPF object\n");
+		return 1;
+	}
+
+	obj->rodata->filter_modname = true;
+	strncpy(obj->rodata->targ_modname, env.modname, MODULE_NAME_LEN - 1);
+	obj->rodata->targ_modname[MODULE_NAME_LEN - 1] = '\0';
+
+	obj->rodata->filter_modfunc = true;
+	obj->rodata->targ_modfunc = env.func;
+
+	if (env.errinj) {
+		obj->rodata->set_errinj = true;
+		obj->rodata->targ_errinj = env.errinj;
+	}
+
+	err = moderr_bpf__load(obj);
+	if (err) {
+		fprintf(stderr, "failed to load and verify BPF object\n");
+		goto cleanup;
+	}
+
+	err = moderr_bpf__attach(obj);
+	if (err) {
+		fprintf(stderr, "failed to attach BPF object\n");
+		goto cleanup;
+	}
+
+	printf("Monitoring module error injection... Hit Ctrl-C to end.\n");
+
+	rb = ring_buffer__new(bpf_map__fd(obj->maps.rb), handle_event, NULL,
+			      NULL);
+	if (!rb) {
+		err = -1;
+		fprintf(stderr, "failed to create ring buffer\n");
+		goto cleanup;
+	}
+
+	if (env.trace)
+		printf("%-10s %-5s %-20s\n", "MODULE", "ERROR", "FUNCTION");
+
+	while (!exiting) {
+		err = ring_buffer__poll(rb, 100);
+		if (err == -EINTR) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			fprintf(stderr, "error polling ring buffer: %d\n", err);
+			break;
+		}
+	}
+
+	printf("\n");
+
+cleanup:
+	ring_buffer__free(rb);
+	moderr_bpf__destroy(obj);
+
+	return err < 0 ? -err : 0;
+}
diff --git a/tools/bpf/moderr/moderr.h b/tools/bpf/moderr/moderr.h
new file mode 100644
index 0000000000000000000000000000000000000000..e17440cf4bd5fe09b927cb83807a88f66861bba5
--- /dev/null
+++ b/tools/bpf/moderr/moderr.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Samsung */
+#ifndef __MODERR_H
+#define __MODERR_H
+
+#define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
+#define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
+#define MODULE_FUNC_LEN 128
+#define MESSAGE_LEN 128
+
+enum modfunc {
+	UNKNOWN,
+	COMPLETE_FORMATION = 1,
+	DO_INIT_MODULE,
+	MODULE_ENABLE_RODATA_AFTER_INIT,
+};
+
+struct event {
+	char modname[MODULE_NAME_LEN];
+	int err;
+	int func;
+	char msg[MESSAGE_LEN];
+	int dbg;
+};
+
+static inline const char *modfunc_to_string(enum modfunc fc)
+{
+	switch (fc) {
+	case COMPLETE_FORMATION:
+		return "complete_formation()";
+	case DO_INIT_MODULE:
+		return "do_init_module()";
+	case MODULE_ENABLE_RODATA_AFTER_INIT:
+		return "module_enable_rodata_after_init()";
+	default:
+		return "unknown";
+	}
+}
+
+#endif /* __MODERR_H */

-- 
2.39.5


