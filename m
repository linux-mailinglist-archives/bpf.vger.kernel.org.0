Return-Path: <bpf+bounces-65095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C08B1BDAB
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 02:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BDA18A66AF
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980423C1F;
	Wed,  6 Aug 2025 00:03:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8D36B;
	Wed,  6 Aug 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438609; cv=none; b=IeOa0sN0KFsLOOLxJ0S62BMvTZBqZbqqP+HVI/o807RJzQy5IT8kHsiACvYsfSGClzSdZBDku3JuKKxRN9qNkDop9/7Lnz85RD/nytywks06nNiSWmKNYgG2+1aMDHJWh6AheJYB2Cf2rDwRfn4WzyL6ICQeVMUS5iEhERjN0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438609; c=relaxed/simple;
	bh=LMWsAMqznkxjuzCZXSV6yTT0L9mx/2Ia2i/1IF+r/js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxulRKkUG9tAAKlaExbBk2dYO+pq9hrOYOJjlswHkNh/g063dJ8fz3kD07eNpXQt6Ekb1EnkP/u63bazK/2wQUPJTWSK4OzK1DZKxjr+Dv+mwI+3lAMKezRputD+6zqknBDtT2SUvAjOXoCEZe26OQkxvYQl+jMK1U9nJDn6wL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2E682335D8D;
	Wed, 06 Aug 2025 00:03:24 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Sam James <sam@gentoo.org>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] perf: use __builtin_preserve_field_info for GCC compatibility
Date: Wed,  6 Aug 2025 01:03:01 +0100
Message-ID: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exploring building bpf_skel with GCC's BPF support, there was a
buid failure because of bpf_core_field_exists vs the mem_hops bitfield:
```
 In file included from util/bpf_skel/sample_filter.bpf.c:6:
util/bpf_skel/sample_filter.bpf.c: In function 'perf_get_sample':
tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42: error: cannot take address of bit-field 'mem_hops'
  169 | #define ___bpf_field_ref1(field)        (&(field))
      |                                          ^
tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29: note: in expansion of macro '___bpf_field_ref1'
  222 | #define ___bpf_concat(a, b) a ## b
      |                             ^
tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29: note: in expansion of macro '___bpf_concat'
  225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
      |                             ^~~~~~~~~~~~~
tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9: note: in expansion of macro '___bpf_apply'
  173 |         ___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
      |         ^~~~~~~~~~~~
tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39: note: in expansion of macro '___bpf_field_ref'
  188 |         __builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_EXISTS)
      |                                       ^~~~~~~~~~~~~~~~
util/bpf_skel/sample_filter.bpf.c:167:29: note: in expansion of macro 'bpf_core_field_exists'
  167 |                         if (bpf_core_field_exists(data->mem_hops))
      |                             ^~~~~~~~~~~~~~~~~~~~~
cc1: error: argument is not a field access
```

___bpf_field_ref1 was adapted for GCC in 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
but the trick added for compatibility in 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
isn't compatible with that as an address is used as an argument.

Workaround this by calling __builtin_preserve_field_info directly as the
bpf_core_field_exists macro does, but without the ___bpf_field_ref use.

Link: https://gcc.gnu.org/PR121420
Co-authored-by: Andrew Pinski <quic_apinski@quicinc.com>
Signed-off-by: Sam James <sam@gentoo.org>
---
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index b195e6efeb8be..e5666d4c17228 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -164,7 +164,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		if (entry->part == 8) {
 			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
 
-			if (bpf_core_field_exists(data->mem_hops))
+			if (__builtin_preserve_field_info(data->mem_hops, BPF_FIELD_EXISTS))
 				return data->mem_hops;
 
 			return 0;
-- 
2.50.1


