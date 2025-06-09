Return-Path: <bpf+bounces-60121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AAAD2AB2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4356B16F839
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489322FF39;
	Mon,  9 Jun 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4nTaKt1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EC22FACA;
	Mon,  9 Jun 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513014; cv=none; b=JnqWMmw9DZ7HUzSVhwx2PHl6K6kLXKUv882GkwLQQQxuWjL8Cn9wWmMjdIJXq4S4pdiKiuYtDwEj/2LzOn3/6u9eTeARitq8HLrFkrkn9vxlhRr2DU+1GuBj+LqTK2l26HQ6eAD6cnOPukPUICSktqa5HMCGBRe3RdLL7kRk6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513014; c=relaxed/simple;
	bh=MdqTs7ZWm8Y4pz1jUFW5OVUy8Af3TP5fOyeKdUZv/7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DbtS/DxlNU9tSmlzvoAetfqsMpa2DpiT3J8ETFwoVRYShqVerXXmhDhhzkRw/T/1arqhK0KzQ2kRxAwz3Gvh+HgDCp0LemOn48GM8cSP+Ee8iSICed+/+4KmVdP65WcbSVQrWB7yajOiNFZrEKPkiFfifcK5a4uVChdYTQJspY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4nTaKt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE135C4CEEB;
	Mon,  9 Jun 2025 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749513013;
	bh=MdqTs7ZWm8Y4pz1jUFW5OVUy8Af3TP5fOyeKdUZv/7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4nTaKt189fBz/Fo6oc4iSYq9vBPdePkpdYkycEWM0kwOWN/jrfvTQ22kG3Ez59VH
	 HjT+Shxs3Xdd1Gd6PS2+Ko5kfYsBgYlaysHyqpvad7bGVc8nbPXwvRyFsaQT4a1B0/
	 pYXqzBWDyX+fZ+Z/UvaeNI3ywXMGe0VTQTCNKwt8E+RXlbqo+4cmt2ZdhkRj3Dgsgf
	 H89wSRoQGnzkMZWkMF0drEXxO+9ITwZlhXP00jYj7jnwY/9q4xBgkbAhdESFaziQ/9
	 A612kahcuJBvuwruUkBTu8nfzlMosQBHAJwAdDdkJz4CKU0U6GbPMOAIVn5clfFcgh
	 HQT3+cf1r42xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB83822D49;
	Mon,  9 Jun 2025 23:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next  1/5] bpf: Add cookie to tracing bpf_link_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174951304279.1595076.16528330369132469013.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 23:50:42 +0000
References: <20250606165818.3394397-1-chen.dylane@linux.dev>
In-Reply-To: <20250606165818.3394397-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, qmo@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat,  7 Jun 2025 00:58:14 +0800 you wrote:
> bpf_tramp_link includes cookie info, we can add it in bpf_link_info.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/uapi/linux/bpf.h       | 2 ++
>  kernel/bpf/syscall.c           | 1 +
>  tools/include/uapi/linux/bpf.h | 2 ++
>  3 files changed, 5 insertions(+)

Here is the summary with links:
  - [bpf-next,1/5] bpf: Add cookie to tracing bpf_link_info
    https://git.kernel.org/bpf/bpf-next/c/c7beb48344d2
  - [bpf-next,2/5] selftests/bpf: Add cookies check for tracing fill_link_info test
    https://git.kernel.org/bpf/bpf-next/c/d77efc0ef5b0
  - [bpf-next,3/5] bpftool: Display cookie for tracing link probe
    https://git.kernel.org/bpf/bpf-next/c/ad954cbe0849
  - [bpf-next,4/5] bpf: Add cookie in fdinfo for tracing
    https://git.kernel.org/bpf/bpf-next/c/380cb6dfa2bf
  - [bpf-next,5/5] bpf: Add cookie in fdinfo for raw_tp
    https://git.kernel.org/bpf/bpf-next/c/2bc0575fec36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



