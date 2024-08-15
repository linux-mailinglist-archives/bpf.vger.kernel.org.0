Return-Path: <bpf+bounces-37259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94234952CA2
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 12:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B64D2823AA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A71BBBFA;
	Thu, 15 Aug 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9C2FYVn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5417A5BE;
	Thu, 15 Aug 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717232; cv=none; b=uQrEMi7Otgh7nihGyf09NXfllBIV9QkJ33XvykEd0HKnxWAYZE01bJFfJ4e5O9R8DT52b3NlHPw37MmT6l08ll21Esvv+C9XdtgYUE2aDGImvcD9DLDD37fhlMHWwlIAM5fM0jAMHpy58gZgWUkOy/UkS6ls5tyLZuRz3JbCKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717232; c=relaxed/simple;
	bh=g/zdg0zQkNI6e0xcHGogI2xvBrYAdBYo14fPTcT6vMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u8Y6oEiJmmOraCeJw23VbrmoxsBP3RbPO/DLNXieQST/GprolF37f+IYLnjT94hZ8BnW8uuWUQzwnvs3gFLQIZjSPKR+ievQL5gK0NJ5wNpq9eRGNy5oiFFYu2fEtmVCDFaA+wx4RLfwrKrUMwhp1G6wYGE2sqtgxScCGzTObio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9C2FYVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82802C32786;
	Thu, 15 Aug 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723717230;
	bh=g/zdg0zQkNI6e0xcHGogI2xvBrYAdBYo14fPTcT6vMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X9C2FYVnh0CdzP6kxXsqg9Ul9noJC4Z6hkwbZIGwOAZs7EE6E5UWA0HVMwBJ3ehKT
	 nJ7OhQg9H0N39aPSyqbuoQsoHXSrjGbzw2fsAfOmOxmBFewY+pkG9Ce6OBpScM7Zic
	 DgPovFk4BVH03vj63aArOR/Ur5Jki9CzF35ds3Ka6SnORq9KK/iBWerOnbtZ6MggyN
	 V2SM2nEc6tgax0A6klifPDNfNih8ASjMxxNDY5vAwxClQ71NMbxfI9nNrAwUrUG/NO
	 j1f6z+QzVSnayQmpCKZRLy2ofiMfh/UZIldDo/VMd+981YVCLmF41UqzrPFSB0GMX7
	 gq7C50+BFnpRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB85E382327A;
	Thu, 15 Aug 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net] vsock: fix recursive ->recvmsg calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172371722975.2812387.12170002867287928955.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 10:20:29 +0000
References: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, cong.wang@bytedance.com,
 syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com,
 bobby.eshleman@bytedance.com, mst@redhat.com, sgarzare@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 11 Aug 2024 19:21:53 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After a vsock socket has been added to a BPF sockmap, its prot->recvmsg
> has been replaced with vsock_bpf_recvmsg(). Thus the following
> recursiion could happen:
> 
> vsock_bpf_recvmsg()
>  -> __vsock_recvmsg()
>   -> vsock_connectible_recvmsg()
>    -> prot->recvmsg()
>     -> vsock_bpf_recvmsg() again
> 
> [...]

Here is the summary with links:
  - [net] vsock: fix recursive ->recvmsg calls
    https://git.kernel.org/netdev/net/c/69139d2919dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



