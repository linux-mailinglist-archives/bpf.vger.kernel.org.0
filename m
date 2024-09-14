Return-Path: <bpf+bounces-39872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5FE978C07
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 02:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBE31C24F0F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B712B63;
	Sat, 14 Sep 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLo+YOIs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15DD515
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726272033; cv=none; b=n5gyzEQ0iFy3hRHeiTxVscG7F1ZPo+2iXl4gxgFJrYc3rwsYiL7i5HxgN7enGo8ZjZxngPufqYF7EEPYrAGDFY/fSd3NBetIgbkEaQSiEZTxMGQC7hrf16S0wxxvsP4WhZzTql5K6U4R2VYtKo0J1op3nilSty5nvdxHbyNHLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726272033; c=relaxed/simple;
	bh=flkWqWs7e/XPwKXDBp2zCyH4zMg1rvff8/ZXePTMBLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJcNHzjs6Oi3R02LyMKyM6XuC4gog3s3JWdtqh/Al+2dVlCkDN8QkqSLYp1Yq3XKfLGFoirVmeJHW+u5ZDGQaDAyFQBxlS1sru4QOzyPoDv+G0prJtfZTVykaDO/4ArD7sybQ38e6WkZA5Qie0WOleourZa/8KXYVO0qidob42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLo+YOIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D0C4CEC0;
	Sat, 14 Sep 2024 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726272031;
	bh=flkWqWs7e/XPwKXDBp2zCyH4zMg1rvff8/ZXePTMBLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gLo+YOIsnYBjqkXiDt6IZHKW5ye9rK0/PWAzmzc3+jv019qkDko20hOqH18850Qd5
	 hTE3K2bm0R0R076ukgHmvyULDwXRp/2/JspjNt9EqXL6/M61b/CI3DNMKKkhHk5eWn
	 7sY+cIn8NEXVERlqHbFdo2q8G7lzDPnldhjcR9bRBEutPDeMxJpPkcmws++rzf2Uer
	 Jwl96TmwBH+mw1bM9d7730b7nIQILE81QlRTE74sGQkW5YROMndbQTSfAN0EA5Vdx9
	 0Jux2NU4Tz+4BqY+kIHnwxUoVRzrqlAqY8K/wTF0+T29qqeKUEx/Yo0BM4o3pn1thP
	 8ex951S0llcCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB83806655;
	Sat, 14 Sep 2024 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Two tiny fixes for btf record
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172627203326.2405584.13750174567800751223.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 00:00:33 +0000
References: <20240912012845.3458483-1-houtao@huaweicloud.com>
In-Reply-To: <20240912012845.3458483-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 amery.hung@bytedance.com, davemarchevsky@fb.com, houtao1@huawei.com,
 xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Sep 2024 09:28:43 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The tiny patch set aims to fix two problems found during the development
> of supporting dynptr key in hash table. Patch #1 fixes the missed
> btf_record_free() when map creation fails and patch #2 fixes the missed
> kfree() when there is no special field in the passed btf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Call the missed btf_record_free() when map creation fails
    https://git.kernel.org/bpf/bpf-next/c/87e9675a0dfd
  - [bpf-next,2/2] bpf: Call the missed kfree() when there is no special field in btf
    https://git.kernel.org/bpf/bpf-next/c/986deb297d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



