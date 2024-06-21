Return-Path: <bpf+bounces-32762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A235912E45
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EFF284AB7
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94516D303;
	Fri, 21 Jun 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHh053+l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A315FA96
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000632; cv=none; b=m3a7iDboORS9hCOMajTvXcpVwGQ+WVUt/7QD4EcMtpYX6rFWS3KZh+iEVCSkI79Cuhzupc9D+KIjsFUtjlmyJ8wIH2IizUFt6kiHsqqvi3igEnNJb5hl6A97GQFtNmHnyRBkYD94k0X4ZDq5IPeDzyNPPW/ArTEoyoUWrM+CiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000632; c=relaxed/simple;
	bh=yS4jwjxZH4NOuctx2lFClEu/KAPKlsqvAja2OHI1K3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJoi0taWiQERCpwu7w/uLnGmTpLL9h62UU/NhY8jyDKFvypl2W1A589WKDnfyXz/aKLnYBVGrzF4lmFkW65dsXBUsT3NeIQwydqKrS/M1a1k8ieqsTFkSlnXagMA8VbKe5UMgRFnUhsl8N/NjAO3yAyIgob2ccR7kQrdw0IMYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHh053+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B6C4C32781;
	Fri, 21 Jun 2024 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719000631;
	bh=yS4jwjxZH4NOuctx2lFClEu/KAPKlsqvAja2OHI1K3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHh053+lxIl6rvVZvjHncCwsHy77kdpR190dQB6RmBHOWO3MK4M/mhZvUGKg76Lin
	 +0L2CovNjnwfQRd8VQhOtn/lSJQbaOHRVpzGoUVDdcjYRIiHIuzdq2LWRKBs3QjrIe
	 YhPhtO7YknYiQl89Wt0KdrKJOfBovt1gojSe8Nd8aiaJ/KDcd246kjRUNDRFNx9jIx
	 UAxLnmOnIc5aMu6QegRLJoAS/JWYJ5HMs4GZEIUXP6SN9vPNQkY7UQkFTRSrEw8eoo
	 Je9Kz2fuWFtQcsJDBwtv7EMUGr6OxtYftmJ5nGodFqcIa4FutupXyOK7WK8LAgt5i4
	 OU5vsHMnohsUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7192BCF3B95;
	Fri, 21 Jun 2024 20:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix overrunning reservations in ringbuf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900063146.4429.1561366582593435770.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 20:10:31 +0000
References: <20240621140828.18238-1-daniel@iogearbox.net>
In-Reply-To: <20240621140828.18238-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, bpf@vger.kernel.org, billy@starlabs.sg,
 ramdhan@starlabs.sg, andrii@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 21 Jun 2024 16:08:27 +0200 you wrote:
> The BPF ring buffer internally is implemented as a power-of-2 sized circular
> buffer, with two logical and ever-increasing counters: consumer_pos is the
> consumer counter to show which logical position the consumer consumed the
> data, and producer_pos which is the producer counter denoting the amount of
> data reserved by all producers.
> 
> Each time a record is reserved, the producer that "owns" the record will
> successfully advance producer counter. In user space each time a record is
> read, the consumer of the data advanced the consumer counter once it finished
> processing. Both counters are stored in separate pages so that from user
> space, the producer counter is read-only and the consumer counter is read-write.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Fix overrunning reservations in ringbuf
    https://git.kernel.org/bpf/bpf/c/cfa1a2329a69
  - [bpf,v3,2/2] selftests/bpf: Add more ring buffer test coverage
    https://git.kernel.org/bpf/bpf/c/1d68f685a850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



