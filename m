Return-Path: <bpf+bounces-35023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220393700D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD381F22669
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BC145A07;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHVROgur"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B287D41D;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337985; cv=none; b=dI/u63Z37Ga2cEt4L3RVMkx8ywCqQAy8V6HuA5dx5nMvILbaaB75WDGzK3BGf75KgLKK9viXpeCVbYCmu9JaxtnYA9HcMmjWPBWGTImm8q2jQrfbWkwfOjukj5SCV2krJOoXovqn9teIW/9vtGIsM2onA440B1RMxDKxleT37UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337985; c=relaxed/simple;
	bh=77g5ZKczIGSzBzLBHUU8Ac1bEUef2qHXbszmcms2nQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eLE6JR18nSM9q3OEyxtj+82Aijy2iYCsFzJogqpx2JMr4ZijRo0Y1492T9zSuUuGSZnbed1bUHA6STevDxGqeiXzjeJcEyG8v9Hpl8Q5AVpD88+ymMhxKWgZ6M9mGYXpm33cPZIP7Senddqc0S4/hDm87UmsYckrckJ6Bdk2BXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHVROgur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31F4AC116B1;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337985;
	bh=77g5ZKczIGSzBzLBHUU8Ac1bEUef2qHXbszmcms2nQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rHVROgurr89sVaPAUMWsobEk3lXgy5UAu4MuuZetCKKxmQuC9wjy+uOF+qEU0RggJ
	 wzaYN6HCxSdQXqV6pAMJByyQ1PyylrcOkpTVEeWna+IgBy2t68yh8vo7M4V57ffBoP
	 +pG0mTcZIUzuEkCEaRPbCihwWzrE1PxEylVL0XVJV1dB4tFO23aBkshutW3cVgxXF6
	 woZLlMwphTbMEIJg63TY92C7XDHSLhqeHf3WFB5ZSLSS5D64J/18wvW0UqqQfcoLmI
	 69a4VLeU/wjD0JBHA7CJQrgh+d5gSHobI5zaC/J0sYBBTvavGQVPhDWs34ZdbAW+/R
	 CG42EiD54Ty8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2880DC433E9;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716162714.48febeaf@rorschach.local.home>
References: <20240716162714.48febeaf@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716162714.48febeaf@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.11
X-PR-Tracked-Commit-Id: b576d375b536568c85d42c15a189f6b6fdd75b74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70045bfc4cd5fef44ada25fa3367329eba98731a
Message-Id: <172133798515.21905.3505795977271400771.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:25 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Marilene A Garcia <marilene.agarcia@gmail.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Tatsuya S <tatsuya.s2862@gmail.com>, bpf <bpf@vger.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 16:27:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70045bfc4cd5fef44ada25fa3367329eba98731a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

