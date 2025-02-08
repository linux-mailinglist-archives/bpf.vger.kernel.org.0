Return-Path: <bpf+bounces-50837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E45A2D314
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744433AC3BC
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1014B06C;
	Sat,  8 Feb 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUXOl/uU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E4256D
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981804; cv=none; b=rzHUJoQvgm4R6PcyE4iQhInAb2BxNa1jAhmulc9veylWr2gK8DB81g0E9KhIDtDpPglZJUaFicK90hWdT1pUZpBCR/+fiQ4KWr0tnuH1nMLMRlPMifHQgwQio72Myyin6IZ6lbM+4jGkrDMvzUL8CyUp7g97L/7+VB1d9PncTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981804; c=relaxed/simple;
	bh=65OfUyZP+85ViCNr+Ib1kj8VYCetzh5ziUrDROCnMbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OuzzpDCrglyOMxwAlccHdDrnGXmQMVo+zFTVGrZkwy9TWbwtAEvaDxk5vq3uH1i+68Z5f1WwEnL2H0azDwuPdGZJWzQQg4pWU98575o6HRMyFmujCxU5+l+NS0fsX1D8yvKxeaLnja+PZQrgItBZ2Z8SEYLkc6W8/F9Nu7vFJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUXOl/uU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A21C4CED1;
	Sat,  8 Feb 2025 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738981803;
	bh=65OfUyZP+85ViCNr+Ib1kj8VYCetzh5ziUrDROCnMbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OUXOl/uUP1AEjHavS0mIbRPPXUylPL9LIa2Scav1QCpAxFeKqHZlXrgI59djtmzkC
	 EzYN1EQVoGYKJKUA7T5ne9KQMWsHeCtITkserk/AMEE5+HgVZxxwvk4IQ610Q9rjlK
	 pTbhLz3hbBABBpDVjNhd44f6DDRC4CY3/ojm0vq1agC4VuA6jmXQpFkQmveygZdt+X
	 awfs6pKmtA6dUl6yB5CbQiU4aWyqVEWL5e6xCp0So1qrWxXmMOuaqZbi+l9FJsHHsz
	 YNbyQgW7ifwM/nbcMqDv4KP++jcmI3WZoQAIOKKEqdqsjPOsU74jWXM2Kvobc/HeBP
	 +/jQmVRmnxUSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712DA380AAF5;
	Sat,  8 Feb 2025 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: define KF_ARENA_* flags for bpf_arena kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173898183127.2461149.14441400262793958042.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 02:30:31 +0000
References: <20250206003148.2308659-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250206003148.2308659-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Feb 2025 16:31:48 -0800 you wrote:
> bpf_arena_alloc_pages() and bpf_arena_free_pages() work with the
> bpf_arena pointers [1], which is indicated by the __arena macro in the
> kernel source code:
> 
>     #define __arena __attribute__((address_space(1)))
> 
> However currently this information is absent from the debug data in
> the vmlinux binary. As a consequence, bpf_arena_* kfuncs declarations
> in vmlinux.h (produced by bpftool) do not match prototypes expected by
> the BPF programs attempting to use these functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: define KF_ARENA_* flags for bpf_arena kfuncs
    https://git.kernel.org/bpf/bpf-next/c/ea145d530a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



