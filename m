Return-Path: <bpf+bounces-12703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25907CFDF0
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6B6B20D7D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243DD31597;
	Thu, 19 Oct 2023 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAaNmsxh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DE29CF4;
	Thu, 19 Oct 2023 15:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E6CC433CA;
	Thu, 19 Oct 2023 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697729588;
	bh=Uc+05bAqsoGMggBrKojmgxhn9M02KPabo337XfIvTck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rAaNmsxhMInS/iWv20j3xWfY0Mz+qGbenqq7UF0DBHFFo0BbN17LuuLyqEfZYBJX+
	 PjhEpxxA7ivr6e8VtUTSpENbtptf+mwOxVU7bm02JbZiA65dzKm44YZF7tBD6Rk7tE
	 yhxccGMxkv9j0p1HlNqM1b9VrG0teaHA/DHPnFX7fyS+MhdJl53Otq0xfOYGQTeKDf
	 BoucEdEuKrstivjxTRqIEbyolQvwUJAGvu5BTxK4Bi0u0AZFq1P64ek8gCkFSP3z5c
	 d7OsWvtO3RhpEg2lHxAU3Kb9m7GmAVxAWjJd3agnIwsjIjltujvDGhZIyJMJm5Ixmh
	 EFwIBhfeubtVA==
Date: Thu, 19 Oct 2023 08:33:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Breno Leitao <leitao@debian.org>, sdf@google.com,
 asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 martin.lau@linux.dev, krisman@suse.de, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 io-uring@vger.kernel.org
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Message-ID: <20231019083305.6d309f82@kernel.org>
In-Reply-To: <7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
References: <20231016134750.1381153-1-leitao@debian.org>
	<7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 08:58:59 -0600 Jens Axboe wrote:
> On 10/16/23 7:47 AM, Breno Leitao wrote:
> > This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> > and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> > SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> > and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
> > SOL_SOCKET level, which seems to be the most common level parameter for
> > get/setsockopt(2).
> > 
> > In order to keep the implementation (and tests) simple, some refactors
> > were done prior to the changes, as follows:  
> 
> Looks like folks are mostly happy with this now, so the next question is
> how to stage it?

Would be good to get acks from BPF folks but AFAICT first four patches
apply cleanly for us now. If they apply cleanly for you I reckon you
can take them directly with io-uring. It's -rc7 time, with a bit of
luck we'll get to the merge window without a conflict.

