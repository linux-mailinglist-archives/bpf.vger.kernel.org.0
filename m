Return-Path: <bpf+bounces-65977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDEB2BD3A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BE71BC4F3D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E731CA4C;
	Tue, 19 Aug 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaIQuc3a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573526D4EF;
	Tue, 19 Aug 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595218; cv=none; b=COo79K43lHfQ6kIuYPf6fq8RsPi6oECLQ4LkWHa5g9tznUFb921aqGOKx3ekN4r+NHW4f5Viz86m1L9x0VlrEyloKGdLVfFsSh0Xq4WJx/hWonD+P3dLI7R7xdN+Kll2xg+YTcGWocVxvt4BzY6CUM4cEvLbR3pt6BOufIWqfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595218; c=relaxed/simple;
	bh=qXsXnOFhzvM0ZB2TgHO+7IHEuqwUzXUo5OdIf1l/A3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdq0lvIf9sbHKAlT4RaZaRzoNtBb9dtxUIp/dFicPu3OzJoPmyKE4hg1ORylUFP9F0BEYGWXRRjWZnaIbxGcsx80zZYaMiIBmuIG0CZM6LdQYi1FQV3Uk6M+BLhkWTFX5x/6lZHeF3t43PEpxmOj1cEqxQIMtjNlmoWOXE26uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaIQuc3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DD2C4CEF1;
	Tue, 19 Aug 2025 09:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595218;
	bh=qXsXnOFhzvM0ZB2TgHO+7IHEuqwUzXUo5OdIf1l/A3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaIQuc3aEctHOeJCJblK7CwcvE3Id/wRCen/tIC1PJTgrNm5bH6vK0AmHxa1vfKmw
	 cgEZClWdPlWqZorfgtg0L8+yu9dQpBkI4MlH1ewfEVicoNn7/V3LBN2LVep6kG/njq
	 VBrD24gywWOocHPDMsdvz3TjmWMEKIoitpSh0/wS5AJamAhiB2QEopUtI63AOpzI8b
	 mnZLkFdi1GlrAj0+rDrCSl9POI/jUDqKuxakZDnt7TF/R+Qc/Dkc0rOxiE40TSc8bj
	 YJcOAz6k6hs7oHgA3VRwDvTDpr1W9orWSM7FPmY1kT7hz6hb5qYmV7ZbDzii4b7ATj
	 ppKaY/D7sDzSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE2383BF58;
	Tue, 19 Aug 2025 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V4 0/9] eth: fbnic: Add XDP support for fbnic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175559522825.3461363.17326947395428104813.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 09:20:28 +0000
References: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250813221319.3367670-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch, ast@kernel.org,
 bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org,
 john.fastabend@gmail.com, kernel-team@meta.com, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 13 Aug 2025 15:13:10 -0700 you wrote:
> This patch series introduces basic XDP support for fbnic. To enable this,
> it also includes preparatory changes such as making the HDS threshold
> configurable via ethtool, updating headroom for fbnic, tracking
> frag state in shinfo, and prefetching the first cacheline of data.
> 
> ---
> Changelog:
> V4: Update P7 and P8 to address cocci complains about PTR_ERR
> 
> [...]

Here is the summary with links:
  - [net-next,V4,1/9] eth: fbnic: Add support for HDS configuration
    https://git.kernel.org/netdev/net-next/c/2b30fc01a6c7
  - [net-next,V4,2/9] eth: fbnic: Update Headroom
    https://git.kernel.org/netdev/net-next/c/0cf5a39720d0
  - [net-next,V4,3/9] eth: fbnic: Use shinfo to track frags state on Rx
    https://git.kernel.org/netdev/net-next/c/61f9a066c309
  - [net-next,V4,4/9] eth: fbnic: Prefetch packet headers on Rx
    https://git.kernel.org/netdev/net-next/c/9064ab485f04
  - [net-next,V4,5/9] eth: fbnic: Add XDP pass, drop, abort support
    https://git.kernel.org/netdev/net-next/c/1b0a3950dbd4
  - [net-next,V4,6/9] eth: fbnic: Add support for XDP queues
    https://git.kernel.org/netdev/net-next/c/cf4facfb132a
  - [net-next,V4,7/9] eth: fbnic: Add support for XDP_TX action
    https://git.kernel.org/netdev/net-next/c/168deb7b31b2
  - [net-next,V4,8/9] eth: fbnic: Collect packet statistics for XDP
    https://git.kernel.org/netdev/net-next/c/5213ff086344
  - [net-next,V4,9/9] eth: fbnic: Report XDP stats via ethtool
    https://git.kernel.org/netdev/net-next/c/7fedb8f2677e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



