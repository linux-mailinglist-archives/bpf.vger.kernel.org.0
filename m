Return-Path: <bpf+bounces-43672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF19B84FC
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 22:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052E82837BD
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDB1E0DE9;
	Thu, 31 Oct 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPXjVi3g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F31D131E;
	Thu, 31 Oct 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408996; cv=none; b=UUTScjeb8scG7VEMpKlSvKg6LMWhEbzE2+G7xMauiyEYJl6X3O7Doa4/42baZvW/WZDP50tcVdWc4DPQhie8DWe3QJl8p7uHUJHw/9yZnKAG7b7Gh4/3Op0bF41E2/F0PGxw8li9QZuf/Vz8MXCt/d1Qrkqnv7itH4RR7tpz6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408996; c=relaxed/simple;
	bh=aa+8Ty0bzdDp3GnvBMFsb/72+qrBl2HEaLiCKUzVr9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxeN+hOHHofXEFl5Pkpa5VvoqymfH3dHuvfINu4WFxEJxXArDLoVNvpDxqUTcZiJFvxsQ8UVMPtsbl+Cvlft4Mp8qUSxFZC3VaXK344HIeTWsBt4ViiauIlAjkDKy8Kjb+AIPjhdpowsn559CyVebALrr2/JH6f8tdMVaB/4ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPXjVi3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B2C4CEC3;
	Thu, 31 Oct 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730408996;
	bh=aa+8Ty0bzdDp3GnvBMFsb/72+qrBl2HEaLiCKUzVr9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPXjVi3g+TFRX4AgT+3dtWGZhUpkcUOXHMkv8+7QA0GuyC2X/+H9Dus4Sff3lkNfr
	 ATHbTF48HMmm2wsXFQERU21dhyvVhzq7gg1YFIxNOxH6RUpjJ4d4o1UDkPxAFtRCvE
	 5V0gvZLYxGfAMmUFJs/AoMx5fUTqJ2yXYIr0uGSMrO6x7cLSFAogsBfzmwdYmdFRWo
	 TJSsXDm+GLIDnShumoeUOsp+xQkV2Jpm1F/+KNhWps/db6/Lz8lJcVBsUBltBMP8FR
	 yRWY5xY4E3jgwzgHyTkJP4FbCmZsWvhUlyH0YI8DsFDj5KwdSkT2cLFbFTwh1zoOvN
	 yfguitZWq9Frw==
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
Subject: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for sleepable raw tracepoint BPF links
Date: Thu, 31 Oct 2024 14:09:38 -0700
Message-ID: <20241031210938.1696639-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241031210938.1696639-1-andrii@kernel.org>
References: <20241031210938.1696639-1-andrii@kernel.org>
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


