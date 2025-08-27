Return-Path: <bpf+bounces-66735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F0B38E4C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36B33B66E5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730943128AC;
	Wed, 27 Aug 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgGJXsFd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC23311C3E
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333203; cv=none; b=gTKbbeK2VBZG55dmUc3thPN5xfiMogmlOt25mE0QUw/NuMOFBn8rDm0PpXGqRyj1kcK56EZM40hpbVygCIFYntkBTQFVVtgDuxBcrrBXXn+6lTsTxGQuuMYzbcqvkXOA1yV/V2JKMCc8hfjj77tpbmV7r/Ke9MEY+zVWrt0j308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333203; c=relaxed/simple;
	bh=fyMRhL7PPriONHHTDzsMOnsehCYDVe09cBsJ0wP1JIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIhNIHdft8h0SLzauJikhR8F92HEm7osOQCxFKsWHjKTnDEouHRqjmloi/Va1wobPPllHBOKeJyF/gVq+lWCJSTCzoMWwWyYMA0gK5lSiNOCFFd/5xxi8oMI5svEL/KzRGx2sVMahOO4PFph6/upzGl9g29VC4SnxycKKDiUkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgGJXsFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72789C4CEEB;
	Wed, 27 Aug 2025 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756333200;
	bh=fyMRhL7PPriONHHTDzsMOnsehCYDVe09cBsJ0wP1JIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgGJXsFdBqOIUezyri+HUMn0ZHh4ytNyUrUzCluypNjEB5TdIdoCEMsRMyXi2hxc+
	 UlceK/NysTfWdfq08FCW8IhCpOLAhl/nrAIwPMa/DbXsvsZ/YBWYX8qzSIHraYEQCe
	 RxdXKb+DqiDpLIoEmVWeky1YdIjG2NN1p0uRd3sddPF5pnHt3RRSfSgpLRWOKawaGU
	 RvO9yWFTG9ahREOS5h7DUP2jRQ5i4hRx2Fi0xhuJ0OkBPGo5m5LiNf0CqGprMFYFih
	 1FxLIPj6WYGksmUECBBXLemYvPwGqvUlkSgaY5ywcAPXSODxwk4bGJtEEqO6x9z3lc
	 sJdd+PJNQ1VLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBD383BF76;
	Wed, 27 Aug 2025 22:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 1/2] bpf: Improve the general precision of
 tnum_mul
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175633320776.857353.6375443651457217963.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 22:20:07 +0000
References: <20250826034524.2159515-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250826034524.2159515-1-nandakumar@nandakumar.co.in>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: alexei.starovoitov@gmail.com, eddyz87@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jakub@cloudflare.com, harishankar.vishwanathan@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 Aug 2025 09:15:23 +0530 you wrote:
> Drop the value-mask decomposition technique and adopt straightforward
> long-multiplication with a twist: when LSB(a) is uncertain, find the
> two partial products (for LSB(a) = known 0 and LSB(a) = known 1) and
> take a union.
> 
> Experiment shows that applying this technique in long multiplication
> improves the precision in a significant number of cases (at the cost
> of losing precision in a relatively lower number of cases).
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,1/2] bpf: Improve the general precision of tnum_mul
    (no matching commit)
  - [v6,bpf-next,2/2] bpf: Add selftest to check the verifier's abstract multiplication
    https://git.kernel.org/bpf/bpf-next/c/2660b9d47750

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



