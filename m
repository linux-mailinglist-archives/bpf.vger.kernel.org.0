Return-Path: <bpf+bounces-27878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11A8B2E9F
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AC91F21542
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF2F17FF;
	Fri, 26 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOOoOeuH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C001849
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098027; cv=none; b=oMadQZ6699haiaGS9Bruc3pdaHoWfL8eYDCdPoRy+g7/YcUtfBpZNZhZPGx8vbLgRPmGtjb7vY0P1fsYuoZyCM3Y9Yi0jlFAfp1J7apVxBYGk129eEgqMUXmTbhBlOpMF00jMOryS3+tGNXHnDTAw0SgZPnJjD03d+KPIJDncT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098027; c=relaxed/simple;
	bh=1yj8rzcYYqdZ20I5cKSimsqUBgqo2G3HpZ+C3LyH0m0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AMdZhX4fw5Y3DYJSVPrphWuyM104C3f8/rc3qign9HlR9fVI8kOmjRKo5BvXlfB+Xt8CZCksFMprN0r0QCg6NG7JqipE338rD0sX9EQ4ipJfVfV7rC1ttoPOtpxSPXRF3TDNf4dP/Le6rxZP2aXT9RIjPdfzxk5MirdFVENKkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOOoOeuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E39C2BD11;
	Fri, 26 Apr 2024 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098026;
	bh=1yj8rzcYYqdZ20I5cKSimsqUBgqo2G3HpZ+C3LyH0m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOOoOeuHxs678VFDzMiDHRwsOl3G8jC+Ldhv7tONb8S96DTT77i64lJxXgxvsraMW
	 t1FWyveVxhW8BkoL+1/JiJ6PWI8xy40/yC8wpo//HTCDouzApMdeQAwe8RyDwGWX9Q
	 acitUaqUrOMsvZbHZ1HLeC5Vh7rR9ghCgyvi9LJgsvouD2ZDqJsRzT3iAnLBM9eSut
	 9HxR6n//32DAssZdehXFkQOWAKlfu8cA/Jhyq+/blr650ENaIs7HLKd0rk+zt6RXit
	 qO0ED0dc2oqNEPa2jKj6yrDIq42eKPQ45rAAE2AgqOcEWHBHMSBIRMOez0Au+WU7ZO
	 k44Otp2Jh5wsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72A1C595CE;
	Fri, 26 Apr 2024 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Add introduction for use in the ISA Internet Draft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409802687.9165.16675554812187303069.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:20:26 +0000
References: <20240422190942.24658-1-dthaler1968@gmail.com>
In-Reply-To: <20240422190942.24658-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Apr 2024 12:09:42 -0700 you wrote:
> The proposed intro paragraph text is derived from the first paragraph
> of the IETF BPF WG charter at https://datatracker.ietf.org/wg/bpf/about/
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Add introduction for use in the ISA Internet Draft
    https://git.kernel.org/bpf/bpf-next/c/e51b907d4032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



