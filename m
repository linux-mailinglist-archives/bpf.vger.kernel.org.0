Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2161E899
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiKGCeT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 21:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGCeS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 21:34:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA402AE3
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 18:34:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f27so26662482eje.1
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 18:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsgqAQQLHqRLDXEzG5Tskk8VRetQTGlahVxSqWU++5E=;
        b=pEkWthFatzrLjodEfO+iuj/m3IJEyzDiIiqq8I+1WXbJ2ofiARAPsOInJ8HMdEhBMd
         adwACLPpY5qD+VnjBplpp7uSNSHs65240LIZpoW6mp16WLlpazu1zwQe/BuXElacypFk
         SKqKX3b5sxOHcvlMXdpnuLGPKsuElHh4KZveHE/1JEgK9AkQ5La5lGXWX4nY3yjHE9gU
         SH6QoGuXlkPPHnyr0O2oMOE66D/meE2hPDuGpwjK0b1gkH59CCZw5dAMdkZ9V/hrRvOc
         bmLNfi2XcT08OgEL+E9p2Vre2VltzMtoVzS1RybW592SbC/FlPzBZYht+nAM/I43PIvw
         Xz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsgqAQQLHqRLDXEzG5Tskk8VRetQTGlahVxSqWU++5E=;
        b=u3RxqkgcOwIClEZ1maH6r9TT+LgmqteqVjaVJeN996kSlldolQGA0RlHs275TTPsPx
         JC2+LYrDSWgy6uRJdDpqAKKYZrJh+gh/3CAt9TM5Ltqj3VKJklKE5MVoLbIbCp578dog
         n9siM0y/pfjGYC6JOg72Q5+f8AoF7IzrkOx/Zv3REOq2PyjYeLxcBBLpP1VKgBBpwte8
         DnrSIKvZ+ud5JCVEy5oVVM/x1HaGFfpqpR/1w4pGR6dKSCKRiEqhDNVnnu0ThC1Vj3rg
         01Nts3Ka6Q3dMPkGR7L/j2o3jNTtfc6GExx1I5PN9x/fUxBc//xeg/9RVUvLHJ/7ugBj
         XW/Q==
X-Gm-Message-State: ACrzQf3d+u4nyWsiZ7JKQP9jdS2LewdqdrKS+WHye4Y95qQ5pHkfnvfn
        SfUizoafCN/zNtKVL8OBh2Z052RNCMcLr8VVpUk=
X-Google-Smtp-Source: AMsMyM4eG5v42w066yFmuxmRJ6x07JLYYSJrANN/IklIRxzTUoIn9z79uDKMUz9vxuChI6Ye1GszPO6ulUdU93n7swU=
X-Received: by 2002:a17:906:8a73:b0:7ae:3962:47e7 with SMTP id
 hy19-20020a1709068a7300b007ae396247e7mr13285437ejc.502.1667788455170; Sun, 06
 Nov 2022 18:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20221106015152.2556188-1-memxor@gmail.com> <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com>
 <20221106214444.nbqh4qdpsoaj5t7s@apollo> <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
 <20221107014851.fofi3xxqlludjgez@apollo>
In-Reply-To: <20221107014851.fofi3xxqlludjgez@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 6 Nov 2022 18:34:03 -0800
Message-ID: <CAADnVQKyUKeEs14uzcHKym3iVtjV1DU2HkitPc+NvV8RUZW=Pg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/2] bpf: Fix deadlock for bpf_timer's spinlock
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Sun, Nov 6, 2022 at 5:48 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
>
> On Mon, Nov 07, 2022 at 06:01:44AM IST, Alexei Starovoitov wrote:
> > On Sun, Nov 6, 2022 at 1:44 PM Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> > >
> > > On Mon, Nov 07, 2022 at 02:50:08AM IST, Alexei Starovoitov wrote:
> > > > On Sat, Nov 5, 2022 at 6:52 PM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
> > > > >
> > > > > Currently, unlike other tracing program types, BPF_PROG_TYPE_TRAC=
ING is
> > > > > excluded is_tracing_prog_type checks. This means that they can us=
e maps
> > > > > containing bpf_spin_lock, bpf_timer, etc. without verification fa=
ilure.
> > > > >
> > > > > However, allowing fentry/fexit programs to use maps that have suc=
h
> > > > > bpf_timer in the map value can lead to deadlock.
> > > > >
> > > > > Suppose that an fentry program is attached to bpf_prog_put, and a=
 TC
> > > > > program executes and does bpf_map_update_elem on an array map tha=
t both
> > > > > progs share. If the fentry programs calls bpf_map_update_elem for=
 the
