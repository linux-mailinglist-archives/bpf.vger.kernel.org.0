Return-Path: <bpf+bounces-71289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D7BEDDC5
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B5218A1239
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF61E1A17;
	Sun, 19 Oct 2025 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odKRCAAg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C09354AE8
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841033; cv=none; b=TNYDSMl/l/4IAzWctASOR3qrZ4RXOkYB9xvOivpgOaXe7YAJjj4z9ctqgk0Wlu4QEdMy9M7iKd3bGSPz14JcO8WSzxCZcjt8Z7zDwCJG8arRjl7a+rehZ0Jry6EJrG6ZTZonY+6B9Dn42YjIBUj1ysH27eb661JzF6sd1YpA9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841033; c=relaxed/simple;
	bh=vS85EYqXhdHh64V6dSfxJGjWvW/ifHT4jBdmIi3zwEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GS4podQAEHZluLfohZDS8L2GzjlE4+WOz9u0+V7Fuq6U9ubomB8WXR4xKvi8/wyGsOgHJL6INzEeHxHrIMZ7Un5k6A/Ac0/aJQ2b+pqMSiKLFw2sN5LPHSGOBJkhBHPmAStS/0jdVl53em99yY/90r/aZL6+wX2o7eOEXrkxqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odKRCAAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBAC4CEF8;
	Sun, 19 Oct 2025 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841032;
	bh=vS85EYqXhdHh64V6dSfxJGjWvW/ifHT4jBdmIi3zwEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=odKRCAAgb6EBh0r+2yBnLjqvrDb23ahVcxXzhQN+1WxnmGK2uFNWVe6uN2ZrQ4PH5
	 nJZUsJRZVKjP5WSEBWlazvaShOXiDSoE2hCP0cTfqH2n5cD9WkBoqbdQYgKUjnYKfJ
	 PZ1C1chpQ4TVjLWvoXscqRSfR8iOsDpVmN4Npjv9qfEhIB4VHH1YoIsug24EP6TsH2
	 wfFlnh7j80X/WKnA9M9SeLZn1t8gZqUhZ2KZJoWSKLXuaMmMy9FcKNb+SC2ps62O1I
	 Mw6h+5lpFYH5Ybp5cRkk6FBlAkkqWi0cVNXBb6iYzqNUymQdMRUUvv0aL1LRX0TcUo
	 0Fsp0qecvER+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA7239EFBBF;
	Sun, 19 Oct 2025 02:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176084101529.3155740.2422703832168893238.git-patchwork-notify@kernel.org>
Date: Sun, 19 Oct 2025 02:30:15 +0000
References: <20251017141727.51355-1-puranjay@kernel.org>
In-Reply-To: <20251017141727.51355-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Oct 2025 14:17:25 +0000 you wrote:
> The __list_del fuction doesn't set the previous node's next pointer to
> the next node of the node to be deleted. It just updates the local variable
> and not the actual pointer in the previous node.
> 
> The test was passing up till now because the bpf code is doing bpf_free()
> after list_del and therfore reading head->first from the userspace will
> read all zeroes. But after arena_list_del() is finished, head->first should
> point to NULL;
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix list_del() in arena list
    https://git.kernel.org/bpf/bpf-next/c/7361c864852f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



