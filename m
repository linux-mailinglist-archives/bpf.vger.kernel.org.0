Return-Path: <bpf+bounces-12773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808D7D05CA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2779D282312
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146D379;
	Fri, 20 Oct 2023 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2n63BUd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE3369
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 00:25:42 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF1C0;
	Thu, 19 Oct 2023 17:25:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso194337f8f.1;
        Thu, 19 Oct 2023 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697761538; x=1698366338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rc9lZF+vBPgi5R3r3/LvS3yCi6c6W9vHNO40Y+Feu1A=;
        b=g2n63BUdjQWQfG8ElHQSQKJ1L1TJTt2sVD+NxuLi5+WRvTmh5dWKpl6VGNd/uxGmKr
         4cYFEMjvbBI32niw9oKZU45/LE22gnlOwBQSLrolQPoaxLel/gQR6bGF5xK4j/il7sn/
         YU6/4fHmtOatOolf0NgNJFVyrw8KB9lT41ixxV8J6kJQOj3F2ucfiLF3YOaQiLO191Yb
         4X8Y/ah7jdZCvu+uyE0P51CO22sayuhqovfO8JVTiKBK96Agi1S6JPnqw21HqSskqGuX
         XJQcV3JumTVFGBUz/DZyrDFZ6iRUhYt0DOHiyqIlJA9MYyZVKYckRPIZ7tQqjeZfMwps
         0fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761538; x=1698366338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rc9lZF+vBPgi5R3r3/LvS3yCi6c6W9vHNO40Y+Feu1A=;
        b=aTVZpSYfOXAAQ4+7wf3kMtcIYK7T13Tdc2M0nOp1U3/OPw+0u39aHCkj9I2xx5oy8b
         1J0a92eBuCxo1+sS3FK0DTm4ypsRd2U4SiGAlfpRwc589+ql4Pew9qP8E+lB5sXh11T4
         DSaWj6UTHCGfR2f7WqDpRofa7E+KvfKvUYnVquK3zSI864wII5jmUEKOsW2DJK2/Sod+
         jGVNRRque0mHaH4kPvrU83JvUp7LPHPrbnY5gXdM6F7PxGVRT5An5L2JJBjT4+gTo6Hi
         zzxSkF6ho+iUnu7I+FLEFRpLQUFILw7x3m8U7f3wY77Gq1xQJtRGFKm2XcazL4KWuHgi
         l6DA==
X-Gm-Message-State: AOJu0YxGdgZfIujttw7S8czvjCrwFRFfcn+KZ9n0hKvecMT5fBqnoWSm
	fz44W0FF5yCklyIAbdKboMvO3Vg5feM8eOiXRSw=
X-Google-Smtp-Source: AGHT+IGjy/3289wIO62UBQAx1vsuR6Ooez52nMo1zTUy37lxdTiUiOBqp0iGtR2AjnkZ+PfklnK2NRV66UEtuvnOPx8=
X-Received: by 2002:adf:e58f:0:b0:31f:a0ab:26b5 with SMTP id
 l15-20020adfe58f000000b0031fa0ab26b5mr199270wrm.8.1697761538434; Thu, 19 Oct
 2023 17:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com>
 <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
 <ZSeq7ieG7Cq13w67@u94a> <CAADnVQJHAPid9HouwMEnfwDDKuy8BnGia269KSbby2gA030OBg@mail.gmail.com>
 <ZSi5PHDfoAYcvbCq@u94a>
In-Reply-To: <ZSi5PHDfoAYcvbCq@u94a>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 17:25:26 -0700
Message-ID: <CAADnVQLiWk5_Wf3q6iDAyLb-n0W5je3Z8XT2J-mtZ5s9RA-JjQ@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 8:28=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Thu, Oct 12, 2023 at 08:02:00AM -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 12, 2023 at 1:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse=
.com> wrote:
> > > On Wed, Oct 11, 2023 at 06:38:56AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Oct 11, 2023 at 2:01=E2=80=AFAM Hao Sun <sunhao.th@gmail.co=
m> wrote:
> > > > >
> > > > > Currently, we don't check if the branch-taken of a jump is reserv=
ed code of
> > > > > ld_imm64. Instead, such a issue is captured in check_ld_imm(). Th=
e verifier
> > > > > gives the following log in such case:
> > > > >
> > > > > func#0 @0
> > > > > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > > > 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,=
ks=3D4,vs=3D128,imm=3D0)
> > > > > 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> > > > > 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,=
ks=3D4,vs=3D128,imm=3D0)
> > > > > 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> > > > > 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> > > > > 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> > > > > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > > > > mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x=
32
> > > > > 7: R5_w=3D50
> > > > > 7: BUG_ld_00
> > > > > invalid BPF_LD_IMM insn
> > > > >
> > > > > Here the verifier rejects the program because it thinks insn at 7=
 is an
