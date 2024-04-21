Return-Path: <bpf+bounces-27332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6438AC033
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9A8281652
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A831C6B6;
	Sun, 21 Apr 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEHBSubh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D991BF34
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713719429; cv=none; b=YYSsqgqodf3Gd7IcCc5A2Tg0iLyxbeNNBnWt8HCJscHsZHYe7d/sgCo2T9RvfnJMdd+k9AadYj9bztNgRVfCUIdWpBw5tilx6abG87ERBdFMigeJGfcI3hWa1LYdtRkwDFBji4fgxVVGy2UlLkv1Sj2NCuJg0fGnOxVRcJsJIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713719429; c=relaxed/simple;
	bh=LK3Waz1g0uO0seMMbUENbDWwauCPoJyeOJCVrDbE5tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O99IeBG25c7rEjZq6uqRWQkjYM6Q2mB3QXZQh9tNVoItD9ewNaHEpFwiv46SvMVY+gNlLcwvDpJBevPsxqUWkZOoBesOX0IDEAdI56jMuu3PUW4qrVMA/KnA2NHCTVZAj5gBlRw8n94b1cNXiJwRRqilEW/Wm8JHSZSo64Cot5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEHBSubh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C520C2BD11;
	Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713719428;
	bh=LK3Waz1g0uO0seMMbUENbDWwauCPoJyeOJCVrDbE5tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kEHBSubhEvNvgBC5d5wH/khDCqvIE6s1iwOkNt16WbqGcCaf4uLOdhWuQP1mH93Zs
	 xsloDZnS13In8W5b1f3l/xJ9wj6uMKv/TQIAgaMfSWUkIfUdDO2Ol23+AMxf+SnhyG
	 mZYxjZaATLh/iBcvdJAeO3MnTGrJyJTOP+mOVL6eMWYrIvUfNtAY7GtqNt/NsYNPu3
	 Sy6LToo3I0QhkGt0yiaDcuvQWoFIqQwkeJKEvYiBWC7se8mTqZ2S+JaiPbK5Lu7WcT
	 MC3CedSG8OcE8Bzf09thfiQu8mUOTtgRmWArA4xmb/oQdDiajXDgyXWrcI1hz7eKz2
	 GIvQ1JqwgK3HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BC90C43618;
	Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Clarify helper ID and pointer terms in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171371942850.789.13662700653980158201.git-patchwork-notify@kernel.org>
Date: Sun, 21 Apr 2024 17:10:28 +0000
References: <20240419203617.6850-1-dthaler1968@gmail.com>
In-Reply-To: <20240419203617.6850-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Apr 2024 13:36:17 -0700 you wrote:
> Per IETF 119 meeting discussion and mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/2JwWQwFdOeMGv0VTbD0CKWwAOEA/
> the following changes are made.
> 
> First, say call by "static ID" rather than call by "address"
> 
> Second, change "pointer" to "address"
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Clarify helper ID and pointer terms in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/db50040d09cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



