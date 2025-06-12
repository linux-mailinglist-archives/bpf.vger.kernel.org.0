Return-Path: <bpf+bounces-60459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC275AD6F99
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7FA189E3B9
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A594523BF91;
	Thu, 12 Jun 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="weSgil/Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20422D4C3
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729398; cv=none; b=Nyb/Y9ZiEvISRId0TsmJzCTpP47CQ112C7506IQjP++QkBSbq18oDgLn5I6GTGkiR70Sfx0Z9HroQOhyTPPqtNv/+g/rcD6xeqzHilt/awhMGhm1OkAboX5vmfqFU9WgqWRpxMkacpCnK7cdDaPANCpJL+NrFJHsXnicizfrags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729398; c=relaxed/simple;
	bh=xQUd6KRk/zxgbgaYPb4B2Ml8aBjLBMLlzwWH++I11kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5GBsL1YzD4I+kzIbW206E8byN0CTG/ljKF9VhP6fn4T+IDMVzVtZk9JE2EVEea+Q9IfhjZu8U/VVAHehJkB8IXFEBN0YaZA5i1R+OlYvVzPFcmum+V9Qf6slEE1BMTj3z5nu/wd0ZD0WwPEyKftBkGXu5BrOKjPYll6Uow1pek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=weSgil/Q; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749729394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAzhY+KexUawruXmAPMa1vYXeOJqsujnp/yRg0G6Jx0=;
	b=weSgil/QVe084UqrgSRLaOYFpRVY3lYT+rzc6unxQr2BYkN+F0bHvlCnIGzmeBIm+DYN2m
	okoUygpDUa2vr6BeuToH7W2VIAG+X4+4CYjbrXBS+8V7f3vFst53G1dZnD+YSIyoVTTQF0
	OgZCqXgz18APH9DZhaHHa6fYM8OlSbA=
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
Subject: [PATCH bpf-next 2/2] bpf: Add show_fdinfo for kprobe_multi
Date: Thu, 12 Jun 2025 19:55:56 +0800
Message-ID: <20250612115556.295103-2-chen.dylane@linux.dev>
In-Reply-To: <20250612115556.295103-1-chen.dylane@linux.dev>
References: <20250612115556.295103-1-chen.dylane@linux.dev>
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
link_id:	4
prog_tag:	279dd9c09dfbc757
prog_id:	30
type:	kprobe_multi
func_cnt:	8
missed:	0
addr:	0xffffffff81ecb1e0
cookie:	8
addr:	0xffffffff81eccb70
cookie:	2
addr:	0xffffffff81eccba0
cookie:	7
addr:	0xffffffff81eccbd0
cookie:	6
addr:	0xffffffff81eccc00
cookie:	5
addr:	0xffffffff81eccc30
cookie:	4
addr:	0xffffffff81eccc60
cookie:	3
addr:	0xffffffff81eccc90
cookie:	1

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c4ad82b8fd8..6c3ffa3c1ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,10 +2623,41 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
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
+		   "type:\t%s\n"
+		   "func_cnt:\t%u\n"
+		   "missed:\t%lu\n",
+		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
+					 "kprobe_multi",
+		   kmulti_link->cnt,
+		   kmulti_link->fp.nmissed);
+
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		seq_printf(seq,
+			  "addr:\t%#lx\n"
+			  "cookie:\t%llu\n",
+			  kmulti_link->addrs[i],
+			  kmulti_link->cookies[i]
+			  );
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


