Return-Path: <bpf+bounces-43755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36379B9740
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AEB1F22272
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD11CEEB2;
	Fri,  1 Nov 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1yc/Xto"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E061CEEA1;
	Fri,  1 Nov 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485083; cv=none; b=RQeTStwNHNssxqhg5RrWNIeIekYIEOOxmVm7ZDYLE/rGJxq+COY2QKGMdsHuTEIk95xN2OsxWO87a21gItDWRaeLYQ2r+MeVzpX3k6SfIHFuKswfbD0vg29w/V0rIbBA0FcfPClQaxlC+zcx+YtSh+o4YM3Da6VgJD3Vz0lPa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485083; c=relaxed/simple;
	bh=pLkrsjMFYN/mNaI3Fdv6PbD0M+/x9zuZD5f1yei6K5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP0VIH6jnlK3nMfejjLNnap7sGD9BksM4dwcQymQKL7L8KEcvdC4NcOn4Aw4O2BtUYeRcUBNYC4GOo26xeyD3Ar3SgH5i/CmtD/OLFoVFY0h5149/0trb+hc0mkRoJvt67i1V6NgbrI/jEawF5cOc5RAwG/lp9AlL6XO24HM+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1yc/Xto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF4AC4CED3;
	Fri,  1 Nov 2024 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730485083;
	bh=pLkrsjMFYN/mNaI3Fdv6PbD0M+/x9zuZD5f1yei6K5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1yc/XtoFpsg3yXIo8zVXSP4INlcThkXyYlIz4ZTH2xJSEhQMxJcpKiddlGG0rfRg
	 sVbqmtsb3SqUJiyb14mwQN9NtKk98ZDP4nszrQz08vooYFRVU13z+yy7eDfUSZW6l2
	 YDY3DzX7pTHqLGtZ5BUN8x4ndHW099vav8EvdiadF5JX2e6YZ3YSzHa4z4bFtgABIG
	 KHa093FDVZkiuLZFHso+8l3AfH/vccR+kSVkS6GiZQkl2SJWvR2Z3fXEOOkR7dL2R9
	 x49sjtNbnvGXOaYtJRdZgvnyoSJ3pzF2B7GzZAEMV9AjF5m6F4RR+R/YE0RnpchmSa
	 J6pHJzN1tUUOg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rostedt@goodmis.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	jrife@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links
Date: Fri,  1 Nov 2024 11:17:54 -0700
Message-ID: <20241101181754.782341-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101181754.782341-1-andrii@kernel.org>
References: <20241101181754.782341-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that kernel supports sleepable tracepoints, the fact that
bpf_probe_unregister() is asynchronous, i.e., that it doesn't wait for
any in-flight tracepoints to conclude before returning, we now need to
delay BPF raw tp link's deallocation and bpf_prog_put() of its
underlying BPF program (regardless of program's own sleepable semantics)
until after full RCU Tasks Trace GP. With that GP over, we'll have
a guarantee that no tracepoint can reach BPF link and thus its BPF program.

We use newly added tracepoint_is_faultable() check to know when this RCU
Tasks Trace GP is necessary and utilize BPF link's own sleepable flag
passed through bpf_link_init_sleepable() initializer.

Tested-by: Jordan Rife <jrife@google.com>
Reported-by: Jordan Rife <jrife@google.com>
Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0f5540627911..db2a987504b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/tracepoint.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -3845,8 +3846,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		err = -ENOMEM;
 		goto out_put_btp;
 	}
-	bpf_link_init(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
-		      &bpf_raw_tp_link_lops, prog);
+	bpf_link_init_sleepable(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
+				&bpf_raw_tp_link_lops, prog,
+				tracepoint_is_faultable(btp->tp));
 	link->btp = btp;
 	link->cookie = cookie;
 
-- 
2.43.5


