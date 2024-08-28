Return-Path: <bpf+bounces-38290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEC962CFC
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96CA1C222FE
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D441A38D5;
	Wed, 28 Aug 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCJYn5/2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24013775E
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860230; cv=none; b=eQ/kjhH4p2psrKHZpKJYgW8tB19rGH2saf2qr4KBCQOCFhYgR77LnqU74E88q4vkIGijFqh096R5L6r5XtHu30bJbGGQYYNr2rTo+8/DAVWp6XDShu/WOsGfOe7E0aGUpUPLc8n2wAjuV60ll9lMFMtTBPYgU7lU+TpF/xZGoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860230; c=relaxed/simple;
	bh=7roXSqMPGG0T2MbW4zqRIlN7e12J2kL/x1PGdlulMKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hi+b1UQhzh5QX71j79NxQY5na6MqIjYNf6ToRv9dMrWqeTpT782HHb+UFlpfihh3CqQUrwmv+3DAKnTX7hh88Qfz/ud+VoTU0h01200CKv+6s9d5N0BqnZGEjHjVxmRnTzb5m7ERlLsDE60kPjjXHnxBJeQYw09wV5jF5zJ2btI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCJYn5/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA192C4CEC7;
	Wed, 28 Aug 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860229;
	bh=7roXSqMPGG0T2MbW4zqRIlN7e12J2kL/x1PGdlulMKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oCJYn5/2FRSDrIYEqZHlw+95NmbYoPpcsL3CV8m+zI8el3X9DbotpoA3Z68Q49YRh
	 f3jhzyaBP26QbhHVKHeLemCumWDYBZHg1Lfao42+k3VHDEq8pyl++eIqttx2x5QLhy
	 98j8a6nOPVgc4yrG9gNYEzmO+grHowYQBgLi+w5b2MbMg25C+g46SrNeuGgCohHJ6G
	 sNp5E3l52AURqpJuW/V+WY4ztpPunLjUZgrmG+xTKH/iIKyKESreabAhAHzIsU8V5S
	 L9jeEc/ofmhUBWkhOSYegPFaNzIrxdzFpfWi5j3PpazZIICnLJEcsiabWuSduPSTz4
	 fBYHwY1UEdUJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD4380666A;
	Wed, 28 Aug 2024 15:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf, arm64: Simplify jited prologue/epilogue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172486023001.1307876.17308113588830601988.git-patchwork-notify@kernel.org>
Date: Wed, 28 Aug 2024 15:50:30 +0000
References: <20240826071624.350108-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240826071624.350108-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, puranjay@kernel.org,
 hffilwlqm@gmail.com, catalin.marinas@arm.com, will@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 Aug 2024 15:16:22 +0800 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> The arm64 jit blindly saves/restores all callee-saved registers, making
> the jited result looks a bit too compliated. For example, for an empty
> prog, the jited result is:
> 
>    0:   bti jc
>    4:   mov     x9, lr
>    8:   nop
>    c:   paciasp
>   10:   stp     fp, lr, [sp, #-16]!
>   14:   mov     fp, sp
>   18:   stp     x19, x20, [sp, #-16]!
>   1c:   stp     x21, x22, [sp, #-16]!
>   20:   stp     x26, x25, [sp, #-16]!
>   24:   mov     x26, #0
>   28:   stp     x26, x25, [sp, #-16]!
>   2c:   mov     x26, sp
>   30:   stp     x27, x28, [sp, #-16]!
>   34:   mov     x25, sp
>   38:   bti j 		// tailcall target
>   3c:   sub     sp, sp, #0
>   40:   mov     x7, #0
>   44:   add     sp, sp, #0
>   48:   ldp     x27, x28, [sp], #16
>   4c:   ldp     x26, x25, [sp], #16
>   50:   ldp     x26, x25, [sp], #16
>   54:   ldp     x21, x22, [sp], #16
>   58:   ldp     x19, x20, [sp], #16
>   5c:   ldp     fp, lr, [sp], #16
>   60:   mov     x0, x7
>   64:   autiasp
>   68:   ret
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf, arm64: Get rid of fpb
    https://git.kernel.org/bpf/bpf-next/c/bd737fcb6485
  - [bpf-next,2/2] bpf, arm64: Avoid blindly saving/restoring all callee-saved registers
    https://git.kernel.org/bpf/bpf-next/c/5d4fa9ec5643

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



