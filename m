Return-Path: <bpf+bounces-29209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2C8C1453
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CCAB20EAC
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB41770E9;
	Thu,  9 May 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m15JRa+y"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09F17BA9
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277039; cv=none; b=O7anZcWLu7lpQRCB+LllKJg90aUUHC/0F6+u4wtNSGyjIUUs333DPDPOIk34dQrYNJ01XpQIou0PP5ofndU+qslyxkWjM5Lse+k1hCePLP3HGezcakUZGM5Dzrg95aL/GSrBveTj8flbneYyhaE/Xf/lsJJA9U80pL8GZR5B0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277039; c=relaxed/simple;
	bh=wuKuqtk8SS9NStD0qviDihoXsLyRUQV7I4DWMlymT2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9yxjyc1dKB02SSyrCNhkyzPQWmUTRoAZvy4mODTVcQYhU7ERFB46bXsqEQcFEjvFEdPEwROO+3wXnR2ld3B4+YNbs/HzZlE1UwF7CyCYWKBXzE6vZ6lMx6V2FdtuGVdp4tq8nJmcz5myHyl62KJ0G58hb7L7Rf5fmInPD1OKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m15JRa+y; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715277036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNqAOZmN5SI14IjwNGHaM/DmAUgv6zT91E1LOLIGF24=;
	b=m15JRa+ypSQ5X/I54N65j0NUnnSOpnTA9JFZCVdDWlpVom0ACvWs98BBGboPnkPLssy4jW
	QhxYmkOjMrMdH4V81zxbk6v8Q1InDhE5Sr5SBm/m9YeIbT3ijIyKATTKhDtnK/DV1tmBbI
	Q6rIZjWNzQfpHy1pdmVF9/GmPhkATkY=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 01/10] selftests/bpf: Remove bpf_tracing_net.h usages from two networking tests
Date: Thu,  9 May 2024 10:50:17 -0700
Message-ID: <20240509175026.3423614-2-martin.lau@linux.dev>
In-Reply-To: <20240509175026.3423614-1-martin.lau@linux.dev>
References: <20240509175026.3423614-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removes the bpf_tracing_net.h usage from the networking tests,
fib_lookup and test_lwt_redirect. Instead of using the (copied) macro
TC_ACT_SHOT and ETH_HLEN from bpf_tracing_net.h, they can directly
use the ones defined in the network header files under linux/.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/progs/fib_lookup.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_lwt_redirect.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/fib_lookup.c b/tools/testing/selftests/bpf/progs/fib_lookup.c
index c4514dd58c62..7b5dd2214ff4 100644
--- a/tools/testing/selftests/bpf/progs/fib_lookup.c
+++ b/tools/testing/selftests/bpf/progs/fib_lookup.c
@@ -3,8 +3,8 @@
 
 #include <linux/types.h>
 #include <linux/bpf.h>
+#include <linux/pkt_cls.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tracing_net.h"
 
 struct bpf_fib_lookup fib_params = {};
 int fib_lookup_ret = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
index 8c895122f293..83439b87b766 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
@@ -3,7 +3,7 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/ip.h>
-#include "bpf_tracing_net.h"
+#include <linux/if_ether.h>
 
 /* We don't care about whether the packet can be received by network stack.
  * Just care if the packet is sent to the correct device at correct direction
-- 
2.43.0


