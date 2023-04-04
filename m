Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA396D56FA
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDDDAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 23:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjDDDAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 23:00:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C41A133;
        Mon,  3 Apr 2023 20:00:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ga7so30357126qtb.2;
        Mon, 03 Apr 2023 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680577231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qQ30VT4jlUqcCXZPdUXLknWBND/jvUaW+XZhTkIr8o=;
        b=BLxUcK8+RJYK9sdCkrG7v5Yd/ZO0hy42uVnGlwK52TlBVQvfy2HPRq99cpDM28e6nl
         LirfX0xlLCwFizCjz4clUYgSNAJSnFMkjSEtPaezXNK3Sqr6mTXQ8Pqf2xRo7AQ92yLs
         7Bem/X0tp3JXRwVWvLyyypHBiQzAgp7paL8EhP/etlyMH1cpdQ2K4EzxbXCF1qGZQs/U
         SsbCosXjWRjUm01mZeXZNC4ofnQ4Ctughgv6wCWfmuxQiKSFfHYzINNqBWkWVLb0mrOn
         eGymSGJwtT5dsegeqeIOMaYn07weASMaNdWKHTnT9kjyBFB7642HPGwEJcJR/j+7uZFn
         OiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680577231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qQ30VT4jlUqcCXZPdUXLknWBND/jvUaW+XZhTkIr8o=;
        b=mqxrys+/XfLPjVyS695AB0bw3TuYZFZuvJ2v46g4C9cY6gUSh4c23SJfgFqlC2YF0c
         P3193wIwJqapoENXiL9Y/vchgB3nhCfCAPYqZ8h8RnUCdTyxzgzYyzotmjxd2EyJWJA2
         2WDHBRXYJhCs+wAfHkERHfv8DgWk6oJg/ZhtYgZdN2apuRK4vaFPnS28DDuiPmlCoD45
         XvhShZILyv3TBdosSBjufwfziF8e7qGUsTXMQsizWD5ZJJy670jRjjK8XmnslF+lrkuu
         22nhjHANuqB5vvLj1MUOS7vqh6JaGzCFn7wOPoni2GAUH9gLx3jOVwzsZ9kAwBa+aflv
         Mhcw==
X-Gm-Message-State: AAQBX9dHsG9XzgWETgdndDSqekXzoPh+aCTMe8NoP8zB1QK30FMW2vlw
        PSiv/TF3jGhfWlRN/BqrxYLqjGCDltS9L3ncItgGNoIhNQ7trg==
X-Google-Smtp-Source: AKy350arzTDBkKJnhwKqR4qd3g+sLridvAgOLOiyht6KFe9V/1R8iWzQjzk1R67/MeBdOaXkMFdlyvY3U4DlUK4sQN0=
X-Received: by 2002:a05:622a:1803:b0:3df:4392:1aff with SMTP id
 t3-20020a05622a180300b003df43921affmr287447qtc.6.1680577231294; Mon, 03 Apr
 2023 20:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com> <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 4 Apr 2023 10:59:55 +0800
