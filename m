Return-Path: <bpf+bounces-31519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA498FF35E
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25AA1C23C68
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EE1990C8;
	Thu,  6 Jun 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MygBeLEN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE1198E6E
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693832; cv=none; b=uixaxbrQJ8v0IVHVg0cXhEkZ7d6g/Ka/VIGu3qvqWIjHUjH9tjlO8+kJjimzYrFvGlSvi9a5tMzQ4nVM/zwamUNMq5yQ0rNPuRIS9i79v43lNyjQMPgqutzb/ulRIM0VW8meCz3kFS6vd0AKVHA3CsbR7JpNshrZKjqv0mrFLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693832; c=relaxed/simple;
	bh=iwEI0fMHBHRvccliXqKbx13WQKRJTm1b77TH07SnoKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlfBcfIXWVhJhBHy4goYR1VLiO2bZnFi0O+veCqC7ejz/VXbc+1I71mXegrOvpxkHvgCxifSbLumZe8vFCpL5LAAsYzT+Gmsl3VQ79Kxm0lPTSp6Be1CB9axqxJw7BPE18hozyAaIYaGdNFiiCWK2FOnwb4PkbQLTakQJ8g1+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MygBeLEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88532C32786;
	Thu,  6 Jun 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693831;
	bh=iwEI0fMHBHRvccliXqKbx13WQKRJTm1b77TH07SnoKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MygBeLENZNMGIJfo+dW2Xe9T5Wx5vq/wb7apyZ7xBRIr4mLK3fUQbuSilWRGeWpGX
	 Dgdda8E3rQXBsf9/LzlnxAYGHkiRfai+ay5lKZLAjZmmvqLJEgkJ2r5AaRpVO2IR99
	 dgA1cLrOvIK+IJqi+kn6afYJVKOSscnt0wUqzm7ZWZhIf/JCaMcPpv7YkDy5C1GsGb
	 lISWAMkQCgnRGZAgc5nbC0ofMfVsc3YuflZ/BNDiy6DZq17igJDaKmLq1SAu3QLf9I
	 3UN1XTbXoLPZrtTV+Ko6NJGawQCIVLz4qfnWk7Leq0DdqbvKaF6wN1I2VDlZXH4yLN
	 GusSh+c+QBElg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7618CD2039C;
	Thu,  6 Jun 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: auto-attach skeletons struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171769383147.24877.15058532842185809490.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 17:10:31 +0000
References: <20240605175135.117127-1-yatsenko@meta.com>
In-Reply-To: <20240605175135.117127-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  5 Jun 2024 18:51:35 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Similarly to `bpf_program`, support `bpf_map` automatic attachment in
> `bpf_object__attach_skeleton`. Currently only struct_ops maps could be
> attached.
> 
> Bpftool
> Code-generate links in skeleton struct for struct_ops maps.
> Similarly to `bpf_program_skeleton`, set links in `bpf_map_skeleton`.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: auto-attach skeletons struct_ops
    https://git.kernel.org/bpf/bpf-next/c/08ac454e258e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



