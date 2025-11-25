Return-Path: <bpf+bounces-75513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2309C877C3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E8714EA429
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E72F25E0;
	Tue, 25 Nov 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj3X0s+E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408C2EE274
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114048; cv=none; b=o0GgniHbP/mA3Oilm72g/WlaHnKKmHs2wDaJB3dgmhxx4YkC4bxREpPoEo2/zp2h9+cJNzpTSZkfLlHTHXdNN7K+HP/OF5xc1i40bI9UwRuEj2wXdu2f8Yf857sKKYHQm19GoszBQk4GVUn5+2SFVT1zBIL2tyCGNcmX8t9ynVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114048; c=relaxed/simple;
	bh=Ukj+mqA89x3cGJX1sBI4mC+MoLedw6nQXnaFo/7Z8Bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZB95PTMEokYZA+NjvBB24u+yD+9z5Ybt+PhQvt5AoupEMeMPplmlUH5QXY4XDBRKyE2HTdQZfQ3cIfCC1UzCLqStT4mhBZNicHtMLqqHl1W9s40qwm5j4TATGTiVYxebmYV1IFpMktzEZwf0vqZtABTu9lbpP3gBRyYDoXov0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj3X0s+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F5C4CEF1;
	Tue, 25 Nov 2025 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764114048;
	bh=Ukj+mqA89x3cGJX1sBI4mC+MoLedw6nQXnaFo/7Z8Bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sj3X0s+EdyMqzKonTSdVoA1yASXAgPX4FMIDSUbNuUL0y3ZTYUIf8svaTL2Rrfca0
	 8NdARH6DUGBNAtfQjIbE3tvLBwaLfGmfEeREc28FO1nKrFpuk51JMFjczrbKsZ9/lN
	 fOvOS1cE5HR50u8HDDaetcPG7O+Lr9lUsMDX3h/In8VCraDOXG06sEQTi7s3RylQtc
	 2zgnMjOsrHcgj2l93ufe0FNczyPPnT04qHgWXVFzAFSIjKMsC/LAydOZCWjb8tQb8N
	 0oh0M+PXp3iN6slnPyUXAC6TBLTNxVqew7ATAJ1Pdq37aHwr/leQpTnfgx9MJkMAGw
	 GlmzXJVlT/2sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED8380AAE1;
	Tue, 25 Nov 2025 23:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] General enhancements to rqspinlock stress
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176411401075.953309.1687282751140868871.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 23:40:10 +0000
References: <20251125020749.2421610-1-memxor@gmail.com>
In-Reply-To: <20251125020749.2421610-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Nov 2025 02:07:46 +0000 you wrote:
> Three enchancements, details in commit messages.
> 
> First, the CPU requirements are 2 for AA, 3 for ABBA, and 4 for ABBCCA,
> hence relax the check during module initialization. Second, add a
> per-CPU histogram to capture lock acquisition times to record which
> buckets these acquisitions fall into for the normal task context and NMI
> context.  Anything below 10ms is not printed in detail, but above that
> displays the full breakdown for each context. Finally, make the delay of
> the NMI and task contexts configurable, set to 10 and 20 ms respectively
> by default.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] selftests/bpf: Relax CPU requirements for rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/224de8d5a30e
  - [bpf-next,v1,2/3] selftests/bpf: Add lock wait time stats to rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/6173c1d6208c
  - [bpf-next,v1,3/3] selftests/bpf: Make CS length configurable for rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/88337b587b8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



