Return-Path: <bpf+bounces-41504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA84997952
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2691C20C5A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9971E3DEA;
	Wed,  9 Oct 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPz4oLu/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4B1922C4
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517827; cv=none; b=Ebaeai+YZVlUczmrvCSABE203RmGW5HHPpxu9q85dFGnWRfK9pgO383eriBhTGVE9N+l6P7M11BNbpM1h/Ovxcg1epwMmd/ayRTZRGrcjUsYodQr8FAffc/bTnAHYTZURqjhhevVKggH/XxL0ueJcpk2Z+X+4vnKjTu/BeYroXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517827; c=relaxed/simple;
	bh=MG6Ljiy65HdAdrcuH2d0ezua/Ii4m8WL7KBYGug/rx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RWM4RtU8AaT20DMQmUJbLd7XCnQIAeCGPx/KQW10cf+a7nmcQ+gxt1J7rMBR4ss8f5vbfSaj8Js+W4iK2iuiwH+eJ/WFtkhUWjdUlSo9WZHfAQ4Alw57GWySDywTIbx1DR8Y0JWQTRtxnvuSjRSdIjtGotdiWcg98xNb3SaZoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPz4oLu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78886C4CEC3;
	Wed,  9 Oct 2024 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728517826;
	bh=MG6Ljiy65HdAdrcuH2d0ezua/Ii4m8WL7KBYGug/rx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPz4oLu/uf2fGFUei7yNUGE2+6G96Yd5Vp6RTytGnlk4sILP/QeXqkjYNq5xjckGy
	 172qPamI9WdoiNFpe3Nqkwsm/khdBdJ73WNKyYf1JqLDz5CY3F7ewn6LoK9ep0dK2W
	 flMZLSS72NJZfQQTmSrOm2LKL3O9kA5sPzcaZSMsepwWHd2FYOTAFt6Ll2TsM6SchL
	 VfSyZdLnAi7mI3pIoOXcy0Aemmgtatl3D86Sj0eiodSZgLsQiQAF3NPXtut7xl7RpQ
	 Ftz1qLD+cX4TAv3wpmal+hey3mftBKomQt1/h91ol2dsgwryf92qOyFEuvvxByq7ro
	 4Bd8a1pzsYtYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB86E3806644;
	Wed,  9 Oct 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf RESEND 0/2] Check the remaining info_cnt before repeating
 btf fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172851783075.1510884.4007844609326390404.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 23:50:30 +0000
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
In-Reply-To: <20241008071114.3718177-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 thinker.li@gmail.com, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Oct 2024 15:11:12 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set adds the missed check again info_cnt when flattening the
> array of nested struct. The problem was spotted when developing dynptr
> key support for hash map. Patch #1 adds the missed check and patch #2
> adds three success test cases and one failure test case for the problem.
> 
> [...]

Here is the summary with links:
  - [bpf,RESEND,1/2] bpf: Check the remaining info_cnt before repeating btf fields
    https://git.kernel.org/bpf/bpf/c/797d73ee232d
  - [bpf,RESEND,2/2] selftests/bpf: Add more test case for field flattening
    https://git.kernel.org/bpf/bpf/c/c456f0804058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



