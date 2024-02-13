Return-Path: <bpf+bounces-21880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BE853AEE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF301C223C4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F8604C9;
	Tue, 13 Feb 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJVLjqo2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5B58124
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852629; cv=none; b=D4XovR1cMMpeBnVxXAjRxAqvuo6nIz8FtoUCaF7kukgDTNuQJMHqPxCMWOt8rHl5XDa3BANGE3UtRcxSXF5nALO42aw5IpGLzjUuV+/LZzd0T1nFAYMV+znzDBpXdz5KEz/OZJDkoyJBHYgdTAB6o46iVvj5Xtf6493jnnPoyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852629; c=relaxed/simple;
	bh=jn4DmoJpFYIBaL+989fG8FchTqAwPatAvI5SMwrOGpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nU5oRF85DLituS0b/GG+BOkl6kioP3Pz4n9fwCHILxfFdYItiXmX/PdNilafVcZqkZmCx05ZPpS1U0+NxNmKv8AWZtbjZvYV4E7LcZi9uMbK5ZnroNg8ELFGYvDW3NdHeRZvwQ+MeL+1+msd10/wSSXyjoHBEyfJcVkwQ1LsZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJVLjqo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 811F5C433F1;
	Tue, 13 Feb 2024 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852628;
	bh=jn4DmoJpFYIBaL+989fG8FchTqAwPatAvI5SMwrOGpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NJVLjqo2fnv5IML5rfvAoyYZH2pZFQ4cA6Mo9JXAybN+R0JwBWO4iZck45IYwlfxG
	 ZXYI7kZ3O+UE7GZQLIiLf6zWx2MjX/AkcHq6P9S6yarwkNV9e1N9J/yu0PLdmtxH2T
	 vpAzhrrN54AzsPk82jGuhaUG/4qaYQsPk/GEdW70e65UR0t5Fnc0nOEzPwilfeXPvC
	 66mkQLC4zMmWTgqjkbYiEaqf5DzMm5aExE+Hn+4nCZjWE8FuPtGU+Ksf2KmlXVYu6H
	 5OYMnVaG01RNSXK5XC802ZadJb4hcJ2/hBrz8yizPajNZBKg7k8QXljpBVP/DCfrTs
	 jhHWZ5GKZNC8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 681D2D84BCD;
	Tue, 13 Feb 2024 19:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next V2] bpf: abstract loop unrolling pragmas in BPF
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170785262842.8425.16429888165871490905.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 19:30:28 +0000
References: <20240208203612.29611-1-jose.marchesi@oracle.com>
In-Reply-To: <20240208203612.29611-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yhs@meta.com, eddyz87@gmail.com,
 alexei.starovoitov@gmail.com, david.faust@oracle.com,
 cupertino.miranda@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  8 Feb 2024 21:36:12 +0100 you wrote:
> [Changes from V1:
> - Avoid conflict by rebasing with latest master.]
> 
> Some BPF tests use loop unrolling compiler pragmas that are clang
> specific and not supported by GCC.  These pragmas, along with their
> GCC equivalences are:
> 
> [...]

Here is the summary with links:
  - [bpf-next,V2] bpf: abstract loop unrolling pragmas in BPF selftests
    https://git.kernel.org/bpf/bpf-next/c/52dbd67dff5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



