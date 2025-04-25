Return-Path: <bpf+bounces-56709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A9A9CF63
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20831BA1082
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F121F4191;
	Fri, 25 Apr 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tMs8P2PL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D7134CF;
	Fri, 25 Apr 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601526; cv=none; b=up0Hk/+ZMCpvgRv5GxK4NFtudNfXgwrXXkLSml7t+XlLtvd77bWeyMld3tDUMPcDlz2CBe5nxagIO6As2oXPX2+/vU+SAJYrxcv+pMyONqVtbi4KHFGdyX6qfzFEieN0RGpuV04uo+WEtTBGwl7LeRpeYN5LHWm8Rieo5jSd6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601526; c=relaxed/simple;
	bh=yMlIIWP69R2LmDFUlaAQd5j5I9BJBFAMsgi+9DqlMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/voUwadeuh1j59D+p9uk1fl31DLK1iqyldENvd+7RSF398L7aGPjCawbQ0wkENC+eS1Lw7q+VYlg7LQKHuGjg9vUn995DXDM9iCR2MW1yDGC2XkxIOrPzfCqXGFkpQLmbAKgfl2TO9z0UiXwFtyfQaajhWyTAok0vsM2qL/1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tMs8P2PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5BDC4CEE4;
	Fri, 25 Apr 2025 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745601525;
	bh=yMlIIWP69R2LmDFUlaAQd5j5I9BJBFAMsgi+9DqlMI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMs8P2PLhXOBbIybhWvBosl6Tc71+3SXPrxqmWH6brQ9SWT5tU3K/zDlpanVZo30d
	 6S73yPSNJSzKy3cyvYIkJbx+k2bpINNHzqfn8ftSeknc1GBYw7hDNsVdyxBTYsATFF
	 L3PR6RHhnIVvd7fEw2zhHurgaBTKUNAmOrkorT6o=
Date: Fri, 25 Apr 2025 13:18:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christopher Hoy Poy <choypoy@linuxfoundation.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, patchwork-bot+netdevbpf@kernel.org, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
Message-ID: <20250425-mottled-ruby-leech-d48a91@lemur>
References: <20250424165525.154403-1-iii@linux.ibm.com>
 <174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
 <CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>
 <20250424-imported-beautiful-orangutan-bb09e0@meerkat>
 <20250425092551.2891651d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425092551.2891651d@kernel.org>

On Fri, Apr 25, 2025 at 09:25:51AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 14:51:51 -0400 Konstantin Ryabitsev wrote:
> > > Hmm. Looks like pw-bot had too much influence from AI bots
> > > and started hallucinating itself :)  
> > 
> > I'll look into what happened here.
> 
> Alexei mentioned that the bot was stopped, I presume to avoid further
> mistakes. I'm 100% sure I've seen the bot be confused by merge commits
> before. It happens occasionally, IMHO there is no need to take the bot
> offline. Is there an ETA on it coming back?

Yes, I'm poking at it right now and I'm hoping to bring it back up soon.

-K

