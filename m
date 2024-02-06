Return-Path: <bpf+bounces-21364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D184BCA0
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624421F262C9
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAE1078B;
	Tue,  6 Feb 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz2pLTGn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6620DF56;
	Tue,  6 Feb 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242429; cv=none; b=cDHZHEjEqnmzjW5uuPeyAegK6583LpxbVsQHp4R8qWon0/w+w9jCBkgB2MQUwlOhemnrUxTvBmSs3Spr6/T4sVkXaSOFTVRVR2BjTMB5xoxEJBCJ8bZNAmuxNUvm/y2k8iWdQgcLLMgR1EpkyDGKPOR73itVDiBqw1CpDQceBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242429; c=relaxed/simple;
	bh=gMiV3UbQI3ESv5jAuOZlSorHv0YoP7Gy4moGPOJ8eG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NE23vmwwA8uuSkjRXOAzdPJnwN6+1y23NCnOb1sWN4mrNqNqKhjG/p0b9T3cpHqpeUI6/Uod4FwB80P9CbsB9NSmZZO7PQ1siYhEzQ8/uhKOCGF21eT7q6rQeakXh1ByEyIRemMNu3I9j5r9sx7jUY9uALd5NrnRN1jMBskrRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz2pLTGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E475C43390;
	Tue,  6 Feb 2024 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242429;
	bh=gMiV3UbQI3ESv5jAuOZlSorHv0YoP7Gy4moGPOJ8eG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qz2pLTGntL+UUe94FEvQhMDVfc2B06CE5PtwKkd8laiEdzJgmJe59f2hD+hp+slJz
	 61H6+B/EUbuVQhA6L0au7zJQuU9e9OSxf39absKmKskcX48NvVWzNwvapbDswEDcJt
	 tnK99R+ThhBcWPD95VlPkCKoASIyhpmjWaO93O+0qZ0IC0gOfVsgevm7UhTJRYJ/AI
	 0Iwjas+LyZWJwgTZbgcHDaHz4Zt/O4nHOZ6hlXFzdCjjHko3srd+lh2YRRopVkFlWn
	 jbVlKOogMfc/XIijimlNuANfc2vlDBOLgtGdcRBvFSMvNYt3OaJP90VOcFBJkLCpdO
	 omRFgMnmcZIHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EE4E2F2F9;
	Tue,  6 Feb 2024 18:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170724242913.20911.7567549858006801341.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 18:00:29 +0000
References: <20240206125922.1992815-1-toke@redhat.com>
In-Reply-To: <20240206125922.1992815-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, maciej.fijalkowski@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  6 Feb 2024 13:59:22 +0100 you wrote:
> When the feature_flags and xdp_zc_max_segs fields were added to the libbpf
> bpf_xdp_query_opts, the code writing them did not use the OPTS_SET() macro.
> This causes libbpf to write to those fields unconditionally, which means
> that programs compiled against an older version of libbpf (with a smaller
> size of the bpf_xdp_query_opts struct) will have its stack corrupted by
> libbpf writing out of bounds.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
    https://git.kernel.org/bpf/bpf-next/c/92a871ab9fa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



