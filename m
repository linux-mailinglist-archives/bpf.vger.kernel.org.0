Return-Path: <bpf+bounces-32781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6DA913101
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4C6B21AF1
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C031F63E;
	Sat, 22 Jun 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AojQ0sbc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8137C;
	Sat, 22 Jun 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719014554; cv=none; b=H/wcjd9lzRkIGWJgetbiz1uF9t6iGIGI4a2pIfc79C7z1FRdpv1qh1VFm+rZCC8Gbv9ncb2ZG6xVd84M0KacfRuwCT45NQuPb9GFK+VYaTAuXonXOROHBB3ibRIXKGbbvj1Daz/4NuYXsskF00J86RFs7BfaAgJUp8xcW+FsTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719014554; c=relaxed/simple;
	bh=BLNegGk7Ar3Sr7RqPCQ7WoyTkKu2K1zChYztvm/n01s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiMXaHxsJqysSpblV5YLV37W1kLe2fIXICMDG9Dspo34VSlMn5ap7h092piXBZiCDCnDO++z8ohcPYml3djhPmyeW+5ehlFubh8SIsb7e9WOf8nmYFg2v6+8TcoGcmdwc2+OLT0+Ku4diK710NlYdO3JveZZYBwFrErvB4wP6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AojQ0sbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DF6C2BBFC;
	Sat, 22 Jun 2024 00:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719014553;
	bh=BLNegGk7Ar3Sr7RqPCQ7WoyTkKu2K1zChYztvm/n01s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AojQ0sbcRdXaRjzwsmzVXO+Z9gqaUsQpJinUt/5UVc/HfsuM3Kb90tIWX8zNyMTdE
	 CThWjCgLXYpRLSlzAYsU0gsKqQQMAt/Vo2yc5ah5Ikv5nQ8N+4Q6y/sTX31fyM55dF
	 anYnAznHOr5la5C+1VE0Uy+gxHgnSr6x4+Gajh9gAv479Etf6wCVSxTvONjlAc/zZP
	 PlQQQL4slkfVqWjFXDqw3gIaIyXH3UhOY9yYsvsk3mFIDb2dUEqEqlU2FSdsJujc/w
	 l+TDz48Hu4eTYxDFwDHChP8Rcz5JyCpVBhgqOmFfn/tEgXoKX9t7Q2KrSOyI1ZNfYp
	 pTFZ2h9IfYjKw==
Date: Fri, 21 Jun 2024 17:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <mhal@rbox.co>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
Message-ID: <20240621170232.74ce4a27@kernel.org>
In-Reply-To: <20240620221223.66096-1-kuniyu@amazon.com>
References: <20240620203009.2610301-1-mhal@rbox.co>
	<20240620221223.66096-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:12:23 -0700 Kuniyuki Iwashima wrote:
> Sorry for not mentioning this before, but could you replace "net" with
> "bpf" in Subject and rebase the patch on bpf.git so that we can trigger
> the patchwork's CI ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

netdev runs the BPF CI, too, FWIW.

Open the patch in patchwork:
https://patchwork.kernel.org/project/netdevbpf/patch/20240620203009.2610301-1-mhal@rbox.co/
Click on contest in "checks".
Select Executor = "gh-bpf-ci".
Click on "outputs", you should get to:
https://github.com/kernel-patches/bpf/actions/runs/9607623089
If you click in context on the branch name it will take you to
the tested branch:
https://github.com/linux-netdev/testing/commits/net-next-2024-06-21--03-00
which had:
  af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
applied, 5th from the top.

