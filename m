Return-Path: <bpf+bounces-73306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C04CAC2A470
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 103AB4EC9A6
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709529D27F;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIVZl0oM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF953299A8C;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154352; cv=none; b=DFbPcNnZZ0W99K2uTkdsmddKUfzzU37WLiuJWPG39110Wc2NkcpzLeb2RmKSLgD1rn4koQDalnVRpThrCck9fPGkqsiJdwAWlOjR5mdz1kVN0Vt0JpkvgWzHydKk6yr7hlfJoYwWsUbWBV8Zqhd93nP3fhwSl8PIhjY0dPpILqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154352; c=relaxed/simple;
	bh=updO0Qt60cves0NEScBOtRbVWMjNNxOri0JDFrV2Fxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbRIAbhVzTvdpapmGcYRnaq9qRG8WSPgj8Nq+N8bdkd/J/jfkyDn0sLGEiufmW/mtKi5MKQLPRddB/1BXN87opHd7kaXILVz9fRW9X2QEzC8jhgqnAWeHqM2ha5ypVQ1ULNBTYB93fB722pI91SpR3xbhEkM1x91VqLKSYDpTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIVZl0oM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3EBC116C6;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154352;
	bh=updO0Qt60cves0NEScBOtRbVWMjNNxOri0JDFrV2Fxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIVZl0oMMdIyNWJE59R29h1WVUaMv79Jf4uFwY/len7oVj60uaEmMRQFH0SE7G2CU
	 g7p+h8yN/7CsJkBlYx/nAqapTxUEnyDNsYzwW16EpF6FXcZuxAVx1XKwHDGTjuOxZx
	 FfozfNZY6E1CXHc6LOSIRpWh2QyERP/xZb1s1F9UrY04kS+0SMbfzHljd4bxIA5Hbx
	 VjqX3LRfL315O8LdJfcUJ5kcozW17U4T2k8v0i0lWU8KhIOAfk4zaunPg/Rkufqp7D
	 3RAsv5IZa36pfSRHOM334SgqL3p5M3t0Ch4JibNPID4NS1rPe0JVhQaFHfyVtkdYKM
	 +DOGKSDJVt74A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5F53CE19AC; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 7/9] checkpatch: Deprecate rcu_read_{,un}lock_trace()
Date: Sun,  2 Nov 2025 15:06:57 -0800
Message-Id: <20251102230659.3906740-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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
index e722dd6fa8ef..3bb7d35a5cfc 100755
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


