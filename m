Return-Path: <bpf+bounces-63539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CCB0828A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2E1A64CFE
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E81F5413;
	Thu, 17 Jul 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtQ2rWi2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5C1EE02F;
	Thu, 17 Jul 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716403; cv=none; b=VOu/H2x7jnBQ71DjULMjDa5PGLpK5/kDFxvdSElFgeW45ZSjjFS4VlTBxY60tDWMnMsgX6xKBoROSn6IK7oh+PH6/JtXjM8m5grtLR6V70oIGe6tgaxXfbHKOyw9qkkKxTBL/i1o6wdMN7Hi9Aq1qUPIIlZ2jJy1H2JD/Yefbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716403; c=relaxed/simple;
	bh=eWAwC1GBJWP4MMsdwqJNitn5FU+zU5RAmgOfK+oLt6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gx/sk7NtgjWQTQsp1fn58cIYyNQUe3vD1JtuYt2mj7IqL8oBj600D42g4w4iX1H5y0BxLjd+9vCcJKKOBj4mK954uuPiPWrre2BrAUO7HzGrgmYGBNnr9woJ9gZfkT5+rZWSK1hRUsoFQjb1iLPrkFsNBBjnLFgJlbfXt9HuA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtQ2rWi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8B7C4CEF0;
	Thu, 17 Jul 2025 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716403;
	bh=eWAwC1GBJWP4MMsdwqJNitn5FU+zU5RAmgOfK+oLt6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OtQ2rWi2AD19Sxm7KcYKZFZWeKSQ1W5wme+BgWW9eF8Yn4jhJQtmlnQa7H5vH5WV9
	 R1F9oqLeHiG1uYeGU41To4wozRBRXUs7Dc8+mmyfJH8kSwh+GQYb+8Fv8BGb7aVdBj
	 uMIx/ywBAl1ENrJTrRALWEWjH6GgB8p/aC9VZzSNN3TVA+jgstYgK6kvlJLAh8hdSr
	 WKu3ald6c4vwduyJQvc4msVUM1g8OvYGuQ7n3yRQW4+RScotFsdrWcP8NfTjmyB1MN
	 x9ZTFK9fbTVm4S/EqbajhZd8Wr5YEcmDFoVe/AyXDl972If3hPWjDYrhakkPoy/UrV
	 xgPgUxC1P+Vtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC62383BA38;
	Thu, 17 Jul 2025 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Clean up individual BTF_ID code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271642326.1391969.12291957818977082467.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:40:23 +0000
References: <20250710055419.70544-1-yangfeng59949@163.com>
In-Reply-To: <20250710055419.70544-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 olsajiri@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Jul 2025 13:54:19 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Use BTF_ID_LIST_SINGLE(a, b, c) instead of
> BTF_ID_LIST(a)
> BTF_ID(b, c)
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Clean up individual BTF_ID code
    https://git.kernel.org/bpf/bpf-next/c/62ef449b8d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



