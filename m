Return-Path: <bpf+bounces-75281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81269C7C11F
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 02:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29553A54D6
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DC24E4A1;
	Sat, 22 Nov 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhD8HIEP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D12BAF4
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773842; cv=none; b=Ip8KVtBBA4hCP/ZuOnQNQ/8K/v/OLqo8tHEJcOvuoW81vrHz4O3VuYdwmfRaSjtoAPOzjH0PR5lp512NoejNZmEYi6T4wVMEb0bzz40z67U3i7SRdWwjbSTpRaUqtxZmSjIMziNzwskpKNuuBY03gvSK1MBh29CUVRY1tACx2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773842; c=relaxed/simple;
	bh=Pl10Hwju6IkdCZZx2CxQVdgSMfYpBFnsZDT9MnqssRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MjQuNXiz5Yn6f4dGwHEPc2x3sxy23oLZHKq2Ab0vRpLCC96D9mN4bylvW08SNY2A3dd1/9d/1LxHGC6soWfF04kNaOTkuOAlY4uhri7MUJD2oUKmfkXA4cf/N+ynRQqZHTuTCRZvsuuj1S+GBrPIBDQ8613TKfKPpS3mXWOjEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhD8HIEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4221FC4CEF1;
	Sat, 22 Nov 2025 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763773842;
	bh=Pl10Hwju6IkdCZZx2CxQVdgSMfYpBFnsZDT9MnqssRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GhD8HIEPFc/anFCWYvTm1tnjJQpfk+aJZVYoBs7VOGdNFqtDtizxn7rfBvEsyYs3U
	 iWlCk0hf7vMms0xiJ9BMUxIxUf2bprIA7qKFJ0raLwkn1SRF0kF+JIp2unfEkgVct4
	 gzudDqX4ilHRoeNf4s0azCA4vsXn3OqD6Q4Hko8y3+4t5cicJZM9GzNa5vKTUqjWZ2
	 608xzxyY/jPQlhTCozUA8mbnLxseqW3P0vKxGlKrZ+nBR74sfFvWkRxqrC/KbnzSEq
	 MPWuGqhI8eqTg1GUc2hHe1C6H96nyZNjCB3mbXQD0NDAEbFEQGsPtodltLdA5ra3G3
	 iwGuWMxgJeNhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23C3A78B32;
	Sat, 22 Nov 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: add a check to make static analysers happy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377380677.2642890.8477166174268108624.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 01:10:06 +0000
References: <20251119112517.1091793-1-a.s.protopopov@gmail.com>
In-Reply-To: <20251119112517.1091793-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Nov 2025 11:25:17 +0000 you wrote:
> In [1] Dan Carpenter reported that the following code makes the
> Smatch static analyser unhappy:
> 
>         17904       value = map->ops->map_lookup_elem(map, &i);
>         17905       if (!value)
>         17906               return -EINVAL;
>     --> 17907       items[i - start] = value->xlated_off;
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: add a check to make static analysers happy
    https://git.kernel.org/bpf/bpf-next/c/4dd3a48d13a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



