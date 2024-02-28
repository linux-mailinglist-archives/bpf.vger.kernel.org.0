Return-Path: <bpf+bounces-22965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A286BC5C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799641F22A49
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7647442E;
	Wed, 28 Feb 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b/WtlF+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318972920
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164427; cv=none; b=ZQs9CedjQkrllNc41Jm8CB9HPNvbRVn5+P1k7D8J66XtrcRQIyHoqUjYUbOlkH+IYzx8Ure1dqvclElHKiljGt3cOiGpAVBKVDAw0B8abaKFqCJ05DuesGZ6g0CajteT/Ldl5uJwK8hyrqErP51T7HaoPXIauN2LsYiYFgXvR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164427; c=relaxed/simple;
	bh=226C5h/Y1VCHHH/6rHYwB8j04u2Bj9Ng00Ye5vrzpe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtjobTTusCylTWEzEvq9uAEspC20J/tCEdlhZ6kPIKadqL/wBSOiQj9X4gmszQvWKmxna+Snc2AHA3WabZp2RNxzgXMRyfW69DtSbMt+VFrU/wA84SbLTC4ACfAzsr70nRY0rPEOO1bOmjF5nQIFTZO9tSNczzJHehEKm+BHlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b/WtlF+/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56694fdec74so298380a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709164424; x=1709769224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=b/WtlF+/cAuvq6M20JXmWz8A2nkQptPjwcnBQLZkV9kPBbnAW24f9bgh5o9TXc7veb
         a3eOi5yMNeZ0hOuCQ3ljUOEqMjHWtp6/ScFlSp1ToC/hhPIiGktWzjz7Pdv3WAnYcinj
         eCck83VpNb35lad8kW5Mqhr9VE5ZFzNOGWHUFbs76XLAQrQEScmGNMXDAz+j8u5YGIHO
         R56D/9Cp+0iznOPm3kXRtfJh9YHYZhdss1n9vCIoVe4M5ivBNkgV0HDZyaRPF1N6UCFS
         E9MKOTH213WGU0/R421/tyAuYheLu49B136cC2wpkd/ARaWY9L02tzb2vCoR9xRlVYaa
         4uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164424; x=1709769224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyTb/9u8Fut3XJA7s5sTKjASpumq9GMF8lzH2f5O968=;
        b=XVH+JO5x8Gye2Z+1KhP5Zx921jIdX8hZ6DpONoRB8iWnT6DCDC2JXMHzD+DU6uBe+c
         fRCme6NaTx6/V1oiadNP0nLhquLgC0xf7N5+pShyywrxafXh9mVGvkw1VFn8K4+6FlRh
         vv3R+Wm+UefLuIbaAZMh8qmumgCDdpp8km0Mv/vEG3QKdypAa6+tJ6qBhkjbUJbnS9y1
         5AZ46/jSBaVWNOt4bMQzN+AbPP8m0w+Hq+1hJQilxBcToS0wLx9X86olH2cFX580VH7j
         /PR5aE+60+3J+ZMa6EDtpdbHewhg3RhuE91NNn9UHC6SCkdQmhLDtE7OBeNSINmkyxLD
         L5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAdn6NiWx6mYnBlnBPEqkV9h05cBw7+xjhcUOH8N1LF/sfRYsGcugqIGJv8RiNA6aXwIzXuNAxnD6fE9Fs3MPGY43L
X-Gm-Message-State: AOJu0YxCjPZr9qPPh1KAhD7tFaDnjhLv97SrGrNGwD0wAkzlhydRBVTg
	MY7QIckeDXGfmBaSrKjJw3QGwHPKGx3u5BZILkvBPbrkktmXCcJyJmXJYzSvpjYmrgb6B0HLLIP
	CT+LXnbm9sjK8WbdPkBW7BH7pgdvnjPy02Qn+Ew==
X-Google-Smtp-Source: AGHT+IFWoAzwjRhf4ZRQtooisu3O7UmB386nUInSxafRbB0jMnEpyJq60SxptGuNyafKn0Mhr6ixAk9Zq1h7yoTNCaY=
X-Received: by 2002:a05:6402:b57:b0:566:414d:d724 with SMTP id
 bx23-20020a0564020b5700b00566414dd724mr253144edb.35.1709164424445; Wed, 28
 Feb 2024 15:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
In-Reply-To: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 17:53:33 -0600
Message-ID: <CAO3-Pbq4Fybyhodv5-36U=-rgttkjxFj6cRvAGcapvE8pZyWSQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Feb 27, 2024 at 10:44=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Hmm....
> Why napi_busy_loop() does not have a similar problem ?
>
I just tried and can reproduce similar behavior on sk busy poll.
However, the interesting thing is, this can happen if I set a super
high polling interval but just send rare packets. In my case I had a 5
sec polling interval (unlikely to be realistic in prod but just for
demonstration), then used nc to send a few packets. Here is what
bpftrace react:

Normal:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...

@: 0

real    0m1.527s
user    0m0.073s
sys     0m0.128s


Extra wait when polling:
time sudo bpftrace -e 'kfunc:napi_busy_loop{@=3Dcount();}
interval:s:1{exit();} kfunc:udp_recvmsg {printf("%ld\n",
args->sk->sk_ll_usec);}'
Attaching 3 probes...
5000000


@: 16

real    0m11.167s
user    0m0.070s
sys     0m0.120s

So the symptoms are the same, bpftrace cannot exit despite having an
1sec timeout. But the execution pattern for these two are probably
different: NAPI threads would keep polling by itself, whereas sk poll
program might only poll when there is no immediate data. When there
are packets, it switches to process packets instead of polling any
more.


Yan

