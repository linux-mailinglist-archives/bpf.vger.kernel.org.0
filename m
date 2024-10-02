Return-Path: <bpf+bounces-40752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA898D0A7
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC05B23B3F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE79198E6C;
	Wed,  2 Oct 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc7tl7Ex"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2B194A67
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863229; cv=none; b=ZlEKvBhvnb0DminQG6hFTVjF4dUzBdaD/ACXDcD5+asNhr97pLYpT16CwHTK+TRCyGIQxSHj1NfXZhUnf+NktD+6c5NmAzzQe0wzU30h+S3mirbNoKWzTHIaSHOxA+p7C/0TDfGtUJaek2amYy/SI3f7ADlT/MPtN3aOm6cvq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863229; c=relaxed/simple;
	bh=/NNLdGdvbCBBGSTrKZR2GHD/1bxpiFgtpaDjAW5kJPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ft6Z28MAW3rTRBTuvDnPjeHZ7BPIHss3LAzyFBzv8+miKImOnVJ7JPirNBmR/nlhwjIe6lb0D5QPsnQwcZTv4UHkT/ULFj3fc9xIn3X7qvOZnR86mf4AIfImYt+b1fZWX7GQoHPH0H5TPSh7H6TqsbBtQvUkBpV9HOjKcQrw968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc7tl7Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E3BC4CEC5;
	Wed,  2 Oct 2024 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727863228;
	bh=/NNLdGdvbCBBGSTrKZR2GHD/1bxpiFgtpaDjAW5kJPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fc7tl7ExfL7nU3Y64wkYh05xaCArqHJiMVgwKPlsyJTfjMkgWDS4aFw2ziqbOhwcE
	 GZ6ZfwCRKbhGm4S5DPFpQwGClgoIoCcHTISc2qF4WlUHkUG4wH27eOTTyP9lflN2TX
	 qnIQO9mY6kt4MsmpN+IcrnqyFwrHux17+DDveyFlj08QRBvm3SwCJyCqmOveyJ5m7w
	 Ytwym3Fut34Ht80qcyvmv9VhcC7tCI0gVJH0P/xizvgQ7FWkDoQBIamD0arWxa14NX
	 jMWgUlSydNhBkIbLJ4HasFZ9FXRlXhUxm8aSetrxhrOBkuEsT54Afl2wSK5B3Tm1S5
	 QaISOmoA7j4+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3414A3822EA0;
	Wed,  2 Oct 2024 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: remove unused macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172786323201.1108180.3714780473180982863.git-patchwork-notify@kernel.org>
Date: Wed, 02 Oct 2024 10:00:32 +0000
References: <20241001200605.249526-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20241001200605.249526-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  1 Oct 2024 22:06:05 +0200 you wrote:
> Commit 7aebfa1b3885 ("bpf: Support narrow loads from
> bpf_sock_addr.user_port") removed one and only
> SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD callsite but kept the macro.
> 
> Remove it to clean up the code base. Found while getting lost in the bpf
> code.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: remove unused macro
    https://git.kernel.org/bpf/bpf-next/c/8f5b408d7661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



