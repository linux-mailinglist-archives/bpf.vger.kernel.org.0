Return-Path: <bpf+bounces-16915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC0807816
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6011C20F24
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA946540;
	Wed,  6 Dec 2023 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu2YbFBb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18110FF
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:47:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso161677e87.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888475; x=1702493275; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=guwTk9rKVtP7sDgXpQKKBOuTiuqBrYQzrQCvQSKSG8Y=;
        b=Iu2YbFBbVLH6SRiCjOoYWvVX7Ul79EABgffdX703QWSitjFU98MfOEX0GWl7XjJpqB
         0Mz7j0bgxBPknYtnjp0JfaTrZceqQFiRq74cR1SUJ0NagD2ZdzuEzgsLVGUftrjbdiwm
         zfikIW5S7alj3DyPMkcq+ut80p8Tn9WC2TYV/TCAAf2ZKDnvtVK1e/rRZmfFiMRYs45r
         VJ5z9xMz/BDg/+WFbPokOeg5NjyFemsLiKNylT7btgeEv/ynrdoCUpW6om94H4KJFP4Q
         Yago+j7GJP9ZYRhwMWQ9I2wO4QkcNzL9GtVONv15PzfLJMvmUe8IERv+G7mBnxkjQiv6
         KM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888475; x=1702493275;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guwTk9rKVtP7sDgXpQKKBOuTiuqBrYQzrQCvQSKSG8Y=;
        b=iCuel7+ZBHpzVu+dTOq9+kU3tVv3xzKgdIV9hX0gCv0rloN6wJ48MN8YaExPjSroTW
         duaoo2ddx7K4DudZZPgJarj+saJP4fHCzvPGC+rcMWzusfUjWGgWLQp7rDyAGPU7Cs71
         1ktqBaW7r8Gtc6gZaSI+jXn+YmGp/DR+vO0/vLx+yPRoTwBEC/VHLtkIh39fLe4pOtyC
         2DaGKjojY2n9qeJpC08x+uOr3nj8k8GMRulObTz6LP17zoYV/9GjWt18HWUxqnvfHEsS
         g0ctF+fdVo75dnik+rLtvLI4PL3evaVFxJnw9yNPaGa6P8uc2IofUBCQyo7JK2sonfAO
         5IwQ==
X-Gm-Message-State: AOJu0YwrGO6rH4SYXmRXd+NZbt03A1H0p9/5a+E6FgoO0VS2Dif69gZk
	VL5rMpoFwX9s7QqO0ttKoIw=
X-Google-Smtp-Source: AGHT+IGDzn4llH/9XHZLjjm+cSphfT+i1E9vLf9fvhmJ236UDLp1y2knRWRDEH1CH8T2xZfbrY+7Aw==
X-Received: by 2002:ac2:43ac:0:b0:50b:ee85:efd4 with SMTP id t12-20020ac243ac000000b0050bee85efd4mr947304lfl.25.1701888475456;
        Wed, 06 Dec 2023 10:47:55 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dx14-20020a0565122c0e00b0050c10295228sm357765lfb.44.2023.12.06.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:47:54 -0800 (PST)
Message-ID: <7d2be3d598047b2515b89ee33ff6ad9153f95992.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/13] bpf: support 'arg:xxx'
 btf_decl_tag-based hints for global subprog args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Wed, 06 Dec 2023 20:47:53 +0200
In-Reply-To: <CAEf4BzaVqN726rWmuC+-ZzSmWg+9yxTZR=JgWMPWfgD=cKzv+Q@mail.gmail.com>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-11-andrii@kernel.org>
	 <fc790a1fd70a4159c6d73b953088ec2beb97f48b.camel@gmail.com>
	 <CAEf4BzaVqN726rWmuC+-ZzSmWg+9yxTZR=JgWMPWfgD=cKzv+Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 10:15 -0800, Andrii Nakryiko wrote:
