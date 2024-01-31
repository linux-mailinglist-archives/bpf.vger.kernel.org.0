Return-Path: <bpf+bounces-20784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95978843315
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82BA1C22496
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8C5663;
	Wed, 31 Jan 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p355Xkdy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E55224;
	Wed, 31 Jan 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666426; cv=none; b=XDLdgv53hiuxhVlZYV1r/tqXypFkW/SLSmZa2LJJ3DmT6+IlzWUYhGlVNZqlXHSE45rTfqiorlNiOYN8HBOHR/NhNx1xdcGWoRvcEukSCSlQf9xi5pv3VdDWp2AgUi+p0wtxpUZ+kV7dw40NXNWVaR16S+MSNA2O50xoOCmZfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666426; c=relaxed/simple;
	bh=6rTbYy6Vuzy/IF/kaJV31Z4upqRE4wLblupoPCdP6j4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rx2xUkzs8ZfK+orHQ4B18RMdJ4G/62LOF7DZU3R2dtgjgL57P5RO/9xSIYpphmQ4spTGK5Czk5eyY6OfZf/YMXJul4r3U8LEGXQeiMHsJqKE0kJuRiYO9ld2EGLZpnfc2iCvkBVlDXZQa8pxiNfjYXZoyv7uQhxhUnFs6czQ6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p355Xkdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3643BC43390;
	Wed, 31 Jan 2024 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706666426;
	bh=6rTbYy6Vuzy/IF/kaJV31Z4upqRE4wLblupoPCdP6j4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p355XkdyMJfPBBBVayinoMlZayPV+Y/dSx1f+9exbH2S47S/65N2Y2novMyPmtSSa
	 cjOKjPYlDZvR2C+EYbRO47nQipDHs83PCvkW34s1ZUyU5yvA+dJgo58AOqRLfspv9m
	 0fs4X8+4FndustpQp8LlPGnwnix02ltpuembZjbfnHjMnWXz5klqmOoZo5Vg9cmxwj
	 3xGGp9NIEyPxHfq3izY0bFU0s8bakdc6mrR7knAVSx6rkCJKwAFDaaPJFdXKsw5H3X
	 Q/wA48eGaVU43hba6VvhL+LNZLfZf29FWKyqJ60cJRfuO+jG/W2BwDUjZ/1vVw9RPN
	 spLdzaZ5exJ/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AB98E3237E;
	Wed, 31 Jan 2024 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] xdp: Remove usage of the deprecated ida_simple_xx()
 API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666642610.31142.2671848763624675681.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 02:00:26 +0000
References: <8e889d18a6c881b09db4650d4b30a62d76f4fe77.1705734073.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8e889d18a6c881b09db4650d4b30a62d76f4fe77.1705734073.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jan 2024 08:02:20 +0100 you wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] xdp: Remove usage of the deprecated ida_simple_xx() API
    https://git.kernel.org/netdev/net-next/c/6a571895116e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



