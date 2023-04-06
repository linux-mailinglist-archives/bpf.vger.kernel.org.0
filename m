Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AA6D8DC2
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 04:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDFCzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjDFCzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 22:55:23 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233259752;
        Wed,  5 Apr 2023 19:55:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id u15so12568721qkk.4;
        Wed, 05 Apr 2023 19:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680749720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg3yuOT4rHjhDE99YFeq/2Gf/WpFBpxMdlJ+a9yTK0A=;
        b=PDx2rbRkI6lrRByfDjKrc1fpT2v2xRGHJrWRY/tzNQxQIa/Fvw+yTktmS9osFT1c1i
         YGUwtm5Qdfipdgqy8nq/YbmTKol+LNeJRiBVFzPhOHhdwewjvwjTxzEjsx8I+OCUe2X6
         iuPZBYuNjiqcVE/cdDa4poksblEwRhPnEuGWg43gwhKPOIbQL6ULH7JIMomguAv0A7gA
         NTTuOttgvCq9LQcR5x1oOJsAySFOD2XK8ouvtcKgKy6uOeM0/Rs4WMGMVNxEGFw9YtBJ
         PnWKVFVW0ktb6BnydZqljOZFJwVZPcl+SU86O5oXsyAkTqaesaQwgpeSdLm0uJABLYAt
         9IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jg3yuOT4rHjhDE99YFeq/2Gf/WpFBpxMdlJ+a9yTK0A=;
        b=S4PCfMdz6m9wd5zAtxjUMWKe4GbR4sqwLmK5V9CfPMrhFGfpixAWhiUv43j6GMI7AL
         aafp/dOwr5qwluVSk7bPwte2hH4uD7FcXhTsTolfWWwfu6sGBp3/owIcH+5VEqFFO7jc
         WpNOBfzeajbN+y+MaKJVHrPZKy9h93AZL0xhNLxrvHdWogbeB1HSjHkUO53Kg14fgKDg
         MQWNQoCQCltDcTh74Z3zl0uRYIFrS5Wc1k5kEpvZrEmuDXrf5DvFdofF0hZzV+ar5DLM
         sIfNqoT7qfax28vWny7pgr8jbWI69Ub1bF+rjhnIOE10rJ8yLXtzkkyACPcNpRWVLXKl
         yYsw==
X-Gm-Message-State: AAQBX9e08Ss0BnR3dfkz+ZS7Iae5AIIB4mukvXD59m2+LOEyIDxpDBk9
        T6uzYxnx8gp9tq8VkV7reDJWZ7U1ai0PpFeTrbk=
X-Google-Smtp-Source: AKy350Z/vMYvDIrAE/h1CkRcCE3T4e0MRbdFmmafbYXNWN0CUc1+uc2hVpiUwwoQbvrIwpXQkWZTIf/VSDTHWDXLGRU=
X-Received: by 2002:a05:620a:410e:b0:743:9b78:d97e with SMTP id
 j14-20020a05620a410e00b007439b78d97emr2069273qko.14.1680749720131; Wed, 05
 Apr 2023 19:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com> <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 6 Apr 2023 10:54:44 +0800
Message-ID: <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
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

On Thu, Apr 6, 2023 at 10:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 04, 2023 at 10:59:55AM +0800, Yafang Shao wrote:
> > On Tue, Apr 4, 2023 at 6:50=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 03, 2023 at 11:05:25AM +0800, Yafang Shao wrote:
> > > > On Mon, Apr 3, 2023 at 7:37=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> > > > > > On Tue, Mar 28, 2023 at 3:04=E2=80=AFAM Song Liu <song@kernel.o=
rg> wrote:
> > > > > > >
> > > > > > > On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.sh=
ao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and=
 convert IDs
> > > > > > > > to FDs, that's intended for BPF's security model[1]. Not on=
ly does it
> > > > > > > > prevent non-privilidged users from getting other users' bpf=
 program, but
> > > > > > > > also it prevents the user from iterating his own bpf object=
s.
> > > > > > > >
> > > > > > > > In container environment, some users want to run bpf progra=
ms in their
> > > > > > > > containers. These users can run their bpf programs under CA=
P_BPF and
> > > > > > > > some other specific CAPs, but they can't inspect their bpf =
programs in a
> > > > > > > > generic way. For example, the bpftool can't be used as it r=
equires
> > > > > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > > > > >
> > > > > > > Agreed that it is important to enable tools like bpftool with=
out
> > > > > > > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > > > > > > namespace for this. Can we reuse some existing namespace for =
this?
> > > > > > >
> > > > > >
> > > > > > It seems we can't.
> > > > >
> > > > > Yafang,
> > > > >
> > > > > It's a Nack.
> > > > >
> > > > > The only thing you've been trying to "solve" with bpf namespace i=
s to
> > > > > allow 'bpftool prog show' iterate progs in the "namespace" withou=
t CAP_SYS_ADMIN.
> > > > > The concept of bpf namespace is not even close to be thought thro=
ugh.
> > > >
> > > > Right, it is more likely a PoC in its current state.
> > > >
> > > > > Others pointed out the gaps in the design. Like bpffs. There are =
plenty.
> > > > > Please do not send patches like this in the future.
> > > >
> > > > The reason I sent it with an early state is that I want to get some
> > > > early feedback from the community ahead of the LSF/MM/BPF workshop,
> > > > then I can improve it based on these feedbacks and present it more
> > > > specifically at the workshop. Then the discussion will be more
> > > > effective.
> > > >
> > > > > You need to start with describing the problem you want to solve,
> > > > > then propose _several_ solutions, describe their pros and cons,
> > > > > solicit feedback, present at the conferences (like LSFMMBPF or LP=
C),
> > > > > and when the community agrees that 1. problem is worth solving,
> > > > > 2. the solution makes sense, only then work on patches.
> > > > >
> > > >
> > > > I would like to give a short discussion on the BPF namespace if
> > > > everything goes fine.
> > >
> > > Not in this shape of BPF namespace as done in this patch set.
> > > We've talked about BPF namespace in the past. This is not it.
> > >
> > > > > "In container environment, some users want to run bpf programs in=
 their containers."
