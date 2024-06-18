Return-Path: <bpf+bounces-32444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46590DE2C
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234A41F225CC
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAD18E757;
	Tue, 18 Jun 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niIG5s9a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01172178393;
	Tue, 18 Jun 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745688; cv=none; b=JF/MgRCIPOSBcLZhOg8yD8qt4BZUlOjh7AMq59R+uuWYDWSkM0YkDBcT1nXVuTE3GJWAZyJvuveTjmtTOkLOVYJTNLUZEHhWF/scm8+zrydnqIJWtIspBIR5SfPRbL02tTsZ0VhXnPfpqDBBagkIJ2z2qkt6sDd0BO1aIXRXvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745688; c=relaxed/simple;
	bh=/ypc4Db/NXcebge+uw+b4B8KrboR86tquOKE0tc9M+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swRnBuwrvUsd3zPMuGPo6sVTx0/ngK93Viamwu68gSNfGz3kBnYCKYth3ciL7/3/pYl0MMzd5uzUPQiu6hivQDwQUtOjSMJ8twU0wGKZBWVWcTQLztp6axxCE35bgOUJsZ4Igf5KBXNNpE4dF5Ciduy7+/Aa559bSEvEiqxLBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niIG5s9a; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eee7728b00so101993139f.3;
        Tue, 18 Jun 2024 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745686; x=1719350486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQdSHUBpQOpn2D5zDs8Ogf9IC7Y2k8GQ/64PDJlEIY0=;
        b=niIG5s9an7u0hBpbziq88sem/60Cw0Anj5XMrs9EmQvURryA4MR9FR67AdsS7ejaCD
         rmnfzfFakujJz0Cc+xQW4ytC+60JrqOlXY08OXs+yPtCgtO8h02FZKJDNKJMw7hMWeuo
         /BsFG0EjKkK+eUhuwVpXUe8zCOfseOGSVX5GGPMh/R2+MAmHkzskFFLqH3+M/EXupFPu
         usY7XhZRicKfkLzp/L/b0Ze8lc9Im9oFN7b7W8Czhf8jumrzUiA4aB37MZKq01R60dXs
         TV50VI00ZLmFNXy9nBM5VxkbfSr4iyvUNDOwHYmdBFNYSDnE86zKLNNZp6LFwaoU97Nu
         iLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745686; x=1719350486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQdSHUBpQOpn2D5zDs8Ogf9IC7Y2k8GQ/64PDJlEIY0=;
        b=GA65k7Il+x+IKlL+5JHe2GbHDDcUh42bK9WwSeTX4+4C1zkNDt9EV8+GX47oLOUCgH
         dhWUozH7JdrnkmBxuWtsuLyvrEfsHDTIzzpuYde6weS0dVyA1100ijziOLj5D8SQqvfy
         eMV0f97v1UNAAnvhMd4nfWr7t/EPfHVxnqa8VG3FLM6fba0UxHeHh7C97YeHpjqvnwj7
         4VE8DmNPziiJTrCQamBYcpbGV13w2Owk/WCFw58vuj/g+KtQvbdc6zhx6nkr88hc2evU
         oXE0/ViAPb9Fg2h8KoP6UMcWup1Rcb0KhJQZjWR8oX42T6MZntGsGcQhvWoII/rlJjUz
         1LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvrQLwYvkLYCFoDPsGwb1//39EbR3FqEEVsZoSf5ELD5uUdrDg39kr/Vu+zzOS/Vro6v9N3nH2f52IfzP5bqp5ls+S
X-Gm-Message-State: AOJu0Yw05HyFPcByr/AFCHaaUn9cQAQuGvehUHDUGz7XF+D3uaB3+gLU
	0VIqrbUPpVppELSXxrqKeopeRx/qOJavzpJcrJ/Xbi+zB7oMjKE3
X-Google-Smtp-Source: AGHT+IFTo/A58lX1rUt9CeU5QzxE/YVYK7mRWmmdoFv8t4LmWf6qjNBbHgPYXC0aGBfipFOp5k58Wg==
X-Received: by 2002:a05:6602:1347:b0:7eb:cba1:b19e with SMTP id ca18e2360f4ac-7f13edcfff3mr125068839f.8.1718745686044;
        Tue, 18 Jun 2024 14:21:26 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2c40851sm8426457a12.68.2024.06.18.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/30] sched_ext: Add sysrq-S which disables the BPF scheduler
Date: Tue, 18 Jun 2024 11:17:26 -1000
Message-ID: <20240618212056.2833381-12-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables the admin to abort the BPF scheduler and revert to CFS anytime.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 drivers/tty/sysrq.c         |  1 +
 kernel/sched/build_policy.c |  1 +
 kernel/sched/ext.c          | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e5974b8239c9..167e877b8bef 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -531,6 +531,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* P */
 	NULL,				/* Q */
 	&sysrq_replay_logs_op,		/* R */
+	/* S: May be registered by sched_ext for resetting */
 	NULL,				/* S */
 	NULL,				/* T */
 	NULL,				/* U */
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index f0c148fcd2df..9223c49ddcf3 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -32,6 +32,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/sysrq.h>
 #include <linux/percpu-rwsem.h>
 
 #include <uapi/linux/sched/types.h>
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 49b115f5b052..1f5d80df263a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -20,6 +20,7 @@ enum scx_exit_kind {
 	SCX_EXIT_UNREG = 64,	/* user-space initiated unregistration */
 	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
 	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
+	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
@@ -2776,6 +2777,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "Scheduler unregistered from BPF";
 	case SCX_EXIT_UNREG_KERN:
 		return "Scheduler unregistered from the main kernel";
+	case SCX_EXIT_SYSRQ:
+		return "disabled by sysrq-S";
 	case SCX_EXIT_ERROR:
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
@@ -3526,6 +3529,21 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
  * System integration and init.
  */
 
+static void sysrq_handle_sched_ext_reset(u8 key)
+{
+	if (scx_ops_helper)
+		scx_ops_disable(SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF scheduler not yet used\n");
+}
+
+static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
+	.handler	= sysrq_handle_sched_ext_reset,
+	.help_msg	= "reset-sched-ext(S)",
+	.action_msg	= "Disable sched_ext and revert all tasks to CFS",
+	.enable_mask	= SYSRQ_ENABLE_RTNICE,
+};
+
 void __init init_sched_ext_class(void)
 {
 	s32 cpu, v;
@@ -3549,6 +3567,8 @@ void __init init_sched_ext_class(void)
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.45.2


