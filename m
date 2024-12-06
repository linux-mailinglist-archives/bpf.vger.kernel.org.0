Return-Path: <bpf+bounces-46329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9C9E7B6A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD64162399
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086751D6DBC;
	Fri,  6 Dec 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtEVg+l0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8F22C6C0
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523016; cv=none; b=n8jNDueyQaQ0wZq2Pgm5MItgW7c/aK63TQloNzFah0NOWfF04dETCyso7IDjD1lxFEITLcFFZHG/kdu0brpspDpKVOgnxxYhL+MLxwylSGanSbK+iiS6NFyIdSby7nA+CeXU0BKee8pq3vNBwWSW6zclgwVrejh/5Tc+zvYzcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523016; c=relaxed/simple;
	bh=UuiPc8fp1407JNIr7Eb//8kp4qAkqoOBps2TnCyRCew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqvfZXTFapJRa28HY3XC1b8s1eXpgDekZwkhnpx3a5JvFr9m5z+U1GUMxU+o10kDMtVrtkw2pKo35Y6MHjIIhozB59Ej0kPOUF+ZGC1Cc8Do5eAW5PCUfc9D9S4qlM4O5xsFs3hcPKh7+ZloF7Da235DGftYzTt7fHoGNml1pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtEVg+l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F369CC4CED2;
	Fri,  6 Dec 2024 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733523016;
	bh=UuiPc8fp1407JNIr7Eb//8kp4qAkqoOBps2TnCyRCew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YtEVg+l0glRXWkgEB32U+3hfka1qNmanzBnkrWwK/K6oumYLKvpH3Wg7YpiSLSZ/+
	 FxzL3YwoShYgUzJ5IzI0UbaKmqsU5Cgh2U8JheBnv+ohYUgaAtRpXz5ru4KZLtbvmn
	 ppgxS0+Zwu0PwxBtEjqvhU7GV+saPiv01Y30pc9pVPBu4WQJYJCjEBiCbbt6R7f8mg
	 HIMOLR6JRk1sRUv8THsG43P9Dq1ju4xqqMRjJooCy43MYngAXrfb1uWaOy44dMwbu7
	 ODDU2zB1DmhsEYiWUFhHYFNChI7RGdSqqHQde6clUQ+yHQZ4Za20m7DEo9FLM6ZSLZ
	 g30LlorXhpXjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345E3380A95C;
	Fri,  6 Dec 2024 22:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Consolidate kernel modules into
 common directory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173352303103.2814043.17875547914996700881.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 22:10:31 +0000
References: <20241204-bpf-selftests-mod-compile-v5-1-b96231134a49@redhat.com>
In-Reply-To: <20241204-bpf-selftests-mod-compile-v5-1-b96231134a49@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalik@redhat.com,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 04 Dec 2024 14:28:26 +0100 you wrote:
> The selftests build four kernel modules which use copy-pasted Makefile
> targets. This is a bit messy, and doesn't scale so well when we add more
> modules, so let's consolidate these rules into a single rule generated
> for each module name, and move the module sources into a single
> directory.
> 
> To avoid parallel builds of the different modules stepping on each
> other's toes during the 'modpost' phase of the Kbuild 'make modules',
> the module files should really be a grouped target. However, make only
> added explicit support for grouped targets in version 4.3, which is
> newer than the minimum version supported by the kernel. However, make
> implicitly treats pattern matching rules with multiple targets as a
> grouped target, so we can work around this by turning the rule into a
> pattern matching target. We do this by replacing '.ko' with '%ko' in the
> targets with subst().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5] selftests/bpf: Consolidate kernel modules into common directory
    https://git.kernel.org/bpf/bpf-next/c/d6212d82bf26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



