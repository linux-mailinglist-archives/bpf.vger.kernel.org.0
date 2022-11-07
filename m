Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1D61E7E7
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 01:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKGAcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 19:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGAb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 19:31:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC42BAC
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 16:31:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d26so26159348eje.10
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4OV0oF8IQTbgm1ekupvD2HjyY0/9tvxs7wdhN/QNMY=;
        b=fEqVXi1qFwYuURC6DB91i9cP0DPNJKEzhGEkKmi2SBNmiq5nEBxeg08ELW3/oGqvBU
         X4eiJOcV3uEtwNeCz7C9M/pylmoum6Vbg1uEemQJ5+EiYc4eEVm7/JO0x+n5K90eLpEL
         MzPdr4KGbiBwJ4y6SkkQsvTaZvRkbF7pOh8vIdBEm6oIP/dv5yDfC4y6Bl1Si/6lFT5R
         zn59UBLIhgwW3fUsvOwsBKn6TsPFXfQ1CuS7xpSg00R/kuPu7i6MQwpSR+28poOf7GY4
         TYRYbobAUmaGKWNWVfeBfdDKLy9CZHFDAQxlxyXKPsHAyk3vpcu2g0uMudPiULPsEJVT
         5Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4OV0oF8IQTbgm1ekupvD2HjyY0/9tvxs7wdhN/QNMY=;
        b=02/8c+afsHBIMvskASR14tFsSMTAsTwy6GONp6iZ30iVq9wO075dTSJi/3mb8cbEZo
         bchhfnobXveFWdn4A2Z2/OJh7QKryZRcVRNzJhFMLHWk2rJSN58CCR5RxEZnfAhFKVFt
         IVvxC8A/nsEauedVbKr1M533Srd4/i3Pa/tZwVANV6P5rFdW6Jcw9zq1XzMFuEphZ6aQ
         pZOs6/DB8SR93dRj+xNlrU//q8eLqH286cZGJ4R0OJ9/12mf47kXYSOkD2cTH/qCZSSQ
         my7n+gu7Dii9wLU/eVzkL37TtxMDdcl8oSzgwh1w+kYr5smRqpCyIJfRLE0dx3si7kTC
         6NNA==
X-Gm-Message-State: ACrzQf2ijgYjgYihVSLSiQuOktknoG2tcnRhlzTu3L8qGznkTRm9mhG5
        cx2INYdGbPyN7VO5DX9H5n8uHlD3DQayYAtoOFNiHd9q
X-Google-Smtp-Source: AMsMyM7FbKJx0xdGX4AtJsdHDbeolwsXd+o8J0bTbvczO5AyOGLxklyiqJPOjcZQvgV0wv7LmvmLqTNTIrczkXBsbsk=
X-Received: by 2002:a17:906:1f48:b0:7ae:77d:bac with SMTP id
 d8-20020a1709061f4800b007ae077d0bacmr24664331ejk.708.1667781115868; Sun, 06
 Nov 2022 16:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20221106015152.2556188-1-memxor@gmail.com> <20221106015152.2556188-2-memxor@gmail.com>
 <CAADnVQ+iuB6abH0=N0su6DGAW1FnOtgUQ+Zq6x9bH1w5X_6P=w@mail.gmail.com> <20221106214444.nbqh4qdpsoaj5t7s@apollo>
In-Reply-To: <20221106214444.nbqh4qdpsoaj5t7s@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 6 Nov 2022 16:31:44 -0800
Message-ID: <CAADnVQLiPdCZSiGsy7rUWttpM+iuXp+2BJoaHqR_ajc4K-xuWw@mail.gmail.com>
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

On Sun, Nov 6, 2022 at 1:44 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
>
> On Mon, Nov 07, 2022 at 02:50:08AM IST, Alexei Starovoitov wrote:
> > On Sat, Nov 5, 2022 at 6:52 PM Kumar Kartikeya Dwivedi <memxor@gmail.co=
m> wrote:
> > >
> > > Currently, unlike other tracing program types, BPF_PROG_TYPE_TRACING =
is
> > > excluded is_tracing_prog_type checks. This means that they can use ma=
ps
> > > containing bpf_spin_lock, bpf_timer, etc. without verification failur=
e.
> > >
> > > However, allowing fentry/fexit programs to use maps that have such
> > > bpf_timer in the map value can lead to deadlock.
> > >
> > > Suppose that an fentry program is attached to bpf_prog_put, and a TC
> > > program executes and does bpf_map_update_elem on an array map that bo=
th
> > > progs share. If the fentry programs calls bpf_map_update_elem for the
> > > same key, it will lead to acquiring of the same lock from within the
> > > critical section protecting the timer.
> > >
> > > The call chain is:
> > >
> > > bpf_prog_test_run_opts() // TC
> > >   bpf_prog_TC
> > >     bpf_map_update_elem(array_map, key=3D0)
> > >       bpf_obj_free_fields
> > >         bpf_timer_cancel_and_free
> > >           __bpf_spin_lock_irqsave
> > >             drop_prog_refcnt
> > >               bpf_prog_put
> > >                 bpf_prog_FENTRY // FENTRY
> > >                   bpf_map_update_elem(array_map, key=3D0)
> > >                     bpf_obj_free_fields
> > >                       bpf_timer_cancel_and_free
> > >                         __bpf_spin_lock_irqsave // DEADLOCK
> > >
> > > BPF_TRACE_ITER attach type can be excluded because it always executes=
 in
> > > process context.
> > >
> > > Update selftests using bpf_timer in fentry to TC as they will be brok=
en
> > > by this change.
> >
> > which is an obvious red flag and the reason why we cannot do
> > this change.
> > This specific issue could be addressed with addition of
> > notrace in drop_prog_refcnt, bpf_prog_put, __bpf_prog_put.
> > Other calls from __bpf_prog_put can stay as-is,
> > since they won't be called in this convoluted case.
> > I frankly don't get why you're spending time digging such
> > odd corner cases that no one can hit in real use.
>
> I was trying to figure out whether bpf_list_head_free would be safe to ca=
ll all
> the time in map updates from bpf_obj_free_fields, since it takes the very=
 same
> spin lock that BPF program can also take to update the list.
>
> Map update ops are not allowed in the critical section, so this particula=
r kind
> of recurisve map update call should not be possible. perf event is alread=
y
> prevented using is_tracing_prog_type, so NMI prog cannot interrupt and up=
date
> the same map.
>
> But then I went looking whether it was a problem elsewhere...
>
> FWIW I have updated my patch to do:
>
>   if (btf_record_has_field(map->record, BPF_LIST_HEAD)) { =E2=80=A3rec: m=
ap->record =E2=80=A3type: BPF_LIST_HEAD
>         if (is_tracing_prog_type(prog_type) || =E2=80=A3type: prog_type
>             (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>              env->prog->expected_attach_type !=3D BPF_TRACE_ITER)) {
>                 verbose(env, "tracing progs cannot use bpf_list_head yet\=
n"); =E2=80=A3private_data: env =E2=80=A3fmt: "tracing progs cannot use bp
>                 return -EINVAL;
>         }
>   }

That is a severe limitation.
Why cannot you use notrace approach?
