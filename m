Return-Path: <bpf+bounces-38491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86C965278
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A071C2470A
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBED1BA28A;
	Thu, 29 Aug 2024 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxlyKeFF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497918A950;
	Thu, 29 Aug 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968792; cv=none; b=AxxJ84TwMIGEDHluiDeO1DOzjEDyYZZupxrhrYwqMis5Q3WcgVT/+7UEW3GQYQcbo7H+zJNZR4Uk+mbD+Htbd1helIKcu2Pp/Y5hfQThisjz7fXNynau53rwaghe/jHE1+jcR5+kQwvQMouZK/MlRi5WP0aO5low0M7IgF2J7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968792; c=relaxed/simple;
	bh=jQCyfB7bd52U21Qbkv4SE2ontUcwyWwphxbfj2QlHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj0OWBj4FaJo1MhCXYt9eloxPZaNxXL5fXg5yuAOntDq0jhsrqFR7r647+QfYC54YiM9WYjspvynMofAaM9s+/Ij/HHHM6nMtpbJFw0qSHYRaiL6jxWfuUV9NBan2aS9bEHHpBWKwgCL617+c2i5Z5ODBtUiq4MqEbQvtFr2jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxlyKeFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B85C4CEC1;
	Thu, 29 Aug 2024 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724968791;
	bh=jQCyfB7bd52U21Qbkv4SE2ontUcwyWwphxbfj2QlHNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxlyKeFFdFJx0TiTONB1xToeDXMi7NUA2esxm8O74z7ocqfkcg0e2MQnkBe/Wtax9
	 OqxhF8Zb8qGLv8/xhcuiEeKtznKKeMgxpRocF/K7qhBRAMpUoXe5sUHW3bbmTnCvlp
	 73y58vF34BjGDpYH7oMeAF1+MijelrE1Oy/D2fWf4PcdQKxWLT1T3OBY8Nj3zxD59S
	 fGH+7YuBNQ7KoDUYnh7d2zVXm8GvW6WTw/sk6wzHZBqaDgcy/AF3GWV4OY1KTuVUu5
	 ZsDS5dg3Rlkhhgw4Sj5BtfzrN9pUSqWHj6ZCTbgnE4aJ3Mpb4dnvSv5ANTS9JKRUO2
	 Z2G116WRowWXw==
Date: Thu, 29 Aug 2024 22:59:47 +0100
From: Simon Horman <horms@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, sockmap: Correct spelling skmsg.c
Message-ID: <20240829215947.GD1368797@kernel.org>
References: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>
 <ZtDlZtUj2Xzp6ARQ@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDlZtUj2Xzp6ARQ@mini-arch>

On Thu, Aug 29, 2024 at 02:17:26PM -0700, Stanislav Fomichev wrote:
> On 08/29, Simon Horman wrote:
> > Correct spelling in skmsg.c.
> > As reported by codespell.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Although I bet there is so much more spelling errors :D
> I have a spell check enabled for the code comments, and I'm almost ready
> to disable it because half of the screen is usually red.

For some reason this was the only one I noticed
flagged by codespell. But I can look again, with other tools.

