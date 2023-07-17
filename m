Return-Path: <bpf+bounces-5130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DF756AEA
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354D61C20ACD
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AEBA55;
	Mon, 17 Jul 2023 17:45:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3E1878
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 17:45:35 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542D189
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:45:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703caf344so69725911fa.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689615928; x=1692207928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XngfHeM9WfZnUM86bkrDDsIHRleB9rVM3l42ddom0Q=;
        b=Tbvs3m5eEDEQmmEZyzaE8AOFkZpV20FpBim+7ftPACeN43VFueZIbpFlmPidd7nlT4
         8rffq58KJTlUI8VrCXjaU8aVSNud8mT2ajFFNINGsrK7ywK0U1II8jlXlljhU7MgRPkT
         t+iWKRBtWMD729gdHY7x+Xhmm/7WdS7VSu5GMIzfxUVtDF76Su/R+wl/CEGVHkeZ0Jua
         /mTreKA0z1vQrKkVj96lhzKQWceY2bh2UzKuRn/aBBjP2ZpGBoJQyF2FQPzzyDV8FsQQ
         Z4oFmJEXQ4uF2r97y/kNK7Ufi1PqGneXPfJr+0NxsyXgtIkUGQOEZ7p+qCBDgWrGrWgU
         y3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615928; x=1692207928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XngfHeM9WfZnUM86bkrDDsIHRleB9rVM3l42ddom0Q=;
        b=b2J8r/OKXEXIVDdxtrkyHy38u1ZBs10H4Y1055jbCG77jQXtMIWtgfw37Jhx02Vv1H
         mxR80TQTGHs9oyzBJymnBgoJH0Sr1N1aNPqORB87GBL+cOz5l0+U3hCuWTKM/geY6mRj
         zXUq8d4+n+rGKlSpEbaMPiZOb2GzMAAi4rg6wNniX5G8eGkdVfItfiBeLEDxU3XLAPAA
         RlUfTf7f8gVC1fHscjSbYX6rBav7i0UOzADZUtSTtEssn77EKlQwbGcazqpka7ObpP2x
         OKUj5b8o3Kkw9PIeMkVBQ2dHMg3mOLi/DxPuVu1Twq15no89jH0vl+snFT7idf/XF7Me
         EsSg==
X-Gm-Message-State: ABy/qLbRtrIXQkCJ3EDY7Qex9ANXNMesAQ7LAtBTGzy53LY+crqUQG34
	ARZcksFdrvIr9O5yI9/bLVWYF4nwj8vGvgqKwns=
X-Google-Smtp-Source: APBJJlHxf6sNr+1AGCh09tamoCCjHxdv+rODA1RRTnIy6cfedTdsSf21keqeu/GAHJ7ERiWuw85gW0yky7O5AF7w0Ts=
X-Received: by 2002:a2e:9b9a:0:b0:2b9:4418:b46e with SMTP id
 z26-20020a2e9b9a000000b002b94418b46emr163557lji.21.1689615928402; Mon, 17 Jul
 2023 10:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-8-memxor@gmail.com>
 <20230714223929.eu2ijg6t3kvgtl6b@MacBook-Pro-8.local> <CAP01T76AacE8OGbeo07RyL9ipd4G7OZUgUvqsuf45hpZJrT7zQ@mail.gmail.com>
In-Reply-To: <CAP01T76AacE8OGbeo07RyL9ipd4G7OZUgUvqsuf45hpZJrT7zQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 10:45:17 -0700
Message-ID: <CAADnVQJtUD6+gYinr+6ensj58qt2LeBj4dvT7Cyu-aBCafsP5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/10] bpf: Ensure IP is within
 prog->jited_length for bpf_throw calls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Mon, Jul 17, 2023 at 9:36=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 15 Jul 2023 at 04:09, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jul 13, 2023 at 08:02:29AM +0530, Kumar Kartikeya Dwivedi wrote=
