Return-Path: <bpf+bounces-12009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B67C65A0
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F9A2826BD
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7ECA77;
	Thu, 12 Oct 2023 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQgWY1gR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC429D529
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:32:49 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57885BA;
	Wed, 11 Oct 2023 23:32:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso518364276.3;
        Wed, 11 Oct 2023 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697092367; x=1697697167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLs232MoIvKTceoFGKf83FsYAh/WEEvSsX2TipWGeU4=;
        b=FQgWY1gRQCI3x8yWmyVVZY1MEkz/WxLWijdF2uaZanr7xLvbUOYTB+FTPqOGL1nIrK
         ThAVKJspSYKJS726r/FEn0t3CaW2G1BBf6lhKlqtgFT30r91uTo/pFR636jwkcwYOFxv
         nAFPInV0GRvvaNJtaSAK3hqQzVlP7Bl1+XDmaUsCsliaMfRPCc1FtHBLnOrvelNPO3yc
         W82vFuNCrCFrZOMg1chKFdirHuPksvI5NZEq5Rvtj+kp6bbI33UpAIMu/s9p5jl3uNGT
         ZUp1NvqUfnmW1PCRclKbxZLbLfIq9k6Tl/4OKh/1pFmzNkvs6uXux2a2K/CxTsh6VsUq
         Bjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092367; x=1697697167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLs232MoIvKTceoFGKf83FsYAh/WEEvSsX2TipWGeU4=;
        b=V/9FpPeuOrFYOoLDn1MsQFKsAeJlk0yjbdoWa2WsHrXBVDZpnEaj4p/xFYzBxhZ/zt
         HTNOMo9XcVv4oAdDz0O4HW/RZ0V2jUBJhoMMxwr5FL9T6X0ry4pH6SYSve0zPM8cq2nG
         RXAIrJqvanuY+wFgLM7lYN+s5YvCkLjxbaenAlRdy7V8uSKJ5EIfrYGg/gHGsnHVG9/k
         tOpE0TjLIk+d68Mbsc2suHIY36igzq/sC6nMmHpjDZAvIxPrsulAMi48tjpvfGe+RYk2
         cZEV1k+GXDBIYXqH1bDK+do9QtkNBrrJrcthF6uSLgL8hp1FFxo9cixm2bTkuu6A8V7X
         IEZQ==
X-Gm-Message-State: AOJu0Yw5B4/jSal32VJVko9gWg4nJXNc5NNryZfmjHyZpIarm1+iLqbb
	r3ghJ1+2xqK+76tuoHw+bis5lBzxi6pezFIDIQ==
X-Google-Smtp-Source: AGHT+IHkDv5jKaQ1FgsNyM0VOVCwqFWJXnJyrusacjLePBkFgPyzB5kGHgmIe9tx3q5vW64I8SeFnjGpVfd3+nPwLKA=
X-Received: by 2002:a25:4d89:0:b0:d99:f29f:371 with SMTP id
 a131-20020a254d89000000b00d99f29f0371mr9694650ybb.4.1697092367335; Wed, 11
 Oct 2023 23:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011-jmp-into-reserved-fields-v3-0-97d2aa979788@gmail.com>
 <20231011-jmp-into-reserved-fields-v3-1-97d2aa979788@gmail.com> <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
In-Reply-To: <CAADnVQJnhfbALtNkCauS_ZwRfybcb_mryEvZW7Uu1uOSshQ9Ew@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 12 Oct 2023 08:32:36 +0200
Message-ID: <CACkBjsabY6e1Zh1R+gyuqwpuDiXJwLDc9s9wEEqfb=1P11QeOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Detect jumping to reserved code
 during check_cfg()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Wed, Oct 11, 2023 at 3:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 11, 2023 at 2:01=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wro=
te:
> >
> > Currently, we don't check if the branch-taken of a jump is reserved cod=
e of
> > ld_imm64. Instead, such a issue is captured in check_ld_imm(). The veri=
fier
> > gives the following log in such case:
> >
> > func#0 @0
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D128,imm=3D0)
> > 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> > 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D128,imm=3D0)
> > 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> > 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> > 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> > mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> > 7: R5_w=3D50
> > 7: BUG_ld_00
> > invalid BPF_LD_IMM insn
> >
> > Here the verifier rejects the program because it thinks insn at 7 is an
> > invalid BPF_LD_IMM, but such a error log is not accurate since the issu=
e
> > is jumping to reserved code not because the program contains invalid in=
sn.
> > Therefore, make the verifier check the jump target during check_cfg(). =
For
> > the same program, the verifier reports the following log:
> >
> > func#0 @0
> > jump to reserved code from insn 8 to 7
> >
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index eed7350e15f4..725ac0b464cf 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struc=
t bpf_verifier_env *env,
> >  {
> >         int *insn_stack =3D env->cfg.insn_stack;
> >         int *insn_state =3D env->cfg.insn_state;
> > +       struct bpf_insn *insns =3D env->prog->insnsi;
> >
> >         if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FA=
LLTHROUGH))
> >                 return DONE_EXPLORING;
> > @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, stru=
ct bpf_verifier_env *env,
> >                 return -EINVAL;
> >         }
> >
> > +       if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> > +               verbose_linfo(env, t, "%d", t);
> > +               verbose(env, "jump to reserved code from insn %d to %d\=
n", t, w);
> > +               return -EINVAL;
> > +       }
>
> I don't think we should be changing the verifier to make
> fuzzer logs more readable.
>
> Same with patch 2. The code is fine as-is.

Confused, the changes are not for fuzzer logs but to handle jumping to
the middle of ld_imm64. Like jumping out of bounds, both are similar
issues and can be handled in one place.

The current code handles such incorrect jumps in check_ld_imm(), which
is strange, and the error log "BAD_LD_IMM" rather than "bad jump" is
also strange.

The second one is just for verifier debugging because the only
caller of check_ld_imm() is do_check(), before which we already
have resolve_pseudo_ldimm64() which has opcode_in_insntable()
to check the validity of insn code. The only reason we could see
an invalid ld_imm64 in check_id_imm() is errors somewhere else.

