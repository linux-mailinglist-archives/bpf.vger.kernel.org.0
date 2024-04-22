Return-Path: <bpf+bounces-27437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D928AD079
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8071C21DC9
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A78152DFC;
	Mon, 22 Apr 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDQymUui"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C37152180
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799227; cv=none; b=pVuGZF5eYo1fuBVpbVIVb80wBYAQsxb3onneCIIugILwkcOQolgDusCWjfwAewXIXhwbBWhEVxhiusqVu4UQimTPr/Oxr9Bv4SiU4qyn60R84BwX2LxXjrdHdW/h2U0mMIuWaM8bEh7+jQBbV83JqLwNSFPKenJu3YWlWBvcej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799227; c=relaxed/simple;
	bh=3cAyMEydludjhoInu+AjD/+5d8DYqlPns0ch6PqQmYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ame8dylRuvTJZPwz0R6TTZQx1vynmK+NB5aAuiNSFQMwbtPlJefObD8yPoay58QECjN21x1aj3fzBuxBzD/2UcGs0ulk03lklv0CZ2NVfE3N8DJWuhkz3gOyznerIQg8TupNvww1HHkll8a1Y+UmdvOVN42dn8rqGwzph8aTaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDQymUui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B2D6C116B1;
	Mon, 22 Apr 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799227;
	bh=3cAyMEydludjhoInu+AjD/+5d8DYqlPns0ch6PqQmYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kDQymUui85DoTekpHLF9LO84/kyQz5e19P2DUadScd/iT2NqISnVFOD+wmggLD+IM
	 TtHtOSCuzpOZA+3X5vO4VAYc/8vK9NW/0uIHtjsW7b0IvtFuONbebrtG9amstsZwEC
	 uoqWgdUmkBXLHFBBDIm6a/pnYcQcQOcVtEydzmkZE/ETpk+0dFOsX7DiJkO5dmmmaD
	 kUnHdGx9p6Ro32EVYO0W8pDwfUoSlprNHws1reuIOLw2M4fe1rVnDjo3Q5wewgo1lg
	 JJgpUZ6m1u+Kn5lxfRMB+VW4mwkBoKxbcjPSq+uE2rr1XOPevIGF2cR+7zdo6oAyWQ
	 F/bRDWHvXssEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07BFDC4339F;
	Mon, 22 Apr 2024 15:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix typo in function save_aux_ptr_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171379922702.23349.7247861491314887893.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:20:27 +0000
References: <fbe1d636-8172-4698-9a5a-5a3444b55322@smtp-relay.sendinblue.com>
In-Reply-To: <fbe1d636-8172-4698-9a5a-5a3444b55322@smtp-relay.sendinblue.com>
To: Rafael Passos <rafael@rcpassos.me>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 17 Apr 2024 14:52:26 -0300 you wrote:
> I found this typo in the save_aux_ptr_type function.
> s/allow_trust_missmatch/allow_trust_mismatch/
> I did not find this anywhere else in the codebase.
> 
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - bpf: fix typo in function save_aux_ptr_type
    https://git.kernel.org/bpf/bpf-next/c/e1a7545981e2
  - [bpf-next,2/2] bpf: fix typo in function save_aux_ptr_type
    https://git.kernel.org/bpf/bpf-next/c/e1a7545981e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



