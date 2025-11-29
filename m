Return-Path: <bpf+bounces-75762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0AC94613
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2A7F4E1CDD
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 17:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984330F7FE;
	Sat, 29 Nov 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgKzURXm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F422759C
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438809; cv=none; b=GpZTfXKgc8TkqS89EV3i4AGM+bBQBx/5J4mkAiWcnpCgcGcHHZc5umzKQtmLri4v5mS4bfIEb9yEgH0M4AlH3P/ELkht2SR1VecefJ2a3A10eQi2R3rE+q8rAqwxeHHGUFBIrXFgVg2couaiky544S5aiGE19WyZMPrke9gw+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438809; c=relaxed/simple;
	bh=XfXbORGS3/ufhmLqd4i+Y3zEh+p/3MgoFyWXDmCj2FI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6yzI2E4gBrv2oAPtRlgz6Io++yTm5VlvWkrwbDOb9KVzRsVyxRWwt7zExdyr8USkfKwmeag02U96fqr2IM7OLgqrb6EWdW2LW5COEVgh1cSmIJMP/TyLzk88h1n8IyK0sg6rDNDyGdMErcgGVWbrDznThjaSE43tP9Q3Q90NtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgKzURXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D3BC4CEF7;
	Sat, 29 Nov 2025 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764438809;
	bh=XfXbORGS3/ufhmLqd4i+Y3zEh+p/3MgoFyWXDmCj2FI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bgKzURXm+BYa1qDu9tOHu3WEYUO5a8rEwaA1ddTSL93c4zw1ozCBijrS8TekLhbcp
	 NRwciruTXLKGiiFk47cspUzr2ovGxlt+5DVwetRM8ODOipuKU3bnkhkWN0z28UpVjb
	 WBwXrwzLh/iNJ5lWDshTEgAHnmOKyvvDAAbWjOJEJK+/RzhfJ3yH5dMBSeHz5Rtbrv
	 mLVajwbN3svIMJrPDah6f6SEKq1WluYvX4lXnO1ZlBbIq76maYhUuac3lJASL9U7SW
	 QpGqL6BV3JlmCjNyiryBXkQTIlhIsbdRyHNozGJZNVl47tn+jHsLj76y3nRfsOA6Eg
	 0LNS+P9Gq2Gcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788B83806934;
	Sat, 29 Nov 2025 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: optimize bpf_map_update_elem() for
 map-in-map
 types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176443863006.1061209.10606164337894467600.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 17:50:30 +0000
References: <20251128000422.20462-1-ritesh@superluminal.eu>
In-Reply-To: <20251128000422.20462-1-ritesh@superluminal.eu>
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, houtao@huaweicloud.com,
 jelle@superluminal.eu

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Nov 2025 01:02:35 +0100 you wrote:
> Updating a BPF_MAP_TYPE_HASH_OF_MAPS or BPF_MAP_TYPE_ARRAY_OF_MAPS via
> bpf_map_update_elem() is very expensive.
> 
> In one of our workloads, we're inserting ~1400 maps of type
> BPF_MAP_TYPE_ARRAY into a BPF_MAP_TYPE_ARRAY_OF_MAPS. This takes ~21
> seconds on a single thread, with an average of ~15ms per call:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: optimize bpf_map_update_elem() for map-in-map types
    https://git.kernel.org/bpf/bpf-next/c/ff34657aa72a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



