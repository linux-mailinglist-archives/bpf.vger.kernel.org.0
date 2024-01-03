Return-Path: <bpf+bounces-18837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975828225D1
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C63B1C22C02
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFC361;
	Wed,  3 Jan 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjIosAUy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC34A0D
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1915034144so1120940566b.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 16:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704240377; x=1704845177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgFyJIpT1pHW3CdPgSQIrLVxiOC1SZuMhLqy+b3mk4A=;
        b=cjIosAUyqfN2wzvtOm/IUYIdsjPJb4x4fpoGrhArb5bAcj1wOb4M8IfkTcpuHffmTt
         vemxfzryBTBm0eTDQDRR8/eS4ZFKQWN978aZ/pg5PjppOUWKALRQSozmcd3oyYUHod8N
         N6EE5ak1DhlT7th6ql7mp7xB5RuhFaQdjgL/418hI5xllHwKXoFQ20C2JnsGMVWhmGMV
         0NNksJtE3wX9AbDVN9C0OxvkoDqUXNrs0jwUgPM4eF1zkryJ0wQ/oZZZrorb+LdbcbkR
         4x5YTzmlmYH7U+ZHgmMho1RmcJGrKHKKXSg0y6ZfT9D+4D5W04C6R3L9x+4rLHE+Su/4
         RGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704240377; x=1704845177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgFyJIpT1pHW3CdPgSQIrLVxiOC1SZuMhLqy+b3mk4A=;
        b=txaaJ8+zWHkGUTN4KoP1GXLVL3cAMA99fKXTKwcoLqr3XqH0GvhYtEirXaIYE8RgoC
         B4afkkIlqb510D2kB+faN35krfkaJosCJF3m675y9t/ofmhJO3liU/zqQDQYdTKz8cOy
         E1wyS9CBBiLRJDRjwnNMYJxE98VQayAUK8q2lGrqhN3ia8VA0gMZoN9WfV/4uORm1tsa
         nh5HYTyABc5ldWoS0TtY5Y2qlXh2Vvfya9Z2J/6UMltA5wGDhsRhdx8Kb7msIFFDXaX0
         2rYCSJ2ArlQV353/z/TqdfsG6L7cm4ammc0ZEO2ZIh+gZmfbbdAqThauf+DdrWSvRAAt
         YifQ==
X-Gm-Message-State: AOJu0YxFnYvrskWGjM/+cALONPeWPvfu7hUGNpGOBjKIaM9JLPCmYsdZ
	kxJMJ1cupiKSlo3zjHBVvT/vj2j0w/UfH/qUDss=
X-Google-Smtp-Source: AGHT+IF8s+k5SMhb6W1+9MkvtuX9lOk1syZsF3TD0BPj1viUUayXAyLN7QQCgxzv2f01GafvfsTHzpYz/o0dr3dqkQM=
X-Received: by 2002:a17:906:c196:b0:a28:6611:966c with SMTP id
 g22-20020a170906c19600b00a286611966cmr707132ejz.77.1704240377413; Tue, 02 Jan
 2024 16:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com> <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
In-Reply-To: <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 16:06:04 -0800
Message-ID: <CAEf4BzaLyHbddd-FfCMWBjbGb0==D1a=xyi0-u0zpQHonkhfyg@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:45=E2=80=AFPM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> On Tue, Jan 2, 2024 at 1:46=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Dec 29, 2023 at 5:31=E2=80=AFPM Maciej =C5=BBenczykowski
> > <zenczykowski@gmail.com> wrote:
> > >
> > > I have a relatively complex program that fails to load on 6.5.6 with =
a
> > >
> > > if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> > >
> >
> > How realistic is such code in practice? Is there a situation in which
> > it's critical to ensure that the packet has exactly X bytes in [data,
> > data_end) range? Even in that case we can have data in frags, though,
> > right? So I'm just wondering if we are discussing some rather
> > theoretical situation?
>
> So, as I mentioned I hit this while debugging some other complex code,
> so the example 98 isn't a particularly good value
> (when I actually hit this I think I was trying to match some ping packets=
).
>
> However, elsewhere in the same program I need to match and reply to
> IPv6 NS packets
> (for an IPv6 address the kernel doesn't own, to workaround a pair of
> kernel bugs / missing features in ipv6 neigh proxy).
>
> In practice the NS I receive and need to handle are always:
>   14 ethernet + 40 ipv6 + 8 icmp6 + 16 target + 8 byte link address
> option =3D 86 bytes long
> (and if they're not, then my current code can't parse them anyway)
> so it's natural to do something like:
>
> handle_ns_with_laddr(struct __sk_buff *skb) {
>   if (skb->data + 86 !=3D skb->data_end) return;
>   struct ethernet_ipv6_ns *pkt =3D data;
>   if (pkt->ether.h_proto !=3D htons(ETH_P_IPV6)) return;
>   if (pkt->ip6.nexthdr !=3D IPPROTO_ICMPV6) return;
>   ...etc...
> }
>
> Yeah, there's lots of caveats in the above (lack of pull, etc), but it
> is enough to handle the case I need handled...

