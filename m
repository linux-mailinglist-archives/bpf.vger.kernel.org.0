Return-Path: <bpf+bounces-41906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC599DAD8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70AB28303A
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CF4B5C1;
	Tue, 15 Oct 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fm7eB3sE"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB341C79
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953438; cv=none; b=fA7IY5uJKMJ0dCNkFWQak/tOgLMKficRy3JNIa0D/ah4K2iXh/KfztRIZE1CAD5N5r8WG4m4HB4aNwoAI1DAgykzfp9/VdKrxb3RLZDDDC6Q3enIfkjJ7nASckbD6s9hTdWgR8023cYaX270DPF0EiRUNwWKnOQ9ak8PWTv+nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953438; c=relaxed/simple;
	bh=7HDICpPHsebJv3BzIzIi1/AHx2X/2Qv1uWN4chBGU+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THBZteljPqeBBhGqpMjLtEGAAFej7kR2ksPw7D9rEWFs3483dbbPypjqC9mpRXIDdBfB39X9XlcomyophlnIvpdzYdYCxGqhN0XixafrvnXt1H2HGQMv6/Sz8PmNCsPrgDPHe3L6BtIBgqOSpEtifO4pxJQxVCFTJibCN1Z+H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fm7eB3sE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC3+xARsUKd/viABjpsb1scja9lwPh9MOMLQdWqqcS0=;
	b=fm7eB3sELlNZoy+t90YpMz9SFWdY/8AxwXHmrCnYF3ZV/kjVPqGEKsxVAHBgMHAOG3W5q6
	uNdab7pyQGL4DNUS0i9d6PaeZLnCGEZR920ggFkAZn3vu/lQ8W9haDSRQbRWeC+uf1phs8
	X9uKIW8LDyIhIIzBWoiFyeNOg0nf2EM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 07/12] libbpf: define __uptr.
Date: Mon, 14 Oct 2024 17:49:57 -0700
Message-ID: <20241015005008.767267-8-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kui-Feng Lee <thinker.li@gmail.com>

Make __uptr available to BPF programs to enable them to define uptrs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80bc0242e8dc..686824b8b413 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -185,6 +185,7 @@ enum libbpf_tristate {
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
+#define __uptr __attribute__((btf_type_tag("uptr")))
 
 #if defined (__clang__)
 #define bpf_ksym_exists(sym) ({						\
-- 
2.43.5


