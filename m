Return-Path: <bpf+bounces-57719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA63AAF0AD
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69944C80EE
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D561A5B93;
	Thu,  8 May 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5hvKBjA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C204B1E6F
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668406; cv=none; b=NiWqRS1Ls4WRDADaz0mRuRB5ETK2K9HVJxfMPBpFuvxhQfnm+xfwR2Rz+ievREQPTC5WTqz8sbsgwv2dKDiDL36GlQgig4MZJXG+2sRCEeIy/ETJwZqueYnSZASADoHFC9IPlB3PWlUbZIxnY6YhdAJ94lwh4UnpnJYPGjbZf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668406; c=relaxed/simple;
	bh=KRgPOEb3fH3DzHcSA5uZQJ5Tk9UMiIqCLgcS0Tg5vV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mm8Se38czwqy4krtH7zcPL0RNDAZCw8xagCC3v887OyKjg9MExPbupycMqf5JA0/g8ULq4bShGItqjWmywbjxddq/qt12lH5W3mAYJ6kY085ZMEZDBt+or0mbRt47AIdeKF2sNGtanlg0ddGY0Bd+oy2hxBQKdpyY+UqVoBLS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5hvKBjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C00CC4CEE2;
	Thu,  8 May 2025 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746668406;
	bh=KRgPOEb3fH3DzHcSA5uZQJ5Tk9UMiIqCLgcS0Tg5vV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L5hvKBjAeRasUfKbmwZMltCpe0VTwjf2wyodWnPxsR6uULqjt4QG5p02hSkkQz9vg
	 NU5SVsR+xf/oD+nIinTfuRfPqzQ/i5x/nfMy7eqyJoJNOZKCr5jMd627agyzDR+rsG
	 z7XDzE/BBr6tCrq7wByxCrbwNlI8vlzLuCWH/5Rn/kgrqBdQ9tjO5CuNbTkMAGNkk7
	 ncQ4WlPgUbQyQxIQl8woqpKyXfR2LNPp/dvigaaqu+VkL7UOSs6nHr24Fx0l6Kj0D+
	 TR3MD5MJ8bkyrkJ+ocokFyBBfd3cue3qatNjizY5eA+c0b1YbsvHYZW2i+fMpJllK0
	 MD6ZmRJxXZMnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF7380AA70;
	Thu,  8 May 2025 01:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Scrub packet on bpf_redirect_peer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666844500.2418694.3924867515434420953.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:40:45 +0000
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
In-Reply-To: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 May 2025 21:58:04 +0200 you wrote:
> When bpf_redirect_peer is used to redirect packets to a device in
> another network namespace, the skb isn't scrubbed. That can lead skb
> information from one namespace to be "misused" in another namespace.
> 
> As one example, this is causing Cilium to drop traffic when using
> bpf_redirect_peer to redirect packets that just went through IPsec
> decryption to a container namespace. The following pwru trace shows (1)
> the packet path from the host's XFRM layer to the container's XFRM
> layer where it's dropped and (2) the number of active skb extensions at
> each function.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Scrub packet on bpf_redirect_peer
    https://git.kernel.org/netdev/net/c/c43272299488
  - [bpf,v2,2/2] bpf: Clarify handling of mark and tstamp by redirect_peer
    https://git.kernel.org/netdev/net/c/f5c79ffdc250

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



