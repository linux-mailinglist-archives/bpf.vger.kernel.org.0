Return-Path: <bpf+bounces-61817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE8AEDC46
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38F83B724F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3D289815;
	Mon, 30 Jun 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP09IVTy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2A28507C;
	Mon, 30 Jun 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285260; cv=none; b=cyf9issfAYys/BZ1rF9jmz0ZX5t1zPD0C+Frpz0r42wjVJI5XcMRso4/vufpPQbC/727sgExKbN+jc7/c63a1NucvzfVHQtMI1vzebBRL8qu3GXHaIFGQ1K4xW0LS1kbHmnrVWpIvjllDBSmsSZNvLC3543TghFqlmhDbnhaa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285260; c=relaxed/simple;
	bh=oWfahthu4lRpAHyz1PGLTYWZrIT3duCBXXwMTHQ60uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F56m+m6hhdJg5oMR6vd26o23L0ZGvwpANH/+XICxKO623Cym/uWcUfkcbwtfLTxIeBUWcKEpsaloBXxsVnIBT8vt+m9gtcV0CKyEasLf6Y09Xg0E0ghmWMdgJgbrkLZsdybQRdTlBMVv47N4UXBa/w1tFvzcZrEcFx1+oQjdKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP09IVTy; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df3ce3ec91so8939845ab.2;
        Mon, 30 Jun 2025 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751285258; x=1751890058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1Y2kNk6/RyOPvlbTloRZmjiHTq/yIMIP7qqPNBr/CI=;
        b=aP09IVTyjdToF69mjIycMrPrHzHHiCPzDRY7s4808KcrhGY/xBpVkZzPqkoP0Ms0Cc
         EEKH3lul5WkrhWZMTMwVsIvsQeKigaDms7hpFjRm0gg3z3liZmO2z37ooVbzHm7SsJH8
         fR6jLdWOv5V0Xol6aepkXS5rw0mGYbzkjMrGdAF+Wc79hfjmcN3Er0DCX23JZ8tw3saQ
         t9qMMBMl6ZPTBSr4s5mMFzSyrO00BX2Af0AVA9GhCZ0L6rM3gIxf5rCJRh+XyxoGg9vF
         E+/riEwPpbqEAaUU4ffovxfQMXKAAizeBZmwTGkvmr1Z6AG3AZ59Zaw8iiE2R+NaV54v
         LogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285258; x=1751890058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1Y2kNk6/RyOPvlbTloRZmjiHTq/yIMIP7qqPNBr/CI=;
        b=okwTaFzzJjPLUAL7wNV7fU5huc/PpmunBX5k6DB4yQ53pM/1FkeAvrl339oqyAOyIe
         mhpEqRQ7QQHSLilu2vNSdO2blXeQdk7IDWMmMQMN7nLIw4o880fAAhY1d+VtSWt9tHWq
         wNjgxrrAEbjeKYogLTkYxo6edzCtdbB/0KG5EBGiYp9lIVxX+w3AtsvzHqAb9z9Rigmc
         n11rfz6qJSRhB406Vq89QAEo8B6FrpwkskJcL3122zs2gHIhmgXXgesBNYpQ9QXSXG9W
         +VrjlA6E9moc1lGBhd2PMAb6DmvvBoF9xvYAOwRhxK+LpQJVpB7SZWwBf7QXoV/0us30
         YeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9HkajT+g3K50S+R6ZoP7lgcpi3gAFsjssb0yEugK34ftj2VQ3viL3dPgnBr4h8I7iU38=@vger.kernel.org, AJvYcCWeIT7e2t9VJqW9UgkCM8k/7Zz6nbpaudhXAezXUZ3WODTnj0pIp2+uyuFSg5gCO6F6x0aJ2CxO@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdIEb1ZX/jBmgCIXb9no+ieHlyFY9YHRdpjN7pEw8xrJqOIp7
	Q4jaaPmpyKS2BvoKFZXw59gOXKYEC2EoGxx212UzHX+m4WuNkxzYGoadU8MCwvY227ag6VTOpnm
	C+DNv9xexTrFDQ4gyZEQbJ8Cqf+HgKi4=
X-Gm-Gg: ASbGncvgZSoTqN+63fHOZksIdE8PydlUETe7R1P5qNN3VDARwS8RE2ek1SVXtvuoOIO
	hfU9QjsJHHkm1LXh1c4NC0sfFgLhKSdD++QaW+AFsJqhyBc/W1ry0Ntxq1HUk+6SRkNMFOzEpuf
	g190rr2lGpmdLgibLvKXujMH8p28NZlwtonqulGKIH7KU=
