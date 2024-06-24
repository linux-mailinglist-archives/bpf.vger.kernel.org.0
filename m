Return-Path: <bpf+bounces-32940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290D915793
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906271C21333
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806F1A01D9;
	Mon, 24 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFIOVQOw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1B4502F
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259831; cv=none; b=kFNYISIDo5GGMVvg0mVImf9CCfBCsucYlLALhoWeiKzZScT3K/gsAUpbc0FU4n0M3yOZltwkHsBaZ+AJk/o9XEMwUWdNSvBWvqqtAzknXizENcETI45lu1Pt59AoOVTOo4r+MCVeesIrTSQcjqLdWDoYR7CZ36W6SZPN8WjnQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259831; c=relaxed/simple;
	bh=G5F1R9JCRZBzeeEzqkheUrnnPwkWQxn69IKEz47qCGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYGWozEG0lAclm1CLJ0hgJYRlse081rNvfBddRG8ZTfcaKtsQxeKml8CWyIxY+qh7QEpfvref+pTFZxrwe0FW6qTCacac7sLFAUJNEbpnuNaYDaE2Bc5jblaBS3ZOdZtyF9xvcWWziYxKj3lAR1DrL+1RCfnhEak0D0S0EXJfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFIOVQOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D1DC32789;
	Mon, 24 Jun 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719259830;
	bh=G5F1R9JCRZBzeeEzqkheUrnnPwkWQxn69IKEz47qCGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFIOVQOwhxrgSp44Ui2Bo/IQ+C2W16w7T7klMtXWWKCKjyoVpDxzIt3PvnINz7eMe
	 NBPYnC11YcrwVh0N6sYJVkN3rBmTOMf0MDdqqBCITWCiJmM7AvSTlutstbYtwLt2Qy
	 nExO2YjUuqA1wikDqZ48WrsFDof+jBGS0+QGDuj85G47rQl6sniVnJXBz6576880u8
	 47c8wD8T9OxaPp+gPXuFwXa16KbBSn21gumsMgW7v5pIZJ+oGMo9vgkDiyaWlLDcEl
	 GjPaRgP8gkv7qcW4uyHIl152qRmPE4fagMzQk7qqE/c+GclRBKGBBz6nFcxSwwQ65l
	 JKpqztHEqTp0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D362E01F21;
	Mon, 24 Jun 2024 20:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: skip base btf sanity checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171925983043.10245.7618604092498222479.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 20:10:30 +0000
References: <20240624090908.171231-1-atenart@kernel.org>
In-Reply-To: <20240624090908.171231-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 24 Jun 2024 11:09:07 +0200 you wrote:
> When upgrading to libbpf 1.3 we noticed a big performance hit while
> loading programs using CORE on non base-BTF symbols. This was tracked
> down to the new BTF sanity check logic. The issue is the base BTF
> definitions are checked first for the base BTF and then again for every
> module BTF.
> 
> Loading 5 dummy programs (using libbpf-rs) that are using CORE on a
> non-base BTF symbol on my system:
> - Before this fix: 3s.
> - With this fix: 0.1s.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: skip base btf sanity checks
    https://git.kernel.org/bpf/bpf-next/c/c73a9683cb21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



