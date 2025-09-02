Return-Path: <bpf+bounces-67186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7EB4070E
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999154E607C
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C43126BC;
	Tue,  2 Sep 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8p0Hgey"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1B2FB975;
	Tue,  2 Sep 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823759; cv=none; b=nlhi+GDIjfB3Sc35UMJeci92gtnb/B4oaaiUnCqbt5DQmRrajFt33zs2SfjnP9xU5IaohIsmNgPEV8zrc4lz3iAGSwBsWcC7tjw/Cc/Zi3peYMLl6x4WV9IN694D2Sv6YgbOOxFT0ma4zUrL2YKkyWTBDFemmqo4iH7XtI6HWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823759; c=relaxed/simple;
	bh=t3UXooaazEhhUvhuEd2T+tvKknhfUjTYkjtwmq08f+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJBivUKUNsXZfg4nHM/dpKs7iMC3IPkF/F9s+QuGYoGIBUDrdwf3jZmp42sRqMnj8hCa5dUkG9v/s/hU0BDKhog5/BrQ5C2sSUyNU3r+u5cBaiOcEaHQN333YewNkDMr/7Yu0MvvALYsLdXLRe6+RR9vYgn/+3ETHc7DARHRotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8p0Hgey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0ECC4CEED;
	Tue,  2 Sep 2025 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823758;
	bh=t3UXooaazEhhUvhuEd2T+tvKknhfUjTYkjtwmq08f+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8p0HgeyswS62wDW4Mzla2zdjTCHIXLx9uHWrj+2KFE0sbUuFs8C5wTrGC2B8Of6R
	 VDD7xG/KVOTVdPLHXQeGTXy7r/ksoTJ8MPAOrOr3HNDtvBsvWeqndbnSt6LBPMIBES
	 /uqWPGqOlAWHqWblK4EdkEgNOkFVqOcv1BcMloAJ7c7EcVZR5qO33C4ktLW/+88hXW
	 a5CAQadi0BzuR9knBJTVt8YSilxhNvDKDUVtxfzbLqn3vSzx6EuCgBXb0BwA+ykTSg
	 aoz+P/+Trz2b2FAJ56pc2X9zNFCcAW4CNqJya03K4tOWXCPGKDX6mvzInmI5bo+Tfw
	 7ewSsC/rmwPHw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 04/11] bpf: Add support to attach uprobe_multi unique uprobe
Date: Tue,  2 Sep 2025 16:34:57 +0200
Message-ID: <20250902143504.1224726-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to attach unique uprobe through uprobe multi link
interface.

Adding new BPF_F_UPROBE_MULTI_UNIQUE flag that denotes the unique
uprobe creation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 3 ++-
 kernel/trace/bpf_trace.c       | 4 +++-
 tools/include/uapi/linux/bpf.h | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..3de9eb469fe2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1300,7 +1300,8 @@ enum {
  * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_UPROBE_MULTI_RETURN = (1U << 0),
+	BPF_F_UPROBE_MULTI_UNIQUE = (1U << 1),
 };
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..0674d5ac7b55 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3349,7 +3349,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -EINVAL;
 
 	flags = attr->link_create.uprobe_multi.flags;
-	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
+	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN|BPF_F_UPROBE_MULTI_UNIQUE))
 		return -EINVAL;
 
 	/*
@@ -3423,6 +3423,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 		uprobes[i].link = link;
 
+		if (flags & BPF_F_UPROBE_MULTI_UNIQUE)
+			uprobes[i].consumer.is_unique = true;
 		if (!(flags & BPF_F_UPROBE_MULTI_RETURN))
 			uprobes[i].consumer.handler = uprobe_multi_link_handler;
 		if (flags & BPF_F_UPROBE_MULTI_RETURN || is_uprobe_session(prog))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..3de9eb469fe2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1300,7 +1300,8 @@ enum {
  * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
  */
 enum {
-	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+	BPF_F_UPROBE_MULTI_RETURN = (1U << 0),
+	BPF_F_UPROBE_MULTI_UNIQUE = (1U << 1),
 };
 
 /* link_create.netfilter.flags used in LINK_CREATE command for
-- 
2.51.0


