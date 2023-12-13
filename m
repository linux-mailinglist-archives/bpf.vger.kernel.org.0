Return-Path: <bpf+bounces-17737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D65181236B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B8F28289D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F479E32;
	Wed, 13 Dec 2023 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdzD45WJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAC10F0;
	Wed, 13 Dec 2023 15:40:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so9554255a12.3;
        Wed, 13 Dec 2023 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510846; x=1703115646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW8yg2nE5XYpvubYPqjC521h9OK/OsxXdk/i+77n0Io=;
        b=BdzD45WJYzsmeor1jnJ1sjTUjCMp+63Sggb6g/WT9NxQEdc1jqFbVVagrFiAbJ+O1l
         WpzyZuB01rKEdlbHlo9qNWwriioT9cpSYdibvbi/TaK6dT5nutZo7thyrjYCt9jFf4cn
         SFbN0xD8yhNo6s8WhF93HcpNm1yr3rKCCcyDY06bD+PNus78q9Cvd1oriZMJRHpMkfLj
         eZJD6uWdx5iWcXLuleryxIlDB5TZWstS2xoVbIjoWK2+IPMHavkcXJ7os/BNvw1f6ulU
         Lr0F3lDmj2kFBv6a8haumEtFsjteLS1dnGmuCq2mgXHL5ci5vZr7+ZlIQZK3xuERorfF
         O+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510846; x=1703115646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW8yg2nE5XYpvubYPqjC521h9OK/OsxXdk/i+77n0Io=;
        b=BSwFfjRI6fZzKz6URRHPFgffwemnPf+GM2HaTqafriivbjwRC2bC4EPlfPv6HEtjfO
         CIUGeArweQHEeKjKw39HJymi6PqbdVxBBJjybZXkA88HNEEN88J872gXyggFi9NH2B76
         fPVE+HxWnxeDyvuZwN+OukS0+uvN5cmC7YIxWgohKN1gg1G14UdWvwpxQFnV8ydsNwww
         +iV8Gzvjnv2K4W5zvICm56y9UfvYD8uDvqa4GRlGJB/8cokUiJNRmVbKIkRk3vz0f33B
         IUb6Ei3j5kcLBeoEuZBzTHXo0Dy3bo1xpFQKIrp/9AUxx2u9XdlmBAv3fhOzx507g8Gj
         9jDw==
X-Gm-Message-State: AOJu0YyRWFHJAoYI/KA9KKuVg8XndE6/16kiPS6SxZ//kntW1ed9Hhlt
	bgSLbTMHYjv6B7O5q/H7C1a9bWz6vgdY7g6VVkZw8BgbqNk=
X-Google-Smtp-Source: AGHT+IElLc1SIIkcpOaYUCC71XEtTs2vU5Ol+skni0PoF6L84idW5x045blq1+i0OQXB0I32nbVkEWq40mP/MQmKIOo=
X-Received: by 2002:a17:906:491b:b0:9fd:8cd9:7842 with SMTP id
 b27-20020a170906491b00b009fd8cd97842mr4307680ejq.44.1702510845980; Wed, 13
 Dec 2023 15:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com> <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
