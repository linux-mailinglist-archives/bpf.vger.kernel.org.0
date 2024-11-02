Return-Path: <bpf+bounces-43806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6429B9C1D
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 03:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A4F1C20FB8
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55783A14;
	Sat,  2 Nov 2024 02:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EFC45BEC;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513127; cv=none; b=k51A4JgNKCbEJqeHyt8tuZwND3wkD9q5rgt94B0w2PXanyrEbu7RL64nrDybPHmmNBGwGyWGLH8rZifBSP4yY8NnXet/T5fqHu1Pvx8ruVdWvOhiLY1SuUMswK5C+5BlMF9E7j8tyB/kVpYQiI+U+1K7MGX04rJocQyGgqYRAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513127; c=relaxed/simple;
	bh=ltd541s0kV2rAtuImuK1PKdLtFcYMQ5/FrhyIksohA8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W6kTMyTmegf6UIvHpn8doy4aiEQHfl/BzRB+E/m7OxTpvTznYBACkIMnZvDbRHT2swbSmiuK2dZDseU6peYKXA7mJjMzR6WwJqgi6OV9eyYDEqUMi+OCIYZsC1y3vxEiqfZKPshchtCqR64kNUxrRYZ2gA10CCHociP40OOm5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8126C4CED6;
	Sat,  2 Nov 2024 02:05:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t73X0-00000005ZfS-2DV4;
	Fri, 01 Nov 2024 22:06:26 -0400
Message-ID: <20241102020626.391428728@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 22:05:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Jordan Rife <jrife@google.com>
Subject: [for-next][PATCH 3/3] bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links
References: <20241102020553.444477901@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andrii Nakryiko <andrii@kernel.org>

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

Link: https://lore.kernel.org/20241101181754.782341-3-andrii@kernel.org
Tested-by: Jordan Rife <jrife@google.com>
Reported-by: Jordan Rife <jrife@google.com>
Fixes: a363d27cdbc2 ("tracing: Allow system call tracepoints to handle page faults")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.45.2



