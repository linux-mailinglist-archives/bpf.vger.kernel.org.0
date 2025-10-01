Return-Path: <bpf+bounces-70097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A284FBB0D0A
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E2164121
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABE304BD0;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlvg7uXA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405F303C8B;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=tbsfOXySrYzRcMvjjgvEU7oTWY9a0M7Ggw3R//0zoxD//Xr4kB9lOTEx08j9S9hWZMd/r5W3ok3MePs4xDFpDKYkgY6EhvHT9SYTww1QnCLmt4FAnFtzYL0lUfdB7sZjmngm7K9cIf+RlJ7pRYwHW9zRA50jIvqRiIMH73iCBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=B7b7Gx1mcM4EGN2sMoC77cGW6QCZYuX1KTpiyMpYpx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8c9P+GO/8N08akBy/MOOjSx5LJIsh+ZhgPwTI0LsBALFNWrzGpI2b6amNKApTe7nMTK6MZQ5nte+xNLcb0CQhaq2eW3MOdq2evwgjWcQRW2Yk3yV+ntHcjNL6SwdmH2pEs0rLtdEp4403/Gz9dQ7l/QJNPygVD3qtK7++3jnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlvg7uXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD2C4CEFE;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=B7b7Gx1mcM4EGN2sMoC77cGW6QCZYuX1KTpiyMpYpx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dlvg7uXAg5rWZQQ4kDnogLgvbX+Lp0+tarH4OhgI5HhhEyZh92TTtccnO7MZW/wvS
	 vRUMu4h31lTdZzhC/Usv4YHo3KEhi6QlGuT2ALJFTHGLlkkE3td2Sx8O0xOUi5Yshr
	 MTiUdSolUxQ5JRDI70nkw2u++7rSVHA4DEKl7GeJWwsCI0LymePhEs4Irhjt/plA+m
	 9gPaPY1cKB/Xqg6FgTt9VbhbJJoHz+BB0c0km+HeRSIw7ki5pLxQ/mVuiGNbgOs25P
	 20kHq34ia3nZ0DRcXCUebnWb+jlMLLNnK/rUCfe57gric6TtxtcJqbDYdufai/8thK
	 GJAlbs4dWrYYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7AA38CE12CD; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
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
Subject: [PATCH v2 10/21] checkpatch: Deprecate rcu_read_{,un}lock_trace()
Date: Wed,  1 Oct 2025 07:48:21 -0700
Message-Id: <20251001144832.631770-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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


