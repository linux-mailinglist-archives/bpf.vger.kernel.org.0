Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68363E6EB
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLABJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLABJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:09:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BEE5CD0A
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:09:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id o13so718378ejm.1
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt1Q+Qvu5kN3GTD54s1gR0b7AvjWYLIRtJNt3elWBAM=;
        b=PY7puCjiWr4Zt+YUPVy/oiFbARTl605VPwplHOwPSJF7/C1vGWJF0l4oDoZc6944wG
         LLR9PRy8zJsikMEZPw82kIGrecpQDPP+BigP+o6NUEImC1CgAkA+FYkSZPhRcSWKqmz2
         9+tCW/iaYgxo/UFKDbdJ6EQx5L/bkF335nePl5hX6iBLtECRwrCvNshEmkJeyS9LhwjK
         nSCWqhP2yk8sM+U/Zf0ekXHRZUWytDwc6d6ip0SZkPmjEcj116JPRsEcHUaDXiOhGwH+
         vhiVCSm2OXSRw+7g9EHxcehpKJhOBE0gb2yrWwyGqqYR/BmT0UJKsVKRTy15UcUMG0/g
         cBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt1Q+Qvu5kN3GTD54s1gR0b7AvjWYLIRtJNt3elWBAM=;
        b=JSZsBN23ypoYrXMEe4wynG3OzfFsBKS86I4gEC5gW5Vw+J4P8IfovXUWPr4qSTDgLm
         eM5GuJOpHpmfHewAy2hDiFnV1FHRcuhyPLDfbECycQGPTXNQQlhZQSFg/1/o2tkOugSh
         v81XJBiEr6WQ/xOgyfhv8kzic76WZlQHWzvgDFYGIwRjWQQ7if1P+8tWas4EYoAAKmNp
         XVJIO65jCU8LOCf7brGm1vveTuxeptMpf3ccgnp7XK0iaEvoiEXqFOSTgtMxD5DMaR+C
         Ga1a2lKsaoKCCGyDwVIAPaO9OTh8S8FUJ9nqooUmIkNu4/BCPrFLSltBC3KwDocpqE9C
         lK4A==
X-Gm-Message-State: ANoB5pmRHqSUEbyhFJZyPv5UHUadvgCs5NnO8uhDukMBF8cHP16W3fRo
        cFa81zfxbahuKkOcdLgFIOeqcNWNVVQ731j8v3I=
X-Google-Smtp-Source: AA0mqf4kRpR78VQXL/V79sbpLeWn9zHTLM19rYLUWzlf+dLEM+/l1nRTe4lgPLuwVlFN/Ei3nnxo2TM0LH7ccg8CUaA=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr39631581ejb.745.1669856955538; Wed, 30
 Nov 2022 17:09:15 -0800 (PST)
