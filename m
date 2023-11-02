Return-Path: <bpf+bounces-13951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDE7DF4C3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305FE1C20F2B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969ED11185;
	Thu,  2 Nov 2023 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AExWQDyb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885E1B28C
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 14:17:27 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCEE13A;
	Thu,  2 Nov 2023 07:17:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da30fd994fdso1869151276.1;
        Thu, 02 Nov 2023 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934642; x=1699539442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozVCHWs6xPfqFL3sFI7yfrmGIHIbII6d/vJuYQgFLiI=;
        b=AExWQDybeQm99GEEq3yDnGpdtTqbAtthw9/hEFLNmNmvZYEeNWcsYuXBtz3g37cZcn
         qBpXPCx8AT4HCSb9Ozyaxx8iv8dJwbL9LmMSt90q2djsfWb6i9FTDWDW3ydbE2+ACs7N
         GSqueaz2zohv0Ct0qNbtsrBfz6ANCUf16lVvmGmrjOXRYfMQx3+DCTGw019PuvHQ4yA3
         NAgxAiyYIBnNZtIQjktnCvaOIHjXXrlehaoAQ/BsLF3dVeEMaVkuehi6vUlBDedbS9t8
         4CvaLo5dYcjhGNeoXyN5d2Tl32f5ZVsAOAmHHoEuwQQ0s5dLwUljJxLXBG8kYrd5vKT6
         e1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934642; x=1699539442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozVCHWs6xPfqFL3sFI7yfrmGIHIbII6d/vJuYQgFLiI=;
        b=qfJVZ09+wSZbw6MpLZlLO4cUKB41mTf3TYBn/ybUhKKZ6i43rmic3qpqTSAlFy/aFe
         kOX1mSCtl/g9yRBnKyf8Mo35HCQ0dYeHwLu5gkUxMGZmuY7V2+Hrlg0/FzVVKrdOF+dD
         tyVqGoyoafhVaACH8wTcVWeBapbzk3Maf0Ofqi9/Ln6Vj0ubhfu8ItcRN1cnuxQwjBDV
         8jQCw4pl+cgWSoleFdHoT0DmHUo1VFFaRyTgAkdZIMy1XMI9Q6YsP9aUisRbhvEmRi7k
         AbRDBU5ZoTDGFtOeheQZpKu3oDqmd+IdWkLkC++86X+cCJqwlYJhg7J/9Ot04BvboQtL
         xzJQ==
X-Gm-Message-State: AOJu0YyGj1HbNm40fEu8vrFgql7V9CxedH21vSC1kFhRcdjgkIN0N02B
	U2YSa+eW1nnlBkBfd9CGF3RjouajCOIYtKKkHw==
X-Google-Smtp-Source: AGHT+IERacoiMey2iwNhsLShLPUA+dv2+2NMsVR4WqLZBSHtd4+CnuNZy3L37UIhDtvklAQU92mM44VWIB/g3T1N24I=
X-Received: by 2002:a25:2fc3:0:b0:da0:8955:34f7 with SMTP id
 v186-20020a252fc3000000b00da0895534f7mr6351905ybv.23.1698934642161; Thu, 02
 Nov 2023 07:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <4b354d05b1bb4aa681fff5baca3455d90233951d.camel@gmail.com>
 <CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com>
 <CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com> <CAEf4BzYxC64doNAEcgtPGFirm2pWS=RUQ7JkGG+UMQ17=JqzcA@mail.gmail.com>
