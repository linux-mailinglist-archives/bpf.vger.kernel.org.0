Return-Path: <bpf+bounces-48821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE0A10F21
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 19:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FF43A72ED
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4B221D9E;
	Tue, 14 Jan 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsNlJsfr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF31FCFE1;
	Tue, 14 Jan 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877671; cv=none; b=jpl6idl2aCrkRzzlGGp1hdMJnXd8R6Pfsu8PXLwPGZu7d3Yklk1v/HLRE93eX2W1XxhQi7bI+b0snKMtTRptp5uio4UKTCs1i5I4jfMdmCGSYR8FbSeysQv0DNqblb2P+1mBH6g8ZNhvcNMgFhM9CH71gaU6EPPWHfm6F2jt1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877671; c=relaxed/simple;
	bh=N898Ds9vhbwHNJvs1hFR/5Ts0qoRlojv2AjUAwKHoiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHTW6HIWaTqiHyPnkkpWUmK6yffvpQQSxM5VoR9IwpIjSaxr7BuEkoqSva7XJwmxhI4iry/dxwCZzV8cyH6oiBcoiO46IQIRnF0R93GKb07MOPgrrlecJ4+S+KsdcVjE4lFVCL5L06+6ilmv4T52oobRQ6Y6d7aYHUsoMlmhvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsNlJsfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D87C4CEDD;
	Tue, 14 Jan 2025 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877671;
	bh=N898Ds9vhbwHNJvs1hFR/5Ts0qoRlojv2AjUAwKHoiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KsNlJsfrjZZ5HurpHOB1Lhju2/BaQbRdcNq/Uhf5qqK2Y3Nf5N3hzElNPagtCxhbE
	 tuEi4UbQQJF9fgsOdtq7bm4mWP2ptVw0u7g4xCEwagKTTvwIS7eV7pN+cwf5UZYjJn
	 CrMMMa2N3kRwWM0/radtEZxq5TtqNlOf8H5w4NippPxBAzLG1nrhFG/eog4vjIt09f
	 /d3EoWSDgwFCwLaPnFgPASYYdl16y7uBb3RjjrjInjU+94M5xBfC0RTk2wnH65ocuT
	 sTsithpnRxU1kkJDjzXc3q7OR8vMjZrw9C4lCC//MqPb5Wdbl3kyZ5JSQEBUkG9P2B
	 4+Esy5hj04t9A==
Date: Tue, 14 Jan 2025 10:01:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev,
 daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org,
 corbet@lwn.net, eddyz87@gmail.com, cong.wang@bytedance.com,
 shuah@kernel.org, mykolal@fb.com, jolsa@kernel.org, haoluo@google.com,
 sdf@fomichev.me, kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v5 1/3] bpf: fix wrong copied_seq calculation
Message-ID: <20250114100108.121f9d5a@kernel.org>
In-Reply-To: <nch3maxdymvvdq647hijycfj2y242o67wgkch3vksfgrkabtt3@xuskfpo426xz>
References: <20250109094402.50838-1-mrpre@163.com>
	<20250109094402.50838-2-mrpre@163.com>
	<20250113160404.7ab0927d@kernel.org>
	<nch3maxdymvvdq647hijycfj2y242o67wgkch3vksfgrkabtt3@xuskfpo426xz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 14:35:34 +0800 Jiayuan Chen wrote:
> > To state the obvious feels like the abstraction between TCP and psock
> > has broken down pretty severely at this stage. You're modifying TCP
> > and straight up calling TCP functions from skmsg.c :(
> >  
> You are right!
> 
> How about we construct code like this:
> 
> sk_psock_strp_read_sock(strp)    skmsg.c
>     tcp_bpf_strp_read_sock(sk)   tcp_bpf.c
>         tcp_read_sock_noack(sk)  tcp.c
> 
> In skmsg.c we just register read_sock handler for strparser, then move
> core code into tcp_bpf.c. I believe it makes more sense than before as
> there already exist some psock with tcp operation(especially ops handler)
> implemented in tcp_bpf.c.

Yes, that's slightly better, thanks

