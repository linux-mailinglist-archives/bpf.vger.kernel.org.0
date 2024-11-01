Return-Path: <bpf+bounces-43751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2549B9721
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC91F22539
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF21CDFA9;
	Fri,  1 Nov 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSbv/6R+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D513B7A3;
	Fri,  1 Nov 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484625; cv=none; b=SSv8ESkP1yTPZeGNVKXflIuvIFLSB26/fXph4scAqBrteFU7jAVpeo4ddHpxTvf7bP+MMGpTFRM+ZYBqqIoQhGJL6tXe8JJSHn2XVenpcbnRw0MA8ap+6iwGKMQ2IgO4EuwKoISkWQZGw2KZKr8oQluarhrp/GPFGi6mUaXJYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484625; c=relaxed/simple;
	bh=aMKshjwPdQnUfVlRS3VH1NeJurY3Ir60LU9mIvGjoww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKOVE9ynQxWPEUmEHODnxdwGMHiGakGzQqox4cpOO5fjHrz1fUmInlilq2eu2nCQMxg6Gk+FErBRKEaVxCJFrGyBH9f/2ZoGGBfyCPH3C5Dk/5Z2gNK2nZktuZ78mjBaqKb+ZF1Ji6F1yAZBwWFjDx2VhwjSxPTKDcmVdNBOZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSbv/6R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757AEC4CECD;
	Fri,  1 Nov 2024 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730484625;
	bh=aMKshjwPdQnUfVlRS3VH1NeJurY3Ir60LU9mIvGjoww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cSbv/6R+NWph5P2zeEyjSM7lcwxc2Hc7CzC+E14zgsqcqg6HNwcDdkVqGp/gixceu
	 U0ZasGLv8C4PS8FohqQxc30WaPqRgSgNeZiNwug69fMx5UJ3JUvJbjfiI2QXuatKDF
	 NBO55wNwxlS5lWiWkJzcHc8VlWt3shQFj9+ZSS//uEl/QN+miJlnucgjYQ3IRrBwpv
	 K++qecbxXTLeuBWBNo93iBmivuc0xrqWarlBYRxZ6wXZvNyieWqZX0DE97KHshUp0f
	 XBUHwHWC1EbEldKdVX+l4Xkq1syC5rX379xMx2wGUm9CAmaWc+hociyI4m3j/cYxO8
	 uaAmpVt6krtcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD443AB8975;
	Fri,  1 Nov 2024 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add open coded version of kmem_cache
 iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173048463350.2768869.2189077263456608571.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 18:10:33 +0000
References: <20241030222819.1800667-1-namhyung@kernel.org>
In-Reply-To: <20241030222819.1800667-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, akpm@linux-foundation.org,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, acme@kernel.org, kees@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Oct 2024 15:28:18 -0700 you wrote:
> Add a new open coded iterator for kmem_cache which can be called from a
> BPF program like below.  It doesn't take any argument and traverses all
> kmem_cache entries.
> 
>   struct kmem_cache *pos;
> 
>   bpf_for_each(kmem_cache, pos) {
>       ...
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Add open coded version of kmem_cache iterator
    https://git.kernel.org/bpf/bpf-next/c/2e9a548009c2
  - [bpf-next,v3,2/2] selftests/bpf: Add a test for open coded kmem_cache iter
    https://git.kernel.org/bpf/bpf-next/c/e5e4799e2ac3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



