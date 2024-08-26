Return-Path: <bpf+bounces-38098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA895FA44
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992532815B8
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5391199EA2;
	Mon, 26 Aug 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GztjKuuk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DD199243;
	Mon, 26 Aug 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702563; cv=none; b=W9I5nFrCdu9vceykGrnvGs6mLiP+P3i100Wtqt7X/XH72d1IZ4oJKvwy1IyaP+d8s+bwDieOUlgx+SfSkWWylAJmW0akoNaenG7zEGLOFoeoj9WkOtVI+ZDvemz+Y4lhG+B3DZHCGRZNTPtPQ9U/qWjbJt0yP1fgf424LG041oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702563; c=relaxed/simple;
	bh=lWkYccqrI8abW+zXHMHwQiv/jHDEjgCiW5moaBHwmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKamceKuBeZDqGpWkbFbspZ6D1UaBG7tKa20CAV2IH3OQYY0VDIg8Xy1bivOKzNReAfeOiox8U9J8EVq0SbgwTffIGXYToxIZHh3PAZ6nPmVesND/dLl3W2KfsEv0IkzReiAA6224VAuJhZY4Xc+G6mGBbAf8Yr61JXa8jdd5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GztjKuuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D8DC8B7BC;
	Mon, 26 Aug 2024 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702563;
	bh=lWkYccqrI8abW+zXHMHwQiv/jHDEjgCiW5moaBHwmrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GztjKuukceFjbBeMoNDO1+iHN2CH8/xeeFRF9tLSzay3PWFvghyK7NwNiOhFEpdHg
	 dh1EBZVnedjF1kNA1VBLphBV1f4yTA9KKMlhtu2ctYgcbk90I2gVt2fEQ6cLIY5iVX
	 KeOzN1rkBsvEi/gVp/2aecKE2/f2ptXQ35cE/XuZFkB4fbI56CY3c/ELyvG69nVU8t
	 fc7sgZD8QEvTcNHMZdvgNnK5zo8jxrh5XKCsFbgMxnNZT7LMaCSQYYdReSbM72vToi
	 caR36Y1VYPlwVKEpM9ZN6szE44oU+5qU7SNh7uTXvYuQwOBuRyKbR3fqTpPiAd/mZO
	 68RG3WHVOnn0g==
Date: Mon, 26 Aug 2024 17:02:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <ZszfX0V1YgM0225K@x1>
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
 <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>

On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > I stumbled on this limitation as well when trying to build the kernel on
> > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> > created a swapfile and it managed to proceed, a bit slowly, but worked
> > as well.
> 
> Here, it hits the VM space limit (3 G).
> 
> > Please let me know if what is in the 'next' branch of:
> > 
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > 
> > Works for you, that will be extra motivation to move it to the master
> > branch and cut 1.28.
> 
> on 64bit (-j1):
> * master: 3.706 GB
> (* master + my changes: 3.559 GB)
> * next: 3.157 GB
> 
> 
> on 32bit:
>  * master-j1: 2.445 GB
>  * master-j16: 2.608 GB
>  * master-j32: 2.811 GB
>  * next-j1: 2.256 GB
>  * next-j16: 2.401 GB
>  * next-j32: 2.613 GB
> 
> It's definitely better. So I think it could work now, if the thread count
> was limited to 1 on 32bit. As building with -j10, -j20 randomly fails on
> random machines (32bit processes only of course). Unlike -j1.

Great! I'm now processing a patch by Alan Maguire that should help with
parallel loading, I'll add it o the next branch, together with his work
on distilled BTF.

If you could test it, it would be great to see how much it helps with
teh serial case and if it allows for at least some parallel processing
on 32-bit architectures.

Thanks for all your effort on this, appreciated.

- Arnaldo

