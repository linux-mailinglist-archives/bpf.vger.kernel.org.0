Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6EF475B18
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 15:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhLOOyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 09:54:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55686 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhLOOyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 09:54:15 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id 697B720B7179;
        Wed, 15 Dec 2021 06:54:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 697B720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639580055;
        bh=kpvtFImBdsm0KS6/7ksR5rDp39OEowT/MiX537AcTKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MmWbvmBoJOrpllac7Vzm7DlHz/8QuqZV4quR/T0DZyzWGW74auXKoo7+Wq2rI7x0z
         PD76FHEIuLAR0WBvXxQbKyKul+dDX+kIXyOqAerSCrKnlgWf6RfVG75Vzdbg7eZyjO
         QK7e3+cU3UAXqzQmSbGddXVub09+SvJSnMfidqW8=
Received: by mail-pj1-f53.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso20633066pji.0;
        Wed, 15 Dec 2021 06:54:15 -0800 (PST)
X-Gm-Message-State: AOAM531YkIBO0XsJ8d4o3e4VmnNYXyywAIALmBwIuZ15pnsmy72bUB/0
        mBFQTDtkBW36m+55u5zPcyijwk5lq4+twYdTkSU=
X-Google-Smtp-Source: ABdhPJyYlvtC8PbTkloBE3GK0NsNRRrs3BSa88a0IjzkqUrs32iyUjkW8mEl78Zy/F0o5l0K7Ce+nybVGCYh0qP0CrI=
X-Received: by 2002:a17:90b:3b8d:: with SMTP id pc13mr167135pjb.112.1639580054956;
 Wed, 15 Dec 2021 06:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com> <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
In-Reply-To: <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 15 Dec 2021 15:53:38 +0100
X-Gmail-Original-Message-ID: <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
Message-ID: <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
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

On Wed, Dec 15, 2021 at 6:57 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 10, 2021 at 9:20 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > In userspace, bpf_core_types_are_compat() is a recursive function which
> > can't be put in the kernel as is.
> > Limit the recursion depth to 2, to avoid potential stack overflows
> > in kernel.
> >
> > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
>
> Thank you for taking a stab at it!
>
> > +#define MAX_TYPES_ARE_COMPAT_DEPTH 2
> > +
> > +static
> > +int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> > +                               const struct btf *targ_btf, __u32 targ_id,
> > +                               int level)
> > +{
> > +       const struct btf_type *local_type, *targ_type;
> > +       int depth = 32; /* max recursion depth */
> > +
> > +       if (level <= 0)
> > +               return -EINVAL;
> > +
> > +       /* caller made sure that names match (ignoring flavor suffix) */
> > +       local_type = btf_type_by_id(local_btf, local_id);
> > +       targ_type = btf_type_by_id(targ_btf, targ_id);
> > +       if (btf_kind(local_type) != btf_kind(targ_type))
> > +               return 0;
> > +
> > +recur:
> > +       depth--;
> > +       if (depth < 0)
> > +               return -EINVAL;
> > +
> > +       local_type = btf_type_skip_modifiers(local_btf, local_id, &local_id);
> > +       targ_type = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
> > +       if (!local_type || !targ_type)
> > +               return -EINVAL;
> > +
> > +       if (btf_kind(local_type) != btf_kind(targ_type))
> > +               return 0;
> > +
> > +       switch (btf_kind(local_type)) {
> > +       case BTF_KIND_UNKN:
> > +       case BTF_KIND_STRUCT:
> > +       case BTF_KIND_UNION:
> > +       case BTF_KIND_ENUM:
> > +       case BTF_KIND_FWD:
> > +               return 1;
> > +       case BTF_KIND_INT:
> > +               /* just reject deprecated bitfield-like integers; all other
> > +                * integers are by default compatible between each other
> > +                */
> > +               return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
> > +       case BTF_KIND_PTR:
> > +               local_id = local_type->type;
> > +               targ_id = targ_type->type;
> > +               goto recur;
> > +       case BTF_KIND_ARRAY:
> > +               local_id = btf_array(local_type)->type;
> > +               targ_id = btf_array(targ_type)->type;
> > +               goto recur;
> > +       case BTF_KIND_FUNC_PROTO: {
> > +               struct btf_param *local_p = btf_params(local_type);
> > +               struct btf_param *targ_p = btf_params(targ_type);
> > +               __u16 local_vlen = btf_vlen(local_type);
> > +               __u16 targ_vlen = btf_vlen(targ_type);
> > +               int i, err;
> > +
> > +               if (local_vlen != targ_vlen)
> > +                       return 0;
> > +
> > +               for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> > +                       btf_type_skip_modifiers(local_btf, local_p->type, &local_id);
> > +                       btf_type_skip_modifiers(targ_btf, targ_p->type, &targ_id);
>
>
> Maybe do a level check here?
> Since calling it and immediately returning doesn't conserve
> the stack.
> If it gets called it can finish fine, but
> calling it again would be too much.
> In other words checking the level here gives us
> room for one more frame.
>

I thought that the compiler was smart enough to return before
allocating most of the frame.
I tried and this is true only with gcc, not with clang.

> > +                       err = __bpf_core_types_are_compat(local_btf, local_id,
> > +                                                         targ_btf, targ_id,
> > +                                                         level - 1);
> > +                       if (err <= 0)
> > +                               return err;
> > +               }
> > +
> > +               /* tail recurse for return type check */
> > +               btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
> > +               btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
> > +               goto recur;
> > +       }
> > +       default:
> > +               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> > +                       btf_type_str(local_type), local_id, targ_id);
>
> That should be bpf_log() instead.
>

To do that I need a struct bpf_verifier_log, which is not present
there, neither in bpf_core_spec_match() or bpf_core_apply_relo_insn().
Should we drop the message at all?

> > +               return 0;
> > +       }
> > +}
>
> Please add tests that exercise this logic by enabling
> additional lskels and a new test that hits the recursion limit.
> I suspect we don't have such case in selftests.
>
> Thanks!

Will do!

Regards,
-- 
per aspera ad upstream
