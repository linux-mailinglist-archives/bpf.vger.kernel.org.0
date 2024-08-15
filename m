Return-Path: <bpf+bounces-37338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2D953DC4
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C261C25490
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B84AEF5;
	Thu, 15 Aug 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOky0PcS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116334A3E;
	Thu, 15 Aug 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762838; cv=none; b=VMwoynMEteFYzBxUup/+nH5tANYXoQOj8ZTLLLHp9WNmelDJSEyRqiE8MYYJ2LWK3D//+zerstq5iOJIEGouODcMNV9eCI2EHgYRbOUhiwIDF6CydZYdCAHvU+7pi5o/S3gdqFQCFLPp2zBYuJWEwC/kkgylGY7Vy6gAP1itxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762838; c=relaxed/simple;
	bh=8VkW66DBJVvsOSTjW4arvwVXOrAbmFsQhOtmibjpEWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qfPdOnCMBU5zNh2k/1EEUpt/JhEJHbX7GfM0tzKkKZzF4hQSWr7dbvcI9RwqKN/Tm1ZOh4vQy+PCQ/J+Pl0VoWBSvmqv6bZvKc/DprPDQU5lrtpGJA8/Fa5G45vCjFS5SksKM9MU9uuAXkH9nsI1pwaTOD3g6FZz2RVZjbkhvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOky0PcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78039C32786;
	Thu, 15 Aug 2024 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723762837;
	bh=8VkW66DBJVvsOSTjW4arvwVXOrAbmFsQhOtmibjpEWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LOky0PcSK3RvA4BNfUy4mAp3RMSxys62RFyVu9rVHJUlaMDC14ozYjxd4Q7AjUddy
	 E/+u5Lyf1QXADgwuyKrUV1uLo/4RUav0i9Lm3+WHmZv++nVxMJAyQWadDQZKPR7DSv
	 shFvTILbxyAaNcmgaKVW5SIIsA+w3etA5r6Z1jZIFK9k0PRBshL/Il8eUFkNgW+5Hm
	 Te5OOymcBxTy1Xc48qH5U+oegbdIwQ9TB1pEj2vKXwhOIiTca2FqntVAEn6cmHmGmj
	 CBUM8KfZ3eDcCx05qJA7PfWq+UjqarRRM3jsO9hI3VTLHty4aB1oRiT6Eb/IPkqE2J
	 UqdGNxvAa0D5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB181382327A;
	Thu, 15 Aug 2024 23:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: remove __btf_name_valid() and change to
 btf_name_valid_identifier()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172376283676.3058964.17807853893727172025.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 23:00:36 +0000
References: <20240807143110.181497-1-aha310510@gmail.com>
In-Reply-To: <20240807143110.181497-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  7 Aug 2024 23:31:10 +0900 you wrote:
> __btf_name_valid() can be completely replaced with
> btf_name_valid_identifier, and since most of the time you already call
> btf_name_valid_identifier instead of __btf_name_valid , it would be
> appropriate to rename the __btf_name_valid function to
> btf_name_valid_identifier and remove __btf_name_valid.
> 
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: remove __btf_name_valid() and change to btf_name_valid_identifier()
    https://git.kernel.org/bpf/bpf-next/c/febb6f3e3ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



