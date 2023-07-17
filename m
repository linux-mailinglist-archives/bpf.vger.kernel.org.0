Return-Path: <bpf+bounces-5118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0C975694F
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1AC280EC2
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99817EE;
	Mon, 17 Jul 2023 16:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9B10E7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:37:07 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFBD10E4
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:36:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so6346600a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689611815; x=1692203815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8TgGbr621gZzM/ZT0mn12VwZ32pslu3DbRmhhVFWpM=;
        b=drYes1DTT4C+dh/2eE6mqrN0W7kKJVXpBsFJv5o/TfgKu+3kwRJ31Li1eU5csa7vOf
         BWifkhacQiBj+TtvtPu1JcRSWOIM9iV9rbCn7wdnRgQFDigrScAS9JDRRdWAlcQYfo5H
         KSrClykpqn0/erl/nk4AvI1wgeAIlEwAkpYfaPk41eaXfg+41TZOfhq3MG7KUAhbcimf
         XI2E/yi4Y06RXEtMlHpG5qyZkXdKWUfU/31V4NVavTT82t768dzONPFDWUJoHmk4pich
         IU78pMRe0AADn2z+ojq3qiqEmhRKSwzBx97KH0jr6rswzCjcNvP1Yqpb/jSi+GRMix/o
         MGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611815; x=1692203815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8TgGbr621gZzM/ZT0mn12VwZ32pslu3DbRmhhVFWpM=;
        b=QzChQHKWzY7DBpFZ6VZ8+KoNLFTkXnGnRANFZWCUZhpi6EGhO0HGOpn4z5PkoWIROc
         3fAMh/Gt6bwfez2sB3GEXQQUlTquIgi+3z1caV7a7CwYl4Z0rnVjQ6kY+tYij9tjl85q
         rtzVoH1HymsIFuseA06VPLXvZZQTPjBQaS1dFpBC6xtLED46+79/cpG0FB9Sv8o42L0c
         qQb+bg9vH3TSuGIqS3Wy3xoIgUkvlama2Md7quIen9PDMi8ln4ZSUpNsFX7MEV7ELH6Z
         vpsEIhDCM9EUiVKu5Eyg4DBD8PAOUJUJ03j/9OwgCtk6tk5rVB68j2fjcK83CuK54h3t
         XxEA==
X-Gm-Message-State: ABy/qLYhehiK+tvoll7UO/d6VecyWii/DLwsKZE1vgGdYBOb5EHs6zqW
	8R+EWRDJZisVhrAUHP3eT9dgh//UORXqxvPOxbIS3b8LEVw=
X-Google-Smtp-Source: APBJJlGgZxSpOPlNp9vlSFB/81l5u80T1Vy13/wQQZw6dyXePZQPxCUiKRYE62MdjZXa/+UwtzvxBsuqRjybsP+RULw=
X-Received: by 2002:aa7:c60d:0:b0:51d:9195:400f with SMTP id
 h13-20020aa7c60d000000b0051d9195400fmr12160844edq.17.1689611815229; Mon, 17
 Jul 2023 09:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-8-memxor@gmail.com>
 <20230714223929.eu2ijg6t3kvgtl6b@MacBook-Pro-8.local>
In-Reply-To: <20230714223929.eu2ijg6t3kvgtl6b@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 22:06:15 +0530
Message-ID: <CAP01T76AacE8OGbeo07RyL9ipd4G7OZUgUvqsuf45hpZJrT7zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/10] bpf: Ensure IP is within
 prog->jited_length for bpf_throw calls
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 15 Jul 2023 at 04:09, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Now that we allow exception throwing using bpf_throw kfunc, it can
> > appear as the final instruction in a prog. When this happens, and we
> > begin to unwind the stack using arch_bpf_stack_walk, the instruction
> > pointer (IP) may appear to lie outside the JITed instructions. This
> > happens because the return address is the instruction following the
> > call, but the bpf_throw never returns to the program, so the JIT
> > considers instruction ending at the bpf_throw call as the final JITed
> > instruction and end of the jited_length for the program.
> >
> > This becomes a problem when we search the IP using is_bpf_text_address
> > and bpf_prog_ksym_find, both of which use bpf_ksym_find under the hood,
> > and it rightfully considers addr == ksym.end to be outside the program's
> > boundaries.
> >
> > Insert a dummy 'int3' instruction which will never be hit to bump the
> > jited_length and allow us to handle programs with their final
> > isntruction being a call to bpf_throw.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
> >  include/linux/bpf.h         |  2 ++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 8d97c6a60f9a..052230cc7f50 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1579,6 +1579,17 @@ st:                    if (is_imm8(insn->off))
> >                       }
> >                       if (emit_call(&prog, func, image + addrs[i - 1] + offs))
> >                               return -EINVAL;
> > +                     /* Similar to BPF_EXIT_INSN, call for bpf_throw may be
> > +                      * the final instruction in the program. Insert an int3
> > +                      * following the call instruction so that we can still
> > +                      * detect pc to be part of the bpf_prog in
> > +                      * bpf_ksym_find, otherwise when this is the last
> > +                      * instruction (as allowed by verifier, similar to exit
> > +                      * and jump instructions), pc will be == ksym.end,
> > +                      * leading to bpf_throw failing to unwind the stack.
> > +                      */
> > +                     if (func == (u8 *)&bpf_throw)
> > +                             EMIT1(0xCC); /* int3 */
>
> Probably worth explaining that this happens because bpf_throw is marked
> __attribute__((noreturn)) and compiler can emit it last without BPF_EXIT insn.
> Meaing the program might not have BPF_EXIT at all.

Yes, sorry about omitting that. I will add it to the commit message in v2.

>
> I wonder though whether this self-inflicted pain is worth it.
> May be it shouldn't be marked as noreturn.
> What do we gain by marking?

It felt like the obvious thing to do to me. The cost on the kernel
side is negligible (atleast in my opinion), we just have to allow it
as final instruction in the program. If it's heavily used it allows
the compiler to better optimize the code (marking anything after it
unreachable, no need to save registers etc., although this may not be
a persuasive point for you).

Regardless of this noreturn attribute, I was thinking whether we
should always emit an extra instruction so that any IP (say one past
last instruction) we get for a BPF prog can always be seen as
belonging to it. It probably is only a problem surfaced by this
bpf_throw call at the end, but I was wondering whether doing it
unconditionally makes sense.

