Return-Path: <bpf+bounces-22915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19AA86B874
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CF41C25126
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C35E06C;
	Wed, 28 Feb 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McIgWXQL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477125E064;
	Wed, 28 Feb 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149295; cv=none; b=NDUFzgGmiIiyqWxPHRvBgamFjbNFvSHPcgwrd5UscNUiWqLGh9QHeY5J4Uh2OaS4X9V2J5XXbzNdEbI8nBGp8uSMPPH9kiOdxSuez+os6JZzifu7qW0ocZ8u4Rl4fCzu6A8anIFxbG+2N3FyvOPwQqHh8MPSjqvmtNrslZvC1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149295; c=relaxed/simple;
	bh=NPzyxwGeYXka5gn3GSClv08yHw0AIL3RUtkhYEIB4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gs/pc4xCcVuSWZSy+VAzpk8k3s+Yt0xEW8CDR8kRDn4i1SBzN41mMfQXIlEfhHq4UCC741lObyfvGVLSY6VVpT0H3fd2HdY4C7zEoxq+uAbVoyJeC11ygpLBd55c9UJ8n1VJ9xDsYj/GSdkYkbqUSH5tgXMkQ3/3JJGv/PnARpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McIgWXQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8832C433F1;
	Wed, 28 Feb 2024 19:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709149294;
	bh=NPzyxwGeYXka5gn3GSClv08yHw0AIL3RUtkhYEIB4Wg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=McIgWXQLxWsmvp/4CoIA6FzhNKEtocy6+giqblpmPudKRUvdS3pDFPbKvAAp603Ga
	 6vaPUQEPp6nxYA+EU3/lHnVCjf/l8xH/Wwgqd643QXjBWhTvCMk9i6siY+tcWW8ma0
	 t1C3usPFza3lVr5yPx4aHmAzfYjxN+SCVx0mTcAjccFHcNlQNpVQVvKyI/x73LdauJ
	 0dUFejxdx73g8UdrMStTk2mOa7Gk7Rp6rYYSjHIddwrhNsf+kC/CISd3M7AXaDvkNW
	 FA8Y0SszP/UA1eGxveBLhGq0EQ0s4N86CCFvqlYyZAvteRVCC40hWCIV0Ra0tgjcva
	 0b9KWq/TNqznw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38A90CE03F3; Wed, 28 Feb 2024 11:41:29 -0800 (PST)
Date: Wed, 28 Feb 2024 11:41:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@meta.com
Subject: [PATCH RFC bpf] Chose RCU Tasks based on TASKS_RCU rather than
 PREEMPTION
Message-ID: <847ac98b-886d-4f91-b961-2bb452555af0@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
might see the occasional preemption, and that this preemption just might
happen within a trampoline.

Therefore, update bpf_tramp_image_put() to choose call_rcu_tasks()
based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.

This change might enable further simplifications, but the goal of this
effort is to make the code safe, not necessarily optimal.

Only build tested.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <bpf@vger.kernel.org>

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d382f5ebe06c8..5085f66b33890 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -333,7 +333,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_JUMP,
 					     NULL, im->ip_epilogue);
 		WARN_ON(err);
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_TASKS_RCU))
 			call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 		else
 			percpu_ref_kill(&im->pcref);

