Return-Path: <bpf+bounces-21274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72484AD47
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089CF2862D8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A374E02;
	Tue,  6 Feb 2024 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt9geo6c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B42745D1;
	Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192627; cv=none; b=IzVwSSc2aaXiZFrf5EjHr9wYIOpqhj1rul3p7TB502IWh+7MXDx2j/e+FAcVzzFiVMmCCwZXAeG4aIuOV9YIGGiwkuYxhQL7bd5DxhgXPfUbtqiEfuAm7GzzutdwQjLzHGt3fusb4VD5oqDv7RHYf55xDpBGE0jljPXZkzarU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192627; c=relaxed/simple;
	bh=432o2YUXZqvZbioLyWUS52rmQGlqiywkJd986A6NDtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FEysJ9+bLqggMmJQd89dNmnPtIwus5+fajnQ3d2D1TskFyEerT5T1Ux8bUWc0e34u6QggA1ACDe93oPD3sak/1ZQnn2v734TBSRQnuXj2xtqghGNbwckTsIo7xzBuPUulJ3NNlTZCUN8dYwLjeZMVaT9KjnwecOMOEG4XQNa6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt9geo6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B3A4C43394;
	Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707192626;
	bh=432o2YUXZqvZbioLyWUS52rmQGlqiywkJd986A6NDtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rt9geo6cj721kOEZxAhresV7+pjx89BQNjlLPkD59wCpBJzX77qOCtjvBRcgMOZYt
	 NONTi6dRsgsiOH4EA7HoOh52XQmpQCnVvykHbcps4tc7XZB9Pvdf7oBf8iasLHMD5U
	 wJ2A2KeelFBQplcAHSq+EW0xgALdAUYidfJi5cZyK9ynwpvkX85rZbQBr5no4flEdo
	 tz2JflL2SlX/1ERA2WzpcdJ/0GNxSWMZNiBh9qAZzH1cLPusAZtA4iqylx7HSggfEo
	 PFJy4L05U+/1IEBRhWI/E8hZ/lNVQqerxVsSX63orxXEzlBFpH+T65nETK5oWV9gvD
	 4rrNcCcYK8cvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 550AAE2F2ED;
	Tue,  6 Feb 2024 04:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] xsk: support redirect to any socket bound to the
 same umem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170719262634.31872.11192144503118658406.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 04:10:26 +0000
References: <20240205123553.22180-1-magnus.karlsson@gmail.com>
In-Reply-To: <20240205123553.22180-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 yuvale@radware.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Feb 2024 13:35:49 +0100 you wrote:
> This patch set adds support for directing a packet to any socket bound
> to the same umem. This makes it possible to use the XDP program to
> select what socket the packet should be received on. The user can
> populate the XSKMAP with various sockets and as long as they share the
> same umem, the XDP program can pick any one of them.
> 
> The implementation is straight-forward. Instead of testing that the
> incoming packet is targeting the same device and queue id as the
> socket is bound to, just check that the umem the packet was received
> on is the same as the socket we want it to be received on. This
> guarantees that the redirect is legal as it is already in the correct
> umem.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] xsk: support redirect to any socket bound to the same umem
    https://git.kernel.org/bpf/bpf-next/c/2863d665ea41
  - [bpf-next,2/2] xsk: document ability to redirect to any socket bound to the same umem
    https://git.kernel.org/bpf/bpf-next/c/968595a93669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



