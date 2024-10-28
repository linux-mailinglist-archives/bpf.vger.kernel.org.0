Return-Path: <bpf+bounces-43340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1049B3E59
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 00:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F285283471
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C51F76B2;
	Mon, 28 Oct 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+zHLWt7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B318FC83;
	Mon, 28 Oct 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157625; cv=none; b=RiXkUNzTyVhE3edscj93H+5JvWuLfqC6XOxz7Jaepsd8x0ehqpNA4mzEZHtnqSADGSRFbt739rCKTKCp62K396R8NSrkoNERPR5aZLxjT0j/4FuHlUFCg6QehTAePdELcR3W82FxDfscbzybmm7REBtZx8R/N1kYotDZtILtLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157625; c=relaxed/simple;
	bh=Tde3yplX/35Zf8PAWxjRShS8odG7y676cVMjRuH6VLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/SrqbKD9KpnayQJUTaeu+ZYxgvi3weWbWQLr69wT+wjqtKRur+wv6T6poMQibBSTrQJ4uRbbi3UUV6u5nwA1oaUickHgx+IISjRFGDSV9Fl5mt8KKc/9j5rkJcmTgn/JqbHo/o2eW/JZwFH33MBZtAjGcISGrjveN+Tx2tWjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+zHLWt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E727C4CEC3;
	Mon, 28 Oct 2024 23:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730157624;
	bh=Tde3yplX/35Zf8PAWxjRShS8odG7y676cVMjRuH6VLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g+zHLWt7RqPOhhg10Q6nGDqjsg/5qZNWzYZFjiORxccyHup1yE1dVj1g933xfcfeF
	 +uZlWOIPHKbLhMhLngaBF7W+Vn8OGyi9uBN6khXKXJPKcIM+3JjpVFNHLYj2YeJmtT
	 U1gEoN8WaZn/Di1V/DvhWORDM5mgaWBj+069fNqHYlmje3/FKRVcKCMWHF6WlWc382
	 j7o+zedOrPE2xozYUt72trkKeXBg2ZdoEPkney2kvbd9rRdwLrRPN1+emmJa3eKyXV
	 bFmlvHuhmkYzlsp7jJsqIONlgj+6EvJPUmFDsI46vkmAMNIe/3JPak0BuWmaFAxX5n
	 DqjLw7A9sA3XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D66380AC1C;
	Mon, 28 Oct 2024 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next 0/2] Bonding: returns detailed error about XDP
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015763201.210329.16112928259951489548.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:20:32 +0000
References: <20241021031211.814-1-liuhangbin@gmail.com>
In-Reply-To: <20241021031211.814-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, andriin@fb.com, joamaki@gmail.com,
 jv@jvosburgh.net, andy@greyhouse.net, corbet@lwn.net, andrew+netdev@lunn.ch,
 razor@blackwall.org, toke@redhat.com, horms@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 03:12:09 +0000 you wrote:
> Based on discussion[1], this patch set returns detailed error about XDP
> failures. And update bonding document about XDP supports.
> 
> v3: drop patch that modified the return value (Toke Høiland-Jørgensen)
>     drop the sentence that repeat title (Nikolay Aleksandrov)
> v2: update the title in the doc (Nikolay Aleksandrov)
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net-next,1/2] bonding: return detailed error when loading native XDP fails
    https://git.kernel.org/netdev/net-next/c/22ccb684c1ca
  - [PATCHv3,net-next,2/2] Documentation: bonding: add XDP support explanation
    https://git.kernel.org/netdev/net-next/c/9f59eccd9dd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



