Return-Path: <bpf+bounces-62281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FAFAF752B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F1A1C813E9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8912E7185;
	Thu,  3 Jul 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3mcL7U9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482523AB86;
	Thu,  3 Jul 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548358; cv=none; b=FemwWXobkt3wH3PKRrSF1IENIg/1Fj9DazMXsMbreEMCupQKDAHz0rpOODUNqiFrSKPrWmvoZfB1a+E7la1qolFo2IVwdiS8NbIh2VuAeSfqcAfEOIA50iMv7PeUsd/ZCxG4OyK5E9yQ2W62lW8kC7BtYIRuupAv0bVbZlca0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548358; c=relaxed/simple;
	bh=LG9XBSu0ciGJZgz7vLJ4OrBf9LsapUiqVdmBedNFvKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FezCfIJFyhFAsQgvK2j8sFDVKVBkFHoJslowY4/Xm2r9XHBSoBdJO32XIDvxzXZHt1O6JgiVP4TPLD1zjqGSkHfQtonWpzF7Vbp6rnxg2GLX7TWgl1fdJ9LuwtDoPVZSFR6lVseDCk8/fpbxSAefBo6tuS91GfyyJPVz5GhUhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3mcL7U9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df210930f7so3613895ab.1;
        Thu, 03 Jul 2025 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548355; x=1752153155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuoUj+0h6/tTrKengxDfGebjlK0PMrwSeN40sTMEen8=;
        b=O3mcL7U9qtVOeCuMB4stsZJI9gHiwjuL3010JfLk9pAXNKSlWGZVcB3ABzzpb8nlhr
         p+JBc/lbuseYMuBCuEOFPG4TZt9FaBhgmvS7dJu88ckTCKqNYyNrbZa+ALlcZFqJHama
         M8sCKYhdvWJnNNnXGRCcLFwctsaPWKnb/Vc0S/+UESQQFsCQ24ZT2kvmzhJVoHEm+XLu
         gTbunFAXZ6PPV+dBVEV7d2SPN3HE/sLVnWun3PHeeQTmUsyIKGvqvw5fAYVhUAwiEaaL
         ZsKgECDBUrJ2OLkNsLcpF6utf/amZ8hrP0LkJPhsdQlNV2ZbDdvfEzCBG5vwikovkspZ
         /caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548355; x=1752153155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuoUj+0h6/tTrKengxDfGebjlK0PMrwSeN40sTMEen8=;
        b=GxEfxVlI2k0aLeS7VhIsgNobh7RQRT7OHRbNcXVEG9Pi5ls72KAXgwDenD6ehPpoNt
         /GYY2MNG9yMjT527k1flEPRhsbj8LQdKRHExKvi70OItGbNyjv56cUnBpw4fDwhtU2kW
         FIOmyOt0jSd1Gxb4Gl1w8g152aRxH7KU6D+LEE4KnyLg8INteiNRIsIwZdEfeXu1OAIu
         uixo/XlX1pLnFC7rSTvy0jDq98KacvQoAXJGa3MBvA7r+xOlOrxjbH4b/28sNSpYdihr
         kuZuAMrqup6rV2Ul5uWDWUQGjDxJTMBAky/prp16AXyOEG1OrM1RmZd4d52oMxi2bG33
         5TSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPQccfh98KDwe2PQnSZBa3HP526rdB+jLD0OCqC6tfCc4pxGznqmZ4uOK318wOlZ7zgJ3Zr5Du@vger.kernel.org, AJvYcCWMTXLVf0/fJiKqGyA2Z0SqY2/F6wu2dPL91dgFFciF/t9AqsboN6xvS1098sLTrDCQ+b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGv0oSrbMTfcylh5rAFLg7ecZgJfqiR/dKrNHk/kRHK7EYIpNA
	1cWkX0D7N3P7Rf1D+VEQ02DyRuLzWdSCi7mTiatDt0ETRxEC4SY+3Bv4lkQEnNbQ1A2cA7QR5GX
	5zlM9d2Cc1/+3Dx1lcXhFL/1Y+waTx0Q=
X-Gm-Gg: ASbGncsIQBOos18wuKnQMN/2gbYsaAsmHfbtVil93Va816nTQ392a/DTkvynpUlM5TT
	ayxzr66obkKUZBc8u+mhuRxxrbk1gx1blNkojrZtUUmRChZTgHg8/5aPuP18Ps6bXf+TDhgixDT
	b9g9lsdTdsLXto6gEiXCz71EaH2wdR5A94kXQ8wShQ8A==
X-Google-Smtp-Source: AGHT+IFOI6FpNIzalOqbXgrhAJIcObLcLVwZs+q5IvM5m2F+tRfHbtjuSWZc/xXYaWyTJOwesyvxzTR6QtHkmJMk28g=
X-Received: by 2002:a05:6e02:d54:b0:3e0:536d:2b72 with SMTP id
 e9e14a558f8ab-3e05dc866b0mr14080785ab.8.1751548355476; Thu, 03 Jul 2025
 06:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <af16a28a-18b9-4d45-9ab9-1b150988b7d5@redhat.com> <CAL+tcoDa13Gzdzv7NOSVwWDZV86w7NgJniT1jMqe2FCw1psHFg@mail.gmail.com>
 <aGZ3mJnFSsAxv7z6@boxer>
In-Reply-To: <aGZ3mJnFSsAxv7z6@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 21:11:59 +0800
X-Gm-Features: Ac12FXz3W63k1fTo7bN8uwnlrl2zEdGUbU37o6c7gkRkUAmwEuB-Ue1tdQqQhCI
Message-ID: <CAL+tcoDuBkd=pMR+mrUJgLpCRdh1cQcPBEH9rvnMJtXU242MHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:29=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 03, 2025 at 04:22:21PM +0800, Jason Xing wrote:
> > On Thu, Jul 3, 2025 at 4:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On 6/27/25 1:01 PM, Jason Xing wrote:
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
> > > >
> > > > [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljason=
xing@gmail.com/
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > LGTM, waiting a little more for an explicit an ack from XDP maintaine=
rs.
> >
> > Thanks. No problem.
>
> Hey! i did review. Jason sorry but I got confused that you need to sort
> out the performance results on your side, hence the silence.

Thanks for the review. My environment doesn't allow me to continue the
xdpsock experiment because of many limitations from the host side.
>
> >
> > >
> > > Side note: it could be useful to extend the xdp selftest to trigger t=
he
> > > new code path.
> >
> > Roger that, sir. I will do it after this gets merged, maybe later this
> > month, still studying for various tests in recent days :)
>
> IMHO nothing worth testing with this patch per-se, it's rather the matter
> of performance.
>
> I would like however to ask you for follow-up with patch against xdpsock
> that adds support for using this new setsockopt (once we accept this onto
> kernel).

That xdp-project in the github. I will finish it after it's done.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason

