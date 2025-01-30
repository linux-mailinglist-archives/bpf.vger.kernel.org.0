Return-Path: <bpf+bounces-50097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D0A227BA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 03:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B1A1658CE
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299DE49641;
	Thu, 30 Jan 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hka/w5uJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FF4431
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738205838; cv=none; b=QPdo8fbA8wk8KCvFEXflJ01BRjWrejN/jas+MPpz0CtrvnRSVWcodRqDE/1yRyvTEQ51IzgVkMe3Os7Th3xaMbdwyJoMQ4kOZB3RuD6TsUbxTU8FAlxf9r9C0GvlipFQG/TdSGdStfqIHwLIH3FQ1M8vfES3lTU9PiIrrX+4n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738205838; c=relaxed/simple;
	bh=PEztpKOSrIHx9Ut1vcqr3DlMPwFvuwZMl4VISwDERFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qZcA67L+38m2+eZQnwTgv09z2qocCwGbdPJ94/VbkA7xUbHWlbtsg7WC1nce9OBpKvD4EhUv2PZ98cfoxTGXGnpuH480acYbAdnGSnmXmKlrgq/vT2SRnQp+OMwTM9g0X0t2R7wP+iuDcFJ+bSvk6SM09WStflRnuh8YuedCOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hka/w5uJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17900C4CED1;
	Thu, 30 Jan 2025 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738205837;
	bh=PEztpKOSrIHx9Ut1vcqr3DlMPwFvuwZMl4VISwDERFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hka/w5uJl4OKcYpgAW3vwb3lxRQdG91PoZuPmLN1inp21VFWi5GqDj3+kL6DtDLVe
	 FqTyxyKVA5d/FtEGQtCNSqNriu6viJ1TuBx+Eq6MtfLYLloEjpkbpFkqEJ9u9HThjr
	 dvBoDknj6md1Kjmt5F3LcSa5T6dDNSgzXz5FTL5LhxlVBNhKrDLhtVX+wrZYCgjBkD
	 Gat34OMKYCgcJafUosyoLgcjv/G48Oim4U35u47D1PZlw6P7WjNLcT11AsTkNuUije
	 nmM/9FWJ+pl5fhLljoFzjMsnXhMzJp2XkK5kROTdcfJPB1oj1MSoD62D/NmDbdMxbo
	 9P8E4gXjRG2gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714A1380AA66;
	Thu, 30 Jan 2025 02:57:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Use kallsyms to find the function name of a
 struct_ops's stub function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173820586327.497372.16562553927673922341.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 02:57:43 +0000
References: <20250127222719.2544255-1-martin.lau@linux.dev>
In-Reply-To: <20250127222719.2544255-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, tj@kernel.org,
 bentiss@kernel.org, yonghong.song@linux.dev, ameryhung@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 27 Jan 2025 14:27:19 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In commit 1611603537a4 ("bpf: Create argument information for nullable arguments."),
> it introduced a "__nullable" tagging at the argument name of a
> stub function. Some background on the commit:
> it requires to tag the stub function instead of directly tagging
> the "ops" of a struct. This is because the btf func_proto of the "ops"
> does not have the argument name and the "__nullable" is tagged at
> the argument name.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Use kallsyms to find the function name of a struct_ops's stub function
    https://git.kernel.org/bpf/bpf-next/c/9af5c78155a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



