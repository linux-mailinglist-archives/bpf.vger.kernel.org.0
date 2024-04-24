Return-Path: <bpf+bounces-27762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CC8B16B5
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CC1C24F8B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809616EC17;
	Wed, 24 Apr 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd/UXBCx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A016EBE7;
	Wed, 24 Apr 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999628; cv=none; b=Z3SlcZO6Ok3/ckzHmu2E08YsLaEKXHnGBrWD0bS9oK9xrqrKy3g01H4g1b8dMTjbyxvVjUScXXm32FhHvB/eFVNOF9WKRMgnJMdvs4z+LiAkDcCqoZTXrTH9fLj492u1D/o7WX5fkhHgg4D92VLjexR9eDdbCQIds1zi5RKuXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999628; c=relaxed/simple;
	bh=4tVXH1bdNG8zrYB7FyYNMh7A/u6GuVfC/b0MJA6V2FI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DeX7vJX38htavBEUysI6QN1SwEzcZNihVbBR9Px3T4x+mCbDMJhIbE2yqPinQzPGj+wlM9HqtrCVsbqZgumF0F1HLKcH8LN45iPqHIwxy7nY1DCeE5HHMh+218oU6Lqj3uPlJpRj9RzUEdVdZDW8IxypDAVSF3HCeZHqykW128I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd/UXBCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B315C32786;
	Wed, 24 Apr 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713999628;
	bh=4tVXH1bdNG8zrYB7FyYNMh7A/u6GuVfC/b0MJA6V2FI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gd/UXBCx078Q7eW+KMN35VCDj0XWVV1e9MyupeiTvEzM5QAayM7HN96KM1uuORlav
	 591iS11LpV8FhnsxvKT3vdhkKhD4qvbX8QSgIWhTqV1O/OyBdeMoqx6R7e6hCrgzbY
	 Kh6+K5fA7Sj4f+QIUa8AedZNcWjIZSutZSTYBI5DQ/MN9M9iQhg6XEqlfEmiBTGXH8
	 DBplkHKdnAB2IeaZTLLrhIEH5QqeoiYnuFE63ZPZeSrzzeSmblHIeZiZ9LI5vZOKWC
	 2IaDGh0Mzl5NRTwi3V1VrMvPmEIhBHWrxst/oqwmFW0DM9DGOr7Wbrs/wBlfEAFjrf
	 nMaBhJ1MPV9rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 025CCC43614;
	Wed, 24 Apr 2024 23:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: update the comment for BTF_FIELDS_MAX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171399962800.5535.10016594730757289270.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 23:00:28 +0000
References: <20240424054526.8031-1-haiyue.wang@intel.com>
In-Reply-To: <20240424054526.8031-1-haiyue.wang@intel.com>
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 Apr 2024 13:45:07 +0800 you wrote:
> The commit d56b63cf0c0f ("bpf: add support for bpf_wq user type")
> changes the fields support number to 11, just sync the comment.
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  include/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next,v1] bpf: update the comment for BTF_FIELDS_MAX
    https://git.kernel.org/bpf/bpf-next/c/95c07d58250c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



