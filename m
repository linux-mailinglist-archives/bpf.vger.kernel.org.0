Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19147609B
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 19:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbhLOSWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 13:22:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54182 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbhLOSWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 13:22:25 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id C278420B717B;
        Wed, 15 Dec 2021 10:22:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C278420B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639592544;
        bh=1yoFqk1NIOkk1E9u0o3iSqiMDfatwHvp5iTqOCmKgtY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bf0H/kwsMKg63IRp8BW+THyjUdhxTHL5yS9FiikFL0udxs17+DTmIYjI4r1wWMtv/
         O76T/ruJSnjKcOPFC9ei+mSDpncazi2yFC1mU+TCz4r5AeR76kd9h5pNB3pQu8dfqu
         Cu6YkXKRABB9k05EjaPv0WSEs2hvLK9DLa/9hkMY=
Received: by mail-pl1-f177.google.com with SMTP id b13so17218529plg.2;
        Wed, 15 Dec 2021 10:22:24 -0800 (PST)
X-Gm-Message-State: AOAM5312SNDj/Tq7TPn8Gi+zd/gb/mCkl+4bLnehTwyUgZMQ6dPorQol
        NGZMlyDfac7DtjT4JdvupVl3ryj6EVZ5dM1IjqI=
X-Google-Smtp-Source: ABdhPJxsssypnvz2ZNv9Io3lsaJWpF0ZvHLmzNTjwbRdVDkBnOjhXXBGyg7j1DosghtsK9FYLquvc576DMDU3SMikKc=
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr1194298pjq.20.1639592544248;
 Wed, 15 Dec 2021 10:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com> <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 15 Dec 2021 19:21:48 +0100
X-Gmail-Original-Message-ID: <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
Message-ID: <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 6:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 15, 2021 at 6:54 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > >
> > > Maybe do a level check here?
> > > Since calling it and immediately returning doesn't conserve
> > > the stack.
> > > If it gets called it can finish fine, but
> > > calling it again would be too much.
> > > In other words checking the level here gives us
> > > room for one more frame.
> > >
> >
> > I thought that the compiler was smart enough to return before
> > allocating most of the frame.
> > I tried and this is true only with gcc, not with clang.
>
> Interesting. That's a surprise.
> Could you share the asm that gcc generates?
>

Sure,

This is the gcc x86_64 asm on a stripped down
bpf_core_types_are_compat() with a 1k struct on the stack:

bpf_core_types_are_compat:
test esi, esi
jle .L69
push r15
push r14
push r13
push r12
push rbp
mov rbp, rdi
push rbx
mov ebx, esi
sub rsp, 9112
[...]
.L69:
or eax, -1
ret

This latest clang:

bpf_core_types_are_compat: # @bpf_core_types_are_compat
push rbp
push r15
push r14
push rbx
sub rsp, 1000
mov r14d, -1
test esi, esi
jle .LBB0_7
[...]
.LBB0_7:
mov eax, r14d
add rsp, 1000
pop rbx
pop r14
pop r15
pop rbp
ret

> > > > +                       err = __bpf_core_types_are_compat(local_btf, local_id,
> > > > +                                                         targ_btf, targ_id,
> > > > +                                                         level - 1);
> > > > +                       if (err <= 0)
> > > > +                               return err;
> > > > +               }
> > > > +
> > > > +               /* tail recurse for return type check */
> > > > +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
> > > > +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
> > > > +               goto recur;
> > > > +       }
> > > > +       default:
> > > > +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> > > > +                       btf_type_str(local_type), local_id, targ_id);
> > >
> > > That should be bpf_log() instead.
> > >
> >
> > To do that I need a struct bpf_verifier_log, which is not present
> > there, neither in bpf_core_spec_match() or bpf_core_apply_relo_insn().
>
> It is there. See:
>         err = bpf_core_apply_relo_insn((void *)ctx->log, insn, ...
>
> > Should we drop the message at all?
>
> Passing it into bpf_core_spec_match() and further into
> bpf_core_types_are_compat() is probably unnecessary.
> All callers have an error check with a log right after.
> So I think we won't lose anything if we drop this log.
>

Nice.

> >
> > > > +               return 0;
> > > > +       }
> > > > +}
> > >
> > > Please add tests that exercise this logic by enabling
> > > additional lskels and a new test that hits the recursion limit.
> > > I suspect we don't have such case in selftests.
> > >
> > > Thanks!
> >
> > Will do!
>
> Thanks!



-- 
per aspera ad upstream
