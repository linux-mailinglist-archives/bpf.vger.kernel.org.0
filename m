Return-Path: <bpf+bounces-38475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71696517F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4774E1F2300C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B418CBE1;
	Thu, 29 Aug 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMLZb4EC"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB418A958
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965750; cv=none; b=sxiSXEZaLXUm/HfiRN2rzJhMoF8xoKfriibRYUSoEuWeP0Zef42WSKWQ8b0dIEu1MgRxDrEnBIpRasIVNvrX0sBVc30kVGpYXOTsowL1vLwyFxwBhlZDtWriOJY8ecoMECwBxrCbxI4O6YxhzsR2PWCZR7lTqXYPTIc90LRNFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965750; c=relaxed/simple;
	bh=TGLozP1T8y9Syv46OWMDS3t1f/QdzTBqDQJB23S5jMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAMyc+Bd+tBo2bzPKnVsHP2oB98s5telryYcADm/meUhb909OIFB6xc2yBCqufNMF17uFiWqEFUqDNadRkEvjhqDZHBQ3EzlSc9zSW7WRqGVBnwzKMbAcbFPKO5y9HNlG7dMkVcAq7gst0xw/Sc/OLBOtYvMDSOiI/l+bn/aBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMLZb4EC; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7C2VtnQMppUsC7qptuP0MiQLIPaakPSFnQH53irf9Y=;
	b=OMLZb4ECLQ2cMHfpuCpwA9EjIoeQiE+b7hVFNxr2tu9z/l5pgzn2xFLy/dK73/eJ9RqQqO
	8lHYoqOcRb0z2WmF0an8+Xv/heIEvPwvXHBHCU3TRUTKJVn9bPp80oImniNbKcKstJpbzE
	vD1QVKZzkqzkATboGJEu0QCdnFc30uI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 4/9] bpf: Export bpf_base_func_proto
Date: Thu, 29 Aug 2024 14:08:26 -0700
Message-ID: <20240829210833.388152-5-martin.lau@linux.dev>
In-Reply-To: <20240829210833.388152-1-martin.lau@linux.dev>
References: <20240829210833.388152-1-martin.lau@linux.dev>
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
a later selftest patch. This patch is to EXPORT_GPL_SYMBOL
the bpf_base_func_proto.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7e7761c537f8..3956be5d6440 100644
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


