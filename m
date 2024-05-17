Return-Path: <bpf+bounces-29920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467D8C81E7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D19B21AA9
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485AA39AF0;
	Fri, 17 May 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmlWZao8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDC36137
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932631; cv=none; b=dEZhPVGxBuJ16LPiNMnzNOp+RvefCPb4/vygaHTR/5ky5wqA4I8fUGy2itGWUEiBmSPpGVzKNat63KWO+133FopudP2+wfoWFL7nOWo+fkkHpwWn6AL6aT4g4KoXvNzXe7t3WNataU8d7lhqnv3GRvJVmAFDu3IK2uy+/5h/UmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932631; c=relaxed/simple;
	bh=9gA8C7scapzQkOpcYTVUyzOG+DKqZe9FF6oObQonZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aal32+q5lmMIV1ljbp/dNFRHHC45zPxpjP/8PpIZt0hLh4WhXthYurk16qq8y0z1h0aZ1GNlCpZN3jUH+jJtqeWkuhhdZtBZqvbpdqhe5+4prdQltnIbmAaqMQoGsXhUXoKu7qTrQZD/E6fFQEEAe6OVrnFK6TqFiiVsoww1OPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmlWZao8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojtsOOMpEVSQ1qTErBfqA1ZFUuWuw8zuknPaEwojp0k=;
	b=OmlWZao8LEMCSXo9JB5mbpHeZ4mymtJ1thKkIrU1MMppFK2gDAe8hm/dnG0a17WnTGWFG8
	BqAdUOvc6tyCKzlozmo8YWtRvYT8Es9376O7mGyGQPuRXxQ33tYlGfo6fo5Ah012cH+y4l
	kzplrDp/tcZOXJWzfqw4z+qFD/W84A4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-E7lV0bIaOeCWPztpMpSOSg-1; Fri, 17 May 2024 03:57:06 -0400
X-MC-Unique: E7lV0bIaOeCWPztpMpSOSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4540B8001F7;
	Fri, 17 May 2024 07:57:06 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB50C740F;
	Fri, 17 May 2024 07:57:04 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 5/5] powerpc64/bpf: jit support for signed division and modulo
Date: Fri, 17 May 2024 09:56:50 +0200
Message-ID: <20240517075650.248801-6-asavkov@redhat.com>
In-Reply-To: <20240517075650.248801-1-asavkov@redhat.com>
References: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add jit support for sign division and modulo. Tested using test_bpf
module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/net/bpf_jit_comp64.c     | 41 +++++++++++++++++++++------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 76cc9a2d82065..b98a9e982c03b 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -536,6 +536,7 @@
 #define PPC_RAW_MULI(d, a, i)		(0x1c000000 | ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
 #define PPC_RAW_DIVW(d, a, b)		(0x7c0003d6 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVWU(d, a, b)		(0x7c000396 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
+#define PPC_RAW_DIVD(d, a, b)		(0x7c0003d2 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVDU(d, a, b)		(0x7c000392 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVDE(t, a, b)		(0x7c000352 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVDE_DOT(t, a, b)	(0x7c000352 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | 0x1)
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 811775cfd3a1b..1f5f93926e424 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -510,20 +510,33 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
 		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
 			if (BPF_OP(code) == BPF_MOD) {
-				EMIT(PPC_RAW_DIVWU(tmp1_reg, dst_reg, src_reg));
+				if (off)
+					EMIT(PPC_RAW_DIVW(tmp1_reg, dst_reg, src_reg));
+				else
+					EMIT(PPC_RAW_DIVWU(tmp1_reg, dst_reg, src_reg));
+
 				EMIT(PPC_RAW_MULW(tmp1_reg, src_reg, tmp1_reg));
 				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
 			} else
-				EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
+				if (off)
+					EMIT(PPC_RAW_DIVW(dst_reg, dst_reg, src_reg));
+				else
+					EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
 			goto bpf_alu32_trunc;
 		case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
 		case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
 			if (BPF_OP(code) == BPF_MOD) {
-				EMIT(PPC_RAW_DIVDU(tmp1_reg, dst_reg, src_reg));
+				if (off)
+					EMIT(PPC_RAW_DIVD(tmp1_reg, dst_reg, src_reg));
+				else
+					EMIT(PPC_RAW_DIVDU(tmp1_reg, dst_reg, src_reg));
 				EMIT(PPC_RAW_MULD(tmp1_reg, src_reg, tmp1_reg));
 				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
 			} else
-				EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, src_reg));
+				if (off)
+					EMIT(PPC_RAW_DIVD(dst_reg, dst_reg, src_reg));
+				else
+					EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
 		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
@@ -544,19 +557,31 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			switch (BPF_CLASS(code)) {
 			case BPF_ALU:
 				if (BPF_OP(code) == BPF_MOD) {
-					EMIT(PPC_RAW_DIVWU(tmp2_reg, dst_reg, tmp1_reg));
+					if (off)
+						EMIT(PPC_RAW_DIVW(tmp2_reg, dst_reg, tmp1_reg));
+					else
+						EMIT(PPC_RAW_DIVWU(tmp2_reg, dst_reg, tmp1_reg));
 					EMIT(PPC_RAW_MULW(tmp1_reg, tmp1_reg, tmp2_reg));
 					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
 				} else
-					EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, tmp1_reg));
+					if (off)
+						EMIT(PPC_RAW_DIVW(dst_reg, dst_reg, tmp1_reg));
+					else
+						EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, tmp1_reg));
 				break;
 			case BPF_ALU64:
 				if (BPF_OP(code) == BPF_MOD) {
-					EMIT(PPC_RAW_DIVDU(tmp2_reg, dst_reg, tmp1_reg));
+					if (off)
+						EMIT(PPC_RAW_DIVD(tmp2_reg, dst_reg, tmp1_reg));
+					else
+						EMIT(PPC_RAW_DIVDU(tmp2_reg, dst_reg, tmp1_reg));
 					EMIT(PPC_RAW_MULD(tmp1_reg, tmp1_reg, tmp2_reg));
 					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, tmp1_reg));
 				} else
-					EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, tmp1_reg));
+					if (off)
+						EMIT(PPC_RAW_DIVD(dst_reg, dst_reg, tmp1_reg));
+					else
+						EMIT(PPC_RAW_DIVDU(dst_reg, dst_reg, tmp1_reg));
 				break;
 			}
 			goto bpf_alu32_trunc;
-- 
2.45.0


