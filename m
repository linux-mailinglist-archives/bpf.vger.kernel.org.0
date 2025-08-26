Return-Path: <bpf+bounces-66505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B328AB35373
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD2A7A64DD
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC222EFD89;
	Tue, 26 Aug 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCLb5Lgo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25580226CFD;
	Tue, 26 Aug 2025 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186808; cv=none; b=lGaB6DveRjatVAQGp9Nlti7XfQYdBYpTqzrynGVz+n7qXMDpFsrm8bS61P91vIyRaZITUlWfNDbzX9u0e49HXEZcSnp13Sqx78PsCDTDaO3v70ZH4N9Gu25NFgtq5swt/arhh6KjGfiGO3/f+FaOtf74i1CJS2wNy0/Tu5oS/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186808; c=relaxed/simple;
	bh=V7haGWXGYxuDHQzykH2Qfa3866AAjU/I6C4sFCOcY8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6l85Th//LHLtRZSLZrd3g6QTr+TaKaNqDijaCee3x6027nN2jJ7DY98nK7RO2rmF2VEsYuaiFNLNWPECwmMFu74+h7ZIQKr18Whz1SL5AeCBcY1Wb9FbotSSZYZNDw8RIa/VxbcbUa3xLUYscfRJCDqlGnQI1/2vpd5LwKUWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCLb5Lgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EF2C4CEF1;
	Tue, 26 Aug 2025 05:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756186806;
	bh=V7haGWXGYxuDHQzykH2Qfa3866AAjU/I6C4sFCOcY8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCLb5LgoyGv7/cQj52C0b10RNHeEK5O2Ut103GdaASmZanYZw8jcA9HPJm+ePadvg
	 stwyZMDp+q2oYtatFQS8Zj7MsGrAhVuKfxH+/z9JtNvpTqZ0gwOV3cX4GtHVuTt8RR
	 tcYppuAXc0VZtIS4PWH06Cbb4cnxH2LBFXINb02WtfbdKj6w810P01nd/KEsLJSt1S
	 xd6ajz72LIVDnF7UQC0GjRieq3muZNlsR2pqpIi5xVyiVoooer5QxK2X4/Ep6H+BuK
	 dFTmWvyNpI8mJC6NeCfK/2ERmz2xRPA9JsE1eKFtNFqPndINIGkzzKv6gaFVCwnikb
	 oMAFtZ/qhb8jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF1383BF70;
	Tue, 26 Aug 2025 05:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] bpf: introduce and use
 rcu_read_lock_dont_migrate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175618681450.3665841.12074652835342270974.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 05:40:14 +0000
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250821090609.42508-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 Aug 2025 17:06:02 +0800 you wrote:
> migrate_disable() and rcu_read_lock() are used to together in many case in
> bpf. However, when PREEMPT_RCU is not enabled, rcu_read_lock() will
> disable preemption, which indicate migrate_disable(), so we don't need to
> call it in this case.
> 
> In this series, we introduce rcu_read_lock_dont_migrate and
> rcu_read_unlock_migrate, which will call migrate_disable and
> migrate_enable only when PREEMPT_RCU enabled. And use
> rcu_read_lock_dont_migrate in bpf subsystem.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] rcu: add rcu_read_lock_dont_migrate()
    https://git.kernel.org/bpf/bpf-next/c/1b93c03fb319
  - [bpf-next,v3,2/7] bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
    https://git.kernel.org/bpf/bpf-next/c/8c0afc7c9c11
  - [bpf-next,v3,3/7] bpf: use rcu_read_lock_dont_migrate() for bpf_inode_storage_free()
    https://git.kernel.org/bpf/bpf-next/c/f2fa9b906911
  - [bpf-next,v3,4/7] bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
    https://git.kernel.org/bpf/bpf-next/c/68748f0397a3
  - [bpf-next,v3,5/7] bpf: use rcu_read_lock_dont_migrate() for bpf_task_storage_free()
    https://git.kernel.org/bpf/bpf-next/c/cf4303b70dfa
  - [bpf-next,v3,6/7] bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
    https://git.kernel.org/bpf/bpf-next/c/427a36bb5504
  - [bpf-next,v3,7/7] bpf: use rcu_read_lock_dont_migrate() for trampoline.c
    https://git.kernel.org/bpf/bpf-next/c/8e4f0b1ebcf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



