Return-Path: <bpf+bounces-5139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5A756CD8
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049A22811FE
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAFDC148;
	Mon, 17 Jul 2023 19:10:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68D253CD
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 19:10:14 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AE97
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:10:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso6831687a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621011; x=1692213011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5ve/ks5BekhLI6vhFo1Uisg8k0YXBWIRZviAQdxkv0=;
        b=Sshrg02O1XQejK10OX4zFcO7pBMXjrHiw/XoMUtWTUNV7cwUFwgZoKkPSJrGsVlwcY
         3nikwSJcOxnZEjqDkiwhGT0YP069DrA8IlzXEfAKxD5ak/C4eEiO85QX+4xzCwM/KqmP
         zePGMcYXTNvGLgf4ksdxnIuxPBOuB/zMo2sEZZklTeAD7a+qB2x3C+Izn0K9u6hXsAut
         Gimv1oPxY4dA6Q/cMWLRyA6cgR6VB1BuE9+J2MO6ZX32hmUG0grpClUdpzYsfEUPSIsk
         dY8hj8ZntWbzpS227cS320dkcucJYs2phpX4r45v9ogO5vPOboidrab4urGAaw92xNGn
         O9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621011; x=1692213011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5ve/ks5BekhLI6vhFo1Uisg8k0YXBWIRZviAQdxkv0=;
        b=RoQDaoPdanmcvjey+OdxFMeZn8YaX81lIKha9o/Wr90K+YSlaq2Sd53xm1QFjeSdVu
         kcemRRkTAC0dNR8zraCFyaZMZhJt0wHs01h8TGylbrlwTzjfJelxKFnduhR94v7WydBX
         XoiaKOjZerCC+E+i+qUmr9MXFKISK5jIr/UU65IH2s5OT/RJE5yBd7uo/UNXwt+tO6TQ
         YovWpehbWDsN0MSyrU0uSsPr6hs+hDs0QKDDGTMWll+N6oO6vPBDTlQiuo4E1eUCo5SK
         D2vRzUiKa2RYdOYB45srXRZzfnopOrnjG4bvEIk5gVI/NSP0PEfLWrx2bO1ZY8AR5b7Z
         HfhA==
X-Gm-Message-State: ABy/qLYqFGWhq6xWQsPHJABF9xgPIgGFf1U4VchEX36jBJJoVRXqDfPB
	IeSz5dC0btJVzuyUQHS7NWuUC+pJyaNm8Yb0DHM=
X-Google-Smtp-Source: APBJJlHxrerABmxNM2Ncbdiil/uRgOrWVvco05Wd9o7w3hpmrX4hO1I6TslS0mWjxu1HZljxPCTVWJogGpMGsLiK/vI=
X-Received: by 2002:a17:907:3c0d:b0:992:3897:1985 with SMTP id
 gh13-20020a1709073c0d00b0099238971985mr10000183ejc.43.1689621011379; Mon, 17
 Jul 2023 12:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-8-memxor@gmail.com>
 <20230714223929.eu2ijg6t3kvgtl6b@MacBook-Pro-8.local> <CAP01T76AacE8OGbeo07RyL9ipd4G7OZUgUvqsuf45hpZJrT7zQ@mail.gmail.com>
 <CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBCafsP5g@mail.gmail.com>
