Return-Path: <bpf+bounces-13484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4307DA1EA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBCB2825AF
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA93B7A1;
	Fri, 27 Oct 2023 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7/+Z/c1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A038BA8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 20:46:51 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010A1AA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:46:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507b96095abso3579339e87.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698439607; x=1699044407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaYDIOylQCR1didr8+5RkC44kCMu+ll/Ceunqx8nUzA=;
        b=O7/+Z/c1BsGIXtWACIHNtMKmUwDYMoqXxPPEcauFicqm2XRRhIRDFjCJ+iXekJFxyf
         3teL/86Wk7kaF34kWR4TSJKOQQ7oFI7ywt2Uzz7cm/hp0yi2Z1WvLfKSn0uqOFgZhNJQ
         5ns92DIDqSvsk8kVe6V4bIY2oieoY6VEKYb97kESA06RIRJweix9Rqk/DseTDBDMVCsR
         gqUuhbwmUYp59yuAQbnXTxkqqetGlWzmf4cQewaZ9o5he2O0/Jsw+87J5ua884514Rtw
         Zt2W/irPjxD1OV5wnWsXvgpXZ9i6y+vQgLBTHOhDswS59rGQKm/RSf6qg+2R5I5lKFqf
         mDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698439607; x=1699044407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaYDIOylQCR1didr8+5RkC44kCMu+ll/Ceunqx8nUzA=;
        b=rE/YFOAKhaANd9QA33qVRmLDq7OXmbdw412DMBoMawi3CGNxcpnkiay7iKIhq/WniY
         qzK17XqBqyLzDWwIOiWOcwOvCJYD1qSrTxQXQmhnTWCMgWYafLzTDbRhSustPKN9JMD8
         xzBV9Ywimj0PR8K7ooPWcHZ7WhNeuoXuXu29RTzPefurvxR2RgUb+qghoEiYTf/fLlpx
         PPccxNYrHkNTj6rDCUM3KcsekCioebtxxvwX9/hoelnyPynebOwVzCA0y+7Cp11kq4P+
         410RiJpwx/z92CBxMRTeZ+G2c5aJsVPq8xp5bTUggU+oWPiTGIgMao9DAPd3gcB4VFcx
         hU2A==
X-Gm-Message-State: AOJu0Yz9B90zv6sni2O2tUyzlWMw6hCujtHHLBsjlFik4NGd2UR/h2p+
	066LH7QpAKIH409o9qPbIJuIsHtCnzsaHudCmt8=
X-Google-Smtp-Source: AGHT+IGSIHy9lDRCxwTQwN5T7bLFpnA0ImI9GiYGtUlyfoViEprFCJCbAJcUqh77g6/IvI3A01Gtc3M93LdJulPMtXM=
X-Received: by 2002:a05:6512:368f:b0:506:8d2a:5654 with SMTP id
 d15-20020a056512368f00b005068d2a5654mr2463437lfs.28.1698439607119; Fri, 27
 Oct 2023 13:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTZxoDJJbX9mrQ9w@u94a> <ZTtOEFqpFIiYoqht@u94a>
In-Reply-To: <ZTtOEFqpFIiYoqht@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Oct 2023 13:46:35 -0700
Message-ID: <CAEf4BzYqu-Ojqc0jjiJdTfmV4F2HwU45-OqBYQ0NcKk9D7hxaA@mail.gmail.com>
Subject: Re: Unifying signed and unsigned min/max tracking
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:44=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Mon, Oct 23, 2023 at 09:14:08PM +0800, Shung-Hsi Yu wrote:
> > Hi,
> >
> > CC those who had worked on bound tracking before for feedbacks, as well=
 as
> > Dave who works on PREVAIL (verifier used on Windows) and Paul who've wr=
itten
> > about PREVAIL[1], for whether there's existing knowledge on this topic.
> >
> > Here goes a long one...
> >
> > ---
> >
> > While looking at Andrii's patches that improves bounds logic (specifica=
lly
> > patches [2][3]). I realize we may be able to unify umin/umax/smin/smax =
into
> > just two u64. Not sure if this has already been discussed off-list or i=
s
> > being worked upon, but I can't find anything regarding this by searchin=
g
> > within the BPF mailing list.
> >
> > For simplicity sake I'll focus on unsigned bounds for now. What we have
> > right in the Linux Kernel now is essentially
> >
> >     struct bounds {
> >       u64 umin;
> >       u64 umax;
> >     }
> >
> > We can visualize the above as a number line, using asterisk to denote t=
he
> > values between umin and umax.
> >
> >                  u64
> >     |----------********************--|
> >
> > Say if we have umin =3D A, and umax =3D B (where B > 2^63). Representin=
g the
> > magnitude of umin and umax visually would look like this
> >
> >     <----------> A
> >     |----------********************--|
> >     <-----------------------------> B (larger than 2^63)
> >
> > Now if we go through a BPF_ADD operation and adds 2^(64 - 1) =3D 2^63,
> > currently the verifier will detect that this addition overflows, and th=
us
> > reset umin and umax to 0 and U64_MAX, respectively; blowing away existi=
ng
> > knowledge.
> >
> >     |********************************|
> >
> > Had we used u65 (1-bit more than u64) and tracks the bound with u65_min=
 and
