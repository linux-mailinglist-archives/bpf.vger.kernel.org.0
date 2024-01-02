Return-Path: <bpf+bounces-18817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCBF8224EB
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B80B21C34
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A2171D9;
	Tue,  2 Jan 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkheL8n5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D747171CD
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so1150966366b.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 14:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704235520; x=1704840320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuCmZVPgS7t87k1uSvmSVHnzibSA2ruAj3pzF4cvg8A=;
        b=PkheL8n5Xdr3/wdiIxjE2n9qsmVTAlSv1qAyFdeCzfV+je9OB0wjY3L229J1VKR65b
         TrM7wSbzWD0jt62feeVImEot4Y47zFc2obx25tl2C7GLvd1yYZbzqIvEaX+kqfges1V7
         n8YPDSKh81L3xzpoQhBVCIOE9OxNuOASIGQ638n42EtyfIiXZ0fO0kKtIgFjHpnEB8fx
         0FSvv6pZNwyIh23bWPNJteq1rglAfUFr1Er88vr37R/K42uayLbgO71E8W0I2oE8RuJy
         6jC9+3HPrlAVIkjECzvSw9qIBsy+UOlOuN9/3jtIkQBbnDUXSkff3ckwbmKY8qcdfj/c
         xf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704235520; x=1704840320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuCmZVPgS7t87k1uSvmSVHnzibSA2ruAj3pzF4cvg8A=;
        b=RgNeoQP9mgloLTAAR59Q1genQbukziE/QkO11SSwtMMw5nGm4qIddSyg7AdwPoZYPa
         A3ehtbmgjRcvJ6Ehhmyn0h7ooxIgF/fZSINMwW1icxsNiC7+L+Ma+Xs1dV1gGhOOWXWg
         eUWn6fThL8MuhKSg1GD8ay4rPN+m8SxjB5Z9/W6h/YNLphxdVktRpInaz0BRnWQ4dPwP
         2Do26JsXLG56PI9vb1Fw4oH+s4gD5Fo7Aa8KgH/BM+TZSVjfh9xSrAPXUWDRFbSDtO7o
         o4eorzBQMoIAQDcYMJkMsjA58xPnyifFUxVb82rAFrTU+wGMc4ksK6xjx7in0BoKHdP3
         1/ag==
X-Gm-Message-State: AOJu0YwUtiU4TG7bvpdjwpWoc5+H/ML0Ua68CiJ0/uKP9Pq51aBZX0Dl
	DBhl9namFHWjnJzO5rzKPeFUZzAFEG8BMx/sQ9gKKt82HPFH3w==
X-Google-Smtp-Source: AGHT+IEZZXjRfcLcTx/mjHNMpn2J48kPWqWfjQh/YPiaoxrLYHMYYflET1SWxuptI4BPE5lV8o20iQuJEpgyeTqf5wA=
X-Received: by 2002:a17:906:d932:b0:a00:185a:a12b with SMTP id
 rn18-20020a170906d93200b00a00185aa12bmr3695666ejb.34.1704235520412; Tue, 02
 Jan 2024 14:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com>
In-Reply-To: <CAEf4BzbowzKU+8tZTSnxPTG-x-2ypT-EshZxS+G+c3DeLtsA0w@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 2 Jan 2024 14:45:09 -0800
Message-ID: <CAHo-Oox+=KLhtdgwv7MFx7Yn9TYAy86_Z-b5Hw_BQ=BnLGrbGw@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 1:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 29, 2023 at 5:31=E2=80=AFPM Maciej =C5=BBenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > I have a relatively complex program that fails to load on 6.5.6 with a
> >
> > if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> >
>
> How realistic is such code in practice? Is there a situation in which
> it's critical to ensure that the packet has exactly X bytes in [data,
> data_end) range? Even in that case we can have data in frags, though,
> right? So I'm just wondering if we are discussing some rather
> theoretical situation?

So, as I mentioned I hit this while debugging some other complex code,
so the example 98 isn't a particularly good value
(when I actually hit this I think I was trying to match some ping packets).

However, elsewhere in the same program I need to match and reply to
IPv6 NS packets
(for an IPv6 address the kernel doesn't own, to workaround a pair of
kernel bugs / missing features in ipv6 neigh proxy).

In practice the NS I receive and need to handle are always:
  14 ethernet + 40 ipv6 + 8 icmp6 + 16 target + 8 byte link address
option =3D 86 bytes long
(and if they're not, then my current code can't parse them anyway)
so it's natural to do something like:

handle_ns_with_laddr(struct __sk_buff *skb) {
  if (skb->data + 86 !=3D skb->data_end) return;
  struct ethernet_ipv6_ns *pkt =3D data;
  if (pkt->ether.h_proto !=3D htons(ETH_P_IPV6)) return;
  if (pkt->ip6.nexthdr !=3D IPPROTO_ICMPV6) return;
  ...etc...
}

Yeah, there's lots of caveats in the above (lack of pull, etc), but it
is enough to handle the case I need handled...

Obviously I could rewrite the above as:
  if (skb->data + 86 > skb->data_end) return;
  if (skb->data + 86 < skb->data_end) return;

though I guess a too smart compiler could optimize that back down to =3D=3D=
 ...

> > check, that loads fine if I change the above !=3D to (a you would think
> > weaker) > check.
> >
> > It's not important, hit this while debugging, and I don't know if the
> > cause is the verifier treating !=3D differently than > or the compiler
> > optimizing !=3D somehow... but my gut feeling is on the former: some
> > verifier logic special cases > without doing something similar for the
> > stronger !=3D comparison.
> >
> > ...
> > 453: (85) call bpf_trace_printk#6     ; R0_w=3Dscalar()
> > ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> > 454: (bf) r1 =3D r6                     ; R1_w=3Dpkt(off=3D0,r=3D42,imm=
=3D0)
> > R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> > 455: (07) r1 +=3D 98                    ; R1_w=3Dpkt(off=3D98,r=3D42,im=
m=3D0)
> > ; if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> > 456: (5d) if r1 !=3D r9 goto pc-23      ; R1_w=3Dpkt(off=3D98,r=3D42,im=
m=3D0)
> > R9=3Dpkt_end(off=3D0,imm=3D0)
> > *** IMHO here r=3D42 should be bumped to 98 ***
> > 457: (bf) r3 =3D r6                     ; R3_w=3Dpkt(off=3D0,r=3D42,imm=
=3D0)
> > R6=3Dpkt(off=3D0,r=3D42,imm=3D0)
> > 458: (07) r3 +=3D 34                    ; R3_w=3Dpkt(off=3D34,r=3D42,im=
m=3D0)
> > ; uint64_t cs =3D bpf_csum_diff(NULL, 0, data + 14 + 20, 98 - 14 - 20, =
0xFFFF);
> > 459: (b7) r1 =3D 0                      ; R1_w=3D0
> > 460: (b7) r2 =3D 0                      ; R2_w=3D0
> > 461: (b7) r4 =3D 64                     ; R4_w=3D64
> > 462: (b7) r5 =3D 65535                  ; R5_w=3D65535
> > 463: (85) call bpf_csum_diff#28
> > invalid access to packet, off=3D34 size=3D64, R3(id=3D0,off=3D34,r=3D42=
)
> > R3 offset is outside of the packet
> >
> > Side note: bpf_csum_diff() is super non user-friendly, but that's for
> > another thread...
> >
> > Happy New Year,
> > Maciej
> >

