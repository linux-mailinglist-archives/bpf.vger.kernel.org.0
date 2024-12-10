Return-Path: <bpf+bounces-46542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FF9EB978
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF4B1882432
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0C1BC9E2;
	Tue, 10 Dec 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkG5JsgF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683C3C17
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856020; cv=none; b=BpcH7iA3nEa6pS9kaSEn5sWK9Gf2r+oP6M83l5TCC7gtipue25+k3qNGQNzSzpLQUQe9U2nSG4vKptRO03b1MUFYH7G0h/gOVjzC0N4LJjMLHw5MF6YCzodROs64KtSbF3GPHp0qTW0hY0vJ/AN3/Z0L867FCMlfmzeU3HDmas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856020; c=relaxed/simple;
	bh=B2BRGOVxhkcNo6iG/SO6x7sJWaWdynC0Wb6TUqcvFaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EfL91xF18ha7Dzw4G9acmKc9E9BdDBcAIwn65YJUX9DyqMHzIYDwG5M2ZDE5vItKhUyYLAfWc49oApxiPxxTciWVXFsCQV5LiqCxeyg0XB+zHCzUYaZ7T8xrSpj048g+9lr5NnkrZdaefSFOApNTT6RLhgM5Ze4J04Uk+3VBkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkG5JsgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFE9C4CED6;
	Tue, 10 Dec 2024 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856019;
	bh=B2BRGOVxhkcNo6iG/SO6x7sJWaWdynC0Wb6TUqcvFaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkG5JsgFaMse3g7X6St///ktkzZTNFDxArzxxqDQY+/HLC9DfeYLyOaLtGrTdp+cE
	 7VSz1pjLwxDGuzu7Gdbmpsn+9C3wtcqcRhkU5cpvR/ku7A9FlUAaOAtNyxo7qDvCLA
	 8e64PYS1U8U5fJ6LXYz1wLjrQDU/DAQdoCI49W1iQyypfkTk9JqpJG53Klu5nzw3i7
	 LgJoWg+hSp1ZVwGnxw721JWLSYIlfV5V/KXmZzAgVkFIF7SiB+n7uGlI0C9T+/LNjv
	 OnfoUhDn9CV+uVMUzfH7HIuafln8jBoC1cqUVlOr7IPBeVmrEvndeuG0QVlTnbPyhT
	 RZ0LayVoqeObA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9FE380A954;
	Tue, 10 Dec 2024 18:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/8] bpf: track changes_pkt_data property for global
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173385603475.940040.10715587197067593603.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 18:40:34 +0000
References: <20241210041100.1898468-1-eddyz87@gmail.com>
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, mejedi@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Dec 2024 20:10:52 -0800 you wrote:
> Nick Zavaritsky reported [0] a bug in verifier, where the following
> unsafe program is not rejected:
> 
>     __attribute__((__noinline__))
>     long skb_pull_data(struct __sk_buff *sk, __u32 len)
>     {
>         return bpf_skb_pull_data(sk, len);
>     }
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/8] bpf: add find_containing_subprog() utility function
    https://git.kernel.org/bpf/bpf/c/27e88bc4df1d
  - [bpf,v2,2/8] bpf: refactor bpf_helper_changes_pkt_data to use helper number
    https://git.kernel.org/bpf/bpf/c/b238e187b4a2
  - [bpf,v2,3/8] bpf: track changes_pkt_data property for global functions
    https://git.kernel.org/bpf/bpf/c/51081a3f25c7
  - [bpf,v2,4/8] selftests/bpf: test for changing packet data from global functions
    https://git.kernel.org/bpf/bpf/c/3f23ee5590d9
  - [bpf,v2,5/8] bpf: check changes_pkt_data property for extension programs
    https://git.kernel.org/bpf/bpf/c/81f6d0530ba0
  - [bpf,v2,6/8] selftests/bpf: freplace tests for tracking of changes_packet_data
    https://git.kernel.org/bpf/bpf/c/89ff40890d8f
  - [bpf,v2,7/8] bpf: consider that tail calls invalidate packet pointers
    https://git.kernel.org/bpf/bpf/c/1a4607ffba35
  - [bpf,v2,8/8] selftests/bpf: validate that tail call invalidates packet pointers
    https://git.kernel.org/bpf/bpf/c/d9706b56e13b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



