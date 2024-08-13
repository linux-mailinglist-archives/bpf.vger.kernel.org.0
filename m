Return-Path: <bpf+bounces-37011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8597950272
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F2E1F22AAD
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B18C345;
	Tue, 13 Aug 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="QteaAE7m"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B118B499
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544852; cv=none; b=HRlumS24waa10dQdGH/+T5B5VxuQvdJFjH3xhENx3T8OwLEJW4AG5cDLQBRlVBFxHEjM1czeyVfPNayWVGPes28m+2eSeDo7E/kHaodzZAqbOoASPdPYpI4e6djdz0LtyW4t8bgH02Fo0QMzfAHNSBNOfvgXEfuNsDI24UEUFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544852; c=relaxed/simple;
	bh=yuKba18SMhrcztqRrAHzlzAgPzwyoY14Xajb4miTgnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4+Mbxu49LkekF3HCzr76s03Vj06qUVr1AaXx39mtkRNnDud7oReQwn+z9TCGm3sld+g+Trndo7VOg0azgEfS9Joj09KuNAH/qywAs7QoNmRFNq3J957bA9KyntNgn218F84/7fQLxvrOUPKyS2i6AswAyBC3Hx45cO+HxkVr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=QteaAE7m; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1723544849; x=1724149649; i=linux@jordanrome.com;
	bh=82X3/AtePClJyBxlzJZDPlOZEP5mUvS0J61t83VWx3o=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QteaAE7mowcXxFEas80srozhB9FJPwYkHy5p/JDpitx4+CjTgnNwDS8nQyIHoAxt
	 rvu0PVnS2mt0lmHmcXGVs8Gw1mIZCqFQIOsJ4L5sqYft0a6a3eFUmJuU0CXmtFRt2
	 JUhmq/uiZKQrKJE6hzi88NbqLkuMcA5bv8dudSeZVZMJLOHR3EnYDAxhpn668RkvG
	 NFTjf1j+Omqjro8EKSJvYTH+g+cYKoYbau1x1ZZrCMBTw5Of7p2rrRfpwqxVSTxNQ
	 Ew+B8D3Qw+3sdbDKbK9iNfgPSF5dfsgqBJBHYV/EsLth8YLxZhKV5AnqrFM8HxF4j
	 k76YHNsOYSd7QBjtoA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f181.google.com ([209.85.166.181]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MV5f0-1snCR513gs-00OpB2 for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 12:27:29
 +0200
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b3e12754eso18452845ab.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 03:27:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy6umw02SC2WlyIHBXsKlSY7UoC1dVSISSXowrW98O2/PUdQvRl
	yYqrldn89Q8U+ZH2j7kh3o74fOU1taVjCo9yawRmYvwDUyZC4gqI+e1C4jeioXOsWkLfHoiY8ga
	9E8Ic9NGtysv5OCVFsbtpBIExrn4=
X-Google-Smtp-Source: AGHT+IHoJCNf4XEvEnBG9c4aLPCg4LRK4VIi0EEIskV8ZM2eKLJwVOdoSeHYQKuSVWpnzWu5jwqJm4E9WDIq6Kr9WYY=
X-Received: by 2002:a05:6e02:12ca:b0:39b:3980:3288 with SMTP id
 e9e14a558f8ab-39c477b6307mr35845575ab.1.1723544848815; Tue, 13 Aug 2024
 03:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com> <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
In-Reply-To: <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Tue, 13 Aug 2024 06:27:17 -0400
X-Gmail-Original-Message-ID: <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
Message-ID: <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X5jpSn+YylRpQQotJ/tlmle1gDUphOFHutUlhamj8jq+aH0QAtP
 92WECuXG9OkUyxoZOGHQB6n3c5ganKeJE4+/0JEPlcokVY52xrYUH+jwIFip6NO2TSbbAbm
 ohx2XRkx24zVRWt9QRTz0G/LVschSIPMZ/S6h4BKzdFeG7isiz/zc0paeJm6drfsdL1YYKL
 PKYGqO3RpEesNEKd/K7Mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e6i76aHQKWY=;Rz6kKazfPJEfIINfWAl9oWvNV4o
 zxY17heMKsPUugajg34+wHENrptvO/0q1zKz7hAkBtjM0Ui2G+pgKocd3WymhNHTr9Bo2hqRC
 FwE0HsTpmxwvdBi5+fDrmRBfBVLhRPkkl1pnGPojGpNYSL3cufUrih2DnRKT8qBTpjN7zQnHm
 iV0YqWzRAl62KSFI/rETs+8oeO4AKJlV9rnxe7QkHgf65lrJ4+C4CkW6qYxd56ghEoWePF/Jf
 UJilfKX/c+B3KBci8tjqmIt0zK6MLXhYAwLzTpeSaKNElTz4527LHBNABUNeOby9qB8dNyI5a
 nyVY274OHkCVQit6ok9xwNmYyxsVgRLqsg9nrAuy56uGDKVo98G8M/nE47lu7CIeSSRXRKM0L
 dIz0ztj+LlTcsyxHr4PVx4ahH7dweWBzFvERm1HIpkMZWWTVoC11ksVLVYMPCobL7AFLKkABc
 ZXDkyEmQy+M+P2gQ4c9LRmhebEJyIF9emvUkU8ikeRMr3tX9DVLbdhWbn+HStC8hSTX8rqAvD
 NfJ5T9sjm4oWi8lH3nNaHembWEPsMD0PTH8fSnTjq4ya2G1WfF5ZXeMfTtMZy1eKsuc9BNwo5
 /R4S4TqJeCQsdqcn5/MJsgdOtrygG2IkIEfE0o1kEDG4/ACHShRih8q6GwVG1MyWKfy7qF7DK
 navcm9SVNym1+ya7Sq1NCF4n/zmu+wiLNCHoiRFB7nTqYhZ5T0s7D+Uz+rCzuAD5tcwh7MxRx
 2a+Y5g3DtxpcKcr0mKDKbj/taTwU8duuw==

On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > This adds a kfunc wrapper around strncpy_from_user,
> > which can be called from sleepable BPF programs.
> >
> > This matches the non-sleepable 'bpf_probe_read_user_str'
> > helper.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index d02ae323996b..e87d5df658cb 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bp=
f_iter_bits *it)
> >         bpf_mem_free(&bpf_global_ma, kit->bits);
> >  }
> >
> > +/**
> > + * bpf_copy_from_user_str() - Copy a string from an unsafe user addres=
s
> > + * @dst:             Destination address, in kernel space.  This buffe=
r must be at
> > + *                   least @dst__szk bytes long.
> > + * @dst__szk:        Maximum number of bytes to copy, including the tr=
ailing NUL.
> > + * @unsafe_ptr__ign: Source address, in user space.
> > + *
> > + * Copies a NUL-terminated string from userspace to BPF space. If user=
 string is
> > + * too long this will still ensure zero termination in the dst buffer =
unless
> > + * buffer size is 0.
> > + */
> > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const =
void __user *unsafe_ptr__ign)
> > +{
> > +       int ret;
> > +       int count;
> > +
> > +       if (unlikely(!dst__szk))
> > +               return 0;
> > +
> > +       count =3D dst__szk - 1;
> > +       if (unlikely(!count)) {
> > +               ((char *)dst)[0] =3D '\0';
> > +               return 1;
> > +       }
> > +
> > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > +       if (ret >=3D 0) {
> > +               if (ret =3D=3D count)
> > +                       ((char *)dst)[ret] =3D '\0';
> > +               ret++;
> > +       }
> > +
> > +       return ret;
> > +}
>
> The above will not pad the buffer and it will create instability
> when the target buffer is a part of the map key. Consider:
>
> struct map_key {
>    char str[100];
> };
> struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __type(key, struct map_key);
> } hash SEC(".maps");
>
> struct map_key key;
> bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
>
> The verifier will think that all of the 'key' is initialized,
> but for short strings the key will have garbage.
>
> bpf_probe_read_kernel_str() has the same issue as above, but
> let's fix it here first and update read_kernel_str() later.
>
> pw-bot: cr

You're saying we should always do a memset using `dst__szk` on success
of copying the string?

