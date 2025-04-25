Return-Path: <bpf+bounces-56703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A150A9CE14
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEC47B6FC1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDD1A0BCA;
	Fri, 25 Apr 2025 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKK0amiM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7618C008;
	Fri, 25 Apr 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598353; cv=none; b=MwPiYwXynkzgDRyyaaiVJwL4Tsh/OiCCvrRYWgPBk2qoQhru8LHgzENw6SQr3f+cHWj8/fACdqEDaEAgyW+zEbXV85LiwkloHySqvA0xTcbUFkpfRmZyjNqXOFIMUJdlzHv1Ecv8ksxjysN/rc6avDaGqvlDiGqp6U0qrEfT8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598353; c=relaxed/simple;
	bh=+MHpsA31/1SvOXWGOB0ffKLDsT1w+DA4iOk/aNaBbbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBFlItN6yQDKSYWXkcP17LnDm928d3lEwOcK640mzkSMT8x2CqT05b4TGA7JWuv1PY5ZsICIfDfN81CscKy0OPT5OvNjbeZRLPfG3l8Waj82M2iypHduZy9EwwOpykcJ5bOds1w/eyDehxT4Zc7M7sZB4GvV4hqUrhH50/HusmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKK0amiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD55C4CEE4;
	Fri, 25 Apr 2025 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745598352;
	bh=+MHpsA31/1SvOXWGOB0ffKLDsT1w+DA4iOk/aNaBbbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TKK0amiMFc7AlVXkKZkdfL1qP70rb9ItU3i6bxLQESV/o+rYBu5Bku/wuzNfsJ+fN
	 yJNiu5KYpJOrmPpatTttewPgzZIYsZlI1DefxfivhLkuoxCLhUvzAXnTr28GLW2ujb
	 BUIS6LwJ+YNODuE69XMzST/gfbHK75TENi0KXNkRL3mE5ndS/1PFTBNHoL1I0urWjJ
	 vYhgMJB6t9vVKgMvqevVrTXVyRPZ4g6Yb/RuY1hU22KAY7O4CC3NJfsRFxwtBfClmK
	 KPI/yfcoNI4rJ0ZGoqhX9GvArz3AFiQZ7/O7Wnje5cYXUXUC9LAwgiqCpPUEgdqUKQ
	 10JccavhvMyIw==
Date: Fri, 25 Apr 2025 09:25:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Christopher Hoy
 Poy <choypoy@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
Message-ID: <20250425092551.2891651d@kernel.org>
In-Reply-To: <20250424-imported-beautiful-orangutan-bb09e0@meerkat>
References: <20250424165525.154403-1-iii@linux.ibm.com>
	<174551961000.3446286.10420854203925676664.git-patchwork-notify@kernel.org>
	<CAADnVQL2YzG1TX4UkTOwhfeExCPV5Sj3dd-2c8Wn98PMsUQWCA@mail.gmail.com>
	<20250424-imported-beautiful-orangutan-bb09e0@meerkat>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 14:51:51 -0400 Konstantin Ryabitsev wrote:
> > Hmm. Looks like pw-bot had too much influence from AI bots
> > and started hallucinating itself :)  
> 
> I'll look into what happened here.

Alexei mentioned that the bot was stopped, I presume to avoid further
mistakes. I'm 100% sure I've seen the bot be confused by merge commits
before. It happens occasionally, IMHO there is no need to take the bot
offline. Is there an ETA on it coming back?

