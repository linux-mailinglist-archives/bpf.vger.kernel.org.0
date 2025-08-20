Return-Path: <bpf+bounces-66085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4EB2DD3D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925BA168464
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88E31DD88;
	Wed, 20 Aug 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqXHP0QS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618E31CA78
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694797; cv=none; b=beqxv3Bfel8jknC5qEx2u4Wc0qyPrTBCAQcnbQselMLkieqozkPaeOYdzGzMojEio6sTyr2sMGpoJuJVCPBRjRGku3zZc+aUIZbx1cTdT+HQcICPql5c9EYWsqA81B2o4/LBlsN1Fgqp5ZblxfziPH+aksUNEDgxRbgOFMFfZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694797; c=relaxed/simple;
	bh=nK4Jr2iAGMn+t06bA5WF2xPvcT3St4BadW/igf7EeOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UwcZNuV55V2xqMivNb9EQilDEquMOTxghFrU0og53oqJ/DyjVOexSjZ+m9+fNkRq1tswxxpXGwgbGZDJnOhpeBqtQ09XsrKWTIdE0y81DBmU7gLC7DLTG5MoHMPbMvfWj9UlPDxz3BxG47/sq6vXQzWu/XhC07CB2qjHubn/T88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqXHP0QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C93C4CEEB;
	Wed, 20 Aug 2025 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755694796;
	bh=nK4Jr2iAGMn+t06bA5WF2xPvcT3St4BadW/igf7EeOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LqXHP0QSm903H5dTKbjUR/LFCLzIBYr7SOsm/dTvibj5svUEPfnsqv6/zAqV6fDKO
	 4LHIisJG6zFRE2oJS4qeTITgdV0EEAdndptRNGFFmNu0DTEc/qVxx3VBonLYTAKvae
	 q+0PF0yvwQHgY5R3kq1UTFr5j+LCp04mSgKs6Bas6hvNBk4UR4EydSri4Yk32gXYeK
	 Njn1upfe/nn73tFLDYiRFfCdV7BIkkX/uGiTD9n2/+JOuUk1hvmZY+8Rty/niNu3VJ
	 S8WLLoW3LE2WW0H/zOwwq/K4PB4HVMy83asEqWC6ut+mklJr6NB9Gt1APDi0IVh4w6
	 L6VZgfPyirrfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C03383BF4E;
	Wed, 20 Aug 2025 13:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] s390/bpf: Use direct calls and jumps where
 possible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175569480626.226748.2627236785124780537.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 13:00:06 +0000
References: <20250819102116.252203-1-iii@linux.ibm.com>
In-Reply-To: <20250819102116.252203-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Aug 2025 12:20:38 +0200 you wrote:
> After the V!=R rework (commit c98d2ecae08f ("s390/mm: Uncouple physical
> vs virtual address spaces")), all kernel code and related data are
> allocated within a 4G region, making it possible to use relative
> addressing in BPF code more extensively.
> 
> Convert as many indirect calls and jumps to direct calls as possible,
> namely:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] s390/bpf: Use direct calls and jumps where possible
    https://git.kernel.org/bpf/bpf-next/c/b5bbbb70e5f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