MIME-Version: 1.0
References: <87leoh372s.fsf@toke.dk> <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk> <Y4Yeom8vSZtBM3o2@wtfbox.lan> <877czdzfid.fsf@toke.dk>
In-Reply-To: <877czdzfid.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 17:09:03 -0800
Message-ID: <CAEf4Bza2xDZ45kxxa3dg1C_RWE=UB5UFYEuFp6rbXgX=LRHv-A@mail.gmail.com>
Subject: Re: Calling kfuncs in modules - BTF mismatch?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 12:12 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Artem Savkov <asavkov@redhat.com> writes:
>
> > On Sun, Nov 13, 2022 at 07:04:43PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
> >> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> >>
> >> >>
> >> >> Hi everyone
> >> >>
> >> >> There seems to be some issue with BTF mismatch when trying to run t=
he
> >> >> bpf_ct_set_nat_info() kfunc from a module. I was under the impressi=
on
> >> >> that this is supposed to work, so is there some kind of BTF dedup i=
ssue
> >> >> here or something?
> >> >>
> >> >> Steps to reproduce:
> >> >>
> >> >> 1. Compile kernel with nf_conntrack built-in and run selftests;
> >> >>    './test_progs -a bpf_nf' works
> >> >>
> >> >> 2. Change the kernel config so nf_conntrack is build as a module
> >> >>
> >> >> 3. Start the test kernel and manually modprobe nf_conntrack and nf_=
nat
> >> >>
> >> >> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
> >> >>
> >> >> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRU=
CT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
> >> >
> >> > This week Kumar and I took a look at this issue and we ended up
> >> > identifying a duplication of nf_conn___init structure. In particular=
:
> >> >
> >> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> >> > net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
> >> > [110941] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
> >> > [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
> >> > net/netfilter/nf_nat.ko format raw | grep nf_conn__
> >> > [107488] STRUCT 'nf_conn___init' size=3D248 vlen=3D1
> >> >
> >> > Is it the root cause of the problem?
> >>
> >> It certainly seems to be related to it, at least. Amending the log
> >> message to include the BTF object IDs of the two versions shows that t=
he
> >> register has a reference to nf_conn__init in nf_conntrack.ko, while th=
e kernel
> >> expects it to point to nf_nat.ko.
> >>
> >> Not sure what's the right fix for this? Should libbpf be smart enough =
to
> >> pull the kfunc arg ID from the same BTF ID as the function itself? Or

Libbpf is doing just that. Or rather this just happens automatically.
Libbpf finds the FUNC type corresponding to a kfunc, and then all the
types of all the arguments are consistent with that FUNC definition.

I think the problem is that test is getting `struct nf_conn` from
bpf_xdp_ct_alloc() kfunc, which is defined in nf_conntrack module (and
so specifies that it returns `struct nf_conn` coming from
nf_conntrack's module BTF), while bpf_ct_set_nat_info() kfunc is
defined in nf_nat module and specifies that it expects `struct
nf_conn` defined in nf_nat's module BTF.

And those two types are two completely different types, with different
BTF object ID and BTF type ID, as far as all the BTF stuff is
concerned.

I don't know what the solution here is, but it's not on the libbpf
side at all for sure. As Toke said, bringing BTF dedup into the kernel
seems like an overkill. So some hacky "let's compare struct name and
size" approach perhaps?

> >
> > Verifier chose the ID based on where the variable was allocated, which
> > is bpf_(skb|xdp)_ct_alloc() from nf_conntrack.ko. Assuming btf id based
> > on usage location might be error prone.
>
> Yeah, I think we need something more robust.
>
> >> should the kernel compare structs and allow things if they're identica=
l?
> >> Andrii, WDYT?
> >
> > This works but might make verifier slower.
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 195d24316750..562d2c15906d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/poison.h>
> > +#include "../tools/lib/bpf/relo_core.h"
> >
> >  #include "disasm.h"
> >
> > @@ -8236,7 +8237,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
> >
> >         reg_ref_t =3D btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg=
_ref_id);
> >         reg_ref_tname =3D btf_name_by_offset(reg_btf, reg_ref_t->name_o=
ff);
> > -       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->=
off, meta->btf, ref_id, strict_type_match)) {
> > +       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->=
off, meta->btf, ref_id, strict_type_match) && \
> > +                       !__bpf_core_types_match(reg_btf, reg_ref_id, me=
ta->btf, ref_id, false, 10)) {
> >                 verbose(env, "kernel function %s args#%d expected point=
er to %s %s but R%d has a pointer to %s %s\n",
> >                         meta->func_name, argno, btf_type_str(ref_t), re=
f_tname, argno + 1,
> >                         btf_type_str(reg_ref_t), reg_ref_tname);
>
> Ah, cool! This is a lot of code to important into the kernel, though; do
> we really want to do that?
>
> I guess an alternative could be to make sure that every data type used
> by a kfunc is always referenced in a built-in module somewhere, so
> modules will use the definition from vmlinux.
>
> Andrii, Alexei, any opinions on which way to go with this?
>
> -Toke
>
