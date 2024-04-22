Return-Path: <bpf+bounces-27451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1698AD37B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329E21F21C8D
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F44153BFE;
	Mon, 22 Apr 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTrKQ5Jd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C91152197;
	Mon, 22 Apr 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808228; cv=none; b=GJNqh1VoTC2UmyrhBZphe0/zlfWOXAB0SDx/UZkDgx7PMMnVvgqdndHp5pGwMxObHrzyVmQVK9Bi/x+oekKweDg0iQGEks21FXg73VpF76s9f8smQJoxveBVC4wJurxpvTOseQtaUq6nwwSKE4FNrXTK8ZGcjoelOTyA5JrGmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808228; c=relaxed/simple;
	bh=eusvQ1qTeyVaZa085v5i/7OYRBK6+gCBmIqNn5rg1VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d9xXf59iPF209CUX3qXHvuBCZy2g9N1P+VR2twiMJY5oVAfXfhr6Cb1hs3P5JvZFWxmXjhMtHMDdbxz09Y4JWseYqXTbuXxFxJMyKaOupA6Vh2aV/aU/q7dsGgGSHmo71ITZJrIb48eidhPp1TPTFRoW5Iae/qk2YqrRmGMfbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTrKQ5Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3007C32781;
	Mon, 22 Apr 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713808227;
	bh=eusvQ1qTeyVaZa085v5i/7OYRBK6+gCBmIqNn5rg1VI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nTrKQ5JdfpKycMzwX9DU1M/It1z4647q7DhmY1J4q5D4tpMuQI/cddXluDxSfVyW6
	 P9ZZ2Z2qN9yG0UWmxKsPMo+uzKDwoQchtLtltXUJ+hkPs1vOlOZj1YwD++gMae7t91
	 wGz+7RwDxSy2QTCKwEtqZPVnG2YQ8iVMAYMUqhdygkbnUD3a4G5HBdKGY9Vi6Bl0qe
	 t8t+aYJi1lKeSrKfvssdqBg8F6ASPcX9+g/XEMKj0Vv6cT0I+/hLf6YyTp7VfwTl6g
	 QO8z9vi2P4owl1TIuqjm5xYlMDS8tGZDdQTTxRLcaJAyWSGEO5yM0RhuQ4NDYWX5eg
	 1QUpBMWaf+1ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D8F7C43440;
	Mon, 22 Apr 2024 17:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171380822764.15877.4346017565227383505.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 17:50:27 +0000
References: <20240418071840.156411-1-toke@redhat.com>
In-Reply-To: <20240418071840.156411-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, liuhangbin@gmail.com,
 syzbot+af9492708df9797198d6@syzkaller.appspotmail.com, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 18 Apr 2024 09:18:39 +0200 you wrote:
> When redirecting a packet using XDP, the bpf_redirect_map() helper will set
> up the redirect destination information in struct bpf_redirect_info (using
> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
> function will read this information after the XDP program returns and pass
> the frame on to the right redirect destination.
> 
> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
> bpf_redirect_info to point to the destination map to be broadcast. And
> xdp_do_redirect() reacts to the value of this map pointer to decide whether
> it's dealing with a broadcast or a single-value redirect. However, if the
> destination map is being destroyed before xdp_do_redirect() is called, the
> map pointer will be cleared out (by bpf_clear_redirect_map()) without
> waiting for any XDP programs to stop running. This causes xdp_do_redirect()
> to think that the redirect was to a single target, but the target pointer
> is also NULL (since broadcast redirects don't have a single target), so
> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
> 
> [...]

Here is the summary with links:
  - [bpf] xdp: use flags field to disambiguate broadcast redirect
    https://git.kernel.org/bpf/bpf/c/5bcf0dcbf906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



