Return-Path: <bpf+bounces-16132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA17FD00F
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBFB28286F
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA81118F;
	Wed, 29 Nov 2023 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVK9rdio"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15A10D4;
	Tue, 28 Nov 2023 23:44:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db4050e68f3so6119111276.0;
        Tue, 28 Nov 2023 23:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701243866; x=1701848666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6jmJHglGtU9cahHc2lD5bEKUuDPk2ce4UOMIxy6Cx0=;
        b=NVK9rdiodBEppSPEzQo4PNHQRKdCxf0p0S6Wwu5S0vTTv2Paf3TnsEPtf4yuRYZN4+
         rdcqee7oHBGHkc1+55oAiezdVN6ALswXn2QPFgfHks+L0RNJd6AkXiu8bcwA724WyeaF
         RPVwwUMIuF+S3YkAiC1dEqRz7PD66oCZO4jucwbQzIoOOsbOuIYSdx0Sq/KCbjo06qq9
         vJr1thiYvg3Cze0kcmSp5/KRwpALNhxYyBO7rdJYgVoZfvr2eVbN0EB5fikcHj9wTxCy
         vvqAPUhEJSI07ZsTgAchHksgeZ3VYYs5iRhQjY7je9fBvTlhv6gEw4HQ8yXuzdg9SClp
         xuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243866; x=1701848666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6jmJHglGtU9cahHc2lD5bEKUuDPk2ce4UOMIxy6Cx0=;
        b=PDfo3oznqpqdVSlVKcZC8v14FQqrHiSVRkej/LXKB2KwRNT/ORCxXbDhmLkyHtQsPU
         gh4rnsToqBYCrj/gO8WtpBW9vq7Z4pPWXtMNQoe5zNh/ZeLEgvusRSHZcpfylgdCQ90+
         TwGUJfF5johv+N8uuLQE2kXraxsUwaNV+bjFHLraKe/vXbAE7tCl3aGFqXyXf8r1hnAo
         vv2ZkHRByO2UHv/2yjlLuJ/lVzUiNVmht0U4CzGzuAzr3E2ZxBneNgcbyTClMr2U7Yua
         LWBSNHub7/ofHK9gjesoaSDE8hruJA0nhkZbsElFJWKOSe9i9HSHcHxCE1AUrDH/6tNv
         U6Ag==
X-Gm-Message-State: AOJu0YzVs8akxdZTR9rJzfnJ/yUAKWy7nHotlf5wQrQpDbrh+UOS8hFa
	eGi7dAqr6ASE53BpYU/Db1/Tds8LIhsaPWaelw==
X-Google-Smtp-Source: AGHT+IGEdkY9AX1U4mzuSN/8p8Kin7s1Kf2ri0yEG5PP1I0kgFz+yDwFjeIIyg2BZe9rklTw+7hRFQZ+onTtyMATufk=
X-Received: by 2002:a25:f90a:0:b0:da3:b603:8314 with SMTP id
 q10-20020a25f90a000000b00da3b6038314mr15032890ybe.0.1701243866047; Tue, 28
 Nov 2023 23:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsaecr+VjmfOHzaMbiei5G3WMDjvjp4kZVE79Bn8ib1-Rg@mail.gmail.com>
 <CAEf4BzYVRwpP6TbXdJeFwMot80FodexyOk2_Y9H2tsJC-3FBUA@mail.gmail.com>
In-Reply-To: <CAEf4BzYVRwpP6TbXdJeFwMot80FodexyOk2_Y9H2tsJC-3FBUA@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 29 Nov 2023 08:44:14 +0100
Message-ID: <CACkBjsae4bwde6133GrUh-2EcdEhKjb9zj5baRyUxyxdhqQUfQ@mail.gmail.com>
Subject: Re: [Bug Report] bpf: reg invariant voilation after JSLE
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:43=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 21, 2023 at 7:08=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wro=
te:
> >
> > Hi,
> >
> > The following program (reduced) breaks reg invariant:
> >
> > C Repro: https://pastebin.com/raw/SRQJYx91
> >
> > -------- Verifier Log --------
> > func#0 @0
> > 0: R1=3Dctx() R10=3Dfp0
> > 0: (b7) r0 =3D -2                       ; R0_w=3D-2
> > 1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
> > 2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3D=
scalar(id=3D1)
> > 3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
> > R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D0x7ffffffffffffff=
e,umin=3Dumin32=3D0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=
=3D-2,umax32=3D0xfffffffe,var_off=3D(0xfffffffe;
> > 0xffffffff00000000))
>
> this part looks suspicious, I'll take a look a bit later
>
> > 4: (65) if r8 s> 0xd goto pc+3        ;
> > R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D13,umin=3Dumin32=
=3D0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=3D-2,umax32=3D0x=
fffffffe,var_off=3D(0xfffffffe;
> > 0xffffffff00000000))
> > 5: (b7) r4 =3D 2                        ; R4_w=3D2
> > 6: (dd) if r8 s<=3D r4 goto pc+1
> > REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> > u64=3D[0xfffffffe, 0xd] s64=3D[0xfffffffe, 0xd] u32=3D[0xfffffffe, 0xd]
> > s32=3D[0x3, 0xfffffffe] var_off=3D(0xfffffffe, 0x0)
> > 6: R4_w=3D2 R8_w=3D0xfffffffe
> > 7: (cc) w8 s>>=3D w0                    ; R0=3D0xfffffffe R8=3Dscalar()
> > 8: (77) r0 >>=3D 32                     ; R0_w=3D0
> > 9: (57) r0 &=3D 1                       ; R0_w=3D0
> > 10: (95) exit
> >
> > from 6 to 8: safe
> >
> > from 4 to 8: safe
> >
> > from 3 to 8: safe
> > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
> > 1 peak_states 1 mark_read 1
> >
> >
> > Besides, the verifier enforces the return value of some prog types to
> > be zero, the bug may lead to programs with arbitrary values loaded.
>
> Generally speaking, if the verifier reports "REG INVARIANTS VIOLATION"
> warning above, it doesn't necessarily mean that verifier has some bug.
> We do know that in some conditions verifier doesn't detect conditions
> that *will not* be taken, and in such cases we might get reg
> invariants violation. But in such case verifier will revert to
> conservative unknown scalar state, which is correct, even if
> potentially unnecessarily pessimistic.
>

Yes, I'm aware of that, which is why I only selected two suspicious cases
to report. Also, this is true after the check (5f99f312bd3be: bpf: add
register bounds sanity checks and sanitization), but these cases may
cause some issues in the previous releases. Your recent improvement in
return value check also helps.

I will see what I can do, maybe add more checks by using both tnum and
ranges information in is_scalar_branch_taken().

Thanks!

