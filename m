Return-Path: <bpf+bounces-73486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B65C32AD0
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A2A42370A
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BD33FE04;
	Tue,  4 Nov 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOn3ThBh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6133F8AB;
	Tue,  4 Nov 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281036; cv=none; b=da2RhpPCoFdut1BfjtBtA/MB+g0rTBvXbPy032UlIpLD7tUd7Kbw6ajxm+qaT1yrZcbmHce3saMRbHbL1VBzm8yOxzvFCB7UMrV/LX9tMhfWnZ8DdvsP40LNFBrMSVumBgZC6qdzN0786GgDN7BRz55F+VMthceSoiltx53RJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281036; c=relaxed/simple;
	bh=a7geEZcE8zgpcKUFaOcbkZCsetwgeMxFqMU9cnrNxTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+gjnKJUddvN2UjS53aHG9CnmP+4TBcBFNVwzaGg6Xl/E2LDtTqVYs1q50I/Zv6vHJjkOyg4J7MMS/psTxfFaRoeEdkuYDXieb45lf77w7Z48ZOMzbksISclhGQF5D96a2/M1xvCSBtX8BzO4PtG+XFK3Bdd4bhyFLSWcBQiXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOn3ThBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A93C4CEF7;
	Tue,  4 Nov 2025 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762281036;
	bh=a7geEZcE8zgpcKUFaOcbkZCsetwgeMxFqMU9cnrNxTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOn3ThBheom1P3mRfVzXDhE13YfKRM0T84JuVUSem4VgTTWoS37DXbDh94l3nkYsA
	 nnAnSknq0kVFPhTwHWPPW/jC2DbGIXmCUZBua4/4UFEYZbPaFeRttFZGtKOCnfqoRm
	 7H2am7hLmGSKMKwUG88sFk73zckEgGbEgBq/RqIxIa6osW9IB13JB8lDYKe0CRy691
	 eCI+QU0FCN8wEhCa38kq97jtCmDQ3o2q9WRhghD4g1EILNDQuSEY0rlksow5kg48if
	 ifetM3bRUq3nZLoDJ2zdV+GuBuI70Tgi1ONDznG5qoWFLRe1srnlFkoV43QV4OKQv6
	 wB0/vqT/D7rpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1F380AA44;
	Tue,  4 Nov 2025 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] libbpf: update the comment to remove the reference to
 the
 deprecated interface bpf_program__load().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176228101010.2956689.5611314609382456914.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 18:30:10 +0000
References: <20251103120727.145965-1-jianyungao89@gmail.com>
In-Reply-To: <20251103120727.145965-1-jianyungao89@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Nov 2025 20:07:27 +0800 you wrote:
> Commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API") marked
> bpf_program__load() as deprecated starting with libbpf v0.6. And later
> in commit 146bf811f5ac ("libbpf: remove most other deprecated high-level
> APIs") actually removed the bpf_program__load() implementation and
> related old high-level APIs.
> 
> This patch update the comment in bpf_program__set_attach_target() to
> remove the reference to the deprecated interface bpf_program__load().
> 
> [...]

Here is the summary with links:
  - [v4] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
    https://git.kernel.org/bpf/bpf-next/c/efa47566ad0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



