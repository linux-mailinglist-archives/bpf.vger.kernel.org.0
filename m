Return-Path: <bpf+bounces-61806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346EDAECC33
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 12:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC963B5CE1
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665A204096;
	Sun, 29 Jun 2025 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGrQyoAY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6578F2E;
	Sun, 29 Jun 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751193825; cv=none; b=As6waPnZJC5fFzBxajFILAbsxQyo5KfjwbmJdyumw8uXytx25GpycA4FgZvhWy4KLQ1MbO1/m9cQaX4yjPJY5dQHQ5gnLXwGd+aca+YZB87mY+AuntvR4QidYx5VqJe3hj9qxPAxd85Xy+exUKyhB5k/PUdGk9/cmD/Lrb8PgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751193825; c=relaxed/simple;
	bh=ZpLtuh86E89zYh29URqnIcZ1DiSLHtt+B+iIBE6z0Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoJu9/RuLXmtiF0CmGqpwXt9SAa3/eH7O78stNSfjFEZCUqeBB2mjrNG4YQE06ea66f+W3M15dQwtroRFVByMdqfzigb2y3uQqM2RzwV7io0/Og5VEXdOD0JUx7GaLL+dj1UaU+qWeHqO7x7+qXuOqcq0hAD/r6bfXIMjbG/TBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGrQyoAY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2fb6378cso11444875ab.0;
        Sun, 29 Jun 2025 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751193822; x=1751798622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGCrUUFVv/kt95mYSv6XUlmbedZRctqevQjAWxYlvOY=;
        b=RGrQyoAYCgTt4i2A3ZXqyEtoawq7CCnkJd/Q6jwDdQ0VLPQBntJWuHAvOa4+y+YZ5+
         mPxwIeSnC/EygLOrxF/m8XMWj70qs6N3xQC+2LDefB7QqRNpnxPu0HSIgKlrGNICJx5G
         X2PiO8BLierJeCS3GdB9nIJXsfiBPCLJzWLNstOkHySOIMysqUYe9BsvYwujbqXyztaG
         jgXA4Z+ZWmrCa4wRqbM0tS3erDaEMXTsLBC7BOeGh7UMGy9zm0wngXf09ElS6MAO79CH
         vZ1/IHteG+avUI9RxJTHD+XAGbhQSLC65ZHKZ4hosVkBmLfRa71SGjH5+DMNrtD2p9S/
         EOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751193822; x=1751798622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGCrUUFVv/kt95mYSv6XUlmbedZRctqevQjAWxYlvOY=;
        b=JYrbt0JiMwlflY7OykvW0s++YD9kaHjWrfU5ucIGc9dCmZax3lljNzzbOdRAr2E12h
         KpJpcuuci7YXwIHKnqEUzvhjzMpPRS2mNf8SYYFeqw99wlHeOcEICJ1QNGkofG07CJYB
         59y3BMlLQC+BnT7OFvb2dpWBDKJi1RLP2Kg0tQVKAKQ1PKO3Ni0JHJjWR+Pafi7nxtzi
         Aj47Gzj3RkvP8OdoR3WFR185Eq+4nkQ9bmpMoyx7ztVQYbn3JMwJd7tVIYkDNWLTop+l
         FW9XY0HQS+JjArs+Nb2mB0z2lWA9EOOoNfxDVcsv8lZGHtfT7Cz3xw/u5x/rTDIXN/fU
         a3xA==
X-Forwarded-Encrypted: i=1; AJvYcCWmPci+Q9WFB1yGrqAg4dUbfwUP6UZOSUo8OcgLh0k9efExFEoWisSCNBf1S0g57xjkSJC9mW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZnxMuEp7hwwGRge4j7qexeTqPoMiLRm7lugwW3liamAFYEbu
	Qg6DVq8ozWohAGTNeyj8iL4psdF7auwvWb2XExH+gQFqg19GauaPfhYG6b2Zy0SmSxlXoVQ7BMm
	2drziuqjHo5GSVv+AuYTcAqAsTu/nTHY=
