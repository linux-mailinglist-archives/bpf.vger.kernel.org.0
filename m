Return-Path: <bpf+bounces-12037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985347C70DC
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC96A1C21034
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A56262B2;
	Thu, 12 Oct 2023 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDKis3GW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC6BA3C
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 15:02:15 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54CA9;
	Thu, 12 Oct 2023 08:02:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3215f19a13aso1011108f8f.3;
        Thu, 12 Oct 2023 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697122932; x=1697727732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S90hAqlSYxgq/E7D0v0WIajU1lTX+G+PuSX4VnbOm2s=;
        b=KDKis3GWmPt1v3HGVxBgn10/0YAnB/yWFbaafdzEo/3+Gb6RM2En8yCZSk3SYov8SI
         BlsGVdQ5SIGZflTelek2MEixwPfL8BWa5RaGMq47B6HEHAm5Z2v2gA9LvQq5+JX1PXmJ
         6RejCEbYgpgAikP5vtCn9BKw4qRCZovXRMRhZsWSB/f06ur4XhwSFB3rraGiNa+AUeNr
         LLF3nU26jXFAPyLcHm3Y67jWWxBzdNMGuWd0S+9cgLYJUhY0PnuWqjWhvASYkT8eW/3G
         +ND3VmrsLjT2FzGVpcNvapxsIDJeN8irvpmwtRfZbbHQ5/xkRG9AYipdbxXzt4P6WgVf
         N17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697122932; x=1697727732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S90hAqlSYxgq/E7D0v0WIajU1lTX+G+PuSX4VnbOm2s=;
        b=BnQuX0EnRC7qbfpTlvL81KHAxW/0V9VYZ0dQtyXlM50S3Nn9H9jMPPcI+ZSfQvblu5
         uzBduNboLIzL3XVPkIyEbQ4KUo01nK855E6xr2G5Sl/jFkKBC2idRw/tjOka6l+9Yeyw
         l8TMEz8Qd5QgPVEfZaODh3GF9A2KpBQ1lsqVwnmCxSR5yq+xSz4IlYTXu0Zd8syzcEgD
         eR3dTqbziz5pF85DQ5gGmz0zxeG4IMgzuq+M+8a/X1JfxTuWMlb57MXYxkgv5sRsxXik
         PVY0ir/9t0qHHfa2Wn6IbDZ1qf0RC+kr41XnlfMe/atbT8TK44CG+zSUo7YsseQUTtnO
         xhCQ==
X-Gm-Message-State: AOJu0YxpEj/ctj5fLHMUupkn9r7uqduRkUpwJFvd+Eiza4/sLliujdKN
	svG6t1XXG20r61YjfH/+CNNtGd2aG8ydvzrXQoQ=
X-Google-Smtp-Source: AGHT+IFlyPzAR6LK6U2iigbKY3HePEve7fDW4KzopE20OLPrOkOjGCI8S1oQsO+ZRoLEXRscWeToi84PdF3NTTzuIm8=
X-Received: by 2002:a05:6000:1cc:b0:32d:819c:5da6 with SMTP id
 t12-20020a05600001cc00b0032d819c5da6mr5400142wrx.21.1697122932227; Thu, 12
 Oct 2023 08:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
 <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com> <ZSeq7ieG7Cq13w67@u94a>
In-Reply-To: <ZSeq7ieG7Cq13w67@u94a>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Oct 2023 08:02:00 -0700
Message-ID: <CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Detect jumping to reserved code
 during check_cfg()
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 1:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Wed, Oct 11, 2023 at 06:38:56AM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 11, 2023 at 2:01=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> w=
rote:
> > >
> > > Currently, we don't check if the branch-taken of a jump is reserved c=
ode of
> > > ld_imm64. Instead, such a issue is captured in check_ld_imm(). The ve=
rifier
> > > gives the following log in such case:
> > >
> > > func#0 @0
> > > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> > > 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> > > 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> > > 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> > > 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> > > 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> > > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > > mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> > > 7: R5_w=3D50
> > > 7: BUG_ld_00
> > > invalid BPF_LD_IMM insn
> > >
> > > Here the verifier rejects the program because it thinks insn at 7 is =
an
> > > invalid BPF_LD_IMM, but such a error log is not accurate since the is=
sue
> > > is jumping to reserved code not because the program contains invalid =
insn.
> > > Therefore, make the verifier check the jump target during check_cfg()=
. For
> > > the same program, the verifier reports the following log:
> > >
> > > func#0 @0
> > > jump to reserved code from insn 8 to 7
> > >
> > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index eed7350e15f4..725ac0b464cf 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, str=
uct bpf_verifier_env *env,
> > >  {
> > >         int *insn_stack =3D env->cfg.insn_stack;
> > >         int *insn_state =3D env->cfg.insn_state;
> > > +       struct bpf_insn *insns =3D env->prog->insnsi;
> > >
> > >         if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | =
FALLTHROUGH))
> > >                 return DONE_EXPLORING;
> > > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, st=
ruct bpf_verifier_env *env,
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> > > +               verbose_linfo(env, t, "%d", t);
> > > +               verbose(env, "jump to reserved code from insn %d to %=
d\n", t, w);
> > > +               return -EINVAL;
> > > +       }
> >
> > I don't think we should be changing the verifier to make
> > fuzzer logs more readable.
>
> Taking fuzzer out of consideration, giving users clearer explanation for
> such verifier rejection could save a lot of head scratching.

Users won't see such errors unless they are actively doing what
is not recommended.

> Compiler shouldn't generate such program, but its plausible to forget to
> account that BPF_LD_IMM64 consists of two instructions when writing
> assembly (especially with filter.h-like macros) and have it jump to the 2=
nd
> part of BPF_LD_IMM64.

Using macros to write bpf asm code is highly discouraged.
All kinds of errors are possible.
Bogus jump is just one of such mistakes.
Use naked functions and inline asm in C code that
both GCC and clang understand then you won't see bad jumps.
See selftets/bpf/verifier_*.c as an example.

> > Same with patch 2. The code is fine as-is.
>
> The only way BPF_SIZE(insn->code) !=3D BPF_DW conditional in check_ld_imm=
()
> can be met right now is when we have a jump to the 2nd part of LD_IMM64; =
but
> what this conditional actually guard against is not straight-forward and
> quite confusing[1].

There are plenty of cases in the verifier where we print
an error message. Some of them should be impossible due
to prior checks. In such cases we don't yell "verifier bug"
and are not going to do that in this case either.

