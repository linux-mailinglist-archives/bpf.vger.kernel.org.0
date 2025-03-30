Return-Path: <bpf+bounces-54904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C37A75C47
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4853A9144
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9A1DF25D;
	Sun, 30 Mar 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLLC8SqJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDA1DE882
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368724; cv=none; b=azxY/4Nsel02Htf1bGLQRtgqRa/P8wBshdD4zlzbbKGgk/4jQ++r8knvrL0RzueHHU7o7OoBrilyWTVaQQ3Ak1pv6czBc2bIC46iNj9BqvSwJi8+UPBsNzslNUnNHlObRgvNT5RPwjVOL/tFvlIDSWLctnxR1skH9NHh4bWfkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368724; c=relaxed/simple;
	bh=HeAO7GT3w9AiOIPcMRQx7/DZvejqpnElnoRC5FUQX1k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cjY8pm7GeVx+Ta+Gj7m0WyFga+vZAkN2Rt5wuIgXR6zzQhBeAw3J0USMQ2bf/4fZWKi6yne9cYvUautD95CsHQ/0sqZ2tnMyLkHxyYThFpU63YypUBI6CbKlX4Rqnw9RnLJa0qKSnc850WyhILh6+7b0TjnJA5T5T5ii1CLEZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLLC8SqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ED9C4CEDD;
	Sun, 30 Mar 2025 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743368723;
	bh=HeAO7GT3w9AiOIPcMRQx7/DZvejqpnElnoRC5FUQX1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GLLC8SqJucY/IE0ziuCBRCM1DW3daj6oPbryGofbOU++DQX3yKm8GPFoF3wuLbTZi
	 zdoI94KArBalbH+Fwd7fi4eai7xuzcwZe4XTbUu3L1v/8Fz613N9JSPCwzvHI8jvq/
	 H7b9AAMaIqVSbENjBP6+E/uTQEvcTKcK8SocachHao/lpsh0Je57HxS0JI6XqpRz8s
	 ZswKfK3/YWiHnDkZilZhYaZoKf35hOqWizGMB2BcbLrY2ythhmueUFWAOyqhRsvw6g
	 Praekk+rdCKXbrYOSlFbAYeAyLqFY6kGzxCyz7+343rWM6TQvuV5EzNTrLqGL9oUT8
	 i6ld8U1B3n9qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD8380AA7A;
	Sun, 30 Mar 2025 21:06:01 +0000 (UTC)
Subject: Re: [GIT PULL] Main BPF changes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
References: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.15
X-PR-Tracked-Commit-Id: 9aa8fe29f624610b4694d5b5695e1017c4753f31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa593d0f969dcfa41d390822fdf1a0ab48cd882c
Message-Id: <174336876024.3547747.60172735145321555.pr-tracker-bot@kernel.org>
Date: Sun, 30 Mar 2025 21:06:00 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 10:40:13 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa593d0f969dcfa41d390822fdf1a0ab48cd882c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

