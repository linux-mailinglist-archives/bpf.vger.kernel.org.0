Return-Path: <bpf+bounces-38000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48595D959
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E4E1F23BD3
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2F1C8FA0;
	Fri, 23 Aug 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9wH6iVL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31781185B72
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453429; cv=none; b=gHfJlIA//dXiBawu5ElTVrxfhiSvDjpdd/s1482QUnQc0BBl3d4vxiLUZuJ+7At0Zd3Tg6xzhPSVRqz/L+l49krepqyBcEGJa9fqlNKprg4jBwyxJr6XycQg/+gmOKoNWhUDCrrcg5Te47wWCeMJYKel3dccH20alEYCIUOqzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453429; c=relaxed/simple;
	bh=/c0maHixoMlTgzzjjPHmvfmJyXeRcxT4LqeWoyO8Wp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oaTXdVWunLb2jEo/08SFXjFG4tED1xqvEST11hlLwZFIglaVtkcmm5WOtZpifYZg6JihjIXfItklnr6DxoeAg5ICVUdvXa2Lb0EZ5jLRS7atXt0SxJK3S3VxWEHq3KAWPs5c9Ar4Zag3j8u2lo0lCJiccSdbgugaLr+LyKB76JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9wH6iVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096BC32786;
	Fri, 23 Aug 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453428;
	bh=/c0maHixoMlTgzzjjPHmvfmJyXeRcxT4LqeWoyO8Wp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f9wH6iVLDAh/iYcJMlQlXj637Rr7/IWlJhOEYJZhy5/3LOGv9J4L8yeNc8kn3KzAE
	 ZC1r0wibPBXxXBzA9f9JGGZ4XMASxjZ0Z4vMgYleY+n24KPEvcWqcWb8BAlLowjw0O
	 bh+HiHZJI9SLwFt7uoxlqMxDbW11gL/JzQHK2s4clw4PZ63fYk/oGuxcC+lWOAW7hK
	 aL3eQohyIw3ucr1E8vImkWvm9a+wz7hedleXhCGp7fxhclfBmYljJPLHrfSi4GUPq4
	 l5RRLPU8DMHSsuUICGstNs8PsuyLDaGhTTS1QM7dgv5VT4VCZq/akaI8BjVsRVM8Ob
	 uPZbTlP8q6NHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD023804C87;
	Fri, 23 Aug 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v10 1/2] bpf: Add bpf_copy_from_user_str kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172445342852.3104518.6878679528114082010.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 22:50:28 +0000
References: <20240823195101.3621028-1-linux@jordanrome.com>
In-Reply-To: <20240823195101.3621028-1-linux@jordanrome.com>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
 sinquersw@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Aug 2024 12:51:00 -0700 you wrote:
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
> 
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper except it includes an additional 'flags'
> param, which allows consumers to clear the entire
> destination buffer on success or failure.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/2] bpf: Add bpf_copy_from_user_str kfunc
    https://git.kernel.org/bpf/bpf-next/c/65ab5ac4df01
  - [bpf-next,v10,2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
    https://git.kernel.org/bpf/bpf-next/c/ddc3d98807dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



