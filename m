Return-Path: <bpf+bounces-61285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE1AE4547
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38C617A8B9
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D125486A;
	Mon, 23 Jun 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJWg/h1p"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04525291F
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686323; cv=none; b=emis5OjzrlJ449vDY0J9SVhpxc/bTQFS8gDkKompQNFtyoEn98Z1/mwwopz2KfXlu+9sRy35cfZYlQgWo0gbc9skNf5KZuvXXgTDcbo28jyiOvPp6tOeq4YJWJl5hLUJd5LY6o9SdOYbLVyiT5N+rb4yMHjy7X79ucC0w3sKTcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686323; c=relaxed/simple;
	bh=AlyOK8e20E88te3l2GflfE+0qiJ/f6x6QhsyGZEf+P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLx1J/O3Y4UmdIiaZm+ctoiAd7ogOTfCMV+MbDYo9SkpQGCCJHN4a0mB7W9+hCMG0+7lmmm8BqYeedPdejKWEGsSvo+Y/rNSceCBB+EaGhCFamcpCylctg43wXYtuNtuxAzoyEKSgCb/42eYsnhWf0mKgI+eXgm51jfiuJk+Z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJWg/h1p; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750686319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJg67qQuLrQ9MnWPvmahOxwsNWo0ze5flYtpMSuPnYs=;
	b=rJWg/h1pRZ4c40l0vyoOnp5O/2sl6GygdG253RGmtoOy8Nvisi6UVVA7Iu/aTD8gdOciTP
	5fbkpziz38DlTHL877Ou4aOEuhtbVsVhigKVl/w4cb7JcOIL9CsQX5hCPY1usrsMenIybJ
	ZfQAALi68fkBgLJhQBHv5Sm2mZXkZTI=
From: Tao Chen <chen.dylane@linux.dev>
To: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v5 3/3] bpf: Add show_fdinfo for kprobe_multi
Date: Mon, 23 Jun 2025 21:43:42 +0800
Message-ID: <20250623134342.227347-3-chen.dylane@linux.dev>
In-Reply-To: <20250623134342.227347-1-chen.dylane@linux.dev>
References: <20250623134342.227347-1-chen.dylane@linux.dev>
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
prog_tag:	33be53a4fd673e1d
prog_id:	21
kprobe_cnt:	8
missed:	0
cookie           func
1                bpf_fentry_test1+0x0/0x20
7                bpf_fentry_test2+0x0/0x20
2                bpf_fentry_test3+0x0/0x20
3                bpf_fentry_test4+0x0/0x20
4                bpf_fentry_test5+0x0/0x20
5                bpf_fentry_test6+0x0/0x20
6                bpf_fentry_test7+0x0/0x20
8                bpf_fentry_test8+0x0/0x10

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 90209dda819..957e5b319ef 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2623,10 +2623,37 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
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
+	seq_printf(seq, "%-16s %-16s\n", "cookie", "func");
+	for (int i = 0; i < kmulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%-16llu %-16pS\n",
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


