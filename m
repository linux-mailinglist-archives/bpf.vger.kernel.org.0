Return-Path: <bpf+bounces-13857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BD7DE837
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782B51C20E37
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3C14AAD;
	Wed,  1 Nov 2023 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHJNXqiY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10F125D3
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:45:22 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76FC10F;
	Wed,  1 Nov 2023 15:45:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so67955466b.0;
        Wed, 01 Nov 2023 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698878719; x=1699483519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptbNpH+AcVqxM1M4NGsECpNzHfwuOHCRxY6vQN87uCg=;
        b=CHJNXqiYcQyYl4riPXtWDy3vryJWplZrWb4eZY4h8m45gHevbClTolEGIg0sYsq2Wx
         urECiZ3mqW1iLNtrj6moPXvcw70/F0OqCU8bN7g8ajMAMr+M0L90BZ8JknGmSBkhIRiD
         +NzfO8NuYoCxcIwuDKnSF0uBMMnAiIoWwJczVbr90y0YS6zB1wuTgkCbXWVon7NHk1Ne
         ghs7gELZEEJevw825Awc91+yNWNqAiiCSRszdy610VZ2j1OWnnGqhQ3shnGU3FQx7KUj
         OUAOM95sK+reZKajlDUmj9vDAz0bMPv0xv1unnIFmHmgq35bqh9aujxvXEFH9vp5tVR+
         lBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878719; x=1699483519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptbNpH+AcVqxM1M4NGsECpNzHfwuOHCRxY6vQN87uCg=;
        b=xEKFX4Zi8PEPTf/Op7h4193oOwL5fH1ix7kIFjysXT1G4uaSqiJetH99FbnfYWfu1n
         Y59ZxFP/Xr3wiW+kpDcwnLKrVKWKKIloLzOm6+JAiW3juMDrMGB0xM2IG7fzPsjjqujY
         R5+N5hOUw4jVsBbh9bQ/LkEC1bjueJb+AMZCT0Yygdm6Lh7MGnT/heVT/IYXIbTW86sL
         BHIKYCO03G2LzlOal/yd61xbg2ljmPBBQy65shI9IdL47OO8KsurhKcsEoEsEv0BEj5l
         hQ8QjP7liapVHKjfKIfsnputDxt/nkZUo42hnTjIwK3kv1SAix+nJLUiwlMFN0jM5hqY
         p+1A==
X-Gm-Message-State: AOJu0Yz2D0ymrcPdJLorPlhks+KBnmJM2MmmmvMHE7WYOnBkmAbwwzJw
	z3/hJjT7rmw8J7HQNu0brR2WAEx5xmjZYez5qLw=
X-Google-Smtp-Source: AGHT+IFJtjOX8B2PpQ5J/SeveJ0TvaMdxovJ5G2DWSuFcHxNpOeRuekN4D3/at6gLIymeGBdEK67BpR5eo9YAvrjYk4=
X-Received: by 2002:a17:906:ef09:b0:9bd:a5a9:34de with SMTP id
 f9-20020a170906ef0900b009bda5a934demr3350099ejs.23.1698878718702; Wed, 01 Nov
 2023 15:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
 <4b354d05b1bb4aa681fff5baca3455d90233951d.camel@gmail.com>
 <CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com> <CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com>
