Return-Path: <bpf+bounces-58412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3CABA1D8
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EACC9E104E
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591F272E4B;
	Fri, 16 May 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJARW/kx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE425CC77;
	Fri, 16 May 2025 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416168; cv=none; b=hcN/O5v8ZIPAkfg6w2yI76/Woze971/rS4Zl45tZMyiLdPnnm5uBi5qSdAE874y8Akr+RC4Gyd7HRTC4FfG8Bps/mbMHyXaaCsCBrO3QnBZ8ErEQOsAjeAJyPTSx5ds+bnaAYc1tr17HrWXJ2Ms/fnsAhD+uTSSNypNKgHqoslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416168; c=relaxed/simple;
	bh=gHDnfoajrPghe0uHWBzNeNQBRVEv0TYcue3CT7aNfik=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K0kkd5B08+9yOWV1GhsT78an6VFc41vggcXjkle1S487Ittf/yZ2u1aEP9rNKGULU907Ig9lbBFIdRkBwND+a9FsXnR3B4Kab8IhfdtjX8zDiOxclViDR3KtjhTmJC9xssk9f04CfFUW2EtlN16bNaVxIbXe2pSpgHuBOY0ennM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJARW/kx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5568355ffso204946385a.0;
        Fri, 16 May 2025 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747416165; x=1748020965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rijU/iw06s1As7dK45CRJ6ZUYyr3AoRxB/Rs1KgsH2c=;
        b=NJARW/kxHAezzeVEWXZdhZTVlQ7NAXZCjbWZGoS9DvUtB2TFwXlOOUcx0dOpLym0LN
         tE2gkQkuymuWH+4tU4dhHetH/QRUgF/RAK6V9848vS64MKBb4yX73y//XrU4B/+y3Cbw
         zdJ0WWHOnnb4ScpXgWWHATk1Ex22yj6sgEgkQfok0DI+QUTi/wpAqMjsNpxAHKjLg6pS
         vfDF7BeMen5Q9cYLXkAY1DKa+TuCHBCS1/aK3ioGK6sLK25bgOSoM7RnnFQRVNawhzUf
         n8Lb0iRzzfTqp0SDUi28h/z43fDJ/CpUleAnsDMVnqJQgICeuCc4/OFU6mUi3McRG/7k
         Y1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747416165; x=1748020965;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rijU/iw06s1As7dK45CRJ6ZUYyr3AoRxB/Rs1KgsH2c=;
        b=t5GNa/iEJmT5wKlWjgspeqzv36spvkvT8F1I4qLskQndKSQbaIES3P4ScrFcX+teZD
         4Sh2B9RcBQr1p1LRtyAH22iv76nWN0DSvjpG6m8zOWnR0qKtMsKlWIAWMndNiK/n4d+/
         cCFYr1J6HJva0kXXG2w7Q4EpNxXnAi1Ql+M07Gr7G0cZGTw1mmDRhS1P1UP7RvynJhd3
         xgir3+hcSyRC0Q2jXg2AlYBjbXIyBmanF70oeXbVc7I6kMaMx6PuGA7pRdYbOEdCiaeN
         Z1FQjRhgeqFnZ+cK68ihXmlolQgn4KlajtgaoB87Z2KZz64jGuZh7jrZvwo7qxcjbatS
         53Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV2YGptP5LNs1fgZ6UQZfizVQysU9cG7RFNe3CjbyMCSY18jyL/U5jIOW/5+9LnOz8gvco=@vger.kernel.org, AJvYcCVdAn/SZ21e3g0qt6361tGvAqgqsHlNDywZlPpBMEcZvjyxEq3iDnvUwlxCGOyug3cVuTSZeAwML4S/lbSU@vger.kernel.org, AJvYcCVgafJd4HnJwNogd9bLuKbq1yoVEVmJ7GRLoqjRJvAJ00paQhCXgxn00AE7N8tpl0To/8PBgBBS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxi6X/S85/+KfEBBLwHKsBWugAAP7f7Qr6pv3cTEYYpRV7uiwj
	7q2QB30UaPgt+H4mcvbYxfgkoRuwdz86Y9D9Xsd4uUwOViDaoQbeBsbW
