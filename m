Return-Path: <bpf+bounces-65051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E824EB1B2DD
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F59622378
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14EA2561D9;
	Tue,  5 Aug 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajBeWn2X"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01121D416C
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394957; cv=none; b=dWGHKUkidMI4cMBRTi9xgeCQL23lEqg48htXYxd71fzlUs/X+4EAOzzaYAYX0Awq7jyCFlZMTFhmhCtP2O9Ik970EQfUMnYXHCElpJPI4L3G+hAx+JlkBvyUbl+QqmrNdnOOBs8KiutwxlHpxHjQHFPM5H8TZYRaXSq3mjw1yE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394957; c=relaxed/simple;
	bh=PggTa6WxH0M5vJFOXlrFPWJ8rRrHvm0EqhGTYumCrl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLtNvh92ifwOCaPI1OrqZrn82KyuZ1o/5IgRalXCvy2ThLsJoH41UZGjHcOfhJ8pgTJ2tXjOEvkEK/eh5Wfcdt2sv/WWS1muTT770/L5Z0uf0lC9jOnIbW4w8XJ5bhAgg1ujaiSGXs/wunbLEf7TBGpgMfFJuOgfvYSG/b6+qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajBeWn2X; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754394943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1jlTuuY4q/lESnvYBhHYVkc1gTSHmVy1oGeEx4fpCSM=;
	b=ajBeWn2XwrexaWuIR21f3lKETvQsaivFu7/Bh9NEcLw/K3ibRBIqgnbSx9E0nzxNgiFfQb
	d0tzCir3CcpXoF5Eyh2o2pOBsvNpj9ZyIQIRuaNu8LjJLKxPeyNJAjxSbKbf2IXOAmENPr
	6O/lTfqHD83zpzf3VODLV75nja0rlWs=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mrpre@163.com,
	mannkafai@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for programs with stack size <= 512
Date: Tue,  5 Aug 2025 19:55:13 +0800
Message-ID: <20250805115513.4018532-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

OpenWRT users reported regression on ARMv6 devices after updating to latest
HEAD, where tcpdump filter:

tcpdump -i mon1 \
"not wlan addr3 3c37121a2b3c and not wlan addr2 184ecbca2a3a \
and not wlan addr2 14130b4d3f47 and not wlan addr2 f0f61cf440b7 \
and not wlan addr3 a84b4dedf471 and not wlan addr3 d022be17e1d7 \
and not wlan addr3 5c497967208b and not wlan addr2 706655784d5b"

fails with warning: "Kernel filter failed: No error information"
when using config:
 # CONFIG_BPF_JIT_ALWAYS_ON is not set
 CONFIG_BPF_JIT_DEFAULT_ON=y

The issue arises because commits:
1. "bpf: Fix array bounds error with may_goto" changed default runtime to
   __bpf_prog_ret0_warn when jit_requested = 1
2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error when
   jit_requested = 1 but jit fails

This change restores interpreter fallback capability for BPF programs with
stack size <= 512 bytes when jit fails.

Reported-by: Felix Fietkau <nbd@nbd.name>
Closes: https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name/
Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit fails")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5d1650af899d..2d86bd4b0b97 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2366,8 +2366,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, or interpreter is being used when
-	 * prog->jit_requested is not 0, so warn about it!
+	 * or may_goto may cause stack size > 512 is not working properly,
+	 * so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
@@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 	 * But for non-JITed programs, we don't need bpf_func, so no bounds
 	 * check needed.
 	 */
-	if (!fp->jit_requested &&
-	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+	if (idx < ARRAY_SIZE(interpreters)) {
 		fp->bpf_func = interpreters[idx];
 	} else {
+		WARN_ON_ONCE(!fp->jit_requested);
 		fp->bpf_func = __bpf_prog_ret0_warn;
 	}
 #else
@@ -2505,7 +2505,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = fp->jit_requested;
+	bool jit_needed = false;
 
 	if (fp->bpf_func)
 		goto finalize;
@@ -2515,6 +2515,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 		jit_needed = true;
 
 	bpf_prog_select_func(fp);
+	if (fp->bpf_func == __bpf_prog_ret0_warn)
+		jit_needed = true;
 
 	/* eBPF JITs can rewrite the program in case constant
 	 * blinding is active. However, in case of error during
-- 
2.43.0


