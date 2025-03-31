Return-Path: <bpf+bounces-54950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D331A76389
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F9F3A88F2
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F931DE892;
	Mon, 31 Mar 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lCdrsYKV"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AE1D63EF
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414489; cv=none; b=tVYmT9so8+9xCKIAXI/3sj3NnryCtekpoUeDQYaLzmzuEjRVcNSrFbdmi4LcdWYeCH8a60/aFeJvAqRA2SzmSPupaixsW4Lq2Hgz44fOfwGFNI6egR3BEf7ZWthmxyl1VK+PFRqpkgDVfbyWFAJ6L7DYWczbY0mDnKSogklYDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414489; c=relaxed/simple;
	bh=qW71JueQyZ8CXYAUt8EBBRnReSVMaIj7h1nmuaJsu6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X9OVDecILnBOIRMFiYUUgDeBqo7RBVhA4SyHkisrLzUlmddrnHpJJ+UmP0GBj9jerciuOLWtyvPvzRy8/j7pntXtiQ2HOeGPvZCJUUrP3pkX/Mk0fKGO/j/e30ZJfwoCFhs0UFbz2vK6VJL48xxkiCjOxmLp7gR1D0hokKnNYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lCdrsYKV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743414473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tn2VNzmzUAUwZ48Xp6pSAVp7xWEWB+IDyqbSXAEKDQ4=;
	b=lCdrsYKV0grW61XBMQGFyJbZWBRN6OKpdzI1/e+ZFet5tXIdb4gAyR9dyn0K51eUVxPVY9
	2t4cIyr1I9ZnR1Il9xt754tFEcdahVSs1qbAQB2PM3H8XTd4bcJLQrN4NJzJX/BP8SxI62
	4A3JVjrBOP/gxlZNotTa+ofPO76l8I0=
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
Subject: [PATCH bpf-next 1/2] bpf: Check link_create parameter for multi_kprobe
Date: Mon, 31 Mar 2025 17:47:44 +0800
Message-Id: <20250331094745.336010-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The target_fd and flags in link_create no used in multi_kprobe
, return -EINVAL if they assigned, keep it same as other link
attach apis.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13bef2462..2f206a2a2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2993,6 +2993,9 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
 
+	if (attr->link_create.target_fd || attr->link_create.flags)
+		return -EINVAL;
+
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
-- 
2.43.0


