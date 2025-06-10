Return-Path: <bpf+bounces-60233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5BAD4366
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C48E178A7F
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7926560A;
	Tue, 10 Jun 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKjQhvsk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BC2327A7;
	Tue, 10 Jun 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585599; cv=none; b=htXK1pjisjmJlZXcnOf6LTN/sMmbXbX1Be8xzRxA3JIYlc/8xrxmqRUjDSGB0Sg/o1Pqurx7/i65r1qgYtNXhZYsqpCanqZOO4OQ43O1h7Mm/8WrN/apGEAu3UwqQOd7tuCVnK3rXFzhuhKlYDPIgGqcjebv/sHBv/89uAzc984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585599; c=relaxed/simple;
	bh=1xP9nIA3hWH304jqMq/W/p/NC3hWfeFnxr4McDe7B4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mn9DtnLECJ6WK6I31Q142wcKFwThBiVkRxp0EOhEEpYMA9GDo4yqXFwJzkPxZvs7OaeGhDebWghJaoeIP1zVhxWyxT1QPlOwIpqCceUBIQYYHAiLWwlJJAS2iymDxm5LbCPli5QrLprlsQFcWG+E5ZccUMWkbq9r1AzG3sPIf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKjQhvsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1912CC4CEED;
	Tue, 10 Jun 2025 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749585599;
	bh=1xP9nIA3hWH304jqMq/W/p/NC3hWfeFnxr4McDe7B4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XKjQhvskHgVBFnjbxVI9F7VVZ1tUAZE9iQrt/bbpUufiVxbnXT5w1Ez8dm5y9qp7J
	 sTQfE8B0HS5izj2WWYzPKxhfkYlriiDtqAjN7iVUuNQfYcWtOl26k6QlGDmbzcLz3Z
	 lNkwTXvgYUWA42WBEViBEAmBfFlwF78BXZFVziDnpDgkj8TgNVRklKzBsWY3dSHJha
	 06M2oVzRu9xbdkmXxwGajMEKdz/si/EUypC+P8wfZYCfENEb43NLZZ6Z7L5D7Bk8oU
	 t/VLFEiAjrMBqO6jhnOvuvcFSehhGQgKDUDrFbS6H3qeE1qCr9Ok9gC0lQYb4tV9Ym
	 TfzD54AruGB5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE07939D6540;
	Tue, 10 Jun 2025 20:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: add myself as bpf networking reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174958562956.2589090.15813828833479221525.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 20:00:29 +0000
References: <20250610175442.2138504-1-stfomichev@gmail.com>
In-Reply-To: <20250610175442.2138504-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, akpm@linux-foundation.org,
 lumag@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Jun 2025 10:54:37 -0700 you wrote:
> I've been focusing on networking BPF bits lately, add myself as a
> reviewer.
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 3 +++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [bpf] MAINTAINERS: add myself as bpf networking reviewer
    https://git.kernel.org/bpf/bpf/c/9cf1e25053c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



