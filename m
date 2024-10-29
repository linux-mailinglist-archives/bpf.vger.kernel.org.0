Return-Path: <bpf+bounces-43413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD469B5340
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01911C22986
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACE2076BB;
	Tue, 29 Oct 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoMbGiZd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE32192B74
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233225; cv=none; b=QrPBKSoPngOqOxWWPtc/ip4040E4wcEnJCbqDm98Ll+xpB1gx9hkqj2M9Lppd2WDLZ+sZfOsyQD1T9KYGMejOvM695IyAHmS4fW2u2QCQXzKhXB0hZm+3CbeF5dS847u/niAXtbdp2IAsTmAGwNMtscQrsNyU7QkvHIAJMCwntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233225; c=relaxed/simple;
	bh=DgkYDLX8ike5CEtEB8xWrOM/Cv7+8+Zyf5AG0yEbCTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rSgyrdyTP5HlqVbdsHKv/RV/tnfFVVsH3V6iX5i21Pvv9i5Q07fghX8cbGoAYjBuLagdfuR9MRz3mU6PkvDNoI5PY6f2PmnTNdMJttvFxuYmns8tMNeK8xWpFK3vCKT86W1xoDdjxBQFx9XN+QHePeN5i7AO0NjBN7+oRnARwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoMbGiZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31BAC4CECD;
	Tue, 29 Oct 2024 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730233224;
	bh=DgkYDLX8ike5CEtEB8xWrOM/Cv7+8+Zyf5AG0yEbCTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NoMbGiZds9rDOkx94IsgzHlDG9Pcv700HPvN5UKks6D0BOSBZC1d58IZ+zBiaV77E
	 pT0zk+f4HNfGFjD/Er6KjIAUKO+Z4g44who8xcvJ1WctsQB1p4fgoIR0CrJ39yByCa
	 n8T9xV9ryHuc7P3OvMkbMP6o3yaMAGzwv1DEqjTncDHmuiIi6QppSNNngs0nC97tqr
	 ognBpp7esTXvAB4IxSAa8SDRZySUhYZx8hQVn5yQxBw3gV8eIqi5mIGoCMZAo9Gi8L
	 gh7UgDAY9MbC1kuPKo9yuN8ABsxp5UZ+Jg7Zjd9C3bqyRTKrjuxG51KRHID1jyW41P
	 5eCs+q84D4uew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC0380AC08;
	Tue, 29 Oct 2024 20:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] docs/bpf: Add description of .BTF.base section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173023323191.809155.7408349686237368552.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 20:20:31 +0000
References: <20241028091543.2175967-1-alan.maguire@oracle.com>
In-Reply-To: <20241028091543.2175967-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 28 Oct 2024 09:15:43 +0000 you wrote:
> Now that .BTF.base sections are generated for out-of-tree kernel
> modules (provided pahole supports the "distilled_base" BTF feature),
> document .BTF.base and its role in supporting resilient split BTF
> and BTF relocation.
> 
> Changes since v1:
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] docs/bpf: Add description of .BTF.base section
    https://git.kernel.org/bpf/bpf-next/c/8a0cfd8adf81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



