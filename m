Return-Path: <bpf+bounces-52447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63989A42FEB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF7717A341
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50E1FFC7F;
	Mon, 24 Feb 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHInztJZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB41DF242
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435602; cv=none; b=Xlwzr2Wu5qQ+xLgBblFlH9h1jBPfHIuemzCUZmXe4OMgbIpm1KP+mJqFgtDtPx0FzPwxe6CoSNo1cZP6DV9ANZA9ASMISjoIWPl2qRDY1tV/kUdej1Ff4APVFH85yC7s1N0xhMTbat+mb5GD8ZdAJFKDyKWiW4EaimvDJhcI59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435602; c=relaxed/simple;
	bh=1BVcSK8vY8PnNHHajgC8aXrLQelVQUrZoT27RDC8o+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jyrBPz5eGfKxo3kjrbQz+2Z3aC1u1YQcpdUpJ2It15vDVOMtndxzr5+PbNpRkEki8JXfs76yzuUkGekL4SkcPLQR+qBJyzVXME45/j670hwiwe5qdWZf3VGV+HFyRZ3CTW/kQUmADa1Gkhywtjc0gRZKuc83liBc9osYaIw4RHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHInztJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A304C4CED6;
	Mon, 24 Feb 2025 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435601;
	bh=1BVcSK8vY8PnNHHajgC8aXrLQelVQUrZoT27RDC8o+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sHInztJZZkziOJlyu0l22HkkQlIOPO6eMYnnzw17Fn4Rxx1JBH6zeVoxXN27q8UBE
	 tcueK8+TWowPI8SW1NMjPhYQqyO/KZVsJCtTAJzelyDI0RIFe1m9YGUa/9/bwrIacO
	 5QbSowh8ce5GFt9RzgbF81f8Pm/ItSRTkNV1RjdaZsMU16KhTNLE4Q42Ly47hqDuur
	 lwn+CyXZdoBgGkgwlan1rBoppZo/AUYokeX/wkuidhI2n8Aq53InMse+PKsUDZDlGV
	 XQ+2SsQjRZriyefq6UhMx2r0ZAzfFIkCwFNFcdZepkmNpRDY6+5EMDr3nKc6IVa3bZ
	 A0QXeiesgfrkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC0380CEDD;
	Mon, 24 Feb 2025 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kbuild,
 bpf: Correct pahole version that supports distilled base btf feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043563304.3628285.11966484526881480198.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:20:33 +0000
References: <20250219063113.706600-1-pulehui@huaweicloud.com>
In-Reply-To: <20250219063113.706600-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alan.maguire@oracle.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Feb 2025 06:31:13 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> pahole commit [0] of supporting distilled base btf feature released on
> pahole v1.28 rather than v1.26. So let's correct this.
> 
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=c7b1f6a29ba1 [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] kbuild, bpf: Correct pahole version that supports distilled base btf feature
    https://git.kernel.org/bpf/bpf-next/c/1ffe30efd2f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



