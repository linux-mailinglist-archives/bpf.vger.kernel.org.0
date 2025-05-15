Return-Path: <bpf+bounces-58338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E51AB8DEB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFCF3B2D70
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170C25A34D;
	Thu, 15 May 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm9+2cdD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA26259CBB;
	Thu, 15 May 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330604; cv=none; b=XWEqvRsMFdABqK9WgeOuth+IGyuyOqkUNEZ7Bnx2V+Rt83oyKE/gXnn7JDS1OCs5rgbl8WnzzzQjzF7nZx+eSZYLOa5iNqNQ/8fwjdJfXJ7DAcj8hRkHJ4AxSGGRVtBcW8ACB3PniXZgC6LVA+INek5rxT1eCfZfNthnNIiGZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330604; c=relaxed/simple;
	bh=ueXrgOKxju5TM0wNlBNM4SK5+8YeomN4JRdcAYs0eHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll/tj1W1oSCbSIansBA6C1psYgXD+t5VpdDZA8++gTe5ckOK7QTZrWbfOm1qYNNpKf/8BL9UrdnGluMDEbK3IMpfp5L6+0b26Gd5sm2f5znWxQfzlZIon0yLh+rwOtJWHVQScC3JI+YGj44Htu96nfwL/INjkGeEbKxnT9aM+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm9+2cdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B88C4CEF2;
	Thu, 15 May 2025 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747330603;
	bh=ueXrgOKxju5TM0wNlBNM4SK5+8YeomN4JRdcAYs0eHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tm9+2cdD+gA8f65QT4gZG57//UAl7fnmpATiWX15tXw2fzEl4pPXievYMMPdNvdNp
	 IpQZM6rq/kE31/7d3jY9ESn5p8DfWucjiJuudtTZ922cAcOaz9/AzS2A1LF/CIm0qG
	 39av+qatsnFdXBsFgacVN1iBaZYFbb8CVn886gktqVvwVva87lJBHsByNYnLIRJ75X
	 KF5eJi/1s2yqIj76D5+SJQNc7a4Mt+nEG5FNTa4AT7l99sZpakaf6fIygomPkwSB+0
	 qsqSbXLsn7T7rwZSQIsNAY80ErlpKnm0098ckLPlhq4UWko7FDN6G9Rnbd9NcF1F3N
	 ggDi6WOd0XVBA==
Date: Thu, 15 May 2025 10:36:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev,
 edumazet@google.com, kuni1840@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next] selftest: bpf: Relax TCPOPT_WINDOW
 validation in test_tcp_custom_syncookie.c.
Message-ID: <20250515103642.01ed5f5a@kernel.org>
In-Reply-To: <174726243176.2534141.9628048963449437170.git-patchwork-notify@kernel.org>
References: <20250514214021.85187-1-kuniyu@amazon.com>
	<174726243176.2534141.9628048963449437170.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 22:40:31 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
> Here is the summary with links:
>   - [v1,bpf-next] selftest: bpf: Relax TCPOPT_WINDOW validation in test_tcp_custom_syncookie.c.
>     https://git.kernel.org/bpf/bpf-next/c/4dd372de3fde

Per the link in the commit description we need this in net-next :(
Did it land in the non-network BPF tree? Or on the network branch?