> > u65_max, the verifier would have captured the bound just fine. (This id=
ea
> > comes from the special case mentioned in Andrii's patch[3])
> >
> >                                     u65
> >     <---------------> 2^63
> >                     <----------> A
> >     <--------------------------> u65_min =3D A + 2^63
> >     |--------------------------********************------------------|
> >     <---------------------------------------------> u65_max =3D B + 2^6=
3
> >
> > Continue on this thought further, let's attempting to map this back to =
u64
> > number lines (using two of them to fit everything in u65 range), it wou=
ld
> > look like
> >
> >                                     u65
> >     |--------------------------********************------------------|
> >                                vvvvvvvvvvvvvvvvvvvv
> >     |--------------------------******|*************------------------|
> >                    u64                              u64
> >
> > And would seems that we'd need two sets of u64 bounds to preserve our
> > knowledge.
> >
> >     |--------------------------******| u64 bound #1
> >     |**************------------------| u64 bound #2
> >
> > Or just _one_ set of u64 bound if we somehow are able to track the unio=
n of
> > bound #1 and bound #2 at the same time
> >
> >     |--------------------------******| u64 bound #1
> >   U |**************------------------| u64 bound #2
> >      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
> >     |**************------------******|
> >
> > However, this bound crosses the point between U64_MAX and 0, which is n=
ot
> > semantically possible to represent with the umin/umax approach. It just
> > makes no sense.
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > The way around this is that we can slightly change how we track the bou=
nds,
> > and instead use
> >
> >     struct bounds {
> >       u64 base; /* base =3D umin */
> >         /* Maybe there's a better name other than "size" */
> >       u64 size; /* size =3D umax - umin */
> >     }
> >
> > Using this base + size approach, previous old bound would have looked l=
ike
> >
> >     <----------> base =3D A
> >     |----------********************--|
> >                <------------------> size =3D B - A
> >
> > Looking at the bounds this way means we can now capture the union of bo=
und
> > #1 and bound #2 above. Here it is again for reference
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > Because registers are u64-sized, they wraps, and if we extend the u64 n=
umber
> > line, it would look like this due to wrapping
> >
> >                    u64                         same u64 wrapped
> >     |**************------------******|*************------------******|
> >
> > Which can be capture with the base + size semantic
> >
> >     <--------------------------> base =3D (u64) A + 2^63
> >     |**************------------******|*************------------******|
> >                                <------------------> size =3D B - A,
> >                                                     doesn't change afte=
r add
> >
> > Or looking it with just a single u64 number line again
> >
> >     <--------------------------> base =3D (u64) A + 2^63
> >     |**************------------******|
> >     <-------------> base + size =3D (u64) (B + 2^32)
> >
> > This would mean that umin and umax is no longer readily available, we n=
ow
> > have to detect whether base + size wraps to determin whether umin =3D 0=
 or
> > base (and similar for umax). But the verifier already have the code to =
do
> > that in the existing scalar_min_max_add(), so it can be done by reusing
> > existing code.
> >
> > ---
> >
> > Side tracking slightly, a benefit of this base + size approach is that
> > scalar_min_max_add() can be made even simpler:
> >
> >     scalar_min_max_add(struct bpf_reg_state *dst_reg,
> >                              struct bpf_reg_state *src_reg)
> >     {
> >       /* This looks too simplistic to have worked */
> >       dst_reg.base =3D dst_reg.base + src_reg.base;
> >       dst_reg.size =3D dst_reg.size + src_reg.size;
> >     }
> >
> > Say we now have another unsigned bound where umin =3D C and umax =3D D
> >
> >     <--------------------> C
> >     |--------------------*********---|
> >     <----------------------------> D
> >
> > If we want to track the bounds after adding two registers on with umin =
=3D A &
> > umax =3D B, the other with umin =3D C and umin =3D D
> >
> >     <----------> A
> >     |----------********************--|
> >     <-----------------------------> B
> >                      +
> >     <--------------------> C
> >     |--------------------*********---|
> >     <----------------------------> D
> >
> > The results falls into the following u65 range
> >
> >     |--------------------*********---|-------------------------------|
> >   + |----------********************--|-------------------------------|
> >
> >     |------------------------------**|**************************-----|
> >
> > This result can be tracked with base + size approach just fine. Where t=
he
> > base and size are as follow
> >
> >     <------------------------------> base =3D A + C
> >     |------------------------------**|**************************-----|
> >                                    <--------------------------->
> >                                       size =3D (B - A) + (D - C)
> >
> > ---
> >
> > Now back to the topic of unification of signed and unsigned range. Usin=
g the
> > union of bound #1 and bound #2 again as an example (size =3D B - A, and
> > base =3D (u64) A + 2^63)
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > And look at it's wrapped number line form again
> >
> >                    u64                         same u64 wrapped
> >     <--------------------------> base
> >     |**************------------******|*************------------******|
> >                                <------------------> size
> >
> > Now add in the s64 range and align both u64 range and s64 at 0, we can =
see
> > what previously was a bound that umin/umax cannot track is simply a val=
id
> > smin/smax bound (idea drawn from patch [2]).
> >
> >                                      0
> >     |**************------------******|*************------------******|
> >                     |----------********************--|
> >                                     s64
> >
> > The question now is be what is the "signed" base so we proceed to calcu=
late
> > the smin/smax. Note that base starts at 0, so for s64 the line that
> > represents base doesn't start from the left-most location.
> > (OTOH size stays the same, so we know it already)
> >
> >                                     s64
> >                                      0
> >                                <-----> signed base =3D ?
> >                     |----------********************--|
> >                                <------------------> size is the same
> >
> > If we put u64 range back into the picture again, we can see that the "s=
igned
> > base" was, in fact, just base casted into s64, so there's really no nee=
d for
> > a "signed" base at all
> >
> >     <--------------------------> base
> >     |**************------------******|
> >                                      0
> >                                <-----> signed base =3D (s64) base
> >                     |----------********************--|
> >
> > Which shows base + size approach capture signed and unsigned bounds at =
the
> > same time. Or at least its the best attempt I can make to show it.
> >
> > One way to look at this is that base + size is just a generalization of
> > umin/umax, taking advantage of the fact that the similar underlying har=
dware
> > is used both for the execution of BPF program and bound tracking.
> >
> > I wonder whether this is already being done elsewhere, e.g. by PREVAIL =
or
> > some of static code analyzer, and I can just borrow the code from there
> > (where license permits).
>
> As per [1], PREVAIL uses the zone domain[2][3] to track values along with
> relationships between values, where as the Linux Kernel tracks values wit=
h
> min/max (i.e. interval domain) and tnum. In short, PREVAIL does not use t=
his
> trick, but I guess it probably don't need to since it's already using
> something that considered to be more advanced.

