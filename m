Return-Path: <bpf+bounces-20195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4AF83A0BC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 05:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F53C1F2A82F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 04:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F5C8F1;
	Wed, 24 Jan 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQQCvAdb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115517D2
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071826; cv=none; b=tWkIZZsbE68OzviGmL2dhMXQLKwNwqLqpU612kmjTEM2MRVD3YKz/C0Y1I+Bjpb1374CelUwL2o4f7dzTI7K8Gm8/vjEa65qG32iqF4Ai1a6Te+jvzLRu6hy9OUz4huejymhTIgxZimvim2YsUdBBVv6JyGdLZYJpH6iw9ZvSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071826; c=relaxed/simple;
	bh=tGGsjKis2I0fLZpZEvsWkPH8U6B0VuvbJ7Byk3dmdX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ELp8G5LWWAW0wznPXFKK4ICSiMEK3u53O/p79FikDFIP1C98EHM58KzwP6ljlFga7LgQM7UwQPZmp8FfaNd6JCIyJ6/GFKOB+/0Vv79VcBqaAquqFFllgciKZWrdB8u8LRkT6DYrbbm1URpgx1Q1jP5QoNcAnBD21JwACE+Bfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQQCvAdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED7ADC433F1;
	Wed, 24 Jan 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706071826;
	bh=tGGsjKis2I0fLZpZEvsWkPH8U6B0VuvbJ7Byk3dmdX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dQQCvAdb6J4OvKQizH/sYKtP+Q6HNOMDsh7+1pgbKf5P8NlmetrnwWmyeSqtsHfbF
	 h3HIZOyL/RiWUVdgf4KfPQ1O1yxNi5pwjK5gIAe8tX0GdHN7pdoeR5hjom1n6CKYRD
	 Je4/1cCsf6k4jw31lm1Zq3vtJOSXbWzMShYFqjK9N1C8gtZvkZdNwpjxYX41ot1WxZ
	 RMaYJWYoemdHJ3T9ARs35Kz7uhlA7r6/kAmVhXxd36nJVx1zRcoYS63Q7dv2R+h4Xs
	 rVTFxNLowAt1+2bwJJnMRAvvjh9gfD9/Kw84APWg2/OHTEnFnScNtGmgJkOvsJMZ3f
	 +aw/Bvh3oHXBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6558DFF768;
	Wed, 24 Jan 2024 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] Correct bpf_core_read.h comment wrt bpf_core_relo
 struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170607182587.16094.11922936821913452133.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 04:50:25 +0000
References: <20240121060126.15650-1-dimaqq@gmail.com>
In-Reply-To: <20240121060126.15650-1-dimaqq@gmail.com>
To: Dima Tisnek <dimaqq@gmail.com>
Cc: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 21 Jan 2024 15:01:26 +0900 you wrote:
> Past commits, like 28b93c64499ae09d9dc8c04123b15f8654a93c4c, have removed the last
> vestiges of struct bpf_field_reloc, it's called struct bpf_core_relo now.
> 
> Signed-off-by: Dima Tisnek <dimaqq@gmail.com>
> ---
>  tools/lib/bpf/bpf_core_read.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] Correct bpf_core_read.h comment wrt bpf_core_relo struct
    https://git.kernel.org/bpf/bpf-next/c/d47b9f68d289

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



