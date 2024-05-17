Return-Path: <bpf+bounces-29904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F18C8016
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31592B21776
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E289470;
	Fri, 17 May 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQBaCdFK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED409441
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715914832; cv=none; b=IHl9mm/xg4jFrqqtOVe1tqmBmpEBiojLvTIVAzEnwmlY7m7xkcCkFJEvdjafdivskiutZf0MwZM9mkNTSwoBatAmijMBs1ivscre9tHNxfmVGgD7wMBYsk7bjYMw4+RoXFz3WGFp4WvnXzHFRqsPIMowVyiKmNkoVmEWGCFHILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715914832; c=relaxed/simple;
	bh=/jb7e/3zSCVOvJ6NxCcAeONPBGNWQAlpOy7z/klBQPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQcHlTmfyklqiiPrOHaVeBJ+n78VZi605bEdavDdpnan9vFyKiHY6O6A/xpnvwfTvtBzKGymSvIMj0nUDGYjAQR97xY5Q7S7jvCCvlgEYH/d4WlxlLHJcgkmo42b2t49/nyt7P8MsuTS7VJ8gdk6RIm1dABaPJ1QYX5rC5Nn9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQBaCdFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7083C32781;
	Fri, 17 May 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715914830;
	bh=/jb7e/3zSCVOvJ6NxCcAeONPBGNWQAlpOy7z/klBQPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQBaCdFKhthumm0v2jz473adruCNMX4J37sO2Ez3NtOOTIdfGl6VyM8zGFjVbDO46
	 CKFWb1gDo+N056AJG0HwL1vnWn2GHBrUgdl3s0Qrnw6QNa3W5yuAbWgGkEmG+G6QsL
	 IPzxvS0OkC72Q8+ks/Yxbi9HImM2CL8A9vWJOrgA18T77LaD+nd3P/AlquOfhBfM7+
	 eyW5ECDbe08gbehTbwGBKrXVThAQJt24Bcr2pZsz5VbZSixEOUyAnqchgUnit6o2tb
	 NrkmcN7t60qOQzxQT3/HNGmEVXjdScpR4tJWte/dsP5pW01WOr9B5QXEMaJP2OJF6Y
	 wksOhqVGqH8Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95CFFC41620;
	Fri, 17 May 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next] bpftool: introduce btf c dump sorting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591483060.14098.7925767286434481245.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 03:00:30 +0000
References: <20240514131221.20585-1-yatsenko@meta.com>
In-Reply-To: <20240514131221.20585-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, qmo@kernel.org,
 yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 14 May 2024 14:12:21 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
> 
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next] bpftool: introduce btf c dump sorting
    https://git.kernel.org/bpf/bpf-next/c/45053110e260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



