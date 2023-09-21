Return-Path: <bpf+bounces-10527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F37A97E7
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0100B20E86
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68917754;
	Thu, 21 Sep 2023 17:06:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770F125A2
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:06:13 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17B36D60
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:06:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5094182a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315970; x=1695920770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGEfbCvMALy3L4HQxYyJ0Q7dIxiuNmaFrXxaW1KksK4=;
        b=IPM0+7IaMhMZWJVmGiWOoaD9nh+13zv3yNZjUhSVYqJoUYX9U21Gs6YdyFL7r+7VlI
         PNm2ZrSRvK9xOs5+1bUardUBenKhtge40ugXobN00TUAB7PcijRv9yIgCX5iItBOnoF9
         Nv7A5kaIkqzlwnsEckDvYxH0xXBOeqQCUOJGt7wGP8t9ODqi6f50OyZZy7NKFFCi1foN
         JTiDGpTGkfO/3TRcgguY7AwLSqHjZbRrm1bt4O3tdyEgSLZuFa6J8hwIHAHd1SUEjJbL
         nFYxNKYJ3xkKThmv6w93lmIdCh56GNCEJHymAYbul2BGMsd28XuN7asPUdEnxXvrFdzS
         Sfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315970; x=1695920770;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGEfbCvMALy3L4HQxYyJ0Q7dIxiuNmaFrXxaW1KksK4=;
        b=LAh1tjOVIk0dVF0AqWLJ86YEXYTUJrJdAi6dc0SlC7MWF4pbNH3SV1+nFO+L3OxiKb
         2VzR1EY1Bk6Zucecvdj2niyRdHQtnisKJLmqPPQUYFvynvTBP+JuSeWVfEOHR5x5sGW1
         3hIVYJBFs7MQ90Tuyn63N8wR21xEjkhW8RpuayM6AbIsw2PWnW6OzwFeRL+5SOAbwbmk
         LhylJo3gbYsqp8sp42UnwwbMN5p7GfEYQx8RQt4ptXiV7PTUG3yD5JsyPA55FyJm0Xeu
         wffEh/gOc4HrFstikKu5+46Q3TNNcd++j//zl2ezBuEiO8ayl5RSfJnKSHiUWaOe9NZN
         dRGw==
X-Gm-Message-State: AOJu0Yw/feRwnS2XffKUaeUaqj+XdyDSdxKwiPPwJ02uaIqNSvmKaSgm
	AweCVi5kCMwmK5gRJdI2S4a3Td1cFm8=
X-Google-Smtp-Source: AGHT+IEGaMP5jTpwuzkzUXqsseBvw+vFrPHYAQKtR71gOi1FZ8hJ9Zodg2eE12+eYCdXXlfvaungrQ==
X-Received: by 2002:a17:906:51d2:b0:9a5:9305:83fb with SMTP id v18-20020a17090651d200b009a5930583fbmr7628885ejk.34.1695294234568;
        Thu, 21 Sep 2023 04:03:54 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090690cd00b0099364d9f0e2sm872523ejw.98.2023.09.21.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 04:03:53 -0700 (PDT)
Message-ID: <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Sep 2023 14:03:52 +0300
In-Reply-To: <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
	 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
	 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
	 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
	 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
	 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-09-21 at 02:14 -0700, Alexei Starovoitov wrote:
> On Tue, Sep 19, 2023 at 5:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > > >=20
> > > > Note that R7=3Dfp-16 in old state vs R7_w=3D57005 in cur state.
> > > > The registers are considered equal because R7 does not have a read =
mark.
> > > > However read marks are not yet finalized for old state because
> > > > sl->state.branches !=3D 0.
>=20
> By "liveness marks are not finalized" you mean that
> regs don't have LIVE_DONE?
> That shouldn't matter to state comparison.
> It only needs to see LIVE_READ.
> LIVE_DONE is a sanity check for liveness algorithm only.
> It doesn't affect correctness.

No, actually I mean that the state where R7 is read had not been seen
yet and thus read mark had not been propagated to the parent state.
See below.

