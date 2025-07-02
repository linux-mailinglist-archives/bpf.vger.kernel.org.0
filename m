Return-Path: <bpf+bounces-62136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C9FAF5D90
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA98B1884E88
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D602D7803;
	Wed,  2 Jul 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9P5dCbQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A83196B9
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470904; cv=none; b=hQEGRm4pA2bVRpYpC9oTWf61l1WRvp+mR/bgFl7/MPVtWyrtCmn2fcjS/SErVTQ8MNkVUhIqZ3hB/7gigu8GkZ008iIaOVX4/2hGuMfDMmreJWYeqp55HOpZHK86hnN347HXZxwN202rZvI6lVi3WZZa36cJUeMhGkF18Uhf/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470904; c=relaxed/simple;
	bh=En7BNpcoJa/n13IT+RqaWyk0TF0dKDWgK1txgAGYeHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2s6VIss+N6w4fGQfEWrYMTNG5h2/0e7ZB1g55RFLMDxIz55K7ilBUwBCiAYw+RgDhS4JCxcNVGcaS2GhHFLN+YxiDt+/rgl4s1u4kQYabEtjD1pTMNDLsIRI7K2MzsAndFMoWpKGgX8/B2k0yYr32tqJU1IO9IZn4ID4yTGREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9P5dCbQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751470900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eBqqWXx8G2Qqbrx7SN0UwqZFfxzFb5EhS0w9gnHvfs=;
	b=r9P5dCbQjjD7w7sfJjw2+Yse8QMwx063HS3S6JHldOHxovY1m+ZToukjqCepPS9e2CALYq
	k3g/KEm8jJ4qYdZDCEDDQr+UKTcEeoG1F3KnV9CQhueASjcjUXqaKR0mYIa/SGUhJVtP2Z
	e9CBnkfRCc6qb+UraVpZpaU7XwayGn4=
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
Subject: [PATCH bpf-next v7 3/3] bpf: Add show_fdinfo for kprobe_multi
Date: Wed,  2 Jul 2025 23:39:58 +0800
Message-ID: <20250702153958.639852-3-chen.dylane@linux.dev>
In-Reply-To: <20250702153958.639852-1-chen.dylane@linux.dev>
References: <20250702153958.639852-1-chen.dylane@linux.dev>
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
prog_tag:	a69740b9746f7da8
prog_id:	21
kprobe_cnt:	8
missed:	0
cookie	 func
1	 bpf_fentry_test1+0x0/0x20
7	 bpf_fentry_test2+0x0/0x20
2	 bpf_fentry_test3+0x0/0x20
3	 bpf_fentry_test4+0x0/0x20
4	 bpf_fentry_test5+0x0/0x20
5	 bpf_fentry_test6+0x0/0x20
6	 bpf_fentry_test7+0x0/0x20
8	 bpf_fentry_test8+0x0/0x10

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9161a1b3418..49d594b8c71 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2622,10 +2622,37 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+
+	seq_printf(seq,
+		   "kprobe_cnt:\t%u\n"
+		   "missed:\t%lu\n",
+		   kmulti_link->cnt,
+		   kmulti_link->fp.nmissed);
+
+	seq_printf(seq, "%s\t %s\n", "cookie", "func");
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%llu\t %pS\n",
+			   kmulti_link->cookies[i],
+			   (void *)kmulti_link->addrs[i]);
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


