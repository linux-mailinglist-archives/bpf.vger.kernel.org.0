Return-Path: <bpf+bounces-41788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C673F99ACDE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89277287441
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5B1D094A;
	Fri, 11 Oct 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j80mKbUd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E81D0793;
	Fri, 11 Oct 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675625; cv=none; b=OlSOli9wUZPLcolc3pdOmC3hB++sBrQDW5qKQW2RbMeQmBdpfStX0t4U7heE/enJ8/YJiD9bCCadIcSb6utRbXxaftl9EDruk/G+Fm1zOx8wXEgKcvBhWZL8vjfJP4jK+s8Xo8OgnoUyle5Sin29ae4Td4OUwJoN0YOCuLYOocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675625; c=relaxed/simple;
	bh=4+2xDNBS0Rq7hw4JdQEEFiEa8ZXkllnKf6saFGvE0y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DowZ4lmxvQGoTPZ9ZNtVrmlu1Vq/whc/RB7Pm3B7Kv6UNvhM9r9MogQ7+q0DaWNzwthVVHcWKavXmpKgUkA9YrCg7CgE7dsn4s6fpJTi+908k9CZlDMiU7VjjghUWCQCaavD4z9+aKwrCp0pGwCyro03tvzwxDkGqEfKzYzluyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j80mKbUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C77DC4CEC3;
	Fri, 11 Oct 2024 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675625;
	bh=4+2xDNBS0Rq7hw4JdQEEFiEa8ZXkllnKf6saFGvE0y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j80mKbUd7Z7SB3RKDb1j318AArY3kscgtO6N3vPTtgSxSpPUYUqm7Rfk6f3htZxEp
	 /5DNjMUjJa8uV67eQt6jjAs+ofxpHfc9Tg9NEeoajUOrQ396vVcBdgNTw8NRn6Z8pV
	 Oq78aFdurZhi/UqVbp8ll4hRd8DZ8UeALL+FmO+lpe2UNdRCcYikR3ly18mH/4zJIM
	 gVAu/tocFiYdoZNT+5W4HupPdYgvLx9e6o16vvcFnLdrVezpGCJWvM712y05FI807o
	 CYaRAP3MyepjHGaW1E2dIdRm85oerYI7ftkOMYzBiEHwfobWP/QVZlhj/VAaLRMj6E
	 rGKx60WJ9PGvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFF8380DBC0;
	Fri, 11 Oct 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: Fix possible compiler warnings in hashmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172867562948.2977918.6854581716055058273.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 19:40:29 +0000
References: <20241011170021.1490836-1-namhyung@kernel.org>
In-Reply-To: <20241011170021.1490836-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 11 Oct 2024 10:00:21 -0700 you wrote:
> The hashmap__for_each_entry[_safe] is accessing 'map' as a pointer.
> But it does without parentheses so passing a static hash map with an
> ampersand (like '&slab_hash') will cause compiler warnings due
> to unmatched types as '->' operator has a higher precedence.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> [...]

Here is the summary with links:
  - libbpf: Fix possible compiler warnings in hashmap
    https://git.kernel.org/bpf/bpf-next/c/989a29cfed9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



