Return-Path: <bpf+bounces-56480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CEFA97D2A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0443BE0BF
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B68265604;
	Wed, 23 Apr 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVX0LHI/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B7264A97;
	Wed, 23 Apr 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377795; cv=none; b=DFC4z8BnBCgD7ZQa62OonNwyDeycejY2FsQ6fGepRY9xsSzkKfE52MItomait/CPeTGTcIaY6FmmiZslcYbBG5bjEZvdo7aYnIqJfhbgQPE3/NsZfbfCWcx/CgxOuJsphVqCTihoN2glKs/A3GCfIIiLFyKSStiNrw+iLPkKuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377795; c=relaxed/simple;
	bh=YFou7kr1T/EfKSVIgqwV51geoeT84J89WJpefwYE6z8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IT3ZukMYc0MANnTeDAgIT7Ab04xvd854iYN1/W4IR1c3HDLyd1Wr466m6DYc38BEg5koXfaxyFC6kFlhKBxlBVPEvuXfuu0WfHzKpvs/V7ATF5GZKbrbQDgeMeI6riG9OBG0uPjqcOGlDB7ZKK81UW9BqAUgMdcXbVR0Tcj2YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVX0LHI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0707BC4CEEC;
	Wed, 23 Apr 2025 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745377795;
	bh=YFou7kr1T/EfKSVIgqwV51geoeT84J89WJpefwYE6z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hVX0LHI/ExDVvjdxR3eVpIc+kjG5O765Q68fowHE59T8Jy08yahXQJW7ZJYpE808X
	 mJQkrTOrRBlYH3mrp5mkiyBenS+dhF+3AtBkliFv4RgXrBPsKaUG/JCvrsmTCR3tLh
	 vWiuZgip5FihPNtGUs8eYVOcvwePNo9wMlcoROki6JSZ/w8SYQrjH3pnfST+0Aj0S/
	 sCu43Brn8SFuOlSalFnYbtwhjE27RQy5ofRUvW2xLysEX6BZ3dbuCWDb75OmQF6XcE
	 zqz7BUbEPs1s0Yi+azIDXRHmVj5uNjt333D0jEzxq3JfWDTEh3sAiU360/osqgi90t
	 BJQTTGcBmjZVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCB380CEF4;
	Wed, 23 Apr 2025 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] xdp: create locked/unlocked instances of xdp
 redirect target setters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537783324.2126900.9923938841011183319.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 03:10:33 +0000
References: <20250422011643.3509287-1-joshwash@google.com>
In-Reply-To: <20250422011643.3509287-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, almasrymina@google.com,
 willemb@google.com, hramamurthy@google.com, jeroendb@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
 pkaligineedi@google.com, shailend@google.com, sdf@fomichev.me,
 martin.lau@kernel.org, jdamato@fastly.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Apr 2025 18:16:32 -0700 you wrote:
> Commit 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with
> netdev->lock") introduces the netdev lock to xdp_set_features_flag().
> The change includes a _locked version of the method, as it is possible
> for a driver to have already acquired the netdev lock before calling
> this helper. However, the same applies to
> xdp_features_(set|clear)_redirect_flags(), which ends up calling the
> unlocked version of xdp_set_features_flags() leading to deadlocks in
> GVE, which grabs the netdev lock as part of its suspend, reset, and
> shutdown processes:
> 
> [...]

Here is the summary with links:
  - [net-next] xdp: create locked/unlocked instances of xdp redirect target setters
    https://git.kernel.org/netdev/net-next/c/0e0a7e3719bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