Message-ID: <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Apr 4, 2023 at 6:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 03, 2023 at 11:05:25AM +0800, Yafang Shao wrote:
> > On Mon, Apr 3, 2023 at 7:37=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> > > > On Tue, Mar 28, 2023 at 3:04=E2=80=AFAM Song Liu <song@kernel.org> =
wrote:
> > > > >
> > > > > On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and con=
vert IDs
> > > > > > to FDs, that's intended for BPF's security model[1]. Not only d=
oes it
> > > > > > prevent non-privilidged users from getting other users' bpf pro=
gram, but
> > > > > > also it prevents the user from iterating his own bpf objects.
> > > > > >
> > > > > > In container environment, some users want to run bpf programs i=
n their
> > > > > > containers. These users can run their bpf programs under CAP_BP=
F and
> > > > > > some other specific CAPs, but they can't inspect their bpf prog=
rams in a
> > > > > > generic way. For example, the bpftool can't be used as it requi=
res
> > > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > > >
> > > > > Agreed that it is important to enable tools like bpftool without
> > > > > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > > > > namespace for this. Can we reuse some existing namespace for this=
?
> > > > >
> > > >
> > > > It seems we can't.
> > >
> > > Yafang,
> > >
> > > It's a Nack.
> > >
> > > The only thing you've been trying to "solve" with bpf namespace is to
> > > allow 'bpftool prog show' iterate progs in the "namespace" without CA=
P_SYS_ADMIN.
> > > The concept of bpf namespace is not even close to be thought through.
> >
> > Right, it is more likely a PoC in its current state.
> >
> > > Others pointed out the gaps in the design. Like bpffs. There are plen=
ty.
> > > Please do not send patches like this in the future.
> >
> > The reason I sent it with an early state is that I want to get some
> > early feedback from the community ahead of the LSF/MM/BPF workshop,
> > then I can improve it based on these feedbacks and present it more
> > specifically at the workshop. Then the discussion will be more
> > effective.
> >
> > > You need to start with describing the problem you want to solve,
> > > then propose _several_ solutions, describe their pros and cons,
> > > solicit feedback, present at the conferences (like LSFMMBPF or LPC),
> > > and when the community agrees that 1. problem is worth solving,
> > > 2. the solution makes sense, only then work on patches.
> > >
> >
> > I would like to give a short discussion on the BPF namespace if
> > everything goes fine.
>
> Not in this shape of BPF namespace as done in this patch set.
> We've talked about BPF namespace in the past. This is not it.
>
> > > "In container environment, some users want to run bpf programs in the=
ir containers."
> > > is something Song brought up at LSFMMBPF a year ago.
> > > At that meeting most of the folks agreed that there is a need to run =
bpf
> > > in containers and make sure that the effect of bpf prog is limited to=
 a container.
> > > This new namespace that creates virtual IDs for progs and maps doesn'=
t come
> > > close in solving this task.
> >
> > Currently in our production environment, all the containers running
> > bpf programs are privileged, that is risky. So actually the goal of
> > the BPF namespace is to make them (or part of them) non-privileged.
> > But some of the abilities of these bpf programs will be lost in this
> > procedure, like the debug-bility with bpftool, so we need to fix it.
> > Agree with you that this goal is far from making bpf programs safely
> > running in a container environment.
>
> I disagree that allowing admin to run bpftool without sudo is a task
> worth solving. The visibility of bpf progs in a container is a different =
task.
> Without doing any kernel changes we can add a flag to bpftool to let
> 'bpftool prog show' list progs that were loaded by processes in the same =
cgroup.
> bpftool already does prog->pid mapping with bpf iterators.
> It can filter by cgroup just as well.

IIUC, at least we need bellow change in the kernel,

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3705,9 +3705,6 @@ static int bpf_obj_get_next_id(const union bpf_attr *=
attr,
        if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >=3D INT_MAX)
                return -EINVAL;

-       if (!capable(CAP_SYS_ADMIN))
-               return -EPERM;
-
        next_id++;
        spin_lock_bh(lock);
        if (!idr_get_next(idr, &next_id))

Because the container doesn't have CAP_SYS_ADMIN enabled, while they
only have CAP_BPF and other required CAPs.

Another possible solution is that we run an agent in the host, and the
user in the container who wants to get the bpf objects info in his
container should send a request to this agent via unix domain socket.
That is what we are doing now in our production environment.  That
said, each container has to run a client to get the bpf object fd.
There are some downsides,
-  It can't handle pinned bpf programs
   For pinned programs, the user can get them from the pinned files
directly, so he can use bpftool in his case, only with some
complaints.
-  If the user attached the bpf prog, and then removed the pinned
file, but didn't detach it.
   That happened. But this error case can't be handled.
- There may be other corner cases that it can't fit.

There's a solution to improve it, but we also need to change the
kernel. That is, we can use the wasted space btf->name.

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b7e5a55..59d73a3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5542,6 +5542,8 @@ static struct btf *btf_parse(bpfptr_t btf_data,
u32 btf_data_size,
                err =3D -ENOMEM;
                goto errout;
        }
+       snprintf(btf->name, sizeof(btf->name), "%s-%d-%d", current->comm,
+                        current->pid, cgroup_id(task_cgroup(p, cpu_cgrp_id=
)));
        env->btf =3D btf;

        data =3D kvmalloc(btf_data_size, GFP_KERNEL | __GFP_NOWARN);


--=20
Regards
Yafang
