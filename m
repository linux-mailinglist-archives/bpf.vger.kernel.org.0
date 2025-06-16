Return-Path: <bpf+bounces-60712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D3ADB103
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B80F3A3E5A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F3298CDC;
	Mon, 16 Jun 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mXqX5g0O"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB94292B3B;
	Mon, 16 Jun 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079022; cv=none; b=YpgYLTdR1taTUxgvdVMWAKEpz2smjCsUX4mmmXrrXMSYgK8/Ruq58TXL+rbcL7QMjdSprLtHPWCxDQVNmxYlN8rvncTB2rNCUr4HQtsps4y6JBY+K0BsuSiYdWYIz0hUXAwU7nkI+fhVMXEOVBeJiiShq2vpboopuMWqHvSCg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079022; c=relaxed/simple;
	bh=p5RbUZDdBP9GJ45EushgzCm7+amW2nhZBxekb5kEaaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq7DXSbK4fTD2hWe9wgDLJm7frXwjmq9Q+T4B+8mEg7rH892FGebZQmt2YanSlOVdGUy6nYMgISatrX43kG26jBAWBjKhvbNnH80aOxt+PVjK6wmd+vay3gsswYLqQf/qJpBxFirRWswrZAnIaIhJCP8H6r9dpakEvjCKD+ygzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mXqX5g0O; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750079014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA4HDcoQwAsvy+FAZ9s9PfK2YKDSvcnxpI2xo5wCIxE=;
	b=mXqX5g0OBZq0XRkexyW2HXYyD81frodp818ARkJ6Su1YUldK/pBBLJCLo6/hh86FNw0m7B
	6vxIAZxgDwONHbmzsgf0HLlfZ2vk/PKuln1LW2uPfu4ba9fKf2GLmR62Gx4ItbQ8HNFjkO
	YOaxUqbbFrVtoW8XJASPOJq5iRjGdP0=
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
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 2/2] bpf: Add show_fdinfo for kprobe_multi
Date: Mon, 16 Jun 2025 21:02:33 +0800
Message-ID: <20250616130233.451439-2-chen.dylane@linux.dev>
In-Reply-To: <20250616130233.451439-1-chen.dylane@linux.dev>
References: <20250616130233.451439-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show kprobe_multi link info with fdinfo, the info as follows:

link_type:	kprobe_multi
link_id:	1
prog_tag:	a15b7646cb7f3322
prog_id:	21
type:	kprobe_multi
kprobe_cnt:	8
missed:	0
cookie           func
1                bpf_fentry_test1
7                bpf_fentry_test2
2                bpf_fentry_test3
3                bpf_fentry_test4
4                bpf_fentry_test5
5                bpf_fentry_test6
6                bpf_fentry_test7
8                bpf_fentry_test8

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2d422f897ac..fcf19e233b5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,10 +2623,42 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+	char sym[KSYM_NAME_LEN];
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+
+	seq_printf(seq,
+		   "type:\t%s\n"
+		   "kprobe_cnt:\t%u\n"
+		   "missed:\t%lu\n",
+		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
+					 "kprobe_multi",
+		   kmulti_link->cnt,
+		   kmulti_link->fp.nmissed);
+
+	seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		sprint_symbol_no_offset(sym, kmulti_link->addrs[i]);
+		seq_printf(seq,
+			   "%-16llu %-16s\n",
+			   kmulti_link->cookies[i],
+			   sym);
+	}
+}
+#endif
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
 	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_kprobe_multi_show_fdinfo,
+#endif
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
-- 
2.48.1


