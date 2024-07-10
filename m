Return-Path: <bpf+bounces-34414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1E92D732
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A5B1C2243D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCA1922E3;
	Wed, 10 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfk5E46K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14E1946DE;
	Wed, 10 Jul 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631432; cv=none; b=oGn/9388R92YcsBFGQFg/7aALCYmgGbN3BpBoZ07gEC9pUgkCml8i8i6FPyXg26QNbiWAOpA71grB7+kD9ldcRXHytP/rrqkWiMzizRV+QS9s08HXsi53g0wbGsVOTgs6ydU+LIcykWvrp/bjsHRmB2taFfRnjZJMAtyzuFR5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631432; c=relaxed/simple;
	bh=Xu4+M3G64FIzVDig1Z9pDCa4msV18et3mszNDByFIew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2my+XzdWHC9dD1rBnO0w4/1tE4VMxIVOAUx8tkdHswOEWday7qFAcj+q3Zc8ZKI2+xP2Rlj3tT1IsKSBHHaKE51vGJpgaOzF8CkcwRaRCu9l4WySDgUdbrdZvajio/QlGMxlplKvYYYQdbq+wSe9sT6kb+SKCN1dSF0aebt0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfk5E46K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEC2DC4AF07;
	Wed, 10 Jul 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720631431;
	bh=Xu4+M3G64FIzVDig1Z9pDCa4msV18et3mszNDByFIew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kfk5E46KuNOaMGYC+/EDr5//NuqsVGj4HKXsNBYVA6fyNNM2Eyy0YVQR1YPD3gSCk
	 2gttbxoO8ABYfCkg6LV7b68DBDXWjaarpF+ntaffevTwBDmsadPxwurpKzV0oeKcdm
	 h3Qb4SAKa7FkFauFvcIrgPo30QxwbvVXoTStkbAf6bJGxlqjMhBUPRj+cMRwWQr/7r
	 GJbv3BA/VI9Ic88VRCU6E71BxGNIDhj6UtFegECKcAQTB5ygFIVZhM3O+nbuC7DId5
	 EaS7l/yc3sU49upgnngYJbbcu0SQWVAxNYvbST9QzCh2lBbdBMG8qTUZ2ycMOEy852
	 aW20rrfyBSPJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA41DDAE95B;
	Wed, 10 Jul 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove tst_run from lwt_seg6local_prog_ops.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172063143182.19190.6752940637516779571.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 17:10:31 +0000
References: <20240710141631.FbmHcQaX@linutronix.de>
In-Reply-To: <20240710141631.FbmHcQaX@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: martin.lau@linux.dev,
 syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, tglx@linutronix.de, m.xhonneux@gmail.com,
 dlebrun@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 10 Jul 2024 16:16:31 +0200 you wrote:
> The syzbot reported that the lwt_seg6 related BPF ops can be invoked
> via bpf_test_run() without without entering input_action_end_bpf()
> first.
> 
> Martin KaFai Lau said that self test for BPF_PROG_TYPE_LWT_SEG6LOCAL
> probably didn't work since it was introduced in commit 04d4b274e2a
> ("ipv6: sr: Add seg6local action End.BPF"). The reason is that the
> per-CPU variable seg6_bpf_srh_states::srh is never assigned in the self
> test case but each BPF function expects it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove tst_run from lwt_seg6local_prog_ops.
    https://git.kernel.org/bpf/bpf-next/c/c13fda93aca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



