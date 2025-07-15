Return-Path: <bpf+bounces-63388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F658B069F4
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501E33A7855
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C322D837E;
	Tue, 15 Jul 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLikDS4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEC2C08AB;
	Tue, 15 Jul 2025 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622787; cv=none; b=kHkmUyNwya69G36pmD3pUTUIXI+Zh42RwBOTwm0pYZA94M9MrWmANggjK+p+ZsH4l23aSRaLh8wKCKjT88imLMUniBAp746Jlj7bgeutjFWhs9O7a6Q3TVZ6vn7CjYbfRzks6jvwqxT0lQCNiB0z56J5icSM3SNpBjVMPPSeLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622787; c=relaxed/simple;
	bh=/NMAMgGHYTD9vYTSprLzcvM83YjeYox24zUTm5stx4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnTh3gE5ZAD+Mghau3rayU8ozxHBDjCBJdGqE9+2v1lHoQmDvQnUeQX3p80l1leB7EvTXvp33zRwXGeBNyc1KKRoE1D6B/+PwbIWME92pl1B6twlxGzc2Z3loBqShdqzo1z824BuexEtiG52v+wmfw2CVe8ijI+q3AKBs4LMzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLikDS4d; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-879399faac9so459716039f.3;
        Tue, 15 Jul 2025 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752622785; x=1753227585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NMAMgGHYTD9vYTSprLzcvM83YjeYox24zUTm5stx4M=;
        b=nLikDS4dQnmJ77ecjBdMUF1BSmI5nyTxyVNizaU6gH51C16gX4vtjz4QNDa8STjkjV
         YjwHiRH9mOOMm+T/viOpNx5mQqyokGywZkvmCkLxctMsRDZWzuJYNLMSOb8WKbzSkqxQ
         lhpZMTVRyjl+8shw0P+MSv/gahetMJKtMJzBdN/Uear5KwfBXCSzCFzddXbAhW3hXoEO
         9iN6OOuTWEFVjNw9lPdzU2eaTkL6jp5fOqfQD8NI1AH6FMXHnWSTtsdvRjQQL+QjQGIu
         9C7QjLd35hLKRb92SPHEL/UuKdCZLHXS4zY69t+VMfVnFIC4uUAi9c1nl+NB3OaMWuwB
         Daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752622785; x=1753227585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NMAMgGHYTD9vYTSprLzcvM83YjeYox24zUTm5stx4M=;
        b=GThWIK0ZqR/54vkpEoI5jk9B0Nw/YWVTaN41d94CSa8MriGbBmqT4IUJYKWg+4Vabb
         WqFDc92Wd/SRHjoGrn7ICMr0XtRixMNu2Baz77nxpSuuE8VZDgiwH+aFdnW8J3tDyrhr
         igRP+Rkm22qsgsgYH5b7173h296HTaN/J7tFHe+q9EuI1ImI5CWqWVCiM6Bvdi7HgNvD
         ueTylc0/XEhD/f11yU/rlTHF28lRnqDYSyLyM8cSx7fowjjRblYM5kUEKtgBIpGKtRUT
         ChPiPy9r3A9CXPVXQuycGIthpVdRLmDBA7tk84eelk0DsOdUaKS34uWqFOKKKZPFIqJA
         oCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZeNYWsqwzfLA3gazpGu2FAhtDEA1rSt2oTQ/6bd7rWpcCN18Xx2DBzCddrcoAa5B9RXoWerpm@vger.kernel.org, AJvYcCXeUllA9OLnTEMkZpqZNQyykv3lTb7Ssz8fzM0y1jJ4nMMwkiUdfcGfF0J8SfNnI3LZwy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZs1+w9AQ+Zyx3TVFByvH9hhWZ0VQ+is8NgQ2WzIEDO5mAYz5
	Qw1VgsK0/ELTaJ3rOykvDVCo8PC+N1YSxGoXDj21r2V0QSeyvxdDpTlLE9D5bAscRdpCZ5wp5yw
	m4qYOgJt+bjpssF1drD0RFoflv18M5zg=
X-Gm-Gg: ASbGncuFCFaSYMeJG3TtCKpEm60R1pY/lwTW9PeNAIkYZmfB/AmltrC61ZvqnJrdWOK
	sznqeZ102tuwA40LzAbVLg62HEVw4CFjU+QnAdPM1Nml/8BgSN3UZyPHba09VtYHsrrTXhfzcVb
	IBmUSPsM5O8dUaap+TThqeEywc3PUPkApSkYwPS2NtLCF8SsPpOiDw7g12Lo83vLQSoqLyI8fLC
	VJMLg==
X-Google-Smtp-Source: AGHT+IF1AGPGLx+chLnXPzSUIbo1llisHxGaUomK0TaJpx2Peo++4xVrX9r1sdpHVqem/gKN7QhN2iTgLZPlqjjmDW4=
X-Received: by 2002:a05:6602:154d:b0:879:572e:238c with SMTP id
 ca18e2360f4ac-879c091cc40mr161860839f.9.1752622784998; Tue, 15 Jul 2025
 16:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
 <aHUqR5_NoU8BYbz5@mini-arch> <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
 <20250715161911.32272364@kernel.org>
In-Reply-To: <20250715161911.32272364@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Jul 2025 07:39:08 +0800
X-Gm-Features: Ac12FXxB5gBAZoZ7le3QojwPXtKckJgE1Ad6qaVWew8gFow9WbpZrKl1KtyVeAk
Message-ID: <CAL+tcoAn8ADUGARSzZB=5dGoa+Kh7HnNBLxyqTa3W6tOhUK-sg@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 15 Jul 2025 07:53:19 +0800 Jason Xing wrote:
> > > Although, again, if you care about performance, why not use zerocopy
> > > mode?
> >
> > I attached the performance impact because I'm working on the different
> > modes in xsk to see how it really behaves. You can take it as a kind
> > of investigation :)
>
> How does the copy mode compare to a normal packet socket?

We combine a TCP user-space stack that is not mature obviously with
this copy mode af_xdp in the virtual machine, seeing that in some
cases:
1) in the real workload the cpu% could be minimized a lot (almost
50%), which is one of factors we care about most of the time.
2) the throughput does not always outperform TCP in the kernel. So
far, only in request & response cases, we're able to see xsk ramp up
the transmission.

I'm focusing on the physical machine scenario in the meantime.
Everything went not well admittedly.

As I said, I'm still trying to find/test every possible feature in
xsk, hoping to find a final solution to deploy.

I'm also thinking if it's possible to 1) remove the sendto syscall
that is used to drive/notify the xsk, 2) prepare enough skbs
beforehand instead of allocating one and then freeing it over and over
again. Well, these so-called ideas are just out of thin air :p

Thanks,
Jason

