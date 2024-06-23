Return-Path: <bpf+bounces-32853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C263F913CB2
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5814F283177
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912361822FF;
	Sun, 23 Jun 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR41n8iH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BA181338
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159629; cv=none; b=ezwaxhElVvvRE6Nmq5DPsSCX2fUjEkXwM1Fb5eO0eSrnXIyR5mEhYGi0hA+oYOlVDC9XuS+fTr0H2gXGnFh1tt39P51m4BkHoQaQRHiKwAUaUR/tKLFnQjEp6Nvm0NFtLXp4DhM1jHGwDdAaSFhOjvpcSy/gdDKgfvmtmUABF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159629; c=relaxed/simple;
	bh=XzCqdGEDneBWRvt/Sm1gUWQovNa0IYMF1aFnBBXQj1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExWJwauRwDqdste3iLNn2XHjQaQXWJ3cD8pTy5oiwreZUEORefWED3q4BG8ZrVkqZuTCOTUaC4E+PL9MzMSnGdy3/DWGvyfVhVuc/6Tlvh4bdSqQPEETaL8HGIjNmUUR1aq9rgBxUJlncnC/miwzdjNP7dmuMIxkMuHGRLL+9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR41n8iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96842C32781;
	Sun, 23 Jun 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159628;
	bh=XzCqdGEDneBWRvt/Sm1gUWQovNa0IYMF1aFnBBXQj1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sR41n8iHJsRIvOcrk4mJh9oxS5UCsxW54meHOicVxcrljjV8wgE0+IStxRVi8W0Qo
	 OLxN0Xv9T63AfTUzVCKC28DUZRJAKSdQ+ISDCPOVQIloL9hUOhKKO/OBWaa0l/sqI6
	 xRveM3kA7OkRS7W9PYmVkf3dp4Tq/aE9Ot39xcppjkMrjvBKXxi5QoBubo+zMRuYx7
	 YdkFD7ZHl/Z4fMGqEXfGhVO8/UCeS9+YjlE1YdvqdZl+YxKbRyH6girWZYqOsk7G8p
	 /2sCFZ/4KF7ozUaZ//AuqdhdkRWFcqTVVmg64Bp4Q+FhJK/25c+uMkYhCttgt9gYVm
	 UVIFEImjFmyMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86667CF3B80;
	Sun, 23 Jun 2024 16:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 docs: Address comments from IETF Area Directors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171915962854.3890.15461061572104632932.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 16:20:28 +0000
References: <20240623150453.10613-1-dthaler1968@gmail.com>
In-Reply-To: <20240623150453.10613-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 23 Jun 2024 08:04:53 -0700 you wrote:
> This patch does the following to address IETF feedback:
> 
> * Remove mention of "program type" and reference future
>   docs (and mention platform-specific docs exist) for
>   helper functions and BTF. Addresses Roman Danyliw's
>   comments based on GENART review from Ines Robles [0].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: Address comments from IETF Area Directors
    https://git.kernel.org/bpf/bpf-next/c/04efaebd72d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