> > > > (Note: precision marks are not finalized as
> > > > well, which should be a problem, but this requires another example)=
.
> > >=20
> > > I originally convinced myself that non-finalized precision marking is
> > > fine, see the comment next to process_iter_next_call() for reasoning.
> > > If you can have a dedicated example for precision that would be great=
.
> > >=20
> > > As for read marks... Yep, that's a bummer. That r7 is not used after
> > > the loop, so is not marked as read, and it's basically ignored for
> > > loop invariant checking, which is definitely not what was intended.
> >=20
> > Liveness is a precondition for all subsequent checks, so example
> > involving precision would also involve liveness. Here is a combined
> > example:
> >=20
> >     r8 =3D 0
> >     fp[-16] =3D 0
> >     r7 =3D -16
> >     r6 =3D bpf_get_current_pid_tgid()
> >     bpf_iter_num_new(&fp[-8], 0, 10)
> >     while (bpf_iter_num_next(&fp[-8])) {
> >       r6++
> >       if (r6 !=3D 42) {
> >         r7 =3D -32
> >         continue;
> >       }
> >       r0 =3D r10
> >       r0 +=3D r7
> >       r8 =3D *(u64 *)(r0 + 0)
> >     }
> >     bpf_iter_num_destroy(&fp[-8])
> >     return r8
> >=20
> > (Complete source code is at the end of the email).
> >=20
> > The call to bpf_iter_num_next() is reachable with r7 values -16 and -32=
.
> > State with r7=3D-16 is visited first, at which point r7 has no read mar=
k
> > and is not marked precise.
> > State with r7=3D-32 is visited second:
> > - states_equal() for is_iter_next_insn() should ignore absence of
> >   REG_LIVE_READ mark on r7, otherwise both states would be considered
> >   identical;
>=20
> I think assuming live_read on all regs in regsafe() when
> cb or iter body is being processed will have big impact
> on processed insns.
> I suspect the underlying issue is different.
>=20
> In the first pass of the body with r7=3D-16 the 'r0 +=3D r7'
> insn should have added the read mark to r7,
> so is_iter_next_insn after 2nd pass with r7=3D-32 should reach
> case SCALAR_VALUE in regsafe().
> There we need to do something with lack of precision in r7=3D-16,
> but assume that is fixed, the 3rd iter of the loop should continue
> and 'r0 +=3D r7' in the _3rd_ iter of the loop should propagate
> read mark all the way to r7=3D-32 reg.

I repeat the complete example with added instruction numbers in the
end of the email. As of now verifier takes the following paths:

  First:
    // First path is for "drained" iterator and is not very interesting.
    0: (b7) r8 =3D 0                        ; R8_w=3D0
       ...
    2: (b7) r7 =3D -16                      ; R7_w=3D-16
       ...
    4: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3D=
scalar(id=3D1)
       ...
    12: (85) call bpf_iter_num_next#63182
       ; R0_w=3D0 fp-8=3Diter_num(ref_id=3D2,state=3Ddrained,depth=3D0) ref=
s=3D2
    13: (15) if r0 =3D=3D 0x0 goto pc+8
    22: (bf) r1 =3D r10
       ...
    26: (95) exit
 =20
  Second:
    // Note: at 13 a first checkpoint with "active" iterator state is reach=
ed
    //       this checkpoint is created for R7=3D-16 w/o read mark.
    from 12 to 13: R0_w=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0)=
 R6=3Dscalar(id=3D1)
                   R7=3D-16 R8=3D0 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,sta=
te=3Dactive,depth=3D1)
                   fp-16=3D00000000 refs=3D2
    13: (15) if r0 =3D=3D 0x0 goto pc+8       ; R0_w=3Drdonly_mem(id=3D3,re=
f_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
    14: (07) r6 +=3D 1                      ; R6=3Dscalar() refs=3D2
    15: (55) if r6 !=3D 0x2a goto pc+2      ; R6=3D42 refs=3D2
    16: (b7) r7 =3D -32                     ; R7_w=3D-32 refs=3D2
    17: (05) goto pc-8
    10: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0 refs=3D2
    11: (07) r1 +=3D -8
      is_iter_next (12):
        old:
           R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7=3D-16 R8_r=
=3D0 R10=3Dfp0
           fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16=3D0=
0000000 refs=3D2
        cur:
           R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R1_w=3Dfp=
-8 R6=3D42 R7_w=3D-32
           R8=3D0 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=
=3D1) fp-16=3D00000000 refs=3D2
      > hit
    12: safe
    // At this point R7=3D-32 but it still lacks read or precision marks,
    // thus states_equal() called from is_state_visited() for is_iter_next_=
insn()
    // branch returns true. (I added some logging to make it clear above)
   =20
  Third:
    // This is r6 !=3D 42 branch, it hits same checkpoint as "second" path.
    // Note that this branch has "r0 +=3D r7" and will propagate read mark
    // for R7 to the "old" checkpoint but that's too late, R7=3D-32 state
    // has already been pruned.
    from 15 to 18: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,off=3D0,imm=3D0) R=
6=3Dscalar()
                   R7=3D-16 R8=3D0 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D2,sta=
te=3Dactive,depth=3D1)
                   fp-16=3D00000000 refs=3D2
    18: (bf) r0 =3D r10                     ; R0_w=3Dfp0 R10=3Dfp0 refs=3D2
    19: (0f) r0 +=3D r7
    20: (79) r8 =3D *(u64 *)(r0 +0)         ; R0_w=3Dfp-16 R8_w=3DP0 fp-16=
