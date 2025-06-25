Return-Path: <bpf+bounces-61595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAEAE911B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061721C25057
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30392F3C28;
	Wed, 25 Jun 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8NQwWHg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB02F3C0B;
	Wed, 25 Jun 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890581; cv=none; b=QYz9i3mrYKlVNEKhF9iBrwemV2ZVzqJUQd+EWq+V7iWiasoyKRCEwZYjQwy98dgXeUSPAnmlRzHBI+FeFxGJdkTvbRvdg+pyhasHBkTn2LKp8LMnsuDw1ojNW7TcXTOerAIWXuA/MrcWm3AxtaM+EcYP74zF4rRyHC6K/smSWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890581; c=relaxed/simple;
	bh=/w6YPmSRYgUdUXYRfXkmQC/XbHDJ6pg+H7vO2QTrNKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FMblxly8q/g12CkgTG/hsPJWLPt4gdEjhdYqGJQBiKMPQPoBLChadrBDH0iLaVdbRifwQs8egLYDzBJotAgZljRo4c2587+6BLzrwQKRY9QW9DMdlbPi6J+IiLrVRIh4dLzWZvi/6YL73qzJ/h28blPj7IrQIChqhWEHesXnONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8NQwWHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33C7C4CEEA;
	Wed, 25 Jun 2025 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750890581;
	bh=/w6YPmSRYgUdUXYRfXkmQC/XbHDJ6pg+H7vO2QTrNKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8NQwWHgmYpFKlI+sOFwp/kSvbFfKaG8uOUpkDP/HB6N6NlNEvz3XUSiLInhJbsfd
	 mitFWElQCUgjSMpZLTgDX/jvNhvv9NlI/LG3DsvXQDgf4EpmMep9iDOUS25obFyn4r
	 K0TT/+UY8ATaQkwIJB1rKm3dmTj+EiF1fydT70w/2oSk4/uTm2r1Gy57U+p/U4PSbZ
	 x08FdnWv7V3yyWfTUSvm9BRemTeJsjZMKJpUv/D6TvQPh8yJkD7svrY9XJXDxEKbNc
	 3OsYUpguKlWZK7O849QWs8nVVuUh7sijZzO2QW6mKvU0Zgl8DVkK/by6EVGsXB1S+S
	 iT6fD2OekBvyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAA3A40FCB;
	Wed, 25 Jun 2025 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: adapt one more case in test_lru_map to
 the
 new target_free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089060751.641624.12110903845868703382.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:30:07 +0000
References: <20250625210412.2732970-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250625210412.2732970-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 stfomichev@gmail.com, willemb@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Jun 2025 17:03:55 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The below commit that updated BPF_MAP_TYPE_LRU_HASH free target,
> also updated tools/testing/selftests/bpf/test_lru_map to match.
> 
> But that missed one case that passes with 4 cores, but fails at
> higher cpu counts.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: adapt one more case in test_lru_map to the new target_free
    https://git.kernel.org/bpf/bpf/c/5e9388f7984a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



