Return-Path: <bpf+bounces-10548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB267A9A17
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53546B209EB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4617754;
	Thu, 21 Sep 2023 17:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94517744
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:31:29 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916530ED
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:28:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso148534866b.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317306; x=1695922106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrGSVM+r8onQIbS/fvQg7ZdNcdy6hV98KwyB8HQsmt0=;
        b=DAQPE7+zGDHHt3qY1KFeLykNgXybsJp675EnNBPGIKF80CNCpmsqM+H6esfABtfcfC
         xjpHjeuu7/Fq9wel0EVCQ4T4QDYQUXxQBXuHBWiSDT1+fgMRFozSP/apTvitTQdKswqV
         DouRzQBx2bLdd7vZ7a00B8IjjQndg0W1Wdhx1SoVXYPi1Pk13xxNyc9cJH/7ay83NfWX
         CF0DxTHcL0ZI7n6AnNsjz3dwOAdsjGgLz+zUNcpIqxRu1koWI+bc1drFDjNJIOt6fVPn
         wy+/yZaWXC4YpHZKh+eaYAWDasrsMTXnwd/fVHrk598b8iFE7J8I8CRC6B5Se80p+tQm
         XeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317306; x=1695922106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrGSVM+r8onQIbS/fvQg7ZdNcdy6hV98KwyB8HQsmt0=;
        b=RkIRIBQRA1TZWTbt8YH4PRlC4sgHAAQiEddESK4TnqoX+9jrEue1MfT1PqLgQ9KWn7
         1z7x4MWGrSn5+ggKfUY7Ml7GtWtcweLSqUiMOYepqO9Th7xdwHeWYUrePrx8ycrbevNN
         433QfYbRLsjCbeIqeRRawXGuSo+52ib4D/1eS/sJlvgrrxqFG9jxvVQ6gpUXuECyDHu3
         cqqH9GDpZ6klhYThl/3jpF1gUswo6XYVEKq8vBT9AlxwchMN7Eg6uROvE1oBisldddM4
         M9YZAhhJyfb+ufZo1WYi5MwMMS34Q4TNRAMrxPdEfhI6Xc7IKNrc9+RFwqPrQtS8QbbL
         V9tw==
X-Gm-Message-State: AOJu0YzHBoAkrsJbIHHI84T+GXuoMKKTcvmeQm2robzjczXQ4BotW2Xo
	t+jonDPPcMrUXrM+gV2fJ2so+/rnuR7QFq8chJc2ANhBXu4G2A==
X-Google-Smtp-Source: AGHT+IE0AP2GIy/nVTu1t8ljZ43I6QUbz1mUA3KpGT0ks5/myvz44f9Q+DPSjlMKVqTWmq/xwBnMW60hNMQBWeTpx10=
X-Received: by 2002:adf:d0cc:0:b0:317:61af:d64a with SMTP id
 z12-20020adfd0cc000000b0031761afd64amr4920408wrh.3.1695301004811; Thu, 21 Sep
 2023 05:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com> <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
In-Reply-To: <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Sep 2023 05:56:33 -0700
Message-ID: <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 4:03=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> I repeat the complete example with added instruction numbers in the
> end of the email. As of now verifier takes the following paths:
>
>   First:
>     // First path is for "drained" iterator and is not very interesting.
>     0: (b7) r8 =3D 0                        ; R8_w=3D0
>        ...
>     2: (b7) r7 =3D -16                      ; R7_w=3D-16
>        ...
>     4: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=
=3Dscalar(id=3D1)
>        ...
>     12: (85) call bpf_iter_num_next#63182
>        ; R0_w=3D0 fp-8=3Diter_num(ref_id=3D2,state=3Ddrained,depth=3D0) r=
efs=3D2
>     13: (15) if r0 =3D=3D 0x0 goto pc+8
>     22: (bf) r1 =3D r10
>        ...
>     26: (95) exit
>
>   Second:
>     // Note: at 13 a first checkpoint with "active" iterator state is rea=
ched
>     //       this checkpoint is created for R7=3D-16 w/o read mark.

Thanks for detailed example.
The analysis in my previous email was based on C code
where I assumed the asm code generated by compiler for
if (r6 !=3D 42)
would be
if (unlikely(r6 !=3D 42))
and fallthrough insn after 'if' insn would be 'r0 =3D r10'.
Now I see that asm matches if (likely(r6 !=3D 42)).
I suspect if you use that in C code you wouldn't need to
write the test in asm.
Just a thought.

>     from 12 to 13: R0_w=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D=
0) R6=3Dscalar(id=3D1)
>                    R7=3D-16 R8=3D0 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,s=
tate=3Dactive,depth=3D1)
>                    fp-16=3D00000000 refs=3D2
>     13: (15) if r0 =3D=3D 0x0 goto pc+8       ; R0_w=3Drdonly_mem(id=3D3,=
ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
>     14: (07) r6 +=3D 1                      ; R6=3Dscalar() refs=3D2
>     15: (55) if r6 !=3D 0x2a goto pc+2      ; R6=3D42 refs=3D2
>     16: (b7) r7 =3D -32                     ; R7_w=3D-32 refs=3D2
>     17: (05) goto pc-8
>     10: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0 refs=
=3D2
>     11: (07) r1 +=3D -8
>       is_iter_next (12):
>         old:
>            R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3D-16 R8_r=
=3D0 R10=3Dfp0
>            fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=
=3D00000000 refs=3D2
>         cur:
>            R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3D=
fp-8 R6=3D42 R7_w=3D-32
>            R8=3D0 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,state=3Dactive,dep=
th=3D1) fp-16=3D00000000 refs=3D2
>       > hit
>     12: safe
>     // At this point R7=3D-32 but it still lacks read or precision marks,
>     // thus states_equal() called from is_state_visited() for is_iter_nex=
t_insn()
>     // branch returns true. (I added some logging to make it clear above)

Maybe instead of brute forcing all regs to live and precise
we can add iter.depth check to stacksafe() such
that depth=3D0 !=3D depth=3D1, but
depth=3D1 =3D=3D depthN ?
(and a tweak to iter_active_depths_differ() as well)

Then in the above r7 will be 'equivalent', but fp-8 will differ,
then the state with r7=3D-32 won't be pruned
and it will address this particular example ? or not ?

Even if it does the gut feel that it won't be enough though,
but I wanted to mention this to brainstorm, since below:

> The "fix" that I have locally is not really a fix. It forces "exact"
> states comparisons for is_iter_next_insn() case:
> 1. liveness marks are ignored;
> 2. precision marks are ignored;
> 3. scalars are compared using regs_exact().

is too drastic.

> It breaks a number a number of tests, because iterator "entry" states
> are no longer equal and upper iteration bound is not tracked:
> - iters/simplest_loop

that's a clear sign that forcing 1,2,3 is a dead end.

Another idea is to add another state.branches specifically for loop body
and keep iterating the body until branches=3D=3D0.
Same concept as the verifier uses for the whole prog, but localized
to a loop to make sure we don't declare 'equivalent' state
until all paths in the loop body are explored.

