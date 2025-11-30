Return-Path: <bpf+bounces-75773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E66C94B3D
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 05:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037953A5863
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 04:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EAF238166;
	Sun, 30 Nov 2025 04:03:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D641DEFE0
	for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764475439; cv=none; b=knpR5Z349FVR8V3sgzFDsyHPNxw1vMg3uBZHNsnweDCoEQsrv2qCA1En+eVVqlzyNYuzy5ABcPsrdVva7eTdxud79WbXGI6oKshCWBcNFjPOczjoG71LbLI/MkjAWT6W682SiKk/HLLuCUghhknso73bRBM+ikrwOAqNfJ7TyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764475439; c=relaxed/simple;
	bh=QnKTW9o4Y81pt5LkJFVI85eVEIQ7roRsro9Ic8vmzDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKalJOWgZP5Gvw14nZUwZKOLeJX8ckqpMRIARHzi+F1MSl3/yI5oAvzofr6LxQMgptU1BPnUfsiqfREGDo8jtDVhuYZCejPLkaU66rggaA2Ey31O9+8cCRvI/8pFDDw0T+3wA3Y2A6IAv3NN9MWCjFAW+XDVadblzcz5NsQDu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4F51E15D63B79; Sat, 29 Nov 2025 20:03:45 -0800 (PST)
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
Subject: [PATCH dwarves v2 1/2] btf_encoder: Refactor elf_functions__new() with struct btf_encoder as argument
Date: Sat, 29 Nov 2025 20:03:45 -0800
Message-ID: <20251130040345.2636661-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251130040340.2636458-1-yonghong.song@linux.dev>
References: <20251130040340.2636458-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For elf_functions__new(), replace original argument 'Elf *elf' with
'struct btf_encoder *encoder' for future use.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b37ee7f..3486fa3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -186,11 +186,13 @@ static inline void elf_functions__delete(struct elf=
_functions *funcs)
=20
 static int elf_functions__collect(struct elf_functions *functions);
=20
-struct elf_functions *elf_functions__new(Elf *elf)
+struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
 {
 	struct elf_functions *funcs;
+	Elf *elf;
 	int err;
=20
+	elf =3D encoder->cu->elf;
 	funcs =3D calloc(1, sizeof(*funcs));
 	if (!funcs) {
 		err =3D -ENOMEM;
@@ -1541,7 +1543,7 @@ static struct elf_functions *btf_encoder__elf_funct=
ions(struct btf_encoder *enco
=20
 	funcs =3D elf_functions__find(encoder->cu->elf, &encoder->elf_functions=
_list);
 	if (!funcs) {
-		funcs =3D elf_functions__new(encoder->cu->elf);
+		funcs =3D elf_functions__new(encoder);
 		if (funcs)
 			list_add(&funcs->node, &encoder->elf_functions_list);
 	}
--=20
2.47.3


