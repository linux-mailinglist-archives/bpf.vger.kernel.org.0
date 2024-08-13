Return-Path: <bpf+bounces-37074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E507950C86
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140B31F230D7
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6B1A4F1B;
	Tue, 13 Aug 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWNP/AhQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D81A4F02
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575002; cv=none; b=kAgv2Un9vD74MrxNRcgpxrlTKEaeVGSseVceFjdGSrfwt519K7f3t/T6ACiJNpmFx2C17W+TuKr7xpiVTPi2mU1LCqXvFaWGXGJKcE5aKka9s+8TUcLg8vQo+Jb/KB6bxdL25hrJsNK2Bgv+w7/csdVXudpsfXDMXPLDs/MLg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575002; c=relaxed/simple;
	bh=Tp5JrxpYW8SID0V4QRxd2sfc0j9BTY5Hf1PEptZhhtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUcEnEIaRLFurVArZsBpLxfj9RNJWKNdo1PrR4J7CSD+JR6MFHt8mFnapT2zaJnZWePmp8JM5D+qX5+NkeL9rwvHfv+vNB1Dxlr85Oo7Mc5tDjh7rFzuUW1TqPNxYUEAb+J0SwqpJDK0TGSkNUmDDsQL9SJo/LNY5F4KlCz6sBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWNP/AhQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723574999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIWJaA/rr7z3c0SNNY8RBM7QoiU+VLBlKjZVwreXHcc=;
	b=JWNP/AhQWB6T3SbpgAKKRG+G+rpueqKJu655+7r7Ya+ghnn7Znybe6xteih6h9mgLDhmnM
	zh8+pKaeyW7sqgKDx7wi3nag10zgbcmJFkj2yfURLpbyKog07CeBU5jI3aEdNFZFGz92M0
	K/lSrrgVPXvPSDln4/CpVE96lqys+Kc=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next 2/6] bpf: Export bpf_base_func_proto
Date: Tue, 13 Aug 2024 11:49:35 -0700
Message-ID: <20240813184943.3759630-3-martin.lau@linux.dev>
In-Reply-To: <20240813184943.3759630-1-martin.lau@linux.dev>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_testmod needs to use the bpf_tail_call helper in
the next selftest patch. This patch is to EXPORT_GPL_SYMBOL
the bpf_base_func_proto.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..544f7d171fe6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2034,6 +2034,7 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
-- 
2.43.5


