Return-Path: <bpf+bounces-74245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 024FEC4F2F1
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77E1D4ED46A
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9080377E86;
	Tue, 11 Nov 2025 17:04:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67073115BD
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880683; cv=none; b=pBXJSrSQbO5WYxfPPeQvIFhWT6wqke67plncy/t5ixwdu3vaJlqMUHUteOGVvJrlpf1V7OXihNirnwymPEzAgtV7KS1KuwzlvZMtVsGELE1Qpw+5x39dBo3QfPPipzJgpbhWScuCyL5IfkW9ouB0sTuqWmRGmfSwkZU4w4/Lhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880683; c=relaxed/simple;
	bh=VYIBjBVTCNqOAFEgx+njh/nJbLMUFKX20ywZAqKiNpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avi/Tyoof3YGY9rnapxGIeglwDF6qrM/LILUXIX5wEmxCzf9PVoNXn4sLxBrfgCUn8lw9z8nKqf34hv+OBbcyybnqptDweJbSSiPFKpTOu8lFbmaVF9KZuCMPdDWZPNExADuoBy0BtDapM+bmlKTEsIESdtbh8iogpNeIvwYEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DDCBB14B81A06; Tue, 11 Nov 2025 09:04:29 -0800 (PST)
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
Subject: [PATCH dwarves 1/3] btf_encoder: Refactor elf_functions__new() with struct btf_encoder as argument
Date: Tue, 11 Nov 2025 09:04:29 -0800
Message-ID: <20251111170429.287170-1-yonghong.song@linux.dev>
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

For elf_functions__new(), replace original argument 'Elf *elf' with
'struct btf_encoder *encoder' for future use.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 03bc3c7..1c69577 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -187,11 +187,13 @@ static inline void elf_functions__delete(struct elf=
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
@@ -1509,7 +1511,7 @@ static struct elf_functions *btf_encoder__elf_funct=
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