In-Reply-To: <CAEf4BzYxC64doNAEcgtPGFirm2pWS=RUQ7JkGG+UMQ17=JqzcA@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 2 Nov 2023 15:17:11 +0100
Message-ID: <CACkBjsbvk7rNfV0uS8uvrw497ybB1uLvUFvZWPx_SBzSRn2Raw@mail.gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 11:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 1, 2023 at 2:53=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrot=
e:
> >
> > On Fri, Oct 27, 2023 at 7:51=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Oct 25, 2023 at 10:34=E2=80=AFAM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >
> > > > On Tue, 2023-10-24 at 14:40 +0200, Hao Sun wrote:
> > > > > Hi,
> > > > >
> > > > > The following program can trigger a shift-out-of-bounds in
> > > > > tnum_rshift(), called by scalar32_min_max_rsh():
> > > > >
> > > > > 0: (bc) w0 =3D w1
> > > > > 1: (bf) r2 =3D r0
> > > > > 2: (18) r3 =3D 0xd
> > > > > 4: (bc) w4 =3D w0
> > > > > 5: (bf) r5 =3D r0
> > > > > 6: (bf) r7 =3D r3
> > > > > 7: (bf) r8 =3D r4
> > > > > 8: (2f) r8 *=3D r5
> > > > > 9: (cf) r5 s>>=3D r5
> > > > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > > > 11: (1f) r7 -=3D r5
> > > > > 12: (71) r6 =3D *(u8 *)(r1 +17)
> > > > > 13: (5f) r3 &=3D r8
> > > > > 14: (74) w2 >>=3D 30
> > > > > 15: (1f) r7 -=3D r5
> > > > > 16: (5d) if r8 !=3D r6 goto pc+4
> > > > > 17: (c7) r8 s>>=3D 5
> > > > > 18: (cf) r0 s>>=3D r0
> > > > > 19: (7f) r0 >>=3D r0
> > > > > 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> > > > > 21: exit
> > > >
> > > > Here is a simplified example:
> > > >
> > > > SEC("?tp")
> > > > __success __retval(0)
> > > > __naked void large_shifts(void)
> > > > {
> > > >         asm volatile ("                 \
> > > >         call %[bpf_get_prandom_u32];    \n\
> > > >         r8 =3D r0;                        \n\
> > > >         r6 =3D r0;                        \n\
> > > >         r6 &=3D 0xf;                      \n\
> > > >         if w8 < 0xffffffff goto +2;     \n\
> > > >         if r8 !=3D r6 goto +1;            \n\
> > > >         w0 >>=3D w8;       /* shift-out-bounds here */    \n\
> > > >         exit;                           \n\
> > > > "       :
> > > >         : __imm(bpf_get_prandom_u32)
> > > >         : __clobber_all);
> > > > }
> > > >
> > >
> > > With my changes the verifier does correctly derive that r8 !=3D r6 wi=
ll
> > > always happen, and thus skips w0 >>=3D w8. But the test itself with
> >
> > A similar issue can be triggered after your patch for JNE/JEQ.
> >
> > For the following case, the verifier would shift out of bound:
> >      //  0: r0 =3D -2
> >       BPF_MOV64_IMM(BPF_REG_0, -2),
> >       // 1: r0 /=3D 1
> >       BPF_ALU64_IMM(BPF_DIV, BPF_REG_0, 1),
> >       // 2: r8 =3D r0
> >       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
> >       // 3: if w8 !=3D 0xfffffffe goto+4
> >       BPF_JMP32_IMM(BPF_JNE, BPF_REG_8, 0xfffffffe, 4),
> >       // 4: if r8 s> 0xd goto+3
> >       BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 0xd, 3),
> >       // 5: r4 =3D 0x2
> >       BPF_MOV64_IMM(BPF_REG_4, 0x2),
> >       // 6: if r8 s<=3D r4 goto+1
> >       BPF_JMP_REG(BPF_JSLE, BPF_REG_8, BPF_REG_4, 1),
> >       // 7: w8 s>>=3D w0 # shift out of bound here
> >       BPF_ALU32_REG(BPF_ARSH, BPF_REG_8, BPF_REG_0),
> >       // 8: exit
> >       BPF_EXIT_INSN(),
> >
> >  -------- Verifier Log --------
> >  func#0 @0
> >  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >  0: (b7) r0 =3D -2                       ; R0_w=3D-2
> >  1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
> >  2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=
=3Dscalar(id=3D1)
> >  3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
> > R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D922337203685477=
5806,umin=3Dumin32=3D4294967294,umax=3D18446744073709551614,smin32=3D-2,sma=
x32=3D-2,
> > umax32=3D4294967294,var_off=3D(0xfffffffe; 0xffffffff00000000))
> >  4: (65) if r8 s> 0xd goto pc+3        ;
> > R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D13,umin=3Dumin3=
2=3D4294967294,umax=3D18446744073709551614,smin32=3D-2,smax32=3D-2,umax32=
=3D4294967294,
> > var_off=3D(0xfffffffe; 0xffffffff00000000))
> >  5: (b7) r4 =3D 2                        ; R4_w=3D2
> >  6: (dd) if r8 s<=3D r4 goto pc+1        ; R4_w=3D2 R8_w=3D4294967294
> >  7: (cc) w8 s>>=3D w0                    ; R0=3D4294967294 R8=3D4294967=
295
> >  8: (95) exit
> >
> > Here, after #6, reg range is incorrect, seems to be an issue in JSLE ca=
se
> > in is_branch_taken(). Is this issue fixed in your patch series?
>
> I don't know, but you can easily check by applying my patches on top
> of bpf-next and then trying your change.
>

After applying your change, the verifier does not shift out of bound,
but the range
is still not correct. See this verifier log:

-------- Verifier Log --------
func#0 @0
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
0: (b7) r0 =3D -2                       ; R0_w=3D-2
1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Dscal=
ar(id=3D1)
3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D9223372036854775806=
,umin=3Dumin32=3D4294967294,umax=3D18446744073709551614,smin32=3D-2,smax32=
=3D-2,umax32=3D4294967294,var_off=3D(0xfffffffe;
0xffffffff00000000))
4: (65) if r8 s> 0xd goto pc+3        ;
R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D13,umin=3Dumin32=3D=
4294967294,umax=3D18446744073709551614,smin32=3D-2,smax32=3D-2,umax32=3D429=
4967294,var_off=3D(0xfffffffe;
0xffffffff00000000))
5: (b7) r4 =3D 2                        ; R4_w=3D2
6: (dd) if r8 s<=3D r4 goto pc+1        ; R4_w=3D2 R8_w=3D4294967294
7: (cc) w8 s>>=3D w0                    ; R0=3D4294967294 R8=3Dscalar()
8: (77) r0 >>=3D 32                     ; R0_w=3D0
9: (57) r0 &=3D 1                       ; R0_w=3D0
10: (95) exit

from 6 to 8: safe

from 4 to 8: safe

from 3 to 8: safe
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1

-------- Test Run Log --------
RetVal: 1

At #9, the verifier thinks the value of R0 is 0, but it's 1, because
r0 is -2 all the time before
#8. The test run also shows return value is 1.

This program can reproduce the above: https://pastebin.com/raw/a0WuXaKh

