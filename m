Return-Path: <bpf+bounces-50582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34370A29E1E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AF81888F14
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C429CF0;
	Thu,  6 Feb 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDpoelAG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5B2561D
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803606; cv=none; b=X5GByGVovDNlxl348o21Qo0fjqQKtWLaXXwALO5Jvvm7tNrkD15+ZoVHgtBymwRAKvxna2rDfvIUj1GFQXtMRSAEbLEf/cYnmgtSegmNjInskHVlFoj0s0qW9FtfpBIirPDubbZva1A2o6EFeeql7mCyKeolEca36qzxaXr3l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803606; c=relaxed/simple;
	bh=GHRJkQdMoCdBC4gQjr/EIqE5T68K8NPpvGrsNRbwmKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llAQObzIM0JIMZhNx5W6j20q4hebLBGL1X8KsD09zNh9wMFx9oIJ5Gt/b/WcTO1X4UGpyCpegVolhbBldNH/vwktcy/QdJBo8Pgne4uJl04/KwynRFgzMtevpPsGS6jduF81lgjYzGrELMRV08OU1fP1QE81nPiZ1b4aullCPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDpoelAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD530C4CED1;
	Thu,  6 Feb 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738803605;
	bh=GHRJkQdMoCdBC4gQjr/EIqE5T68K8NPpvGrsNRbwmKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDpoelAGXFPa9CrPK36MhAl6yUyVghiHjkg/1nRcl5hKQIs+lVyjTbM8Q62n26+NJ
	 UAPAsDSWwIgxcHjh3yfXL5CO3ATk0hM0CQ8HoVz5lKj/fGGMCyATFdmMUFTXKU1Vci
	 ARz1BF6mAJeczlQC5S9yC/YhhJP+sh90UEno4EUeVTIgOh0W3NejHgxiD4SykyS3rd
	 t4O1xzjy1tr0HrLyA7GVY9Gfto3weB+DZZFkcB87Rg57Qyci5FmhLRbTEKfUpPh+X4
	 EgKo0AIpUpjp5132spBYSz/YLM9h9fclKWzMBZ91FCr8rCsRLZd2A7w+xib+ZJvPe3
	 1FLV1G2O7GCPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA6380AAD0;
	Thu,  6 Feb 2025 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] BTF: arbitrary __attribute__ encoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880363326.959069.4707220911950424811.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 01:00:33 +0000
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 jose.marchesi@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 30 Jan 2025 12:12:33 -0800 you wrote:
> This patch series extends BPF Type Format (BTF) to support arbitrary
> __attribute__ encoding.
> 
> Setting the kind_flag to 1 in BTF type tags and decl tags now changes
> the meaning for the encoded tag, in particular with respect to
> btf_dump in libbpf.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] libbpf: introduce kflag for type_tags and decl_tags in BTF
    https://git.kernel.org/bpf/bpf-next/c/51d1b1d42841
  - [bpf-next,v3,2/6] docs/bpf: document the semantics of BTF tags with kind_flag
    https://git.kernel.org/bpf/bpf-next/c/ea70faa1f244
  - [bpf-next,v3,3/6] libbpf: check the kflag of type tags in btf_dump
    https://git.kernel.org/bpf/bpf-next/c/2019c58318b8
  - [bpf-next,v3,4/6] selftests/bpf: add a btf_dump test for type_tags
    https://git.kernel.org/bpf/bpf-next/c/6c2d2a05a762
  - [bpf-next,v3,5/6] bpf: allow kind_flag for BTF type and decl tags
    https://git.kernel.org/bpf/bpf-next/c/53ee0d66d7a6
  - [bpf-next,v3,6/6] selftests/bpf: add a BTF verification test for kflagged type_tag
    https://git.kernel.org/bpf/bpf-next/c/770cdcf4a59e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



