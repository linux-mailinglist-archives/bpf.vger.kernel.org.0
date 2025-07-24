Return-Path: <bpf+bounces-64312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97675B11469
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC3A172F92
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 23:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564323D2A1;
	Thu, 24 Jul 2025 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlnq6NZr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729342F30;
	Thu, 24 Jul 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399129; cv=none; b=uFM4RgtjD9M5ZDdczsvNPKPaBmmE5ZMQ9slo3XhIdso31tf2gX74klsnR+GgSzbKGzjSS90tYkxnf27NRufcOAisqYRbPxiMd3h1q0e2UdGhCxcaHR9I0tVqQVgNQqIEI1RTIfyzlz/JUjt4/IgyGCNtMC1b70FDIhMLFYVNo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399129; c=relaxed/simple;
	bh=dEKAc56BHehGNaIvvH5Q0MuxTZULsqolyYCt/3SX6+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHlkC4dByJHKQFCAhdRVbf5HdV1IidtpjEa0UrnnJVKY4PA59gbFLro0HAUto3ON5jbHBBik3Gml4ovK4qHdKjYUvOwZXAtVmZ7BtZJgGF5amNN7EcgLuGJTX1RSF25tCSuc+LDQWmrGT5N/0ARn88gBlWMH6yur7rgrraU3s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wlnq6NZr; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e29788356cso5295355ab.3;
        Thu, 24 Jul 2025 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753399127; x=1754003927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEKAc56BHehGNaIvvH5Q0MuxTZULsqolyYCt/3SX6+s=;
        b=Wlnq6NZrdb28l2inmAih3BegFbs5QKrcRXI1LHRtv1mza7OYrV5NnUolWcLuA2UDTv
         +yr1V/pfhcTn0Q4DkauJhf5cXXS1N67yCAwbErnWpLkIjF0NFrNBTzO77DGKe0ocrHtK
         BRrZF43YdxlhcGs7vU6tSJ5WImzaYeBJTNqvmko9Y31+L9b+D58txpHPM/KXyJ1Pz2c+
         iMZ0QOdaD5JtsDftPB8TYItumKsOmLUMp3Q4FA5yXRqfsSix3nHZmOghlH57ml7fZu7s
         eH8coPK7717kSO1/A2aoBEyECDyEBsCdAkV+KWxB2CXGJMjdFSvGnfk3H10/LFk2y6rG
         kxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753399127; x=1754003927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEKAc56BHehGNaIvvH5Q0MuxTZULsqolyYCt/3SX6+s=;
        b=LGnpT0MdbjjWC9IyL84LVO4jOrybszGGzU0xbP6NjO3nshvyOo4fBT4ovc8yCuPYm9
         L9egBBqA9KU9TOgCdZZ2NNgG8bHnVwjZsmj0+wqo9uYO/pllSGaXDlHyq9QVUCdLB4S4
         rWg2K2g9BkuqpHuTT5XrRdmrONUhBe9FVcwHHwhpeI0O43apJCpYyqt77dGY/74Ps0EW
         Aw4Hi4AzQy/mmTeXtFxMhm8gLp/FiJgHtYq6rsQ5KU/pwtKTlNnDPBEWPbd9IoEMhMnP
         LF60IKigDNaN5mPIEdo4JXAKSAiOsoRy7u4dZlnBdEiietWQFLsBJzZhgkMssksR6RTC
         acrw==
X-Forwarded-Encrypted: i=1; AJvYcCVAIf0/BBNuuB3EfDhR0MBl722F5gQLLJO27NK36/0AAIt27EzRQDe4qM8YWXPqVye7xgc=@vger.kernel.org, AJvYcCXOSHVTZHxdhvrstHrqwKjUMMipktUZV388c0J8FDngwYs0fo6MtIR96R952bPshwlKgaE/TN8B@vger.kernel.org
X-Gm-Message-State: AOJu0YwYf43IlyhGYZ4mRqscHtBJihAWmqq1rAI1864qHKZ1myhxUlOd
	V5I8AgzeVEoMJ+xpJNwHqrVFXYEpmdt4L8zPEPcl/SMvDwK+MIromtx58jf1djq9FtR+4VhSA4a
	dWdh8tjTXPstZYtWVS67OnzIRZsW5hNk=