In-Reply-To: <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 15:40:34 -0800
Message-ID: <CAEf4BzbfF=aNa-jAkka6YrK6Vbisi=v7PFsEDR-RFuHtAub2Xw@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-12-13 at 11:25 +0100, Hao Sun wrote:
> [...]
>
> > I tried to convert the repro to a valid test case in inline asm, but se=
ems
> > JSET (if r0 & 0xfffffffe goto pc+3) is currently not supported in clang=
-17.
> > Will try after clang-18 is released.
> >
> > #30 is expected to be executed, see below where everything after ";" is
> > the runtime value:
> >    ...
> >    6: (36) if w8 >=3D 0x69 goto pc+1    ; w8 =3D 0xbe, always taken
> >    ...
> >   11: (45) if r0 & 0xfffffffe goto pc+3  ; r0 =3D 0x616, taken
> >   ...
> >   18: (56) if w8 !=3D 0xf goto pc+3     ; w8 not touched, taken
> >   ...
> >   23: (bf) r5 =3D r8     ; w5 =3D 0xbe
> >   24: (18) r2 =3D 0x4
> >   26: (7e) if w8 s>=3D w0 goto pc+5    ; non-taken
> >   27: (4f) r8 |=3D r8
> >   28: (0f) r8 +=3D r8
> >   29: (d6) if w5 s<=3D 0x1d goto pc+2  ; non-taken
> >   30: (18) r0 =3D 0x4      ; executed
> >
> > Since the verifier prunes at #26, #30 is dead and eliminated. So, #30
> > is executed after manually commenting out the dead code rewrite pass.
> >
> > From my understanding, I think r0 should be marked as precise when
> > first backtrack from #29, because r5 range at this point depends on w0
> > as r8 and r5 share the same id at #26.
>
> Hi Hao, Andrii,
>
> I converted program in question to a runnable test, here is a link to
> the patch adding it and disabling dead code removal:
> https://gist.github.com/eddyz87/e888ad70c947f28f94146a47e33cd378
>
> Run the test as follows:
>   ./test_progs -vvv -a verifier_and/pruning_test
>
> And inspect the retval:
>   do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>   run_subtest:FAIL:647 Unexpected retval: 1353935089 !=3D 4
>
> Note that I tried this test with two functions:
> - bpf_get_current_cgroup_id, with this function I get retval 2, not 4 :)
> - bpf_get_prandom_u32, with this function I get a random retval each time=
.
>
> What is the expectation when 'bpf_get_current_cgroup_id' is used?
> That it is some known (to us) number, but verifier treats it as unknown s=
calar?
>
> Also, I find this portion of the verification log strange:
>
>     ...
>     13: (0f) r0 +=3D r0                     ; R0_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,
>                                                         var_off=3D(0x0; 0=
x3))
>     14: (2f) r4 *=3D r4                     ; R4_w=3Dscalar()
>     15: (18) r3 =3D 0x1f00000034            ; R3_w=3D0x1f00000034
>     17: (c4) w4 s>>=3D 29                   ; R4_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,
>                                                         var_off=3D(0x0; 0=
xffffffff))
>     18: (56) if w8 !=3D 0xf goto pc+3       ; R8_w=3Dscalar(smin=3D0x8000=
00000000000f,smax=3D0x7fffffff0000000f,
>                                                         umin=3Dsmin32=3Du=
min32=3D15,umax=3D0xffffffff0000000f,
>                                                         smax32=3Dumax32=
=3D15,var_off=3D(0xf; 0xffffffff00000000))
>     19: (d7) r3 =3D bswap32 r3              ; R3_w=3Dscalar()
>     20: (18) r2 =3D 0x1c                    ; R2=3D28
>     22: (67) r4 <<=3D 2                     ; R4_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0x3fffffffc,
>                                                         smax32=3D0x7fffff=
fc,umax32=3D0xfffffffc,
>                                                         var_off=3D(0x0; 0=
x3fffffffc))
>     23: (bf) r5 =3D r8                      ; R5_w=3Dscalar(id=3D1,smin=
=3D0x800000000000000f,
>                                                         smax=3D0x7fffffff=
0000000f,
>                                                         umin=3Dsmin32=3Du=
min32=3D15,
>                                                         umax=3D0xffffffff=
0000000f,
>                                                         smax32=3Dumax32=
=3D15,
>                                                         var_off=3D(0xf; 0=
xffffffff00000000))
>                                             R8=3Dscalar(id=3D1,smin=3D0x8=
00000000000000f,
>                                                       smax=3D0x7fffffff00=
00000f,
>                                                       umin=3Dsmin32=3Dumi=
n32=3D15,
>                                                       umax=3D0xffffffff00=
00000f,
>                                                       smax32=3Dumax32=3D1=
5,
>                                                       var_off=3D(0xf; 0xf=
fffffff00000000))
>     24: (18) r2 =3D 0x4                     ; R2_w=3D4
>     26: (7e) if w8 s>=3D w0 goto pc+5
>     mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
>     mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x=
4
>     ...                   ^^^^^^^^^^
>                           ^^^^^^^^^^
> Here w8 =3D=3D 15, w0 in range [0, 2], so the jump is being predicted,
> but for some reason R0 is not among the registers that would be marked pr=
ecise.

It is, as a second step. There are two concatenated precision logs:

mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
mark_precise: frame0: regs=3Dr0 stack=3D before 24: (18) r2 =3D 0x4
mark_precise: frame0: regs=3Dr0 stack=3D before 23: (bf) r5 =3D r8
mark_precise: frame0: regs=3Dr0 stack=3D before 22: (67) r4 <<=3D 2


The issue is elsewhere, see my last email.

