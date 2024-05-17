Return-Path: <bpf+bounces-29921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C18C81E8
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F51C21245
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57D3A1C5;
	Fri, 17 May 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTGnew54"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6636AE4
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932632; cv=none; b=pt7KtvVXgduz5QxfMmPKGiTy1KSDyvZJuHvzEY1DaE7yPZmRKji10ugxlYrZs9DQlbPyh8fSWWqpJP0fxbPbQUZrIBm4dVMHMTzr2NJ5M0I3kPxVHNGPx4Ep+EqVRkRBc3rUjc2fnmUTDlgfpvdidOlyE8l5u1hdiCYVwQwe65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932632; c=relaxed/simple;
	bh=YqLbfufeW7VmiN4YiSu4dqE3r4dbGApPtQWPOtaOLaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKD7xNmJ7QJ4VNBW94gZxT4syBtoD8fVSRpdCJamz8cSa8WF7+u/sDEmv+hZ+9ofRYcdblDVWYqmk0EOdJStekvsNIgP+dX8FcoUWqq5m1G70SrV3TfnQ/gmeUQSLXxZa+NnBoWntKlhHzHXGY5p4qY+qtdREx/44arqrC3/4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTGnew54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd2FKBCCbPYSn62NGk1dvMv2wELGjjJmJdCabLrNLS4=;
	b=jTGnew54b0OPo6S+/bILvQKcgZF0l9NxYePJwpg3eQquhjsnM3jloHHG7ZVXiPVtg/SLe9
	zzQJHog50Y1icBnf9P2+hy+W9kVLVXW8KcTDAw75ImRCpAXGxrwiR8ZYUaVdQqkPXsGN0a
	AAmKOqECKSZ90QUfx3+R2MdTdVyPtrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-7oOlzHjNPLyc9PnqOvSHLQ-1; Fri, 17 May 2024 03:57:03 -0400
X-MC-Unique: 7oOlzHjNPLyc9PnqOvSHLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8A87185A783;
	Fri, 17 May 2024 07:57:02 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB08740F;
	Fri, 17 May 2024 07:57:01 +0000 (UTC)
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
Subject: [PATCH 3/5] powerpc64/bpf: jit support for sign extended load
Date: Fri, 17 May 2024 09:56:48 +0200
Message-ID: <20240517075650.248801-4-asavkov@redhat.com>
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

Add jit support for sign extended load. Tested using test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/net/bpf_jit_comp64.c     | 61 ++++++++++++++++++---------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 076ae60b4a55d..76cc9a2d82065 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -471,6 +471,7 @@
 #define PPC_RAW_VCMPEQUB_RC(vrt, vra, vrb) \
 	(0x10000006 | ___PPC_RT(vrt) | ___PPC_RA(vra) | ___PPC_RB(vrb) | __PPC_RC21)
 #define PPC_RAW_LD(r, base, i)		(0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
+#define PPC_RAW_LWA(r, base, i)		(0xe8000002 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
 #define PPC_RAW_LWZ(r, base, i)		(0x80000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LWZX(t, a, b)		(0x7c00002e | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_STD(r, base, i)		(0xf8000000 | ___PPC_RS(r) | ___PPC_RA(base) | IMM_DS(i))
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 97191cf091bbf..b9f47398b311d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -925,13 +925,19 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 */
 		/* dst = *(u8 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_B:
+		case BPF_LDX | BPF_MEMSX | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 		/* dst = *(u16 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_H:
+		case BPF_LDX | BPF_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		/* dst = *(u32 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_W:
+		case BPF_LDX | BPF_MEMSX | BPF_W:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 		/* dst = *(u64 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_DW:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
@@ -941,7 +947,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * load only if addr is kernel address (see is_kernel_addr()), otherwise
 			 * set dst_reg=0 and move on.
 			 */
-			if (BPF_MODE(code) == BPF_PROBE_MEM) {
+			if (BPF_MODE(code) == BPF_PROBE_MEM || BPF_MODE(code) == BPF_PROBE_MEMSX) {
 				EMIT(PPC_RAW_ADDI(tmp1_reg, src_reg, off));
 				if (IS_ENABLED(CONFIG_PPC_BOOK3E_64))
 					PPC_LI64(tmp2_reg, 0x8000000000000000ul);
@@ -954,30 +960,47 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				 * Check if 'off' is word aligned for BPF_DW, because
 				 * we might generate two instructions.
 				 */
-				if (BPF_SIZE(code) == BPF_DW && (off & 3))
+				if ((BPF_SIZE(code) == BPF_DW ||
+				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_PROBE_MEMSX)) &&
+						(off & 3))
 					PPC_JMP((ctx->idx + 3) * 4);
 				else
 					PPC_JMP((ctx->idx + 2) * 4);
 			}
 
-			switch (size) {
-			case BPF_B:
-				EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
-				break;
-			case BPF_H:
-				EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
-				break;
-			case BPF_W:
-				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
-				break;
-			case BPF_DW:
-				if (off % 4) {
-					EMIT(PPC_RAW_LI(tmp1_reg, off));
-					EMIT(PPC_RAW_LDX(dst_reg, src_reg, tmp1_reg));
-				} else {
-					EMIT(PPC_RAW_LD(dst_reg, src_reg, off));
+			if (BPF_MODE(code) == BPF_MEMSX || BPF_MODE(code) == BPF_PROBE_MEMSX) {
+				switch (size) {
+				case BPF_B:
+					EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+					EMIT(PPC_RAW_EXTSB(dst_reg, dst_reg));
+					break;
+				case BPF_H:
+					EMIT(PPC_RAW_LHA(dst_reg, src_reg, off));
+					break;
+				case BPF_W:
+					EMIT(PPC_RAW_LWA(dst_reg, src_reg, off));
+					break;
+				}
+			} else {
+				switch (size) {
+				case BPF_B:
+					EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+					break;
+				case BPF_H:
+					EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
+					break;
+				case BPF_W:
+					EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
+					break;
+				case BPF_DW:
+					if (off % 4) {
+						EMIT(PPC_RAW_LI(tmp1_reg, off));
+						EMIT(PPC_RAW_LDX(dst_reg, src_reg, tmp1_reg));
+					} else {
+						EMIT(PPC_RAW_LD(dst_reg, src_reg, off));
+					}
+					break;
 				}
-				break;
 			}
 
 			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
-- 
2.45.0