In-Reply-To: <CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:45:07 -0700
Message-ID: <CAEf4BzYxC64doNAEcgtPGFirm2pWS=RUQ7JkGG+UMQ17=JqzcA@mail.gmail.com>
Subject: Re: bpf: shift-out-of-bounds in tnum_rshift()
To: Hao Sun <sunhao.th@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 2:53=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 7:51=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 25, 2023 at 10:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Tue, 2023-10-24 at 14:40 +0200, Hao Sun wrote:
> > > > Hi,
> > > >
> > > > The following program can trigger a shift-out-of-bounds in
> > > > tnum_rshift(), called by scalar32_min_max_rsh():
> > > >
> > > > 0: (bc) w0 =3D w1
> > > > 1: (bf) r2 =3D r0
> > > > 2: (18) r3 =3D 0xd
> > > > 4: (bc) w4 =3D w0
> > > > 5: (bf) r5 =3D r0
> > > > 6: (bf) r7 =3D r3
> > > > 7: (bf) r8 =3D r4
> > > > 8: (2f) r8 *=3D r5
> > > > 9: (cf) r5 s>>=3D r5
> > > > 10: (a6) if w8 < 0xfffffffb goto pc+10
> > > > 11: (1f) r7 -=3D r5
> > > > 12: (71) r6 =3D *(u8 *)(r1 +17)
> > > > 13: (5f) r3 &=3D r8
> > > > 14: (74) w2 >>=3D 30
> > > > 15: (1f) r7 -=3D r5
> > > > 16: (5d) if r8 !=3D r6 goto pc+4
> > > > 17: (c7) r8 s>>=3D 5
> > > > 18: (cf) r0 s>>=3D r0
> > > > 19: (7f) r0 >>=3D r0
> > > > 20: (7c) w5 >>=3D w8         # shift-out-bounds here
> > > > 21: exit
> > >
> > > Here is a simplified example:
> > >
> > > SEC("?tp")
> > > __success __retval(0)
> > > __naked void large_shifts(void)
> > > {
> > >         asm volatile ("                 \
> > >         call %[bpf_get_prandom_u32];    \n\
> > >         r8 =3D r0;                        \n\
> > >         r6 =3D r0;                        \n\
> > >         r6 &=3D 0xf;                      \n\
> > >         if w8 < 0xffffffff goto +2;     \n\
> > >         if r8 !=3D r6 goto +1;            \n\
> > >         w0 >>=3D w8;       /* shift-out-bounds here */    \n\
> > >         exit;                           \n\
> > > "       :
> > >         : __imm(bpf_get_prandom_u32)
> > >         : __clobber_all);
> > > }
> > >
> >
> > With my changes the verifier does correctly derive that r8 !=3D r6 will
> > always happen, and thus skips w0 >>=3D w8. But the test itself with
>
> A similar issue can be triggered after your patch for JNE/JEQ.
>
> For the following case, the verifier would shift out of bound:
>      //  0: r0 =3D -2
>       BPF_MOV64_IMM(BPF_REG_0, -2),
>       // 1: r0 /=3D 1
>       BPF_ALU64_IMM(BPF_DIV, BPF_REG_0, 1),
>       // 2: r8 =3D r0
>       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
>       // 3: if w8 !=3D 0xfffffffe goto+4
>       BPF_JMP32_IMM(BPF_JNE, BPF_REG_8, 0xfffffffe, 4),
>       // 4: if r8 s> 0xd goto+3
>       BPF_JMP_IMM(BPF_JSGT, BPF_REG_8, 0xd, 3),
>       // 5: r4 =3D 0x2
>       BPF_MOV64_IMM(BPF_REG_4, 0x2),
>       // 6: if r8 s<=3D r4 goto+1
>       BPF_JMP_REG(BPF_JSLE, BPF_REG_8, BPF_REG_4, 1),
>       // 7: w8 s>>=3D w0 # shift out of bound here
>       BPF_ALU32_REG(BPF_ARSH, BPF_REG_8, BPF_REG_0),
>       // 8: exit
>       BPF_EXIT_INSN(),
>
>  -------- Verifier Log --------
>  func#0 @0
>  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>  0: (b7) r0 =3D -2                       ; R0_w=3D-2
>  1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
>  2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Ds=
calar(id=3D1)
>  3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
> R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D92233720368547758=
06,umin=3Dumin32=3D4294967294,umax=3D18446744073709551614,smin32=3D-2,smax3=
2=3D-2,
> umax32=3D4294967294,var_off=3D(0xfffffffe; 0xffffffff00000000))
>  4: (65) if r8 s> 0xd goto pc+3        ;
> R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808514,smax=3D13,umin=3Dumin32=
=3D4294967294,umax=3D18446744073709551614,smin32=3D-2,smax32=3D-2,umax32=3D=
4294967294,
> var_off=3D(0xfffffffe; 0xffffffff00000000))
>  5: (b7) r4 =3D 2                        ; R4_w=3D2
>  6: (dd) if r8 s<=3D r4 goto pc+1        ; R4_w=3D2 R8_w=3D4294967294
>  7: (cc) w8 s>>=3D w0                    ; R0=3D4294967294 R8=3D429496729=
5
>  8: (95) exit
>
> Here, after #6, reg range is incorrect, seems to be an issue in JSLE case
> in is_branch_taken(). Is this issue fixed in your patch series?