> > > > > invalid BPF_LD_IMM, but such a error log is not accurate since th=
e issue
> > > > > is jumping to reserved code not because the program contains inva=
lid insn.
> > > > > Therefore, make the verifier check the jump target during check_c=
fg(). For
> > > > > the same program, the verifier reports the following log:
> > > > >
> > > > > func#0 @0
> > > > > jump to reserved code from insn 8 to 7
> > > > >
> > > > > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index eed7350e15f4..725ac0b464cf 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e,=
 struct bpf_verifier_env *env,
> > > > >  {
> > > > >         int *insn_stack =3D env->cfg.insn_stack;
> > > > >         int *insn_state =3D env->cfg.insn_state;
> > > > > +       struct bpf_insn *insns =3D env->prog->insnsi;
> > > > >
> > > > >         if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERE=
D | FALLTHROUGH))
> > > > >                 return DONE_EXPLORING;
> > > > > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e=
, struct bpf_verifier_env *env,
> > > > >                 return -EINVAL;
> > > > >         }
> > > > >
> > > > > +       if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> > > > > +               verbose_linfo(env, t, "%d", t);
> > > > > +               verbose(env, "jump to reserved code from insn %d =
to %d\n", t, w);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >
> > > > I don't think we should be changing the verifier to make
> > > > fuzzer logs more readable.
> > >
> > > Taking fuzzer out of consideration, giving users clearer explanation =
for
> > > such verifier rejection could save a lot of head scratching.
> >
> > Users won't see such errors unless they are actively doing what
> > is not recommended.
> >
> > > Compiler shouldn't generate such program, but its plausible to forget=
 to
> > > account that BPF_LD_IMM64 consists of two instructions when writing
> > > assembly (especially with filter.h-like macros) and have it jump to t=
he 2nd
> > > part of BPF_LD_IMM64.
> >
> > Using macros to write bpf asm code is highly discouraged.
> > All kinds of errors are possible.
> > Bogus jump is just one of such mistakes.
> > Use naked functions and inline asm in C code that
> > both GCC and clang understand then you won't see bad jumps.
> > See selftets/bpf/verifier_*.c as an example.
>
> Understood, thanks for the explanation!
>
> Found them under progs/verifier_*.c inside the bpf selftest directory.
>
> > > > Same with patch 2. The code is fine as-is.
> > >
> > > The only way BPF_SIZE(insn->code) !=3D BPF_DW conditional in check_ld=
_imm()
> > > can be met right now is when we have a jump to the 2nd part of LD_IMM=
64; but
> > > what this conditional actually guard against is not straight-forward =
and
> > > quite confusing[1].
> >
> > There are plenty of cases in the verifier where we print
> > an error message. Some of them should be impossible due
> > to prior checks. In such cases we don't yell "verifier bug"
> > and are not going to do that in this case either.
>
> I agree, without patch 1 applied, the change to "verfier bug" in patch 2
> doesn't make sense and is just wrong. The point I'm trying to make is tha=
t
> the checks done by verifier are generally clear, you can make sense of wh=
y
> certain check are in place just by looking at the code, but
> BPF_SIZE(insn->code) !=3D BPF_DW is _not_ one of them.
>
> I got confused, (reading between the lines I believe) this had Hao puzzle=
d,
> and even Yongsong had to look twice[1] back then; so this check is certai=
nly
> not on-par with others we have in the verifier in terms of clarity, which
> leads to patches here as well as mine a while back.
>
> Perhaps we could reconsider making it more obvious how verifier prevents
> jump to reserved code/2nd instruction of LD_IMM64?

I agree that the message is confusing.
My point is that people see it only when they code in asm with macros.
Anyone who was doing that a lot saw that message and probably debugged
much worse issues while inserting an asm macro and forgetting to
adjust constants in branches. The code might even load, but will
execute something totally different.
asm macros are a nightmare to debug. Adding more code to the verifier
to help with one particular case is not going to help much.
Use inline asm in C is the right answer for folks that still need asm.

UX of the verifier sucks and we need to improve. So please focus on impactf=
ul
improvements instead of hacking on niche cases.

