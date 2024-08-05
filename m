Return-Path: <bpf+bounces-36413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7694836B
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1B1C21EBD
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F21547C3;
	Mon,  5 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhhgPl2h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1413CF86;
	Mon,  5 Aug 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889687; cv=none; b=ZcQ18ZutdLprh6yamQkgLjWeQTiL8B6lz7y8WiWmmQly3Vy1uG66LNPtrG4Sym0fa334eMDT5K6pL4175KU7skAxkJA2SnY0dh0VCa5QNnPzoADMstP9W5dUL8gTMASw+fj52cdHT/NcbczbzxN9MAEObJXUVYgqlB9YLZzRhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889687; c=relaxed/simple;
	bh=ytY7BCZ4p2pRVE1pUSq3YppSwfqJsmzi1njORzdxIsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=attGLNE8c5kJec4InT6/8sZTjNCoSC6jsXDlXlFaiBSWNKaZcLXorkhQIQ2Kw9iQ4eMZyBIh3MPb2dVzNKwpA8V3gJQE3XDc31ZlDnc97a/h8oe957TuCP13T0nP9S8PPli3flUwwVPSrJtMeWZ+pmqpkWUlCS6utg1+J8Y5JTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhhgPl2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86837C32782;
	Mon,  5 Aug 2024 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722889686;
	bh=ytY7BCZ4p2pRVE1pUSq3YppSwfqJsmzi1njORzdxIsY=;
	h=From:To:Cc:Subject:Date:From;
	b=uhhgPl2hxbczZSJ38YXHEb1HEMak8s2WUStfRl7N4gC/6KSU69dvtqG1nk+Tgz6Xw
	 OkEEEuaDOe5auHupuciNn5WInJU3dUE56txJaFuRXypLQr+bv/cKDgVEOQWpg8YEXP
	 EeHtqqtaa3pv5CAF3oK2TMHRYor6fTpNL6popAeLFkW2zmXoNb1Ee+MgOBrqomRhmh
	 QU1wrzhzHLSFOz0+Q+ZhqZ2kOn0G7F8oKFv03dHv8gVub3pvIqk/3wG7WBM4lofi6w
	 QUTNk1xZDH+KqrwV59c7q9xm8CiFvEtoX0s4RawdITS/r8yMlc2Wd1bvt2dC/14J6A
	 35y5Lox9SzM7w==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: peterz@infradead.org,
	oleg@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] uprobes: get rid of bogus trace_uprobe hit counter
Date: Mon,  5 Aug 2024 13:28:03 -0700
Message-ID: <20240805202803.1813090-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_uprobe->nhit counter is not incremented atomically, so its value
is bogus in practice. On the other hand, it's actually a pretty big
uprobe scalability problem due to heavy cache line bouncing between CPUs
triggering the same uprobe.

Drop it and emit obviously unrealistic value in its stead in
uporbe_profiler seq file.

The alternative would be allocating per-CPU counter, but I'm not sure
it's justified.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 52e76a73fa7c..5d38207db479 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -62,7 +62,6 @@ struct trace_uprobe {
 	struct uprobe			*uprobe;
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
-	unsigned long			nhit;
 	struct trace_probe		tp;
 };
 
@@ -821,7 +820,7 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
 
 	tu = to_trace_uprobe(ev);
 	seq_printf(m, "  %s %-44s %15lu\n", tu->filename,
-			trace_probe_name(&tu->tp), tu->nhit);
+		   trace_probe_name(&tu->tp), ULONG_MAX);
 	return 0;
 }
 
@@ -1507,7 +1506,6 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
-	tu->nhit++;
 
 	udd.tu = tu;
 	udd.bp_addr = instruction_pointer(regs);
-- 
2.43.5


