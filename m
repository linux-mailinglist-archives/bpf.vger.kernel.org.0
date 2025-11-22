Return-Path: <bpf+bounces-75274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D1C7C0A0
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4513A672A
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37B1DF736;
	Sat, 22 Nov 2025 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfJBH2ND"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C423E325;
	Sat, 22 Nov 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772814; cv=none; b=avZLMzJWFy4tYL9H3NN8JEeRCCKc5d4pCS4AWY35eq+Szm9ITfjgrFbj5VKl8PtVgjSAktN3ooG018XHm2SNqQ5BpAN8+f8hs9lMGDoEviboOSyi5tLs2Z9rYrl1nkldJOhsb7npaC3J9XTP1GqNn/M0FD8DeuB32STmEvYYNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772814; c=relaxed/simple;
	bh=Wvfr7qC6rGowL1DcF2UQq9PSzHQ+VVTYkpQRpo8VDM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=owkIRsO4cghL7PmD4cwyF6abZluNHR8brGm5xAH6JfJBbS5kTVSBSkcwakoZqF0CcpH7V0+OZuQZP1X08vNQT9zL0uu0AZGxU+ObhGdJFAW8/ymEYpIpM06h0OVSWNb/R898gOH+mOAcCbI1sjWCDXlyQvPuM5hO4YYFv7jk+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfJBH2ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BBEC4CEF1;
	Sat, 22 Nov 2025 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763772814;
	bh=Wvfr7qC6rGowL1DcF2UQq9PSzHQ+VVTYkpQRpo8VDM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MfJBH2ND/g3Ck4yjD2MDD22cHniHOzW4iiiMDFl6yTBdmHRAbMhnN53fQ800Wu9Qm
	 NM0718L5nrPQad5aOwdcfeHght7TN+kiB9E98rj7egZOyCoQzxbcFTwEaty0buc7sv
	 6mlXF47DyejgghHBRfH+Z6vcI9IARSKmTW4SmCnYTkExPyxsttMCEcTeFyWD8JNJaR
	 C7y+mbill4I04Tdhl0ENDERpd9fwdA2hrKWotVU4uT66NZrPxL8yXsqmN0R1lmKR+4
	 bSDTOWSDpAsTL3f1mFBwD4CaIXx1E9pG8hWeNmE2+HrHYefs07FARufIO7/XV0xI08
	 FTiGqeHFKGHjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9B3A78AC8;
	Sat, 22 Nov 2025 00:52:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Plug a potential exclusive map memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377277852.2637800.13726063744889483182.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 00:52:58 +0000
References: <tencent_3F226F882CE56DCC94ACE90EED1ECCFC780A@qq.com>
In-Reply-To: <tencent_3F226F882CE56DCC94ACE90EED1ECCFC780A@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 16 Nov 2025 22:58:13 +0800 you wrote:
> When excl_prog_hash is 0 and excl_prog_hash_size is non-zero, the map also
> needs to be freed. Otherwise, the map memory will not be reclaimed, just
> like the memory leak problem reported by syzbot [1].
> 
> syzbot reported:
> BUG: memory leak
>   backtrace (crc 7b9fb9b4):
>     map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
>     __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
> 
> [...]

Here is the summary with links:
  - bpf: Plug a potential exclusive map memory leak
    https://git.kernel.org/bpf/bpf/c/22d70d400556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



