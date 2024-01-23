Return-Path: <bpf+bounces-20145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250F839D50
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7192B27D86
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BE55767;
	Tue, 23 Jan 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amIXzl7A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581F54279
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053250; cv=none; b=s7BUg4Gbx9jpFKZMTeeXBJWP7F6GnRQ6Vg1oz7jQ8y2JxjD/SGy0ZiyKBGu5n6J/7JESoGTufNolz/Jo7LRZ9Ok3wn+GRRe3YkK/o7usCvudaT8E0GDEAdNDVb7gEKczOUGhu6P9cgJ9Ki/qEBSA5wiOMyuOuXp4UYx00h7PwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053250; c=relaxed/simple;
	bh=bFIAYd2JmvAqbGRSNzkT9Haa0t8DeHitLIFL4R/ieBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihrA3BbrcOuG/fK0eMKou2HD2u3nVVZdCNI8gxv2VuBBeE6V23U83ad+2l0N/XsfTyn2gOPnAQgvLTxF4uj+cXF1keh6AI9Ix2PH7om2m5PYA5PEkHfkslI6TCIfYR2C2caFWvKBENKTI233HfrPcGOo3ZrCKgDMe9/IR/QlLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amIXzl7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 187A0C43390;
	Tue, 23 Jan 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706053250;
	bh=bFIAYd2JmvAqbGRSNzkT9Haa0t8DeHitLIFL4R/ieBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=amIXzl7AnicYbdlG90wSRvBX61w0HtPI47XFimzgTXt8Ly0FE0d4yaw9ZLQJCuQpW
	 Q6UVcPWoGluJgtmLw8dAZ2vpwigE6x8TUcqMGSNjgRB8rvqG0yYvYHfAKVL4U0WM34
	 5pMgzg6i1kg6JDwUtI4RMoym8dRLAXRCXyLnadASjnjJaFCWWr5cIGblTvFELrFYiR
	 y/E209I4TkJWM2pwPB1sGkiDAzwlUC3H0iLCvLxKvDwqF2nF6cZnRM+lDkxvyVVnV9
	 EYgRZhs1rdgAeP6BK5zwZviV0yCNjZLyBcfCNCbWUfLhpaNtMHm14dmMHmB+WOiNj/
	 Mb6R2c5+l1Ljw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0A18DFF760;
	Tue, 23 Jan 2024 23:40:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Clarify that MOVSX is only for BPF_X not BPF_K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605324997.25186.9635969435498333979.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 23:40:49 +0000
References: <20240118232954.27206-1-dthaler1968@gmail.com>
In-Reply-To: <20240118232954.27206-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jan 2024 15:29:54 -0800 you wrote:
> Per discussion on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
> the MOVSX operation is only defined to support register extension.
> 
> The document didn't previously state this and incorrectly implied
> that one could use an immediate value.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Clarify that MOVSX is only for BPF_X not BPF_K
    https://git.kernel.org/bpf/bpf-next/c/20e109ea9842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



