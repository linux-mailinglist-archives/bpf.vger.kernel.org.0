Return-Path: <bpf+bounces-34344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA492C848
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DC21F236AF
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312BBBA39;
	Wed, 10 Jul 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfZnLRO8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60B847B
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577432; cv=none; b=iuMhWSNkaSw8azL6wyF78Ofn4iaGmMoZRDFr77Obrm3f70F1pT9/wcxC9RXVFWlFo5xQFVzijCr3ORTMyevXKcGTM2OlWLOitCLm8En1tHDcbU8xfsBEStXFZ3cJctzZ4a42RKaDyzFYcHOw80eabDIhVomARJb2uxio6f4hc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577432; c=relaxed/simple;
	bh=/zs5ksXYWJ71B9W31ElXwlUCcgSebbV8mWFUiBhdRCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAYZHSUNBdLvXLBnAojjKqoAeXeBRmGuAwYa4FDubcYTktjlYPIZtIM1VEYeOBOKRswElcjuNZ7J53XgZyiJ3gY2Lv7MGGctpicDAZ+nepPDjuUMAwaLjnUbdVxmKje9P9tQOinNToBcnUYnqCHsrjYAGrYOBSFr3Rb+E/jrDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfZnLRO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A92BC32782;
	Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577431;
	bh=/zs5ksXYWJ71B9W31ElXwlUCcgSebbV8mWFUiBhdRCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfZnLRO84njIaR1DoH83cMkp3RLXCvolEHIoDs6QlDKR170klI9D71DpiPOvgml+l
	 r5FU93D+rMXhg5YPmxT3e69SbCrvO4lmC0IZd7IZyt12SOzqOFwYMZye3PIw7I/5hF
	 BYfpwYGkIdrVio/qnkGZCkYbCCoiCY/2ghJ3FKkOH8vsQjt4diNNP9D9oQagO9/89r
	 DT1Jymh9wO3XXYvKCht/tcGPYSbsjjhUaefQrjPvuh4fT5oJAjW7auU5Ltq0Y0v6sK
	 sdnmsAwA+M+viK82DutatOPSLdWyseQpSA0nmInsEcgUywTyQch+PS2+/imD/vS1Y+
	 PFf8wXd8+qM7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15D1FC4332D;
	Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/3] Fix libbpf BPF skeleton forward/backward
 compat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057743108.1917.580054394368940459.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:10:31 +0000
References: <20240708204540.4188946-1-andrii@kernel.org>
In-Reply-To: <20240708204540.4188946-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  8 Jul 2024 13:45:37 -0700 you wrote:
> Fix recently identified (but long standing) bug with handling BPF skeleton
> forward and backward compatibility. On libbpf side, even though BPF skeleton
> was always designed to be forward and backwards compatible through recording
> actual size of constrituents of BPF skeleton itself (map/prog/var skeleton
> definitions), libbpf implementation did implicitly hard-code those sizes by
> virtue of using a trivial array access syntax.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/3] bpftool: improve skeleton backwards compat with old buggy libbpfs
    https://git.kernel.org/bpf/bpf-next/c/06e71ad53488
  - [v2,bpf-next,2/3] libbpf: fix BPF skeleton forward/backward compat handling
    https://git.kernel.org/bpf/bpf-next/c/99fb9531886d
  - [v2,bpf-next,3/3] libbpf: improve old BPF skeleton handling for map auto-attach
    https://git.kernel.org/bpf/bpf-next/c/a459f4bb27f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



