Return-Path: <bpf+bounces-26776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634D8A4FDE
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CB12843F3
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2584FB1;
	Mon, 15 Apr 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbp6IM9f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C284E1A;
	Mon, 15 Apr 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185398; cv=none; b=YirF4EN7c8wN79lWYTWcBLiXiWYiKk31DhTJFHwUR6pN20wa527qNYHUttxOqpvMeRhQYZJu57xhUaAU2JLeSH6r+ZTdzr8bW96+AvrpnJ8d7OobtpuPyNEY6nmc5YEDNwFyH2FTDS20Q0mdVUcFYvBYeiqTLKNnWyS/VRyDWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185398; c=relaxed/simple;
	bh=easHeh5Xj7DUyBr60hryDikkSrsUrXbwTd6D7KguFQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC7QpOzCY6voFSwfGUdz5p4OkyGvvio1yWrK8QYjK6/a8oV4LxLX0YGfX0ao52DVBnSDKQZ6YDpu2X1aYgqT7vWvIKjmvqjMZMhYsiAEfL8loQcc2hR5oaYSvk9Itj9Inf3IkGhLLCIie260a/96k32I0pFd5eJf5N01vRaP6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbp6IM9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AF2C4AF0A;
	Mon, 15 Apr 2024 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185397;
	bh=easHeh5Xj7DUyBr60hryDikkSrsUrXbwTd6D7KguFQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mbp6IM9fj5anM+C+B+7OjAI2x7k5zUxxBJGB0mnEjotFRZm5xEFzLH7suv8JK3JEA
	 /vW5Gjdwx3bgjDdRsTGrX04Q3yQExa8s9ANdUIjMNKr1Y+reaRG4V6eSm5EFw+lr0+
	 l6bzKdscZt1ZXsYmtIrQ5omqdnh8KiGQlZ3XFyDL2wAup2D9yXXNYXqlbPyWlQRIfX
	 mWPy9sM5ENfSOPRy3p/OJJM2lcIFG2AKpAf8SMs/1Yp7iKVvvaZ5P6IEGoG7ZtLISo
	 n65tAo2nS69TlnQDURp7BCHkc0ygnyjhMrG2ce2q8z1utwCN0bnwq3tUUc3QSlDaJ+
	 dcS3kus6UAx+w==
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
Subject: [PATCH AUTOSEL 6.6 03/12] bpf: put uprobe link's path and task in release callback
Date: Mon, 15 Apr 2024 06:03:38 -0400
Message-ID: <20240415100358.3127162-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
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
index 1d76f3b014aee..4d49a9f47e688 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3065,6 +3065,9 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
+	path_put(&umulti_link->path);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3072,9 +3075,6 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
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


