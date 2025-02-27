Return-Path: <bpf+bounces-52796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA049A488C8
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4073166DBE
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F48274256;
	Thu, 27 Feb 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2tzLwHh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F3272936;
	Thu, 27 Feb 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683545; cv=none; b=W+HU+IqTu0zopFlSXvepGHISlru89qMBH5i16kJ1aj1aCLCelj+Kor4Gt/2SdFmSogPYwZJL1f3MP3dVWx5krXmQ2CR5ZYlHTS7/9JuQ4dZqBLx3p+EjFClabTLZHXoHlIvRvuOFDhz4gESmiqyFrh3LbHEdzk6gGp6+cykrrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683545; c=relaxed/simple;
	bh=yWNJrJRwano97v863X32STby/iPM1XeqFx3OW2jGIL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecaHZvcWMOO1Cknp/g6E58H8xqm365BjakE5sMxVPZUtIaScXdHa5iaboJ4ZPVHHzXN8/sTjTPlBO39oSlOehFKZKa4X8DAfdQZvz8ThBDjIhSMsqXM71Dpfx8dy5W8Z8tXPo+LbgHMjcjrxbEAhRFFLCV1t868lGPAex+Fv7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2tzLwHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6E9C4CEE5;
	Thu, 27 Feb 2025 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683545;
	bh=yWNJrJRwano97v863X32STby/iPM1XeqFx3OW2jGIL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2tzLwHh4pcwBWRaKRvSwbyl700FuA8J/pe8vsq59ZqrCCVMVaDfTIQOSmuPAE47G
	 WXDK0M1m8lHNw3kBoAnyuFfBXVE99UwdvNzqH7mG59cAWwtSb/spiJZ7PvBIba8u74
	 4IwLo286NQ8qt1waaF2jNxEZYxs8hFKP6PYvRd87F/BX4G/EDfisk/eYue4tmydefH
	 GEsXV8TcVrxyTv/iT3YEGM9G3cZBXN6zWNRcAsqCFPQgpVfwiQ5XWskEVCXlTSPApo
	 VlenIIvT71rMfFY73400x68gBcCaJKl19R1neowSRkPxSLmlprcin2UNGgdWftvkRa
	 qba62OP55K5dw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 3/3] perf ftrace: Use atomic inc to update histogram in BPF
Date: Thu, 27 Feb 2025 11:12:23 -0800
Message-ID: <20250227191223.1288473-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250227191223.1288473-1-namhyung@kernel.org>
References: <20250227191223.1288473-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It should use an atomic instruction to update even if the histogram is
keyed by delta as it's also used for stats.

Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/func_latency.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index ad70547446786c54..e731a79a753a4d2d 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -142,7 +142,7 @@ int BPF_PROG(func_end)
 		if (!hist)
 			return 0;
 
-		*hist += 1;
+		__sync_fetch_and_add(hist, 1);
 
 		__sync_fetch_and_add(&total, delta); // always in nsec
 		__sync_fetch_and_add(&count, 1);
-- 
2.48.1.711.g2feabab25a-goog


