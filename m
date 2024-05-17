Return-Path: <bpf+bounces-29922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D38C81EA
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EE91F2101D
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC823AC25;
	Fri, 17 May 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W49hEC+m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387937149
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932632; cv=none; b=ZHrsQdMXYBOykQ7b9iQCF1nfWkYsg/nd7EZzug4+iCDK247yCXS7uCduad+IJ/Vj/WNz5ekntxvnuCMhi24fbRxLthoxx1xiOrEv5rY7TYAWM5lpKvTnbhDfLWHTHAxQsQ1XLJARAU8GmYm2ozhpEvilJkdtS9wK6N9KoyxIfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932632; c=relaxed/simple;
	bh=z3AwgBqlBUWCWye022RyFCz2f5ylMRfnUjZq4yLjspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU3LvusgiB+y5TMR365D4Xm51aciauwDDKgfeNQAum49W1skbvyo9JY2/4gIVp0E2ShuAxjxa024GSL+9VrRDWlLQzJOJisFiRbWaqHx03ZTz3x8KCf7LVeJ0rMuU1k8MkArSoquA96ogAfHBizx3X7rOLTKQ/QlqvJ8+AtfuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W49hEC+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsCKnSd8SY21HTUjj+hbf4r5AF/uUdXnBR6lfnTM7uI=;
	b=W49hEC+mDultynAMoGV0hlUTXaCBRBFvXbI7v11BevS8jfjrt8QaG/b62q7sNE6PxSbzB6
	tuEThDsI3ude0C+MPQS5vCKu7b8Wdx5kJGuKgFjHC5rvysS2cnnA8JPmw0dKBJPChI9qV6
	gk20zg3CRBOKPyVtf1/XXRPas++lSWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-vWFqYgpbOEGkJTvFzMf7zg-1; Fri,
 17 May 2024 03:57:05 -0400
X-MC-Unique: vWFqYgpbOEGkJTvFzMf7zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 765E529AA3AC;
	Fri, 17 May 2024 07:57:04 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD402740F;
	Fri, 17 May 2024 07:57:02 +0000 (UTC)
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
Subject: [PATCH 4/5] powerpc64/bpf: jit support for sign extended mov
Date: Fri, 17 May 2024 09:56:49 +0200
Message-ID: <20240517075650.248801-5-asavkov@redhat.com>
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

Add jit support for sign extended mov. Tested using test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index b9f47398b311d..811775cfd3a1b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -676,8 +676,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				/* special mov32 for zext */
 				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
 				break;
-			}
-			EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			} else if (off == 8) {
+				EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
+			} else if (off == 16) {
+				EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
+			} else if (off == 32) {
+				EMIT(PPC_RAW_EXTSW(dst_reg, src_reg));
+			} else if (dst_reg != src_reg)
+				EMIT(PPC_RAW_MR(dst_reg, src_reg));
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
 		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
-- 
2.45.0


