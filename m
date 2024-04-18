Return-Path: <bpf+bounces-27161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A78AA289
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2571F22121
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D617B4E0;
	Thu, 18 Apr 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAY9TR56"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C417A93E;
	Thu, 18 Apr 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467357; cv=none; b=Jt3R4/TxJ6/SOG1AWiUdIaDDOZwVQSqCXopp9m5g1b631XGiP/7yMz8cyFtYYhVDf25kZSvopM/sfetcLLkBubRRV6n/8SlCCJ42Qm0ZmQUMGwlt6vPX8/KNMeIY3k0lljQsD04jqGNuMmHppXiG9P5zbzQYNhRfkxgkL+JR4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467357; c=relaxed/simple;
	bh=75OGVwtk10YDnshR2n8e3XiLU+Tzx59fshzeQKNOVa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRtsaQe8RSInFD8JiDss1lCgxPyfr43pNUNbSqJNOjd5EDbGM8LssynkvsD2JoXBAPgNP4+t5amQ55XYYyROFOaUfWaPWHVJby9vF+MAv/3WqcaZGngFGs31yLD9jPM6JiECXUeFhFWPa+RVOLHixLaD0aHdPfvOjNcegCsXUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAY9TR56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29964C113CC;
	Thu, 18 Apr 2024 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713467357;
	bh=75OGVwtk10YDnshR2n8e3XiLU+Tzx59fshzeQKNOVa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAY9TR56v/jjNv854LjFW2kiFRpkox+yVSKcQK7VcA4CvmV42AiBGKaWRXtNHx2qP
	 SN63J9umkMgiAaJdCGl4SRanjqE6CXWoR4daqdtmBt7q8MdMLe55GdrOQuNcF2E7WA
	 get2b9h99o6zODP5C9GajKdKMP9vHFssp1Y7ymEOTzSY9Wp2RlENkAtXO+YXX/d/I5
	 b75EI0AnPl0xkGupeqVBhR6pyuAsZQIWtUPbcZXtfdiZDn7fZrtH9GQuLDZx2yxXQB
	 nBoMCbpa8c/4d8UGgpqNA6nbsEaMJlceOUigGlSXB631uFddeSetyVtW5XCd6JYClS
	 LtuDghZE+UGdQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 2/2] rethook: honor CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING in rethook_try_get()
Date: Thu, 18 Apr 2024 12:09:09 -0700
Message-ID: <20240418190909.704286-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418190909.704286-1-andrii@kernel.org>
References: <20240418190909.704286-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validating
that RCU is watching when trying to setup rethooko on a function entry.

One notable exception when we force rcu_is_watching() check is
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y case, in which case kretprobes will use
old-style int3-based workflow instead of relying on ftrace, making RCU
watching check important to validate.

This further (in addition to improvements in the previous patch)
improves BPF multi-kretprobe (which rely on rethook) runtime throughput
by 2.3%, according to BPF benchmarks ([0]).

  [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/rethook.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index fa03094e9e69..a974605ad7a5 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!handler))
 		return NULL;
 
+#if defined(CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING) || defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
 	/*
 	 * This expects the caller will set up a rethook on a function entry.
 	 * When the function returns, the rethook will eventually be reclaimed
@@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	 */
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
+#endif
 
 	return (struct rethook_node *)objpool_pop(&rh->pool);
 }
-- 
2.43.0