X-Gm-Gg: ASbGncuAHEaqHOv+I4KJmgW7HXZ5JywTlyfzdSlpgbWLBvoZOVwHc3r/2bw2XKTJkE7
	u53NLTumBp9EbEfYTRDmuf6h8PwvH/6Nx45Eo7wfMytDqbLvjzmo5hy2g3Pdh1k0R5bkI2mMPUI
	O5I9SQ4eK80pNnCatgUw+CR0ZzN3BTbngBl3i2lmHhBnc=
X-Google-Smtp-Source: AGHT+IFzgtIpomD9pkXx6GJ8emNiPPiO+ni4u8S/c2UNTWfgRW7sSbDgmW8AdiQqHgvF24F8ODl6wxnl3ZbOvPq69V8=
X-Received: by 2002:a05:6e02:1294:b0:3df:2f9e:3da8 with SMTP id
 e9e14a558f8ab-3df3e2e3fb5mr118518555ab.9.1751193821839; Sun, 29 Jun 2025
 03:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com> <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
In-Reply-To: <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 29 Jun 2025 18:43:05 +0800
X-Gm-Features: Ac12FXzDVHky2GUp1Dyr5emkdivA8dA5KnWfhWBtS0FNntjcXwcbH66zhXt79iM
Message-ID: <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Fri, Jun 27, 2025 at 7:01=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch provides a setsockopt method to let applications leverage to
> > adjust how many descs to be handled at most in one send syscall. It
> > mitigates the situation where the default value (32) that is too small
> > leads to higher frequency of triggering send syscall.
> >
> > Considering the prosperity/complexity the applications have, there is n=
o
> > absolutely ideal suggestion fitting all cases. So keep 32 as its defaul=
t
> > value like before.
> >
> > The patch does the following things:
> > - Add XDP_MAX_TX_BUDGET socket option.
> > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > - Set tx_budget_spent to 32 by default in the initialization phase as a
> >   per-socket granular control. 32 is also the min value for
> >   tx_budget_spent.
> > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> >
> > The idea behind this comes out of real workloads in production. We use =
a
> > user-level stack with xsk support to accelerate sending packets and
> > minimize triggering syscalls. When the packets are aggregated, it's not
> > hard to hit the upper bound (namely, 32). The moment user-space stack
> > fetches the -EAGAIN error number passed from sendto(), it will loop to =
try
> > again until all the expected descs from tx ring are sent out to the dri=
ver.
> > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> > sendto() and higher throughput/PPS.
> >
> > Here is what I did in production, along with some numbers as follows:
> > For one application I saw lately, I suggested using 128 as max_tx_budge=
t
> > because I saw two limitations without changing any default configuratio=
n:
> > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > this was I counted how many descs are transmitted to the driver at one
> > time of sendto() based on [1] patch and then I calculated the
> > possibility of hitting the upper bound. Finally I chose 128 as a
> > suitable value because 1) it covers most of the cases, 2) a higher
> > number would not bring evident results. After twisting the parameters,
> > a stable improvement of around 4% for both PPS and throughput and less
> > resources consumption were found to be observed by strace -c -p xxx:
> > 1) %time was decreased by 7.8%
> > 2) error counter was decreased from 18367 to 572
>
> More interesting numbers are arriving here as I run some benchmarks
> from xdp-project/bpf-examples/AF_XDP-example/ in my VM.
>
> Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256"
>
> Using the default configure 32 as the max budget iteration:
>  sock0@eth0:1 txonly xdp-drv
>                    pps            pkts           1.01
> rx                 0              0
> tx                 48,574         49,152
>
> Enlarging the value to 256:
>  sock0@eth0:1 txonly xdp-drv
>                    pps            pkts           1.00
> rx                 0              0
> tx                 148,277        148,736
>
> Enlarging the value to 512:
>  sock0@eth0:1 txonly xdp-drv
>                    pps            pkts           1.00
> rx                 0              0
> tx                 226,306        227,072
>
> The performance of pps goes up by 365% (with max budget set as 512)
> which is an incredible number :)

Weird thing. I purchased another VM and didn't manage to see such a
huge improvement.... Good luck is that I own that good machine which
is still reproducible and I'm still digging in it. So please ignore
this noise for now :|

Thanks,
Jason

