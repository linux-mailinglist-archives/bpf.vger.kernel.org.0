Return-Path: <bpf+bounces-53129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB67A4CF54
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DE41897A64
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8023BCE1;
	Mon,  3 Mar 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEaWfM8P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC321F461C
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044933; cv=none; b=kQI+y9XARde8TbViKoJQJor9/Vr/52PiwPrH2B+YsTW9rr9/ITp+/WgTR4rjydNCScIFBO+/anSCu+ugW1NcJ5p6GshtiVtIjPh5UKERcmM27CgNI6GVsBcUYOkG9moz3k3VCcyxhGu18VYnGU+Q658VuhhpXaJU8qGo/n+6Bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044933; c=relaxed/simple;
	bh=KBiRCIGt8Swb8YhcsRuD4d70afy1z7icyWbUhAEw+4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b8hbzFXyUsIJTSxvG3rd7oM7PuYXVLojyUKjQUmJE1HgeO8yg2m/jlVQoi0ABAi/1/+U6bhIXDaJWCu992sUCzh37EpK+0RC62OiWo1HRJiOWE56+xc1MSTjMQDhkslJcUwrecsqGktCIEo3srP+DFYyUkwhRYk+osO0yzcFd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEaWfM8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC614C4CEE8;
	Mon,  3 Mar 2025 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741044933;
	bh=KBiRCIGt8Swb8YhcsRuD4d70afy1z7icyWbUhAEw+4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lEaWfM8PTK/R1sv4scoToBlJ9tGAo+Z9wLf8Ww6QhngEn545ZbeJlthFHBxI4KWrO
	 97RxHTzH90tYQjZSPlK6b68X3H0lCZ6YbxeKB6iq9IdVo7gC6ahgHGh5b1XOmuVIjv
	 AyHcweovn6fVaZ1j0xygb5fJvc+YCb7Fcxkb8cgNvhI9bn8lBKFtPCtXGbjmyHDQpy
	 3WAhSAmxEQxI30PoQfexJpoCfYMlBdjWRFr5PiHumzn4Kux9rWC8cdE2i1LVrjMs3h
	 5QVlbeyFgzN3bZX4Qy+ZJ73X5rBj8os7dvLRT6iVwX1gwJ3dPWyPWfO1ttBY57j40K
	 pcnh+LiK0DX5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF73809A8F;
	Mon,  3 Mar 2025 23:36:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] Introduce bpf_object__prepare
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104496548.3745415.10380206773751586157.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 23:36:05 +0000
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Mar 2025 13:57:48 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> We are introducing a new function in the libbpf API, bpf_object__prepare,
> which provides more granular control over the process of loading a
> bpf_object. bpf_object__prepare performs ELF processing, relocations,
> prepares final state of BPF program instructions (accessible with
> bpf_program__insns()), creates and potentially pins maps, and stops short
> of loading BPF programs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] libbpf: use map_is_created helper in map setters
    https://git.kernel.org/bpf/bpf-next/c/7218ff1f322d
  - [bpf-next,v2,2/4] libbpf: introduce more granular state for bpf_object
    https://git.kernel.org/bpf/bpf-next/c/8ca8f6d1a2b4
  - [bpf-next,v2,3/4] libbpf: split bpf object load into prepare/load
    https://git.kernel.org/bpf/bpf-next/c/da755540c6f8
  - [bpf-next,v2,4/4] selftests/bpf: add tests for bpf_object__prepare
    https://git.kernel.org/bpf/bpf-next/c/68b61a823aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



