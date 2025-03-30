Return-Path: <bpf+bounces-54913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AFFA75D5E
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CEC16885F
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA01C5D7B;
	Sun, 30 Mar 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP0K4ZO7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC71A9B34;
	Sun, 30 Mar 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743378003; cv=none; b=JVsv0ETw+7AvBF1DlqlZBJ2jF7+5lPe75ooN3Ik+RoSQppwq78JeOZbH6SwclF5evMgADLBBexnAWXrIkGW2BRm3Rzi5+rrPElt4D17xrx8MZHpBD4Si7UpjMaIHHYl8UqXKHTq22+w4TNqtWVn7fY2tpXwM2enKcySEVbWQZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743378003; c=relaxed/simple;
	bh=hkHJgn5GbQ/gSvA/rsyJW4g21dQ9rrlh58CE5iw785U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nbo3KMiaYhAjGwFNaoJkz9a0Xm91q+UuO6Utek/hbKmx24rWY7fYp1Eb5vO8G3wJSo3tSzIoSmPibKCAV9+d3K5H+zyLZfxeumXpqDw9QKfqD9+fh2n1PdUCE3xGSWBlOXYAFMISZoGUSsuPxDCr5sPudwZf3OlwFkKq0w8ZYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP0K4ZO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25697C4CEDD;
	Sun, 30 Mar 2025 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743378003;
	bh=hkHJgn5GbQ/gSvA/rsyJW4g21dQ9rrlh58CE5iw785U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rP0K4ZO7EupLyukqYqzzERk4e4RNwFEbxMTYWixoYbOfsSvFfPRd2djg9jNwDF9O1
	 Yy239M0dKuih66Y7y9yn5CAIBOZNtoeALI9EXhN1IT5LU+MfSgLB3UCe1iVwwJtQO1
	 qlzIYgCGFz7ufuFiPn644wj+PGXM/TdcQdEZNG6zlxdyYv6FHP9he8A9Eky/xjuRfM
	 1HyutH7BfZMXNWRASxkhZvaqm2pcXJ9hmOXh9gZH2Uc3rrPRXTmsW2Y/Ma4ywH3ak6
	 Vlym76DUR2eNhSvwpHGJzU6yn+DRWKJ1zaqLnAl7r2fwnf9RoxqdqA0NmoKDnweZ/i
	 a4mO/R6JRJD1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDB380AA7A;
	Sun, 30 Mar 2025 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix verifier_bpf_fastcall
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174337803977.3621469.8018512740650620414.git-patchwork-notify@kernel.org>
Date: Sun, 30 Mar 2025 23:40:39 +0000
References: <20250328193124.808784-1-song@kernel.org>
In-Reply-To: <20250328193124.808784-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com,
 kuba@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Mar 2025 12:31:24 -0700 you wrote:
> Commit [1] moves percpu data on x86 from address 0x000... to address
> 0xfff...
> 
> Before [1]:
> 
> 159020: 0000000000030700     0 OBJECT  GLOBAL DEFAULT   23 pcpu_hot
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix verifier_bpf_fastcall
    https://git.kernel.org/bpf/bpf/c/8be3a12f9f26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



