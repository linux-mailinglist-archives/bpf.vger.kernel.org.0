Return-Path: <bpf+bounces-32212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D09095BA
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C3C28357E
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 02:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94815CA6F;
	Sat, 15 Jun 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="dlHYQq2e"
X-Original-To: bpf@vger.kernel.org
Received: from mail52.out.titan.email (mail52.out.titan.email [209.209.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41592907
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419756; cv=none; b=DU5pM56vEm9f5ztnO/0+Y7cSX2i9p4TL6pJc1AO6JWUj941PQHE3JYWzfm9m5aBVhB+brBA5l12c1MnB7lCcAeLOgmoL+BGcSYcCPhDib3drsbc4Mh6dEszNvLoWPgu5Uu9chkgcIHFHCtDNcljvbGtCbaVLdQEn8EoZPioMDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419756; c=relaxed/simple;
	bh=Nowwrm7YYGZQB/wslBwAOshDqT2fPt36KDckIMemIKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4ahequi+UU4eER31/C53auN5NJBfhBqSSUEANSg+qVNNTvlIAuPxQNcW0oHKhR5dKMUPUPWRs1CbLEQi9JIdbbka/61p2vv0hWUU12h24sOx0jSUNJ+g3sBl4bx7ym8ArQQTxblSLIadw8BOEMZdJDeMTI6+O2K0PXCahMFbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=fail smtp.mailfrom=rcpassos.me; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=dlHYQq2e; arc=none smtp.client-ip=209.209.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rcpassos.me
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 3D2E0E008E;
	Sat, 15 Jun 2024 02:31:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=bvoD1xXUVp/wUtcoK6nxcw08qYW6ORI2TW5d4HCm9+A=;
	c=relaxed/relaxed; d=rcpassos.me;
	h=to:cc:subject:date:mime-version:from:message-id:in-reply-to:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1718418690; v=1;
	b=dlHYQq2eA60KFCWcGwEWTdiBqXvlg4MQ3xh8ogIpAviCXWje1HO4SgBp+AMt1H/o2mixfI+o
	8qJHfrIMChmg62q2X9OlpGNRKS4o308wvZWMjGPa/WziEEc2ufvPkwI1O2ubBroRBwC5KP1iIYR
	Lp6MhM2PBNRKOU8s5VmIl1ig=
Received: from darkforce.pihole.rcpassos.me (unknown [104.28.243.51])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 36B47E0047;
	Sat, 15 Jun 2024 02:31:29 +0000 (UTC)
Feedback-ID: :rafael@rcpassos.me:rcpassos.me:flockmailId
From: Rafael Passos <rafael@rcpassos.me>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next V2 3/3] bpf: remove redeclaration of new_n in bpf_verifier_vlog
Date: Fri, 14 Jun 2024 23:24:10 -0300
Message-ID: <20240615022641.210320-4-rafael@rcpassos.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615022641.210320-1-rafael@rcpassos.me>
References: <20240615022641.210320-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1718418690115887987.31293.5266191172157278976@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=W6Y+VwWk c=1 sm=1 tr=0 ts=666cfd02
	a=rO3HKV82O4ipXYUjDYeURw==:117 a=rO3HKV82O4ipXYUjDYeURw==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=yI5TgzhYSYgGwSC-jVgA:9 a=---8k2CCGq07aBBJLGWX:22
X-Virus-Scanned: ClamAV using ClamSMTP

This new_n is defined in the start of this function.
Its value is overwritten by `new_n = min(n, log->len_total);`
a couple lines before my change,
rendering the shadow declaration unnecessary.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 kernel/bpf/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4bd8f17a9f24..10b2ed6995eb 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -91,7 +91,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 			goto fail;
 	} else {
 		u64 new_end, new_start;
-		u32 buf_start, buf_end, new_n;
+		u32 buf_start, buf_end;
 
 		new_end = log->end_pos + n;
 		if (new_end - log->start_pos >= log->len_total)
-- 
2.45.2


