Return-Path: <bpf+bounces-61686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C5AEA3DE
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A89562CC6
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234AF2ECE8C;
	Thu, 26 Jun 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtSmL7zi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E12E763F
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956623; cv=none; b=sH4lSp67QrL2wOvfoP111YngTJWKPqHlbLLmDHqAwj7fpwKurismqS4CTTO4hj8uJ2mgfGre9QtK4J53oR3yto/OebRK6SCZg3ulVQubwEntDo6P8Tvtn7eTjiXSvFjppQleVBIplEs4DtftZYTWhTvB4hqj3XhF390K13LrkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956623; c=relaxed/simple;
	bh=4Ygi37k/IPSDwX2hC6IrKWbU4JDRCKVsD55GxKuR15c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rw8NG7XtSF+tu9Q8Fq3b7UIooDIm54zzdF/Chi1/GYKFgQctP8mwVkxjnvGQTZ0j8j/n33NVnpwzIcOFjIf2JQgqqVc+Z1VwbrRSXi7t50l0C50bSwVnElpBDHIaaSHPtN0Jt+EAIpkFt3rWwZVCDNhRlAWjUk96gNZ1CP6x6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtSmL7zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB6C4CEEB;
	Thu, 26 Jun 2025 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750956623;
	bh=4Ygi37k/IPSDwX2hC6IrKWbU4JDRCKVsD55GxKuR15c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JtSmL7ziwmFVpZkeQfCaK3O4iI6zv3xrWLSrGkeDrzXKwWa768/gAkR4ijSw/KvbM
	 lwzF7SlLZRwvE3C0HN7zx44XMnlmc9MEIK6F+4z9ImtTDu8Vj7sOwSnYmtpCDxDBxD
	 bHeBOiqFZ5bGJpRmhzn64tjQAXcRaHLIgMkdn/8OuQXj0M3y7/WuNSTVLb/eYxDsBY
	 v5FVEX0etQzaIKFbtcqyNWio0EN8rjIQkGxMu01vopV+hjmWRv8bbHFHkn7oYZ3AF3
	 caZFQ+laR1cnCE/1bt8YDrUgJDx+jfMKQdUScWafzp9btEZ45mo/fFk3PouIAXgeCb
	 goTf/7NrD7xhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC283A40FCB;
	Thu, 26 Jun 2025 16:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/4] bpf: Add kfuncs for read-only string
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175095664950.1268005.9831138846255038698.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 16:50:49 +0000
References: <cover.1750917800.git.vmalik@redhat.com>
In-Reply-To: <cover.1750917800.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Jun 2025 08:08:27 +0200 you wrote:
> String operations are commonly used in programming and BPF programs are
> no exception. Since it is cumbersome to reimplement them over and over,
> this series introduce kfuncs which provide the most common operations.
> For now, we only limit ourselves to functions which do not copy memory
> since these usually introduce undefined behaviour in case the
> source/destination buffers overlap which would have to be prevented by
> the verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/4] uaccess: Define pagefault lock guard
    https://git.kernel.org/bpf/bpf-next/c/3a95a561f276
  - [bpf-next,v8,2/4] bpf: Add kfuncs for read-only string operations
    https://git.kernel.org/bpf/bpf-next/c/e91370550f1f
  - [bpf-next,v8,3/4] selftests/bpf: Allow macros in __retval
    https://git.kernel.org/bpf/bpf-next/c/a55b7d39328b
  - [bpf-next,v8,4/4] selftests/bpf: Add tests for string kfuncs
    https://git.kernel.org/bpf/bpf-next/c/e8763fb66a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