> > > > > is something Song brought up at LSFMMBPF a year ago.
> > > > > At that meeting most of the folks agreed that there is a need to =
run bpf
> > > > > in containers and make sure that the effect of bpf prog is limite=
d to a container.
> > > > > This new namespace that creates virtual IDs for progs and maps do=
esn't come
> > > > > close in solving this task.
> > > >
> > > > Currently in our production environment, all the containers running
> > > > bpf programs are privileged, that is risky. So actually the goal of
> > > > the BPF namespace is to make them (or part of them) non-privileged.
> > > > But some of the abilities of these bpf programs will be lost in thi=
s
> > > > procedure, like the debug-bility with bpftool, so we need to fix it=
.
> > > > Agree with you that this goal is far from making bpf programs safel=
y
> > > > running in a container environment.
> > >
> > > I disagree that allowing admin to run bpftool without sudo is a task
> > > worth solving. The visibility of bpf progs in a container is a differ=
ent task.
> > > Without doing any kernel changes we can add a flag to bpftool to let
> > > 'bpftool prog show' list progs that were loaded by processes in the s=
ame cgroup.
> > > bpftool already does prog->pid mapping with bpf iterators.
> > > It can filter by cgroup just as well.
> >
> > IIUC, at least we need bellow change in the kernel,
>
> No. The user should just 'sudo bpftool ...' instead.
>

It seems that I didn't describe the issue clearly.
The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
required to run bpftool,  so the bpftool running in the container
can't get the ID of bpf objects or convert IDs to FDs.
Is there something that I missed ?

> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3705,9 +3705,6 @@ static int bpf_obj_get_next_id(const union bpf_at=
tr *attr,
> >         if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >=3D INT_MAX)
> >                 return -EINVAL;
> >
> > -       if (!capable(CAP_SYS_ADMIN))
> > -               return -EPERM;
> > -
> >         next_id++;
> >         spin_lock_bh(lock);
> >         if (!idr_get_next(idr, &next_id))
> >
> > Because the container doesn't have CAP_SYS_ADMIN enabled, while they
> > only have CAP_BPF and other required CAPs.
> >
> > Another possible solution is that we run an agent in the host, and the
> > user in the container who wants to get the bpf objects info in his
> > container should send a request to this agent via unix domain socket.
> > That is what we are doing now in our production environment.  That
> > said, each container has to run a client to get the bpf object fd.
>
> None of such hacks are necessary. People that debug bpf setups with bpfto=
ol
> can always sudo.
>
> > There are some downsides,
> > -  It can't handle pinned bpf programs
> >    For pinned programs, the user can get them from the pinned files
> > directly, so he can use bpftool in his case, only with some
> > complaints.
> > -  If the user attached the bpf prog, and then removed the pinned
> > file, but didn't detach it.
> >    That happened. But this error case can't be handled.
> > - There may be other corner cases that it can't fit.
> >
> > There's a solution to improve it, but we also need to change the
> > kernel. That is, we can use the wasted space btf->name.
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index b7e5a55..59d73a3 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5542,6 +5542,8 @@ static struct btf *btf_parse(bpfptr_t btf_data,
> > u32 btf_data_size,
> >                 err =3D -ENOMEM;
> >                 goto errout;
> >         }
> > +       snprintf(btf->name, sizeof(btf->name), "%s-%d-%d", current->com=
m,
> > +                        current->pid, cgroup_id(task_cgroup(p, cpu_cgr=
p_id)));
>
> Unnecessary.
> comm, pid, cgroup can be printed by bpftool without changing the kernel.

Some questions,
- What if the process exits after attaching the bpf prog and the prog
is not auto-detachable?
  For example, the reuserport bpf prog is not auto-detachable. After
pins the reuserport bpf prog, a task can attach it through the pinned
bpf file, but if the task forgets to detach it and the pinned file is
removed, then it seems there's no way to figure out which task or
cgroup this prog belongs to...
- Could you pls. explain in detail how to get comm, pid, or cgroup
from a pinned bpffs file?

--=20
Regards
Yafang