[...]
> > > +             tag =3D btf_find_decl_tag_value(btf, fn_t, i, "arg:");
> >=20
> > Nit: this does a linear scan over all BTF type ids for each
> >      function parameter, which is kind of ugly.
>=20
> I know, so it's a good thing I added caching, right? :) I'm just
> reusing existing code, though. It also errors out on having two
> matching tags with the same prefix, which for now is good enough, but
> we'll probably have to lift this restriction.
>=20
> As for linear search. This might be fine, BPF program's BTF is
> generally much smaller than vmlinux's BTF, and it's not clear if
> building hashmap-based lookup for tags is worthwhile. For now it works
> well enough, so there is little motivation to get this improved.

Yeah, probably not that big of a deal.
Still ugly though :)

> > > +             /* 'arg:<tag>' decl_tag takes precedence over derivatio=
n of
> > > +              * register type from BTF type itself
> > > +              */
> > > +             if (tag) {
> > > +                     /* disallow arg tags in static subprogs */
> > > +                     if (!is_global) {
> > > +                             bpf_log(log, "arg#%d type tag is not su=
pported in static functions\n", i);
> > > +                             return -EOPNOTSUPP;
> > > +                     }
> >=20
> > Nit: this would be annoying if someone would add/remove 'static' a few
> >      times while developing BPF program. Are there safety reasons to
> >      forbid this?
>=20
> I'm just trying to not introduce unintended interactions between arg
> tags and static functions, which basically can freely ignore BTF at
> verification time, as they don't need BTF info for correctness. If in
> the future we add tags support for static functions, I'd like to have
> a clean slate instead of worrying for backwards compat.

Ok, might be changed if people would complain.

[...]

> > > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_META)=
 {
> > > +                     if (reg->type !=3D PTR_TO_PACKET_META) {
> > > +                             bpf_log(log, "arg#%d expected pkt_meta,=
 but got %s\n",
> > > +                                     i, reg_type_str(env, reg->type)=
);
> > > +                             return -EINVAL;
> > > +                     }
> > > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_DATA)=
 {
> > > +                     if (reg->type !=3D PTR_TO_PACKET) {
> >=20
> > I think it is necessary to check that 'reg->umax_value =3D=3D 0'.
> > check_packet_access() uses reg->umax_value to bump
> > env->prog->aux->max_pkt_offset. When body of a global function is
> > verified it starts with 'umax_value =3D=3D 0'.
> > Might be annoying from usability POV, however.
>=20
> I'm not even sure what we are using this max_pkt_offset for?

Idk, but last time I asked if it could be removed Alexei was very
unhappy, referring to hardware offload. Probably to nfp_bpf_offload_check_m=
tu()
in drivers/net/ethernet/netronome/nfp/bpf/offload.c .

> I see that verifier is maintaining it, but I don't see it being
> checked... Seems like when we have tail calls we even set it to
> MAX_PACKET_OFF unconditionally...

That won't guarantee that offset is always in bounds [0, MAX_PACKET_OFF].

This property is enforced by find_good_pkt_pointers(), so that packet
pointers where umax_value might exceed MAX_PACKET_OFF won't gain
'range' (and if there is no range it is forbidden to read/write
using this pointer).

> This PKT_xxx business is a very unfamiliar territory for me, so I hope
> Martin and/or Alexei can chime in and suggest how to make global funcs
> safe to work with packet pointers without hurting usability.

The way I understand it there are only few aspects:
- max_pkt_offset is maintained;
- access through packet pointer is allowed only if it has 'range';
- 'range' is gained by comparing pkt + X with pkt_end;
- 'range' is not gained if access might exceed MAX_PACKET_OFF;
- whenever some pointer gains range all pointers with same id gain it
  (see find_good_pkt_pointers() for this and two points above);
- when a non constant is added to a packet pointer it gets new id
  (see adjust_ptr_min_max_vals()).

I think that all.