=3D00000000 refs=3D2
    21: (05) goto pc-12
    10: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0 refs=3D2
    11: (07) r1 +=3D -8
      is_iter_next (12):
        old:
           R0=3Dscalar() R1_rw=3Dfp-8 R6_r=3Dscalar(id=3D1) R7_r=3DP-16 R8_=
r=3D0 R10=3Dfp0
           fp-8_r=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0) fp-16_r=
=3D00000000 refs=3D2
        cur:
           R0_w=3Dfp-16 R1_w=3Dfp-8 R6=3Dscalar() R7=3D-16 R8_w=3DP0 R10=3D=
fp0
           fp-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) fp-16=3D000=
00000 refs=3D2
      > hit
    12: safe

Here on the second path the state with R7=3D-32 is pruned and this is
not safe. Registers that differ in this state are R6 and R7. I can
update the example so that there would be no difference in R6, so
let's ignore that for now. As for R7, in the "old" state it is not
marked read because children states of "old" that read R7 had not been
visited yet.

> I mean the parentage chain between regs should link
> regs of iterations.
> I believe the process_iter_next_call() logic maintains
> correct parentage chain, since it's just a push_stack()
> and is_state_visited() should be connecting parents.
> So in case of iter body the issue with above loop is only
> in missing precision,
> but for your cb verification code I suspect the issue is due
> to lack of parentage chain and liveness is not propagated ?

Right, parentage chain is preserved by both process_iter_next_call()
and cb processing code as both use push_stack().

> I could be completely off the mark.
> The discussion is hard to follow.
> It's probably time to post raw patch and continue with code.

The "fix" that I have locally is not really a fix. It forces "exact"
states comparisons for is_iter_next_insn() case:
1. liveness marks are ignored;
2. precision marks are ignored;
3. scalars are compared using regs_exact().

It breaks a number a number of tests, because iterator "entry" states
are no longer equal and upper iteration bound is not tracked:
- iters/simplest_loop
- iters/iter_obfuscate_counter
- iters/testmod_seq_truncated
- iters/num
- iters/testmod_seq
- linked_list/pop_front_off
- linked_list/pop_back_off

The log above shows that (1) and (2) are inevitable.
(But might be relaxed if some data flow analysis which marks
 registers that *might* be precise or read is done before
 main verification path).
For (3), I'm not sure and need to think a bit more but "range_within"
logic seems fishy for states with .branches > 0.

--- complete example with insn numbers ---

SEC("fentry/" SYS_PREFIX "sys_nanosleep")
__failure
__msg("20: (79) r8 =3D *(u64 *)(r0 +0)")
__msg("invalid read from stack R0 off=3D-32 size=3D8")
__naked int iter_next_exact(void)
{
	/* r8 =3D 0
	 * fp[-16] =3D 0
	 * r7 =3D -16
	 * r6 =3D bpf_get_current_pid_tgid()
	 * bpf_iter_num_new(&fp[-8], 0, 10)
	 * while (bpf_iter_num_next(&fp[-8])) {
	 *   r6++
	 *   if (r6 =3D=3D 42) {
	 *     r7 =3D -32
	 *     continue;
	 *   }
	 *   r0 =3D r10
	 *   r0 +=3D r7
	 *   r8 =3D *(u64 *)(r0 + 0)
	 * }
	 * bpf_iter_num_destroy(&fp[-8])
	 * return r8
	 */
	asm volatile (
		"r8 =3D 0;"                            // 0
		"*(u64 *)(r10 - 16) =3D r8;"           // 1
		"r7 =3D -16;"                          // 2
		"call %[bpf_get_current_pid_tgid];"  // 3
		"r6 =3D r0;"                           // 4
		"r1 =3D r10;"                          // 5
		"r1 +=3D -8;"                          // 6
		"r2 =3D 0;"                            // 7
		"r3 =3D 10;"                           // 8
		"call %[bpf_iter_num_new];"          // 9
	"1:"
		"r1 =3D r10;"                          // 10
		"r1 +=3D -8;\n"                        // 11
		"call %[bpf_iter_num_next];"         // 12
		"if r0 =3D=3D 0 goto 2f;"                // 13
		"r6 +=3D 1;"                           // 14
		"if r6 !=3D 42 goto 3f;"               // 15
		"r7 =3D -32;"                          // 16
		"goto 1b;\n"                         // 17
	"3:"
		"r0 =3D r10;"                          // 18
		"r0 +=3D r7;"                          // 19
		"r8 =3D *(u64 *)(r0 + 0);"             // 20
		"goto 1b;\n"                         // 21
	"2:"
		"r1 =3D r10;"                          // 22
		"r1 +=3D -8;"                          // 23
		"call %[bpf_iter_num_destroy];"      // 24
		"r0 =3D r8;"                           // 25
		"exit;"                              // 26
		:
		: __imm(bpf_get_current_pid_tgid),
		  __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy),
		  __imm(bpf_probe_read_user)
		: __clobber_all
	);
}

