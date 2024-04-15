Return-Path: <bpf+bounces-26771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7128A4F8B
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326021F22710
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767D74413;
	Mon, 15 Apr 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPo5HY63"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8973186;
	Mon, 15 Apr 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185351; cv=none; b=VG3GDYRsXLeosIp6SzDt35YN/c64pbGkK90XsJTuuCG74np5rrW4YEksomFqMQmvo5FCfXXOkZuJbhtERY0XYjXjB0T3UzBHe6jwJIbwd+SdRKWF8KgXTFwabLIHgMijCQoXhmQeiYalcxd3M08kI/nwbPd8n9/Z6mJ9XqljNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185351; c=relaxed/simple;
	bh=5YcmAJEaJy+2NLkAu6FGCcCQHDR3gKDPyGyZkrrlNqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgEYqnh7ooTd+mP+rJf+pMVT6QHtxW2KzAW4Yl2wnT0AVgXf1AXLWGEKHKjGafJ84cu98c9h92ZkCqFQkEopDEHAYyAd6jXVb5orLKlsZOMWucOAkCr1ialZWCqgDlYnU4uA3FTPvT++FBIMGUIGWHdxHXGWmib8Yf4OiQ/MQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPo5HY63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D575C32783;
	Mon, 15 Apr 2024 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185351;
	bh=5YcmAJEaJy+2NLkAu6FGCcCQHDR3gKDPyGyZkrrlNqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPo5HY63dNyLkm+LKadPncTqWlme7qI5zf0jWoL+TcvRoLF3vF62CqnzI0L13MkeZ
	 2cOIyRHb1T6l6ynUbVm5D45UgclGiBgF1GqETHyjN1Gmv4HKjLvktf3XvT3Ms7cZ28
	 SkIzIgdxHAPeSv2qbDaq/aaHeZWOEBFtr7t3PZINEFADnHcIFt4df0YJe1CpHiUCLR
	 BdOZ1d96FMS1pRbInpnhmv3H2e/Cv/VL3iSRFw0FktBbYBPhnwNWY9I/nnSfl0ieKw
	 9jiOn8/aXgWMwkm7VoFh/7q+VOJ8Sd308fXzubdCdhmBgobsukfqMU5KyTdGas2vtA
	 mSlSfoQTJlHKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	song@kernel.org,
	daniel@iogearbox.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/15] bpf: put uprobe link's path and task in release callback
Date: Mon, 15 Apr 2024 06:02:43 -0400
Message-ID: <20240415100311.3126785-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit e9c856cabefb71d47b2eeb197f72c9c88e9b45b0 ]

There is no need to delay putting either path or task to deallocation
step. It can be done right after bpf_uprobe_unregister. Between release
and dealloc, there could be still some running BPF programs, but they
don't access either task or path, only data in link->uprobes, so it is
safe to do.

On the other hand, doing path_put() in dealloc callback makes this
dealloc sleepable because path_put() itself might sleep. Which is
problematic due to the need to call uprobe's dealloc through call_rcu(),
which is what is done in the next bug fix patch. So solve the problem by
releasing these resources early.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240328052426.3042617-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7ac6c52b25ebc..45de8a4923e21 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3142,6 +3142,9 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
+	path_put(&umulti_link->path);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3149,9 +3152,6 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	if (umulti_link->task)
-		put_task_struct(umulti_link->task);
-	path_put(&umulti_link->path);
 	kvfree(umulti_link->uprobes);
 	kfree(umulti_link);
 }
-- 
2.43.0