In-Reply-To: <CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBCafsP5g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Jul 2023 00:39:31 +0530
Message-ID: <CAP01T76W77SEU0H-zHqzrSkL_n5ffHCz5A-_=ELc-5c94jZ6=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/10] bpf: Ensure IP is within
 prog->jited_length for bpf_throw calls
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 at 23:15, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 17, 2023 at 9:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 15 Jul 2023 at 04:09, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 08:02:29AM +0530, Kumar Kartikeya Dwivedi wro=
te:
> > > > Now that we allow exception throwing using bpf_throw kfunc, it can
> > > > appear as the final instruction in a prog. When this happens, and w=
e
> > > > begin to unwind the stack using arch_bpf_stack_walk, the instructio=
n
> > > > pointer (IP) may appear to lie outside the JITed instructions. This
> > > > happens because the return address is the instruction following the
> > > > call, but the bpf_throw never returns to the program, so the JIT
> > > > considers instruction ending at the bpf_throw call as the final JIT=
ed
> > > > instruction and end of the jited_length for the program.
> > > >
> > > > This becomes a problem when we search the IP using is_bpf_text_addr=
ess
> > > > and bpf_prog_ksym_find, both of which use bpf_ksym_find under the h=
ood,
> > > > and it rightfully considers addr =3D=3D ksym.end to be outside the =
program's
> > > > boundaries.
> > > >
> > > > Insert a dummy 'int3' instruction which will never be hit to bump t=
he
> > > > jited_length and allow us to handle programs with their final
> > > > isntruction being a call to bpf_throw.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
> > > >  include/linux/bpf.h         |  2 ++
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 8d97c6a60f9a..052230cc7f50 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -1579,6 +1579,17 @@ st:                    if (is_imm8(insn->off=
))
> > > >                       }
> > > >                       if (emit_call(&prog, func, image + addrs[i - =
1] + offs))
> > > >                               return -EINVAL;
> > > > +                     /* Similar to BPF_EXIT_INSN, call for bpf_thr=
ow may be
> > > > +                      * the final instruction in the program. Inse=
rt an int3
> > > > +                      * following the call instruction so that we =
can still
> > > > +                      * detect pc to be part of the bpf_prog in
> > > > +                      * bpf_ksym_find, otherwise when this is the =
last
> > > > +                      * instruction (as allowed by verifier, simil=
ar to exit
> > > > +                      * and jump instructions), pc will be =3D=3D =
ksym.end,
> > > > +                      * leading to bpf_throw failing to unwind the=
 stack.
> > > > +                      */
> > > > +                     if (func =3D=3D (u8 *)&bpf_throw)
> > > > +                             EMIT1(0xCC); /* int3 */
> > >
> > > Probably worth explaining that this happens because bpf_throw is mark=
ed
> > > __attribute__((noreturn)) and compiler can emit it last without BPF_E=
XIT insn.
> > > Meaing the program might not have BPF_EXIT at all.
> >
> > Yes, sorry about omitting that. I will add it to the commit message in =
v2.
> >
> > >
> > > I wonder though whether this self-inflicted pain is worth it.
> > > May be it shouldn't be marked as noreturn.
> > > What do we gain by marking?
> >
> > It felt like the obvious thing to do to me. The cost on the kernel
> > side is negligible (atleast in my opinion), we just have to allow it
> > as final instruction in the program. If it's heavily used it allows
> > the compiler to better optimize the code (marking anything after it
> > unreachable, no need to save registers etc., although this may not be
> > a persuasive point for you).
>
> "no need to save registers"... "optimize"... that's the thing that worrie=
s me.
> I think it's better to drop noreturn attribute.
> bpf has implicit prolog/epilogue that only apply to bpf_exit insn.
> bpf_call insn that doesn't return is exploiting undefined logic
> in the compiler, since we never fully clarified our hidden prologue/epilo=
gue
> rules. Saying it differently, bpf_tail_call is also noreturn,
> but if we mark it as such all kinds of things will break.
> We still need to add alloca(). It doesn't play well with the current BPF =
ISA.
> I think it's better to treat 'noreturn' as broken in the compiler,
> since its behavior may change.
>

Ok, I think then let's drop this patch and the noreturn attribute on bpf_th=
row.

> > Regardless of this noreturn attribute, I was thinking whether we
> > should always emit an extra instruction so that any IP (say one past
> > last instruction) we get for a BPF prog can always be seen as
> > belonging to it. It probably is only a problem surfaced by this
> > bpf_throw call at the end, but I was wondering whether doing it
> > unconditionally makes sense.
>
> I think it's a corner case of this 'noreturn' from bpf_call logic.
> The bpf prog is padded with 0xcc before and after already.
> What you're suggesting is to add one of 0xcc to the body of the prog.
> That doesn't sound right.

Actually this patch was added because I caught the case where the
reported ip during unwinding was lying outside jited_length (=3D=3D
ksym.end).
So including an extra instruction would prevent that. But it's true
it's a side effect of the noreturn attribute, it wouldn't occur
otherwise.

Let's drop this patch then.

