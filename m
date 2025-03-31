Return-Path: <bpf+bounces-54951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E3A7638A
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C91E169422
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB11DE4D8;
	Mon, 31 Mar 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTztKrYn"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2F1DEFE7
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414493; cv=none; b=A36gvoU/jheuD1GpKcfvv1Eglu04aXYlBCQwLdg7tuCtpzdSlmsN6vtM4fK9lk5U7SIgA7VfjJhzoAuUsxbSWV8XlT61hkU3aMMrf6HwufVE0R1Qev1/g2nCIu9R4uUqxFOdEdVhSIybBv38+09YtTuU8ELLko7CO+kvF1kWEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414493; c=relaxed/simple;
	bh=NzhgIP+mGQ4W0FZZ4z+rjwuiSBsl4UldHISVpGjwMLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yxd4PSaDhwSpUkpX/ShOtT6Tp2npeeXcovf9f625UrAQfsJ/fm7y6lVgj7F1X9BYgxV773aHMQZXXE8bf8bjjxKPVa8pXvkcOjaCVByAMdlO2MHT1xZTLUjuBH5iM37wX2Ijr0SzBcV7xaYOrIpErwPThy1+MgOT35HW8inMmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTztKrYn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743414490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyUrTgpXdHKKZlTezNXfLIKziuKXRmHvZa1e0YMWZvE=;
	b=jTztKrYnA8IOCXe3ptnUHJ1vImVoTcF5079lKHCE63wX9O4hF//jQUswhjiz0EdtTqEhYp
	mS0RxpfbmrhkUVOdgcfruYH2SBn62Hh0Ja16nBKVTYgeCc2JcrkKTlW7wE+89EmLF8CEOS
	MA/E/67kP6StiQ1MPt4s4uHvdq5C2mc=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	laoar.shao@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 2/2] bpf: Check link_create parameter for multi_uprobe
Date: Mon, 31 Mar 2025 17:47:45 +0800
Message-Id: <20250331094745.336010-2-chen.dylane@linux.dev>
In-Reply-To: <20250331094745.336010-1-chen.dylane@linux.dev>
References: <20250331094745.336010-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The target_fd and flags in link_create no used in multi_uprobe
, return -EINVAL if they assigned, keep it same as other link
attach apis.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2f206a2a2..f7ebf17e3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
+	if (attr->link_create.target_fd || attr->link_create.flags)
+		return -EINVAL;
+
 	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
-- 
2.43.0


