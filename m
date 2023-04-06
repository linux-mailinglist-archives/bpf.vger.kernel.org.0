Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712016D8DDA
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 05:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjDFDHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjDFDGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 23:06:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A02CA5F4;
        Wed,  5 Apr 2023 20:06:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-93434918b67so74450666b.0;
        Wed, 05 Apr 2023 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680750362; x=1683342362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsfJnbQv1fOILr7h0bAgIUFVdrp0dqf/uXk88iVozVU=;
        b=fdzPMukRN++ad+IfvQT2tCpcAwD8f5B2FIzxt8Nca6zHP51495NR1M/LHK0FLxhb+g
         Huwnq0/oI9FvODgNojwZ8BjQPCT/WC01y7koL3KECzaj2Ve5K42GMepgpy8Otfj2gyUI
         XnfeuC1aLwCrRqENeLmctTAo+Er3a4PsLGIK9qN+Blk9F37x5SsWXq6WbkexHAu8zXWX
         2FRYeAWwO9kIaaF27l3SXdrEU2DkckN87xz1+Oh27t98ChoU2tg5gfxHlQv4R/Tu9Odm
         gMu1/A5ldWTmsUXgmL6UiPGwk8xnFr5p71hmSqBfNJhzP8Bk1HSZ4RWco3yyc0GWWXUT
         d3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680750362; x=1683342362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsfJnbQv1fOILr7h0bAgIUFVdrp0dqf/uXk88iVozVU=;
        b=6EM6Oyb3xvb32Hb3Qqp6qdNmBvMQDVM8NR+MkGEh40C9OdFbAnLwxTejLMwjRE1sQ0
         YxJLoVUkVJFAMGLWU/sFHUKhVAkZ1QleDK6UIHvF/Aj7LG6z+5P582Ucg4BwYOOloRVe
         3uyWayyW86UihBwCny2p9KI+WN2u3nPwr1owtaLQkxyN0EqX/nmY46JF3FgP0Zw0QpML
         KO/zCFah4ZxI5LI9YWJob7GjS9hhAW4bBBnK2oJjs3bktlKwaYBMOP8V2BuQg1poElHw
         OlrokEdsxS2kSAKHPsm+nC8poOCmMaq9huAQ5I51NyoyGCyRe+T/Dd6yOWDbioZQXQgB
         XxwQ==
X-Gm-Message-State: AAQBX9caMnGT9NaYKENr5yR1hvPZ2uUcshuba38lv47WQCKfWcvTcnjA
        1k4Em5h3MduRM6muM/4/0CFptyLs60VnxeJDITs=
X-Google-Smtp-Source: AKy350YRdOL0DfdMv6hljZJW9N9hJV3KwR/mdf0tLHg9badvK2eMICeruWTwCNDJZ/gaD32bVehyoT939O4yWbbBINo=
X-Received: by 2002:a50:aa93:0:b0:4fb:2593:846 with SMTP id
 q19-20020a50aa93000000b004fb25930846mr2271247edc.3.1680750361452; Wed, 05 Apr
 2023 20:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com> <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
In-Reply-To: <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Apr 2023 20:05:50 -0700
Message-ID: <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> It seems that I didn't describe the issue clearly.
> The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
> required to run bpftool,  so the bpftool running in the container
> can't get the ID of bpf objects or convert IDs to FDs.
> Is there something that I missed ?

Nothing. This is by design. bpftool needs sudo. That's all.


>
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3705,9 +3705,6 @@ static int bpf_obj_get_next_id(const union bpf_=
attr *attr,
> > >         if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >=3D INT_MAX)
> > >                 return -EINVAL;
> > >
> > > -       if (!capable(CAP_SYS_ADMIN))
> > > -               return -EPERM;
> > > -
> > >         next_id++;
> > >         spin_lock_bh(lock);
> > >         if (!idr_get_next(idr, &next_id))
> > >
> > > Because the container doesn't have CAP_SYS_ADMIN enabled, while they
> > > only have CAP_BPF and other required CAPs.
> > >
> > > Another possible solution is that we run an agent in the host, and th=
e
> > > user in the container who wants to get the bpf objects info in his
> > > container should send a request to this agent via unix domain socket.
> > > That is what we are doing now in our production environment.  That
> > > said, each container has to run a client to get the bpf object fd.
> >
> > None of such hacks are necessary. People that debug bpf setups with bpf=
tool
> > can always sudo.
> >
> > > There are some downsides,
> > > -  It can't handle pinned bpf programs
> > >    For pinned programs, the user can get them from the pinned files
> > > directly, so he can use bpftool in his case, only with some
> > > complaints.
> > > -  If the user attached the bpf prog, and then removed the pinned
> > > file, but didn't detach it.
> > >    That happened. But this error case can't be handled.
> > > - There may be other corner cases that it can't fit.
> > >
> > > There's a solution to improve it, but we also need to change the
> > > kernel. That is, we can use the wasted space btf->name.
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index b7e5a55..59d73a3 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -5542,6 +5542,8 @@ static struct btf *btf_parse(bpfptr_t btf_data,
> > > u32 btf_data_size,
> > >                 err =3D -ENOMEM;
> > >                 goto errout;
> > >         }
> > > +       snprintf(btf->name, sizeof(btf->name), "%s-%d-%d", current->c=
omm,
> > > +                        current->pid, cgroup_id(task_cgroup(p, cpu_c=
grp_id)));
> >
> > Unnecessary.
> > comm, pid, cgroup can be printed by bpftool without changing the kernel=
.
>
> Some questions,
> - What if the process exits after attaching the bpf prog and the prog
> is not auto-detachable?
>   For example, the reuserport bpf prog is not auto-detachable. After
> pins the reuserport bpf prog, a task can attach it through the pinned
> bpf file, but if the task forgets to detach it and the pinned file is
> removed, then it seems there's no way to figure out which task or
> cgroup this prog belongs to...

you're saying that there is a bpf prog in the kernel without
corresponding user space ? Meaning no user space process has an FD
that points to this prog or FD to a map that this prog is using?
In such a case this is truly kernel bpf prog. It doesn't belong to cgroup.

> - Could you pls. explain in detail how to get comm, pid, or cgroup
> from a pinned bpffs file?

pinned bpf prog and no user space holds FD to it?
It's not part of any cgroup. Nothing to print.
