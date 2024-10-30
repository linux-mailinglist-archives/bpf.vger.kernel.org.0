Return-Path: <bpf+bounces-43453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AB9B5830
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B91C25D7F
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795D4C70;
	Wed, 30 Oct 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqQ+w6qX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E818D;
	Wed, 30 Oct 2024 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246624; cv=none; b=MV2DnmYrvJvllyK02Su6nQJC0eE5kI3dlGZj5EhVBj8S4c8xka3cavsuhqQCxcoy03jlnOCoBjSIOl/ye4yu9vnBOWzsJxPtc237K2S0DPYjIhd2/Hd2pqvX5pf9bMzhJzFWKbw2IYLuaCaexjc8wBQZurq0T93gUX3hIJfo6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246624; c=relaxed/simple;
	bh=KQN+E3h8B8ti/s3m3iYCrSOSbJumnP+mk8IP7VZgfEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C91GHWWjeS5l2GVDjEelfKTzVupRuBNS2GflXSfgp7xCIi+1/UGLlmZiH9rYMEzc4GYtfc3qdCH9A3FrlB0+TP943h7Q8Iug9jdlDQ+ZCFhXiM/VDzkGZACpuuDrqN0kEpYWVAs8gIvooP2h1vMybB7thbTkmngl0174jDtrLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqQ+w6qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9811FC4CEE3;
	Wed, 30 Oct 2024 00:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246623;
	bh=KQN+E3h8B8ti/s3m3iYCrSOSbJumnP+mk8IP7VZgfEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqQ+w6qXYRf02FQF1dsVA8PKReddoiT0tQsJBvQ2EP9QnwUy0NUuKaQ9cHDazAdhs
	 3XZOD/s+W+4vXjWd3GHabJ6y2xAK35t4TZWF8KnRA0nuZxIPNo/c/RSWq6SkioJOma
	 2VzW3YmalG6Bx9w9E56+WHr2Cn3dvMlQ3YOR5lXHTFndGGbbqQdr/MYDJEtkFbTv0r
	 jlTtNthnehDCc15RScCOp2XYi84iORTmqoCYufUPjsOWWjhHt9noM+Hg/BEBMBzka1
	 YNWZGtgfqzzls8giOYktNg7E3nogFkKWAPXAjXymCS5r70FnO3mDQ2yuhpxm85/wRE
	 KG45xTvEArHJw==
Date: Tue, 29 Oct 2024 17:03:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/9] net: ip: add drop reasons to input
 route
Message-ID: <20241029170341.1b351225@kernel.org>
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 17:33:39 +0800 Menglong Dong wrote:
> In this series, we mainly add some skb drop reasons to the input path of
> ip routing, and we make the following functions return drop reasons:
> 
>   fib_validate_source()
>   ip_route_input_mc()
>   ip_mc_validate_source()
>   ip_route_input_slow()
>   ip_route_input_rcu()
>   ip_route_input_noref()
>   ip_route_input()
>   ip_mkroute_input()
>   __mkroute_input()
>   ip_route_use_hint()
> 
> And following new skb drop reasons are added:
> 
>   SKB_DROP_REASON_IP_LOCAL_SOURCE
>   SKB_DROP_REASON_IP_INVALID_SOURCE
>   SKB_DROP_REASON_IP_LOCALNET
>   SKB_DROP_REASON_IP_INVALID_DEST

We're "a bit" behind on patches after my vacation, so no real review
here, but please repost with net-next in the subject. The test
automation trusts the tree designation and bpf-next is no longer
based on net-next. So this doesn't apply.
-- 
pw-bot: cr

