Return-Path: <bpf+bounces-29917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3FD8C81DE
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4B1F21478
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312828DDA;
	Fri, 17 May 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVAjOPT0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C181AAA5
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932627; cv=none; b=r1lD3010FxjiIVaEXlZwdL52geauslnmCNvJ3A7O3zcVYn3gPR1KKmiyHLccAbBDc8lad0Elqe3yOeKSbMyQVbsgxaT75qhOx9Tsg8imxE49saWNABWA/SFHsl3GrUwEkgWzSMBJ3upju1nWS3DiiGY+uRLMwwnvBgas8GTgVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932627; c=relaxed/simple;
	bh=0Zhpfwr2bblfm7k3g5cvVUI3dQpNdm2TqtvTSVzfgYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhYE6Kfy09ngUjB8G7DClcExN9my4gUjWb2cCN8aPw6hiaE2ByZrTGNW3Yut4eXzN3CgQoOXlyCspmpz/EJilYYESrdzZ3B+o8zGcdmxw1m6Z3NzyV+ExNUStxoiSQTRlEJfCaawhh8ws0pMbBelXVKfGTTkQt0yziGIBuRBe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVAjOPT0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CsmDbbLDOx1vnhJg69VuCy0uaob3Dg5hNF61pmV/Vg=;
	b=JVAjOPT08W1HIekJDx0EewE6euPdT7iAlrNNfBBrwuZVl1TBnOl5yFE1nw/YWOfNRGKT2B
	90INl4S7HYfYinlmMMkm6xKss1iqBmRjaUkqUqgBaf5yzaytLtFMqL0Nn7jyDPLiKMVutd
	1LZf3wYI3g5rr608ib4C2Swzs2gLo18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-HFKoaS62NtCAXc51ApmXvA-1; Fri, 17 May 2024 03:57:01 -0400
X-MC-Unique: HFKoaS62NtCAXc51ApmXvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAEC5802079;
	Fri, 17 May 2024 07:57:00 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E28F740F;
	Fri, 17 May 2024 07:56:59 +0000 (UTC)
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
Subject: [PATCH 2/5] powerpc64/bpf: jit support for unconditional byte swap
Date: Fri, 17 May 2024 09:56:47 +0200
Message-ID: <20240517075650.248801-3-asavkov@redhat.com>
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

Add jit support for unconditional byte swap. Tested using BSWAP tests
from test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 3071205782b15..97191cf091bbf 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -699,11 +699,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 */
 		case BPF_ALU | BPF_END | BPF_FROM_LE:
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 #ifdef __BIG_ENDIAN__
 			if (BPF_SRC(code) == BPF_FROM_BE)
 				goto emit_clear;
 #else /* !__BIG_ENDIAN__ */
-			if (BPF_SRC(code) == BPF_FROM_LE)
+			if (BPF_CLASS(code) == BPF_ALU && BPF_SRC(code) == BPF_FROM_LE)
 				goto emit_clear;
 #endif
 			switch (imm) {
-- 
2.45.0


