Return-Path: <bpf+bounces-45751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADA9DADB7
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263B5B2586F
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE67205AB6;
	Wed, 27 Nov 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tLcqbmWn"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0364204084;
	Wed, 27 Nov 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735254; cv=none; b=I8Lpma6sES8xhVaGodOWaEVMpa/V425gMaV3ieZ7qM+OJrStVKHXZ64YwepygeuOOEQ+I8bkEckXhCMxwygbK6eLP/E6KHBV5ee3V4yzb59BkSl9P7rAET8Au8EHByfH5E6ZaYr/S9WEkcYCg4SiyRtNEVD4IDMI3cIu2ZXJ8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735254; c=relaxed/simple;
	bh=nbtK+ExfnhyZ5gIuDVa+ktGgkDaweYMcUS0HqG+YpRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNsmI0FNTCSTyceNkRHtJN2LTQrnnXvNIJMV9HLb17rvGsWC2vFtDMsc3TV9ycANtODNj/vQpZrVVkhgAi2z3UjvzDGJPVb7tLHA3SCMg4y9xSmcj0dkZusXSywn5t+kfBd/rAfGgMpO77QaS5XZTRCwas0G0hP9cQXE/XPP5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tLcqbmWn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735246;
	bh=nbtK+ExfnhyZ5gIuDVa+ktGgkDaweYMcUS0HqG+YpRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tLcqbmWncVQtNYbVmUS4nz2f9F8Sx7+sQ72Vs2nHeofqor4aTS3Il377VCKRGDT7Q
	 dKW3SknUt3I14pxhEcaF/reEIcmCbarycyi41v4gBcbJ2FACOmrnB4Gf0+y+eNVCDM
	 88W4vgzgoW0v+q70nDmi49oCKF5tVMYU1tx/pbMI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 20:15:28 +0100
Subject: [PATCH bpf-next 9/9] sched_ext: Constify BPF ops
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-bpf-const-ops-v1-9-a698b8d58680@weissschuh.net>
References: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
In-Reply-To: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
 Kui-Feng Lee <thinker.li@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Tejun Heo <tj@kernel.org>, 
 David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1292;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nbtK+ExfnhyZ5gIuDVa+ktGgkDaweYMcUS0HqG+YpRw=;
 b=5zWiiR7OeqVtKBCAJqaHUdaXLiAsRczQ+k3xFIAeIbrkbMHLGvOzyXVhTwQ3uzOF+d0gwO38M
 3MftYCnHb5cDCybqRyCLbxCaiQaluJkIYv+kFJkBeG3IpjA8QsuHTkB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The BPF core now allows the registration of read-only ops tables,
make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fff1d0454770f5fab3e13708816d56653637ee9..6d3cced2951f61b73e6779edfb62b63c1ab62093 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5914,7 +5914,7 @@ static void sched_ext_ops__dump(struct scx_dump_ctx *ctx) {}
 static void sched_ext_ops__dump_cpu(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
 static void sched_ext_ops__dump_task(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
-static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
+static const struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.select_cpu		= sched_ext_ops__select_cpu,
 	.enqueue		= sched_ext_ops__enqueue,
 	.dequeue		= sched_ext_ops__dequeue,
@@ -5952,7 +5952,7 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.dump_task		= sched_ext_ops__dump_task,
 };
 
-static struct bpf_struct_ops bpf_sched_ext_ops = {
+static const struct bpf_struct_ops bpf_sched_ext_ops = {
 	.verifier_ops = &bpf_scx_verifier_ops,
 	.reg = bpf_scx_reg,
 	.unreg = bpf_scx_unreg,

-- 
2.47.1


