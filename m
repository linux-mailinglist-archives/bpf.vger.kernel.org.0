Return-Path: <bpf+bounces-22540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E68607A4
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874C71F22FE3
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B54C8C;
	Fri, 23 Feb 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrrUXwLj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9461387;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647989; cv=none; b=Z9cS/e9F1U4DiGvGLiopA4FFV++0zeXV2cUtyklgaqu/7HD160PnN6HhvabB9l+slWARNK172OU5ErDX7vpUhA7G4VubVR3q1a/ArR9P2F+7aR9xqKhdZzES3wdIZ/aZYQH7pjIrbjn2bRCZMnIY1KTg2gwwYXYCoKpzfYZyt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647989; c=relaxed/simple;
	bh=7rZzzwXD4Z2+E6P0fKAU3ZQs833j/2iAWSnMfUO5kvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dsbWBXCb2rZOJnEXgPMiRQH8DB7lLCe1fyhNZHm46rZIinDCtYkPs64Y4oxImUcyuM7Pgtd2jMAyXukDeNlmpZ/gSPPBg3N7tlvL9TDGizM51aW0thOjaJ9QYusUt5NbNLaS3wrgjXGyVmYp8FN9jMkiD5ohvVVfRHRMBw51bBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrrUXwLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5769CC43394;
	Fri, 23 Feb 2024 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647989;
	bh=7rZzzwXD4Z2+E6P0fKAU3ZQs833j/2iAWSnMfUO5kvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrrUXwLjZvHoy6CLd4OlO+2bIHZDqW3lS4qoaGNvh0rMHe0KzwvmECCl28rabN4qV
	 sEhxC74EE6d7XdFPrtDDS9npsDp1XYj066IuUm9lsiAVT72sr3/LxfbF9cipwkgyZs
	 tFtwFpPOgLWaaIYrJt+BOLssM9lwaO5+V0HsMls4/9TCa4iTTL4aRLHZ6QsXGo3FEg
	 yAQeeUItjfOXYa7q0/+mdCydHGmlIv7dhqdbL7e3+G5ezYthBN1t8yylM8KJZj+eef
	 LNEsBwapBlgdJmQj7yTdbKzBeyPRpCL4UGXhP+MAFX4HDJxoQbp+oUMpjdLzPbkJSN
	 AB0JM/mtmp0mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EFF9ECE0CC1; Thu, 22 Feb 2024 16:26:28 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 2/4] bpf: Select new NEED_TASKS_RCU Kconfig option
Date: Thu, 22 Feb 2024 16:26:25 -0800
Message-Id: <20240223002627.1987886-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
References: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
A new NEED_TASKS_RCU Kconfig option has been created to allow this
enablement logic to be in one place in kernel/rcu/Kconfig.

Therefore, make BPF select the new NEED_TASKS_RCU Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff930065..ce9fbc3b27ecf 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -27,7 +27,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
-- 
2.40.1


