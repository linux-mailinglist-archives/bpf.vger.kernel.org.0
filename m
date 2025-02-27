Return-Path: <bpf+bounces-52795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890CA488C6
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16F83A8560
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8431274241;
	Thu, 27 Feb 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyD4phbC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5824D26FA43;
	Thu, 27 Feb 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683545; cv=none; b=BiXvzq3HXzgGWtjgPpiZlUvxCkhFL2X/2bxRszMthnOVzVsbqa8JgHVViyaOxCtrMk7ZAXMNopfdnIXG2JTOhBaZBlCzuTp/v0FO0+6Wa7OCEuYCXVLpXsxnkbps+9mzFVNI4skYN7fazkPDsDmzzqBez2F6I9GyJ40aeoNDVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683545; c=relaxed/simple;
	bh=XNv1JeMEygO+u0rfyIvYtfLNF9wa0OuxFFuJmv+IbKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH09YBA0GNaJ8L/INr12Bw4VnWxy2CFqGVoL2xvL553LCqzUoLuQas63YqApwD6vSTu17E2r4uDtqCSa/DhUJmRk0ZBruVB1AFjrGhtI/pkxFe98AKs5bk8LqsXTFGH4hcLD6cIwfVgimm4fV2ZsXAo6inh9BzOv/SQcjiLB7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyD4phbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EDCC4CEE4;
	Thu, 27 Feb 2025 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683545;
	bh=XNv1JeMEygO+u0rfyIvYtfLNF9wa0OuxFFuJmv+IbKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyD4phbCJbtes5DUJhY0DJqXoTH0IfUB1La3ZQsTpoDrOvCZ14GI1aj9NbXxlFqag
	 LVOoPqf9PKdxhxBwr6cbf8w6M9PRFwVcrToOdPgBp9B4YDoYaOjOqvQVVntiwH00F/
	 HDtKI326SVS+qOFRt2rZ0+Kq5ti3Y5B7G7Mee4EZNm2IkxRXSzN70ZEMngYFEPpFLT
	 nTMiPBqhaUUppYHLePiRWAoY5GXAEY+ry5OYn1qYk98oUx7ZiNrsWI/KA3IVSuznLK
	 PGwvKxbGj3xU1tx9YBjZOw8KXkEzrqwakHezZctEt04qOxjiN+3+7KMfFwRIZQ4m8J
	 Jo9I5eIw+bWDQ==
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
Subject: [PATCH 2/3] perf ftrace: Remove an unnecessary condition check in BPF
Date: Thu, 27 Feb 2025 11:12:22 -0800
Message-ID: <20250227191223.1288473-2-namhyung@kernel.org>
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

The bucket_num is set based on the {max,min}_latency already in
cmd_ftrace(), so no need to check it again in BPF.  Also I found
that it didn't pass the max_latency to BPF. :)

No functional changes intended.

Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/func_latency.bpf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 3d3d9f427c20876e..ad70547446786c54 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -125,8 +125,7 @@ int BPF_PROG(func_end)
 			// than the min latency desired.
 			if (val > 0) { // 1st entry: [ 1 unit .. bucket_range units )
 				key = val / bucket_range + 1;
-				if (key >= bucket_num ||
-					val >= max_latency - min_latency)
+				if (key >= bucket_num)
 					key = bucket_num - 1;
 			}
 
-- 
2.48.1.711.g2feabab25a-goog


