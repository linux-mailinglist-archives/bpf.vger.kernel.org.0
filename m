Return-Path: <bpf+bounces-37785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94195A859
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED8FB213F0
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BD17C7C6;
	Wed, 21 Aug 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rv/n3xTh"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FB17D358
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283312; cv=none; b=oQaDf7RC33Ki0UrLVCJbWca+2Cqn3QPfGqy6l5MIrxEGxVaUSSVyiXNxNzasuRVDRQ801/fgqjNNgncMuMArgAkDsEIcZIZ2nZfAuMLG/Rbwdsnp/07Zsl54j1dKLIXOpjkrkWvodtVlnKOG9tI9X5ENDsfX25ImozJeinTlh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283312; c=relaxed/simple;
	bh=KpvxCmkErqZkpkFlZxuOiD0H1zQQRjiBPevc5uSnYMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6DkivVM6ut7HmMohUdYOJqhkP9/xIVSU1vFpkGXJfmBidQiH3il4kMl7w+LgYk21c8eCCzkCXZSQ6f2UZPymgeXsfYpybPsToqoDd/5qj3RKgm996j5vBQi9M13taSWiJM1UU18tvMI31yIKd1Ou8khQnUusn3L72DDGFfxVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rv/n3xTh; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3pWwo32CSd/xdzbwlEKqQlxQioQvtTwJzQQijNHuxo=;
	b=rv/n3xTh+FfqfVwRgZhDC5J/Cy3JnLVmz2CXOKyp5rweKfCPAdrVW3mB7lZ4i57eRkB9QA
	n/pufP3a06gUyfSPMNCQH2SeIa5iT1Hi0NYJbLr6dk9vlX4IQ4ZNLcwbRkzEoe1POc3wxg
	l/j2pxCknOa1ZdUXRYVwehHD6rGDBHw=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/8] bpf: Export bpf_base_func_proto
Date: Wed, 21 Aug 2024 16:34:32 -0700
Message-ID: <20240821233440.1855263-3-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-1-martin.lau@linux.dev>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
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
index 12e3aa40b180..84c2034a2f53 100644
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