:
> > > Now that we allow exception throwing using bpf_throw kfunc, it can
> > > appear as the final instruction in a prog. When this happens, and we
> > > begin to unwind the stack using arch_bpf_stack_walk, the instruction
> > > pointer (IP) may appear to lie outside the JITed instructions. This
> > > happens because the return address is the instruction following the
> > > call, but the bpf_throw never returns to the program, so the JIT
> > > considers instruction ending at the bpf_throw call as the final JITed
> > > instruction and end of the jited_length for the program.
> > >
> > > This becomes a problem when we search the IP using is_bpf_text_addres=
s
> > > and bpf_prog_ksym_find, both of which use bpf_ksym_find under the hoo=
d,
> > > and it rightfully considers addr =3D=3D ksym.end to be outside the pr=
ogram's
> > > boundaries.
> > >
> > > Insert a dummy 'int3' instruction which will never be hit to bump the
> > > jited_length and allow us to handle programs with their final
> > > isntruction being a call to bpf_throw.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
> > >  include/linux/bpf.h         |  2 ++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 8d97c6a60f9a..052230cc7f50 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1579,6 +1579,17 @@ st:                    if (is_imm8(insn->off))
> > >                       }
> > >                       if (emit_call(&prog, func, image + addrs[i - 1]=
 + offs))
> > >                               return -EINVAL;
> > > +                     /* Similar to BPF_EXIT_INSN, call for bpf_throw=
 may be
> > > +                      * the final instruction in the program. Insert=
 an int3
> > > +                      * following the call instruction so that we ca=
n still
> > > +                      * detect pc to be part of the bpf_prog in
> > > +                      * bpf_ksym_find, otherwise when this is the la=
st
> > > +                      * instruction (as allowed by verifier, similar=
 to exit
> > > +                      * and jump instructions), pc will be =3D=3D ks=
ym.end,
> > > +                      * leading to bpf_throw failing to unwind the s=
tack.
> > > +                      */
> > > +                     if (func =3D=3D (u8 *)&bpf_throw)
> > > +                             EMIT1(0xCC); /* int3 */
> >
> > Probably worth explaining that this happens because bpf_throw is marked
> > __attribute__((noreturn)) and compiler can emit it last without BPF_EXI=
T insn.
> > Meaing the program might not have BPF_EXIT at all.
>
> Yes, sorry about omitting that. I will add it to the commit message in v2=
.
>
> >
> > I wonder though whether this self-inflicted pain is worth it.
> > May be it shouldn't be marked as noreturn.
> > What do we gain by marking?
>
> It felt like the obvious thing to do to me. The cost on the kernel
> side is negligible (atleast in my opinion), we just have to allow it
> as final instruction in the program. If it's heavily used it allows
> the compiler to better optimize the code (marking anything after it
> unreachable, no need to save registers etc., although this may not be
> a persuasive point for you).

"no need to save registers"... "optimize"... that's the thing that worries =
me.
I think it's better to drop noreturn attribute.
bpf has implicit prolog/epilogue that only apply to bpf_exit insn.
bpf_call insn that doesn't return is exploiting undefined logic
in the compiler, since we never fully clarified our hidden prologue/epilogu=
e
rules. Saying it differently, bpf_tail_call is also noreturn,
but if we mark it as such all kinds of things will break.
We still need to add alloca(). It doesn't play well with the current BPF IS=
A.
I think it's better to treat 'noreturn' as broken in the compiler,
since its behavior may change.

> Regardless of this noreturn attribute, I was thinking whether we
> should always emit an extra instruction so that any IP (say one past
> last instruction) we get for a BPF prog can always be seen as
> belonging to it. It probably is only a problem surfaced by this
> bpf_throw call at the end, but I was wondering whether doing it
> unconditionally makes sense.

I think it's a corner case of this 'noreturn' from bpf_call logic.
The bpf prog is padded with 0xcc before and after already.
What you're suggesting is to add one of 0xcc to the body of the prog.
That doesn't sound right.

