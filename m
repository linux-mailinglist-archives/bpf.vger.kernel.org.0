Return-Path: <bpf+bounces-39026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B096DB01
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40B71C24F50
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821E19DF4C;
	Thu,  5 Sep 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1qoVU/Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C1188A1F;
	Thu,  5 Sep 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544830; cv=none; b=NgyuhFxcd+VkEziGFM10fcPagY+/DYBsytfnorylF1LCQoATrMJqD7ZRglpbht0Nwee/HoXNe2u+g1rKw0RRX6ZUIg0VW+LJ+e3V5sUktlgdq58Ji4shCJouF3ERBCIkgKrWYoq+RdPgm64sObZ6/6Y7JEcl9INnXUY5i3AOwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544830; c=relaxed/simple;
	bh=A8l4piqTQI8Mrz5dGmHPoPTePsjVSTnytoQfZFIWWjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VmI+XTV7kY9VYcpJUVqbKZAg2VQGUV+mhfXRtJp+E5rWuRdq86OhXy8LA3hDFGoLoweO2PkV6kNUcC6sM/gC+ZYAkm/1ai6YXMYOhsUBXb+F3TrVu+jAb4hUx+bdU6NWvLLJopEaDI0+ojpiN0x+Mn+NbVknaxJsHxUbp/wRR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1qoVU/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CD0C4CEC3;
	Thu,  5 Sep 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544829;
	bh=A8l4piqTQI8Mrz5dGmHPoPTePsjVSTnytoQfZFIWWjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1qoVU/Q3P/OJVGfCVerPdFkUzbPlL+2M8CfOy+uGAQPEnnqH7tylMVK+sCV3uFiO
	 Na3221RLEmfJpMax5wWk3eHN4pOKC7V+ZUem18gUoGxjp0gWSqIrUMvH11JAOzkK7H
	 /oeexkLfCkiU9tTn2z9fzew38/vtWdbd56rTAOnfP04SruhbXUJDkplaPmbMb0pu1N
	 zhTUbypTofAmXNpAkR1/DxDHJ4WiqDENDmXpBGyVgOzPoi7u2EWTp0/G5e6+FtuQ/w
	 IT4F4K4bjKBUDYtLZwkfQbIya7L54cttc2mL335BlWXwMQYJqUC8tzrOoEnHQLlc+r
	 D4wyJToOHgrUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBEC73806651;
	Thu,  5 Sep 2024 14:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: bump xsk_queue::queue_empty_descs in
 xp_can_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172554483081.1700166.14653164106690090613.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 14:00:30 +0000
References: <20240904162808.249160-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240904162808.249160-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 bjorn@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  4 Sep 2024 18:28:08 +0200 you wrote:
> We have STAT_FILL_EMPTY test case in xskxceiver that tries to process
> traffic with fill queue being empty which currently fails for zero copy
> ice driver after it started to use xsk_buff_can_alloc() API. That is
> because xsk_queue::queue_empty_descs is currently only increased from
> alloc APIs and right now if driver sees that xsk_buff_pool will be
> unable to provide the requested count of buffers, it bails out early,
> skipping calls to xsk_buff_alloc{_batch}().
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: bump xsk_queue::queue_empty_descs in xp_can_alloc()
    https://git.kernel.org/bpf/bpf-next/c/6b083650a373

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