X-Gm-Gg: ASbGnctRoUx7uoAG8wWZP2f/uD+5tIW+qNO6Aninjxz051L6cO8InNDWF9FtXQHid/R
	dZCPMR3UDcA/paKEE4RqQaKbw7Lkpd2CB0ip4yaudhOTFo/s7L3fp4Kssqbx5WjxrwEhPJZ3SHI
	rWdHdArNKO7h8UGz++tqEpx80L40RzTTshhyDHmeZRe+K19uTRIBgFrLd3WJnaH2dbW4Ls38RxK
	g0vU3Tp/sC34v1WtQ0qQkWNRR8AxPo1L4mYcUaA9CkzQuanVGOaW+WU2XmNdJD/w5CUmSW0IsbQ
	uf6+7YcT/sbMoBDoPeMuxlMDc2Pz+BAchXg7qi0Otw9lML0u5Vst0Vl36W1WasJlbYBzVfae01z
	BYSjB8SxJvLe1wmYpC30vmzI=
X-Google-Smtp-Source: AGHT+IGgbFIs4gVRzBrRl+Z/NMLlfhcLYA4US1p+mqyo1Padg1fqO6Wvl/Kd4VdVk1OpuKSb+zZPyw==
X-Received: by 2002:a05:620a:4593:b0:7c5:3b3b:c9da with SMTP id af79cd13be357-7cd4677d5bbmr725106685a.40.1747416164763;
        Fri, 16 May 2025 10:22:44 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467bc7d1sm144103785a.1.2025.05.16.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:22:44 -0700 (PDT)
Date: Fri, 16 May 2025 13:22:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Shalimov <alex-shalimov@yandex-team.ru>
Cc: andrew@lunn.ch, 
 David Miller <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 jacob.e.keller@intel.com, 
 jasowang@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-ID: <68277463d4c43_2ba041294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <0bcc08e4-9f22-431c-97f3-c7d5784d2652@app.fastmail.com>
References: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
 <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
 <6825f65ae82b5_24bddc29422@willemb.c.googlers.com.notmuch>
 <0bcc08e4-9f22-431c-97f3-c7d5784d2652@app.fastmail.com>
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Xu wrote:
> On Thu, May 15, 2025, at 7:12 AM, Willem de Bruijn wrote:
> > Alexander Shalimov wrote:
> >> 06.05.2025, 22:32, "Willem de Bruijn" <willemdebruijn.kernel@gmail.c=
om>:
> >> > Perhaps bpftrace with a kfunc at a suitable function entry point t=
o
> >> > get access to these ring structures.
> >> =

> >> Thank you for your responses!
> >> =

> >> Initially, we implemented such monitoring using bpftrace but we were=

> >> not satisfied with the need to double-check the structure definition=
s
> >> in tun.c for each new kernel version.
> >> =

> >> We attached kprobe to the "tun_net_xmit()" function. This function
> >> gets a "struct net_device" as an argument, which is then explicitly
> >> cast to a tun_struct - "struct tun_struct *tun =3D netdev_priv(dev)"=
.
> >> However, performing such a cast within bpftrace is difficult because=

> >> tun_struct is defined in tun.c - meaning the structure definition
> >> cannot be included directly (not a header file). As a result, we wer=
e
> >> forced to add fake "struct tun_struct" and "struct tun_file"
> >> definitions, whose maintenance across kernel versions became
> >> cumbersome (see below). The same problems exists even with kfunc and=

> >> btf - we are not able to cast properly netdev to tun_struct.
> >> =

> >> That=E2=80=99s why we decided to add this functionality directly to =
the kernel.
> >
> > Let's solve this in bpftrace instead. That's no reason to rever to
> > hardcoded kernel APIs.
> >
> > It quite possibly already is. I'm no bpftrace expert. Cc:ing bpf@
> =

> Yeah, should be possible. You haven't needed to include header
> files to access type information available in BTF for a while now.
> This seems to work for me - mind giving this a try?
> =

> ```
> fentry:tun:tun_net_xmit {
>     $tun =3D (struct tun_struct *)args->dev->priv;
>     print($tun->numqueues);  // or whatever else you want
> }
> ```
> =

> fentry probes are better in general than kprobes if all you're doing
> is attaching to the entry of a function.
> =

> You could do the same with kprobes like this if you really want, though=
:
> =

> ```
> kprobe:tun:tun_net_xmit {
>     $dev =3D (struct net_device *)arg1;
>     $tun =3D (struct tun_struct *)$dev->priv;
>     print($tun->numqueues);  // or whatever else you want
> }
> ```
> =

> Although it looks like there's a bug when you omit the module name
> where bpftrace doesn't find the struct definition. I'll look into that.=


Minor: unless tun is built-in.

Thanks a lot for your response, Daniel. Good to know that we can get
this information without kernel changes. And I learned something new
:) Replicated your examples.


