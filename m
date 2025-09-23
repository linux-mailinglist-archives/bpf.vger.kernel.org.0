Return-Path: <bpf+bounces-69434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A5B9646C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5097D188456E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181532D5C1;
	Tue, 23 Sep 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI1FhNaC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B45251791;
	Tue, 23 Sep 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637325; cv=none; b=S+xRzUO2IFpAvWvIIiAh9g5++zS5HUGbPCKBi6BtgBCFKMPh+aS4yUGeksWy/f8QqNRchoZnbcoltgy64GwK/jVdGHtLcBiFbOUAV/Y+/ezMxFWtHa0zL1pPp2fIvIJuwLTVfztrbBFamEIDuH1uKJ5unytuCVWYc3pRTNNnREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637325; c=relaxed/simple;
	bh=/9ihPRofiSX+oBfCmJpcNKAf4WsfpDFWiCi2HWwyMDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2cllku6hJ5MMxZHoaMeksYPSU7xy6ZKmRqJD05xXUzwzB+e68vhQEb06EKRZ3TmvaBDIftRB5EdSCWaw7xIs5xaN9Fk1R6lYTSBuJ0clocWWcbJwvFsEws4oFJv9hYVa2wsa1Wy4kpGVqPwY9DUgpHIQ8ZSYht4+dQWnP2DB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI1FhNaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79E1C116C6;
	Tue, 23 Sep 2025 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637324;
	bh=/9ihPRofiSX+oBfCmJpcNKAf4WsfpDFWiCi2HWwyMDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kI1FhNaCOg3rQqc/Vkz+IMTFsm+YnYuQHpsjLc4gN0jB/p40ijLyyJdRORo3YXiRD
	 /q0hrBoBddaB/VoZIMTYubFS0r+eSqVHjDV7c61wtZrmGMDiR0c82rKQ4kIaQxpAUJ
	 s70HwmmQ0kcDEsaismPnRf7SszVk0skEmreJWyGFVzGksAp8oOCKrWtTplv9zOWsXF
	 /VbkkBR5KETt9iv9Ti6eN8IKQxhxJ0CGODpx8ivLkc+PSOm3xbd6+oF5Tw14XFJyyd
	 qUddy2TAKMCN5+U1RAGATW8bBep++ISLDIFhP5HrM1Y56l8Wu5hirTBTqPMOM9CNf+
	 FWo+SIfflWgFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F626CE1775; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 29/34] srcu: Make grace-period determination use ssp->srcu_reader_flavor
Date: Tue, 23 Sep 2025 07:20:31 -0700
Message-Id: <20250923142036.112290-29-paulmck@kernel.org>
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

This commit causes the srcu_readers_unlock_idx() function to take the
srcu_struct structure's ->srcu_reader_flavor field into account.  This
ensures that structures defined via DEFINE_SRCU_FAST( or initialized via
init_srcu_struct_fast() have their grace periods use synchronize_srcu()
or synchronize_srcu_expedited() instead of smp_mb(), even before the
first SRCU reader has been entered.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 177f9ec1f926e1..8a871976c37dfe 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -490,7 +490,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
 {
 	int cpu;
-	unsigned long mask = 0;
+	unsigned long mask = ssp->srcu_reader_flavor;
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.1


