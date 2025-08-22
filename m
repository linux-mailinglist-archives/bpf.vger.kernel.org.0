Return-Path: <bpf+bounces-66280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2DB31B50
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335826234AC
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FA2FE58E;
	Fri, 22 Aug 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U+nGpRn0"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F143305E33
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872287; cv=none; b=HiDXN3BH1n2htIXzmmdAUbHOdBksvz5MbrxsV3Kc/1A+rgC5pgqsXFn61GpMsw73V6dXAOEJAyRvjCOZWtuLsU4ACVz5wpAYk2jHczmAb3VvaLZRKj3PfsAXahTFNDZdU61WF2EpFvUIH5FpuNT/sg+pfRW8is1uJZrRVZM8OLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872287; c=relaxed/simple;
	bh=yNJ8nzzSD8lQpxxi1a9wIDly578kF/XGGP+AZzy3glY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn+Ib61qlaaKBWOVU5Os7V5Vd2auIF3e3UO/dbP4jrXhl1xccYJYIs3WkZAz3FZokP73sDM1YF+pyZZ5e95YO+JFm4M7MgxCWbMR81IPEmBegmPqXkp0o0EXaAGRKZnx3Z0goHMChsM6K3fyRlSqBlH6y3C5cXTGVNUKyJGolGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U+nGpRn0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755872282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwmTM1PbDQhAjmWrZJwYLyWQa/PmeXkFO832FSSkEKg=;
	b=U+nGpRn0PCqKbJqWVgSC01ZgiVQOYumgOZNadeXVn+v/iCwg11qTIlyTDQEHRuR/pRlf8V
	vmr0XLaa7aUvyu0VAgPL5zXggImaL3avgT4U+L7gsMSYu+LbkMSQKPt8A0kW9Lx1+LtSJV
	8d6ZEDa42ITgsZUVkRiQ75llOa4cZUE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add case to test bpf_in_interrupt kfunc
Date: Fri, 22 Aug 2025 22:17:21 +0800
Message-ID: <20250822141722.25318-3-leon.hwang@linux.dev>
In-Reply-To: <20250822141722.25318-1-leon.hwang@linux.dev>
References: <20250822141722.25318-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

 cd tools/testing/selftests/bpf
 ./test_progs -t irq
 #143/29  irq/in_interrupt:OK
 #143     irq:OK
 Summary: 1/34 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/progs/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 74d912b22de90..65a796fd1d615 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -563,4 +563,11 @@ int irq_wrong_kfunc_class_2(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__success
+int in_interrupt(struct __sk_buff *ctx)
+{
+	return bpf_in_interrupt();
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.50.1


