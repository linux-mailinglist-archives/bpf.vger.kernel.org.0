Return-Path: <bpf+bounces-74246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C826C4F2F4
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF3D4EDBE3
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8008377E90;
	Tue, 11 Nov 2025 17:04:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678E36CE03
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880684; cv=none; b=qp7vDr7LObldMt9PvlPHepoVQIhn6HMxA570EJt35bneKeoR282eDGJXbMFGbS5Z5snxMkYTqr3n4qNZs5pG2CeLOHj5hNBxn8gkh1dJHjUk+xZwZ5JT7p6118CNisW7pA1OJSFC4e1I/P2qnKP6JftyQ546DW9Z1ozeXjj9c1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880684; c=relaxed/simple;
	bh=hsycmXAHehfr4kQaW7lud8UMrcHrqiul/tVlyIUzRaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pG6TyQ3DqPEfNPLuvg0AYsAdGmlTC+VjPG0A7cpDMZrS6k/0zpfzUWl9bqKwd47LJzwNj5cKsm1QXrNpdeklB7NABGh6k3KhucJjI2O7drR68tI3PQmewNtfi0cALz4L8des5Gi5yxDmm35+aO1WJRHEqJ3xqlI8iRMMQ8jMH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0225914B81A12; Tue, 11 Nov 2025 09:04:35 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	David Faust <david.faust@oracle.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH dwarves 2/3] bpf_encoder: Refactor a helper elf_function__check_and_push_sym()
Date: Tue, 11 Nov 2025 09:04:34 -0800
Message-ID: <20251111170434.287807-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111170424.286892-1-yonghong.song@linux.dev>
References: <20251111170424.286892-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inside elf_functions__collect(), refactor portion of the code
to be a helper elf_function__check_and_push_sym(). Such a helper
will be used in the next patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1c69577..d28af58 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2181,10 +2181,22 @@ static inline int elf_function__push_sym(struct e=
lf_function *func, struct elf_f
 	return 0;
 }
=20
+static int elf_function__check_and_push_sym(struct elf_function *func, c=
onst char *sym_name, int st_value)
+{
+	struct elf_function_sym func_sym;
+
+	if (!func->name)
+		return -ENOMEM;
+
+	func_sym.name =3D sym_name;
+	func_sym.addr =3D st_value;
+
+	return elf_function__push_sym(func, &func_sym);
+}
+
 static int elf_functions__collect(struct elf_functions *functions)
 {
 	uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
-	struct elf_function_sym func_sym;
 	struct elf_function *func, *tmp;
 	const char *sym_name, *suffix;
 	Elf32_Word sym_sec_idx;
@@ -2224,15 +2236,7 @@ static int elf_functions__collect(struct elf_funct=
ions *functions)
 		else
 			func->name =3D strdup(sym_name);
=20
-		if (!func->name) {
-			err =3D -ENOMEM;
-			goto out_free;
-		}
-
-		func_sym.name =3D sym_name;
-		func_sym.addr =3D sym.st_value;
-
-		err =3D elf_function__push_sym(func, &func_sym);
+		err =3D elf_function__check_and_push_sym(func, sym_name, sym.st_value)=
;
 		if (err)
 			goto out_free;
=20
--=20
2.47.3


