Return-Path: <bpf+bounces-41459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36489973ED
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A471F243E8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F941E1A2C;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqtMcOxZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD21E1029;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496847; cv=none; b=ZMzknIkVbrfTf7zS0TXhsH4U7WF6HTX0ZjwfqpnMWmatVLHjWW7CzjT51FpNB1yMrfUPeqAD0catzIZoq8TewkHKHv9riF+gcB7mGTmwjW6cuBP/w72Noz/S9sqb1lY6xSwGid5s5KxtE+PfhUbC+JaeJh+ZplRvoFFk/1lCvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496847; c=relaxed/simple;
	bh=azYSd/1FItgA8eDMglhxA/9kRsVFeYhI6Q2ye0pzl0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLooZnTusttCR+cRRPLNBw7QLGGL3oz9Mn6xKamwiCqdzxig+BnSS4DjLhZx6OnoV4KIuyGqV33JiI5kJazUZ9Y3hx5vKX0b4d8fNLJDFJ73tx3JYXoGDFogryWYQWTyKGZ/7nwPs1/bU6sGLf7LGCfbZR9Yy4NHO8L8UxiF3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqtMcOxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146B2C4CED6;
	Wed,  9 Oct 2024 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496847;
	bh=azYSd/1FItgA8eDMglhxA/9kRsVFeYhI6Q2ye0pzl0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqtMcOxZFauyLdBhGtTU6TwMB66yHev4zgKdN9z8f5K15+Wezny/IBHIWighLakQA
	 grAEeYOyWXTN6ih46N6sLeLCOSKt9D8SMDjnHD5mcrzmWYDCFHV3octz233QR92y7+
	 8vk5+r11EFt12r8F5hylIP4EQByWWBJQ/9/s9P37nu2pfjM08yGkDLvtWPYUnwZxt8
	 Na2CBHNPrPMnq7lNpbPizjZ7X+xYNiPu3xPvD4vFW7cdEnrWngFaCdOnTz2DdrsA57
	 doO6pL4vHAjo/5MOMRpuoJITb6jI94pYAKTh8Z7ucnwcPWXpAatrvhGoY0IqkjWmd6
	 Avq5+d4v8Pzdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 769F1CE10CB; Wed,  9 Oct 2024 11:00:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 6/7] doc: Remove kernel-parameters.txt entry for rcutorture.read_exit
Date: Wed,  9 Oct 2024 11:00:44 -0700
Message-Id: <20241009180045.777721-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
References: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is only ever the one read-exit task, and there is no module
parameter named rcutorture.read_exit, so remove the bogus documentation.
Instead, use rcutorture.read_exit_burst to enable/disable read-exit
race testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe223..7edc5a5ba9c98 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5412,11 +5412,6 @@
 			Set time (jiffies) between CPU-hotplug operations,
 			or zero to disable CPU-hotplug testing.
 
-	rcutorture.read_exit= [KNL]
-			Set the number of read-then-exit kthreads used
-			to test the interaction of RCU updaters and
-			task-exit processing.
-
 	rcutorture.read_exit_burst= [KNL]
 			The number of times in a given read-then-exit
 			episode that a set of read-then-exit kthreads
-- 
2.40.1