I don't know, but you can easily check by applying my patches on top
of bpf-next and then trying your change.

>
> > __retval(0) is not a valid test, so it would be good to construct
> > something that will correctly return 0 at runtime (or use some other
> > check). So I won't put this test into my patch set and will live it as
> > a follow up for someone. But here's the log for anyone curious:
> >
> > VERIFIER LOG:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > func#0 @0
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > ; asm volatile ("                                       \
> > 0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
> > 1: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3D=
scalar(id=3D1)
> > 2: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3D=
scalar(id=3D1)
> > 3: (57) r6 &=3D 15                      ;
> > R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_=
off=3D(0x0;
> > 0xf))
> > 4: (a6) if w8 < 0xffffffff goto pc+2          ;
> > R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808513,umin=3Dumin32=3D429496=
7295,smin32=3D-1,smax32=3D-1,var_off=3D(0xffffffff;
> > 0xffffffff00000000))
> > 5: (5d) if r8 !=3D r6 goto pc+1
> > mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=3Dr0,r8 stack=3D before 4: (a6) if w8 <
> > 0xffffffff goto pc+2
> > mark_precise: frame0: regs=3Dr0,r8 stack=3D before 3: (57) r6 &=3D 15
> > mark_precise: frame0: regs=3Dr0,r8 stack=3D before 2: (bf) r6 =3D r0
> > mark_precise: frame0: regs=3Dr0,r8 stack=3D before 1: (bf) r8 =3D r0
> > mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pr=
andom_u32#7
> > mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=3Dr6 stack=3D before 4: (a6) if w8 < 0xfffff=
fff goto pc+2
> > mark_precise: frame0: regs=3Dr6 stack=3D before 3: (57) r6 &=3D 15
> > mark_precise: frame0: regs=3Dr6 stack=3D before 2: (bf) r6 =3D r0
> > mark_precise: frame0: regs=3Dr0 stack=3D before 1: (bf) r8 =3D r0
> > mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pr=
andom_u32#7
> > 5: R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,v=
ar_off=3D(0x0;
> > 0xf)) R8_w=3Dscalar(id=3D1,smin=3D-9223372032559808513,umin=3Dumin32=3D=
4294967295,smin32=3D-1,smax32=3D-1,var_off=3D(0xffffffff;
> > 0xffffffff00000000))
> > 7: (95) exit
> >
> > from 4 to 7: R0=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D18446=
744073709551614,umax32=3D4294967294)
> > R6=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_of=
f=3D(0x0; 0xf))
> > R8=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D184467440737095516=
14,umax32=3D4294967294)
> > R10=3Dfp0
> > 7: R0=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D184467440737095=
51614,umax32=3D4294967294)
> > R6=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_of=
f=3D(0x0; 0xf))
> > R8=3Dscalar(id=3D1,smax=3D9223372036854775806,umax=3D184467440737095516=
14,umax32=3D4294967294)
> > R10=3Dfp0
> > 7: (95) exit
> > processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1
> > peak_states 1 mark_read 1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > at insn #4, simulating a FALSE condition, verifier knows that r6 is
> > [0, 15], while w8 is exactly 0xffffffff, so at insn #5 it can tell
> > that 0xffffffff can never be equal to a value in [0, 15] range, and
> > thus skips the shift instruction.
> >

