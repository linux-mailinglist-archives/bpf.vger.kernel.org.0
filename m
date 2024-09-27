Return-Path: <bpf+bounces-40435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2087988B5E
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F19DB20CBB
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5D1C2DCF;
	Fri, 27 Sep 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFjLtcB9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1031C2DCB;
	Fri, 27 Sep 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469633; cv=none; b=kHvkXHtUGT9eW0DB+SxzgrcqpBV248TZ7xxqRWd0m8ShraomcN7hRcg1c5t+BDWFqBzJ91ZnIV5fXyHq0fIwiMmdEGmOWEHc0xfhZDZm2Eqi+4K9OSqB6VuB72455xqs7bo2PVCPjgftqfxOpp+KvSwguZBIHKj1Qj7i/Qu5tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469633; c=relaxed/simple;
	bh=+sz5urEjsCgvciVxUL0yOMi9V7oh/+8lIblrjzzcBeI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WBkUmFb8mcgap8JEwsSc2zle0Bc9iAFQDqJN0W6jfqqpJcziuR+cakdXRbqsh4TU53NyWMVodhuiyWMiMYNFc2uVxIrNDLk5geRqMaPycoXnvbOKnEHSp2jgyJg9UJe0yv16ONB8SrvER8xTiQqJxeuoA2N31l3Vp4uMBKSa720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFjLtcB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1099AC4CEC4;
	Fri, 27 Sep 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469631;
	bh=+sz5urEjsCgvciVxUL0yOMi9V7oh/+8lIblrjzzcBeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aFjLtcB9F2M/mRNR0AVDVHeUTsVq+tjkLQRYWzzi2S8rONwir4//k4KtRoRYzAuiK
	 UtYK+oC9/p5dIrFwRL20VxOV5j6xfI79Fs4Sa8cGApv43ULpkxb4a1YOsHu/TYd5hA
	 vfWijENaMmfvemIOU0JxzlglNhP0bWZwsIJvsYteFyR7nIMvDuOwYOnTtTLut3+PtX
	 7enY/++/UuYPOV1YFU0aP9EsDiqMtIjX9SKHefQrRuHEqjq3PxErKD6vXs/qydhAOz
	 rQ7z5PK2i2bQh/W5dZJ2ijcqZ+RLrVJiZMYsH2W/hRKY8X6M5PC87JDCngw7wrkvne
	 RIBtr2lKj4OcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2A3809A80;
	Fri, 27 Sep 2024 20:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Call kfree(obj) only once in free_one()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172746963350.2077014.13816010989127648487.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 20:40:33 +0000
References: <08987123-668c-40f3-a8ee-c3038d94f069@web.de>
In-Reply-To: <08987123-668c-40f3-a8ee-c3038d94f069@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 houtao1@huawei.com, jolsa@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, martin.lau@linux.dev, song@kernel.org, sdf@fomichev.me,
 yonghong.song@linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 26 Sep 2024 13:45:18 +0200 you wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 13:30:42 +0200
> 
> A kfree() call is always used at the end of this function implementation.
> Thus specify such a function call only once instead of duplicating it
> in a previous if branch.
> 
> [...]

Here is the summary with links:
  - bpf: Call kfree(obj) only once in free_one()
    https://git.kernel.org/bpf/bpf-next/c/b295d70db5e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



