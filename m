Return-Path: <bpf+bounces-75381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C0C81FF9
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C94E5844
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CDE314B84;
	Mon, 24 Nov 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt26Aj70"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027662BEC41;
	Mon, 24 Nov 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007253; cv=none; b=MVPUJPLbZ1APBneb7vMRXhq4fAuaWf4xxo2fqkC2R5QIyh0NxOrTlNeNKxzHa/8pRIYJai0bg9jXPiChtCF6Hjo9iv3qVxbL1Yk97ORCd9eLupwrswhsfhX0HE+jBzzvQbpryumURIBDSTQpI4fA+6EcPyxvqTEVhWs/8nXQlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007253; c=relaxed/simple;
	bh=Fs+fOdAmN1Clz0PJjIHz5+puW1Ti2M69nSIhAdynC30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gh/IZDWxzS5FXXKMHM5mzNQG5b4ftWJ6Ag3nLQVdnb0DS/T/KZL8OpOKAAl0EFqob0gr2/Sy9LVxHgJldxwOwBalGo8ai0Td71c/cMbiokNK0m+f4E0vmRnsKtFDzglHh+aPYb5bWOVTfPN2DZ/ziGJ2W9LfTJh+sDWlrmjZyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt26Aj70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E3C4CEF1;
	Mon, 24 Nov 2025 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764007252;
	bh=Fs+fOdAmN1Clz0PJjIHz5+puW1Ti2M69nSIhAdynC30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dt26Aj70GNFKOUpkzi/RSjcSUQ1kAvsyqlyn0Gz9z/8p6i5eSscqGYGAD7KsqVBhG
	 L2Uluh+pi91lTHCA3n+gm0Ed3ULRKYwKhj5QwmkcUHyvxM1R0fgXJwfC/q0IpSJCng
	 fe/V+lta7nfrwkynxLLwpf6g2OrPJmwydEGDXuvxrlk9FP8r01/VfdHfQCcYtJdDfq
	 IWzSflrTTnLr6x/kuTCtVVjPpje+Run0tCTs30K43F8tITQF1AEYjM5FxEUHLn/JWk
	 qUfq8UmHXtQhvpfKJyMzrqw5+QXbYdo6LWw3djxiV2ktoexGxat/gBuIYKlwPTQFxu
	 01RfZsvSDyaQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1533A86295;
	Mon, 24 Nov 2025 18:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176400721551.26255.4099462793867992300.git-patchwork-notify@kernel.org>
Date: Mon, 24 Nov 2025 18:00:15 +0000
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Nov 2025 20:36:28 +0800 you wrote:
> For now, the bpf trampoline is called by the "call" instruction. However,
> it break the RSB and introduce extra overhead in x86_64 arch.
> 
> For example, we hook the function "foo" with fexit, the call and return
> logic will be like this:
>   call foo -> call trampoline -> call foo-body ->
>   return foo-body -> return foo
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] ftrace: introduce FTRACE_OPS_FL_JMP
    https://git.kernel.org/bpf/bpf-next/c/25e4e3565d45
  - [bpf-next,v3,2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
    https://git.kernel.org/bpf/bpf-next/c/0c3772a8db1f
  - [bpf-next,v3,3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
    https://git.kernel.org/bpf/bpf-next/c/47c9214dcbea
  - [bpf-next,v3,4/6] bpf,x86: adjust the "jmp" mode for bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/373f2f44c300
  - [bpf-next,v3,5/6] bpf: specify the old and new poke_type for bpf_arch_text_poke
    https://git.kernel.org/bpf/bpf-next/c/ae4a3160d19c
  - [bpf-next,v3,6/6] bpf: implement "jmp" mode for trampoline
    https://git.kernel.org/bpf/bpf-next/c/402e44b31e9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