tnum is actually critical for checking memory alignment (i.e.,
checking that low 2-3 bits are always zero), which range tracking
can't do. So I suspect PREVAIL doesn't validate those conditions,
while kernel's verifier does.

>
> Also, found some research papers on this topic referring to it as Wrapped
> Intervals[4] or Modular Interval Domain[5]. The former has an MIT-license=
d
> C++ implementation[6] available as reference.
>
> 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-w=
indows-ebpf-verifier.html
> 2: https://en.wikipedia.org/wiki/Difference_bound_matrix#Zone
> 3: https://github.com/vbpf/ebpf-verifier/blob/6d5ad53/src/crab/split_dbm.=
hpp
> 4: https://dl.acm.org/doi/abs/10.1145/2651360

this one (judging by the name of the paper) looks exactly like what we
are trying to do here. I'll give it a read some time later. Meanwhile
I posted full patch set with range logic ([0]), feel free to take a
look as well.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D797178&=
state=3D*

> 5: https://hal.science/hal-00748094/document
> 6: https://github.com/caballa/wrapped-intervals/blob/master/lib/RangeAnal=
ysis/WrappedRange.cpp
>
> > The glaring questions left to address are:
> > 1. Lots of talk with no code at all:
> >      Will try to work on this early November and send some result as RF=
C. In
> >      the meantime if someone is willing to give it a try I'll do my bes=
t to
> >      help.
> >
> > 2. Whether the same trick applied to scalar_min_max_add() can be applie=
d to
> >    other arithmetic operations such as BPF_MUL or BPF_DIV:
> >      Maybe not, but we should be able to keep on using most of the exis=
ting
> >      bound inferring logic we have scalar_min_max_{mul,div}() since bas=
e +
> >      size can be viewed as a generalization of umin/umax/smin/smax.
> >
> > 3. (Assuming this base + size approach works) how to integrate it into =
our
> >    existing codebase:
> >      I think we may need to refactor out code that touches
> >      umin/umax/smin/smax and provide set-operation API where possible. =
(i.e.
> >      like tnum's APIs)
> >
> > 4. Whether the verifier loss to ability to track certain range that com=
es
> >    out of mixed u64 and s64 BPF operations, and this loss cause some BP=
F
> >    program that passes the verfier to now be rejected.
> >
> > 5. Probably more that I haven't think of, feel free to add or comments =
:)
> >
> >
> > Shung-Hsi
> >
> > 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the=
-windows-ebpf-verifier.html
> > 2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.org=
/
> > 3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.org=
/

