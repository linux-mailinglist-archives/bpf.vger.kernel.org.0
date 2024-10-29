Return-Path: <bpf+bounces-43346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440709B3F27
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09068283E66
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 00:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A45DF78;
	Tue, 29 Oct 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaWpKPPu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18448B664;
	Tue, 29 Oct 2024 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161513; cv=none; b=KkFbYlFQJ6q703zLP4F/+1BeH3oulTlBclk266jeG1n9EqmO6/KsaRqC3KDKN0ncxDcCdPJtwCpOF9Jge+zpxftzOzvqT1/XYtQYOQ9fsonwaEhlIdZBvm061pF2n1cgRBy9Lg8wM80kV188gW81cPKpUurrecV3hdQW5vyhmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161513; c=relaxed/simple;
	bh=/Tjxq/NKVAGeYhr8hhPzIgNsqR+DMX+UpHS/JeUS2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNd0ufZ8PLo6Wv/u5m+dXMedZSIqIYi/YIIfxYO2K2WRKEYnoNcdf45yiaJ0Ob22SynVTk/BZWNovFAYspo8fnehZn53Jk+GhcxAVYE0XZzSR42AXrpEFoeYBs+aTts3fUJcfunERzacI19iA+6xUGz94IDnuE30IHMfa/alh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaWpKPPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08DCC4CEC3;
	Tue, 29 Oct 2024 00:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730161512;
	bh=/Tjxq/NKVAGeYhr8hhPzIgNsqR+DMX+UpHS/JeUS2Fw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JaWpKPPuPIQGsiJB71o48pTADOP1XkYsaIScS8GYsYY5UUISs2CEFjJYHrUQ22OpH
	 b67gxCNvAgJXeoe9jBVek8lZCgs8sZmCSZRxTmB1kGrEtyw6nSkiIb1cVl6r/MRtfg
	 KNqmPYKAIw+0/yIsYXBtJLIDFm17qhBALKGgZxFZDqd23VDa9dYzUlMoFLktzN1V6R
	 4nIVznY7PpAnUbLLEpYHkBxynofNZImTVrIeKZWR8ovZtIbwFsuCbRwJDh1ov+Udan
	 pnBx8JHrsRn+YZzae0tPB52vDqQ/YaaJIcrWam0b1gTcaFmbDyfZ726XDx+DtIaaEx
	 saF7inQalAFag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50A46CE0864; Mon, 28 Oct 2024 17:25:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:25:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH rcu v4 14/15] refscale: Add srcu_read_lock_lite() support
 using "srcu-lite"
Message-ID: <6a9cf878-e08a-498d-857a-a9fd4bfd6c12@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-14-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015161112.442758-14-paulmck@kernel.org>

This commit creates a new srcu-lite option for the refscale.scale_type
module parameter that selects srcu_read_lock_lite() and
srcu_read_unlock_lite().

[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f2..338e7c5ac44a1 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -212,6 +212,36 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static void srcu_lite_ref_scale_read_section(const int nloops)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		srcu_read_unlock_lite(srcu_ctlp, idx);
+	}
+}
+
+static void srcu_lite_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_lite(srcu_ctlp, idx);
+	}
+}
+
+static const struct ref_scale_ops srcu_lite_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_lite_ref_scale_read_section,
+	.delaysection	= srcu_lite_ref_scale_delay_section,
+	.name		= "srcu-lite"
+};
+
 #ifdef CONFIG_TASKS_RCU
 
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
@@ -1082,9 +1112,10 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
-		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&clock_ops, &jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops,
+		&typesafe_seqlock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))

