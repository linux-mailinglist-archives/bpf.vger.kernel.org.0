Return-Path: <bpf+bounces-37033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD9950684
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4236D1F21572
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180019AD56;
	Tue, 13 Aug 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="y8aXgevK"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AE2557F
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555857; cv=none; b=PvgOt7ybUZZ5iX/QYMSYPvcQybXrTkxy7FsjGIV57peiFF6XI87FMjT+xDZAGzHxId1RoxbPze6SXov1FQy+W+i152X9Zx2FrzYNXWWaOGyU3nudF9KvN96tgLgC3x1VZl60gdiIlIervOuYh4NbNeN4kkqsDgOZUWpV70KP8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555857; c=relaxed/simple;
	bh=IHqj3NE3Nt2JxelJyaQsW88FDx9rynVKZlYaPbFWfHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8t+9D5NDgXUgWt1iVk07gD8/saISh/sij/Q7pQnIECas/XlCWd8P+XFtN5b6pbWvV/+Z+REu0F+WyowZnIpiR7d9plvDI9qVeDPslDXlvY42ZkS70457KGnuwraGPlwJj9TGEYh2t7GtZARY4IeN0fXca25ZJXKmIhuw6zNPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=y8aXgevK; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723555854; x=1724160654; i=linux@jordanrome.com;
	bh=XSQWOOA7hELeeRc+Poz2a3fZABNqCLl+jpNNWyx39bs=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=y8aXgevKbDWvZhu3LXA98eQWBDVtBsHx/GOP0bZo212S4qGK7ltGKNfkZJDjPXsy
	 roGrY+8AWdTOmy3Hh94POp9pFHJmC/VEmPxQh5okj56nqzJwljfX7nuTw37oEsTGo
	 sX/0+/7t4lHIpYzCxziyeAL4agaqmPd+0obbOr/7aat2KJZAm/lGrJjPApsL36sg/
	 BZOyt1HckAANC44acoHnOFrpNYjn+3TtoHsSbAObnWFs7NkI+WZX069RPc0yprzqR
	 AEIxkCInaKuDv7e/W2G1x7wIOMkmcfseCx/4nBB/o6A3t1V7LsfKj0fe2585mZsRC
	 DRZJ3q7vZsYDzH3y6Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f179.google.com ([209.85.166.179]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MehbC-1soovG1hFI-00IGFQ for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:30:54
 +0200
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b3f65b387so23131155ab.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 06:30:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+z14PkS/uVol/k4vcVqCRhFzCaXTF6m4VAeFS80x4Lmo+IDRJ
	npBp4bkWWElicNpLYS/oXdiHkAJ79YeqU/hUgreGMR/LlrKBD8uk/WntSIY2hOIXZOte4/76M7Z
	U+uW+YQ/bW5osGO2ix0/6G33sZ1E=
X-Google-Smtp-Source: AGHT+IGa1EiKMC+fHJ2zQz/7X2CnwjrNn6+4WpAJPi9dg6OXP4EjKh1AXYD4LwXSGKyG1x/ktEixo8QrIMQERrOpehk=
X-Received: by 2002:a05:6e02:164f:b0:39a:14f7:1c1c with SMTP id
 e9e14a558f8ab-39c478d02c8mr42878885ab.25.1723555853967; Tue, 13 Aug 2024
 06:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com>
 <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com> <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
In-Reply-To: <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Tue, 13 Aug 2024 09:30:42 -0400
X-Gmail-Original-Message-ID: <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com>
Message-ID: <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uKb302jWr087NDHIOWpBLU99jCg+cqvSkFCdM5nNvZnsEpEvdtl
 xXP458HO9X765MYbcwhVpyDdwN30gOVlvNyC0gAWIknUcp2qrUgt+1TI5rMQeBMekBblDLu
 cB6mhSA3M+XIXgvKgDNeHyNqouLTGC6MKacUJ6Cw4vuAfp2UkvTJnitR5lDO2weV7KBo4Fp
 3wy11IHOazzWr8TXaIibA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ImMfSOuRk90=;7nef545Ri4FaYcTuN+lE3iSMIvd
 M1NDKYscrvgbTYCH0nsUnOFt7kU56pBXH5JNwySDh7F1kkBfNl808z9uLQ8FTa9k9toG/sMap
 4HTaotxOEFwmWLxm/GOa1+JQnbNabd6Dr8Z+itQeZ1boMfm3R3aKA5w5Vq3XC2G7/p2afQFaa
 214OpnSIhmtLuOnt8Nbt0ZoFrT/GbjcJX8EPMdbmRCUZ+8l+awAxC2BOHqbzFNf0Q227Hn5yo
 TNNQZGtRNdkVlLGfDbo5GfOnHJ7xd99XmyfRgHc55bj3ViGFkzOh7hOT6spcmeGZU27OI8CaG
 XZNn9AQP+di+kUzFGkdLq3IbAzAyFp63X4EnORXJbj88ufQdboSLBMsLRfF3CXkgiMy8DzDBv
 IV7gpaqJUR6j9Wt6V09zLAq715fzOKzX70RW56JGu2xzJ0HcflzVPm6Xu09P1ENXeQ1/MEVKR
 Jx9ynqS+vk1rOdMxRCALWACDM4Gl9WzZ3if0G2Bmn+4F0J8Adfft6k7l91wRiOBRBuGGFNG7C
 gFkltnwcieR4dibPKWg56ecUD5urF3GQ8SXPcMO3olWcnrKJOIMLfQog6DN3tpo44B5yRxNxI
 Nzx3Q8UKosSbOHnj4lj8xtJSF/PD0nZs28XmYNijjohN5Kpncahl3elwfIBhn8DONOxKCE4Nc
 lq36yWztC+DiHwRbx4/SaaFoaSSz3dkN6yXb5V1p1liq5cLHpjwG7mgbW+MGtEHnlv8xdtXYK
 vgViijL+kT31tAeP8FLINBebgd6CGrx+g==

On Tue, Aug 13, 2024 at 6:27=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > This adds a kfunc wrapper around strncpy_from_user,
> > > which can be called from sleepable BPF programs.
> > >
> > > This matches the non-sleepable 'bpf_probe_read_user_str'
> > > helper.
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index d02ae323996b..e87d5df658cb 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct =
bpf_iter_bits *it)
> > >         bpf_mem_free(&bpf_global_ma, kit->bits);
> > >  }
> > >
> > > +/**
> > > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addr=
ess
> > > + * @dst:             Destination address, in kernel space.  This buf=
fer must be at
> > > + *                   least @dst__szk bytes long.
> > > + * @dst__szk:        Maximum number of bytes to copy, including the =
trailing NUL.
> > > + * @unsafe_ptr__ign: Source address, in user space.
> > > + *
> > > + * Copies a NUL-terminated string from userspace to BPF space. If us=
er string is
> > > + * too long this will still ensure zero termination in the dst buffe=
r unless
> > > + * buffer size is 0.
> > > + */
> > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, cons=
t void __user *unsafe_ptr__ign)
> > > +{
> > > +       int ret;
> > > +       int count;
> > > +
> > > +       if (unlikely(!dst__szk))
> > > +               return 0;
> > > +
> > > +       count =3D dst__szk - 1;
> > > +       if (unlikely(!count)) {
> > > +               ((char *)dst)[0] =3D '\0';
> > > +               return 1;
> > > +       }
> > > +
> > > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > > +       if (ret >=3D 0) {
> > > +               if (ret =3D=3D count)
> > > +                       ((char *)dst)[ret] =3D '\0';
> > > +               ret++;
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> >
> > The above will not pad the buffer and it will create instability
> > when the target buffer is a part of the map key. Consider:
> >
> > struct map_key {
> >    char str[100];
> > };
> > struct {
> >         __uint(type, BPF_MAP_TYPE_HASH);
> >         __type(key, struct map_key);
> > } hash SEC(".maps");
> >
> > struct map_key key;
> > bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
> >
> > The verifier will think that all of the 'key' is initialized,
> > but for short strings the key will have garbage.
> >
> > bpf_probe_read_kernel_str() has the same issue as above, but
> > let's fix it here first and update read_kernel_str() later.
> >
> > pw-bot: cr
>
> You're saying we should always do a memset using `dst__szk` on success
> of copying the string?

Something like this?
```
ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
  if (ret >=3D 0) {
    if (ret <=3D count)
       memset((char *)dst + ret, 0, dst__szk - ret);
    ret++;
}
```

