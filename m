Return-Path: <bpf+bounces-62240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8731AF6CB9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C841C41312
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869502D0C73;
	Thu,  3 Jul 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWkZMlUi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4B295523;
	Thu,  3 Jul 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530981; cv=none; b=UIjm1x1ENuzFkYcgunEu1fsHeLEzXw3TcRE/AqyrplIVM8Zgszoo9QafEbrHjqGJFDnEzcQg9wVgDg7ANm2/evpd7zpD/sIpLTk7+Wsn5Ni/e9UqwFOZJGtmkZXAJmk50JC3MwzTYxoRcldkhwoDjD5RtlaePIY3zPNetYPzCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530981; c=relaxed/simple;
	bh=R1aiK5wt4ta91z40pzcnnqgIJtOlvHV1qIe3gS/lu6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCtqSpPQ2XRSEOqSkMAyfP8+/M6O3dD8D9r9KPk8yqq0QdCTUw+dqiB70dgjZuZbnoo2umFZS08aLzT5CxiO0+mXVB7kKteibPNQgZSolJ1q/ibng2ALsuTnI/Bqvwu7p0pWCZe4TBKyG8fUOTLuQ+Q1/+TliLc9z+q3tosMVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWkZMlUi; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e05bb6efe0so9124625ab.3;
        Thu, 03 Jul 2025 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751530978; x=1752135778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z257Yice6IBNDbRebdWjE/izGZAoWE1CWTqPNOrEQJ4=;
        b=NWkZMlUiZJZ/qtpelsrftWtVzAdssC5pq8ggYONPfEXH8dxsJdOpuaUVjC+9Q9U2b9
         G8NpGhgbu420pXVNwmzVQAtr3xC+iHGcxQ+YYjYtd9wpsuleLJSKTqBDlH9MOcBu1cuL
         Vm7s8EbkZ/PAZ5DJxTneemyG6SLP2IOtBcu5o6m1Uy+os3jKOZE6xYnb8p3LHxvDsBYb
         lmvy3QKzKI5tBRz+s0yr2dyW2LgZ3WnZSMKbReXFUKIZcjAEXVm3FucYtzUiFp9CP3ks
         yObFINjRWV5fGr2EvQLOSnYoqmjdTFnFcmVPq4v3nqrApO0aLOI3smsvM0yYvcdoZrr9
         fKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530978; x=1752135778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z257Yice6IBNDbRebdWjE/izGZAoWE1CWTqPNOrEQJ4=;
        b=iQ3DjCjtTdXuogViNmZu7NSdcVcETfcqp73QlcbM9AmkNoTIsIZ0Guez7Vh1nr264N
         CkWKc6PNHBvt/n3O1PeLPMahgPGfpf1cyN/oDO1SnmqXvGxj9IhxoNlSc2zeHPk+4cWE
         XAavAQbB61B+Om+iU3zR+gbrbovLWwM9/WCNkjFLpda/JFVcEk2xKB5tCcXToHlHBy2x
         a50J9n/lvl4nno6pMRBANMGvEtH5tclhrI1SRTXu2HGemChswk14U3Ry9MeeV3nvWIfQ
         08AJxmaPiuF9MFTMcToVhBx6Hint3cxay1bnLoeGiCbiel8p/4cxhehhdwidccGNdgGx
         KRlA==
X-Forwarded-Encrypted: i=1; AJvYcCWZm/A/1OahpZef3kzS1VE559eEkSciEZ34M6ogMpjoD6nwtz7U6S0JeG2Sl2Fpm/mI0tU=@vger.kernel.org, AJvYcCXLLZ6CjuxHNXGq/0h7MrqxSuQQIpP7XaylPrEYGEZeGL9IPTXrZzjd1n3I1l08OBjlSpX99Ojj@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9JTMA83vG3nT5Uh47q6u297EoXEgIIzO9VIc6pB57AjHyEpw
	aPji82iaRk7JRjuW7l9OcXITzOW4CRCrmvxrEp3xIu3jtv9zPJDMux/dvmvx6Kj5hdL+pwL7hLl
	ZOOcQi0eOqsUz6oM6n1TTfkUGr7yQmM0=
X-Gm-Gg: ASbGncvqvH1Ws5LI0/dZD0c6elnUVYddn1Xz+JVNaDR+OgSDz/mUUdpk0yi+sFH8wH/
	InRDfHy9vpwnzEGdDUdjWRVkzYLrlRQZse6LdUV11eTNOIGsFdLqU1alSf7qhVlHA5iiX4/1Dem
	m6F6QMoa49rJ/4MivmWIbPcn3j3jRK+BdT+cv6ZJ8IR9bg6tEVR0QFXA==
X-Google-Smtp-Source: AGHT+IFOX9nUaEucogkv2J60E9CkJRnX32TsnlPTkSh72ZrnbZscB8Gscg+pr8hkzpmF3XxzjNTf6VzLZQinxC9y0dQ=
X-Received: by 2002:a05:6e02:1d9a:b0:3df:3208:968e with SMTP id
 e9e14a558f8ab-3e05c9a1bf5mr21243585ab.14.1751530978447; Thu, 03 Jul 2025
 01:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com> <af16a28a-18b9-4d45-9ab9-1b150988b7d5@redhat.com>
In-Reply-To: <af16a28a-18b9-4d45-9ab9-1b150988b7d5@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 16:22:21 +0800
X-Gm-Features: Ac12FXx8fJa7A23R4bCrfAzQ98cFKSZOKsCciT-4f3Mxyv3nTDRt8MKJMIm6Hb4
Message-ID: <CAL+tcoDa13Gzdzv7NOSVwWDZV86w7NgJniT1jMqe2FCw1psHFg@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 4:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/27/25 1:01 PM, Jason Xing wrote:
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
> >
> > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing=
@gmail.com/
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> LGTM, waiting a little more for an explicit an ack from XDP maintainers.

Thanks. No problem.

>
> Side note: it could be useful to extend the xdp selftest to trigger the
> new code path.

Roger that, sir. I will do it after this gets merged, maybe later this
month, still studying for various tests in recent days :)

Thanks,
Jason

