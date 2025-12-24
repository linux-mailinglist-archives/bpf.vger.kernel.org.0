Return-Path: <bpf+bounces-77399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5339CDB45C
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 04:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25C77300CAC5
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9933271ED;
	Wed, 24 Dec 2025 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjR5qxQD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1428FFF6;
	Wed, 24 Dec 2025 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547707; cv=none; b=jMEd4N2dWnvruic9g0/r6l90if/a7V1XazbRsIWqugiqiKOMidLSO3N1pU7k0br+Fc+t1MYpZIVM0TWlWpB4BrDA/fg9TYdFe3xZl2bfeayzu3WXpbI1fVI1XOEWCu2TkDYNyQQX3YkQhzsuyCD88BViUdZM6rOwV0YIr2+yeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547707; c=relaxed/simple;
	bh=20KI9PwmKkeJtGHt2+Ga5SqcfLaOGJS1ES7ElwLbA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvU/Lu+abf4n/SiBarqdd/iRn6x4jG8FqD0pxb2yzH6fOQyX6EGg6sVDAXOOcq567cpMl0jh12P42Qiq0zbGep5AB+vs9oBOLtc8NhLHB+N9gD4vf+Sjt4Jav1YUcqs6S95Ght5K8l0VGhUGNfsMJ/+XyaD528CTdAjk8fp16hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjR5qxQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85034C4CEFB;
	Wed, 24 Dec 2025 03:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766547705;
	bh=20KI9PwmKkeJtGHt2+Ga5SqcfLaOGJS1ES7ElwLbA68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjR5qxQDtuAqdXT5FN7AhCbNukbExxsarCxKfXBvKG++ruBXOseReHM8aLlIdruJ5
	 9d3kkJCgc8l1l9BswJuTnZRjpAEKrJOWzT4O3X1TmMh3TegaX42Sa0hIN6grqAGrzT
	 FRHOkvc77N6mHpGnliGwWRMC3c+IvwYm1TGxc5yc=
Date: Tue, 23 Dec 2025 22:41:41 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
Message-ID: <20251223-snake-of-stimulating-genius-ff4cbf@lemur>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
 <CAADnVQLAFav8czDjCYPyjDK6Bj7X_L70WQ0eSFTwvsxxEXDzCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQLAFav8czDjCYPyjDK6Bj7X_L70WQ0eSFTwvsxxEXDzCw@mail.gmail.com>

On Tue, Dec 23, 2025 at 09:25:35AM -1000, Alexei Starovoitov wrote:
> > v4:
> >   - refactored memcg vm event and stat item idx checks (by Alexei)
> 
> Applied yesterday.
> 
> pw-bot seems to be completely broken. No notifications for the last few days.

It was postfix, actually, but it managed to fail in a way that didn't show up
on monitoring. It should be in a happier place now. Thanks for the heads-up.

-K

