Return-Path: <bpf+bounces-61741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F6AEB13F
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153E3189FBC5
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8008A24DD12;
	Fri, 27 Jun 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RmitdeHs"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FC23B622
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012636; cv=none; b=e+mebfYRw6bLX2MieJpnYIkNNZI7jivvSEzRd5/VNx0qvIbiI8TWlL7j4dKLNj0XRPWsM9J/hO3FuFwFttjAzHpsYTR5uf7aUNIDHl9K292soca8rpsCMU/qdzG5MoN2xkcYsQWN1GhkolKZmC2oulfkMBMY0t9H3iQJv0iO478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012636; c=relaxed/simple;
	bh=PKYIMuGy8OCleB8erimjBnJLkk6HD6Z5JWNdDkqlbYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1oNWqTNmYHnXFqzgxPjX+cxN2Y5LqxGsHXz2YETWAdZJ/a1n/A2/75ivakH65tFjLvfiJ8ThKclFM7G67AiiyPYELKfs6xM+8aKdgWwpmreWspXhsS0WXAVb4ZaujFkl1VbIwBzvdJlgV7qNjTk6IaxohAeMJ/9lLJWvx8Kiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RmitdeHs; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751012632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMO1Z8SAg4HfgLswH5zPQRLzwrlmtOR8BlKrCJRhPV0=;
	b=RmitdeHswGkbGrd8XZ1vRSucn/p9fnrPVLD0sTFs0/B8jjWKtZfyU8FqNsiPcGn+l9d8x/
	h0z+8j6yau3w10eYPDW9X4ZIZ8EuFpoE/lsDKa9sRtto/gmseozfal24XGX5ADkRA8PrJv
	37qG846HGEildZA71QMO6WG+QzXBkOE=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
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
Subject: [PATCH bpf-next v6 3/3] bpf: Add show_fdinfo for kprobe_multi
Date: Fri, 27 Jun 2025 16:22:52 +0800
Message-ID: <20250627082252.431209-3-chen.dylane@linux.dev>
In-Reply-To: <20250627082252.431209-1-chen.dylane@linux.dev>
References: <20250627082252.431209-1-chen.dylane@linux.dev>
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
index 1c75f9c6c66..e8f070504c4 100644
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


