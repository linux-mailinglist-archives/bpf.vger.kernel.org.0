Return-Path: <bpf+bounces-38198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B572D96182D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A32852FD
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2A1D31A8;
	Tue, 27 Aug 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cO8q9NkU"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088C1D2F53
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788148; cv=none; b=V92JiZfg3u3jaNh9Y90abL2j/OvSCjXJ37pw2F4tOTf8OvFRlzmKFOLhqlzPMrAJaq7p/u+zXRRo2ilodISphjQhpSiW3uE2/21F9bJys89bavOSqIwKnChDqLmtF24q1eUpLzz33AATn7r0RQa9vuF/AcA6nz7nhFr3+WjXhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788148; c=relaxed/simple;
	bh=TGLozP1T8y9Syv46OWMDS3t1f/QdzTBqDQJB23S5jMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyDiUH3Dt33SdHxwNmDN12cSProA10e9959FdR01/tOT1wVoKvM0afXiQY1kdDLAmNzhix+r9PlKLF1WIluSbasGIoP0K9dJ1Rno6PJdhJ1Bp9ruD4t+3MACyYqEgcY0RCwU/rkZKV2frcV1ag8JIj0qZVxNTn9b/LBT54fWdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cO8q9NkU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724788143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7C2VtnQMppUsC7qptuP0MiQLIPaakPSFnQH53irf9Y=;
	b=cO8q9NkUFXdYsdRHNPWDPR1SUXJuFsLGTxEOrjpvaia+EXsDPxvbFBPdnymvxztYxnrJZO
	7jwsbg8sDHV6y/CBa1P7RjBeRGnq3+KrGy5MEfhoSiXOQM5MTMrQj8395ruhXHBjQpjste
	FKUDH3Uuq4U61l8ruwQf5rI9kBXWRsw=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v4 bpf-next 4/9] bpf: Export bpf_base_func_proto
Date: Tue, 27 Aug 2024 12:48:27 -0700
Message-ID: <20240827194834.1423815-5-martin.lau@linux.dev>
In-Reply-To: <20240827194834.1423815-1-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
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


