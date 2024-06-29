Return-Path: <bpf+bounces-33391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702091C9DE
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 03:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633B61C21685
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594D17FF;
	Sat, 29 Jun 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz1mZdub"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977963C;
	Sat, 29 Jun 2024 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623246; cv=none; b=F97vjQ/JT8oFTen10nLLc4U4TY6uP4DFKofRyw5eO/wcBOUrCB8EmRH5++Z3idwLf28IxEiYUfgq/JTJRGi5pwqRzH9+sB3HikF3SaAuFrAObm1OGcpJEUUM+BcI3aIFFdvF81cJUoPpuLI6/NHMqtfPK3LfBfzTOzynL7SMSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623246; c=relaxed/simple;
	bh=qDqhXvUXMIc+AFhmq41Sha8+fu2VdXeYid3XXG5bgqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNkUr9ozZO/6Tng1EWWwKQmo3rRnDYBhuGbYDRpwD/9jlnOyaWbCeWFn4fUDFh4rj0w6slrMoxI1erIw9DI83j578GoH6Iluna5GTLDIAnbn9YnFu8zCvWP4/NXCGpYKZx7gw82cY56IpB+VQSvLVZEicwbfjjuuLzdAi6OtAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz1mZdub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D498C116B1;
	Sat, 29 Jun 2024 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719623245;
	bh=qDqhXvUXMIc+AFhmq41Sha8+fu2VdXeYid3XXG5bgqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oz1mZdubLqYAWGU5eS97jQnCATX4YuAf2g0Dp5jd/GugskOoC91GY72M7aOK59jA/
	 cfu2nyYLDGgij4TpNPn8fiFwh3uKTbVu535k8JYyF568/nyXaSKwE4DUTH4dEISaCZ
	 zoFvylTrD0v2BSBVd5SN8Rk6a2lGLmQaf7vxI9cIOC5p6HLqeitXwF6LZ2r6LhJ87H
	 afAE6zC3U3wqofNgeaM5v9iwo1CDT/S5PmOdza2jEwN1pcuuPlJBjAenLhrzpyICmt
	 HOEDUuvfXAF9nKesaD6U/gmMQ6xWX+M0kbav0nDYEdYeNXo2Wh0U2DaJKsOAQ/NnS9
	 /sUBf1xp1ozrg==
Date: Fri, 28 Jun 2024 18:07:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFQ=?=
 =?UTF-8?B?w7ZwZWw=?= <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, Hao Luo
 <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Paolo
 Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH net-next 0/3] net: bpf_net_context cleanups.
Message-ID: <20240628180723.53980170@kernel.org>
In-Reply-To: <20240628103020.1766241-1-bigeasy@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 12:18:53 +0200 Sebastian Andrzej Siewior wrote:
> a small series with bpf_net_context cleanups/ improvements.
> Jakub asked for #1 and #2 

I thought you'd just add flags check in xdp_do_flush(), but I guess
this is even faster :)

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thank you!

