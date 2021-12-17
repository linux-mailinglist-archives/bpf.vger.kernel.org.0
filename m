Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACA4794C6
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 20:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhLQTb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 14:31:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45810 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhLQTbz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 14:31:55 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8F0A820B7179;
        Fri, 17 Dec 2021 11:31:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F0A820B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639769515;
        bh=cRv1WcSt0W5cSKayHF2tip8g7TX35i59/0QbRgNWzaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MhexrEl8xul/7EJEmQ9ctKSu/OqP5hTSgYLkcxOxbtlRaEmLVeMC0umttpEf1DccD
         5q05nUXhBgAv/XGu6USkDMeZn48vsVdskq8//9qkBP5FlvUqe+eBrfQRO6/47hBvyc
         y5FSZka5hwe/uuCmg8nTgipQq+dNld6NvVlSP6zI=
Received: by mail-pg1-f180.google.com with SMTP id r138so3041586pgr.13;
        Fri, 17 Dec 2021 11:31:55 -0800 (PST)
X-Gm-Message-State: AOAM530hNRZAk4LCVJ9lPG8s2ijwRjlKCNtdGxoVkSr/nHxaG96Ki6n6
        ivnctV1gn2e4SM4eXhVEUnDHwtJyCL6CiWoWHO0=
X-Google-Smtp-Source: ABdhPJwNH6xujiXnHflsTggNnsem9wvT8MU14S2o6N2NLP2AwJNCHyFv/iBlkfPk4xcTbpnyfBCTlPfGaBbnWmZmrx8=
X-Received: by 2002:a63:ec54:: with SMTP id r20mr3946441pgj.455.1639769515003;
 Fri, 17 Dec 2021 11:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com> <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
In-Reply-To: <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 17 Dec 2021 20:31:18 +0100
X-Gmail-Original-Message-ID: <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
Message-ID: <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
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

 On Wed, Dec 15, 2021 at 7:21 PM Matteo Croce
<mcroce@linux.microsoft.com> wrote:
>
> On Wed, Dec 15, 2021 at 6:29 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 15, 2021 at 6:54 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> > > >
> > > > Maybe do a level check here?
> > > > Since calling it and immediately returning doesn't conserve
> > > > the stack.
> > > > If it gets called it can finish fine, but
> > > > calling it again would be too much.
> > > > In other words checking the level here gives us
> > > > room for one more frame.
> > > >
> > >
> > > I thought that the compiler was smart enough to return before
> > > allocating most of the frame.
> > > I tried and this is true only with gcc, not with clang.
> >
> > Interesting. That's a surprise.
> > Could you share the asm that gcc generates?
> >
>
> Sure,
>
> This is the gcc x86_64 asm on a stripped down
> bpf_core_types_are_compat() with a 1k struct on the stack:
>
> bpf_core_types_are_compat:
> test esi, esi
> jle .L69
> push r15
> push r14
> push r13
> push r12
> push rbp
> mov rbp, rdi
> push rbx
> mov ebx, esi
> sub rsp, 9112
> [...]
> .L69:
> or eax, -1
> ret
>
> This latest clang:
>
> bpf_core_types_are_compat: # @bpf_core_types_are_compat
> push rbp
> push r15
> push r14
> push rbx
> sub rsp, 1000
> mov r14d, -1
> test esi, esi
> jle .LBB0_7
> [...]
> .LBB0_7:
> mov eax, r14d
> add rsp, 1000
> pop rbx
> pop r14
> pop r15
> pop rbp
> ret
>
> > > > > +                       err = __bpf_core_types_are_compat(local_btf, local_id,
> > > > > +                                                         targ_btf, targ_id,
> > > > > +                                                         level - 1);
> > > > > +                       if (err <= 0)
> > > > > +                               return err;
> > > > > +               }
> > > > > +
> > > > > +               /* tail recurse for return type check */
> > > > > +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
> > > > > +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
> > > > > +               goto recur;
> > > > > +       }
> > > > > +       default:
> > > > > +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> > > > > +                       btf_type_str(local_type), local_id, targ_id);
> > > >
> > > > That should be bpf_log() instead.
> > > >
> > >
> > > To do that I need a struct bpf_verifier_log, which is not present
> > > there, neither in bpf_core_spec_match() or bpf_core_apply_relo_insn().
> >
> > It is there. See:
> >         err = bpf_core_apply_relo_insn((void *)ctx->log, insn, ...
> >
> > > Should we drop the message at all?
> >
> > Passing it into bpf_core_spec_match() and further into
> > bpf_core_types_are_compat() is probably unnecessary.
> > All callers have an error check with a log right after.
> > So I think we won't lose anything if we drop this log.
> >
>
> Nice.
>
> > >
> > > > > +               return 0;
> > > > > +       }
> > > > > +}
> > > >
> > > > Please add tests that exercise this logic by enabling
> > > > additional lskels and a new test that hits the recursion limit.
> > > > I suspect we don't have such case in selftests.
> > > >
> > > > Thanks!
> > >
> > > Will do!
> >
> > Thanks!
>

Hi,

I'm writing a test which exercise that function.
I can succesfully trigger a call to __bpf_core_types_are_compat() with
these  calls:

bpf_core_type_id_kernel(struct sk_buff);
bpf_core_type_exists(struct sk_buff);
bpf_core_type_size(struct sk_buff);

but the kind will obviously be BTF_KIND_STRUCT.
I'm trying to do the same with kind BTF_KIND_FUNC_PROTO instead with:

void func_proto(int, unsigned int);
bpf_core_type_id_kernel(func_proto);

but I get a clang crash[1], while just checking the existence with:

typedef int (*func_proto_typedef)(struct sk_buff *);
bpf_core_type_exists(func_proto_typedef);

I don't reach even bpf_core_spec_match().

Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?

[1] https://github.com/llvm/llvm-project/issues/52779

Regards,
-- 
per aspera ad upstream
