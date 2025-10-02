Return-Path: <bpf+bounces-70245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B638BB5802
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F5C19E796F
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA93279DA1;
	Thu,  2 Oct 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRUG19YY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C82AF1D
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441217; cv=none; b=BcGY7k/ak8KYGTFi+hsK+Dmsa7RPdbAeiVxJYqvox5vnjMTxq3ln6WunEpWCo4cXtGedafoZgHTI9dXA0zivgMiPnZKhJpk8xnvb+lXQd+bs2cj7F12H5mT2GP8Cb31l5hqMerUyhIkz89q/EBWAU3waleHoUqor4G99J9rtLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441217; c=relaxed/simple;
	bh=frEE7ENGvOITi5OaQigTPNb10G0dSSbBf80rdXeassc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dOJQ8IF6MmXVYrGDjTio7CT4TAj6gsAlCPikYzy9HSWWlmaSozadCYJYLj9+4F6XvEiU9sEbnKtodF6lV/BDRrJJ87TWE6FCE8M42BT9EByyxgjvthFWQlX54A6XnsXdP0XheZnvaBd+q0oql4yxE3L52Gj4NDYiGVkLiVdRiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRUG19YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69872C4CEF4;
	Thu,  2 Oct 2025 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759441216;
	bh=frEE7ENGvOITi5OaQigTPNb10G0dSSbBf80rdXeassc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uRUG19YY8Iva0PRd6BPCRSBff+euMAtDVLj3qdWZsa6p8pFgDn1ju0w28suC7Cqqm
	 ahPk/2efdvAzmFy2Ibc0wLwlp/bV6utJzPD0GqsYdRoLAp/AsKukviT7wrkwI9crxA
	 twYBAUj3PbFAfEfJx7jAiwE5pGbr/+HTTZPIVYBgRL4I4/QhXbqu8uR4hVwE1RoHo5
	 B98Ar+O0p746HVN2f9zh64DpiqwhrjsonIhOmvsbN+6d5T3dJaag3uuM1QmIeAdMdc
	 WfM01/UmdKrcmKHMAeBaUex9fOdLu1wxeXFafLhZKlI1qv3DmR+8HGgSg+BPqOBK7T
	 IMucLi2UeNZWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6739D0C1A;
	Thu,  2 Oct 2025 21:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175944120795.3470954.3429421575928234428.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 21:40:07 +0000
References: <20251002203150.1825678-1-tony.ambardar@gmail.com>
In-Reply-To: <20251002203150.1825678-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Oct 2025 13:31:50 -0700 you wrote:
> The recent sha256 patch uses a GCC pragma to suppress compile errors for
> a packed struct, but omits a needed pragma (see related link) and thus
> still raises errors: (e.g. on GCC 12.3 armhf)
> 
> libbpf_utils.c:153:29: error: packed attribute causes inefficient alignment for ‘__val’ [-Werror=attributes]
>   153 | struct __packed_u32 { __u32 __val; } __attribute__((packed));
>       |                             ^~~~~
> 
> [...]

Here is the summary with links:
  - [bpf,v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
    https://git.kernel.org/bpf/bpf/c/63d2247e2e37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



