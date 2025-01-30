Return-Path: <bpf+bounces-50100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158ACA227DC
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 04:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E133A5849
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6E129A78;
	Thu, 30 Jan 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXuwaItM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF0881E;
	Thu, 30 Jan 2025 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208417; cv=none; b=uL8BptQD40ADf9WJMui8vVoOPlddgRNLRicgszuEH+s1DdX5Tc2EgCgJIwCJpG6kmiTcoJw29D0jB5ZAiRkS1u51jWdSL1NaseHp8av2t7lr0GIF1ycxOxUWALP8ZOS59Vj+l8Xz62Q3MMWbhB5vOiQ9hGGlHtrq0RXxv3joQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208417; c=relaxed/simple;
	bh=9CalzYwBf7RfO0bjBbMImR6hr46gD215+2mUUVXnOjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZUX540Caqn9/Z38eeObkK+AlR0YODk/Dc8fxDsX4lHnN2791EuqxCMaHBOuKE+BRpCiAGeoG/fyB0XYvAkLGWPIQ4vGMRm9ARCIFw7LzzU7EXe/Wf510A0U+s2GI/FqBfDH6zu8JDAeSg685GnXGLlaNTqrI3GOm9anrQvoToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXuwaItM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D941AC4CED2;
	Thu, 30 Jan 2025 03:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738208413;
	bh=9CalzYwBf7RfO0bjBbMImR6hr46gD215+2mUUVXnOjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXuwaItM3sUOVQjGBQuqbyKKGrXZPlBLox+SkJ6h0rw1sMJVpoAtNa+ELOqLiTHxU
	 aUfjPtlI6IoErfZH2vQgiTC0my4FVC9eZije9Q5tZSHxr2MONg6gutm9yebpWxAePI
	 M7fMKSf7EH+tHsXtGtsgfYm7O610tlGE777HHZCCcXY6hKQV2q0o6gGViapIsbAQA5
	 DSMXHfgrp3PQK8H77WUr5nGvaolqQLDbcCrLew4OGJ7aYWnzEp0UIjOh/8Myjp6GFb
	 ZBUZN3/qBpZd8178YQr+NeFy14cJmAU9kDbUwDg5avTtCsccxocy2qdPWVbS5A0/Y1
	 hw/+12YOmn6gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34364380AA66;
	Thu, 30 Jan 2025 03:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: xdp: Disallow attaching device-bound programs in
 generic mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173820844001.517031.4492741215957881605.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 03:40:40 +0000
References: <20250127131344.238147-1-toke@redhat.com>
In-Reply-To: <20250127131344.238147-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 martin.lau@kernel.org, marcus.wichelmann@hetzner-cloud.de,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jan 2025 14:13:42 +0100 you wrote:
> Device-bound programs are used to support RX metadata kfuncs. These
> kfuncs are driver-specific and rely on the driver context to read the
> metadata. This means they can't work in generic XDP mode. However, there
> is no check to disallow such programs from being attached in generic
> mode, in which case the metadata kfuncs will be called in an invalid
> context, leading to crashes.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: xdp: Disallow attaching device-bound programs in generic mode
    https://git.kernel.org/netdev/net/c/3595599fa836
  - [net,2/2] selftests/net: Add test for loading devbound XDP program in generic mode
    https://git.kernel.org/netdev/net/c/f7bf624b1fed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