Yeah, that's what I was getting at, just using data_end as a marker
for packet length seems incorrect. But I do see the point that it's
just an unnecessary complication for users to work around.

For the fix that Eduard proposed (and checking
try_match_pkt_pointers), should we do a similar simplification as we
do for scalar register comparisons? Make sure that data_end is always
on the right by swapping, if that's not the case. And also use
corresponding rev_opcode() and flip_opcode() operations to minimize
the amount of logic and duplicated code?

And I mean not just for new JEQ/JNE cases, but let's also refactor and
simplify existing logic as well?

>
> Obviously I could rewrite the above as:
>   if (skb->data + 86 > skb->data_end) return;
>   if (skb->data + 86 < skb->data_end) return;
>
> though I guess a too smart compiler could optimize that back down to =3D=
=3D ...
>
> > > check, that loads fine if I change the above !=3D to (a you would thi=
nk
> > > weaker) > check.
> > >
> > > It's not important, hit this while debugging, and I don't know if the
> > > cause is the verifier treating !=3D differently than > or the compile=
r
> > > optimizing !=3D somehow... but my gut feeling is on the former: some
> > > verifier logic special cases > without doing something similar for th=
e
> > > stronger !=3D comparison.
> > >
> > > ...
> > > 453: (85) call bpf_trace_printk#6     ; R0_w=3Dscalar()
> > > ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> > > 454: (bf) r1 =3D r6                     ; R1_w=3Dpkt(off=3D0,r=3D42,i=
mm=3D0)
> > > R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> > > 455: (07) r1 +=3D 98                    ; R1_w=3Dpkt(off=3D98,r=3D42,=
imm=3D0)
> > > ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> > > 456: (5d) if r1 !=3D r9 goto pc-23      ; R1_w=3Dpkt(off=3D98,r=3D42,=
imm=3D0)
> > > R9=3Dpkt_end(off=3D0,imm=3D0)
> > > *** IMHO here r=3D42 should be bumped to 98 ***
> > > 457: (bf) r3 =3D r6                     ; R3_w=3Dpkt(off=3D0,r=3D42,i=
mm=3D0)
> > > R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> > > 458: (07) r3 +=3D 34                    ; R3_w=3Dpkt(off=3D34,r=3D42,=
imm=3D0)
> > > ; uint64_t cs =3D bpf_csum_diff(NULL, 0, data + 14 + 20, 98 - 14 - 20=
, 0xFFFF);
> > > 459: (b7) r1 =3D 0                      ; R1_w=3D0
> > > 460: (b7) r2 =3D 0                      ; R2_w=3D0
> > > 461: (b7) r4 =3D 64                     ; R4_w=3D64
> > > 462: (b7) r5 =3D 65535                  ; R5_w=3D65535
> > > 463: (85) call bpf_csum_diff#28
> > > invalid access to packet, off=3D34 size=3D64, R3(id=3D0,off=3D34,r=3D=
42)
> > > R3 offset is outside of the packet
> > >
> > > Side note: bpf_csum_diff() is super non user-friendly, but that's for
> > > another thread...
> > >
> > > Happy New Year,
> > > Maciej
> > >

