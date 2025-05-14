Return-Path: <bpf+bounces-58211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11080AB71CA
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E523A6F3F
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1A280A5B;
	Wed, 14 May 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCdhx2RU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9B27F165
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240794; cv=none; b=RyjsOf4NN1g+16T8y25Xo199gN0l2vjHCY58VoaalXA4c/mQ+fqhbV1kfWLe/k9SQF4ri8TjyRfYWZIGBxPRLrzXGehOh4c4Kh3tfuBldKGshOod+fjfU20Q0iV6jFBRbOYG/11IG95axRyjaPx/OdR+dDH0Ylx9xaukkOKp/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240794; c=relaxed/simple;
	bh=8povGujgPkIcraZZhUDqRlvTaf9AOkDKWVyj0GEy8To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJJKiqKzSEkXglAMoJkaapgCt1EIBwlUWBOoRjcz7a+8Qf/qsHlGUpg+cO1zllKOluvycRBCStqDd0KdLxNsVORMWGcF580NkQEiu8hPQMDxZ6fcvyKLhaTOjqeog0iECYkSmEa9plk8cv+MnKdaieYpEkF5uxni6ENOh8vUpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCdhx2RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADEC4CEE9;
	Wed, 14 May 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747240794;
	bh=8povGujgPkIcraZZhUDqRlvTaf9AOkDKWVyj0GEy8To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SCdhx2RUgdo+5A4YlIwcCuhEnDTdv97Et3PD9a6zFveefqyoqj9kGEZKudXOtWtoW
	 UvhgyT6KMaabVXGqxzOj1Km+PZRQiuUYfx8D579LkIpytTV6M7v/FF4PUqoHHKBu5D
	 rOwOhqQ85BojqKBS2hjLxQt21hx6AyKS2oqnJi71deFyhoW0yjtAD1eKfq7l8OxsRM
	 iWLz4ODNOuwyDwnoUMal+3MD2sely1/A+HxmsX1IUA/k8ZbTb5sR8l/IaLJtJTREpf
	 gvybjQvbCjanBiHDiU47dtu4SsqlnQFYt3RSFqY7GpWayDGvhyAFg1N2tCPmfvdR1o
	 sGVUP/EvLgyvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F37380AA66;
	Wed, 14 May 2025 16:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: check bpf_map_skeleton link for NULL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174724083163.2433669.17561709151013443813.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 16:40:31 +0000
References: <20250514113220.219095-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250514113220.219095-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 14 May 2025 12:32:20 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Avoid dereferencing bpf_map_skeleton's link field if it's NULL.
> If BPF map skeleton is created with the size, that indicates containing
> link field, but the field was not actually initialized with valid
> bpf_link pointer, libbpf crashes. This may happen when using libbpf-rs
> skeleton.
> Skeleton loading may still progress, but user needs to attach struct_ops
> map separately.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: check bpf_map_skeleton link for NULL
    https://git.kernel.org/bpf/bpf-next/c/d0445d7dd3fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



