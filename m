Return-Path: <bpf+bounces-77483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2ECE8042
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA5E30382B6
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D82BE7B6;
	Mon, 29 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6gWU0gq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C627E077;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=P6sdDrw+bST3oNZWqj7AmowpNuXuTJZ3aYR43jq21e5NmivuP+pZiEhG5dQr5tR0jgjen1rbtPrrAMyHCsVgzBeFgN+h2JGx9nzstvX5QVQjMvr96GbEiJgOwvhmeVesyQ1XC+RiJW7Qbw1JVUEGo8JRjBM7HZohgX1gL6lWfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=am3a4f/tTp1G67zvZ8p5t5twCf+9bpA6UUdHIvr9SDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irQM3RkGi414DD3/BSUJMb5Q403ro7o6sSVPjNRhRULFuPsMq712fZ8un5fezvFU2OG1XfmBt9F1QApVlXGzkgV+YtlFgHAPyZW3V0yc9mX2PSCag2bYJ85tZ1raT5WKalmZ22h/w/a18+rg8xTALi4ixLUFoAmmexaASnlnC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6gWU0gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E622C2BCAF;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035467;
	bh=am3a4f/tTp1G67zvZ8p5t5twCf+9bpA6UUdHIvr9SDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6gWU0gqaXHs8iS6OF0/ijZeI/dlu1SZzULEc1e2hs+9YERcIhFpGckuIrroFy+xC
	 bZC+bANsXxraTtvqxlgbtXWx4mXfURFyUzl4dftonsFzToBNiz2unHSKaeK6n0tOTh
	 8lm6tgM4bFd9LTe8RTWDMsdcC2hmGuYwBZfbn+kuegj1Zl5Iy54/GrfNWX2IzjQw2W
	 ri/ei+KI8JV5UTEWdfsB4wIyhar3xAcn9crea6U7mLfqHbsx49Z7fMlp6sWHJsqIXE
	 d15RuyM+zaTcQtWy0aB3/xSO7uOCtHc3TCrpys60Dxgd7rdSs2fQCgsiWoauSB0xp5
	 bbybjIdaZ8c6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A13ACE1109; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 7/9] checkpatch: Deprecate rcu_read_{,un}lock_trace()
Date: Mon, 29 Dec 2025 11:11:02 -0800
Message-Id: <20251229191104.693447-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uses of rcu_read_lock_trace() and rcu_read_unlock_trace()
are better served by the new rcu_read_lock_tasks_trace() and
rcu_read_unlock_tasks_trace() APIs.  Therefore, mark the old APIs as
deprecated.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c0250244cf7a3..362a8d1cd3278 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -863,7 +863,9 @@ our %deprecated_apis = (
 	#These should be enough to drive away new IDR users
 	"DEFINE_IDR"				=> "DEFINE_XARRAY",
 	"idr_init"				=> "xa_init",
-	"idr_init_base"				=> "xa_init_flags"
+	"idr_init_base"				=> "xa_init_flags",
+	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
+	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1


