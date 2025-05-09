Return-Path: <bpf+bounces-57922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE1AB1DA7
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A320C3A71FD
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4025E839;
	Fri,  9 May 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdOVVAJK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F523E342;
	Fri,  9 May 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821100; cv=none; b=BbJLcL/K3UBsrY4kHLLxVFs9J+Pv6pJmDW8LXHHw17lr9RSVdJHPfo/cVN/sh+mI5BhpB1xqTrwbsT8XpNANr0r4o479GSIa22kPjq2N8UDF5HL6DdqhuGa13cA+506LqpfjklOXSKSYhrF8vxUMITjTvK7Vcrcnnkdhgt/cQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821100; c=relaxed/simple;
	bh=G9Ob1A7TrPbdEg2c0WtIfJ5OWg0wMqZQyRyWphK8hx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARJpgrwFvCX+SXk6BPiLXP/WRjNhA6ahNjKJmsFJJkZoGQjcrDA7f5M4XlHsOhp8dLQz4d1HeoMl3/EAVmRGYOJ2ygxb//zSL6VEFQX7h82zzWe+Uil2REUeZfTyMNe2czSlqWZpV3ynPfwgafvuesDO4EDaLvQQU5JcVtnoiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdOVVAJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB75C4CEE4;
	Fri,  9 May 2025 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821099;
	bh=G9Ob1A7TrPbdEg2c0WtIfJ5OWg0wMqZQyRyWphK8hx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdOVVAJKMotY/6SzERHTMGsHx5dQJwGTw0cg+EDfDqh1yG6ktIPGJz6wUmlaoqfQT
	 pZ1n5d+JaA04RsAaDTgC83pIpGDhZLkQHJ1GDR68owza/ndLO2XlwiC5pGVX03z7j6
	 Vho1KNGGJSX5evfkqpopU3Rjsqpz2El6/f2JenEullo0B3zbngXU82KcxZRy8F2HjE
	 bi0J6cqoKdkKqpQ8Dbt8HEtmYye7HxBK3MPUnu3cJET9aM4aiY+4H3YeHz6q0DiRmO
	 YRqW0uv/5fr8x7Oe0Ya8x+LKLWmQxUhoOe8Tmh5TcwQYgcBK4HnllrmP4dFGOB7nv9
	 L2ELehVzd29bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF439D61FF;
	Fri,  9 May 2025 20:05:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next 0/3] bpf: Retrieve ref_ctr_offset from uprobe perf
 link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174682113774.3728367.17943068400837968863.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 20:05:37 +0000
References: <20250509153539.779599-1-jolsa@kernel.org>
In-Reply-To: <20250509153539.779599-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 haoluo@google.com, laoar.shao@gmail.com, qmo@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  9 May 2025 17:35:36 +0200 you wrote:
> hi,
> adding ref_ctr_offset retrieval for uprobe perf link info.
> 
> v2 changes:
>   - display ref_ctr_offset as hex number [Andrii]
>   - added acks
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next,1/3] bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
    https://git.kernel.org/bpf/bpf-next/c/823153334042
  - [PATCHv2,bpf-next,2/3] selftests/bpf: Add link info test for ref_ctr_offset retrieval
    https://git.kernel.org/bpf/bpf-next/c/d57293db64f5
  - [PATCHv2,bpf-next,3/3] bpftool: Display ref_ctr_offset for uprobe link info
    https://git.kernel.org/bpf/bpf-next/c/97596edfec01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



