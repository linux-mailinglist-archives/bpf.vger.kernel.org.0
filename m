Return-Path: <bpf+bounces-61309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30885AE4CAF
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5297A86D5
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D0A2D3237;
	Mon, 23 Jun 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf+woZbh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3223BF9C;
	Mon, 23 Jun 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702780; cv=none; b=q2Qq87IwidmNWfMtdCprgm3hIEAQAPFPbN9RZUjapwJY669USYu4MtH4hT/Mhj40a67wnOKoaK0pP4Elf86RHFfrY25oxf1zY6UAMw5FZaH4reLPMwV6Oqha+jCcF7rkfOmKcyajl8o1juNCALwGgx92nZZmmD0Sy3Gq+29VBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702780; c=relaxed/simple;
	bh=/kwMb7EYkX9jXCvAV1Tqjp1XqcVWjfLYQ3JkaVLEP8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uXn5dbdaC4U56PTjpmqqr19I+KvqaHBggWTi0IlCBx/HRUTi33qfBp1dtZP3n//meV+zj8JQ/cl7cdj0X6QYqTOB3nbTdJWRYSUv9lm+Q90LcpY4TA9guU7VeX2+BPrO5fSWCPVGKjET7sK9KaIduimAWZeCU63BvKesTEuKcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf+woZbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF34C4CEED;
	Mon, 23 Jun 2025 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702780;
	bh=/kwMb7EYkX9jXCvAV1Tqjp1XqcVWjfLYQ3JkaVLEP8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nf+woZbhQKymZE5VcKhMtLfWFDgIDBpsYCCEzeGKT1q6XrfUT1fH/027kMhUF1iLz
	 sj4X8LXXZEyCIPRNt5ovqTkEu8k52PhmTP6RzIARp7yN/MN14Hcd7UZjrAc/7jo16D
	 1Z/rRdc71JJdUZOaKwPDFsgzoIFLgrX6p74wapUozPu+vhFjBvtm/vdEY/0XLK3Bxo
	 KMMt+B5mdGm7kNDYykrQ/NFjf1TbXJpxYC+zMEs1Zzo2dSHsxsaDefUbg8nRZyBHt+
	 lRth1gjuINh6KVb3me1bdUP+FiwtUsLq29BoB+dYZeTSyxc2+bkA7sjL9x4czxJSmb
	 I24oODzuQWuhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118438111DD;
	Mon, 23 Jun 2025 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Fix null pointer dereference in btf_dump__free
 on
 allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175070280727.3256207.16732864015027671510.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 18:20:07 +0000
References: <20250618011933.11423-1-chenyuan_fl@163.com>
In-Reply-To: <20250618011933.11423-1-chenyuan_fl@163.com>
To: Yuan Chen <chenyuan_fl@163.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenyuan@kylinos.cn

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 18 Jun 2025 09:19:33 +0800 you wrote:
> From: chenyuan <chenyuan@kylinos.cn>
> 
> When btf_dump__new() fails to allocate memory for the internal hashmap
> (btf_dump->type_names), it returns an error code. However, the cleanup
> function btf_dump__free() does not check if btf_dump->type_names is NULL
> before attempting to free it. This leads to a null pointer dereference
> when btf_dump__free() is called on a btf_dump object.
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Fix null pointer dereference in btf_dump__free on allocation failure
    https://git.kernel.org/bpf/bpf/c/aa485e8789d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



