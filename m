Return-Path: <bpf+bounces-69414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03CB963A8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1719C5249
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF62E5B1B;
	Tue, 23 Sep 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWqkTeZI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BC267729;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637303; cv=none; b=bbZfao31XNzXZRIdPDHATIfbw5xlKttgemj3Vzd7kEhFTahf/sqwBWKHVlM/a2AEnVjvXGKRfDuyyd0Q2ersE0OteohuRfQHW6ddAOk8s8EsmurOqQocWnxhz1MJU6Wd0M2bTtRUcWgmeQMhQqZuu/l4cjPpYcu8IulukfIXczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637303; c=relaxed/simple;
	bh=nj4NUdLqqgo6c9WwY9DR0wHNaXFdGzVpfYVSNHOxwxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAINGsYjokvMLCnf1cjRAK3KoPEGniz+YJ6+CMXrR2R2nOoZgGvhQ8v/Y2IN62pX4ZSDNmpbacgSY5+1uT+ow8BgGGI+s3pye0L0xo8tbCH/rglVFTseTFy6x0O3h9EUt2kucms2Qs/GyRSSqf3sJzRUb/dQtfcMfTK9J1MjQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWqkTeZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB22DC19422;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=nj4NUdLqqgo6c9WwY9DR0wHNaXFdGzVpfYVSNHOxwxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWqkTeZI6PpwDPOCkx4bznJ/JVPtzc/R2z1wVVn4YiU+L6I/UtskUUrc8GwuZw3ws
	 iu6lkC0drEptZoDCc0x3rZBN8ABjiEXwzi4dQoKhcdKjMvkywdg3Ury/+TkbwwYSIX
	 7bVQN5y5mFZ737HQXxbjLUSdSgy2HfPQs/ULPb5WXwpHH2eF0d9JmBxdqS+UcvkRN3
	 IIitf5CVSaErbmh6WU13s4YX6l+5EV4shXSjFsKojQgyXcNsnezmOm/ojj79358Qwq
	 keabPrYtr6jeZ5kxfH0c04nDQpGjuk8ZD9Jv3ItJncFYmmg8oCoFMu3Ree931kA47+
	 Z2hlwUms8aiRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EAD94CE15CE; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 20/34] checkpatch: Deprecate rcu_read_{,un}lock_trace()
Date: Tue, 23 Sep 2025 07:20:22 -0700
Message-Id: <20250923142036.112290-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
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
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef3d..3bb7d35a5cfcba 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -860,6 +860,8 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"rcu_read_lock_trace"			=> "rcu_read_lock_tasks_trace",
+	"rcu_read_unlock_trace"			=> "rcu_read_unlock_tasks_trace",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1


