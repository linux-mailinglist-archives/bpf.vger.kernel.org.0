Return-Path: <bpf+bounces-47150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D532C9F5AC0
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F9918949F3
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C31FAC3E;
	Tue, 17 Dec 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqxpUVtF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B21DF969
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479414; cv=none; b=YJRl2EVnzVQyBCE1QIQABaoh/P2iClYH7GVa2k7pkuTStpYnrvF10dE6fj8oshcAsXirwMPQldgdGVx31g1Sdd9LXv1+lQyvJUHXmCEwsneYNOYy/lKus4ITI9kbx5xJfqU6b9OCWZvGpkfdCBb1XHFJp4EgCsbg9rHWM+y8KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479414; c=relaxed/simple;
	bh=2C8L4rzNGKb9mCmEkStkyk8IHxYtwgPmEEB8YyYihBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GtzqSoR6augkYY3ucBozxQHl+7rqeI+cLauPxLdtEJM7APUAoXFwqgCYFYzBqj1YFP0arQn6KMTH/mCDmP+o6ALpJJ26IhLwAyvRjXrbVMCv4Zvq60KtnZr9jyRb+xLoE/tQREJeFtpFjP570MMlCv3CbD1bLkbPlIIBjur0nSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqxpUVtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDACC4CED3;
	Tue, 17 Dec 2024 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734479413;
	bh=2C8L4rzNGKb9mCmEkStkyk8IHxYtwgPmEEB8YyYihBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqxpUVtFRMlqNi5qS+FMDsu6PbzAya+lgV/K7mfz1T/TSKk4P9QhpEkGzRb8wBDyS
	 ZdTtJIQYTfUdu1Pby7hewZDEr/c+2w6gFsPg749oj7mbKuNKL2Y0OhFfnMZK9zlPou
	 aXus6yWus3Wr0U+Qd0YWBXqYZcAUSSbZouFyssuIOValDsHq0VtDdISFtU+BpE6rnK
	 85kb+rmOeIFCghwu20TRzPhYRcW3kxiw63sw0eQuy0kmhz0/2V0/yODVmjMYsgiKSH
	 iRfhIp7+MxMPjmqikIH4b12U5DjGHCMDmD0UNB5nIElC26JXJ7WsfiT/x4y21gAQ0j
	 Js9ln2RsA6mGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8A3806656;
	Tue, 17 Dec 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] veristat: fix top source line stat collection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173447943079.1122682.4871367372412446687.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 23:50:30 +0000
References: <20241217181113.364651-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241217181113.364651-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 17 Dec 2024 18:11:13 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Fix comparator implementation to return most popular source code
> lines instead of least.
> Introduce min/max macro for building veristat outside of Linux
> repository.
> 
> [...]

Here is the summary with links:
  - [bpf-next] veristat: fix top source line stat collection
    https://git.kernel.org/bpf/bpf-next/c/a7c205120d33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