> > > > > same key, it will lead to acquiring of the same lock from within =
the
> > > > > critical section protecting the timer.
> > > > >
> > > > > The call chain is:
> > > > >
> > > > > bpf_prog_test_run_opts() // TC
> > > > >   bpf_prog_TC
> > > > >     bpf_map_update_elem(array_map, key=3D0)
> > > > >       bpf_obj_free_fields
> > > > >         bpf_timer_cancel_and_free
> > > > >           __bpf_spin_lock_irqsave
> > > > >             drop_prog_refcnt
> > > > >               bpf_prog_put
> > > > >                 bpf_prog_FENTRY // FENTRY
> > > > >                   bpf_map_update_elem(array_map, key=3D0)
> > > > >                     bpf_obj_free_fields
> > > > >                       bpf_timer_cancel_and_free
> > > > >                         __bpf_spin_lock_irqsave // DEADLOCK
> > > > >
> > > > > BPF_TRACE_ITER attach type can be excluded because it always exec=
utes in
> > > > > process context.
> > > > >
> > > > > Update selftests using bpf_timer in fentry to TC as they will be =
broken
> > > > > by this change.
> > > >
> > > > which is an obvious red flag and the reason why we cannot do
> > > > this change.
> > > > This specific issue could be addressed with addition of
> > > > notrace in drop_prog_refcnt, bpf_prog_put, __bpf_prog_put.
> > > > Other calls from __bpf_prog_put can stay as-is,
> > > > since they won't be called in this convoluted case.
> > > > I frankly don't get why you're spending time digging such
> > > > odd corner cases that no one can hit in real use.
> > >
> > > I was trying to figure out whether bpf_list_head_free would be safe t=
o call all
> > > the time in map updates from bpf_obj_free_fields, since it takes the =
very same
> > > spin lock that BPF program can also take to update the list.
> > >
> > > Map update ops are not allowed in the critical section, so this parti=
cular kind
> > > of recurisve map update call should not be possible. perf event is al=
ready
> > > prevented using is_tracing_prog_type, so NMI prog cannot interrupt an=
d update
> > > the same map.
> > >
> > > But then I went looking whether it was a problem elsewhere...
> > >
> > > FWIW I have updated my patch to do:
> > >
> > >   if (btf_record_has_field(map->record, BPF_LIST_HEAD)) { =E2=80=A3re=
c: map->record =E2=80=A3type: BPF_LIST_HEAD
> > >         if (is_tracing_prog_type(prog_type) || =E2=80=A3type: prog_ty=
pe
> > >             (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> > >              env->prog->expected_attach_type !=3D BPF_TRACE_ITER)) {
> > >                 verbose(env, "tracing progs cannot use bpf_list_head =
yet\n"); =E2=80=A3private_data: env =E2=80=A3fmt: "tracing progs cannot use=
 bp
> > >                 return -EINVAL;
> > >         }
> > >   }
> >
> > That is a severe limitation.
> > Why cannot you use notrace approach?
>
> Yes, notrace is indeed an option, but the problem is that everything with=
in that
> critical section needs to be notrace. bpf_list_head_free also ends up cal=
ling
> bpf_obj_free_fields again (the level of recursion however won't exceed 3,=
 since
> we clamp list_head -> list_head till 2 levels).
>
> So the notrace needs to be applied to everything within it, which is not =
a
> problem now. It can be done.

let's do it then.

> BPF_TIMER and BPF_KPTR_REF (the indirect call to
> dtor) won't be triggered, so it probably just needs to be bpf_list_head_f=
ree
> and bpf_obj_free_fields.
>
> But it can break silently in the future, if e.g. kptr is allowed. Same fo=
r
> drop_prog_refcnt if something changes. Every change to anything they call=
 (and
> called by functions they call) needs to keep the restriction in mind.

Only funcs that can realistically be called.
Not every function that is in there.

> I was wondering if in both cases of bpf_timer and bpf_list_head, we can s=
imply
> swap out the object locally while holding the lock, and then do everythin=
g
> outside the spin lock.

Maybe, but I wouldn't bother optimizing for convoluted cases.
Use notrace when you can.
Everything that bpf_mem_alloc is doing is notrace for the same reason.

>
> For bpf_timer, it would mean moving drop_prog_refcnt outside spin lock cr=
itical
> section. hrtimer_cancel is already done after the unlock. For bpf_list_he=
ad, it
> would mean swapping out the list_head and then draining it outside the lo=
ck.

That also works.
drop_prog_refcnt() can be moved after unlock.
Don't see any race.

> Then we hopefully don't need to use notrace, and it wouldn't be possible =
for any
> tracing prog to execute while we hold the bpf_spin_lock (unless I missed
> something).

yep. spin_lock, link list, obj_new won't be allowed in
is_tracing_prog_type().
Only talking about prog_type_tracing, since those are
a lot more than tracing. Everything new falls into this category.
We might even create an alias like prog_type_generic to highlight that.
