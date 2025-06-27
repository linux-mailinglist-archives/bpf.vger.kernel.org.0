Return-Path: <bpf+bounces-61708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E956AEABAE
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C14A8031
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6FF15E8B;
	Fri, 27 Jun 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2o5G0zj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07123F4E2;
	Fri, 27 Jun 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983590; cv=none; b=bERtUg4D9ta4Rvesg9FB6cQPzn6XnqBgkuGy0TdeZPDmeS1/PME2EfJrjQ5iEg877uUE2cu/zE27R9IPAyIJnaDOdH/qNrVWVGI8bEhkiGFtNn855ZbesOMkgeJ1TqVrTJTsswUam4KeU18GKadZ7TeO6Qh4TexXsYvLXq8IlPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983590; c=relaxed/simple;
	bh=/gSgrljG7eAjzXFe8hf2tvSNTEmVpGZaz1Bti9sY76w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RT6SL6BoNbQDubygMIZU942EfQQC/h0MUb7zwlWo5b71EFD9G+5hiSTy7dcofc++y3/S7SrhiLm5UHApL4z5pP5I7KwsmXZrCxu9SCni0e/sO6ix6X4mNgBe4KsZS9+f/Fu3sQ0OcaeDhAFtVS+VOPJ5vyHpE6Kb9sk5KOGZg4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2o5G0zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A7AC4CEF1;
	Fri, 27 Jun 2025 00:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750983589;
	bh=/gSgrljG7eAjzXFe8hf2tvSNTEmVpGZaz1Bti9sY76w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j2o5G0zj6/1UMIsC7lenn0zlPElsXrFhtqVE82YvGJi3dhRhvvVbQAdN3cs+nhMAy
	 6GPtI+obQDUgEB9CEB31X8KmjtWgj1TYBSQHe3Tahi28J2re4o26adXlIcbUn+IsVx
	 aN9TVX4YkUaEj8Ppv1j0moZqQmiDKE/zhMIabiBnc5czxVfUKhJtyk4qia4YX7VoUe
	 mop8aE9865eX3v/OKCNznkBcKipVxJZGJZw2bzs4cnWS582KK5DbYNSQCu77cZS5Gi
	 JodY6qfTFOEwr+BYCEyTZMvQyaGXCRxnO0ShOGH/b1p8GcnQ/vYKvHM/1qp1VSB+in
	 mcgZqgOugiWpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC733A40FCB;
	Fri, 27 Jun 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-06-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098361574.1380299.124028561728330295.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 00:20:15 +0000
References: <20250626230111.24772-1-daniel@iogearbox.net>
In-Reply-To: <20250626230111.24772-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 01:01:10 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 6 non-merge commits during the last 8 day(s) which contain
> a total of 6 files changed, 120 insertions(+), 20 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-06-27
    https://git.kernel.org/netdev/net-next/c/32155c6fd9ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



