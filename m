Return-Path: <bpf+bounces-18257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BD817FBF
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 03:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C651C21859
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527EE4409;
	Tue, 19 Dec 2023 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El09p1FV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122B1FAA;
	Tue, 19 Dec 2023 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-5cd81e76164so32906847b3.1;
        Mon, 18 Dec 2023 18:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702952830; x=1703557630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erJKS/m1X8dm4/V3Zk8cOC8PZKWrQRl/DZCo258aRjA=;
        b=El09p1FV51PFGVG71EWiDBWbg1iJTTIy3hvWBWCboV+OJGXN+p0wsJN9M7ZYfCMbb9
         nr+mtegaikZ1Mbtsi3FabVCczqejK5++xzsmF1qQ8tBIaORKRO45zrUZPVPLcIDWWFoa
         vnD297Dd9H9qL1AijUAG5hSi0vCFFXvU3ZMLxoCGkvmMPiC1y6hp8cK7nviUh/zfyu2x
         P9wxUyCjeLfsqqNlys8BLpTpWIX8UW9Yn3aLjyA71fhB5y94O3eXcUUJ6vmENZAS8YB0
         5uFjdzEV/5zD0dSDMIQWHQCBx9mk8WMDTjX//B/KiWzDDViPHWHXKtQw9zzi0EQRTbFn
         64EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702952830; x=1703557630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erJKS/m1X8dm4/V3Zk8cOC8PZKWrQRl/DZCo258aRjA=;
        b=Ju416KyJICtjAC1tVtbSR0P7dKi7IEh4wCxQCPzP8xO13yP/v+olQW03koc/Hc+jq2
         M8eFLQy2SoGRFPSujKhraJgVZiczLNAAwBcLzvRDAt2aybZ73eolxKyi5O+vOsoHwNsZ
         q74IQoQV1EeMfXQgocQXTwE58Di2WdzxK1q41SyHFMuE1/V4iy6YPomMx7WLrLKLsarW
         bXfkMscRhoL85KGU6f86VPzu6f2Tu4aAHayFIqUnSCh3VqCwE6OFFGvhKJgF95VhhKxD
         ph8mIkBuaYFRSlH8s6QD0S76rgCdKvUw74m4igo5vywKMnjO3W4A5E54l65x8Aj/Haci
         SVxQ==
X-Gm-Message-State: AOJu0YwYdSRC0kxisD0psUADWxLtDu9v7s6AdQg1hVLqxDDN8+13gN5n
	YPM+TAWK7iUS2k4pg/JjlQBvFL+GX570z69a7Tk=
X-Google-Smtp-Source: AGHT+IFQmDp6aEpFsklCdSECri/B4VZf0fdJbIfRzr715RJuMJX1/Mu8ymf+WdDeUwJbmCssO4lacc9aMFcWGlmBiEk=
X-Received: by 2002:a81:88c5:0:b0:5d7:1940:dd93 with SMTP id
 y188-20020a8188c5000000b005d71940dd93mr11931768ywf.105.1702952830373; Mon, 18
 Dec 2023 18:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
 <20231217131716.830290-4-menglong8.dong@gmail.com> <CAEf4BzZc3edO35FJwxgRscE4n5_qkpwQOJXjUAYjjfWwLkcANg@mail.gmail.com>
In-Reply-To: <CAEf4BzZc3edO35FJwxgRscE4n5_qkpwQOJXjUAYjjfWwLkcANg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 19 Dec 2023 10:26:59 +0800
Message-ID: <CADxym3bSbxccDSnS1E2ywRMibCOtTb4Mmf0nMMB-YXtO5PonXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase to
 verifier_bounds.c for JMP_NE
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add testcase for the logic that the verifier tracks the BPF_JNE for reg=
s.
> > The assembly function "reg_not_equal()" that we add is exactly converte=
d
> > from the following case:
> >
> >   u32 a =3D bpf_get_prandom_u32();
> >   u64 b =3D 0;
> >
> >   a %=3D 8;
> >   /* the "a > 0" here will be optimized to "a !=3D 0" */
> >   if (a > 0) {
> >     /* now the range of a should be [1, 7] */
> >     bpf_skb_store_bytes(skb, 0, &b, a, 0);
> >   }
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> >  .../selftests/bpf/progs/verifier_bounds.c     | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
>
> LGTM, but please add a comment that we rely on bpf_skb_store_byte's
> 4th argument being defined as ARG_CONST_SIZE, so zero is not allowed.
> And that r4 =3D=3D 0 check is providing us this exclusion of zero from
> initial [0, 7] range.
>

Okay, sounds great! BTW, should I add such a comment to the
commit log or to the assembly function?

>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tool=
s/testing/selftests/bpf/progs/verifier_bounds.c
> > index ec430b71730b..3fe2ce2b3f21 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1075,4 +1075,31 @@ l0_%=3D:   r0 =3D 0;                            =
             \
> >         : __clobber_all);
> >  }
> >
> > +SEC("tc")
> > +__description("bounds check with JMP_NE for reg edge")
> > +__success __retval(0)
> > +__naked void reg_not_equal(void)
>
> technically, you are testing `r4 =3D=3D 0` :) so maybe call the test
> reg_equal_const or something. And then add similar test where you
> actually have `r4 !=3D 0`, called req_no_equal_const?
>

Yeah, that makes sense. I'll add such a test in the next version.

Thanks!
Menglong Dong

> > +{
> > +       asm volatile ("                                 \
> > +       r6 =3D r1;                                        \
> > +       r1 =3D 0;                                         \
> > +       *(u64*)(r10 - 8) =3D r1;                          \
> > +       call %[bpf_get_prandom_u32];                    \
> > +       r4 =3D r0;                                        \
> > +       r4 &=3D 7;                                        \
> > +       if r4 =3D=3D 0 goto l0_%=3D;                          \
> > +       r1 =3D r6;                                        \
> > +       r2 =3D 0;                                         \
> > +       r3 =3D r10;                                       \
> > +       r3 +=3D -8;                                       \
> > +       r5 =3D 0;                                         \
> > +       call %[bpf_skb_store_bytes];                    \
> > +l0_%=3D: r0 =3D 0;                                         \
> > +       exit;                                           \
> > +"      :
> > +       : __imm(bpf_get_prandom_u32),
> > +         __imm(bpf_skb_store_bytes)
> > +       : __clobber_all);
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
> > --
> > 2.39.2
> >

