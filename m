Return-Path: <bpf+bounces-66010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED71B2C466
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394B584FEB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559933CE88;
	Tue, 19 Aug 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkuiJp5P"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4C322C77
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608252; cv=none; b=jqr2fCNr30iiF3vEJcDzrfPXXvpn8daYp4FygMhLRcgtIAO1nUGLI7xSmDyGL5LTCtM3qu7u4N/ID9Q1V/AX3uvDv4+D+ZH8VCpzUwJYhnUT2A+TbdPJt9H85oL2fS+OSTaN6b46TQwRs1KYBnwvLDdtL6eb161xhp4RIC08E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608252; c=relaxed/simple;
	bh=FvU8+HnpnAE+HoIZCFz1dx5R8/F5SQPC+f1V3dtE1I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op6+l8JejO+IWY2hR8Bs+udDaEGbGoGxF6GMr+8pZJbdum8azE/4H+1TK2IgsfBNAVDU2r6FjZkh5hHa8XWgZ57wrMpnoY043lqupyRRmCKf2e42pXB3pclTxasACy8ZgIbtvnx+5CK+rvBEpW9pjMG4Lk76bYHKxTgC9laoO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkuiJp5P; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755608248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XrskpurdbhbEAEqLlf+PaKw7M2joz8cWTLGZUxQsWU8=;
	b=wkuiJp5PGUiA88cc8Sfctvd1ifCNMmkQMlSjJqhreOF7gke72KnZ9W3hWU6TmxO1QbsB4N
	xnEn+z6wXbCrpdvFLOlbdfXqyUPXC2iUAd6o4AEjGBNg2Gkbn3XtU1GcpNly+OT5Ym+wNU
	S3BlOJ/MzhdQ+fbBIqhtK5SvMrm2yMc=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Remove preempt_disable in bpf_try_get_buffers
Date: Tue, 19 Aug 2025 20:56:38 +0800
Message-ID: <20250819125638.2544715-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now BPF program will run with migration disabled, so it is safe
to access this_cpu_inc_return(bpf_bprintf_nest_level).

Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/helpers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a6..182886585d4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -774,11 +774,9 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
-	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
 	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
-		preempt_enable();
 		return -EBUSY;
 	}
 	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
@@ -791,7 +789,6 @@ void bpf_put_buffers(void)
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
 	this_cpu_dec(bpf_bprintf_nest_level);
-	preempt_enable();
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
-- 
2.48.1


