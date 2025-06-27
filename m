Return-Path: <bpf+bounces-61740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4EEAEB13B
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE32560A86
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728B25742C;
	Fri, 27 Jun 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BnxQ020G"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125B24DD13;
	Fri, 27 Jun 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012625; cv=none; b=uUBYd75UMp45bhBSA1azoYTIaL4V4WJbPVYzovFhSI45jjuJ81YF+0w+saGTVyorCrjFs+QvpXPe6hRYbeJKLDiFVjw518ycqCEsZfj+2l6pwRhvNvzHAE6Ndyx7Fp4Hcqk9LcXIMx7wOIliwxgMR11LX0wJaEioaByrnqSrBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012625; c=relaxed/simple;
	bh=vPXURhaW2uw3KgK7PoqNfidHI/8NXnGXhUTNjV2dNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0YkA2JOyQ1rpTFqkbv5DBdFS7AeoSn2XzpZLoEzV6XLt7lk4/Im8ff0L6/Q6+IGP3+mVwf6eYuXY82jgCtUBN3yLkGA3Bry7i1395qb8zg7Rpx02p6DYF3vv4OEAXuQKdjqBsm/Yp/JSmJR1FuaXBaz6J5+1QSVXvgUtc7uSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BnxQ020G; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751012611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0Fbt2AYOLOAACBKVgQkVoLUBFL5Tmg1VJ94A7rZEcQ=;
	b=BnxQ020GiSDzyMKFBoltLfuGpQPmbJINN8+WcZNXQPhPT3VXk6vMqlZm0ezN2rIFj/B2Iu
	DdBRpORwvpnYe8asDlBdEcBzn/O6U0KYIWslfP28AaPor9AzeZbkmAZvTS/N9FiM7d9ay3
	667ot2E+OsIoNeO6vqldBh4gjYdgnK0=
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
Subject: [PATCH bpf-next v6 2/3] bpf: Add show_fdinfo for uprobe_multi
Date: Fri, 27 Jun 2025 16:22:51 +0800
Message-ID: <20250627082252.431209-2-chen.dylane@linux.dev>
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

Show uprobe_multi link info with fdinfo, the info as follows:

link_type:	uprobe_multi
link_id:	10
prog_tag:	7db356c03e61a4d4
prog_id:	42
uprobe_cnt:	3
pid:	0
path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
offset           ref_ctr_offset   cookie
0xa69f13         0x0              2
0xa69f1e         0x0              3
0xa69f29         0x0              1

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 85f07f662fe..1c75f9c6c66 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3155,10 +3155,54 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	return err;
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
+					 struct seq_file *seq)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+	char *p, *buf;
+	pid_t pid;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	p = d_path(&umulti_link->path, buf, PATH_MAX);
+	if (IS_ERR(p)) {
+		kfree(buf);
+		return;
+	}
+
+	pid = umulti_link->task ?
+	      task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
+	seq_printf(seq,
+		   "uprobe_cnt:\t%u\n"
+		   "pid:\t%u\n"
+		   "path:\t%s\n",
+		   umulti_link->cnt, pid, p);
+
+	seq_printf(seq, "%-16s %-16s %-16s\n", "offset", "ref_ctr_offset", "cookie");
+	for (int i = 0; i < umulti_link->cnt; i++) {
+		seq_printf(seq,
+			   "%#-16llx %#-16lx %-16llu\n",
+			   umulti_link->uprobes[i].offset,
+			   umulti_link->uprobes[i].ref_ctr_offset,
+			   umulti_link->uprobes[i].cookie);
+	}
+
+	kfree(buf);
+}
+#endif
+
 static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
 	.release = bpf_uprobe_multi_link_release,
 	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
 	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
+#endif
 };
 
 static int uprobe_prog_run(struct bpf_uprobe *uprobe,
-- 
2.48.1