X-Gm-Gg: ASbGncu+9HTglBoJ8BsjKqNq7eb1cj63e1fmY606MhbcbC8GsifQJUAdtSfPHb6h8eM
	DlIq4LPhPLC1Sw3Xa8yAxriLYNSImJybqexDr2Xm3SoIL7H112Q8woCp1VJ5EP8a3j1FwkFjkh6
	NSrkVJ/KZDNXP5Np/bYhri4+OcCWjlZ3yRTpcAhmt44FNrzRrUMknKAdzCSdf8G0D3cnH+YKsvW
	euDxGw=
X-Google-Smtp-Source: AGHT+IE0Ki4xgb+U/YhxHbKgURvDFOGwE5ntgi5AIuY7AfeNBXyvCSHBjR/Xh9dRk3z7+RqsfjZZEVPXHpUj/qN1ApQ=
X-Received: by 2002:a05:6e02:156d:b0:3e2:aadb:2be8 with SMTP id
 e9e14a558f8ab-3e3355b0625mr143710355ab.15.1753399127377; Thu, 24 Jul 2025
 16:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-3-kerneljasonxing@gmail.com> <6ecfc595-04a8-42f4-b86d-fdaec793d4db@intel.com>
In-Reply-To: <6ecfc595-04a8-42f4-b86d-fdaec793d4db@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 25 Jul 2025 07:18:11 +0800
X-Gm-Features: Ac12FXxcq3Vo79vPuWCMbML6IqnEs97yfg9Pzfq8kprmxnIU1JjJvwbLPY4pIyY
Message-ID: <CAL+tcoBTejWSmv6XTpFqvgy4Qk4c39-OJm8Vqcwraa0cAST=sw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget
 in ixgbe_xmit_zc
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, Jul 25, 2025 at 4:21=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
>
>
> On 7/20/2025 2:11 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Resolve the budget underflow which leads to returning true in ixgbe_xmi=
t_zc
> > even when the budget of descs are thoroughly consumed.
> >
> > Before this patch, when the budget is decreased to zero and finishes
> > sending the last allowed desc in ixgbe_xmit_zc, it will always turn bac=
k
> > and enter into the while() statement to see if it should keep processin=
g
> > packets, but in the meantime it unexpectedly decreases the value again =
to
> > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc retu=
rns
> > true, showing 'we complete cleaning the budget'. That also means
> > 'clean_complete =3D true' in ixgbe_poll.
> >
> > The true theory behind this is if that budget number of descs are consu=
med,
> > it implies that we might have more descs to be done. So we should retur=
n
> > false in ixgbe_xmit_zc to tell napi poll to find another chance to star=
t
> > polling to handle the rest of descs. On the contrary, returning true he=
re
> > means job done and we know we finish all the possible descs this time a=
nd
> > we don't intend to start a new napi poll.
> >
> > It is apparently against our expectations. Please also see how
> > ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> > to make sure the budget can be decreased to zero at most and the underf=
low
> > never happens.
> >
> > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>
> Hi Jason,
>
> Seems like this one should be split off and go to iwl-net/net like the
> other similar ones [1]? Also, some of the updates made to the other
> series apply here as well?

The other three patches are built on top of this one. If without the
patch, the whole series will be warned because of build failure. I was
thinking we could backport this patch that will be backported to the
net branch after the whole series goes into the net-next branch.

Or you expect me to cook four patches without this one first so that
you could easily cherry pick this one then without building conflict?

>
> Thanks,
> Tony
>
> [1]
> https://lore.kernel.org/netdev/20250723142327.85187-1-kerneljasonxing@gma=
il.com/

Regarding this one, should I send a v4 version with the current patch
included? And target [iwl-net/net] explicitly as well?

I'm not sure if I follow you. Could you instruct me on how to proceed
next in detail?

Thanks,
Jason

