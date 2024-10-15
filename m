Return-Path: <bpf+bounces-41986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C399E284
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A4F282D7B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DF1E3782;
	Tue, 15 Oct 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/9cjONp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58E1E32CF
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983498; cv=none; b=nO7uCueP5+S9ekXAuOnJfOfC8B61svjHsP9zHuJqx4zXIutZd9X2o8ahDveReJVct5p12xGaRmWJqeopiz891JPqlUVDskFyNWG3Dwa33JdYRwDrgFLHR1f8pceO9HPwol5fDgC4UuBGI+okXkIcEuJs5DLEbpzkO8SghVTVQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983498; c=relaxed/simple;
	bh=1HQNG9iWWO3wV8At9GP/jjQuJFQ7TICtEW1ksq9n0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeGkoz/rAwY4f3HEtCQznnoA+6+jpITV+UPP/3O1eOIVzNqsJuWcvMtjL8lw7NXdTlMxd5ELIEdGUo8mZWsEcFbzhDT4UDqBZcF0rVud4cZuBQ7SoO/n8aGyId6AfVdZ6fCuicYxCgQ+nuCPfsMeClhAYBPe77v0It+HitET2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/9cjONp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2660FC4CED0;
	Tue, 15 Oct 2024 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983498;
	bh=1HQNG9iWWO3wV8At9GP/jjQuJFQ7TICtEW1ksq9n0g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/9cjONpPgCp6l6GMDakxRXTrSnEChphwND4TtNdB0BX4TjA0lf+zZAxHcxiZYFzJ
	 YYaaxT+8SMsWJYzn3whw2gSnR39GRNTv3Gf5LsD+uz5MHAOw4MXqONTkV4/ECxqEyD
	 XjHn5uWZ6icboTCtwZPuTal70kvzvkguWJryOP+Rsgmp8vmLM/gsxeW1VRpncSRhyk
	 DJ1kBNWAJg6fiRuRZ6ZdiVZHswMywen6PF7eoC6MbxESLLZGVpebhLt2ThotIz5lmy
	 HfMX2KVHmwAPoohymRrkpdtz7fOD9eC7MpPDtD06EwHglB3Dc8uQEne4iMuK0JJ+Hv
	 k2OErQfWp3F/A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 04/15] bpf: Force uprobe bpf program to always return 0
Date: Tue, 15 Oct 2024 11:10:39 +0200
Message-ID: <20241015091050.3731669-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrii make uprobe multi bpf programs to always return 0,
so they can't force uprobe removal.

Keeping the int return type for uprobe_prog_run, because it will be used
in following session changes.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fdab7ecd8dfa..3c1e5a561df4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3209,7 +3209,6 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_prog *prog = link->link.prog;
 	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
-	int err = 0;
 
 	if (link->task && !same_thread_group(current, link->task))
 		return 0;
@@ -3222,7 +3221,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	migrate_disable();
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
-	err = bpf_prog_run(link->link.prog, regs);
+	bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 
 	migrate_enable();
@@ -3231,7 +3230,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		rcu_read_unlock_trace();
 	else
 		rcu_read_unlock();
-	return err;
+	return 0;
 }
 
 static bool
-- 
2.46.2