X-Google-Smtp-Source: AGHT+IGo1bduu0rN+6+rUcnWoL+iSQRZqOf8iwIuZlNSZg1uctReSkP1kGqsNmdk8DmdAtQ7AGPn7Z4EOIZN3u9j0B8=
X-Received: by 2002:a05:6e02:194e:b0:3dd:f948:8539 with SMTP id
 e9e14a558f8ab-3df4ab2aedamr134911405ab.2.1751285257631; Mon, 30 Jun 2025
 05:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
 <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com> <aGJ5DDtFAZ/IsE0B@boxer>
In-Reply-To: <aGJ5DDtFAZ/IsE0B@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Jun 2025 20:07:01 +0800
X-Gm-Features: Ac12FXz5UilEKYhitYo1b6v4WHc0yw1WRA7jUU_gZXgph0gCGjmUDavA2nf0IEU
Message-ID: <CAL+tcoB+_5p4V3WgMmpGnrjj-+axTDkhKoYS=1cMKxTRs68JAA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:47=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 29, 2025 at 06:43:05PM +0800, Jason Xing wrote:
> > On Sun, Jun 29, 2025 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Fri, Jun 27, 2025 at 7:01=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch provides a setsockopt method to let applications leverag=
e to
> > > > adjust how many descs to be handled at most in one send syscall. It
> > > > mitigates the situation where the default value (32) that is too sm=
all
> > > > leads to higher frequency of triggering send syscall.
> > > >
> > > > Considering the prosperity/complexity the applications have, there =
is no
> > > > absolutely ideal suggestion fitting all cases. So keep 32 as its de=
fault
> > > > value like before.
> > > >
> > > > The patch does the following things:
> > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > > - Set tx_budget_spent to 32 by default in the initialization phase =
as a
> > > >   per-socket granular control. 32 is also the min value for
> > > >   tx_budget_spent.
> > > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > > >
> > > > The idea behind this comes out of real workloads in production. We =
use a
> > > > user-level stack with xsk support to accelerate sending packets and
> > > > minimize triggering syscalls. When the packets are aggregated, it's=
 not
> > > > hard to hit the upper bound (namely, 32). The moment user-space sta=
ck
> > > > fetches the -EAGAIN error number passed from sendto(), it will loop=
 to try
> > > > again until all the expected descs from tx ring are sent out to the=
 driver.
> > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency=
 of
> > > > sendto() and higher throughput/PPS.
> > > >
> > > > Here is what I did in production, along with some numbers as follow=
s:
> > > > For one application I saw lately, I suggested using 128 as max_tx_b=
udget
> > > > because I saw two limitations without changing any default configur=
ation:
> > > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > > this was I counted how many descs are transmitted to the driver at =
one
> > > > time of sendto() based on [1] patch and then I calculated the
> > > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > > suitable value because 1) it covers most of the cases, 2) a higher
> > > > number would not bring evident results. After twisting the paramete=
rs,
> > > > a stable improvement of around 4% for both PPS and throughput and l=
ess
> > > > resources consumption were found to be observed by strace -c -p xxx=
:
> > > > 1) %time was decreased by 7.8%
> > > > 2) error counter was decreased from 18367 to 572
> > >
> > > More interesting numbers are arriving here as I run some benchmarks
> > > from xdp-project/bpf-examples/AF_XDP-example/ in my VM.
> > >
> > > Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256"
>
> do you have a patch against xdpsock that does setsockopt you're
> introducing here?

Sure, I added the following code in the apply_setsockopt():
if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_XDP, 9, &a, sizeof(a)) < 0)
...

>
> -B -b 256 was for enabling busy polling and giving it 256 budget, which i=
s
> not what you wanted to achieve.

I checked that I can use getsockopt to get the budget value the same
as what I use setsockopt().

Sorry, I don't know what you meant here. Could you say more about it?

Thanks,
Jason

>
> > >
> > > Using the default configure 32 as the max budget iteration:
> > >  sock0@eth0:1 txonly xdp-drv
> > >                    pps            pkts           1.01
> > > rx                 0              0
> > > tx                 48,574         49,152
> > >
> > > Enlarging the value to 256:
> > >  sock0@eth0:1 txonly xdp-drv
> > >                    pps            pkts           1.00
> > > rx                 0              0
> > > tx                 148,277        148,736
> > >
> > > Enlarging the value to 512:
> > >  sock0@eth0:1 txonly xdp-drv
> > >                    pps            pkts           1.00
> > > rx                 0              0
> > > tx                 226,306        227,072
> > >
> > > The performance of pps goes up by 365% (with max budget set as 512)
> > > which is an incredible number :)
> >
> > Weird thing. I purchased another VM and didn't manage to see such a
> > huge improvement.... Good luck is that I own that good machine which
> > is still reproducible and I'm still digging in it. So please ignore
> > this noise for now :|
> >
> > Thanks,
> > Jason

