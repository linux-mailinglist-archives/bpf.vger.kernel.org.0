Return-Path: <bpf+bounces-40259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B39846BD
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88E028543B
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79F1A76CC;
	Tue, 24 Sep 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myk3k4tT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0341A4F16;
	Tue, 24 Sep 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184628; cv=none; b=CiFaXpuOhPvGfS54D9ZpdeBhbPGbmB+v1z7+xbX2FSOyP5D4tJOXR6a3kUEFqQ6q3SZRTP8ZjHn63DKIP0itkVDAeNs5xoq57JLaOPRRxHN9NvaPlf6wQoeFbEK2bGzQ/lXpWMZumFTkrTmIXE2H3vhjSiCz0Z+05xj0ihdmGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184628; c=relaxed/simple;
	bh=ULygnSo9N6FSEiQI0drmADzkn/pdLfT7Cqv503+L33s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaiN/Pr20VPVfLk+wJSX/zIHlVZneXBWQLjVNv10eFS8p1r1idKTWVyY0iKF9cHpFPUdbJK7xjSqyrJFgrrq3+fXE9+SO6Y2q6xg2bNB2tjdhDmodpap0Rg91vqiJdCH7asCoWY1ZkBEE8g9jqko5fekHIf3oxna0T4BoLL1B80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myk3k4tT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4B4C4CEC4;
	Tue, 24 Sep 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727184627;
	bh=ULygnSo9N6FSEiQI0drmADzkn/pdLfT7Cqv503+L33s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=myk3k4tT0LBKO3HLsOytA9XL8XYSVaZOdEAJMbH9a0gZCNJv3Bi4KQMoxy4TzPrMS
	 rHWsUbC6XC1IHmMKeADWxq+kKhkLibRESO7etqVMmfld4haMxkTn7Qm5hSfWtsVMyK
	 CyMSDrNQH6tZUvUR1w3iG37VdPcyHfPULG8/ZGG80gO/Y8TqVmFvRYjBcohjyeHkoh
	 G+3EbJKiuns6VhfVTG/SIRD090EPylsE0FDSeO3Ryr4SElYPGCMBdJYe2LkZhgXvz7
	 8wW5x2mDINxVQExVh0RSqc3TKfkvW30vAyp+msyrCkkj8qHDj8SMBPmq25U6lStXqe
	 ecS/jj/Zt2A+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715B33806655;
	Tue, 24 Sep 2024 13:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172718463027.4036037.10024447642848017933.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 13:30:30 +0000
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
In-Reply-To: <20240918140602.18644-1-jiwonaid0@gmail.com>
To: Jiwon Kim <jiwonaid0@gmail.com>
Cc: razor@blackwall.org, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Sep 2024 14:06:02 +0000 you wrote:
> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
> this[1], one bond device (bond1) has xdpdrv, which increases
> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
> To reduce unnecessary warnings and improve log management, we need to
> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
> 
> [...]

Here is the summary with links:
  - [net,v3] bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()
    https://git.kernel.org/netdev/net/c/0cbfd45fbcf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



