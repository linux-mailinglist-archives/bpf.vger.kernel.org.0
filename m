Return-Path: <bpf+bounces-66387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57255B34078
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B4F5E034B
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AED26A08A;
	Mon, 25 Aug 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JV/X2XBr"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC01A314D
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127750; cv=none; b=CRjCGanMsGZlHwF4+bD3ntBea6Lbn6ThXTuVVTVhqT24lKuUyHpkqjJk6lQJJhLuOQM5/QtSI/eVjtI7O7RaZ7jWoxq2xbwXJM9EtE75ICx8XFJiX3wPqnKI9ipyJmtDEXSzBMb5ejFBYIlxeHwf/ofIdFMi/Dxy0HTlU/GQB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127750; c=relaxed/simple;
	bh=yNJ8nzzSD8lQpxxi1a9wIDly578kF/XGGP+AZzy3glY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDUpU9Rzu+47ZwsZ2u1TzW3aGtKYaKZEnJcO6ZUafBupjBMFV/2l831KzFX+6Mh0NOLEH2Y8CapLgiHIELIox7pwdq2xeiF0j6nYgRaxYdXdN3El2TgLvcGlHDeh6uIgASS2dOsRT7Sr/jHSBEYJw3kdFGPKZIeE/FLbaIX0Fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JV/X2XBr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756127746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwmTM1PbDQhAjmWrZJwYLyWQa/PmeXkFO832FSSkEKg=;
	b=JV/X2XBrFqVErnvfAB4E1ZBwPoGPLtvVVqCc7uDgG/toDm87kUOJf58gixU/ONEijO4MrP
	cwKWTZhP8mfEjTYUXuFUJSIu9C2AUWlVkHXICmnA1f1TfX3V5NT/23erGry7MSMECpK8p9
	V4Kut8x+itba6QwYkYDoL8IbCw5/hyI=
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add case to test bpf_in_interrupt kfunc
Date: Mon, 25 Aug 2025 21:15:01 +0800
Message-ID: <20250825131502.54269-3-leon.hwang@linux.dev>
In-Reply-To: <20250825131502.54269-1-leon.hwang@linux.dev>
References: <20250825131502.54269-1-leon.hwang@linux.dev>
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


